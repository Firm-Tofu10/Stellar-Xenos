# Stellar Dogos — Phase 3.1 Portrait Intake / Source Preparation
# Discover → classify → interactive name → number → prepare → validate → cleanup
#
# Does NOT: create DDS, portrait IDs, or Stellaris registration.
# Does NOT: accept a -DogName bypass. Naming is always interactive for new candidates.

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

$SupportedExtensions = @(".png", ".jpg", ".jpeg", ".webp")
$CanonicalPattern = '^dog(\d+)_(.+)_stellaris\.png$'

# ---------------------------------------------------------------------------
# Path helpers
# ---------------------------------------------------------------------------

function Get-RepoRoot {
    $scriptDir = Split-Path -Parent $PSCommandPath
    return (Resolve-Path (Join-Path $scriptDir "..")).Path
}

function Get-ImgHerePath {
    param([string]$RepoRoot)
    return Join-Path $RepoRoot "ImgHERE"
}

function Get-AssetsSourcePath {
    param([string]$RepoRoot)
    return Join-Path $RepoRoot "assets\source"
}

# ---------------------------------------------------------------------------
# Classification / parsing (Steps 1-3)
# ---------------------------------------------------------------------------

function Test-IsSupportedExtension {
    param([string]$Extension)
    return $SupportedExtensions -contains $Extension.ToLowerInvariant()
}

function Get-CanonicalPortraitInfo {
    param([string]$FileName)

    $m = [regex]::Match($FileName.ToLowerInvariant(), $CanonicalPattern)
    if (-not $m.Success) { return $null }

    $rawName = $m.Groups[2].Value
    if ([string]::IsNullOrWhiteSpace($rawName)) { return $null }

    return [PSCustomObject]@{
        FileName    = $FileName
        Number      = [int]$m.Groups[1].Value
        Name        = $rawName.ToLowerInvariant()
        IsCanonical = $true
    }
}

function Get-PortraitClassification {
    param([System.IO.FileInfo]$File)

    if (-not (Test-IsSupportedExtension -Extension $File.Extension)) {
        return [PSCustomObject]@{ Kind = "IGNORED"; Info = $null }
    }

    $info = Get-CanonicalPortraitInfo -FileName $File.Name
    if ($null -ne $info) {
        return [PSCustomObject]@{ Kind = "CANONICAL"; Info = $info }
    }

    return [PSCustomObject]@{ Kind = "NEW_CANDIDATE"; Info = $null }
}

function Get-NumberInventory {
    param([object[]]$CanonicalInfos)

    $numbers = @($CanonicalInfos | ForEach-Object { $_.Number } | Sort-Object -Unique)
    $highest = $null
    $next = 1
    if ($numbers.Count -gt 0) {
        $highest = ($numbers | Measure-Object -Maximum).Maximum
        $next = $highest + 1
    }

    return [PSCustomObject]@{
        Numbers = $numbers
        Highest = $highest
        Next    = $next
    }
}

function Get-CanonicalConflicts {
    param([object[]]$CanonicalInfos)

    $conflicts = New-Object System.Collections.Generic.List[string]

    foreach ($g in ($CanonicalInfos | Group-Object Number)) {
        if ($g.Count -gt 1) {
            $files = ($g.Group | ForEach-Object { $_.FileName }) -join ", "
            [void]$conflicts.Add(("Duplicate dog number {0}: {1}" -f $g.Name, $files))
        }
    }

    foreach ($g in ($CanonicalInfos | Group-Object Name)) {
        if ($g.Count -gt 1) {
            $files = ($g.Group | ForEach-Object { $_.FileName }) -join ", "
            [void]$conflicts.Add(("Duplicate dog name '{0}': {1}" -f $g.Name, $files))
        }
    }

    return @($conflicts)
}

function Scan-ImgHere {
    param([string]$ImgHere)

    $allFiles = @(Get-ChildItem -LiteralPath $ImgHere -File -Force | Sort-Object Name)
    $canonical = New-Object System.Collections.Generic.List[object]
    $candidates = New-Object System.Collections.Generic.List[System.IO.FileInfo]
    $ignored = New-Object System.Collections.Generic.List[string]

    foreach ($f in $allFiles) {
        $c = Get-PortraitClassification -File $f
        switch ($c.Kind) {
            "CANONICAL" { [void]$canonical.Add($c.Info) }
            "NEW_CANDIDATE" { [void]$candidates.Add($f) }
            "IGNORED" { [void]$ignored.Add($f.Name) }
        }
    }

    $canonicalSorted = @($canonical | Sort-Object Number, FileName)
    return [PSCustomObject]@{
        Canonical  = $canonicalSorted
        Candidates = @($candidates)
        Ignored    = @($ignored)
        Inventory  = (Get-NumberInventory -CanonicalInfos $canonicalSorted)
        Conflicts  = (Get-CanonicalConflicts -CanonicalInfos $canonicalSorted)
    }
}

function Write-IntakeReport {
    param($Scan)

    Write-Host "Canonical portraits:"
    if ($Scan.Canonical.Count -eq 0) {
        Write-Host "  none"
    } else {
        foreach ($info in $Scan.Canonical) {
            Write-Host ("  [OK] {0}" -f $info.FileName)
            Write-Host ("       number: {0}" -f $info.Number)
            Write-Host ("       name: {0}" -f $info.Name)
        }
    }

    Write-Host ""
    Write-Host "New portrait candidates:"
    if ($Scan.Candidates.Count -eq 0) {
        Write-Host "  none"
    } else {
        foreach ($f in $Scan.Candidates) {
            Write-Host ("  [?] {0}" -f $f.Name)
            Write-Host "       name: unknown"
            Write-Host "       number: unassigned"
        }
    }

    Write-Host ""
    Write-Host "Ignored:"
    if ($Scan.Ignored.Count -eq 0) {
        Write-Host "  none"
    } else {
        foreach ($name in $Scan.Ignored) {
            Write-Host ("  - {0}" -f $name)
        }
    }

    Write-Host ""
    Write-Host "Existing dog numbers:"
    if ($Scan.Inventory.Numbers.Count -eq 0) {
        Write-Host "  none"
    } else {
        Write-Host ("  {0}" -f ($Scan.Inventory.Numbers -join ", "))
    }

    Write-Host ""
    Write-Host "Highest existing dog number:"
    if ($null -eq $Scan.Inventory.Highest) {
        Write-Host "  none"
    } else {
        Write-Host ("  {0}" -f $Scan.Inventory.Highest)
    }

    Write-Host ""
    Write-Host "Next available number:"
    Write-Host ("  {0}" -f $Scan.Inventory.Next)

    Write-Host ""
    Write-Host "Conflicts:"
    if ($Scan.Conflicts.Count -eq 0) {
        Write-Host "  none"
    } else {
        foreach ($c in $Scan.Conflicts) {
            Write-Host ("  ! {0}" -f $c)
        }
    }

    Write-Host ""
    Write-Host "Summary:"
    Write-Host ("  {0} canonical portrait(s)" -f $Scan.Canonical.Count)
    Write-Host ("  {0} new portrait candidate(s)" -f $Scan.Candidates.Count)
    Write-Host ("  {0} ignored file(s)" -f $Scan.Ignored.Count)
    Write-Host ("  {0} conflict(s)" -f $Scan.Conflicts.Count)
}

# ---------------------------------------------------------------------------
# Naming (Step 4-5)
# ---------------------------------------------------------------------------

function ConvertTo-SafeDogSlug {
    param([string]$DisplayName)

    $slug = $DisplayName.Trim().ToLowerInvariant()
    $slug = $slug -replace '\s+', '_'
    $slug = $slug -replace '[^a-z0-9_\-]', ''
    $slug = $slug -replace '_+', '_'
    $slug = $slug.Trim('_')
    return $slug
}

function Test-IsValidDogDisplayName {
    param([string]$DisplayName)

    if ([string]::IsNullOrWhiteSpace($DisplayName)) {
        return [PSCustomObject]@{ Ok = $false; Reason = "empty" }
    }

    $slug = ConvertTo-SafeDogSlug -DisplayName $DisplayName
    if ([string]::IsNullOrWhiteSpace($slug)) {
        return [PSCustomObject]@{ Ok = $false; Reason = "unusable" }
    }

    return [PSCustomObject]@{ Ok = $true; Reason = ""; Slug = $slug }
}

function Read-DogNameInteractive {
    param([string]$CandidateFileName)

    Write-Host ""
    Write-Host "New portrait candidate detected:"
    Write-Host ("  {0}" -f $CandidateFileName)
    Write-Host ""
    Write-Host "What is this dog's name?"

    while ($true) {
        Write-Host -NoNewline "> "
        $entered = $null
        if ([Console]::IsInputRedirected) {
            $entered = [Console]::In.ReadLine()
            if ($null -eq $entered) {
                throw "No dog name provided (stdin closed)."
            }
            Write-Host $entered
        } else {
            $entered = Read-Host
        }

        $check = Test-IsValidDogDisplayName -DisplayName $entered
        if ($check.Ok) {
            return [PSCustomObject]@{ Display = $entered.Trim(); Slug = $check.Slug }
        }

        if ($check.Reason -eq "empty") {
            Write-Host "Dog name cannot be empty."
            Write-Host "Please enter the dog's name:"
        } else {
            Write-Host "Dog name is invalid (no usable filename characters)."
            Write-Host "Please enter the dog's name:"
        }
    }
}

function Get-CanonicalFileName {
    param(
        [int]$Number,
        [string]$Slug
    )
    return ("dog{0:D2}_{1}_stellaris.png" -f $Number, $Slug)
}

# ---------------------------------------------------------------------------
# Image preparation (Step 6)
# ---------------------------------------------------------------------------

function Test-BitmapHasGenuineAlpha {
    param([System.Drawing.Bitmap]$Bitmap)

    $fmt32 = [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    $rect = New-Object System.Drawing.Rectangle 0, 0, $Bitmap.Width, $Bitmap.Height
    $data = $Bitmap.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, $fmt32)
    try {
        $stride = [Math]::Abs($data.Stride)
        $raw = New-Object byte[] ($stride * $Bitmap.Height)
        [Runtime.InteropServices.Marshal]::Copy($data.Scan0, $raw, 0, $raw.Length)
    } finally {
        $Bitmap.UnlockBits($data)
    }

    $transparent = 0
    $opaque = 0
    for ($y = 0; $y -lt $Bitmap.Height; $y++) {
        $row = $y * $stride
        for ($x = 0; $x -lt $Bitmap.Width; $x++) {
            $a = $raw[$row + ($x * 4) + 3]
            if ($a -eq 0) { $transparent++ }
            elseif ($a -ge 250) { $opaque++ }
        }
    }

    return [PSCustomObject]@{
        TransparentPixels = $transparent
        NearOpaquePixels  = $opaque
        HasGenuineAlpha   = ($transparent -gt 100)
    }
}

function Convert-NearWhiteBackgroundToAlpha {
    # Technical plate removal only (border flood-fill of near-white). Does not regenerate art.
    param(
        [System.Drawing.Bitmap]$Source,
        [int]$Threshold = 245
    )

    $w = $Source.Width
    $h = $Source.Height
    $fmt32 = [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
    $bmp = New-Object System.Drawing.Bitmap $w, $h, $fmt32
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.DrawImage($Source, 0, 0, $w, $h)
    $g.Dispose()

    function Test-NearWhite([System.Drawing.Color]$c, [int]$t) {
        return ($c.A -gt 0 -and $c.R -ge $t -and $c.G -ge $t -and $c.B -ge $t)
    }

    $queue = New-Object System.Collections.Generic.Queue[object]
    $visited = New-Object 'bool[,]' $w, $h

    function Enqueue-IfPlate([int]$x, [int]$y) {
        if ($x -lt 0 -or $y -lt 0 -or $x -ge $w -or $y -ge $h) { return }
        if ($visited[$x, $y]) { return }
        $c = $bmp.GetPixel($x, $y)
        if (Test-NearWhite $c $Threshold) {
            $visited[$x, $y] = $true
            $queue.Enqueue(@($x, $y))
        }
    }

    for ($x = 0; $x -lt $w; $x++) {
        Enqueue-IfPlate $x 0
        Enqueue-IfPlate $x ($h - 1)
    }
    for ($y = 0; $y -lt $h; $y++) {
        Enqueue-IfPlate 0 $y
        Enqueue-IfPlate ($w - 1) $y
    }

    $cleared = 0
    while ($queue.Count -gt 0) {
        $p = $queue.Dequeue()
        $x = $p[0]; $y = $p[1]
        $bmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        $cleared++
        Enqueue-IfPlate ($x + 1) $y
        Enqueue-IfPlate ($x - 1) $y
        Enqueue-IfPlate $x ($y + 1)
        Enqueue-IfPlate $x ($y - 1)
    }

    return [PSCustomObject]@{ Bitmap = $bmp; Cleared = $cleared }
}

function ConvertTo-SquareRgbaPortrait {
    # Fit into a square RGBA canvas. Preserve artwork; no creative crop/regen.
    # Taller sources: align to bottom (preserve bottom-edge crop). Wider: center.
    param([System.Drawing.Bitmap]$Source)

    $side = [Math]::Max($Source.Width, $Source.Height)
    $canvas = New-Object System.Drawing.Bitmap $side, $side, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($canvas)
    $g.Clear([System.Drawing.Color]::FromArgb(0, 0, 0, 0))
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $dx = [int](($side - $Source.Width) / 2)
    if ($Source.Height -ge $Source.Width) {
        $dy = $side - $Source.Height
        if ($dy -lt 0) { $dy = 0 }
    } else {
        $dy = [int](($side - $Source.Height) / 2)
    }

    $g.DrawImage($Source, $dx, $dy, $Source.Width, $Source.Height)
    $g.Dispose()
    return $canvas
}

function Save-Png32 {
    param(
        [System.Drawing.Bitmap]$Bitmap,
        [string]$Path
    )

    $dir = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }

    # Save via MemoryStream to avoid GDI+ lock issues on overwrite paths
    $ms = New-Object System.IO.MemoryStream
    $Bitmap.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
    [IO.File]::WriteAllBytes($Path, $ms.ToArray())
    $ms.Dispose()
}

function New-PreparedPortraitPng {
    param([string]$SourcePath)

    $loaded = $null
    try {
        $loaded = [System.Drawing.Bitmap]::FromFile($SourcePath)
    } catch {
        throw ("Failed to load image '{0}': {1}" -f $SourcePath, $_.Exception.Message)
    }

    $working = $null
    $bgRemoved = $false
    $cleared = 0

    try {
        $alpha = Test-BitmapHasGenuineAlpha -Bitmap $loaded
        if ($alpha.HasGenuineAlpha) {
            $working = New-Object System.Drawing.Bitmap $loaded.Width, $loaded.Height, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
            $g = [System.Drawing.Graphics]::FromImage($working)
            $g.DrawImage($loaded, 0, 0, $loaded.Width, $loaded.Height)
            $g.Dispose()
        } else {
            $cut = Convert-NearWhiteBackgroundToAlpha -Source $loaded
            $working = $cut.Bitmap
            $bgRemoved = $true
            $cleared = $cut.Cleared
            $alpha2 = Test-BitmapHasGenuineAlpha -Bitmap $working
            if (-not $alpha2.HasGenuineAlpha) {
                throw "Could not establish genuine alpha transparency. Provide a transparent PNG or a near-white plate background."
            }
        }

        $square = ConvertTo-SquareRgbaPortrait -Source $working
        return [PSCustomObject]@{
            Bitmap           = $square
            BackgroundRemoved = $bgRemoved
            PlatePixelsCleared = $cleared
            SourceWidth      = $loaded.Width
            SourceHeight     = $loaded.Height
            OutputWidth      = $square.Width
            OutputHeight     = $square.Height
        }
    } finally {
        if ($null -ne $working) { $working.Dispose() }
        if ($null -ne $loaded) { $loaded.Dispose() }
    }
}

function Test-PreparedPortraitFile {
    param([string]$Path)

    $bmp = [System.Drawing.Bitmap]::FromFile($Path)
    try {
        $square = ($bmp.Width -eq $bmp.Height)
        $fmt = $bmp.PixelFormat.ToString()
        $rgba = ($fmt -match 'Argb|PArgb')
        $alpha = Test-BitmapHasGenuineAlpha -Bitmap $bmp
        $corner = $bmp.GetPixel(0, 0)

        return [PSCustomObject]@{
            Path              = $Path
            Width             = $bmp.Width
            Height            = $bmp.Height
            IsSquare          = $square
            PixelFormat       = $fmt
            IsRgba            = $rgba
            HasGenuineAlpha   = $alpha.HasGenuineAlpha
            TransparentPixels = $alpha.TransparentPixels
            CornerAlpha       = $corner.A
            LooksLikeOpaquePlate = ($corner.A -eq 255 -and -not $alpha.HasGenuineAlpha)
        }
    } finally {
        $bmp.Dispose()
    }
}

# ---------------------------------------------------------------------------
# Intake processing
# ---------------------------------------------------------------------------

function Invoke-CandidateIntake {
    param(
        [System.IO.FileInfo]$Candidate,
        [string]$ImgHere,
        [string]$AssetsSource
    )

    # Name FIRST (mandatory interactive). Numbering happens only after a valid name.
    $nameInfo = Read-DogNameInteractive -CandidateFileName $Candidate.Name

    $live = Scan-ImgHere -ImgHere $ImgHere
    if ($live.Conflicts.Count -gt 0) {
        throw "Existing canonical conflicts detected. Resolve them before intake."
    }

    $nextNumber = $live.Inventory.Next
    $existingNames = @($live.Canonical | ForEach-Object { $_.Name })
    $slug = $nameInfo.Slug
    $canonicalName = Get-CanonicalFileName -Number $nextNumber -Slug $slug

    Write-Host ""
    Write-Host "Assigned:"
    Write-Host ("  display name : {0}" -f $nameInfo.Display)
    Write-Host ("  slug         : {0}" -f $slug)
    Write-Host ("  dog number   : {0}" -f $nextNumber)
    Write-Host ("  canonical    : {0}" -f $canonicalName)

    if ($existingNames -contains $slug) {
        throw ("Conflict: a canonical portrait named '{0}' already exists. Refusing to create {1}." -f $slug, $canonicalName)
    }

    $destImgHere = Join-Path $ImgHere $canonicalName
    $destAssets = Join-Path $AssetsSource $canonicalName

    if (Test-Path -LiteralPath $destImgHere) {
        throw ("Conflict: '{0}' already exists in ImgHERE. Refusing to overwrite." -f $destImgHere)
    }
    if (Test-Path -LiteralPath $destAssets) {
        throw ("Conflict: '{0}' already exists in assets/source. Refusing to overwrite." -f $destAssets)
    }

    Write-Host ""
    Write-Host "Preparing image (technical only - no artistic regeneration)..."
    $prepared = $null
    $wroteOutputs = $false
    $v1 = $null
    $bgRemoved = $false
    try {
        $prepared = New-PreparedPortraitPng -SourcePath $Candidate.FullName
        $bgRemoved = $prepared.BackgroundRemoved
        Save-Png32 -Bitmap $prepared.Bitmap -Path $destImgHere
        Save-Png32 -Bitmap $prepared.Bitmap -Path $destAssets
        $wroteOutputs = $true

        $v1 = Test-PreparedPortraitFile -Path $destImgHere
        $v2 = Test-PreparedPortraitFile -Path $destAssets

        if (-not $v1.IsSquare -or -not $v1.IsRgba -or -not $v1.HasGenuineAlpha -or $v1.LooksLikeOpaquePlate) {
            throw "Prepared ImgHERE file failed validation."
        }
        if (-not $v2.IsSquare -or -not $v2.IsRgba -or -not $v2.HasGenuineAlpha -or $v2.LooksLikeOpaquePlate) {
            throw "Prepared assets/source file failed validation."
        }
    } catch {
        # Failure safety: never delete the original candidate. Remove any partial outputs.
        if ($wroteOutputs) {
            if (Test-Path -LiteralPath $destImgHere) { Remove-Item -LiteralPath $destImgHere -Force -ErrorAction SilentlyContinue }
            if (Test-Path -LiteralPath $destAssets) { Remove-Item -LiteralPath $destAssets -Force -ErrorAction SilentlyContinue }
        }
        throw
    } finally {
        if ($null -ne $prepared -and $null -ne $prepared.Bitmap) {
            $prepared.Bitmap.Dispose()
        }
    }

    # SUCCESS only: delete the temporary intake file (keep ImgHERE clean).
    Remove-Item -LiteralPath $Candidate.FullName -Force

    Write-Host ""
    Write-Host "Intake complete."
    Write-Host ("  ImgHERE      : {0}" -f $destImgHere)
    Write-Host ("  assets/source: {0}" -f $destAssets)
    Write-Host ("  dimensions   : {0}x{1}" -f $v1.Width, $v1.Height)
    Write-Host ("  square       : {0}" -f $v1.IsSquare)
    Write-Host ("  RGBA         : {0} ({1})" -f $v1.IsRgba, $v1.PixelFormat)
    Write-Host ("  genuine alpha: {0} (transparent pixels: {1})" -f $v1.HasGenuineAlpha, $v1.TransparentPixels)
    Write-Host ("  corner alpha : {0}" -f $v1.CornerAlpha)
    Write-Host ("  bg plate rem.: {0}" -f $bgRemoved)
    Write-Host ("  temp input   : deleted after successful validation")
    Write-Host ""
    Write-Host "Phase 3.1 STOP - no DDS / portrait registration performed."

    return [PSCustomObject]@{
        CanonicalName = $canonicalName
        ImgHerePath   = $destImgHere
        AssetsPath    = $destAssets
        Validation    = $v1
    }
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

$repoRoot = Get-RepoRoot
$imgHere = Get-ImgHerePath -RepoRoot $repoRoot
$assetsSource = Get-AssetsSourcePath -RepoRoot $repoRoot

Write-Host "Stellar Dogos Portrait Intake"
Write-Host "Phase 3.1 - Source preparation (no DDS / no Stellaris registration)"
Write-Host ""
Write-Host "ImgHERE: $imgHere"
Write-Host ""

if (-not (Test-Path -LiteralPath $imgHere -PathType Container)) {
    Write-Host "ERROR: ImgHERE directory not found."
    Write-Host "Expected: $imgHere"
    exit 1
}

$scan = Scan-ImgHere -ImgHere $imgHere
Write-IntakeReport -Scan $scan

if ($scan.Conflicts.Count -gt 0) {
    Write-Host ""
    Write-Host "Existing canonical conflicts detected. Resolve them before intake."
    exit 2
}

if ($scan.Candidates.Count -eq 0) {
    Write-Host ""
    Write-Host "No new portrait candidates to process."
    Write-Host "Phase 3.1 idle complete (scan only)."
    exit 0
}

# Process candidates sequentially. Naming is always interactive (no -DogName bypass).
$processed = 0

foreach ($candidate in $scan.Candidates) {
    try {
        Invoke-CandidateIntake `
            -Candidate $candidate `
            -ImgHere $imgHere `
            -AssetsSource $assetsSource | Out-Null
        $processed++
    } catch {
        Write-Host ""
        Write-Host ("INTAKE FAILED for '{0}': {1}" -f $candidate.Name, $_.Exception.Message)
        Write-Host "Original candidate left in ImgHERE for retry."
        exit 1
    }
}

Write-Host ""
Write-Host ("Processed {0} candidate(s)." -f $processed)
exit 0
