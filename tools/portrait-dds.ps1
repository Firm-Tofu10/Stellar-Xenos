# Stellar Xeno — Phase 4: Canonical PNG → DDS
# Converts a validated Phase 3.1 source PNG into a 256x256 uncompressed
# 32-bit RGBA DDS matching the known-good working dog portraits.
#
# Does NOT: ask for dog names, register portraits, modify defs/sets/categories,
# or touch vanilla Stellaris.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Source
)

$ErrorActionPreference = "Stop"
. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-exit.ps1")
. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-paths.ps1")
Add-Type -AssemblyName System.Drawing

$CanonicalSourcePattern = '^dog(\d+)_(.+)_([a-z]{3})_stellaris\.png$'
$LegacyCanonicalSourcePattern = '^dog(\d+)_(.+)_stellaris\.png$'
$DdsSize = 256

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

function Get-RepoRoot {
    $scriptDir = Split-Path -Parent $PSCommandPath
    return (Resolve-Path (Join-Path $scriptDir "..")).Path
}

function Resolve-SourcePath {
    param(
        [string]$RepoRoot,
        [string]$SourceArg
    )

    if ([IO.Path]::IsPathRooted($SourceArg) -and (Test-Path -LiteralPath $SourceArg)) {
        return (Resolve-Path -LiteralPath $SourceArg).Path
    }

    $candidates = @(
        (Join-Path $RepoRoot $SourceArg),
        (Join-Path $RepoRoot "assets\source\$SourceArg"),
        (Join-Path (Join-Path $RepoRoot "assets\source") ([IO.Path]::GetFileName($SourceArg)))
    )

    foreach ($c in $candidates) {
        if (Test-Path -LiteralPath $c) {
            return (Resolve-Path -LiteralPath $c).Path
        }
    }

    throw ("Source PNG not found: {0}" -f $SourceArg)
}

function Get-DdsOutputDir {
    param([string]$RepoRoot)
    return (Get-SdModPaths -RepoRoot $RepoRoot -Which Production).DdsDir
}

function Get-CanonicalSourceInfo {
    param([string]$FileName)

    $lower = $FileName.ToLowerInvariant()
    $m = [regex]::Match($lower, $CanonicalSourcePattern)
    if ($m.Success) {
        return [PSCustomObject]@{
            Number   = [int]$m.Groups[1].Value
            Name     = $m.Groups[2].Value.ToLowerInvariant()
            XenoAbbr = $m.Groups[3].Value.ToLowerInvariant()
        }
    }

    $legacy = [regex]::Match($lower, $LegacyCanonicalSourcePattern)
    if ($legacy.Success) {
        return [PSCustomObject]@{
            Number   = [int]$legacy.Groups[1].Value
            Name     = $legacy.Groups[2].Value.ToLowerInvariant()
            XenoAbbr = $null
        }
    }

    return $null
}

function Get-DdsFileName {
    param([string]$Slug)
    # Established named-dog pattern: sd_dog_piglet.dds, sd_dog_angus.dds
    # (Oakley sd_dog_02.dds is historical; new dogs use the name slug.)
    return ("sd_dog_{0}.dds" -f $Slug)
}

# ---------------------------------------------------------------------------
# Binary helpers (avoid PowerShell signed-int issues with 0xFF000000)
# ---------------------------------------------------------------------------

function Write-Bytes32 {
    param(
        [byte[]]$Buffer,
        [int]$Offset,
        [uint64]$Value
    )
    # Little-endian u32 via unsigned shifts only
    $Buffer[$Offset]     = [byte]($Value -band 0xFF)
    $Buffer[$Offset + 1] = [byte](($Value -shr 8) -band 0xFF)
    $Buffer[$Offset + 2] = [byte](($Value -shr 16) -band 0xFF)
    $Buffer[$Offset + 3] = [byte](($Value -shr 24) -band 0xFF)
}

function Get-DdsHeaderInfo {
    param([byte[]]$Bytes)

    return [PSCustomObject]@{
        Magic   = [Text.Encoding]::ASCII.GetString($Bytes, 0, 4)
        Size    = [BitConverter]::ToUInt32($Bytes, 4)
        Flags   = [BitConverter]::ToUInt32($Bytes, 8)
        Height  = [BitConverter]::ToUInt32($Bytes, 12)
        Width   = [BitConverter]::ToUInt32($Bytes, 16)
        Pitch   = [BitConverter]::ToUInt32($Bytes, 20)
        Mips    = [BitConverter]::ToUInt32($Bytes, 28)
        PfSize  = [BitConverter]::ToUInt32($Bytes, 76)
        PfFlags = [BitConverter]::ToUInt32($Bytes, 80)
        FourCC  = [Text.Encoding]::ASCII.GetString($Bytes, 84, 4).Trim([char]0)
        Bpp     = [BitConverter]::ToUInt32($Bytes, 88)
        MaskR   = [BitConverter]::ToUInt32($Bytes, 92)
        MaskG   = [BitConverter]::ToUInt32($Bytes, 96)
        MaskB   = [BitConverter]::ToUInt32($Bytes, 100)
        MaskA   = [BitConverter]::ToUInt32($Bytes, 104)
        Caps    = [BitConverter]::ToUInt32($Bytes, 108)
        Length  = $Bytes.Length
    }
}

function Test-KnownGoodDdsHeader {
    param([object]$Header)

    $issues = New-Object System.Collections.Generic.List[string]
    if ($Header.Magic -ne "DDS ") { [void]$issues.Add("magic") }
    if ($Header.Size -ne 124) { [void]$issues.Add("header size") }
    if ($Header.Flags -ne 0x100F) { [void]$issues.Add("header flags") }
    if ($Header.Width -ne 256 -or $Header.Height -ne 256) { [void]$issues.Add("dimensions") }
    if ($Header.Pitch -ne 1024) { [void]$issues.Add("pitch") }
    if ($Header.Mips -ne 0) { [void]$issues.Add("mipmaps") }
    if ($Header.PfSize -ne 32) { [void]$issues.Add("pfSize") }
    if ($Header.PfFlags -ne 0x41) { [void]$issues.Add("pfFlags") }
    if ($Header.FourCC -ne "") { [void]$issues.Add("fourCC/compression") }
    if ($Header.Bpp -ne 32) { [void]$issues.Add("bit depth") }
    if ($Header.Caps -ne 0x1000) { [void]$issues.Add("caps") }
    if ($Header.Length -ne 262272) { [void]$issues.Add("file size") }
    # R/G/B/A channel masks are verified by byte-for-byte header match vs Piglet reference
    return @($issues)
}

# ---------------------------------------------------------------------------
# Source validation
# ---------------------------------------------------------------------------

function Test-SourcePngForDds {
    param([string]$Path)

    $name = [IO.Path]::GetFileName($Path)
    if ($name.ToLowerInvariant() -notmatch '\.png$') {
        throw "Source must be a PNG file."
    }

    $canon = Get-CanonicalSourceInfo -FileName $name
    if ($null -eq $canon) {
        throw ("Source filename must match dog##_<name>_stellaris.png (got '{0}')." -f $name)
    }

    $bmp = [System.Drawing.Bitmap]::FromFile($Path)
    try {
        if ($bmp.Width -ne $bmp.Height) {
            throw ("Source must be square (got {0}x{1})." -f $bmp.Width, $bmp.Height)
        }
        $fmt = $bmp.PixelFormat.ToString()
        if ($fmt -notmatch 'Argb|PArgb') {
            throw ("Source must be RGBA/ARGB (got {0})." -f $fmt)
        }

        $fmt32 = [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
        $rect = New-Object System.Drawing.Rectangle 0, 0, $bmp.Width, $bmp.Height
        $data = $bmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, $fmt32)
        try {
            $stride = [Math]::Abs($data.Stride)
            $raw = New-Object byte[] ($stride * $bmp.Height)
            [Runtime.InteropServices.Marshal]::Copy($data.Scan0, $raw, 0, $raw.Length)
        } finally {
            $bmp.UnlockBits($data)
        }

        $a0 = 0
        $aOpaque = 0
        for ($y = 0; $y -lt $bmp.Height; $y += 4) {
            for ($x = 0; $x -lt $bmp.Width; $x += 4) {
                $a = $raw[($y * $stride) + ($x * 4) + 3]
                if ($a -eq 0) { $a0++ }
                elseif ($a -ge 250) { $aOpaque++ }
            }
        }

        if ($a0 -lt 50) {
            throw "Source does not appear to have genuine alpha transparency."
        }

        $corner = $bmp.GetPixel(0, 0)
        return [PSCustomObject]@{
            Path         = $Path
            Width        = $bmp.Width
            Height       = $bmp.Height
            PixelFormat  = $fmt
            DogNumber    = $canon.Number
            DogName      = $canon.Name
            CornerAlpha  = $corner.A
            SampleA0     = $a0
            SampleOpaque = $aOpaque
        }
    } finally {
        $bmp.Dispose()
    }
}

# ---------------------------------------------------------------------------
# Conversion
# ---------------------------------------------------------------------------

function ConvertTo-PortraitDdsPixels {
    param(
        [string]$SourcePath,
        [int]$Size
    )

    $src = [System.Drawing.Bitmap]::FromFile($SourcePath)
    $canvas = $null
    $g = $null
    try {
        $canvas = New-Object System.Drawing.Bitmap $Size, $Size, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $g = [System.Drawing.Graphics]::FromImage($canvas)
        $g.Clear([System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.DrawImage($src, 0, 0, $Size, $Size)

        $rect = New-Object System.Drawing.Rectangle 0, 0, $Size, $Size
        $data = $canvas.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        try {
            $stride = [Math]::Abs($data.Stride)
            $raw = New-Object byte[] ($stride * $Size)
            [Runtime.InteropServices.Marshal]::Copy($data.Scan0, $raw, 0, $raw.Length)
        } finally {
            $canvas.UnlockBits($data)
        }

        $pixels = New-Object byte[] ($Size * $Size * 4)
        for ($y = 0; $y -lt $Size; $y++) {
            [Array]::Copy($raw, $y * $stride, $pixels, $y * $Size * 4, $Size * 4)
        }

        $a0 = 0
        for ($i = 3; $i -lt $pixels.Length; $i += 4) {
            if ($pixels[$i] -eq 0) { $a0++ }
        }

        return [PSCustomObject]@{
            Pixels            = $pixels
            TransparentPixels = $a0
            CornerAlpha       = $pixels[3]
        }
    } finally {
        if ($null -ne $g) { $g.Dispose() }
        if ($null -ne $canvas) { $canvas.Dispose() }
        $src.Dispose()
    }
}

function Write-UncompressedRgbaDds {
    param(
        [string]$Path,
        [byte[]]$PixelsBgra,
        [int]$Width,
        [int]$Height
    )

    $header = New-Object byte[] 128
    [Text.Encoding]::ASCII.GetBytes("DDS ").CopyTo($header, 0)
    Write-Bytes32 $header 4 124
    Write-Bytes32 $header 8 0x100F
    Write-Bytes32 $header 12 $Height
    Write-Bytes32 $header 16 $Width
    Write-Bytes32 $header 20 ($Width * 4)
    Write-Bytes32 $header 28 0
    Write-Bytes32 $header 76 32
    Write-Bytes32 $header 80 0x41
    Write-Bytes32 $header 88 32
    Write-Bytes32 $header 92 ([uint64]0x00FF0000)
    Write-Bytes32 $header 96 ([uint64]0x0000FF00)
    Write-Bytes32 $header 100 ([uint64]0x000000FF)
    # Alpha mask 0xFF000000 as raw LE bytes (avoid signed hex literals)
    $header[104] = 0
    $header[105] = 0
    $header[106] = 0
    $header[107] = 255
    Write-Bytes32 $header 108 ([uint64]0x1000)
    $tmp = $Path + ".partial"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }

    $fs = [IO.File]::Open($tmp, [IO.FileMode]::Create, [IO.FileAccess]::Write)
    try {
        $fs.Write($header, 0, 128)
        $fs.Write($PixelsBgra, 0, $PixelsBgra.Length)
    } finally {
        $fs.Close()
    }

    Move-Item -LiteralPath $tmp -Destination $Path -Force
}

function Test-GeneratedDds {
    param(
        [string]$Path,
        [string]$ReferencePath
    )

    $bytes = [IO.File]::ReadAllBytes($Path)
    $header = Get-DdsHeaderInfo -Bytes $bytes
    $issues = Test-KnownGoodDdsHeader -Header $header

    $a0 = 0
    $midA = $bytes[128 + ((128 * 256) + 128) * 4 + 3]
    $cornerA = $bytes[128 + 3]
    for ($y = 0; $y -lt 256; $y++) {
        for ($x = 0; $x -lt 256; $x++) {
            $a = $bytes[128 + (($y * 256) + $x) * 4 + 3]
            if ($a -eq 0) { $a0++ }
        }
    }

    $ref = [IO.File]::ReadAllBytes($ReferencePath)
    $headerMatch = $true
    for ($i = 0; $i -lt 128; $i++) {
        if ($bytes[$i] -ne $ref[$i]) { $headerMatch = $false; break }
    }

    return [PSCustomObject]@{
        Header            = $header
        Issues            = $issues
        TransparentPixels = $a0
        CornerAlpha       = $cornerA
        MidAlpha          = $midA
        HeaderMatchesRef  = $headerMatch
        HasGenuineAlpha   = ($a0 -gt 100 -and $cornerA -eq 0)
    }
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

$repoRoot = Get-RepoRoot
$ddsDir = Get-DdsOutputDir -RepoRoot $repoRoot
$refDds = Join-Path $ddsDir "sd_dog_piglet.dds"

Write-SdHost "Stellar Xeno DDS Generator"
Write-SdHost "Phase 4 - Canonical PNG to DDS (no Stellaris registration)"
Write-SdHost ""

$sourcePath = Resolve-SourcePath -RepoRoot $repoRoot -SourceArg $Source
Write-SdHost "Source:"
Write-SdHost ("  {0}" -f $sourcePath)
Write-SdHost ""

Write-SdHost "Validating source..."
$srcInfo = Test-SourcePngForDds -Path $sourcePath
Write-SdHost ("  dog number : {0}" -f $srcInfo.DogNumber)
Write-SdHost ("  dog name   : {0}" -f $srcInfo.DogName)
Write-SdHost ("  dimensions : {0}x{1}" -f $srcInfo.Width, $srcInfo.Height)
Write-SdHost ("  format     : {0}" -f $srcInfo.PixelFormat)
Write-SdHost ("  corner A   : {0}" -f $srcInfo.CornerAlpha)
Write-SdHost ""

$ddsName = Get-DdsFileName -Slug $srcInfo.DogName
$outPath = Join-Path $ddsDir $ddsName
Write-SdHost "Output:"
Write-SdHost ("  {0}" -f $outPath)
Write-SdHost ""

if (-not (Test-Path -LiteralPath $ddsDir)) {
    throw ("DDS output directory missing: {0}" -f $ddsDir)
}
if (-not (Test-Path -LiteralPath $refDds)) {
    throw ("Known-good reference DDS missing: {0}" -f $refDds)
}

if (Test-Path -LiteralPath $outPath) {
    Write-Host ("A game texture already exists for this portrait:")
    Write-Host ("  {0}" -f $outPath)
    Write-Host "The tool will not overwrite it."
    Exit-SdTool 2
    return
}

# Regression snapshots (read-only) — every currently registered portrait DDS.
$protected = @(Get-SdProtectedDdsFileNames)
$hashesBefore = @{}
foreach ($f in $protected) {
    $p = Join-Path $ddsDir $f
    if (Test-Path -LiteralPath $p) {
        $hashesBefore[$f] = (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash
    }
}

Write-SdHost "Converting..."
$converted = ConvertTo-PortraitDdsPixels -SourcePath $sourcePath -Size $DdsSize

$partial = $outPath + ".partial"
try {
    Write-UncompressedRgbaDds -Path $outPath -PixelsBgra $converted.Pixels -Width $DdsSize -Height $DdsSize
} catch {
    if (Test-Path -LiteralPath $partial) { Remove-Item -LiteralPath $partial -Force -ErrorAction SilentlyContinue }
    if (Test-Path -LiteralPath $outPath) { Remove-Item -LiteralPath $outPath -Force -ErrorAction SilentlyContinue }
    throw
}

Write-SdHost "Validating DDS..."
$validation = Test-GeneratedDds -Path $outPath -ReferencePath $refDds
if ($validation.Issues.Count -gt 0 -or -not $validation.HasGenuineAlpha -or -not $validation.HeaderMatchesRef) {
    Remove-Item -LiteralPath $outPath -Force -ErrorAction SilentlyContinue
    $detail = if ($validation.Issues.Count -gt 0) { $validation.Issues -join ", " } else { "alpha/header mismatch" }
    throw ("DDS validation failed ({0}). Output removed." -f $detail)
}

Write-SdHost ""
Write-SdHost "DDS generation successful."
Write-SdHost ("  path        : {0}" -f $outPath)
Write-SdHost ("  dimensions  : {0}x{1}" -f $validation.Header.Width, $validation.Header.Height)
Write-SdHost ("  pfFlags     : 0x{0:X}" -f $validation.Header.PfFlags)
Write-SdHost ("  bpp         : {0}" -f $validation.Header.Bpp)
Write-SdHost ("  compression : none (uncompressed RGBA)")
Write-SdHost ("  pitch       : {0}" -f $validation.Header.Pitch)
Write-SdHost ("  mips        : {0}" -f $validation.Header.Mips)
Write-SdHost ("  alpha A0 px : {0}" -f $validation.TransparentPixels)
Write-SdHost ("  corner A    : {0}" -f $validation.CornerAlpha)
Write-SdHost ("  header==Piglet reference: {0}" -f $validation.HeaderMatchesRef)
Write-SdHost ""

Write-SdHost "Protected DDS regression:"
$regOk = $true
foreach ($f in $protected) {
    $p = Join-Path $ddsDir $f
    if (-not $hashesBefore.ContainsKey($f)) { continue }
    $after = (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash
    $ok = ($after -eq $hashesBefore[$f])
    if (-not $ok) { $regOk = $false }
    Write-SdHost ("  {0}: {1}" -f $f, $(if ($ok) { "unchanged" } else { "CHANGED" }))
}
if (-not $regOk) {
    throw "Protected DDS assets changed unexpectedly."
}

Write-SdHost ""
Write-SdHost "Game texture created."
Exit-SdTool 0
return
