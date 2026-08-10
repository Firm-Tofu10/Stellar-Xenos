# Stellar Dogos — Portrait Workflow

Authoritative **image → DDS → Stellaris** pipeline for static dog portraits.

Related:

- [portrait-prompts.md](portrait-prompts.md) — generation prompts
- [portrait-testing.md](portrait-testing.md) — in-game matrix
- [development-roadmap.md](development-roadmap.md) — phases
- [PROJECT_PLAN.md](../PROJECT_PLAN.md) — goals / current state

---

## Certainty labels

| Label | Meaning |
|-------|---------|
| **CONFIRMED** | Observed in Stellaris 4.4.6 or verified on disk |
| **ASSUMPTION** | Reasonable design choice, not independently proven |
| **TARGET** | Desired behavior we are designing toward |
| **NEEDS VERIFICATION** | Requires more game testing or inspection |

---

## 1. Goal

Turn a real dog photograph into a selectable Mammalian species portrait that:

- Preserves the dog’s recognizable identity
- Uses Stellaris-compatible static `texturefile` art
- Has genuine alpha transparency
- Uses established framing
- Registers without redesigning the mod each time

Current dogs: **Piglet**, **Oakley**, **Angus** (more later).

---

## 2. Stellaris environment & vanilla research

**CONFIRMED** — Installed game: **Pegasus v4.4.6**; `modsCompatibilityVersion = 4.4`.

Inspected (read-only) among others:

- `common/portrait_categories`
- `common/portrait_sets`
- `common/species_classes`
- `gfx/portraits/portraits`
- `gfx/models/portraits`
- `gfx/portraits/asset_selectors`
- sprite configuration / leader backgrounds
- relevant localisation / configuration

**CONFIRMED** — Live vanilla species portraits primarily use `entity = …` (3D).

**CONFIRMED** — Vanilla comments still document alternate bindings including `spriteType` and `texturefile`. Those were **not** treated as automatically valid.

**CONFIRMED (experimental)** — Static 2D species portraits using `texturefile` **work in Stellaris 4.4.6**. Proven by the experiment mod, not by a live vanilla static species portrait.

Do not describe `texturefile` as merely theoretical. Do not claim vanilla currently ships species portraits this way.

---

## 3. Proof-of-concept path

Working experiment:

`experiment/sd_static_portrait_test/`

Established chain:

```text
portrait definition
  → texturefile
  → 256×256 RGBA DDS
  → portrait set (species_class = MAM)
  → Mammalian category (set appended)
  → Stellaris species creation screen
```

Working portrait fields (**do not invent extra syntax**):

```text
clothes_selector = "no_texture"
attachment_selector = "no_texture"
greeting_sound = "mammalian_01_greetings"
texturefile = "gfx/models/portraits/sd_static_test/<file>.dds"
```

---

## 4. Current dogs

| Dog | Portrait ID | DDS | Status |
|-----|-------------|-----|--------|
| Piglet | `sd_dog_piglet` | `sd_dog_piglet.dds` | **WORKING IN-GAME** (species creation) — **protected** |
| Oakley | `sd_dog_02` | `sd_dog_02.dds` | **WORKING IN-GAME** — **gold standard / protected** |
| Angus | `sd_dog_angus` | `sd_dog_angus.dds` | **FUNCTIONALLY WORKING IN-GAME** — regenerated ImgHERE art |

### Piglet notes

Iterations:

1. Sci-fi opaque background → rectangular plate (bad)
2. Transparent but floating (too much empty space under chest)
3. Transparent + bottom-edge crop
4. Halo cleanup (~1488 → ~29 light-fringe pixels) + uniform scale ~**+8%**
5. Final ~**92%** vertical fill, ~**20px** top margin at 256×256, bottom flush

Do **not** casually regenerate Piglet.

### Oakley notes

Strongest visual reference. ~**91%** vertical fill, ~**23px** top margin, bottom flush. Do not modify unless a task explicitly requires it.

### Angus notes

Initial implementation used a raw photo cutout. Regenerated Stellaris-style art from `ImgHERE/dog03_angus_stellaris.png` was wired to the same ID and displays in-game. Current scale/framing was accepted; further normalization deferred until side-by-side review.

---

## 5. ImgHERE staging

`ImgHERE/` is the human-facing **intake/staging** folder for finished/generated portrait artwork (and, for Phase 3.1 tooling, newly dropped candidate images).

### Canonical internal filename (pipeline format)

The pipeline’s stable internal name remains:

`dog##_<name>_stellaris.png`

Examples already in use:

- `dog01_piglet_stellaris.png`
- `dog02_oakley_stellaris.png`
- `dog03_angus_stellaris.png`

Users are **not** required to invent or type this format. Numbering and canonical renaming are tool responsibilities (Phase 3.1 design).

### Phase 3.1 user flow (**IMPLEMENTED** — `tools/portrait-intake.ps1`)

```text
Drop a dog image into ImgHERE
  → run tools/portrait-intake.ps1
  → enter the dog's name when prompted
  → tool assigns the next available dog number
  → tool prepares the canonical source image
```

Supported drop formats: PNG, JPG/JPEG, WEBP (System.Drawing must be able to load the file). Preparation converts to a square RGBA PNG source.

```text
ImgHERE/<any supported image>
  → console: "What is this dog's name?" / "> "
  → e.g. Liberty → dog04_liberty_stellaris.png
  → ImgHERE/dog04_liberty_stellaris.png
  → assets/source/dog04_liberty_stellaris.png
  → temporary input deleted from ImgHERE after successful validation
  → STOP (Phase 3.1)
```

If a file is **already** named `dog##_<name>_stellaris.png`, do not ask again — it is reported as canonical.

Conflicts: if the target canonical name already exists, stop and explain; never overwrite existing canons.

Empty names are rejected and the tool keeps asking. Naming is always interactive for new candidates (no `-DogName` bypass).

Do not treat every file in `ImgHERE` as a new dog (ignore unsupported extensions). See [development-roadmap.md](development-roadmap.md) Phase 3.1.

**Rules:**

- Finished portraits and new candidates go in the ImgHERE root for intake
- Raw reference photographs that are not finished portraits should not be auto-ingested
- On **success**, the temporary input image is removed from `ImgHERE`
- On **failure**, the original input remains untouched in `ImgHERE` for retry
- The tool does **not** maintain an `_originals` archive

Later phases add DDS + Stellaris registration.

---

## 6. Current manual pipeline (**CONFIRMED** working)

Still valid for developers who prepare canons by hand. Preferred future intake is interactive naming (Section 5).

```text
Generated portrait
  ↓
ImgHERE/   (drop any supported image; tool will name — or use existing canon)
  ↓
copy / write prepared canon to assets/source/dog##_<name>_stellaris.png
  ↓
validate alpha
  ↓
background → alpha only if needed (no art regen)
  ↓
── Phase 3.1 ends above; below is later ──
  ↓
256×256 (preserve alpha; fit without inventing opaque plate)
  ↓
uncompressed 32-bit RGBA DDS (pfFlags=0x41)
  ↓
gfx/models/portraits/sd_static_test/<id>.dds
  ↓
portrait definition (texturefile)
  ↓
portrait set sd_static_test
  ↓
Mammalian category
  ↓
Stellaris
  ↓
in-game test
```

Canonical source intake is automated by `tools/portrait-intake.ps1`. DDS and Stellaris registration remain later phases. See [development-roadmap.md](development-roadmap.md).

Paths:

| Role | Path |
|------|------|
| Staging | `ImgHERE/` |
| Source archive | `assets/source/` |
| Game DDS | `experiment/sd_static_portrait_test/gfx/models/portraits/sd_static_test/` |
| Portrait defs | `experiment/sd_static_portrait_test/gfx/portraits/portraits/` |
| Portrait sets | `experiment/sd_static_portrait_test/common/portrait_sets/` |
| Category override | `experiment/sd_static_portrait_test/common/portrait_categories/` |

Keep source PNGs and game DDS separate.

---

## 7. Image composition rules

Based on Piglet and Oakley.

| Rule | Label |
|------|--------|
| Bottom-edge crop works | **CONFIRMED** |
| ~91–92% vertical fill looks correct in species UI | **CONFIRMED** (empirical) |
| Small top margin works | **CONFIRMED** |
| Future portraits should initially target the same proportions | **ASSUMPTION / TARGET** |
| Whether values should be fully automated | **NEEDS VERIFICATION** |
| Whether all Stellaris portrait contexts need identical framing | **NEEDS VERIFICATION** |

Target composition:

- ~91–92% vertical subject fill
- Small transparent margin above ears
- Large dominant head / bust
- Chest/body reaches bottom edge
- Little/no transparent space under the dog
- Subject must not float mid-canvas

---

## 8. Transparency / alpha rules

**CONFIRMED** requirements for game assets:

- Genuine alpha channel
- Dog opaque / near-opaque
- Outside silhouette transparent
- No rectangular background
- No halo / colored fringe (minimize; fine fur may retain tiny residual)
- Preserve fine fur edges
- Never flatten transparency onto white/black/gray

**Piglet halo lesson:** Cutting out against a light background can leave a white/light fringe. Cleanup reduced fringe pixels ~1488 → ~29. Oakley showed a cleaner edge.

Future importer must **validate** alpha, not assume it.

---

## 9. DDS requirements

**CONFIRMED** empirical game format for this project (matches Piglet/Oakley/Angus):

| Property | Value |
|----------|--------|
| Size | **256×256** |
| Compression | **Uncompressed** (no FourCC / DXT) |
| Channels | **32-bit RGBA** |
| `pfFlags` | **0x41** |
| Pitch | **1024** |
| Mipmaps | **0** |
| Caps | **0x1000** |
| Alpha | Preserved; transparent outside dog |

High-resolution canonical PNGs stay in `assets/source/`. DDS is the game texture only.

### Phase 4 tool

`tools/portrait-dds.ps1` converts:

`assets/source/dog##_<name>_stellaris.png` → `…/sd_static_test/sd_dog_<name>.dds`

It validates the source, refuses overwrite conflicts, and compares the DDS header to the Piglet reference. It does **not** register portraits (Phase 5).

---

## 10. Future portrait importer (summary)

See [development-roadmap.md](development-roadmap.md):

- Phase 3.1 — intake / naming / source PNG (**done**)
- Phase 4 — DDS (**done**)
- Phase 5 — Stellaris registration (**planned**)

Must protect existing portraits and never touch vanilla.

**Do not automate too early** — manual portraits taught the real constraints.

---

## 11. Verification (species creation)

1. Enable experiment mod in launcher
2. Empire creation → Mammalian
3. Select dog portrait
4. Check appearance, transparency, framing
5. Keep previous DDS backup until verified

Full UI matrix: [portrait-testing.md](portrait-testing.md).

---

## 12. Important lessons

- Do not assume vanilla `entity` portraits mean static portraits are impossible
- Verify questionable modding experimentally
- Composition matters as much as technical compatibility
- Transparent art can still look wrong if framing is wrong
- Generate for framing; do not expect DDS conversion to fix composition
- Protect Piglet/Oakley as regression fixtures
- Document before automating
