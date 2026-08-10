# Stellar Dogos — Phase 7: Xenotype catalog (isolated mapping)
# Dot-source from portrait-register.ps1 / portrait-pipeline.ps1 / portrait-intake.ps1.
# Vanilla category keys / species_class / set lists inspected from Stellaris 4.4.x
# common/portrait_categories/00_portrait_categories.txt (read-only).
#
# FilenameAbbr is for canonical PNG names only (dogNN_name_<abbr>_stellaris.png).
# It is NOT a Stellaris species_class and must never be used as a portrait ID.

function Get-PortraitXenotypeCatalog {
    # Order = console menu order. DisplayName is user-facing; Ids/classes are internal.
    return @(
        [PSCustomObject]@{
            Id              = "mammalian"
            DisplayName     = "Mammalian"
            FilenameAbbr    = "mam"
            CategoryKey     = "mammalians"
            SpeciesClass    = "MAM"
            SetName         = "sd_static_test"          # historical / existing set — do not rename
            GreetingSound   = "mammalian_01_greetings"
            VanillaSets     = @("mammalians", "cybernetic_mammalians", "biogenesis_mammalians", "psionic_mammalians")
        }
        [PSCustomObject]@{
            Id              = "avian"
            DisplayName     = "Avian"
            FilenameAbbr    = "avi"
            CategoryKey     = "avians"
            SpeciesClass    = "AVI"
            SetName         = "sd_static_test_avi"
            GreetingSound   = "avian_01_greetings"
            VanillaSets     = @("avians", "cybernetic_avians", "synthetic_avians", "biogenesis_avians", "psionic_avians")
        }
        [PSCustomObject]@{
            Id              = "reptilian"
            DisplayName     = "Reptilian"
            FilenameAbbr    = "rep"
            CategoryKey     = "reptilians"
            SpeciesClass    = "REP"
            SetName         = "sd_static_test_rep"
            GreetingSound   = "reptilian_01_greetings"
            VanillaSets     = @("reptilians", "cybernetic_reptilians", "biogenesis_reptilians", "pdx_signup_reptilian")
        }
        [PSCustomObject]@{
            # User-facing label is Amphibian; Stellaris class remains AQUATIC.
            Id              = "aquatic"
            DisplayName     = "Amphibian"
            FilenameAbbr    = "amp"
            CategoryKey     = "aquatics"
            SpeciesClass    = "AQUATIC"
            SetName         = "sd_static_test_aquatic"
            GreetingSound   = "aqu_portrait_01"
            VanillaSets     = @("aquatics", "synthetic_aquatics", "biogenesis_aquatic", "psionic_aquatics")
        }
        [PSCustomObject]@{
            Id              = "arthropoid"
            DisplayName     = "Arthropoid"
            FilenameAbbr    = "art"
            CategoryKey     = "arthropoids"
            SpeciesClass    = "ART"
            SetName         = "sd_static_test_art"
            GreetingSound   = "arthropoid_01_greetings"
            VanillaSets     = @("arthropoids", "cybernetic_arthropoids", "synthetic_arthropoids", "biogenesis_arthropoids", "psionic_arthropoids")
        }
        [PSCustomObject]@{
            Id              = "molluscoid"
            DisplayName     = "Molluscoid"
            FilenameAbbr    = "mol"
            CategoryKey     = "molluscoids"
            SpeciesClass    = "MOL"
            SetName         = "sd_static_test_mol"
            GreetingSound   = "molluscoid_01_greetings"
            VanillaSets     = @("molluscoids", "synthetic_molluscoids", "ep9_exclusive_molluscoid", "biogenesis_molluscoids", "psionic_molluscoids")
        }
        [PSCustomObject]@{
            Id              = "fungoid"
            DisplayName     = "Fungoid"
            FilenameAbbr    = "fun"
            CategoryKey     = "fungoids"
            SpeciesClass    = "FUN"
            SetName         = "sd_static_test_fun"
            GreetingSound   = "fungoid_01_greetings"
            VanillaSets     = @("fungoids", "cybernetic_fungoids", "psionic_fungoids")
        }
        [PSCustomObject]@{
            Id              = "plantoid"
            DisplayName     = "Plantoid"
            FilenameAbbr    = "pla"
            CategoryKey     = "plantoids"
            SpeciesClass    = "PLANT"
            SetName         = "sd_static_test_plant"
            GreetingSound   = "plantoid_greetings"
            VanillaSets     = @("plantoids", "biogenesis_plantoids")
        }
        [PSCustomObject]@{
            Id              = "lithoid"
            DisplayName     = "Lithoid"
            FilenameAbbr    = "lit"
            CategoryKey     = "lithoids"
            SpeciesClass    = "LITHOID"
            SetName         = "sd_static_test_lithoid"
            GreetingSound   = "lithoid_portrait_1_golem"
            VanillaSets     = @("lithoids")
        }
        [PSCustomObject]@{
            Id              = "necroid"
            DisplayName     = "Necroid"
            FilenameAbbr    = "nec"
            CategoryKey     = "necroids"
            SpeciesClass    = "NECROID"
            SetName         = "sd_static_test_necroid"
            GreetingSound   = "necroid_portrait_01_boneworshipper"
            VanillaSets     = @("necroids")
        }
        [PSCustomObject]@{
            Id              = "machine"
            DisplayName     = "Machine"
            FilenameAbbr    = "mac"
            CategoryKey     = "machines"
            SpeciesClass    = "MACHINE"
            SetName         = "sd_static_test_machine"
            GreetingSound   = "robot_mammalian_greetings"
            VanillaSets     = @("machines", "biogenesis_machines", "psionic_machines")
        }
        [PSCustomObject]@{
            # Verified from Stellaris 4.4.x:
            #   portrait_categories: toxoids { name = TOX; sets = { toxoids } }
            #   portrait_sets: toxoids { species_class = TOX }
            #   species_classes: TOX = { ... }
            #   greeting example: tox_portrait_01
            Id              = "toxoid"
            DisplayName     = "Toxoid"
            FilenameAbbr    = "tox"
            CategoryKey     = "toxoids"
            SpeciesClass    = "TOX"
            SetName         = "sd_static_test_tox"
            GreetingSound   = "tox_portrait_01"
            VanillaSets     = @("toxoids")
        }
    )
}

function Resolve-PortraitXenotype {
    param(
        [AllowEmptyString()]
        [string]$Selection = ""
    )

    if ([string]::IsNullOrWhiteSpace($Selection)) {
        return $null
    }

    $catalog = @(Get-PortraitXenotypeCatalog)
    $raw = $Selection.Trim()

    # Numeric menu index (1-based)
    $num = 0
    if ([int]::TryParse($raw, [ref]$num)) {
        if ($num -ge 1 -and $num -le $catalog.Count) {
            return $catalog[$num - 1]
        }
        return $null
    }

    $lower = $raw.ToLowerInvariant()
    # Friendly aliases (user-facing Amphibian == internal aquatic)
    if ($lower -eq "amphibian" -or $lower -eq "aquatic") {
        return ($catalog | Where-Object { $_.Id -eq "aquatic" } | Select-Object -First 1)
    }

    foreach ($x in $catalog) {
        if ($x.Id -eq $lower -or
            $x.DisplayName.ToLowerInvariant() -eq $lower -or
            $x.FilenameAbbr -eq $lower) {
            return $x
        }
    }
    return $null
}

function Read-PortraitXenotypeArrowMenu {
    param(
        [object[]]$Catalog,
        [string]$PortraitDisplayName = ""
    )

    Write-Host ""
    Write-Host "Which Stellaris species type should this portrait belong to?"
    Write-Host "This determines which Stellaris species category the portrait will appear under."
    $up = [char]0x2191
    $down = [char]0x2193
    Write-Host ("Use {0} / {1} to choose, then press Enter." -f $up, $down)
    Write-Host ""

    $selected = 0
    $menuTop = [Console]::CursorTop
    $menuLines = $Catalog.Count
    $prevVisible = [Console]::CursorVisible
    [Console]::CursorVisible = $false
    $esc = [char]27

    function Move-CursorToMenuTop {
        try {
            if ($menuTop -ge 0 -and $menuTop -lt [Console]::BufferHeight) {
                [Console]::SetCursorPosition(0, $menuTop)
                return $true
            }
        } catch { }
        try {
            [Console]::CursorTop = $menuTop
            [Console]::CursorLeft = 0
            return $true
        } catch { }
        # Absolute reposition failed (scrolled buffer). Move up relatively via VT.
        try {
            $cur = [Console]::CursorTop
            if ($cur -ge $menuLines) {
                Write-Host -NoNewline ("{0}[{1}A" -f $esc, $menuLines)
                return $true
            }
        } catch { }
        return $false
    }

    function Write-XenoMenu {
        param([int]$SelectedIndex)

        $repositioned = Move-CursorToMenuTop
        if (-not $repositioned) {
            # Last resort: do not print a second copy; skip redraw.
            return
        }

        for ($i = 0; $i -lt $Catalog.Count; $i++) {
            Write-Host -NoNewline ("{0}[2K" -f $esc)
            $label = $Catalog[$i].DisplayName
            if ($i -eq $SelectedIndex) {
                Write-Host (("  > {0}" -f $label).PadRight(40)) -ForegroundColor Cyan
            } else {
                Write-Host (("    {0}" -f $label).PadRight(40))
            }
        }
    }

    try {
        Write-XenoMenu -SelectedIndex $selected
        while ($true) {
            $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            # Ignore key-up / repeat noise if present.
            if ($null -ne $key.PSObject.Properties["KeyDown"] -and -not $key.KeyDown) {
                continue
            }
            switch ($key.VirtualKeyCode) {
                38 { # Up arrow
                    $selected = ($selected - 1)
                    if ($selected -lt 0) { $selected = $Catalog.Count - 1 }
                    Write-XenoMenu -SelectedIndex $selected
                }
                40 { # Down arrow
                    $selected = ($selected + 1) % $Catalog.Count
                    Write-XenoMenu -SelectedIndex $selected
                }
                13 { # Enter
                    try {
                        [Console]::CursorTop = $menuTop + $menuLines
                        [Console]::CursorLeft = 0
                    } catch {
                        Write-Host ""
                    }
                    $check = [char]0x2713
                    Write-Host ("{0} {1} selected." -f $check, $Catalog[$selected].DisplayName)
                    return $Catalog[$selected]
                }
            }
        }
    } finally {
        [Console]::CursorVisible = $prevVisible
    }
}

function Read-PortraitXenotypeInteractive {
    param(
        [string]$PortraitDisplayName = ""
    )

    $catalog = @(Get-PortraitXenotypeCatalog)

    # Normal console: arrow-key menu. Redirected stdin (scripted tests): numbered fallback.
    $canUseArrowMenu = $false
    try {
        $canUseArrowMenu = (
            -not [Console]::IsInputRedirected -and
            $Host.Name -eq "ConsoleHost" -and
            $null -ne $Host.UI -and
            $null -ne $Host.UI.RawUI
        )
    } catch {
        $canUseArrowMenu = $false
    }

    if ($canUseArrowMenu) {
        return Read-PortraitXenotypeArrowMenu -Catalog $catalog -PortraitDisplayName $PortraitDisplayName
    }

    Write-Host ""
    Write-Host "Which Stellaris species type should this portrait belong to?"
    Write-Host "This determines which Stellaris species category the portrait will appear under."
    Write-Host ""
    for ($i = 0; $i -lt $catalog.Count; $i++) {
        Write-Host ("  {0}. {1}" -f ($i + 1), $catalog[$i].DisplayName)
    }
    Write-Host ""

    while ($true) {
        Write-Host -NoNewline "> "
        $entered = $null
        if ([Console]::IsInputRedirected) {
            $entered = [Console]::In.ReadLine()
            if ($null -eq $entered) {
                throw "No species type was chosen (input closed before a selection was made)."
            }
            Write-Host $entered
        } else {
            $entered = Read-Host
        }

        if ([string]::IsNullOrWhiteSpace($entered)) {
            Write-Host "Please choose a species type from the list (1-$($catalog.Count))."
            continue
        }

        $resolved = Resolve-PortraitXenotype -Selection $entered
        if ($null -ne $resolved) {
            $check = [char]0x2713
            Write-Host ("{0} {1} selected." -f $check, $resolved.DisplayName)
            return $resolved
        }

        Write-Host "That choice was not recognized."
        Write-Host "Please enter a number from the list (1-$($catalog.Count))."
    }
}
