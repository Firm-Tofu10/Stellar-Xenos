# Stellar Xeno — Portrait Generation Prompts

> **Xenotype prompt library:**  
> For the authoritative **xenotype-specific** image-generation prompts (including **CREATED** Universal Machine and Toxoid), see **[portrait-generation-prompts.md](portrait-generation-prompts.md)**.  
> Project-wide composition / identity rules: **[portrait-variety-standard.md](portrait-variety-standard.md)** — *consistent art direction, variable individual composition*.  
> Those prompts are for an external image model (not pipeline commands).

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
- **Consistent art direction, variable individual composition** (see [portrait-variety-standard.md](portrait-variety-standard.md))
- Natural composition variety (not a fixed centered-frontal template; not extreme random cameras)
- Subtle individual variety subordinate to the reference dog
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

COMPOSITION (flexible framing + natural variety):

Use a Stellaris mammalian species portrait-bust crop with natural individual variation.

- Piglet should generally fill most of the portrait vertically (~80–95% with natural variation).
- Head placement may vary naturally in the upper portion of the frame (not a fixed template lock).
- Facing may be mostly frontal, subtle 3/4, slight head tilt, or body angled with head toward viewer — appropriate to the reference, not a roster rotation schedule.
- Avoid repeating identical centered-frontal mugshot compositions across dogs.
- Avoid extreme cameras, cropped faces, and identity-obscuring poses.
- For a standard bust crop, chest/body fur may continue to the BOTTOM EDGE; exact torso exposure may vary.
- Do not leave a large empty void that makes the subject look tiny.
- Keep ears/head readable inside the frame with a modest margin that may vary with composition.
- Do not make the dog appear to float in excessive negative space.

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

Historical dog-development framing (updated for the Universal Portrait Variety Standard):

```text
FRAMING REQUIREMENTS (flexible):
- Modest transparent margin above the ears (exact margin may vary)
- Head generally in the upper portion of the canvas (placement may vary naturally)
- Large dominant head / portrait bust
- Subject generally fills approximately 80–95% of vertical space with natural variation
- For a standard bust crop, chest/body/fur may reach the BOTTOM EDGE (torso exposure may vary)
- Avoid large unused transparent bands under a bust crop
- Dog must not appear tiny in excessive negative space
- Allow natural composition variety (subtle 3/4, head tilt, slight off-center, etc.)
- Anti-template: do not repeat identical centered-frontal mugshot compositions
- See portrait-variety-standard.md
```

Visual stack (typical bust crop — not a rigid lock for every portrait):

```text
TOP: modest transparent space
  ↓
ears / head
  ↓
face
  ↓
neck / chest
  ↓
fur continues
  ↓
BOTTOM EDGE — fur often cropped by the frame
```

See also [portrait-variety-standard.md](portrait-variety-standard.md) and certainty labels in [portrait-workflow.md](portrait-workflow.md) § composition rules.

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

COMPOSITION (flexible framing + natural variety):
- Head generally in the upper portion (placement may vary naturally).
- Subject generally occupies approximately 80–95% of vertical portrait area with natural variation.
- Facing/crop may vary naturally (not locked to centered frontal).
- For a standard bust crop, chest and body fur may continue to the BOTTOM EDGE; torso exposure may vary.
- Avoid large unused transparent bands under a bust crop.
- Modest breathing room above the ears (exact margin may vary).
- Do not float the dog in excessive negative space.
- Anti-template: do not repeat identical mugshot compositions across individuals.

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

COMPOSITION (flexible framing + natural variety):
- Readable Stellaris mammalian portrait-bust scale (~80–95% vertical occupancy with natural variation).
- Head generally in the upper portion (exact placement may vary).
- Allow natural composition variety (subtle 3/4, head tilt, slight off-center, etc.) — not a roster rotation schedule.
- For a standard bust crop, chest/body fur may reach the BOTTOM EDGE; torso exposure may vary.
- Avoid large unused transparent bands under a bust crop.
- Modest space above the ears (exact margin may vary).
- Do not float the subject in excessive negative space.
- Anti-template: do not repeat identical centered-frontal mugshot compositions.
- See portrait-variety-standard.md.

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
