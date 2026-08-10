# Stellar Xeno — Development Roadmap

Authoritative phase status for future sessions. Cross-references:

- [AI development workflow](ai-development-workflow.md)
- [Portrait workflow](portrait-workflow.md)
- [Portrait testing](portrait-testing.md)
- [Project plan](../PROJECT_PLAN.md)

Certainty labels: **CONFIRMED** / **ASSUMPTION** / **TARGET** / **NEEDS VERIFICATION** — see [PROJECT_PLAN.md](../PROJECT_PLAN.md).

---

## Current position

| Item | Status |
|------|--------|
| Static `texturefile` portraits in 4.4.6 | **CONFIRMED** (species creation) |
| Three dogs (Piglet, Oakley, Angus) | Working in species creation |
| Automated portrait importer | **IMPLEMENTED** through Phase 7 (intake → DDS → xenotype register → pipeline) |
| Production mod path | **IMPLEMENTED** — canonical output `mod/stellar_dogos/` (`tools/portrait-paths.ps1`); experiment copy retained as reference |
| Phase 3.1 source intake (interactive naming) | **IMPLEMENTED** (`tools/portrait-intake.ps1`) |
| Phase 4 DDS generation | **IMPLEMENTED** (`tools/portrait-dds.ps1`) |
| Phase 5 Stellaris registration | **IMPLEMENTED** (`tools/portrait-register.ps1`) |
| Phase 6 end-to-end pipeline proof | **IMPLEMENTED** (`tools/portrait-pipeline.ps1`) |
| Phase 7 xenotype selection | **IMPLEMENTED** (`tools/portrait-xenotypes.ps1`) — 12 types including Toxoid; Mam/Avi/Rep/Fun file paths **CONFIRMED**; in-game **NEEDS VERIFICATION** |
| Canonical PNG naming (`dogNN_<name>_<xeno>_stellaris.png`) | **IMPLEMENTED** |
| Xenotype image-generation prompt library | **DOCUMENTED** ([portrait-generation-prompts.md](portrait-generation-prompts.md)) — Mammalian & Machine prompt bodies **ABSENT** from source export; Toxoid prompt **DOCUMENTED**; Toxoid selector/registration **IMPLEMENTED** |
| Full UI portrait compatibility | **NEEDS VERIFICATION** |
| Steam Workshop release | **PACKAGE READY** — structurally prepared (`mod/stellar_dogos/`); human in-game test + Steam upload remain ([docs/workshop-release.md](docs/workshop-release.md)) |

Phases 3.1–7 cover intake → DDS → xenotype-aware registration → end-to-end orchestration. The player-facing **prompt library** is documented separately from the software pipeline. Workshop package structural prep is documented in [workshop-release.md](workshop-release.md); broader UI-context audit remains later.

---

## Phase 0 — Discovery

**STATUS: COMPLETE**

- Investigate Stellaris **Pegasus v4.4.6** (`modsCompatibilityVersion = 4.4`)
- Investigate portrait categories / sets / species classes / gfx portraits
- Test `texturefile` via minimal experiment
- Prove static portrait loading in species creation
- Establish DDS requirements (256×256 uncompressed 32-bit RGBA, `pfFlags=0x41`, alpha)

---

## Phase 1 — Portrait Calibration

**STATUS: MOSTLY COMPLETE**

Done:

- Piglet working (`sd_dog_piglet`) — protected reference
- Oakley working (`sd_dog_02`) — gold-standard visual reference
- Angus working (`sd_dog_angus`) — regenerated ImgHERE art wired; framing accepted for now
- Transparency / alpha rules established
- Scale / framing empirical targets established (~91–92% vertical fill)
- Image-generation prompts preserved ([portrait-prompts.md](portrait-prompts.md))
- Manual DDS pipeline established
- ImgHERE staging convention established

Remaining:

- Final side-by-side visual comparison of all three
- Decide whether Piglet needs any further refinement (do not casually regenerate)

---

## Phase 2 — In-Game Compatibility Audit

**STATUS: NEXT**

Use **Oakley** as the primary test asset.

Test portrait appearance in:

- Species UI (beyond creation checklist already partly confirmed)
- Leader UI
- Council
- Government / empire UI
- Diplomacy
- Contacts
- Factions
- Events
- Other relevant portrait contexts

**Question to answer:** Does one static portrait DDS work correctly everywhere Stellaris displays that portrait?

See [portrait-testing.md](portrait-testing.md).

Only after this audit should importer architecture be finalized.

---

## Phase 3 — Portrait Importer Design / Phase 3.1 Intake

**STATUS: Phase 3.1 IMPLEMENTED** (`tools/portrait-intake.ps1`); Phase 4 DDS + Phase 5 registration also implemented

Before full implementation:

- Fresh Repomix snapshot when coding begins
- ChatGPT reconstructs repository
- Determine exact implementation files
- Define importer architecture (phased: 3.1 source prep → later DDS/registration)
- Define validation contracts
- Define failure behavior
- Define naming rules (canonical `dogNN_<name>_<xeno>_stellaris.png` is **internal**; users are not required to type it)

### Phase 3.1 — Source intake & preparation

**STATUS: IMPLEMENTED** — `tools/portrait-intake.ps1`

**User workflow:**

```text
Drop any image into ImgHERE
  → run tools/portrait-intake.ps1 (or portrait-pipeline.ps1)
  → enter the character's name when prompted (mandatory; no bypass)
  → select Stellaris species type (↑/↓ or numbered fallback)
  → tool assigns the next available dog number
  → tool prepares the canonical source image (includes xenotype abbr)
  → writes ImgHERE/dog##_<name>_<xeno>_stellaris.png and assets/source/...
  → deletes the temporary input from ImgHERE (success only)
  → STOP (intake alone) / continue to DDS+register (pipeline)
```

Phase 3.1 ends at prepared canonical PNG sources. It does **not** create DDS, portrait IDs, or registration edits.

#### Interactive naming + xenotype

Users must **not** be required to manually invent `dog04_…` filenames. Candidate filenames never imply name, xenotype, or sequence number.

1. User places a supported image in `ImgHERE/` (any reasonable name; PNG/JPG/JPEG/WEBP at minimum).
2. Tool detects a new supported candidate (not already a canonical asset).
3. Tool asks: `What is this character's name?`
4. User enters the authoritative display name (e.g. `Liberty`).
5. Tool normalizes the name **only** as needed for a safe filename (`Liberty` → `liberty`).
6. Empty/invalid names: keep asking — do not invent a name. No `-DogName` bypass.
7. Tool asks for Stellaris species type (12 options including Toxoid). Selection moves in one menu; Enter accepts.
8. **After** name + xenotype, tool chooses the next free dog number from existing canonical sources.
9. Tool generates canonical filename: `dog##_<name>_<xeno>_stellaris.png` (e.g. `dog04_liberty_mam_stellaris.png`).
10. Tool validates/prepares the image (PNG, square, RGBA, real alpha — no artistic regen).
11. Canonical prepared source is written to:
    - `ImgHERE/dog##_<name>_<xeno>_stellaris.png`
    - `assets/source/dog##_<name>_<xeno>_stellaris.png`
12. On **success**, delete the temporary input from `ImgHERE`. On **failure**, leave it untouched.
13. **Stop** (intake) or continue to DDS/register (pipeline). No vanilla changes. No `_originals` archive.

Filename abbreviations (PNG only; not species_class / not portrait ID):

| Xenotype | Abbreviation |
|----------|--------------|
| Mammalian | mam |
| Avian | avi |
| Reptilian | rep |
| Amphibian | amp |
| Arthropoid | art |
| Molluscoid | mol |
| Fungoid | fun |
| Plantoid | pla |
| Lithoid | lit |
| Necroid | nec |
| Machine | mac |
| Toxoid | tox |

Example:

```text
ImgHERE/my_dog.png
  → user enters "Liberty"
  → user selects Mammalian
  → ImgHERE/dog04_liberty_mam_stellaris.png
  → assets/source/dog04_liberty_mam_stellaris.png
```

#### Automatic dog numbering

- Scan existing canonical Stellar Xeno source assets (e.g. `assets/source/dog##_…_stellaris.png` and matching ImgHERE canons).
- Next number = lowest unused integer after the highest present (today: dog01–dog03 → next is **dog04**).
- Do **not** reuse numbers, renumber existing dogs, or touch Piglet / Oakley / Angus.

#### Already-canonical files

If a file is already named `dog##_<name>_<xeno>_stellaris.png`:

- Do **not** ask for the name again
- Treat as an explicitly named canonical asset
- Validate/prepare normally
- Do **not** assign another number or create duplicate canons

Legacy `dog##_<name>_stellaris.png` names remain recognizable for inventory; new intakes always write the `<xeno>` form.
#### Conflicts & safety

- If the normalized canonical filename already exists → **stop and explain**; never silently overwrite
- Do not overwrite existing prepared sources, DDS, definitions, or sets
- Existing working dogs are regression fixtures and must remain untouched
- Distinguish: canonical assets / new candidates / unsupported files / raw-reference images to ignore
- If unsure whether a file is a new portrait → **ask the user**; do not guess
- Do not process unrelated files

#### Explicitly outside Phase 3.1

- PNG → DDS conversion
- DDS → portrait definition
- Portrait definition → portrait set / category registration
- In-game testing claims for the new dog

DDS (Phase 4) and registration (Phase 5) are implemented separately; end-to-end automation is Phase 6.

---

## Phase 4 — DDS Generation / Technical Asset Pipeline

**STATUS: IMPLEMENTED** — `tools/portrait-dds.ps1`

Converts a validated Phase 3.1 canonical PNG into a game DDS matching the known-good working portraits.

```text
assets/source/dog##_<name>_stellaris.png
  → validate square RGBA + alpha
  → downscale to 256×256 (preserve alpha; do not alter source PNG)
  → write uncompressed 32-bit RGBA DDS (pfFlags=0x41, no mips)
  → validate header vs Piglet reference + alpha
  → STOP
```

**Output location:**  
`mod/stellar_dogos/gfx/models/portraits/sd_static_test/sd_dog_<name>.dds`

**Command:**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-dds.ps1 -Source assets\source\dog05_bruce_stellaris.png
```

**Safety:** refuses to overwrite an existing DDS; does not modify Piglet/Oakley/Angus; does not touch portrait defs/sets/categories or vanilla Stellaris.

**Explicitly outside Phase 4:** portrait IDs, definition/set/category registration, in-game claims.

---

## Phase 5 — Portrait Registration

**STATUS: IMPLEMENTED** — `tools/portrait-register.ps1`

Wires a Phase 4 DDS into the experiment mod:

```text
sd_dog_<name>.dds
  → portrait ID sd_dog_<name>
  → portraits definition (texturefile + no_texture selectors + mammalian greeting)
  → sd_static_test set (portraits + non_randomized_portraits)
  → Mammalian category already exposes sd_static_test (verified, not duplicated)
  → STOP
```

**Command:**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-register.ps1 -Source experiment\sd_static_portrait_test\gfx\models\portraits\sd_static_test\sd_dog_bruce.dds
```

**Safety:** refuses overwrite conflicts; idempotent when already registered identically; protects Piglet/Oakley/Angus DDS hashes; does not touch vanilla Stellaris.

**Does not claim** full in-game UI-context success — that remains the compatibility audit / later phases.

---

## Phase 6 — End-to-End Automation / Proof

**STATUS: IMPLEMENTED** — `tools/portrait-pipeline.ps1`

Thin orchestrator over the existing tools (no new architecture):

```text
new image in ImgHERE/
  → interactive portrait name
  → canonical PNG (Phase 3.1)
  → DDS (Phase 4)
  → registration (Phase 5)
  → STOP
```

**Command:**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-pipeline.ps1
```

**Phase 6 proof (Cedar):**

| Check | Result |
|-------|--------|
| New non-canonical candidate (`mystery_portrait.png`) | **CONFIRMED** |
| Interactive naming (`Cedar`) → `dog06_cedar_stellaris.png` | **CONFIRMED** |
| DDS `sd_dog_cedar.dds` (256×256, uncompressed 32-bit RGBA, `pfFlags=0x41`) | **CONFIRMED** |
| Registration `sd_dog_cedar` in definition + set | **CONFIRMED** |
| Piglet/Oakley/Angus DDS hashes unchanged | **CONFIRMED** |
| Idempotency (intake idle / DDS refuse / register already) | **CONFIRMED** |
| Failure safety (opaque candidate preserved; no partial registration) | **CONFIRMED** |
| Stellaris species-creation render for Cedar | **NEEDS VERIFICATION** (human in-game check) |

**Does not claim:** leaders/council/diplomacy/other UI contexts, Workshop readiness, or universal portrait compatibility.

### Generic custom-portrait purpose (product framing)

**Stellar Xeno** is the current project/repository name. Dogs were the original development and regression subjects, but the workflow is intended for arbitrary custom portrait subjects and multiple Stellaris xenotypes.

Workshop-facing branding should communicate custom portrait/race creation from your own images—not a dog-only tool.

### Future: portrait variants (NOT IMPLEMENTED)

Eventual support for multiple visual variants of the same custom portrait concept (similar to Stellaris leader portrait variants):

```text
Species Portrait
  ├── Variant 1
  ├── Variant 2
  ├── Variant 3
  └── Variant 4
```

Documented only. Do **not** implement variant IDs or redesign registration around this until a later phase explicitly schedules it.

---

## Phase 7 — Xenotype Selection / Generic Portrait Registration

**STATUS: IMPLEMENTED** — `tools/portrait-xenotypes.ps1` + xenotype-aware `portrait-register.ps1` / `portrait-pipeline.ps1`

Thin layer over the existing registration path (no new framework):

```text
Finished portrait / DDS
  → interactive xenotype menu (validated)
  → map to species_class + experiment set + category key
  → shared registration writes definition + set + category exposure
  → STOP
```

**Mapping** (from Stellaris 4.4.x `common/portrait_categories`):

| Xenotype | species_class | Set | Category |
|----------|---------------|-----|----------|
| Mammalian | MAM | `sd_static_test` (historical) | mammalians |
| Avian | AVI | `sd_static_test_avi` | avians |
| Reptilian | REP | `sd_static_test_rep` | reptilians |
| Aquatic / Amphibian (user-facing label) | AQUATIC | `sd_static_test_aquatic` | aquatics |
| Arthropoid | ART | `sd_static_test_art` | arthropoids |
| Molluscoid | MOL | `sd_static_test_mol` | molluscoids |
| Fungoid | FUN | `sd_static_test_fun` | fungoids |
| Plantoid | PLANT | `sd_static_test_plant` | plantoids |
| Lithoid | LITHOID | `sd_static_test_lithoid` | lithoids |
| Necroid | NECROID | `sd_static_test_necroid` | necroids |
| Machine | MACHINE | `sd_static_test_machine` | machines |

User-facing species-type menu uses plain names (Mammalian, Avian, …, Amphibian, …). Arrow keys + Enter select the type in a normal console; internal `species_class` / set / category mappings are unchanged.

**Phase 7 proof:**

| Check | Result |
|-------|--------|
| Liberty → Mammalian (`sd_static_test`) | **CONFIRMED** (files) |
| Sparrow → Avian (`sd_static_test_avi` + avians category) | **CONFIRMED** (files) |
| Invalid selection `0` / `99` / `abc` rejected | **CONFIRMED** |
| Idempotent re-register | **CONFIRMED** |
| Cross-xenotype move refused (conflict) | **CONFIRMED** |
| Piglet/Oakley/Angus/Bruce/Cedar DDS hashes | **CONFIRMED** unchanged |
| Liberty/Sparrow in-game species creation | **NEEDS VERIFICATION** |
| Other xenotypes in-game | **NEEDS VERIFICATION** (registration path **IMPLEMENTED**) |

Portrait variants remain **NOT IMPLEMENTED** (documented under Phase 6).

---

## Phase 8 — Failure Testing

**STATUS: PLANNED** (partial coverage already exercised in Phases 3.1–7)

Importer/pipeline must fail safely on:

- Invalid image
- Unsupported extension
- Missing alpha
- Malformed image
- Duplicate name
- Duplicate ID
- Multiple new images
- Missing conversion dependency
- Malformed portrait definition
- Interrupted processing

---

## Phase 9 — Documentation / UX

**STATUS: PARTIAL** — Player README + xenotype **prompt library** documented; some generation prompts still missing from source material

Completed in the documentation pass:

- [portrait-generation-prompts.md](portrait-generation-prompts.md) — xenotype image-generation prompts extracted from ChatGPT export (`Stellaris.html`)
- README explains: photograph → external prompt → `ImgHERE/` → Portrait Creator
- Toxoid: generation prompt **DOCUMENTED**; selector + registration **IMPLEMENTED** (`toxoids` / `TOX` / `tox_portrait_01`)
- Still absent from source export (not invented): **Mammalian** and **Machine** xenotype generation prompt bodies

README user workflow:

1. Choose a xenotype and generate a portrait with the matching prompt ([portrait-generation-prompts.md](portrait-generation-prompts.md))
2. Put it in `ImgHERE` (any filename)
3. Run `portrait-pipeline.ps1`
4. Enter the portrait's name
5. Select xenotype (including Toxoid)
6. Pipeline creates `dogNN_<name>_<xeno>_stellaris.png`, then DDS + registration under `mod/stellar_dogos/`
7. Launch Stellaris
8. Enable **Stellar Xeno** / test the portrait

Developer docs explain architecture.

---

## Phase 10 — Release Preparation

**STATUS: PACKAGE READY** (structural) — human Stellaris verification + Steam upload remain

Completed for Workshop packaging:

- Production mod is self-contained under `mod/stellar_dogos/`
- Package `descriptor.mod` has no developer absolute `path=`
- Workshop thumbnail (`thumbnail.png`) + `picture="thumbnail.png"`
- Paste-ready description: `mod/stellar_dogos/workshop_description.txt`
- Author steps: [workshop-release.md](workshop-release.md)

Still required before calling the release “verified”:

- Human in-game smoke test of shipped portraits
- Paradox Launcher → Upload Mod → Steam Workshop
- Confirm Steam-assigned `remote_file_id` after first upload

## Phase 11 — Steam Workshop

**STATUS: READY TO UPLOAD** (pending human test)

Only after:

- Fresh structural validation of `mod/stellar_dogos/` (done in release prep)
- Human in-game smoke test passes
- Workshop description/thumbnail acceptable

Then publish to Steam Workshop under **Stellar Xeno** branding that communicates **custom Stellaris portraits from your own images**.
---

## Engineering lesson — do not automate too early

The project intentionally performed several portraits **manually** before automation.

That discovered:

- Transparency requirements
- Halo / light-fringe problems
- Framing problems
- Scale differences
- DDS requirements
- Portrait registration requirements
- In-game behavior (species creation)

The importer must be built from this **proven** workflow, not from early assumptions.

---

## Regression protection

Treat **Piglet** and **Oakley** as protected regression fixtures.

- Importer must never silently rebuild existing portraits
- Before/after hashes during development
- Existing portraits change only when a task explicitly requests it
