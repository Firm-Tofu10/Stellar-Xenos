# Stellar Doggos — Project Plan

**Target game:** Stellaris 4.4.x (Pegasus)  
**Mod name:** Stellar Doggos  
**Status:** Static-portrait **in-game experiment prepared** — not yet confirmed

This document is a planning artifact. Vanilla Stellaris install files remain the source of truth for registration syntax. The static `texturefile` binding is treated as an **external modding hypothesis** until it appears in species creation.

**Install path used for research (read-only):**  
`C:\Program Files (x86)\Steam\steamapps\common\Stellaris`

---

## Legend: Certainty Levels

| Tag | Meaning |
|-----|---------|
| **CONFIRMED** | Directly verified from the installed Stellaris files |
| **ASSUMPTION** | Reasonable inference from those files / Clausewitz patterns; not proven in-game |
| **NEEDS VERIFICATION** | Still needs an in-game test or further evidence |

---

## Important version note

**CONFIRMED** — `launcher-settings.json` reports:

- `"version": "Pegasus v4.4.6 (fdde)"`
- `"rawVersion": "v4.4.6"`
- `"modsCompatibilityVersion": "4.4"`

The project originally targeted **4.4.5**. The installed copy inspected for this research is **4.4.6**. Portrait systems below were verified against this install.  
**ASSUMPTION** — Portrait registration for a 4.4-compatible mod should use `supported_version` matching launcher expectations (often `v4.4.*` style); exact descriptor string still **NEEDS VERIFICATION** when we create the mod metadata.

---

## 1. Overall Goal

**CONFIRMED** (project requirements)

- Create a Stellaris mod named **Stellar Doggos**.
- Add real-world dogs as selectable species portraits.
- Portraits are **static images** from photographs, not animated 3D portraits.
- Dogs must appear in species / empire creation and function as normal species portraits.
- Prefer the simplest implementation; avoid unnecessary gameplay systems.

---

## 2. Current Scope and Future Extensibility

### Current scope

**CONFIRMED**

- Exactly **two** dog portraits for the initial release.
- Source assets: photographs of the two dogs.
- Selectable during species creation.
- No custom traits, events, or new species classes unless required for portraits to work.
- Keep the mod small and focused.

### Future extensibility

**CONFIRMED** (intent)

- Later versions may add more dogs without restructuring.

**ASSUMPTION** (based on vanilla architecture below)

- Adding Dog N should mean: one new image asset + one new portrait ID entry + one ID added to a portrait set list.
- Prefer a **dedicated portrait set + category** for Stellar Doggos so we never overwrite vanilla `mammalians` set contents on game updates.

---

## 3. Vanilla Portrait Architecture (4.4.6 findings)

### High-level pipeline

**CONFIRMED** — Species-creator portraits are wired through three databases plus portrait asset definitions:

1. **`common/portrait_categories/`** — UI tabs / groups in empire design (“Mammalian”, “Humanoid”, etc.).
2. **`common/portrait_sets/`** — Lists which portrait IDs belong together, and which **`species_class`** they map to.
3. **`common/species_classes/`** — Gameplay class (archetype, graphical culture, playable rules). Playable classes live mainly in `01_base_species_classes.txt`.
4. **`gfx/portraits/portraits/*.txt`** — Defines what each portrait ID *is* (`portraits = {}`), and optional gendered/conditional wrappers (`portrait_groups = {}`).

**CONFIRMED** — Comments in `common/portrait_categories/00_portrait_categories.txt` and `common/portrait_sets/00_portrait_sets.txt` state that categories group sets for the empire editor, and sets associate portraits with species classes.

**CONFIRMED** — Older comments in some `gfx/portraits/portraits/*.txt` files still say portraits are chosen from `common/species_classes/00_species_classes.txt`. That is **outdated relative to the live data**: playable classes in `01_base_species_classes.txt` do **not** list portrait IDs; `portrait_sets` does.

### How a portrait becomes selectable

**CONFIRMED** (from file structure)

1. A portrait ID is defined under `portraits = { ... }` in `gfx/portraits/portraits/*.txt`.
2. That ID (or a `portrait_groups` ID with the same name) is listed in a `portrait_sets` entry.
3. That set is listed under a `portrait_categories` entry’s `sets = { ... }`.
4. The set’s `species_class = MAM` (etc.) determines which species class the empire uses when that portrait is chosen.
5. Localisation key for the category tab comes from the category’s `name = MAM` (etc.), resolved via localisation (e.g. `MAM` → “Mammalian”).

**ASSUMPTION** — A new category with its own set can appear as its own tab while still using `species_class = MAM`, so dogs remain Mammalian gameplay-wise without inventing a new species class.

**NEEDS VERIFICATION** — In-game confirmation that a mod-added category/set appears in empire creation and that `species_class = MAM` behaves as expected for custom portraits.

---

## 4. Where Vanilla Portrait Image Assets Are Stored

**CONFIRMED**

| Role | Location |
|------|----------|
| Species / leader character textures (UV maps for 3D portrait meshes) | `gfx/models/portraits/<group>/…/*.dds` |
| Portrait mesh / animation / entity definitions | `gfx/models/portraits/<group>/_…_portrait_meshes.gfx`, `_…_portrait_entities.asset`, `_…_portrait_animations.asset`, `.mesh`, `.anim` |
| Portrait definition scripts | `gfx/portraits/portraits/*.txt` |
| Clothes / attachment selectors | `gfx/portraits/asset_selectors/*.txt` |
| Leader background plates | `gfx/portraits/leaders/*.dds` |
| Portrait shader / sprite configuration | `gfx/FX/portrait.shader`, `gfx/portraits/sprite_configurations/` |
| UI `portraitType` sprites (rooms, character frames, masks) | `interface/core.gfx` (and related) |

**CONFIRMED** — There is **no** `gfx/interface/portraits/` directory in this install, even though that path appears in a **commented documentation example**.

**CONFIRMED** — Live species portraits in this install are **3D entity-based**, not standalone photo plates. Example (`01_portraits_mammalian.txt`):

- `entity = "portrait_mammalian_05_entity"`
- `clothes_selector = "…"`
- `attachment_selector = "no_texture"` (or a real selector)
- `character_textures = { "gfx/models/portraits/….dds" … }`
- often `greeting_sound = "…"`

**CONFIRMED** — Entity `portrait_mammalian_05_entity` is defined in `gfx/models/portraits/mammalian/_mammalian_portrait_entities.asset` and points at a `pdxmesh`.

---

## 5. Image Formats and Dimensions

**CONFIRMED**

- Portrait character textures inspected are **`.dds`** files under `gfx/models/portraits/`.
- **No** `.png` or `.tga` species portrait textures were found under `gfx/models/portraits/`.
- Sample dimensions (DDS header width×height) vary because these are **mesh UV textures**, not fixed UI portrait frames:
  - `mammalian_slender_05_orange.dds` → **380×440**
  - `mammalian_normal_06_brown.dds` → **344×512**
  - `mammalian_ratling.dds` → **360×512**
  - other mammalian samples → **340×512**, **400×512**, etc.
- `gfx/interface/main/unselected_portrait.dds` (UI placeholder used by `portraitType`) → **140×200**
- `gfx/portraits/leaders/leader_ruler_bg.dds` → **320×380**
- Compression varies: some files report FourCC `DXT5`; several character textures look like **uncompressed RGBA** (`pfFlags` including RGB+alpha).

**CONFIRMED** — There is **no live vanilla example** of a static `texturefile` species portrait asset to measure for photo-style mods.

**CONFIRMED** — Vanilla does **not** currently demonstrate a static species-portrait size standard.

---

## 6. How Portrait Assets Are Referenced

**CONFIRMED** — Inside `portraits = { }`, vanilla **comments** document three alternative binding styles in `gfx/portraits/portraits/00_portraits_main.txt`:

```text
### mam1 = {
###		spriteType = "GFX_portrait_mam1"
###		#OR
###		texturefile = "gfx/interface/portraits/mammalien_massive_01.dds"
###		#OR
###		entity = "portrait_mammalian_06_entity"
###	}
```

**CONFIRMED** — In live portrait definition files under `gfx/portraits/portraits/`:

- **Every active species portrait uses `entity = …`**
- **Zero** active `texturefile = …` or `spriteType = …` portrait bindings
- The comment’s example sprite name and DDS path are **not present** in the install

**CONFIRMED** — There is **no confirmed vanilla-supported static-2D species portrait path** in this install (see Section 10).

**NEEDS VERIFICATION** — Whether those commented alternatives still parse/render if a mod uses them.

**CONFIRMED** — `character_textures` / `tied_texture` are textures for **entity** meshes, not standalone photo portraits.

---

## 7. Where Portrait Definitions Are Declared

**CONFIRMED**

- Primary definitions: `gfx/portraits/portraits/*.txt` (many numbered files, e.g. `01_portraits_mammalian.txt`, `12_portraits_distant_stars.txt`).
- Blocks used:
  - `portraits = { <id> = { … } }`
  - `portrait_groups = { <id> = { default = … game_setup = {…} leader = {…} … } }`
  - also `portrait_evolution = { … }` in `00_portraits_main.txt` (cybernetic/psionic stage suffixes; out of scope for v1)

### Portrait groups vs plain portraits

**CONFIRMED**

- Many selectable IDs (e.g. `mam5`, `mam1`, `mam_rat`) are **plain portrait IDs** with **no** matching `portrait_groups` entry.
- `portrait_groups` are used when one selectable ID must map to variants (e.g. `mam4` → `mam4_m` / `mam4_f` by gender), or special cases like `swarm`.
- Therefore **gendered/conditional `portrait_groups` are not required** for a single static dog image used for all contexts.

**ASSUMPTION** — Two dog portraits can each be a single portrait ID listed directly in a portrait set.

---

## 8. Portrait Sets and Categories

### Categories

**CONFIRMED** — `common/portrait_categories/00_portrait_categories.txt` defines entries such as:

```text
mammalians = {
	name = MAM
	sets = {
		mammalians
		cybernetic_mammalians
		…
	}
}
```

`name = MAM` is a localisation key (see below), not the set ID.

### Sets

**CONFIRMED** — `common/portrait_sets/00_portrait_sets.txt` defines entries such as:

```text
mammalians = {
	species_class = MAM
	portraits = {
		"mam5"
		"mam13"
		…
		"mam_rat"
		…
	}
	non_randomized_portraits = {
		"mam_rat"
	}
}
```

Also supports `conditional_portraits`, `non_pre_ftl_portraits`, `uplifted_portraits`, etc.

**CONFIRMED** — `mam_rat` is a normal mammalian set member (Distant Stars ratling), defined in `12_portraits_distant_stars.txt` as an entity portrait with several `character_textures`.

### Species classes

**CONFIRMED** — Playable `MAM` in `common/species_classes/01_base_species_classes.txt` sets archetype, authority restrictions, `graphical_culture = mammalian_01`, etc. It does **not** enumerate portraits.

**ASSUMPTION** — Stellar Doggos should **reuse `species_class = MAM`** (or another existing class) rather than create a new species class, matching the “portraits only” scope.

---

## 9. Localisation Requirements

**CONFIRMED**

- Category display names use keys like `MAM`, `HUM`, `BIOGENESIS_CAT`, `PSIONIC`, `INF` found in localisation (e.g. `localisation/english/name_lists/name_lists_l_english.yml` has `MAM:0 "Mammalian"`; BioGenesis category key appears elsewhere).
- `localisation/english/portrait_packs_l_english.yml` only contains a couple of portrait-pack **DLC titles**, not per-portrait names.
- Individual portrait IDs in the species picker do **not** appear to require their own display-name localisation in vanilla (they are shown as images).

**ASSUMPTION**

- If dogs are added under the existing **Mammalian** category (by extending that category’s set list / set contents), **no new localisation may be required**.
- If we create a **new portrait category** (recommended for clean extensibility), we **will** need at least one localisation entry for the category `name` key.

**NEEDS VERIFICATION** — Whether missing category localisation shows a raw key or breaks the UI.

---

## 10. Static Portrait Support Deep-Dive (`texturefile` / `spriteType`)

### What the commented example was intended to do

**CONFIRMED** — In `gfx/portraits/portraits/00_portraits_main.txt` (lines ~233–243), a comment documents three **mutually alternative** ways to bind a portrait ID inside `portraits = { }`:

```text
### Portraits
###
### Ex:
### mam1 = {
###		spriteType = "GFX_portrait_mam1"
###		#OR
###		texturefile = "gfx/interface/portraits/mammalien_massive_01.dds"
###		#OR
###		entity = "portrait_mammalian_06_entity"
###	}
```

**CONFIRMED** — Intent of that comment, as written:

| Alternative | Intended meaning |
|-------------|------------------|
| `spriteType = "GFX_…"` | Reference a named UI sprite (normally defined in a `.gfx` `spriteTypes` block) as the portrait graphic |
| `texturefile = "…dds"` | Point the portrait directly at a texture path (no separate sprite name) |
| `entity = "…_entity"` | Use a 3D portrait entity (the only alternative used by live content) |

**CONFIRMED** — The same file’s `debug` portrait still has a **commented** `#spriteType = "GFX_portrait_mam1"` line, while its **active** fields are `entity` values (not a static texture).

### Do the commented examples still resolve in this install?

**CONFIRMED** — They do **not** resolve to present assets:

| Referenced thing | Status in 4.4.6 install |
|------------------|-------------------------|
| `GFX_portrait_mam1` | **Not defined** anywhere under `interface/` or elsewhere searched; only appears in those comments |
| `gfx/interface/portraits/mammalien_massive_01.dds` | **Path does not exist** (`gfx/interface/portraits/` is absent); no `mammalien*` files found |
| `entity = "portrait_mammalian_06_entity"` | **Exists** and matches the live mammalian entity pipeline |

### Full-install search results (species-portrait relevance)

**CONFIRMED**

| Search | Result in species-portrait context |
|--------|-------------------------------------|
| `texturefile` under `gfx/portraits/` | **Only** the commented example line in `00_portraits_main.txt` |
| `spriteType =` under `gfx/portraits/` | **Only** commented lines in `00_portraits_main.txt` |
| Active `texturefile` / `spriteType` portrait bindings | **None** |
| Phrase `static portrait` / `static_portrait` | **No matches** in searched text assets |
| `portrait_sets` / `portrait_categories` | **Present and active** (`common/portrait_sets/`, `common/portrait_categories/`) — these register portrait **IDs** into empire design; they do not define static image binding |
| DLC folders with `gfx/portraits` | **None** found under `dlc/` |
| Plane / flat / billboard portrait meshes under `gfx/models/portraits` | **None** found by name search |

**CONFIRMED** — Outside portrait definitions, `texturefile` is widely used in `.gfx` UI sprites (`spriteType = { name = … texturefile = … }`). That is the **interface sprite system**, not proof that portrait IDs accept `texturefile`.

**CONFIRMED** — `portraitType` entries in `interface/core.gfx` also use `texturefile` (e.g. `unselected_portrait.dds`). Those are **UI frame / render-target placeholders** for drawing character portraits, not species portrait asset definitions.

**CONFIRMED** — In portrait scripts, `texture = "..."` under `environment_override` refers to **planet/environment background** textures, not species portraits.

**CONFIRMED** — `tied_texture = { texture = "….dds" }` appears inside `character_textures` on **entity** portraits (e.g. `29_pdx_signup_portraits.txt`). That is still the 3D entity pipeline with variant textures, not a static 2D species portrait.

**CONFIRMED** — Every inspected live species/leader-style portrait definition uses `entity = ...`. No active portrait ID was found that binds only a flat image via `texturefile` or `spriteType`.

### Verdict

| Claim | Label |
|-------|-------|
| Live vanilla species portraits are entity-based | **CONFIRMED** |
| Comment documents historical/alternate `texturefile` and `spriteType` bindings | **CONFIRMED** |
| Comment’s example sprite and DDS still exist | **CONFIRMED false** (they do not) |
| Vanilla 4.4.6 ships a working static 2D species portrait example | **CONFIRMED false** (no such example) |
| `texturefile` / `spriteType` still function for species portraits in 4.4.6 | **NEEDS VERIFICATION** (cannot be confirmed from files; must not be assumed) |
| `portrait_sets` + `portrait_categories` can expose portrait IDs in empire creation | **CONFIRMED** (vanilla wiring), independent of how the ID’s graphic is bound |

**Bottom line:** There is **no confirmed currently supported static-2D species portrait mechanism** in Stellaris 4.4.6 based on vanilla files alone.

---

## 11. Minimum File Set for a Portrait-Only Mod (projected)

**CONFIRMED** — Empire-creation registration still needs, at minimum, portrait ID definition(s) + `portrait_sets` (+ usually `portrait_categories`), regardless of graphic binding method.

**ASSUMPTION** — Additive structure for two dogs (graphic binding TBD):

```text
Stellar Doggos/
  descriptor / launcher .mod metadata
  gfx/portraits/portraits/00_stellar_doggos_portraits.txt
  gfx/...                          # DDS and/or mesh/entity assets depending on chosen binding
  common/portrait_sets/...
  common/portrait_categories/...   # if not patching Mammalian
  localisation/english/...         # if new category name
```

**NEEDS VERIFICATION** before locking the gfx half of that tree:

- Whether commented `texturefile` / `spriteType` still work at all.
- If not, what **vanilla-supported** alternative can display a dog photograph (likely still the entity pipeline — which has **no** flat “photo plane” example in this install).

**ASSUMPTION** — Still avoid unless required: new species classes, traits, events, namelists, custom graphical cultures.

**NEEDS VERIFICATION**

- Exact mod metadata / `supported_version` and Documents mod path (folder did not exist at research time).
- Clausewitz merge behavior when extending existing categories/sets.

---

## 12. Vanilla Examples to Treat as 4.4 Syntax Authority

Use these installed files as templates / references (do not copy assets into the repo):

| Example | Path | Why it matters |
|---------|------|----------------|
| Comment-only static alternatives | `gfx/portraits/portraits/00_portraits_main.txt` (~233–243) | Historical/alternate docs only — **not** a live working example |
| Live entity portrait binding | `mam5` / `mam_rat` etc. in `gfx/portraits/portraits/*.txt` | **Confirmed** current species-portrait graphic binding |
| Gendered portrait group | `mam4` group in same file | Shows when groups are needed (not for our v1 dogs) |
| Extra portrait in mammalian set | `mam_rat` in `12_portraits_distant_stars.txt` + listing in `portrait_sets` | How additional portraits join `species_class = MAM` |
| Category wiring | `common/portrait_categories/00_portrait_categories.txt` | Empire-design tabs |
| Set wiring | `common/portrait_sets/00_portrait_sets.txt` | Portrait lists + `species_class` |
| Playable class | `MAM` in `common/species_classes/01_base_species_classes.txt` | Gameplay class dogs should reuse |
| Category loc | `MAM` in `localisation/english/name_lists/name_lists_l_english.yml` | How category names resolve |
| Entity stack (confirmed live path) | `gfx/models/portraits/mammalian/_mammalian_portrait_entities.asset` | Current vanilla portrait graphic pipeline |

---

## 13. Image Assets We Will Eventually Need

**CONFIRMED**

- Two source photographs (one per dog).

**ASSUMPTION**

- Convert each photo to `.dds` for the game.
- One texture per dog is enough for v1 (no male/female variants).

**NEEDS VERIFICATION** (only if a static binding is later proven to work)

- Exact pixel size / aspect ratio for static photo portraits.
- Preferred DDS compression (DXT5/BC3 vs uncompressed).
- Whether mipmaps are required.
- How photos should be framed for empire-creation and diplomacy views.
- Transparent background vs opaque; masking behavior.

Keep source photographs archived for re-export when more dogs are added.

---

## 14. Known Technical Uncertainties

| Item | Status |
|------|--------|
| Does `texturefile` still work for species portraits in 4.4.6? | **NEEDS VERIFICATION** — comment-only; example assets missing; **not confirmed** |
| Does `spriteType` still work for species portraits? | **NEEDS VERIFICATION** — same; `GFX_portrait_mam1` undefined |
| Any vanilla static 2D species portrait example? | **CONFIRMED** none in this install |
| Static portrait DDS size/format | **NEEDS VERIFICATION** (no live static species example) |
| Flat photo-plane entity/mesh in vanilla? | **CONFIRMED** none found by name search |
| Required mod descriptor / `supported_version` string | **NEEDS VERIFICATION** |
| New category vs patching Mammalian category | **ASSUMPTION** favoring new category; merge behavior **NEEDS VERIFICATION** |
| Localisation needed only for new category name | **ASSUMPTION** |
| `greeting_sound` required | **NEEDS VERIFICATION** |
| Installed game is 4.4.6 vs project note 4.4.5 | **CONFIRMED** mismatch; treat as 4.4.x Pegasus |

---

## 15. Proposed Next Process (no final dogs until experiment passes)

**CONFIRMED** — Do **not** treat static `texturefile` as a known-good 4.4.6 feature until Section 18’s in-game checklist passes.

### Current gate

Run **SD Static Portrait Test** (Section 18). Then:

1. **If visible in Mammalian species creation** — mark static `texturefile` **CONFIRMED**; proceed to real dog photo conversion and the two-dog mod.
2. **If missing / broken** — keep static binding **unconfirmed**; investigate entity-pipeline photo options or revisit scope (still using vanilla evidence only).

### Only after a binding method is confirmed in-game

1. Keep `portrait_sets` / `portrait_categories` registration with `species_class = MAM`.
2. Replace placeholder DDS with dog photos (one dog first, then two).
3. Replace experiment folder with the real Stellar Doggos layout (or graduate the experiment carefully).
4. Write the real “how to add another dog” note from the working pattern.

---

## 16. Non-Goals (Current Version)

**CONFIRMED**

- No custom traits, civics, origins, or mechanics for dogs.
- No copying vanilla mesh/entity assets into this repository during research.
- No modification of the Stellaris installation.
- No final two-dog Stellar Doggos implementation until the static experiment is verified in-game.
- Do not treat `texturefile` as **CONFIRMED** until the test portrait is visible in species creation.

---

## 17. Research Log — Files / Folders Inspected

Read-only inspection included:

- `launcher-settings.json` (version)
- `common/portrait_categories/00_portrait_categories.txt`
- `common/portrait_sets/00_portrait_sets.txt`
- `common/species_classes/00_species_classes.txt`
- `common/species_classes/01_base_species_classes.txt`
- `gfx/portraits/portraits/` (multiple files, especially `00_portraits_main.txt`, `01_portraits_mammalian.txt`, `07_portraits_human.txt`, `12_portraits_distant_stars.txt`)
- `gfx/portraits/asset_selectors/other.txt`
- `gfx/portraits/sprite_configurations/00_sprite_configurations.txt`
- `gfx/portraits/leaders/` (background DDS samples)
- `gfx/models/portraits/mammalian/` (DDS samples, `_mammalian_portrait_entities.asset`)
- `gfx/models/portraits/distant_stars/` (ratling DDS)
- `interface/core.gfx` (`portraitType` definitions)
- `localisation/english/portrait_packs_l_english.yml`
- `localisation/english/name_lists/name_lists_l_english.yml` (species class / category names)
- `dlc_metadata/dlc_info.txt` (anniversary / creatures-of-the-void metadata only; portrait assets for those packs were not present as separate inspectable static portrait examples in the main tree)
- `tools/texture_converter_settings.json`
- Checked for Documents mod folder / Steam workshop content (neither present on this machine at research time)
- **Static-support follow-up:** exhaustive search under `gfx/portraits` for active `texturefile`/`spriteType`; install-wide checks for `GFX_portrait_mam1`, `gfx/interface/portraits`, `mammalien*`, “static portrait”; DLC `gfx/portraits` presence; flat/plane portrait mesh name search; clarification of `.gfx` `texturefile`, `portraitType` placeholders, `environment_override.texture`, and `tied_texture`

---

## Immediate Next Step

1. Enable **SD Static Portrait Test** in the Stellaris launcher.
2. Open empire / species creation → **Mammalian**.
3. Look for the magenta/cyan placeholder portrait.
4. Report result and update Section 18 labels (`CONFIRMED` only if visible).

Until that in-game check passes, **do not** implement the final two-dog Stellar Doggos portraits.

---

## 18. Experiment: SD Static Portrait Test

**Location:** `experiment/sd_static_portrait_test/`  
**Launcher registration:** `Documents/Paradox Interactive/Stellaris/mod/sd_static_portrait_test.mod` (points at the experiment folder)  
**Goal:** Prove or disprove that a `texturefile` static portrait appears in Stellaris **4.4.6** species creation.  
**Status:** Implemented on disk — **NEEDS VERIFICATION** in-game (not confirmed).

### What was built (minimal / reversible)

| File | Role |
|------|------|
| `gfx/portraits/portraits/00_sd_static_test_portraits.txt` | Defines `sd_static_test_01` |
| `gfx/models/portraits/sd_static_test/sd_static_test_01.dds` | 256×256 magenta + cyan-X placeholder |
| `common/portrait_sets/00_sd_static_test_portrait_sets.txt` | New set `sd_static_test`, `species_class = MAM` |
| `common/portrait_categories/zzz_sd_static_test_portrait_categories.txt` | Overrides vanilla `mammalians` category to append set `sd_static_test` |
| `descriptor.mod` | Mod metadata (`supported_version="v4.4.*"`) |

No real dog photos. No second portrait. No final Doggos folder layout. Vanilla install untouched.

### Portrait definition used

```text
portraits = {
	sd_static_test_01 = {
		clothes_selector = "no_texture"
		attachment_selector = "no_texture"
		greeting_sound = "mammalian_01_greetings"
		texturefile = "gfx/models/portraits/sd_static_test/sd_static_test_01.dds"
	}
}
```

### Syntax provenance

| Piece | Source | Label |
|-------|--------|-------|
| `texturefile = "….dds"` as species portrait binding | Stellaris Wiki “Static portraits” / current modding examples; also commented in vanilla `00_portraits_main.txt` | **EXTERNAL MODDING EXAMPLE** (not live-vanilla-proven) |
| Combining `texturefile` with `clothes_selector` / `attachment_selector` / `greeting_sound` | Requested experiment approach; selectors/`no_texture`/`greeting_sound` IDs exist in vanilla entity portraits | **HYBRID** — structure from modding practice + vanilla IDs |
| `clothes_selector = "no_texture"` | Vanilla selector id in `gfx/portraits/asset_selectors/other.txt`; used on many vanilla portraits | **CONFIRMED** (vanilla id exists) |
| `attachment_selector = "no_texture"` | Same | **CONFIRMED** (vanilla id exists) |
| `greeting_sound = "mammalian_01_greetings"` | Used throughout vanilla mammalian portraits | **CONFIRMED** (vanilla id exists) |
| Unique portrait id `sd_static_test_01` | Experiment naming | **ASSUMPTION** (must not collide) |
| `portrait_sets` entry with `species_class = MAM` | Vanilla `common/portrait_sets/00_portrait_sets.txt` | **CONFIRMED** pattern |
| `non_randomized_portraits` | Vanilla set pattern (e.g. `mam_rat`) | **CONFIRMED** pattern |
| Replacing `mammalians` category `sets = { … }` to append one set | Vanilla category structure; same-key override | **CONFIRMED** structure / **ASSUMPTION** that mod override wins |
| Placeholder DDS 256×256 uncompressed RGBA | Generated for test visibility; not a vanilla static size standard | **ASSUMPTION** (size may be wrong) |
| `supported_version="v4.4.*"` | Matches launcher `modsCompatibilityVersion` major line | **ASSUMPTION** |

### In-game verification checklist

Mark static portraits **CONFIRMED** only if all critical checks pass:

1. [ ] Mod appears and enables in the 4.4.6 launcher without errors.
2. [ ] Empire creation → species portraits → **Mammalian** shows an extra portrait.
3. [ ] That portrait displays the magenta/cyan placeholder (not missing/pink-void/wrong art).
4. [ ] Selecting it keeps species class behavior consistent with Mammalian (**ASSUMPTION** via `species_class = MAM`).
5. [ ] `error.log` / `game.log` lack fatal portrait/`texturefile` errors for `sd_static_test_01`.

If the portrait **does not** appear or does not render: static `texturefile` remains **unconfirmed** for 4.4.6; do not proceed to real dog assets until a working binding is found.

### Revert

- Disable/remove `sd_static_portrait_test.mod` from the Documents mod folder.
- Optionally delete `experiment/sd_static_portrait_test/`.
- No vanilla files need restoring.