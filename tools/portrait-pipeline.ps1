# Stellar Dogos — Phase 6: End-to-End Portrait Pipeline
# Chains existing tools: intake → species-type selection → DDS → registration.
# Does NOT redesign architecture, accept a name CLI bypass, or touch vanilla Stellaris.
#
# Interactive naming is mandatory. Species type is chosen with the arrow-key menu
# (or numbered fallback when stdin is redirected). The pipeline never derives the
# portrait name or species type from the candidate filename.
#
# Normal UX: run without piping; answer the on-screen prompts.
# Scripted proof (optional): pipe answers that go THROUGH the visible prompts, e.g.:
#   @"
#   Maple
#   1
#   "@ | powershell ... -File tools\portrait-pipeline.ps1

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$ProtectedDds = @('sd_dog_piglet.dds', 'sd_dog_02.dds', 'sd_dog_angus.dds')
$CanonicalPattern = '^dog(\d+)_(.+)_stellaris\.png$'

function Get-RepoRoot {
    $scriptDir = Split-Path -Parent $PSCommandPath
    return (Resolve-Path (Join-Path $scriptDir "..")).Path
}

function Get-Sha256Map {
    param(
        [string]$Directory,
        [string[]]$FileNames
    )

    $map = @{}
    foreach ($name in $FileNames) {
        $path = Join-Path $Directory $name
        if (Test-Path -LiteralPath $path) {
            $map[$name] = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        }
    }
    return $map
}

function Assert-Sha256Unchanged {
    param(
        [hashtable]$Before,
        [hashtable]$After,
        [string]$Label
    )

    $ok = $true
    foreach ($k in ($Before.Keys | Sort-Object)) {
        if (-not $After.ContainsKey($k)) {
            Write-Host ("  {0}: MISSING after {1}" -f $k, $Label)
            $ok = $false
            continue
        }
        $same = ($Before[$k] -eq $After[$k])
        if (-not $same) {
            Write-Host ("  {0}: CHANGED" -f $k)
            $ok = $false
        }
    }
    if (-not $ok) {
        throw ("Protected assets changed during {0}." -f $Label)
    }
}

function Get-CanonicalNames {
    param([string]$Directory)

    if (-not (Test-Path -LiteralPath $Directory)) { return @() }
    return @(
        Get-ChildItem -LiteralPath $Directory -File |
            Where-Object { $_.Name -match $CanonicalPattern } |
            ForEach-Object { $_.Name } |
            Sort-Object
    )
}

function Invoke-ChildScript {
    param(
        [string]$ScriptPath,
        # Named parameters as a hashtable (e.g. @{ Source = $path }).
        # Do NOT pass @("-Source", $path) — string-array splatting treats
        # "-Source" as a positional value when invoking scripts with &.
        [hashtable]$Arguments = @{},
        [string]$PhaseName = ""
    )

    # Run in THIS PowerShell process so Write-Host prompts and the arrow-key
    # xenotype menu share the user's real console. Nested powershell.exe was
    # breaking stdin/stdout and made registration fail without a species choice.
    $env:STELLAR_DOGOS_INPROCESS = "1"
    $global:STELLAR_DOGOS_EXITCODE = 0
    $label = if ($PhaseName) { $PhaseName } else { Split-Path -Leaf $ScriptPath }

    try {
        & $ScriptPath @Arguments
        $code = 0
        if ($null -ne $global:STELLAR_DOGOS_EXITCODE) {
            $code = [int]$global:STELLAR_DOGOS_EXITCODE
        }
        return [PSCustomObject]@{
            ExitCode = $code
            Error    = $null
        }
    } catch {
        Write-Host ""
        Write-Host ("Something went wrong while preparing your portrait ({0})." -f $label)
        Write-Host ("  {0}" -f $_.Exception.Message)
        if ($_.InvocationInfo -and $_.InvocationInfo.PositionMessage) {
            Write-Host $_.InvocationInfo.PositionMessage
        }
        return [PSCustomObject]@{
            ExitCode = 1
            Error    = $_.Exception.Message
        }
    } finally {
        Remove-Item Env:\STELLAR_DOGOS_INPROCESS -ErrorAction SilentlyContinue
    }
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

$repoRoot = Get-RepoRoot
$toolsDir = Join-Path $repoRoot "tools"
$imgHere = Join-Path $repoRoot "ImgHERE"
$assetsSource = Join-Path $repoRoot "assets\source"
$ddsDir = Join-Path $repoRoot "experiment\sd_static_portrait_test\gfx\models\portraits\sd_static_test"
$intakeScript = Join-Path $toolsDir "portrait-intake.ps1"
$ddsScript = Join-Path $toolsDir "portrait-dds.ps1"
$registerScript = Join-Path $toolsDir "portrait-register.ps1"
$xenotypesScript = Join-Path $toolsDir "portrait-xenotypes.ps1"
$exitHelper = Join-Path $toolsDir "portrait-exit.ps1"

Write-Host "Stellar Dogos - Portrait Creator"
Write-Host ""

foreach ($required in @($imgHere, $assetsSource, $ddsDir, $intakeScript, $ddsScript, $registerScript, $xenotypesScript, $exitHelper)) {
    if (-not (Test-Path -LiteralPath $required)) {
        throw ("Required path missing: {0}" -f $required)
    }
}

. $exitHelper
. $xenotypesScript

$env:STELLAR_DOGOS_PIPELINE = "1"
try {
    $hashesBefore = Get-Sha256Map -Directory $ddsDir -FileNames $ProtectedDds
    $canonsBefore = Get-CanonicalNames -Directory $imgHere
    $global:STELLAR_DOGOS_LAST_DISPLAY_NAME = $null

    $intakeResult = Invoke-ChildScript -ScriptPath $intakeScript -PhaseName "portrait preparation"

    if ($intakeResult.ExitCode -ne 0) {
        Write-Host ""
        Write-Host "Could not prepare the portrait. Your original image was left in ImgHERE so you can try again."
        if ($intakeResult.Error) {
            Write-Host ("Details: {0}" -f $intakeResult.Error)
        }
        exit $intakeResult.ExitCode
    }

    $canonsAfter = Get-CanonicalNames -Directory $imgHere
    $newCanons = @(Compare-Object -ReferenceObject $canonsBefore -DifferenceObject $canonsAfter |
            Where-Object { $_.SideIndicator -eq "=>" } |
            ForEach-Object { $_.InputObject })

    if ($newCanons.Count -eq 0) {
        # Intake already printed the friendly "no new portrait" message.
        exit 0
    }

    if ($newCanons.Count -gt 1) {
        Write-Host ("Note: multiple new portraits were created ({0}). Continuing with the first." -f ($newCanons -join ", "))
    }

    $canonicalName = $newCanons[0]
    $canonicalRel = Join-Path "assets\source" $canonicalName
    $canonicalPath = Join-Path $assetsSource $canonicalName

    if (-not (Test-Path -LiteralPath $canonicalPath)) {
        throw ("Prepared portrait image missing after intake: {0}" -f $canonicalPath)
    }

    $m = [regex]::Match($canonicalName.ToLowerInvariant(), $CanonicalPattern)
    if (-not $m.Success) {
        throw ("Unexpected prepared filename: {0}" -f $canonicalName)
    }
    $slug = $m.Groups[2].Value
    $displayName = $global:STELLAR_DOGOS_LAST_DISPLAY_NAME
    if ([string]::IsNullOrWhiteSpace($displayName)) {
        $displayName = (Get-Culture).TextInfo.ToTitleCase($slug.Replace('_', ' '))
    }
    $ddsName = "sd_dog_$slug.dds"
    $ddsPath = Join-Path $ddsDir $ddsName

    # Ask species type immediately after the name (player-facing order).
    $xeno = Read-PortraitXenotypeInteractive -PortraitDisplayName $displayName
    $speciesLabel = $xeno.DisplayName

    Write-Host ""
    Write-Host "Preparing your portrait..."

    $ddsResult = Invoke-ChildScript -ScriptPath $ddsScript -Arguments @{ Source = $canonicalRel } -PhaseName "game texture"
    if ($ddsResult.ExitCode -ne 0) {
        Write-Host ""
        Write-Host "Could not finish preparing your portrait."
        if ($ddsResult.Error) {
            Write-Host ("Details: {0}" -f $ddsResult.Error)
        }
        Write-Host ("Exit code: {0}" -f $ddsResult.ExitCode)
        exit $ddsResult.ExitCode
    }

    if (-not (Test-Path -LiteralPath $ddsPath)) {
        throw ("Expected game texture was not created: {0}" -f $ddsPath)
    }

    $regRel = Join-Path "experiment\sd_static_portrait_test\gfx\models\portraits\sd_static_test" $ddsName
    $regResult = Invoke-ChildScript -ScriptPath $registerScript -Arguments @{
        Source   = $regRel
        Xenotype = $xeno.Id
    } -PhaseName "registration"
    if ($regResult.ExitCode -ne 0) {
        Write-Host ""
        Write-Host "Could not finish preparing your portrait."
        Write-Host ("Exit code: {0}" -f $regResult.ExitCode)
        if ($regResult.Error) {
            Write-Host ("Details: {0}" -f $regResult.Error)
        } else {
            Write-Host "See the messages above for the exact reason."
        }
        exit $regResult.ExitCode
    }

    $hashesAfter = Get-Sha256Map -Directory $ddsDir -FileNames $ProtectedDds
    Assert-Sha256Unchanged -Before $hashesBefore -After $hashesAfter -Label "portrait creation"

    Write-Host ""
    $check = [char]0x2713
    Write-Host ("{0} Portrait created successfully!" -f $check)
    Write-Host ("Name: {0}" -f $displayName)
    Write-Host ("Species type: {0}" -f $speciesLabel)
    Write-Host ""
    Write-Host "Your portrait is now ready to use in Stellaris."
    Write-Host ""
    Write-Host "Technical details:"
    Write-Host ("  Portrait ID: sd_dog_{0}" -f $slug)
    Write-Host ("  Source: {0}" -f $canonicalPath)
    Write-Host ("  DDS: {0}" -f $ddsPath)
    exit 0
} finally {
    Remove-Item Env:\STELLAR_DOGOS_PIPELINE -ErrorAction SilentlyContinue
}
