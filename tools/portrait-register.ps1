# Stellar Dogos — Phase 5/7: Portrait Registration
# Registers an existing Phase 4 DDS into the production mod (mod/stellar_dogos):
#   portrait definition + xenotype portrait set + category exposure.
# Does not convert images or touch vanilla Stellaris.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Source,

    # Optional non-interactive xenotype (id, display name, or menu number).
    # When omitted, an interactive xenotype menu is shown.
    [string]$Xenotype = ""
)

$ErrorActionPreference = "Stop"

. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-exit.ps1")
. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-paths.ps1")

$DdsNamePattern = '^sd_dog_(.+)\.dds$'
# Populated after paths resolve (every currently registered ID, including Maple).
$ProtectedIds = @()

. (Join-Path (Split-Path -Parent $PSCommandPath) "portrait-xenotypes.ps1")

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

function Get-RepoRoot {
    return Get-SdRepoRoot
}

function Resolve-DdsPath {
    param(
        [string]$RepoRoot,
        [string]$SourceArg
    )

    if ([IO.Path]::IsPathRooted($SourceArg) -and (Test-Path -LiteralPath $SourceArg)) {
        return (Resolve-Path -LiteralPath $SourceArg).Path
    }

    $prod = Get-SdModPaths -RepoRoot $RepoRoot -Which Production
    $candidates = @(
        (Join-Path $RepoRoot $SourceArg),
        (Join-Path $prod.DdsDir $SourceArg),
        (Join-Path $prod.DdsDir ([IO.Path]::GetFileName($SourceArg)))
    )

    foreach ($c in $candidates) {
        if (Test-Path -LiteralPath $c) {
            return (Resolve-Path -LiteralPath $c).Path
        }
    }

    throw ("DDS not found: {0}" -f $SourceArg)
}

function Get-ExperimentPaths {
    # Compatibility alias — production is the canonical write target.
    param([string]$RepoRoot)
    return (Get-SdModPaths -RepoRoot $RepoRoot -Which Production)
}

# ---------------------------------------------------------------------------
# DDS validation
# ---------------------------------------------------------------------------

function Test-PortraitDdsFile {
    param([string]$Path)

    $bytes = [IO.File]::ReadAllBytes($Path)
    if ($bytes.Length -lt 128) { throw "DDS too small to be valid." }
    $magic = [Text.Encoding]::ASCII.GetString($bytes, 0, 4)
    if ($magic -ne "DDS ") { throw "Not a DDS file (bad magic)." }

    $height = [BitConverter]::ToUInt32($bytes, 12)
    $width = [BitConverter]::ToUInt32($bytes, 16)
    $pfFlags = [BitConverter]::ToUInt32($bytes, 80)
    $bpp = [BitConverter]::ToUInt32($bytes, 88)
    $pitch = [BitConverter]::ToUInt32($bytes, 20)
    $mips = [BitConverter]::ToUInt32($bytes, 28)

    if ($width -ne 256 -or $height -ne 256) {
        throw ("DDS must be 256x256 (got {0}x{1})." -f $width, $height)
    }
    if ($pfFlags -ne 0x41) {
        throw ("DDS pfFlags must be 0x41 (got 0x{0:X})." -f $pfFlags)
    }
    if ($bpp -ne 32) {
        throw ("DDS must be 32-bit (got {0})." -f $bpp)
    }
    if ($bytes.Length -ne 262272) {
        throw ("Unexpected DDS size {0} (expected 262272 uncompressed RGBA)." -f $bytes.Length)
    }

    $a0 = 0
    for ($y = 0; $y -lt 256; $y += 8) {
        for ($x = 0; $x -lt 256; $x += 8) {
            if ($bytes[128 + (($y * 256) + $x) * 4 + 3] -eq 0) { $a0++ }
        }
    }

    return [PSCustomObject]@{
        Width    = $width
        Height   = $height
        PfFlags  = $pfFlags
        Bpp      = $bpp
        Pitch    = $pitch
        Mips     = $mips
        Length   = $bytes.Length
        SampleA0 = $a0
    }
}

function Get-PortraitIdFromDdsName {
    param([string]$FileName)

    $m = [regex]::Match($FileName.ToLowerInvariant(), $DdsNamePattern)
    if (-not $m.Success) {
        throw ("DDS filename must match sd_dog_<name>.dds (got '{0}')." -f $FileName)
    }
    $slug = $m.Groups[1].Value
    if ([string]::IsNullOrWhiteSpace($slug)) {
        throw "DDS filename has empty portrait name slug."
    }
    return "sd_dog_$slug"
}

# ---------------------------------------------------------------------------
# Parse existing registration
# ---------------------------------------------------------------------------

function Get-PortraitDefinitionIds {
    param([string]$Text)

    $ids = New-Object System.Collections.Generic.List[string]
    foreach ($m in [regex]::Matches($Text, '(?m)^\s*(sd_dog_[A-Za-z0-9_]+)\s*=')) {
        [void]$ids.Add($m.Groups[1].Value)
    }
    return @($ids)
}

function Get-PortraitBlockField {
    param(
        [string]$Text,
        [string]$PortraitId,
        [string]$FieldName
    )

    $pattern = '(?ms)^\s*' + [regex]::Escape($PortraitId) + '\s*=\s*\{(.*?)^\s*\}'
    $m = [regex]::Match($Text, $pattern)
    if (-not $m.Success) { return $null }

    $fm = [regex]::Match($m.Groups[1].Value, [regex]::Escape($FieldName) + '\s*=\s*"([^"]+)"')
    if (-not $fm.Success) { return $null }
    return $fm.Groups[1].Value
}

function Get-PortraitTexturefile {
    param([string]$Text, [string]$PortraitId)
    return Get-PortraitBlockField -Text $Text -PortraitId $PortraitId -FieldName "texturefile"
}

function Get-PortraitGreeting {
    param([string]$Text, [string]$PortraitId)
    return Get-PortraitBlockField -Text $Text -PortraitId $PortraitId -FieldName "greeting_sound"
}

function Get-BraceBlockBody {
    param(
        [string]$Text,
        [int]$OpenBraceIndex
    )

    $depth = 0
    for ($i = $OpenBraceIndex; $i -lt $Text.Length; $i++) {
        $ch = $Text[$i]
        if ($ch -eq '{') { $depth++ }
        elseif ($ch -eq '}') {
            $depth--
            if ($depth -eq 0) {
                $start = $OpenBraceIndex + 1
                $len = $i - $start
                return [PSCustomObject]@{
                    Body      = $Text.Substring($start, $len)
                    EndIndex  = $i
                }
            }
        }
    }
    throw "Unbalanced braces while parsing registration file."
}

function Get-AllPortraitSets {
    param([string]$Text)

    $sets = [ordered]@{}
    $rx = [regex]'(?m)^([A-Za-z0-9_]+)\s*=\s*\{'
    foreach ($m in $rx.Matches($Text)) {
        $name = $m.Groups[1].Value
        if ($name -eq "portraits" -or $name -eq "non_randomized_portraits") { continue }

        $openIdx = $Text.IndexOf('{', $m.Index)
        $parsed = Get-BraceBlockBody -Text $Text -OpenBraceIndex $openIdx
        $body = $parsed.Body

        $sc = [regex]::Match($body, 'species_class\s*=\s*([A-Za-z0-9_]+)')
        $species = if ($sc.Success) { $sc.Groups[1].Value } else { $null }

        $pOpen = [regex]::Match($body, '(?m)^\s*portraits\s*=\s*\{')
        $nOpen = [regex]::Match($body, '(?m)^\s*non_randomized_portraits\s*=\s*\{')

        $portraits = New-Object System.Collections.Generic.List[string]
        $nonRand = New-Object System.Collections.Generic.List[string]
        if ($pOpen.Success) {
            $pBody = (Get-BraceBlockBody -Text $body -OpenBraceIndex $body.IndexOf('{', $pOpen.Index)).Body
            foreach ($sm in [regex]::Matches($pBody, '"([^"]+)"')) { [void]$portraits.Add($sm.Groups[1].Value) }
        }
        if ($nOpen.Success) {
            $nBody = (Get-BraceBlockBody -Text $body -OpenBraceIndex $body.IndexOf('{', $nOpen.Index)).Body
            foreach ($sm in [regex]::Matches($nBody, '"([^"]+)"')) { [void]$nonRand.Add($sm.Groups[1].Value) }
        }

        $sets[$name] = [PSCustomObject]@{
            Name         = $name
            SpeciesClass = $species
            Portraits    = @($portraits)
            NonRandom    = @($nonRand)
        }
    }
    return $sets
}

function Find-PortraitSetMembership {
    param(
        [System.Collections.Specialized.OrderedDictionary]$Sets,
        [string]$PortraitId
    )

    $found = New-Object System.Collections.Generic.List[string]
    foreach ($name in $Sets.Keys) {
        $s = $Sets[$name]
        if (($s.Portraits -contains $PortraitId) -or ($s.NonRandom -contains $PortraitId)) {
            [void]$found.Add($name)
        }
    }
    return @($found)
}

function Get-AllCategories {
    param([string]$Text)

    $cats = [ordered]@{}
    $rx = [regex]'(?m)^([A-Za-z0-9_]+)\s*=\s*\{'
    foreach ($m in $rx.Matches($Text)) {
        $key = $m.Groups[1].Value
        $openIdx = $Text.IndexOf('{', $m.Index)
        $parsed = Get-BraceBlockBody -Text $Text -OpenBraceIndex $openIdx
        $body = $parsed.Body

        $nm = [regex]::Match($body, 'name\s*=\s*([A-Za-z0-9_]+)')
        $setsBlock = [regex]::Match($body, '(?ms)sets\s*=\s*\{(.*?)\}')
        $setList = New-Object System.Collections.Generic.List[string]
        if ($setsBlock.Success) {
            foreach ($line in ($setsBlock.Groups[1].Value -split "`r?`n")) {
                $t = $line.Trim()
                if ($t -match '^[A-Za-z0-9_]+$') { [void]$setList.Add($t) }
            }
        }
        $cats[$key] = [PSCustomObject]@{
            Key  = $key
            Name = $(if ($nm.Success) { $nm.Groups[1].Value } else { $null })
            Sets = @($setList)
        }
    }
    return $cats
}

# ---------------------------------------------------------------------------
# Writers
# ---------------------------------------------------------------------------

function Get-PortraitLabel {
    param([string]$PortraitId)
    switch ($PortraitId) {
        'sd_dog_piglet' { return 'Piglet' }
        'sd_dog_02'     { return 'Oakley' }
        'sd_dog_angus'  { return 'Angus' }
        'sd_dog_bruce'  { return 'Bruce' }
        'sd_dog_cedar'  { return 'Cedar' }
        default {
            $slug = ($PortraitId -replace '^sd_dog_', '')
            if ([string]::IsNullOrWhiteSpace($slug)) { return $PortraitId }
            return ($slug.Substring(0, 1).ToUpper() + $slug.Substring(1))
        }
    }
}

function Build-PortraitsFile {
    param(
        [string[]]$OrderedIds,
        [hashtable]$TextureById,
        [hashtable]$GreetingById
    )

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("##############################################################")
    [void]$sb.AppendLine("### Stellar Dogos - static portrait definitions")
    [void]$sb.AppendLine("###")
    [void]$sb.AppendLine("### Portraits:")
    foreach ($id in $OrderedIds) {
        [void]$sb.AppendLine(("###   {0} - {1}" -f $id, (Get-PortraitLabel -PortraitId $id)))
    }
    [void]$sb.AppendLine("##############################################################")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("portraits = {")

    for ($i = 0; $i -lt $OrderedIds.Count; $i++) {
        $id = $OrderedIds[$i]
        $tex = $TextureById[$id]
        $greet = $GreetingById[$id]
        if ([string]::IsNullOrWhiteSpace($greet)) { $greet = "mammalian_01_greetings" }

        [void]$sb.AppendLine("`t$id = {")
        [void]$sb.AppendLine("`t`tclothes_selector = `"no_texture`"")
        [void]$sb.AppendLine("`t`tattachment_selector = `"no_texture`"")
        [void]$sb.AppendLine("`t`tgreeting_sound = `"$greet`"")
        [void]$sb.AppendLine("`t`ttexturefile = `"$tex`"")
        [void]$sb.AppendLine("`t}")
        if ($i -lt $OrderedIds.Count - 1) { [void]$sb.AppendLine("") }
    }

    [void]$sb.AppendLine("}")
    return $sb.ToString()
}

function Build-SetsFile {
    param([System.Collections.Specialized.OrderedDictionary]$Sets)

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("##############################################################")
    [void]$sb.AppendLine("### Stellar Dogos - portrait sets")
    [void]$sb.AppendLine("###")
    [void]$sb.AppendLine("### Pattern from vanilla common/portrait_sets/00_portrait_sets.txt:")
    [void]$sb.AppendLine("### - species_class = CLASS")
    [void]$sb.AppendLine("### - portraits = { `"id`" }")
    [void]$sb.AppendLine("### - non_randomized_portraits so random AI empires avoid this art")
    [void]$sb.AppendLine("##############################################################")
    [void]$sb.AppendLine("")

    $names = @($Sets.Keys)
    for ($si = 0; $si -lt $names.Count; $si++) {
        $s = $Sets[$names[$si]]
        [void]$sb.AppendLine("$($s.Name) = {")
        [void]$sb.AppendLine("`tspecies_class = $($s.SpeciesClass)")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("`tportraits = {")
        foreach ($id in $s.Portraits) { [void]$sb.AppendLine("`t`t`"$id`"") }
        [void]$sb.AppendLine("`t}")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("`tnon_randomized_portraits = {")
        foreach ($id in $s.NonRandom) { [void]$sb.AppendLine("`t`t`"$id`"") }
        [void]$sb.AppendLine("`t}")
        [void]$sb.AppendLine("}")
        if ($si -lt $names.Count - 1) { [void]$sb.AppendLine("") }
    }

    return $sb.ToString()
}

function Build-CategoriesFile {
    param([System.Collections.Specialized.OrderedDictionary]$Categories)

    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("##############################################################")
    [void]$sb.AppendLine("### Stellar Dogos - portrait category overrides")
    [void]$sb.AppendLine("###")
    [void]$sb.AppendLine("### Each block REPLACES the vanilla category of the same key so")
    [void]$sb.AppendLine("### we can append one mod set with minimal change.")
    [void]$sb.AppendLine("### Vanilla set lists were copied from Stellaris 4.4.x.")
    [void]$sb.AppendLine("##############################################################")
    [void]$sb.AppendLine("")

    $keys = @($Categories.Keys)
    for ($ci = 0; $ci -lt $keys.Count; $ci++) {
        $c = $Categories[$keys[$ci]]
        [void]$sb.AppendLine("$($c.Key) = {")
        [void]$sb.AppendLine("`tname = $($c.Name)")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("`tsets = {")
        foreach ($setName in $c.Sets) {
            [void]$sb.AppendLine("`t`t$setName")
        }
        [void]$sb.AppendLine("`t}")
        [void]$sb.AppendLine("}")
        if ($ci -lt $keys.Count - 1) { [void]$sb.AppendLine("") }
    }

    return $sb.ToString()
}

function Write-TextAtomic {
    param(
        [string]$Path,
        [string]$Content
    )

    $tmp = $Path + ".partial"
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [IO.File]::WriteAllText($tmp, $Content, $utf8NoBom)
    Move-Item -LiteralPath $tmp -Destination $Path -Force
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

$repoRoot = Get-RepoRoot
$paths = Get-ExperimentPaths -RepoRoot $repoRoot

Write-SdHost "Stellar Dogos - Portrait Registration"
Write-SdHost ""

foreach ($required in @($paths.PortraitsTxt, $paths.SetTxt, $paths.CategoryTxt, $paths.DdsDir)) {
    if (-not (Test-Path -LiteralPath $required)) {
        throw ("Required path missing: {0}" -f $required)
    }
}

$ddsPath = Resolve-DdsPath -RepoRoot $repoRoot -SourceArg $Source
$ddsName = [IO.Path]::GetFileName($ddsPath)
$portraitId = Get-PortraitIdFromDdsName -FileName $ddsName
$displayName = ($portraitId -replace '^sd_dog_', '')
# Title-case for player-facing messages
$displayPretty = (Get-Culture).TextInfo.ToTitleCase($displayName.Replace('_', ' '))
$textureRel = "gfx/models/portraits/sd_static_test/$ddsName"

Write-SdHost ("Portrait: {0}" -f $displayPretty)
Write-SdHost ""

$ddsInfo = Test-PortraitDdsFile -Path $ddsPath

# Resolve xenotype (interactive unless provided)
if ([string]::IsNullOrWhiteSpace($Xenotype)) {
    $xeno = Read-PortraitXenotypeInteractive -PortraitDisplayName $displayPretty
} else {
    $xeno = Resolve-PortraitXenotype -Selection $Xenotype
    if ($null -eq $xeno) {
        Write-Host "That species type was not recognized."
        Write-Host "Please choose one of:"
        $i = 1
        foreach ($c in (Get-PortraitXenotypeCatalog)) {
            Write-Host ("  {0}. {1}" -f $i, $c.DisplayName)
            $i++
        }
        Exit-SdTool 2
        return
    }
}

if (-not (Test-SdPipelineMode)) {
    Write-Host ""
    Write-Host ("Registering as {0}..." -f $xeno.DisplayName)
    Write-Host ""
}
# Protect every currently registered portrait (IDs + DDS hashes), including Maple.
$ProtectedIds = @(Get-SdProtectedPortraitIds -PortraitsTxt $paths.PortraitsTxt)
$protectedDds = @{}
foreach ($k in (Get-SdProtectedDdsFileNames -PortraitsTxt $paths.PortraitsTxt)) {
    $protectedDds[$k] = $null
}
foreach ($k in @($protectedDds.Keys)) {
    $p = Join-Path $paths.DdsDir $k
    if (Test-Path -LiteralPath $p) {
        $protectedDds[$k] = (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash
    }
}

$portraitsText = [IO.File]::ReadAllText($paths.PortraitsTxt)
$setText = [IO.File]::ReadAllText($paths.SetTxt)
$categoryText = [IO.File]::ReadAllText($paths.CategoryTxt)

$defIds = Get-PortraitDefinitionIds -Text $portraitsText
$sets = Get-AllPortraitSets -Text $setText
$categories = Get-AllCategories -Text $categoryText

# Snapshot mammalian set membership before any mutation (regression guard)
$mamSetBefore = $null
if ($sets.Contains("sd_static_test")) {
    $mamSetBefore = [PSCustomObject]@{
        Portraits = @($sets["sd_static_test"].Portraits)
        NonRandom = @($sets["sd_static_test"].NonRandom)
    }
}

$existingTexture = Get-PortraitTexturefile -Text $portraitsText -PortraitId $portraitId
$existingGreeting = Get-PortraitGreeting -Text $portraitsText -PortraitId $portraitId
$membership = @(Find-PortraitSetMembership -Sets $sets -PortraitId $portraitId)

$inDef = $defIds -contains $portraitId
$inTargetSet = $false
if ($sets.Contains($xeno.SetName)) {
    $target = $sets[$xeno.SetName]
    $inTargetSet = (@($target.Portraits) -contains $portraitId) -and (@($target.NonRandom) -contains $portraitId)
}

# Idempotency / conflict
if ($inDef -or $membership.Count -gt 0) {
    $sameTexture = ($existingTexture -eq $textureRel)
    $sameGreeting = ($existingGreeting -eq $xeno.GreetingSound)
    $onlyTarget = ($membership.Count -eq 1 -and $membership[0] -eq $xeno.SetName -and $inTargetSet)

    if ($inDef -and $sameTexture -and $sameGreeting -and $onlyTarget) {
        Write-Host "This portrait is already registered."
        Write-Host ("  Name: {0}" -f $displayPretty)
        Write-Host ("  Species type: {0}" -f $xeno.DisplayName)
        Write-Host "No changes were made."
        Exit-SdTool 0
        return
    }

    Write-Host "This portrait is already registered differently."
    Write-Host "To protect your existing portraits, nothing was changed."
    Write-Host ("  Portrait: {0}" -f $portraitId)
    Write-Host ("  Existing species set(s): {0}" -f $(if ($membership.Count -eq 0) { "(none)" } else { ($membership -join ", ") }))
    Write-Host ("  Requested species type: {0}" -f $xeno.DisplayName)
    Exit-SdTool 2
    return
}

if ($ProtectedIds -contains $portraitId) {
    throw ("Refusing to modify protected portrait ID '{0}'." -f $portraitId)
}

# --- Portrait definitions (preserve existing greetings/textures) ---
$textureMap = @{}
$greetingMap = @{}
foreach ($id in $defIds) {
    $textureMap[$id] = Get-PortraitTexturefile -Text $portraitsText -PortraitId $id
    $g = Get-PortraitGreeting -Text $portraitsText -PortraitId $id
    if ([string]::IsNullOrWhiteSpace($g)) { $g = "mammalian_01_greetings" }
    $greetingMap[$id] = $g
}
$orderedIds = @($defIds)
if ($orderedIds -notcontains $portraitId) { $orderedIds += $portraitId }
$textureMap[$portraitId] = $textureRel
$greetingMap[$portraitId] = $xeno.GreetingSound

$newPortraits = Build-PortraitsFile -OrderedIds $orderedIds -TextureById $textureMap -GreetingById $greetingMap

# --- Portrait set for selected xenotype (create or append; preserve others) ---
if (-not $sets.Contains($xeno.SetName)) {
    $sets[$xeno.SetName] = [PSCustomObject]@{
        Name         = $xeno.SetName
        SpeciesClass = $xeno.SpeciesClass
        Portraits    = @()
        NonRandom    = @()
    }
} else {
    $existingSet = $sets[$xeno.SetName]
    if ($existingSet.SpeciesClass -ne $xeno.SpeciesClass) {
        throw ("Set '{0}' species_class is '{1}' but xenotype requires '{2}'." -f $xeno.SetName, $existingSet.SpeciesClass, $xeno.SpeciesClass)
    }
}

$targetSet = $sets[$xeno.SetName]
$newPortraitsList = @($targetSet.Portraits)
$newNonRandList = @($targetSet.NonRandom)
if ($newPortraitsList -notcontains $portraitId) { $newPortraitsList += $portraitId }
if ($newNonRandList -notcontains $portraitId) { $newNonRandList += $portraitId }
$sets[$xeno.SetName] = [PSCustomObject]@{
    Name         = $xeno.SetName
    SpeciesClass = $xeno.SpeciesClass
    Portraits    = $newPortraitsList
    NonRandom    = $newNonRandList
}

# Ensure historical mammalian set still exists if it was present
if (-not $sets.Contains("sd_static_test") -and $setText -match 'sd_static_test\s*=') {
    throw "Internal error: existing sd_static_test set disappeared during parse."
}

$newSetText = Build-SetsFile -Sets $sets

# --- Category: ensure selected category exposes the set; leave others alone ---
if (-not $categories.Contains($xeno.CategoryKey)) {
    $categories[$xeno.CategoryKey] = [PSCustomObject]@{
        Key  = $xeno.CategoryKey
        Name = $xeno.SpeciesClass
        Sets = @($xeno.VanillaSets + $xeno.SetName)
    }
} else {
    $cat = $categories[$xeno.CategoryKey]
    if ($cat.Name -ne $xeno.SpeciesClass) {
        throw ("Category '{0}' name is '{1}' but xenotype requires '{2}'." -f $xeno.CategoryKey, $cat.Name, $xeno.SpeciesClass)
    }
    $catSets = @($cat.Sets)
    if ($catSets -notcontains $xeno.SetName) {
        $catSets += $xeno.SetName
    }
    $categories[$xeno.CategoryKey] = [PSCustomObject]@{
        Key  = $cat.Key
        Name = $cat.Name
        Sets = $catSets
    }
}

$newCategoryText = Build-CategoriesFile -Categories $categories

# Validate in-memory before write
$vDef = Get-PortraitDefinitionIds -Text $newPortraits
$vTex = Get-PortraitTexturefile -Text $newPortraits -PortraitId $portraitId
$vGreet = Get-PortraitGreeting -Text $newPortraits -PortraitId $portraitId
$vSets = Get-AllPortraitSets -Text $newSetText
$vCats = Get-AllCategories -Text $newCategoryText

if (($vDef | Where-Object { $_ -eq $portraitId }).Count -ne 1) {
    throw "Validation failed: portrait definition count for new ID is not exactly 1."
}
if ($vTex -ne $textureRel) { throw "Validation failed: texturefile mismatch after edit." }
if ($vGreet -ne $xeno.GreetingSound) { throw "Validation failed: greeting_sound mismatch after edit." }
if (-not $vSets.Contains($xeno.SetName)) { throw "Validation failed: target set missing." }
$vs = $vSets[$xeno.SetName]
if (($vs.Portraits | Where-Object { $_ -eq $portraitId }).Count -ne 1) { throw "Validation failed: set portraits count invalid." }
if (($vs.NonRandom | Where-Object { $_ -eq $portraitId }).Count -ne 1) { throw "Validation failed: non_randomized count invalid." }
if ($vs.SpeciesClass -ne $xeno.SpeciesClass) { throw "Validation failed: species_class mismatch." }
if (-not $vCats.Contains($xeno.CategoryKey)) { throw "Validation failed: category missing." }
if ($vCats[$xeno.CategoryKey].Sets -notcontains $xeno.SetName) { throw "Validation failed: category does not expose set." }

# Preserve protected IDs / mammalian set contents
foreach ($protId in $ProtectedIds) {
    if ($defIds -contains $protId) {
        if (-not ($vDef -contains $protId)) {
            throw ("Validation failed: protected ID '{0}' missing from definitions." -f $protId)
        }
        $oldTex = Get-PortraitTexturefile -Text $portraitsText -PortraitId $protId
        $newTex = Get-PortraitTexturefile -Text $newPortraits -PortraitId $protId
        if ($oldTex -ne $newTex) {
            throw ("Validation failed: protected ID '{0}' texturefile changed." -f $protId)
        }
        $oldG = Get-PortraitGreeting -Text $portraitsText -PortraitId $protId
        $newG = Get-PortraitGreeting -Text $newPortraits -PortraitId $protId
        if ($oldG -ne $newG) {
            throw ("Validation failed: protected ID '{0}' greeting_sound changed." -f $protId)
        }
    }
}

if ($null -ne $mamSetBefore -and $vSets.Contains("sd_static_test") -and $xeno.SetName -ne "sd_static_test") {
    $newMam = $vSets["sd_static_test"]
    if (($mamSetBefore.Portraits -join ",") -ne ($newMam.Portraits -join ",")) {
        throw "Validation failed: mammalian sd_static_test portraits changed unexpectedly."
    }
    if (($mamSetBefore.NonRandom -join ",") -ne ($newMam.NonRandom -join ",")) {
        throw "Validation failed: mammalian sd_static_test non_randomized changed unexpectedly."
    }
}

Write-TextAtomic -Path $paths.PortraitsTxt -Content $newPortraits
Write-TextAtomic -Path $paths.SetTxt -Content $newSetText
Write-TextAtomic -Path $paths.CategoryTxt -Content $newCategoryText

# Post-write validation
$portraitsAfter = [IO.File]::ReadAllText($paths.PortraitsTxt)
$setAfter = [IO.File]::ReadAllText($paths.SetTxt)
$catAfter = [IO.File]::ReadAllText($paths.CategoryTxt)
$postSets = Get-AllPortraitSets -Text $setAfter
$postCats = Get-AllCategories -Text $catAfter

$postDef = Get-PortraitDefinitionIds -Text $portraitsAfter
$postTex = Get-PortraitTexturefile -Text $portraitsAfter -PortraitId $portraitId
$postGreet = Get-PortraitGreeting -Text $portraitsAfter -PortraitId $portraitId

if (($postDef | Where-Object { $_ -eq $portraitId }).Count -ne 1) { throw "Post-write: definition count invalid." }
if ($postTex -ne $textureRel) { throw "Post-write: texturefile invalid." }
if ($postGreet -ne $xeno.GreetingSound) { throw "Post-write: greeting invalid." }
if (-not $postSets.Contains($xeno.SetName)) { throw "Post-write: set missing." }
if ($postSets[$xeno.SetName].Portraits -notcontains $portraitId) { throw "Post-write: set portraits invalid." }
if ($postSets[$xeno.SetName].NonRandom -notcontains $portraitId) { throw "Post-write: non_randomized invalid." }
if ($postCats[$xeno.CategoryKey].Sets -notcontains $xeno.SetName) { throw "Post-write: category missing set." }

if (-not (Test-SdPipelineMode)) {
    Write-Host ""
    Write-Host "Registration complete."
    Write-Host ("  Name: {0}" -f $displayPretty)
    Write-Host ("  Species type: {0}" -f $xeno.DisplayName)
    Write-Host ""
    Write-Host "Technical details:"
    Write-Host ("  Portrait ID: {0}" -f $portraitId)
    Write-Host ("  DDS: {0}" -f $ddsPath)
}

foreach ($k in ($protectedDds.Keys | Sort-Object)) {
    if ($null -eq $protectedDds[$k]) { continue }
    $p = Join-Path $paths.DdsDir $k
    $after = (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash
    if ($after -ne $protectedDds[$k]) {
        throw "Protected DDS changed unexpectedly."
    }
}

Exit-SdTool 0
return
