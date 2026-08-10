<<<<<<< HEAD
# Stellar Xeno

**Stellar Xeno** is a Stellaris **4.4.x** project for turning **your own photographs** into selectable custom species portraits.
=======
# Stellar-Xenos

**Stellar-Xenos** is a Stellaris **4.4.x** project for turning **your own photographs** into selectable custom species portraits.
>>>>>>> d211941543db12f146c56ee810c93f7eb04e14d2

Dogs were the original development and regression subjects (Piglet, Oakley, Angus, and later fixtures), but **Stellar Xeno** is not limited to dogs. The workflow is intended for arbitrary custom portrait subjects—people, animals, or other references—transformed into a believable Stellaris species of a chosen **xenotype**, then registered into the game through this project's tools.

You do **not** need to know PowerShell, DDS files, portrait definitions, or mod scripting to use the normal workflow.

---

## How it works (two stages)

### Stage A — Image generation (outside this software)

1. Take or obtain a **reference photograph**.
2. Choose the Stellaris **xenotype** you want (Mammalian, Avian, Reptilian, …).
3. Open the matching prompt in the **[portrait generation prompt library](docs/portrait-generation-prompts.md)**.
4. Paste that prompt into an **image-generation model** (for example ChatGPT) **with your photograph**.
5. Generate a square, transparent Stellaris-style portrait that still looks like *your* subject as that species.

These prompts are **not** Stellar Xeno software commands. They do **not** create DDS files and do **not** modify Stellaris.

### Stage B — Portrait Creator (this repository)

6. Put the finished image into `ImgHERE/`.
7. Run the Portrait Creator (command below).
8. Enter the **character's name**.
9. Select the **Stellaris species type** (should match the prompt you used).
10. Stellar Xeno prepares the technical game files and registers the portrait in the production mod.
11. Enable the mod in Stellaris and create a species of that type to find your portrait.

```text
Reference Photograph
        │
        ▼
Xenotype-specific generation prompt  ← docs/portrait-generation-prompts.md
        │
        ▼
Generated Stellaris-style portrait
        │
        ▼
ImgHERE/
        │
        ▼
Portrait Creator (name → species type → canonical filename)
        │
        ▼
Stellaris (mod/stellar_dogos)
```

---

## Status

| Item | State |
|------|--------|
| Image-generation prompt library (xenotype prompts) | **DOCUMENTED** — see [docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md) |
| Technical pipeline (intake → DDS → register) | **IMPLEMENTED** / working |
| Interactive species-type selector | **IMPLEMENTED** (12 types, including Toxoid) |
| Toxoid generation prompt | **DOCUMENTED** |
| Toxoid in Portrait Creator selector / registration | **IMPLEMENTED** (Stellaris 4.4.x `toxoids` / `TOX`) |
| Canonical PNG naming (`dogNN_<name>_<xeno>_stellaris.png`) | **IMPLEMENTED** |
| Species creation (Piglet / Oakley / Angus) | **CONFIRMED** on Stellaris **v4.4.6** |
| Full UI compatibility (leaders, diplomacy, …) | **NEEDS VERIFICATION** |
| Steam Workshop | **PACKAGE READY** for human in-game test + launcher upload (`mod/stellar_dogos/`; see [docs/workshop-release.md](docs/workshop-release.md)) |
| Leader portrait variants | **FUTURE** |

---

## Prompt library

Full xenotype prompts live here:

**[docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md)**

Each documented prompt is meant to preserve the reference subject's identity while transforming biology to that Stellaris xenotype (not a generic alien, and not a human with a costume).

**Note:** In the current source export, **Mammalian** and **Machine** generation prompts were **not present** as full prompt bodies. **Toxoid** has a documented generation prompt and is also available in the Portrait Creator selector. See the inventory table in that file.

Older dog-development framing prompts remain in [docs/portrait-prompts.md](docs/portrait-prompts.md).

---

## Adding a portrait with the Portrait Creator

### What you do

1. Generate (or otherwise obtain) a finished portrait image using the prompt library when applicable.
2. Place the image into `ImgHERE/`.
3. Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\portrait-pipeline.ps1
```

4. The tool shows which image it found.
5. Enter the character's name.
6. Select the Stellaris species type with **↑ / ↓**, then **Enter** (includes **Toxoid**).
7. Wait for success, then enable the **Stellar Xeno** production mod in Stellaris.

You do **not** need to manually create DDS files, portrait IDs, definitions, sets, categories, or dog numbers. The tool handles those. Candidate filenames in `ImgHERE/` are never interpreted as the character name, xenotype, or sequence number.

### What you will see (summary)

```text
Stellar Xeno - Portrait Creator

New portrait found:
  your_image.png

What is this character's name?
> Lemon

Which Stellaris species type should this portrait belong to?
This determines which Stellaris species category the portrait will appear under.
Use ↑ / ↓ to choose, then press Enter.
  Mammalian
  …
> Reptilian
  …
  Toxoid

✓ Reptilian selected.
Preparing your portrait...

✓ Portrait created successfully!
Name: Lemon
Species type: Reptilian
```

Canonical source filename example: `dog06_lemon_rep_stellaris.png`  
DDS / portrait ID stay name-based: `sd_dog_lemon.dds` / `sd_dog_lemon`

### Filename abbreviations (canonical PNGs only)

| Xenotype | Filename abbreviation |
|----------|-----------------------|
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

---

## Enable the mod in Stellaris

Working mod folder: `mod/stellar_dogos/`

(`experiment/sd_static_portrait_test/` remains as a temporary regression/reference copy until a later cleanup task.)

1. Point a `.mod` descriptor at `mod/stellar_dogos/` if needed (forward slashes; no developer-only absolute path required inside the package `descriptor.mod`).
2. In the launcher, enable **Stellar Xeno**.
3. Create an empire → pick the species type you chose → select your portrait.

Do **not** edit the vanilla Stellaris installation.

---

## Example (human photo → Avian)

1. Reference: a photograph of yourself.
2. Open the **Avian** prompt in [docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md).
3. Generate with your photo attached → result should feel like *you* as an Avian Stellaris species.
4. Save into `ImgHERE/` (any temporary filename is fine).
5. Run `tools\portrait-pipeline.ps1`.
6. Enter a name; select **Avian**.
7. Play Stellaris with the **Stellar Xeno** production mod enabled.

---

## Future work (not implemented)

- Leader portrait variants  
- Changing xenotype on an existing portrait  
- Broader verification across Stellaris UI contexts  
- Workshop packaging / upload (package prepared; human Stellaris test + Steam upload remain)  
- Multiple xenotype versions of the same person/character  

---

## Development notes

Phases (internal):

- **Phase 3.1** — portrait intake and preparation  
- **Phase 4** — DDS generation  
- **Phase 5/7** — registration and species-type selection  
- **Phase 6** — end-to-end Portrait Creator  
- **Phase 8** — documentation of the generation prompt library and player workflow (**this pass**)

Technical path identifiers such as `mod/stellar_dogos/` and `sd_dog_*` are internal implementation names and are intentionally unchanged.
