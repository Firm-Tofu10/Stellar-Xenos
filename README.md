# Stellar Dogos

**Stellar Dogos** is a Stellaris **4.4.x** project for turning **your own photographs** into selectable custom species portraits.

Dogs were the original development and test subjects — that is why the repository is named Stellar Dogos. The real goal is broader: take a photo of a person, animal, or other subject, transform that subject into a believable Stellaris species of a chosen **xenotype**, then place the finished portrait into the game through this project's tools.

You do **not** need to know PowerShell, DDS files, portrait definitions, or mod scripting to use the normal workflow.

---

## How it works (two stages)

### Stage A — Image generation (outside this software)

1. Take or obtain a **reference photograph**.
2. Choose the Stellaris **xenotype** you want (Mammalian, Avian, Reptilian, …).
3. Open the matching prompt in the **[portrait generation prompt library](docs/portrait-generation-prompts.md)**.
4. Paste that prompt into an **image-generation model** (for example ChatGPT) **with your photograph**.
5. Generate a square, transparent Stellaris-style portrait that still looks like *your* subject as that species.

These prompts are **not** Stellar Dogos software commands. They do **not** create DDS files and do **not** modify Stellaris.

### Stage B — Portrait Creator (this repository)

6. Put the finished image into `ImgHERE/`.
7. Run the Portrait Creator (command below).
8. Enter the **character's name**.
9. Select the **Stellaris species type** (should match the prompt you used).
10. Stellar Dogos prepares the technical game files and registers the portrait in the experiment mod.
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
Portrait Creator (name + species type)
        │
        ▼
Stellaris (experiment mod)
```

---

## Status

| Item | State |
|------|--------|
| Image-generation prompt library (xenotype prompts) | **DOCUMENTED** — see [docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md) |
| Technical pipeline (intake → DDS → register) | **IMPLEMENTED** / working |
| Interactive species-type selector | **IMPLEMENTED** for the types listed in the tool (not Toxoid) |
| Toxoid generation prompt | **DOCUMENTED** |
| Toxoid in Portrait Creator selector | **NOT YET IMPLEMENTED** (intentional) |
| Species creation (Piglet / Oakley / Angus) | **CONFIRMED** on Stellaris **v4.4.6** |
| Full UI compatibility (leaders, diplomacy, …) | **NEEDS VERIFICATION** |
| Steam Workshop | **FUTURE** / not ready |
| Leader portrait variants | **FUTURE** |

---

## Prompt library

Full xenotype prompts live here:

**[docs/portrait-generation-prompts.md](docs/portrait-generation-prompts.md)**

Each documented prompt is meant to preserve the reference subject's identity while transforming biology to that Stellaris xenotype (not a generic alien, and not a human with a costume).

**Note:** In the current source export, **Mammalian** and **Machine** generation prompts were **not present** as full prompt bodies. **Toxoid** is documented as a generation prompt only. See the inventory table in that file.

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
6. Select the Stellaris species type with **↑ / ↓**, then **Enter**.
7. Wait for success, then enable the experiment mod in Stellaris.

You do **not** need to manually create DDS files, portrait IDs, definitions, sets, categories, or dog numbers. The tool handles those.

### What you will see (summary)

```text
Stellar Dogos - Portrait Creator

New portrait found:
  your_image.png

What is this character's name?
> …

Which Stellaris species type should this portrait belong to?
…

✓ Portrait created successfully!
```

### Toxoid reminder

You can use the **Toxoid** image-generation prompt from the library to create artwork, but the Portrait Creator **does not yet** offer Toxoid in its species-type menu. Registering Toxoid portraits is a **future** software task.

---

## Enable the mod in Stellaris

Working mod folder: `experiment/sd_static_portrait_test/`

1. Point a `.mod` descriptor at that folder if needed.
2. In the launcher, enable **SD Static Portrait Test**.
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
7. Play Stellaris with the experiment mod enabled.

---

## Future work (not implemented)

- Toxoid in the interactive selector / registration path  
- Leader portrait variants  
- Changing xenotype on an existing portrait  
- Broader verification across Stellaris UI contexts  
- Workshop packaging  
- Multiple xenotype versions of the same person/character  

---

## Development notes

Phases (internal):

- **Phase 3.1** — portrait intake and preparation  
- **Phase 4** — DDS generation  
- **Phase 5/7** — registration and species-type selection  
- **Phase 6** — end-to-end Portrait Creator  
- **Phase 8** — documentation of the generation prompt library and player workflow (**this pass**)

Planning docs: [PROJECT_PLAN.md](PROJECT_PLAN.md), [docs/development-roadmap.md](docs/development-roadmap.md), [docs/portrait-workflow.md](docs/portrait-workflow.md).
