# Stellar Xeno — Portrait registration validator
# Detects duplicate set membership, cross-category conflicts, missing DDS,
# filename xenotype mismatches, and identical DDS shared by different IDs.
#
# Usage:
#   powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-validate.ps1
# Or dot-source and call: Test-SdPortraitRegistration -ThrowOnError

[CmdletBinding()]
param(
    [switch]$ThrowOnError
)

$ErrorActionPreference = "Stop"

. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-paths.ps1")
. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-xenotypes.ps1")

function Get-SdSetSpeciesClassMap {
    param([string]$SetTxt)

    $map = @{}
    $text = [IO.File]::ReadAllText($SetTxt)
    foreach ($m in [regex]::Matches($text, '(?ms)^([A-Za-z0-9_]+)\s*=\s*\{.*?species_class\s*=\s*([A-Za-z0-9_]+)')) {
        $map[$m.Groups[1].Value] = $m.Groups[2].Value
    }
    return $map
}

function Get-SdPortraitSetMembershipDetailed {
    param([string]$SetTxt)

    $text = [IO.File]::ReadAllText($SetTxt)
    $membership = @{} # id -> array of membership records

    $setRx = [regex]'(?m)^([A-Za-z0-9_]+)\s*=\s*\{'
    foreach ($sm in $setRx.Matches($text)) {
        $setName = $sm.Groups[1].Value
        if ($setName -eq "portraits" -or $setName -eq "non_randomized_portraits") { continue }

        $openIdx = $text.IndexOf('{', $sm.Index)
        $depth = 0
        $end = $openIdx
        for ($i = $openIdx; $i -lt $text.Length; $i++) {
            if ($text[$i] -eq '{') { $depth++ }
            elseif ($text[$i] -eq '}') {
                $depth--
                if ($depth -eq 0) { $end = $i; break }
            }
        }
        $body = $text.Substring($openIdx + 1, $end - $openIdx - 1)
        $sc = [regex]::Match($body, 'species_class\s*=\s*([A-Za-z0-9_]+)')
        $speciesClass = if ($sc.Success) { $sc.Groups[1].Value } else { "?" }

        $pBlock = [regex]::Match($body, '(?ms)portraits\s*=\s*\{(.*?)\}')
        $nBlock = [regex]::Match($body, '(?ms)non_randomized_portraits\s*=\s*\{(.*?)\}')

        function Count-IdInBlock([string]$BlockText, [string]$Id) {
            if ([string]::IsNullOrEmpty($BlockText)) { return 0 }
            return ([regex]::Matches($BlockText, ('"{0}"' -f [regex]::Escape($Id)))).Count
        }

        $pText = if ($pBlock.Success) { $pBlock.Groups[1].Value } else { "" }
        $nText = if ($nBlock.Success) { $nBlock.Groups[1].Value } else { "" }

        $ids = @{}
        foreach ($im in [regex]::Matches(($pText + "`n" + $nText), '"((?:sd_dog_)[^"]+)"')) {
            $ids[$im.Groups[1].Value] = $true
        }

        foreach ($id in @($ids.Keys)) {
            $pc = Count-IdInBlock $pText $id
            $nc = Count-IdInBlock $nText $id
            $rec = [PSCustomObject]@{
                Set            = $setName
                SpeciesClass   = $speciesClass
                PortraitsCount = $pc
                NonRandomCount = $nc
            }
            if (-not $membership.ContainsKey($id)) {
                $membership[$id] = @($rec)
            } else {
                $membership[$id] = @($membership[$id] + $rec)
            }
        }
    }

    return $membership
}

function Test-SdPortraitRegistration {
    param(
        [string]$RepoRoot = "",
        [switch]$ThrowOnError
    )

    if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
        $RepoRoot = Get-SdRepoRoot
    }

    $paths = Get-SdModPaths -RepoRoot $RepoRoot -Which Production
    $errors = New-Object System.Collections.Generic.List[string]
    $warnings = New-Object System.Collections.Generic.List[string]

    $ids = @(Get-SdRegisteredPortraitIds -PortraitsTxt $paths.PortraitsTxt)
    $defText = [IO.File]::ReadAllText($paths.PortraitsTxt)
    $membership = Get-SdPortraitSetMembershipDetailed -SetTxt $paths.SetTxt
    $catalog = @(Get-PortraitXenotypeCatalog)
    $classToXeno = @{}
    foreach ($x in $catalog) {
        $classToXeno[$x.SpeciesClass] = $x
    }

    # Missing DDS / texturefile
    foreach ($id in $ids) {
        $ddsPath = Join-Path $paths.DdsDir ($id + ".dds")
        if (-not (Test-Path -LiteralPath $ddsPath)) {
            [void]$errors.Add(("Missing DDS for registered portrait '{0}': {1}" -f $id, $ddsPath))
        }

        $tm = [regex]::Match($defText, ('(?ms)^\s*{0}\s*=\s*\{{.*?texturefile\s*=\s*"([^"]+)"' -f [regex]::Escape($id)))
        if ($tm.Success) {
            $texRel = $tm.Groups[1].Value -replace '/', '\'
            $texFull = Join-Path $paths.ModRoot $texRel
            if (-not (Test-Path -LiteralPath $texFull)) {
                [void]$errors.Add(("Portrait '{0}' texturefile missing on disk: {1}" -f $id, $tm.Groups[1].Value))
            }
            $expected = ("gfx/models/portraits/sd_static_test/{0}.dds" -f $id)
            if ($tm.Groups[1].Value -replace '\\', '/' -ne $expected) {
                [void]$warnings.Add(("Portrait '{0}' texturefile '{1}' does not match expected '{2}'." -f $id, $tm.Groups[1].Value, $expected))
            }
        } else {
            [void]$errors.Add(("Registered id '{0}' has no parseable texturefile in definitions." -f $id))
        }
    }

    # Set membership: exactly one mod set; no duplicate listings inside a set
    foreach ($id in $ids) {
        if (-not $membership.ContainsKey($id)) {
            [void]$errors.Add(("Portrait '{0}' is defined but not listed in any portrait set." -f $id))
            continue
        }
        $entries = @($membership[$id])
        if ($entries.Count -gt 1) {
            $sets = ($entries | ForEach-Object { "{0}({1})" -f $_.Set, $_.SpeciesClass }) -join ", "
            [void]$errors.Add(("Portrait '{0}' is registered in multiple sets/categories: {1}" -f $id, $sets))
        }
        foreach ($e in $entries) {
            if ($e.PortraitsCount -gt 1) {
                [void]$errors.Add(("Portrait '{0}' listed {1} times in portraits{{}} of set '{2}'." -f $id, $e.PortraitsCount, $e.Set))
            }
            if ($e.NonRandomCount -gt 1) {
                [void]$errors.Add(("Portrait '{0}' listed {1} times in non_randomized_portraits{{}} of set '{2}'." -f $id, $e.NonRandomCount, $e.Set))
            }
            if ($e.PortraitsCount -eq 0) {
                [void]$errors.Add(("Portrait '{0}' missing from portraits{{}} in set '{1}'." -f $id, $e.Set))
            }
            if ($e.NonRandomCount -eq 0) {
                [void]$warnings.Add(("Portrait '{0}' missing from non_randomized_portraits{{}} in set '{1}'." -f $id, $e.Set))
            }
        }
    }

    # Orphan set membership (in set but not defined)
    foreach ($id in $membership.Keys) {
        if ($ids -notcontains $id) {
            [void]$errors.Add(("Portrait '{0}' appears in a set but has no definition." -f $id))
        }
    }

    # Filename xenotype vs registered set (assets/source + ImgHERE canons)
    $canonRx = [regex]'^dog(\d+)_(.+)_([a-z]{3})_stellaris\.png$'
    foreach ($dirName in @("assets\source", "ImgHERE")) {
        $dir = Join-Path $RepoRoot $dirName
        if (-not (Test-Path -LiteralPath $dir)) { continue }
        Get-ChildItem -LiteralPath $dir -File -Filter "*.png" | ForEach-Object {
            $m = $canonRx.Match($_.Name.ToLowerInvariant())
            if (-not $m.Success) { return }
            $slug = $m.Groups[2].Value
            $abbr = $m.Groups[3].Value
            $portraitId = Resolve-SdPortraitIdFromSlug -Slug $slug
            if ($ids -notcontains $portraitId) { return }
            if (-not $membership.ContainsKey($portraitId)) { return }
            $setClass = $membership[$portraitId][0].SpeciesClass
            $xeno = $null
            foreach ($c in $catalog) {
                if ($c.FilenameAbbr -eq $abbr) { $xeno = $c; break }
            }
            if ($null -eq $xeno) {
                [void]$warnings.Add(("Canonical file '{0}' has unknown xenotype abbr '{1}'." -f $_.Name, $abbr))
                return
            }
            if ($xeno.SpeciesClass -ne $setClass) {
                [void]$errors.Add(("Filename/category mismatch: '{0}' implies {1} ({2}) but '{3}' is registered under species_class {4}." -f $_.Name, $xeno.DisplayName, $abbr, $portraitId, $setClass))
            }
        }
    }

    # Identical DDS bytes used by different portrait IDs (causes lookalike cross-category UI confusion)
    $byHash = @{}
    Get-ChildItem -LiteralPath $paths.DdsDir -Filter "sd_dog_*.dds" -File -ErrorAction SilentlyContinue | ForEach-Object {
        $h = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash
        if (-not $byHash.ContainsKey($h)) {
            $byHash[$h] = New-Object System.Collections.Generic.List[string]
        }
        [void]$byHash[$h].Add($_.BaseName)
    }
    foreach ($h in $byHash.Keys) {
        $group = @($byHash[$h] | Sort-Object)
        if ($group.Count -gt 1) {
            [void]$warnings.Add(("Identical DDS bytes shared by: {0}. In-game these portraits look the same across categories." -f ($group -join ", ")))
        }
    }

    return [PSCustomObject]@{
        Ok       = ($errors.Count -eq 0)
        Errors   = @($errors)
        Warnings = @($warnings)
        PortraitCount = $ids.Count
    }
}

function Write-SdPortraitValidationReport {
    param($Result)

    Write-Host "Stellar Xeno - Portrait Registration Validation"
    Write-Host ("Portraits checked: {0}" -f $Result.PortraitCount)
    Write-Host ""
    if ($Result.Errors.Count -eq 0) {
        Write-Host "Errors: none"
    } else {
        Write-Host ("Errors ({0}):" -f $Result.Errors.Count)
        foreach ($e in $Result.Errors) { Write-Host ("  - {0}" -f $e) }
    }
    Write-Host ""
    if ($Result.Warnings.Count -eq 0) {
        Write-Host "Warnings: none"
    } else {
        Write-Host ("Warnings ({0}):" -f $Result.Warnings.Count)
        foreach ($w in $Result.Warnings) { Write-Host ("  - {0}" -f $w) }
    }
}

# When executed directly (not dot-sourced), run validation.
$isDotSourced = $MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -match '^\s*\.'
if (-not $isDotSourced) {
    $result = Test-SdPortraitRegistration
    Write-SdPortraitValidationReport -Result $result
    if (-not $result.Ok) {
        if ($ThrowOnError) { throw "Portrait registration validation failed." }
        exit 1
    }
    exit 0
}
