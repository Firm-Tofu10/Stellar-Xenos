# Stellar Xeno — Portrait Generation Prompts

> **Xenotype prompt library (Phase 8):**  
> For the full set of **xenotype-specific** image-generation prompts extracted from the ChatGPT source export, see **[portrait-generation-prompts.md](portrait-generation-prompts.md)**.  
> Those prompts are for an external image model (not pipeline commands). **Toxoid** is implemented in the Portrait Creator selector and registration path (same as the other xenotypes).

Successful **dog-development** image-generation prompts and related refinement instructions developed during early Stellar Xeno sessions are preserved below.

Use these to reproduce the early artwork workflow. Technical conversion (PNG → DDS → registration) is documented in [portrait-workflow.md](portrait-workflow.md).

---

## Asset stages (do not confuse)

| Stage | Role |
|-------|------|
| **SOURCE PHOTO** | Authoritative reference for identity, coat, markings, face, ears, eyes, muzzle, proportions |
| **GENERATED PORTRAIT** | Stellaris-style artwork produced from the photo (finished PNG for `ImgHERE/`) |
| **GAME ASSET** | Converted **256×256** uncompressed **32-bit RGBA** DDS used by Stellaris |

The photo preserves who the dog is. The generated portrait is the game art. The DDS is the shipped texture.

---

## Style goals (all generation prompts)

The generated image should transform the dog into a realistic Stellaris-style mammalian portrait:

- Realistic painterly rendering
- Detailed fur
- Natural anatomy
- Stellaris-compatible visual style
- No cartoon / anime styling
- No text, logos, UI, watermark, or decorative frame

---

## 1. Base Stellaris dog portrait prompt

Successful framing + transparency prompt (originally used for Piglet). For other dogs, replace subject-specific lines and attach that dog’s reference photo; keep STYLE / COMPOSITION / TRANSPARENCY / TECHNICAL sections intact.

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

---

## 2. Transparent-background requirements

Always include (or enforce) these when generating or accepting a finished portrait:

```text
TRANSPARENCY REQUIREMENTS:
- Genuine transparency (real alpha channel) — not a fake checkerboard baked into RGB
- No background
- No scenery
- No planet
- No stars
- No hexagonal / sci-fi plate background
- No frame / border / UI / text / watermark
- Clean fur edges
- Dog completely opaque (or near-opaque)
- Everything outside the dog silhouette transparent
- No halo or colored fringe
- Do not flatten transparency onto white, black, or gray
```

**Lesson:** An opaque sci-fi background can load in Stellaris but produces an obvious rectangular plate. Transparency fixed that.

**Lesson:** Generators may still emit an opaque near-white plate. If so, convert only that plate to alpha (e.g. border flood-fill of near-white) **without** regenerating art and **without** flattening onto a solid color — then save RGBA PNG before DDS conversion.

---

## 3. Stellaris portrait framing requirements

```text
FRAMING REQUIREMENTS:
- Small transparent margin above the ears
- Head in the upper-middle of the canvas
- Large dominant head / portrait bust
- Subject fills approximately 85–95% of vertical space (empirical target ~91–92% for Piglet/Oakley)
- Chest/body/fur reaches the BOTTOM EDGE
- Bottom fur is intentionally cropped by the frame
- Little or no transparent space beneath the dog
- Dog must not appear to float in the center of the square
```

Visual stack:

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

See also certainty labels in [portrait-workflow.md](portrait-workflow.md) § composition rules.

---

## 4. Scale-normalization prompt / instructions

Used when one dog looks smaller than another **after** both already have correct bottom-edge framing. Do **not** regenerate artwork; scale uniformly.

Reference dog for scale: **Oakley** (`sd_dog_02`) — gold standard (~91% vertical fill, ~23px top margin at 256×256).

```text
SCALE NORMALIZATION (do not regenerate art):

The reference portrait (Oakley / Chocolate Lab) currently looks correctly sized.
Bring the target dog to approximately the same visual size when both are shown at the same Stellaris portrait size.

- Increase or decrease overall subject scale only slightly (approximately 5–10% as a starting point)
- Adjust based on measured fill of the existing assets
- Scale/reframe the existing artwork uniformly

Do NOT:
- stretch the dog
- change proportions
- enlarge the head independently
- alter anatomy
- regenerate the artwork

Maintain:
- small transparent margin above the ears
- similar head-to-canvas ratio to the reference
- chest/body reaching the bottom edge
- intentional bottom-edge crop
- little/no transparent space beneath the dog
- square 256×256 game output with preserved alpha
```

**CONFIRMED example:** Piglet was uniformly scaled approximately **+8%** after halo cleanup; final vertical fill ~**92%**, top margin ~**20px** at 256×256, bottom flush/cropped.

---

## 5. Piglet refinement / halo cleanup prompt

Used after in-game observation of a thin white/light halo around Piglet’s fur. Dog #2 (Oakley) was the scale reference and was **not** modified.

```text
PIGLET ALPHA EDGE CLEANUP (do not regenerate art):

Piglet has a visible thin white/light halo around parts of his fur silhouette.

Clean the alpha edge:
- Piglet's fur remains intact
- Fine fur detail should be preserved
- No white/gray halo should remain around the silhouette
- Background pixels immediately outside the fur should be fully transparent
- Do not use aggressive edge erosion that removes legitimate fur
- Preserve natural fur wisps where possible

Then apply slight uniform scale-up to match Oakley's visual size (see Scale-normalization).

Preserve:
- portrait ID sd_dog_piglet
- registration / set / category
- Oakley DDS and definition untouched
- vanilla Stellaris untouched

Rebuild DDS with the established pipeline:
- 256×256
- uncompressed 32-bit RGBA
- genuine alpha
- bottom-edge crop preserved
```

**CONFIRMED result metrics:**

| Metric | Before | After |
|--------|--------|-------|
| Light fringe pixels (DDS) | ~1488 | ~29 |
| Vertical fill | smaller than Oakley | ~92% |
| Top margin (256×256) | — | ~20px |
| Bottom | cropped | still flush/cropped |

Tiny residual fringe may remain on very fine fur; do **not** casually regenerate Piglet. Treat as a **protected** reference asset.

**Lesson:** Background removal against a light backdrop can create light halos. Oakley demonstrated a cleaner edge result.

---

## 6. Angus regeneration prompt

Angus’s finished Stellaris-style portrait was produced for `ImgHERE/dog03_angus_stellaris.png` and wired to `sd_dog_angus` without further artistic processing in the importer path.

Use this regeneration prompt when regenerating Angus (attach the **SOURCE PHOTO** as reference). Keep framing/transparency identical to the successful Piglet base prompt.

```text
Create a Stellaris-style mammalian species portrait using the provided Angus photograph as the exact subject reference.

The goal is to create a final portrait that matches the framing and subject placement of vanilla Stellaris mammalian species portraits, and matches the successful Piglet/Oakley portrait pipeline for Stellar Xeno.

SUBJECT:
- Preserve Angus's exact recognizable appearance from the reference photo.
- Preserve coat color, markings, face shape, ears, eyes, muzzle, and proportions.
- Do not turn Angus into a generic breed stereotype.
- Do not invent markings that are not in the photo.

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
- Head in the upper-middle.
- Subject occupies approximately 85–95% of vertical portrait area (target ~91–92% like Oakley/Piglet).
- Chest and body fur continue to the BOTTOM EDGE and are cropped by the frame.
- LITTLE TO NO transparent space underneath.
- Small breathing room above the ears.
- Do not float the dog in the center of the square.

TRANSPARENCY:
- Angus remains completely opaque.
- Everything outside the silhouette is genuinely transparent.
- No background, stars, planet, hexagons, scenery, frame, border, or rectangular plate.
- Preserve fur wisps; no halo or colored fringe.

TECHNICAL:
- Square, high resolution, genuine RGBA alpha.
- Designed to downscale to 256×256.
- No text, logos, UI, watermark.

Place the finished PNG in ImgHERE as dog03_angus_stellaris.png for intake.
```

**Note:** Current in-game Angus uses the regenerated ImgHERE art. Scale/framing was accepted visually; further side-by-side normalization was **intentionally deferred**.

Do **not** use the raw reference JPG (`20260418_090607.jpg`) as the finished portrait asset.

---

## 7. Reusable future-dog prompt

Template for Dog N. Replace bracketed fields; attach the dog’s SOURCE PHOTO.

```text
Create a Stellaris-style mammalian species portrait using the provided [DOG_NAME] photograph as the exact subject reference.

The goal is to create a final portrait that matches the framing and subject placement of vanilla Stellaris mammalian species portraits used by the Stellar Xeno mod.

SUBJECT:
- Preserve [DOG_NAME]'s exact recognizable appearance.
- Preserve: [coat / markings / ears / eyes / muzzle / distinctive features from the photo].
- Do not turn [DOG_NAME] into a generic [breed] or invent features absent from the photo.

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
- Match vertical framing of successful Stellar Xeno portraits (Oakley/Piglet).
- Head in the upper-middle.
- Fill approximately 85–95% of vertical space (aim ~91–92%).
- Chest/body fur to the BOTTOM EDGE — intentionally cropped.
- LITTLE TO NO transparent space underneath.
- Small space above the ears.
- Do not float the subject in the center of the square.

TRANSPARENCY:
- [DOG_NAME] completely opaque.
- Outside silhouette genuinely transparent.
- No background / scenery / planet / stars / hexagons / frame / border / rectangular plate.
- Preserve fur wisps; no halo or colored fringe.

LIGHTING:
- Natural dimensional lighting without a background.
- Subtle rim light only — no artificial glow halo.

TECHNICAL:
- Square, high resolution, genuine RGBA alpha channel.
- Designed specifically to be downscaled to 256×256.
- No text, logos, UI, watermark.

Output naming (when finished):
- ImgHERE/dogNN_[name]_stellaris.png
```

After generation: follow the manual pipeline in [portrait-workflow.md](portrait-workflow.md) (or the future importer once built).
