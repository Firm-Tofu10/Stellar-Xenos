# Stellar Dogos — Portrait Workflow

This document preserves the complete process for turning a real dog photograph into a Stellaris-compatible static species portrait for the **Stellar Dogos** mod.

Use this when adding additional dogs later. Do not redesign the mod architecture for each new dog.

---

## 1. Goal

Take a real dog photograph and produce a Stellaris species portrait that:

- Looks visually appropriate for Stellaris mammalian species portraits.
- Preserves the real dog’s recognizable appearance.
- Has a **transparent** background (true alpha — not black/white fill).
- Uses composition appropriate for Stellaris species portraits.
- Converts cleanly into the DDS format required by the working implementation.
- Can be registered as another portrait without redesigning the mod.

---

## 2. Technical Modding Discovery

### Game version

The installation used for this work is **Stellaris Pegasus v4.4.6** (`modsCompatibilityVersion`: `4.4`).

### What vanilla does

- Live vanilla species portraits primarily use **3D `entity`** portraits (mesh + animation + `character_textures`).
- Vanilla portrait definition comments in `gfx/portraits/portraits/00_portraits_main.txt` still document alternate bindings, including **`texturefile`** (and `spriteType`), but **no live vanilla species portrait uses `texturefile`**.

### What we verified experimentally

The `texturefile` static-portrait mechanism was **not assumed** from vanilla usage. It was **confirmed experimentally** in Stellaris 4.4.6 with a minimal one-portrait test mod, then reused for Piglet.

Proof-of-concept / known-good technical details:

| Item | Working value |
|------|----------------|
| Portrait binding | `texturefile = "….dds"` |
| DDS size | **256×256** |
| DDS format | Uncompressed **32-bit RGBA** (`pfFlags = 0x41`) |
| Alpha | **Must be preserved** (transparent outside the dog) |
| Clothes | `clothes_selector = "no_texture"` |
| Attachments | `attachment_selector = "no_texture"` |
| Greeting | `greeting_sound = "mammalian_01_greetings"` |
| Species class | Portrait set uses `species_class = MAM` |
| UI exposure | Portrait set appended under the **Mammalian** category |

Registration flow:

1. Portrait definition (`portraits = { <id> = { … texturefile = … } }`)
2. Portrait set listing that ID (`species_class = MAM`)
3. Mammalian category including that set

---

## 3. Working Mod Pipeline

```text
Real dog photograph
  → generate Stellaris-style portrait (with reference photo)
  → ensure transparent background
  → ensure correct portrait composition
  → save high-resolution RGBA PNG
  → downscale to 256×256
  → convert to uncompressed 32-bit RGBA DDS
  → preserve alpha
  → place DDS under the mod's gfx portrait directory
  → point the portrait definition's texturefile at the DDS
  → launch Stellaris
  → verify in the species creation screen
```

### Current working paths (examples)

| Role | Path |
|------|------|
| Source art / references | `assets/source/` |
| Game-ready DDS (experiment) | `experiment/sd_static_portrait_test/gfx/models/portraits/sd_static_test/` |
| Portrait definitions | `experiment/sd_static_portrait_test/gfx/portraits/portraits/` |
| Portrait sets | `experiment/sd_static_portrait_test/common/portrait_sets/` |
| Mammalian category override | `experiment/sd_static_portrait_test/common/portrait_categories/` |

Keep **source PNGs** and **game-ready DDS** separate. Do not treat the DDS as the archival master.

---

## 4. Image Generation Process

### Sci-fi background version (rejected for final look)

The first generated portrait included a complete sci-fi background (space, planet, hex overlays, etc.).

- It **technically loaded** in Stellaris via `texturefile`.
- It **failed visually**: the entire square was opaque, so the dog sat inside an obvious rectangular plate.

### Transparency requirements (required going forward)

Image generation must require:

- Genuine transparency
- No background
- No scenery
- No planet
- No stars
- No hexagonal background
- No frame / border / UI / text / watermark
- Clean fur edges
- Dog completely opaque
- Everything outside the dog transparent

This solved the rectangular-background problem.

**Note:** Generators may still output an opaque near-white plate. If so, convert the plate to alpha (e.g. border flood-fill of near-white) **without** flattening onto black or white, then save as RGBA PNG before DDS conversion.

---

## 5. Portrait Composition Problem

### Transparent but floating (rejected)

The first transparent version still had **incorrect vertical framing**: too much empty transparent space under the chest compared with vanilla mammalian portraits. The dog looked like it was floating in the square.

### Corrected framing (preferred)

Regenerate with explicit composition requirements:

- Small amount of space above the ears
- Head in the upper-middle
- Subject occupies approximately **85–95%** of vertical space
- Chest/body fur extends to the **bottom edge**
- Bottom fur is **intentionally cropped** by the image boundary
- Little or no transparent space below the dog
- Dog appears **anchored** in the portrait, not floating

Visual relationship:

```text
TOP: small transparent space
  ↓
ears / head
  ↓
face
  ↓
neck / chest
  ↓
fur continues
  ↓
BOTTOM EDGE — fur cropped by the frame
```

This became the current Piglet portrait composition.

---

## 6. Image Generation Prompt

Reusable prompt for future dogs. Replace the dog’s name and subject-specific appearance lines; keep composition and transparency requirements intact.

```text
Create a Stellaris-style mammalian species portrait using the provided Piglet image as the exact subject reference.

The goal is to create a final portrait that matches the framing and subject placement of vanilla Stellaris mammalian species portraits.

SUBJECT:
- Preserve Piglet's exact recognizable appearance.
- Preserve the black, white, and tan tri-color coat.
- Preserve the white facial blaze.
- Preserve the tan markings above the eyes and on the cheeks.
- Preserve the fluffy chest and neck fur.
- Preserve the semi-floppy ears.
- Preserve the natural amber/brown eyes and facial structure.
- Do not turn Piglet into a generic Australian Shepherd.

STYLE:
- Realistic, detailed digital painting.
- Stellaris-style mammalian species portrait.
- Detailed individual fur.
- Naturalistic anatomy.
- Soft directional lighting.
- Subtle rim lighting.
- Slightly desaturated but rich colors.
- No cartoon styling.
- No outlines.

CRITICAL COMPOSITION REQUIREMENT:

Match the vertical framing of the existing vanilla Stellaris mammalian portraits.

- Piglet should fill substantially more of the portrait vertically.
- The head should occupy the upper-middle portion of the image.
- The chest and body fur should continue all the way to the BOTTOM EDGE of the image.
- The lower chest/body should be intentionally cropped by the bottom edge.
- There should be LITTLE TO NO TRANSPARENT SPACE underneath Piglet.
- Do NOT leave a large transparent margin beneath the chest.
- The bottom of Piglet's fur should extend beyond the image boundary, exactly as a portrait subject would be cropped by the portrait frame.
- Keep the ears and top of the head comfortably inside the image.
- Keep a small amount of breathing room above the ears.
- Do not make the dog appear to be floating in the center of a square.
- The subject should occupy approximately 85–95% of the available vertical portrait area.

The important visual relationship is:

TOP:
small amount of transparent space
↓
Piglet's ears/head
↓
face
↓
neck/chest
↓
fur continues
↓
BOTTOM EDGE — fur is cropped by the image boundary

TRANSPARENCY:
- Piglet must remain completely opaque.
- Everything outside the Piglet silhouette must be genuinely transparent.
- No background.
- No stars.
- No planet.
- No hexagons.
- No scenery.
- No frame.
- No border.
- No rectangular background.
- Preserve individual fur wisps around the silhouette.
- No halo or colored fringe.

LIGHTING:
- Lighting should remain natural and dimensional even without a background.
- Use subtle rim lighting to separate the dog from a transparent background.
- Do not create a visible artificial glow around the silhouette.

TECHNICAL:
- Square image.
- High resolution.
- Genuine RGBA alpha channel.
- Designed specifically to be downscaled to 256×256.
- No text.
- No logos.
- No UI.
- No watermark.

The final result should look like Piglet is occupying the same amount of vertical space as a normal vanilla Stellaris mammalian portrait, with his chest/body continuing beyond the bottom edge rather than ending with a large transparent area underneath.
```

When generating for another dog:

1. Attach a clear reference photo of that dog.
2. Replace every “Piglet” / breed-specific line with that dog’s name and true markings.
3. Keep the composition, transparency, lighting, and technical sections unchanged.

---

## 7. Asset Preparation

### Successful source

- High-resolution square **RGBA PNG** (Piglet framed master: **1024×1024**).
- Real transparency outside the silhouette.
- Dog opaque / near-opaque.
- Composition already correct **before** DDS conversion.

### Successful DDS

| Property | Value |
|----------|--------|
| Size | **256×256** |
| Compression | **Uncompressed** |
| Channels | **32-bit RGBA** |
| Header flag | `pfFlags = 0x41` (RGB + alpha) |
| Outside dog | Transparent (`A = 0`) |
| Dog body | Opaque / near-opaque |

### Critical rule

**Do not flatten** the image onto black, white, or any other color before DDS conversion.

The **alpha channel is critical**. Flattening destroys the cutout and recreates the rectangular-plate problem (or a hard silhouette on a solid plate).

Pipeline reminder:

1. Finalize art as RGBA PNG (composition + transparency done).
2. Downscale to 256×256 **while preserving alpha**.
3. Write uncompressed 32-bit RGBA DDS.
4. Spot-check corners (`A = 0`) and bottom-center (fur / opaque).

---

## 8. Verification Process

In-game testing procedure:

1. Enable the test mod in the Stellaris launcher.
2. Start Stellaris.
3. Create an empire.
4. Select **Mammalian**.
5. Locate the custom dog portrait.
6. Verify the portrait appears.
7. Check transparency (no rectangular plate).
8. Check vertical framing (chest cropped at bottom; not floating).
9. Confirm the dog looks anchored in the portrait frame.
10. Only after successful testing treat the portrait as complete.

Until step 10 passes, keep the previous working DDS as a backup.

---

## 9. Iteration History

### Iteration 1 — Sci-fi background

- Dog with full sci-fi background.
- Technically loaded via `texturefile`.
- Failed visually: entire square opaque → obvious rectangular image.

### Iteration 2 — Transparent, wrong framing

- Transparent background.
- Rectangular plate problem solved.
- Failed visually: too much transparent space beneath the chest → floating look.

### Iteration 3 — Transparent + corrected framing (preferred)

- Transparent background.
- Corrected vertical framing.
- Chest/body reaches the bottom edge and is cropped by the frame.
- Current preferred composition (Piglet).

---

## 10. Reusable Workflow for Future Dogs

Checklist for adding another dog:

1. Obtain a clear reference photo.
2. Generate the portrait using the reusable prompt (Section 6), with that dog’s details.
3. Verify the dog is recognizable as that individual.
4. Verify transparent background (true alpha).
5. Verify correct vertical composition (Section 5).
6. Save as high-resolution RGBA PNG.
7. Add the source PNG to `assets/source/`.
8. Convert to **256×256** uncompressed **32-bit RGBA** DDS.
9. Preserve alpha throughout.
10. Choose a unique portrait ID (e.g. `sd_dog_<name>`).
11. Add the DDS under the mod gfx portrait directory (same pattern as the experiment).
12. Add the portrait ID to the portrait definition and the Mammalian portrait set.
13. Test in Stellaris (Section 8).
14. Keep a backup of the previous working asset until the new one is verified.

---

## 11. Important Lessons

- Do **not** assume vanilla’s current 3D/`entity` portraits mean static portraits are impossible.
- Verify questionable modding behavior **experimentally** (placeholder first).
- Test with a placeholder before committing real artwork.
- Keep source images separate from game-ready assets.
- Preserve alpha all the way through the pipeline.
- **Composition matters as much as technical compatibility.**
- A transparent image can still look wrong if the subject is positioned incorrectly.
- Generate the portrait specifically for the game’s framing; do not rely on DDS conversion to “fix” framing.
- Keep backups during asset iteration.

---

## Current Known-Good Configuration

| Item | Status / value |
|------|----------------|
| Game | Stellaris **Pegasus 4.4.6** |
| Static portraits via `texturefile` | **Experimentally confirmed** in-game |
| Working experiment mod | `experiment/sd_static_portrait_test/` |
| Current dog | **Piglet** |
| Portrait ID | `sd_dog_piglet` |
| Source master | `assets/source/piglet_stellaris_portrait_framed.png` (1024×1024 RGBA) |
| Active DDS | `experiment/sd_static_portrait_test/gfx/models/portraits/sd_static_test/sd_dog_piglet.dds` |
| DDS specs | 256×256, uncompressed 32-bit RGBA, alpha preserved |
| Species class | `MAM` (Mammalian) |
| Selectors | `no_texture` / `no_texture` |
| Greeting | `mammalian_01_greetings` |

This configuration is the reference for expanding from one dog to many without redesigning the mod.
