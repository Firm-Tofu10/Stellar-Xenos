# Shared path ownership for Stellar Xeno tools.
# Canonical production Stellaris mod output: mod/stellar_dogos/
# Experiment copy remains at experiment/sd_static_portrait_test/ as regression/reference.

# Captured when this file is dot-sourced (not when a caller later invokes helpers).
$script:SdPathsScriptDir = Split-Path -Parent $PSCommandPath

function Get-SdToolsDir {
    return $script:SdPathsScriptDir
}

function Get-SdRepoRoot {
    return (Resolve-Path (Join-Path (Get-SdToolsDir) "..")).Path
}

function Get-SdProductionModRelativePath {
    return "mod\stellar_dogos"
}

function Get-SdExperimentModRelativePath {
    # Intentional reference/regression path — not the production write target.
    return "experiment\sd_static_portrait_test"
}

function Get-SdModRoot {
    param(
        [string]$RepoRoot = "",
        # Production is the canonical output. Experiment is reference-only.
        [ValidateSet("Production", "Experiment")]
        [string]$Which = "Production"
    )

    if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
        $RepoRoot = Get-SdRepoRoot
    }

    $rel = if ($Which -eq "Production") {
        Get-SdProductionModRelativePath
    } else {
        Get-SdExperimentModRelativePath
    }

    return (Join-Path $RepoRoot $rel)
}

function Get-SdModPaths {
    param(
        [string]$RepoRoot = "",
        [ValidateSet("Production", "Experiment")]
        [string]$Which = "Production"
    )

    if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
        $RepoRoot = Get-SdRepoRoot
    }

    $rel = if ($Which -eq "Production") {
        Get-SdProductionModRelativePath
    } else {
        Get-SdExperimentModRelativePath
    }

    $root = Join-Path $RepoRoot $rel
    return [PSCustomObject]@{
        Which        = $Which
        ModRoot      = $root
        DdsDir       = Join-Path $root "gfx\models\portraits\sd_static_test"
        PortraitsTxt = Join-Path $root "gfx\portraits\portraits\00_sd_static_test_portraits.txt"
        SetTxt       = Join-Path $root "common\portrait_sets\00_sd_static_test_portrait_sets.txt"
        CategoryTxt  = Join-Path $root "common\portrait_categories\zzz_sd_static_test_portrait_categories.txt"
        Descriptor   = Join-Path $root "descriptor.mod"
        DdsRelPrefix = (Join-Path $rel "gfx\models\portraits\sd_static_test")
    }
}

function Get-SdRegisteredPortraitIds {
    param(
        [string]$PortraitsTxt = ""
    )

    if ([string]::IsNullOrWhiteSpace($PortraitsTxt)) {
        $PortraitsTxt = (Get-SdModPaths -Which Production).PortraitsTxt
    }

    if (-not (Test-Path -LiteralPath $PortraitsTxt)) {
        throw ("Portrait definitions missing: {0}" -f $PortraitsTxt)
    }

    $text = [IO.File]::ReadAllText($PortraitsTxt)
    $ids = New-Object System.Collections.Generic.List[string]
    foreach ($m in [regex]::Matches($text, '(?m)^\s*(sd_dog_[A-Za-z0-9_]+)\s*=')) {
        $id = $m.Groups[1].Value
        if (-not $ids.Contains($id)) { [void]$ids.Add($id) }
    }
    return @($ids)
}

function Get-SdProtectedPortraitIds {
    param(
        [string]$PortraitsTxt = ""
    )
    # Protect every currently registered portrait ID (including Maple).
    return @(Get-SdRegisteredPortraitIds -PortraitsTxt $PortraitsTxt)
}

function Get-SdProtectedDdsFileNames {
    param(
        [string]$PortraitsTxt = ""
    )
    return @(Get-SdProtectedPortraitIds -PortraitsTxt $PortraitsTxt | ForEach-Object { "$_.dds" })
}

function Resolve-SdPortraitIdFromSlug {
    param([string]$Slug)

    if ([string]::IsNullOrWhiteSpace($Slug)) { return $null }
    $lower = $Slug.Trim().ToLowerInvariant()
    # Historical Oakley portrait ID / DDS is sd_dog_02 (not sd_dog_oakley).
    if ($lower -eq "oakley") { return "sd_dog_02" }
    return ("sd_dog_{0}" -f $lower)
}

function Get-SdPortraitIdentityStatus {
    <#
      Returns whether a character slug already has a registered definition and/or DDS.
      Case-insensitive slug. Does not modify anything.
    #>
    param(
        [string]$Slug,
        [string]$RepoRoot = ""
    )

    if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
        $RepoRoot = Get-SdRepoRoot
    }

    $paths = Get-SdModPaths -RepoRoot $RepoRoot -Which Production
    $portraitId = Resolve-SdPortraitIdFromSlug -Slug $Slug
    if ([string]::IsNullOrWhiteSpace($portraitId)) {
        return [PSCustomObject]@{
            Slug         = $Slug
            PortraitId   = $null
            Registered   = $false
            DdsExists    = $false
            DdsPath      = $null
            AlreadyExists = $false
        }
    }

    $registered = (@(Get-SdRegisteredPortraitIds -PortraitsTxt $paths.PortraitsTxt) -contains $portraitId)
    $ddsPath = Join-Path $paths.DdsDir ($portraitId + ".dds")
    $ddsExists = Test-Path -LiteralPath $ddsPath

    return [PSCustomObject]@{
        Slug          = $Slug.ToLowerInvariant()
        PortraitId    = $portraitId
        Registered    = $registered
        DdsExists     = $ddsExists
        DdsPath       = $ddsPath
        AlreadyExists = ($registered -or $ddsExists)
    }
}
