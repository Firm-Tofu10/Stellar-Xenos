# Stellar Dogos — Development Roadmap

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
| Automated portrait importer | Partial: 3.1 intake + 4 DDS; registration = Phase 5 |
| Phase 3.1 source intake (interactive naming) | **IMPLEMENTED** (`tools/portrait-intake.ps1`) |
| Phase 4 DDS generation | **IMPLEMENTED** (`tools/portrait-dds.ps1`) |
| Full UI portrait compatibility | **NEEDS VERIFICATION** |
| Steam Workshop release | **NOT READY** |

Phase 3.1 + Phase 4 are available. **Portrait registration remains Phase 5** (not implemented).

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

**STATUS: Phase 3.1 IMPLEMENTED** (`tools/portrait-intake.ps1`); later Phase 3/4 DDS+registration still PLANNED

Before full implementation:

- Fresh Repomix snapshot when coding begins
- ChatGPT reconstructs repository
- Determine exact implementation files
- Define importer architecture (phased: 3.1 source prep → later DDS/registration)
- Define validation contracts
- Define failure behavior
- Define naming rules (canonical `dogNN_<name>_stellaris.png` is **internal**; users are not required to type it)

### Phase 3.1 — Source intake & preparation

**STATUS: IMPLEMENTED** — `tools/portrait-intake.ps1`

**User workflow:**

```text
Drop a dog image into ImgHERE
  → run tools/portrait-intake.ps1
  → enter the dog's name when prompted (mandatory; no bypass)
  → tool assigns the next available dog number
  → tool prepares the canonical source image
  → writes ImgHERE/dog##_<name>_stellaris.png and assets/source/...
  → deletes the temporary input from ImgHERE (success only)
  → STOP
```

Phase 3.1 ends at prepared canonical PNG sources. It does **not** create DDS, portrait IDs, or registration edits.

#### Interactive naming

Users must **not** be required to manually invent `dog04_…` filenames.

1. User places a supported image in `ImgHERE/` (any reasonable name; PNG/JPG/JPEG/WEBP at minimum).
2. Tool detects a new supported candidate (not already a canonical asset).
3. Tool asks in the console: `What is this dog's name?`
4. User enters the authoritative display name (e.g. `Liberty`).
5. Tool normalizes the name **only** as needed for a safe filename (`Liberty` → `liberty`).
6. Empty/invalid names: keep asking — do not invent a name. No `-DogName` bypass.
7. **After** a valid name, tool chooses the next free dog number from existing canonical sources.
8. Tool generates canonical filename: `dog##_<name>_stellaris.png`.
9. Tool validates/prepares the image (PNG, square, RGBA, real alpha — no artistic regen).
10. Canonical prepared source is written to:
    - `ImgHERE/dog##_<name>_stellaris.png`
    - `assets/source/dog##_<name>_stellaris.png`
11. On **success**, delete the temporary input from `ImgHERE`. On **failure**, leave it untouched.
12. **Stop.** No DDS / portrait ID / set / category / vanilla changes. No `_originals` archive.

Example:

```text
ImgHERE/my_dog.png
  → user enters "Liberty"
  → ImgHERE/dog04_liberty_stellaris.png
  → assets/source/dog04_liberty_stellaris.png
```

#### Automatic dog numbering

- Scan existing canonical Stellar Dogos source assets (e.g. `assets/source/dog##_…_stellaris.png` and matching ImgHERE canons).
- Next number = lowest unused integer after the highest present (today: dog01–dog03 → next is **dog04**).
- Do **not** reuse numbers, renumber existing dogs, or touch Piglet / Oakley / Angus.

#### Already-canonical files

If a file is already named `dog##_<name>_stellaris.png`:

- Do **not** ask for the name again
- Treat as an explicitly named canonical asset
- Validate/prepare normally
- Do **not** assign another number or create duplicate canons

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

Those remain later phases (Phase 5+ for registration; Phase 4 is DDS only).

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
`experiment/sd_static_portrait_test/gfx/models/portraits/sd_static_test/sd_dog_<name>.dds`

**Command:**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-dds.ps1 -Source assets\source\dog05_bruce_stellaris.png
```

**Safety:** refuses to overwrite an existing DDS; does not modify Piglet/Oakley/Angus; does not touch portrait defs/sets/categories or vanilla Stellaris.

**Explicitly outside Phase 4:** portrait IDs, definition/set/category registration, in-game claims.

---

## Phase 5 — Portrait Registration

**STATUS: PLANNED**

Wire a generated DDS into Stellaris:

1. Create/update portrait definition (`texturefile`)
2. Add portrait ID to portrait set
3. Ensure Mammalian category still exposes the set
4. Protect existing portraits (hash checks)
5. In-game verification

Do **not** treat Phase 4 DDS creation as registration success.

---

## Phase 6 — End-to-End Automation / Fourth-Dog Proof

**STATUS: PLANNED**

Do **not** use only Piglet/Oakley/Angus as the full-pipeline proof.

- New dog through intake → DDS → registration
- Verify existing dogs unchanged
- Verify new dog appears in-game

---

## Phase 7 — Failure Testing

**STATUS: PLANNED**

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

## Phase 8 — Documentation / UX

**STATUS: PLANNED**

README user workflow (TARGET):

1. Generate a portrait
2. Put it in `ImgHERE`
3. Run intake
4. Run DDS generator
5. (Later) registration → Launch Stellaris
6. Enable Stellar Dogos
7. Test the portrait

Developer docs explain architecture.

---

## Phase 9 — Release Preparation

**STATUS: PLANNED**

- Remove experimental/development-only artifacts where appropriate
- Rename experiment paths into production structure
- Clean repository
- Update README / version
- Test from a fresh clone
- Test packaged mod
- Verify no vanilla files are required
- Verify Workshop package contents

---

## Phase 10 — Steam Workshop

**STATUS: FUTURE**

Only after:

- Full pipeline works
- Compatibility audit complete
- Fresh-install test passes
- Documentation complete
- Production mod structure finalized

Then publish **Stellar Dogos** to Steam Workshop.

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
