# Stellar Xeno — Universal Portrait Variety Standard

This document defines **project-wide** portrait generation rules that apply to **every** xenotype prompt in [portrait-generation-prompts.md](portrait-generation-prompts.md).

**Design principle:**

> **Consistent art direction, variable individual composition.**

> **Same species identity + different individual portrait composition.**

The roster must feel like a professionally illustrated collection of distinct Stellaris species portraits — **not** repeated AI generations using one fixed portrait template.

---

## Universal rules vs xenotype-specific rules

| Layer | Controls | Does **not** control |
|-------|----------|----------------------|
| **Universal rules** (this doc + shared blocks in every prompt) | Identity preservation, portrait presentation, transparency, composition, composition variety, individual variation, overall art direction | Biological/mechanical transformation details |
| **Xenotype-specific rules** (each prompt body) | Biological or mechanical transformation, materials, environmental adaptation, mutations, color treatment, species visual language | Pipeline / DDS / Stellaris file generation |

Universal rules are shared across Mammalian, Avian, Reptilian, Amphibian, Arthropoid, Molluscoid, Fungoid, Plantoid, Lithoid, Necroid, **Machine**, and **Toxoid**.

Xenotype-specific rules change **how** the reference creature exists in the Stellaris universe. They do **not** replace the creature with a generic member of that xenotype.

---

## Consistent art direction + natural variety

**Goal:**

- Consistent art direction
- Consistent species identity
- Natural composition variety
- Individual character variety

**Not the goal:**

- The same centered frontal template with different skins
- A fixed rotation schedule (portrait 1 left, portrait 2 right, etc.)
- Extreme / random camera chaos

Each portrait independently receives a **natural** composition appropriate to its reference creature.

---

## Universal composition variety

Every xenotype prompt must allow natural variation in:

- head orientation
- body orientation
- head tilt
- gaze direction
- facial direction
- posture
- camera angle
- crop distance
- visible torso amount
- horizontal position
- vertical position
- subject scale
- asymmetry
- relationship between head and body orientation

**Possible** compositions (possibilities, **not** a fixed sequence):

- mostly frontal
- subtle 3/4 left
- subtle 3/4 right
- stronger 3/4 angle
- slight side profile
- body angled left while head faces viewer
- body angled right while head faces viewer
- head turned slightly away
- head turned toward viewer while body is angled
- subtle head tilt
- subject slightly left of center
- subject slightly right of center
- closer facial composition
- slightly wider bust composition

Do **not** create a rotation schedule. Do **not** intentionally cycle left / right / frontal across a roster.

---

## Anti-template rule

Every prompt must explicitly discourage repeated:

- centered frontal portraits
- perfectly symmetrical poses
- identical head placement
- identical camera distance
- identical torso exposure
- identical gaze direction
- identical body orientation

Do not make portraits look like identification photos or mugshots.

**Avoid excessive randomness:**

- extreme camera angles
- dramatic perspective distortion
- cropped faces
- awkward anatomy
- poses that obscure identity
- excessive profile views
- extreme zoom
- excessive negative space

Desired variation: **natural portrait variety**, not random camera angles.

---

## Individual variety

Allow subtle individual variation in:

- facial expression
- maturity
- physical build
- natural asymmetry
- minor markings
- scars
- coloration
- eye coloration/intensity
- surface characteristics
- minor anatomical variation
- material wear
- environmental adaptation
- personality

These variations remain **subordinate** to the reference creature.

Do **not** randomly change fundamental anatomy. Do **not** turn the creature into a different species.

Target: **slightly different individuals of the same species** — not completely different species.

---

## Flexible framing

Do not use unnecessarily rigid composition requirements.

Preferred guidance:

> The subject should generally occupy approximately **80–95%** of the vertical frame, with natural variation.

Exact framing depends on the creature’s anatomy and selected composition.

Do **not** require:

- every portrait perfectly centered
- every creature facing directly toward the viewer
- every head in exactly the same position
- fixed camera distance or fixed torso exposure for every portrait

Bust / portrait-bust framing remains appropriate for Stellaris species selection. The lower body may still crop naturally at the bottom edge when that suits the composition.

---

## Identity preservation (universal)

Composition variation must **never** override identity.

The reference creature determines:

- recognizable anatomy
- head shape
- facial proportions
- eye placement
- muzzle / beak / mouth
- ears / horns / antennae
- body plan
- silhouette
- distinctive markings
- recognizable coloration
- personality

The xenotype transformation changes **how** that creature exists in the Stellaris universe. It does not replace the creature with a generic xenotype member.

---

## Universal transparency

All portraits must use genuine **RGBA** transparency.

No:

- scenery, environment, planet, stars, laboratory, floor, room, landscape
- border, frame, text, logo, watermark
- surrounding glow

Clean transparent edges with no white, black, or colored halo.

---

## Copy/paste block (for prompts)

When embedding into a xenotype prompt, use language equivalent to:

```text
==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in head/body orientation, head tilt, gaze,
posture, camera angle, crop distance, torso exposure, horizontal and
vertical placement, subject scale, and asymmetry.

Possible compositions include mostly frontal, subtle or stronger 3/4,
slight side profile, body angled with head toward viewer, subtle head
tilt, subject slightly off-center, closer facial crop, or slightly
wider bust. These are possibilities, not a rotation schedule.

ANTI-TEMPLATE:
Do not repeat centered frontal, perfectly symmetrical, identical head
placement, identical camera distance, identical torso exposure, or
identical gaze/body orientation across portraits. Avoid mugshot /
ID-photo staging.

NATURAL VARIETY ONLY:
Avoid extreme camera angles, perspective distortion, cropped faces,
awkward anatomy, identity-obscuring poses, excessive profile, extreme
zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, build, asymmetry,
minor markings/scars, coloration, eyes, surface detail, and personality
while remaining the same species. Do not change fundamental anatomy.

FLEXIBLE FRAMING:
Square portrait-bust suitable for Stellaris species selection.
Subject generally occupies approximately 80–95% of vertical frame with
natural variation. Do not force perfect centering or identical head
placement. Exact framing depends on anatomy and composition.

IDENTITY OVERRIDE:
Composition variety never overrides recognizable anatomy, silhouette,
markings, coloration, or personality from the reference.

TRANSPARENCY:
True RGBA transparency. No scenery, environment, frame, text, logo,
watermark, or surrounding glow. Clean edges with no halo.
```

---

## Related

- Prompt library: [portrait-generation-prompts.md](portrait-generation-prompts.md)
- Dog-development history: [portrait-prompts.md](portrait-prompts.md)
- Technical pipeline: [portrait-workflow.md](portrait-workflow.md)
