# Stellar Xeno — Phase 6: End-to-End Portrait Pipeline
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

. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-exit.ps1")
. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-paths.ps1")

$CanonicalPattern = '^dog(\d+)_(.+)_([a-z]{3})_stellaris\.png$'
$LegacyCanonicalPattern = '^dog(\d+)_(.+)_stellaris\.png$'

function Get-RepoRoot {
    return Get-SdRepoRoot
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
            Where-Object {
                $n = $_.Name.ToLowerInvariant()
                ($n -match $CanonicalPattern) -or ($n -match $LegacyCanonicalPattern)
            } |
            ForEach-Object { $_.Name } |
            Sort-Object
    )
}

function Test-PortraitIdRegistered {
    param(
        [string]$PortraitsTxt,
        [string]$PortraitId
    )

    $ids = @(Get-SdRegisteredPortraitIds -PortraitsTxt $PortraitsTxt)
    return ($ids -contains $PortraitId)
}

function Resolve-PortraitIdFromSlug {
    param([string]$Slug)
    return (Resolve-SdPortraitIdFromSlug -Slug $Slug)
}

function Get-PendingCanonicalPortraits {
    param(
        [string]$ImgHere,
        [string]$AssetsSource,
        [string]$DdsDir,
        [string]$PortraitsTxt
    )

    $pending = New-Object System.Collections.Generic.List[object]
    foreach ($name in (Get-CanonicalNames -Directory $ImgHere)) {
        $m = [regex]::Match($name.ToLowerInvariant(), $CanonicalPattern)
        if (-not $m.Success) { continue } # legacy canons are not auto-finished here

        $slug = $m.Groups[2].Value
        $abbr = $m.Groups[3].Value
        $portraitId = Resolve-PortraitIdFromSlug -Slug $slug
        $ddsPath = Join-Path $DdsDir "$portraitId.dds"
        $registered = Test-PortraitIdRegistered -PortraitsTxt $PortraitsTxt -PortraitId $portraitId
        $ddsExists = Test-Path -LiteralPath $ddsPath
        if ($registered -and $ddsExists) { continue }

        $imgPath = Join-Path $ImgHere $name
        $assetsPath = Join-Path $AssetsSource $name
        [void]$pending.Add([PSCustomObject]@{
            FileName    = $name
            Slug        = $slug
            XenoAbbr    = $abbr
            PortraitId  = $portraitId
            ImgHerePath = $imgPath
            AssetsPath  = $assetsPath
            NeedsDds    = (-not $ddsExists)
            NeedsReg    = (-not $registered)
        })
    }

    return @($pending | Sort-Object FileName)
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
$modPaths = Get-SdModPaths -RepoRoot $repoRoot -Which Production
$ddsDir = $modPaths.DdsDir
$ProtectedDds = @(Get-SdProtectedDdsFileNames -PortraitsTxt $modPaths.PortraitsTxt)
$intakeScript = Join-Path $toolsDir "portrait-intake.ps1"
$ddsScript = Join-Path $toolsDir "portrait-dds.ps1"
$registerScript = Join-Path $toolsDir "portrait-register.ps1"
$xenotypesScript = Join-Path $toolsDir "portrait-xenotypes.ps1"
$pathsHelper = Join-Path $toolsDir "portrait-paths.ps1"
$validateScript = Join-Path $toolsDir "portrait-validate.ps1"

Write-Host "Stellar Xeno - Portrait Creator"
Write-Host ""

foreach ($required in @($imgHere, $assetsSource, $ddsDir, $modPaths.PortraitsTxt, $modPaths.SetTxt, $modPaths.CategoryTxt, $intakeScript, $ddsScript, $registerScript, $xenotypesScript, $pathsHelper, $validateScript)) {
    if (-not (Test-Path -LiteralPath $required)) {
        throw ("Required path missing: {0}" -f $required)
    }
}

. $xenotypesScript
. $validateScript

$env:STELLAR_DOGOS_PIPELINE = "1"
try {
    $hashesBefore = Get-Sha256Map -Directory $ddsDir -FileNames $ProtectedDds
    $global:STELLAR_DOGOS_LAST_DISPLAY_NAME = $null
    $global:STELLAR_DOGOS_LAST_XENOTYPE_ID = $null
    $global:STELLAR_DOGOS_LAST_CANONICAL_NAME = $null

    $canonicalName = $null
    $displayName = $null
    $xeno = $null
    $fromPendingCanon = $false

    $intakeResult = Invoke-ChildScript -ScriptPath $intakeScript -PhaseName "portrait preparation"

    if ($intakeResult.ExitCode -ne 0) {
        Write-Host ""
        Write-Host "Could not prepare the portrait. Your original image was left in ImgHERE so you can try again."
        if ($intakeResult.Error) {
            Write-Host ("Details: {0}" -f $intakeResult.Error)
        }
        exit $intakeResult.ExitCode
    }

    if (-not [string]::IsNullOrWhiteSpace($global:STELLAR_DOGOS_LAST_CANONICAL_NAME)) {
        $canonicalName = $global:STELLAR_DOGOS_LAST_CANONICAL_NAME
        $displayName = $global:STELLAR_DOGOS_LAST_DISPLAY_NAME
        $xenoId = $global:STELLAR_DOGOS_LAST_XENOTYPE_ID
        $xeno = Resolve-PortraitXenotype -Selection $xenoId
        if ($null -eq $xeno) {
            throw ("Could not resolve species type from intake selection '{0}'." -f $xenoId)
        }
    } else {
        # No raw new candidate this run — finish ONE already-named pending canon if any.
        $pending = @(Get-PendingCanonicalPortraits -ImgHere $imgHere -AssetsSource $assetsSource -DdsDir $ddsDir -PortraitsTxt $modPaths.PortraitsTxt)
        if ($pending.Count -eq 0) {
            # Intake already printed the friendly "no new portrait" message when applicable.
            exit 0
        }

        $chosen = $pending[0]
        $fromPendingCanon = $true
        if ($pending.Count -gt 1) {
            Write-Host ""
            Write-Host ("Multiple portraits are waiting ({0})." -f $pending.Count)
            Write-Host ("Processing this one now: {0}" -f $chosen.FileName)
            Write-Host "Run the tool again to process the next portrait."
        }

        Write-Host ""
        Write-Host "New portrait found:"
        Write-Host ("  {0}" -f $chosen.FileName)

        $canonicalName = $chosen.FileName
        $displayName = (Get-Culture).TextInfo.ToTitleCase($chosen.Slug.Replace('_', ' '))
        $xeno = Resolve-PortraitXenotype -Selection $chosen.XenoAbbr
        if ($null -eq $xeno) {
            throw ("Could not resolve species type from filename abbreviation '{0}' in {1}." -f $chosen.XenoAbbr, $canonicalName)
        }

        # If already registered under a different species class, do not finish with the wrong abbr.
        $idStatus = Get-SdPortraitIdentityStatus -Slug $chosen.Slug -RepoRoot $repoRoot
        $mem = Get-SdPortraitSetMembershipDetailed -SetTxt $modPaths.SetTxt
        if ($idStatus.Registered -and $mem.ContainsKey($idStatus.PortraitId)) {
            $regClass = $mem[$idStatus.PortraitId][0].SpeciesClass
            if ($xeno.SpeciesClass -ne $regClass) {
                Write-Host ""
                Write-Host "Filename xenotype does not match the existing registration."
                Write-Host ("  File            : {0}" -f $chosen.FileName)
                Write-Host ("  File implies    : {0}" -f $xeno.DisplayName)
                Write-Host ("  Registered as   : species_class {0}" -f $regClass)
                Write-Host ("  Portrait ID     : {0}" -f $idStatus.PortraitId)
                Write-Host "Rename the canonical PNG to the correct _<xeno>_ abbreviation, or leave the registered portrait as-is."
                exit 2
            }
        }

        # Ensure assets/source has the same canonical file (copy only if missing).
        if (-not (Test-Path -LiteralPath $chosen.AssetsPath)) {
            Copy-Item -LiteralPath $chosen.ImgHerePath -Destination $chosen.AssetsPath -Force
        }

        $global:STELLAR_DOGOS_LAST_CANONICAL_NAME = $canonicalName
        $global:STELLAR_DOGOS_LAST_DISPLAY_NAME = $displayName
        $global:STELLAR_DOGOS_LAST_XENOTYPE_ID = $xeno.Id
    }

    $canonicalRel = Join-Path "assets\source" $canonicalName
    $canonicalPath = Join-Path $assetsSource $canonicalName

    if (-not (Test-Path -LiteralPath $canonicalPath)) {
        throw ("Prepared portrait image missing: {0}" -f $canonicalPath)
    }

    # Lock the candidate for this invocation — do not re-discover / switch mid-run.
    $lockedCanonicalName = $canonicalName
    $lockedCanonicalPath = (Resolve-Path -LiteralPath $canonicalPath).Path

    $m = [regex]::Match($lockedCanonicalName.ToLowerInvariant(), $CanonicalPattern)
    if (-not $m.Success) {
        throw ("Unexpected prepared filename (expected dogNN_name_xeno_stellaris.png): {0}" -f $lockedCanonicalName)
    }
    $slug = $m.Groups[2].Value
    $xenoAbbr = $m.Groups[3].Value
    if ([string]::IsNullOrWhiteSpace($displayName)) {
        $displayName = (Get-Culture).TextInfo.ToTitleCase($slug.Replace('_', ' '))
    }
    $portraitId = Resolve-PortraitIdFromSlug -Slug $slug
    $ddsName = "$portraitId.dds"
    $ddsPath = Join-Path $ddsDir $ddsName

    if ($null -eq $xeno) {
        throw "Species type was not resolved for this portrait."
    }
    if ($xeno.FilenameAbbr -ne $xenoAbbr) {
        throw ("Filename xenotype '{0}' does not match selected species type '{1}'." -f $xenoAbbr, $xeno.DisplayName)
    }
    $speciesLabel = $xeno.DisplayName

    # Same-file guard before mutating game assets.
    if ($lockedCanonicalName -ne $global:STELLAR_DOGOS_LAST_CANONICAL_NAME) {
        throw ("Candidate switched mid-run (expected {0}, now {1}). Aborting." -f $lockedCanonicalName, $global:STELLAR_DOGOS_LAST_CANONICAL_NAME)
    }
    if (-not (Test-Path -LiteralPath $lockedCanonicalPath)) {
        throw ("Locked candidate file disappeared: {0}" -f $lockedCanonicalPath)
    }

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

    if ($lockedCanonicalName -ne $global:STELLAR_DOGOS_LAST_CANONICAL_NAME) {
        throw ("Candidate switched before registration (expected {0}). Aborting." -f $lockedCanonicalName)
    }

    $regRel = Join-Path $modPaths.DdsRelPrefix $ddsName
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

    $validation = Test-SdPortraitRegistration -RepoRoot $repoRoot
    if (-not $validation.Ok) {
        Write-Host ""
        Write-Host "Portrait files were written, but registration validation reported errors:"
        foreach ($e in $validation.Errors) { Write-Host ("  - {0}" -f $e) }
        exit 3
    }

    Write-Host ""
    $check = [char]0x2713
    Write-Host ("{0} Portrait created successfully!" -f $check)
    Write-Host ("Name: {0}" -f $displayName)
    Write-Host ("Species type: {0}" -f $speciesLabel)
    Write-Host ""
    Write-Host "Your portrait is now ready to use in Stellaris."
    Write-Host ""
    Write-Host "Technical details:"
    Write-Host ("  Portrait ID: {0}" -f $portraitId)
    Write-Host ("  Source: {0}" -f $lockedCanonicalPath)
    Write-Host ("  DDS: {0}" -f $ddsPath)
    if ($fromPendingCanon) {
        Write-Host ("  Note: finished an already-named pending portrait ({0})." -f $lockedCanonicalName)
    }
    exit 0
} finally {
    Remove-Item Env:\STELLAR_DOGOS_PIPELINE -ErrorAction SilentlyContinue
}
