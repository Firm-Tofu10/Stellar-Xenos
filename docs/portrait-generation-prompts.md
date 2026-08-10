# Stellar Xeno — Portrait Generation Prompt Library

This file is the **authoritative library of xenotype-specific image-generation prompts** for Stellar Xeno.

## Important distinction

These prompts are **not** software commands and **not** part of the PowerShell portrait pipeline.

They are copy/paste prompts for an **external image-generation model** (for example ChatGPT with image generation).

Workflow:

1. Choose a Stellaris xenotype.
2. Copy the matching prompt from this library.
3. Provide a reference photograph / creature portrait to the image model with that prompt.
4. Save the finished square RGBA portrait into `ImgHERE/`.
5. Run the Stellar Xeno Portrait Creator (`tools\portrait-pipeline.ps1`).
6. Enter the character's name and select the matching species type in the tool.

These prompts do **not** create DDS files, portrait IDs, definitions, sets, or categories, and they do **not** modify Stellaris.

Related:

- **Universal portrait variety standard:** [portrait-variety-standard.md](portrait-variety-standard.md)
- Dog-development / framing history: [portrait-prompts.md](portrait-prompts.md)
- Technical pipeline: [portrait-workflow.md](portrait-workflow.md)
- Player overview: [../README.md](../README.md)

---

## Universal rules vs xenotype-specific rules

| Layer | Controls |
|-------|----------|
| **Universal rules** | Identity preservation, portrait presentation, transparency, composition, **composition variety**, **individual variation**, overall art direction |
| **Xenotype-specific rules** | Biological/mechanical transformation, materials, environmental adaptation, mutations, color treatment, species visual language |

**Design principle:**

> **Consistent art direction, variable individual composition.**

> **Same species identity + different individual portrait composition.**

Full project-wide standard: [portrait-variety-standard.md](portrait-variety-standard.md).

Universal rules are embedded in every documented prompt under **UNIVERSAL COMPOSITION VARIETY** (and Machine/Toxoid composition sections). Xenotype transforms remain specific to each prompt body.

---

## Source of truth for this library

Most biological xenotype prompt bodies (Avian–Necroid) were originally extracted from the ChatGPT export `Stellaris.html`, then **updated** for the Universal Portrait Variety Standard (flexible framing, anti-template, individual variety).

**Machine** and **Toxoid** Universal prompts were **CREATED** for this project (they are not export recoveries). Do not treat them as pre-existing source-attachment text.

---

## Status legend

| Label | Meaning |
|-------|---------|
| **DOCUMENTED** | Full prompt text present and maintained in this library |
| **CREATED** | Authored for Stellar Xeno (not recovered from the original export) |
| **ABSENT** | Still missing a full Universal prompt body |
| **PROMPT ONLY** | (legacy) generation prompt without pipeline support — no longer used for Toxoid |

---

## Inventory

| # | Xenotype | Prompt status | Pipeline selector |
|---|----------|---------------|-------------------|
| 1 | Mammalian | **ABSENT** (human→Mammalian body still missing; dog-development history in portrait-prompts.md) | **IMPLEMENTED** |
| 2 | Avian | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 3 | Reptilian | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 4 | Amphibian | **DOCUMENTED** + variety standard | **IMPLEMENTED** (display Amphibian → aquatic) |
| 5 | Arthropoid | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 6 | Molluscoid | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 7 | Fungoid | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 8 | Plantoid | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 9 | Lithoid | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 10 | Necroid | **DOCUMENTED** + variety standard | **IMPLEMENTED** |
| 11 | Machine | **CREATED** — Universal Machine Xenotype | **IMPLEMENTED** |
| 12 | Toxoid | **CREATED** — Universal Toxoid Xenotype | **IMPLEMENTED** |

### Notes

1. Machine and Toxoid prompts are **new** project-standard entries.
2. Existing Avian–Necroid prompts keep their xenotype transformation rules; rigid ~91–92% framing was replaced with flexible ~80–95% framing and composition variety.
3. Mammalian remains absent as a Universal human→Mammalian library body; historical dog Mammalian development prompts live in [portrait-prompts.md](portrait-prompts.md).

---

## Player workflow (image generation → Stellaris)

```text
                Reference Photograph
                         │
                         ↓
                Choose Xenotype
                         │
                         ↓
              Xenotype-specific
             Generation Prompt
             (this library)
                         │
                         ↓
              Generated Portrait
                         │
                         ↓
                     ImgHERE/
                         │
                         ↓
                Stellar Xeno
                Portrait Creator
                         │
              ┌──────────┴──────────┐
              ↓                     ↓
          Character Name        Xenotype
                                    │
                                    ↓
                              Register
                                    │
                                    ↓
                                 Stellaris
```

---

## Shared purpose (every xenotype prompt)

Each documented prompt is meant to:

- use the uploaded photograph / creature portrait as the identity reference
- preserve recognizable characteristics
- transform the subject into the selected Stellaris xenotype
- create a believable intelligent alien species
- avoid simply adding superficial features to a human (or armor onto an animal)
- use realistic Stellaris-style portrait presentation
- follow **consistent art direction, variable individual composition**
- allow natural composition variety and subtle individual variety
- produce a square portrait
- generally target approximately **80–95%** vertical subject occupancy with natural variation
- keep the subject isolated
- use genuine RGBA transparency
- avoid backgrounds, UI, frames, watermarks
- avoid DDS generation and Stellaris file modification

The biological / mechanical transformation sections differ per xenotype and are kept specific in each prompt body.

Universal composition / anti-template / individual-variety language is shared across prompts; see [portrait-variety-standard.md](portrait-variety-standard.md).

---
## 1. Mammalian

**Status:** ABSENT

A full **Universal Mammalian** xenotype prompt body is not yet present in this library (the original export referenced Mammalian as `1/11` but did not include the prompt text).

Until a Universal Mammalian prompt is authored, do not invent one here from incomplete narration.

Historical **dog / Mammalian development** prompts (Piglet, framing, transparency) remain in [portrait-prompts.md](portrait-prompts.md). Those development artifacts should follow the same variety standard when reused: **consistent art direction, variable individual composition**.

When Mammalian is added, it must include the same UNIVERSAL COMPOSITION VARIETY / identity / transparency rules as Machine, Toxoid, and the other documented prompts.

---
## 2. Avian

**Source heading:** `STELLAR XENO — AVIAN XENOTYPE PORTRAIT GENERATION TEST`  
**Source number (narration):** `2/11`  
**Status:** DOCUMENTED

```text
STELLAR XENO — AVIAN XENOTYPE PORTRAIT GENERATION TEST

Using the provided photograph as the EXACT identity reference, transform the
subject into a finished Stellaris-style AVIAN species portrait.

This is an artwork-generation task.

The photograph is the authoritative reference for the subject's identity,
recognizable characteristics, expression, and overall visual identity.

The goal is NOT to simply place the human subject into an Avian category.

The goal is to reinterpret the subject as a believable Stellaris Avian
species while preserving enough recognizable characteristics that the
result clearly originates from the supplied person.

==================================================
IDENTITY PRESERVATION
==================================================

Preserve the recognizable identity of the reference subject wherever
compatible with an avian species.

Preserve important characteristics such as:

- overall facial identity
- recognizable eye characteristics
- approximate face shape
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into avian plumage
- distinctive markings or visual features where appropriate
- overall personality and presence

The result should feel like:

"This person as an Avian Stellaris species."

It should NOT feel like:

"A random bird person."

Do not create a generic fantasy bird character unrelated to the reference.

==================================================
AVIAN TRANSFORMATION
==================================================

Transform the subject's physical characteristics so the result is
unmistakably an Avian Stellaris species.

The transformation should affect the appropriate biological characteristics,
including:

- avian head structure
- beak appropriate to the design
- feathered facial and neck regions
- avian eyes
- avian coloration
- feather structure
- avian neck/chest anatomy
- appropriate avian proportions

The result should be biologically coherent.

Do not simply add bird wings to a human.

Do not create a human face with a beak pasted onto it.

Do not create a costume.

Do not create a mascot.

Do not create an anthropomorphic cartoon bird.

The subject should appear to naturally belong to an intelligent,
spacefaring Avian species.

The exact avian characteristics should be artistically interpreted while
remaining grounded in the reference subject.

==================================================
STELLARIS ART STYLE
==================================================

Render the result as a realistic Stellaris species portrait.

Target:

- realistic sci-fi digital painting
- detailed feather rendering
- naturalistic anatomy
- strong three-dimensional form
- realistic eyes
- detailed facial structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation

The result should look like an official Stellaris species portrait rather
than fan-art pasted into the game.

Avoid:

- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking feathers
- photographic cutout appearance
- visible costume elements
- human body with superficial bird features

==================================================
PORTRAIT COMPOSITION
==================================================

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.


Use the established Stellar Xeno portrait framing.

The final portrait must be:

- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- chest/feathering continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition)
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation

The subject should remain at a readable Stellaris species-portrait scale.
Exact crop distance and torso exposure may vary naturally.

Do not leave a large empty void that makes the subject look tiny.

Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).

The lower chest/feathering should naturally continue beyond the bottom edge
of the portrait.

The photograph is the identity reference.

It is NOT the composition reference.

==================================================
TRANSPARENCY
==================================================

The final image must have genuine RGBA transparency.

The subject must remain opaque.

Everything outside the subject must be transparent.

Do NOT include:

- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border

Do not replace the background with white, black, gray, or another color.

The surrounding pixels must contain real transparency.

==================================================
FEATHER EDGE QUALITY
==================================================

Preserve natural feather detail around:

- head
- cheeks
- neck
- shoulders
- chest

Fine feathers should transition naturally into transparency.

Avoid:

- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination

The silhouette should look naturally feathered rather than digitally clipped.

==================================================
LIGHTING
==================================================

Use lighting appropriate for a Stellaris portrait displayed directly over
the game's interface.

Use:

- soft directional lighting
- realistic facial shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional feather shading

The rim lighting should separate the subject from the transparent
background without becoming a visible glow.

==================================================
COLOR
==================================================

Preserve recognizable colors from the reference photograph where they can
naturally translate into avian coloration.

Translate human characteristics into biologically appropriate avian
features rather than simply copying them literally.

For example:

- hair color may influence plumage color
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become feather coloration
- recognizable markings may become feather patterns

Do not arbitrarily replace the subject's recognizable colors with unrelated
colors.

==================================================
IMPORTANT IDENTITY / TRANSFORMATION BALANCE
==================================================

This is the most important part of the test.

The result must be BOTH:

1. recognizably derived from the supplied person
2. unmistakably an Avian Stellaris species

Do not sacrifice the avian transformation just to preserve a human face.

Do not sacrifice the subject's identity just to create a generic bird.

The target is a believable evolutionary/species reinterpretation of the
specific reference subject.

==================================================
TECHNICAL TARGET
==================================================

Generate the artwork at high resolution for later Stellar Xeno processing.

Output should be:

- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI

Do NOT create a DDS.

Do NOT modify Stellaris files.

This image will later be placed into the Stellar Xeno ImgHERE intake workflow.

==================================================
FINAL VALIDATION
==================================================

Before finishing, verify:

- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Avian.
- The avian anatomy is coherent.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head placement and margin above the head vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/feathering reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural feather detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.

The final result should look like:

"The exact person from the supplied photograph, evolutionarily and
artistically reimagined as a believable intelligent Avian species from
Stellaris, professionally painted as a finished species portrait and
framed for the existing Stellar Xeno portrait pipeline."
```

---

## 3. Reptilian

**Source heading:** `STELLAR XENO — REPTILIAN XENOTYPE PORTRAIT GENERATION — 3/11`  
**Source footer:** `3/11 — Reptilian`  
**Status:** DOCUMENTED

```text
STELLAR XENO — REPTILIAN XENOTYPE PORTRAIT GENERATION — 3/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style REPTILIAN species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Reptilian category.
The goal is to reinterpret the subject as a believable Stellaris Reptilian species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a reptilian species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics
- approximate face shape
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into scales or coloration
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Reptilian Stellaris species."
It should NOT feel like:
"A random fantasy reptile person."
Do not create a generic reptilian character unrelated to the reference.

==================================================

REPTILIAN TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Reptilian Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- reptilian head structure
- species-appropriate snout and jaw structure
- reptilian eyes
- scaled facial and neck regions
- natural scale structure
- reptilian skin texture
- reptilian coloration
- species-appropriate teeth where naturally visible
- reptilian neck/chest anatomy
- appropriate reptilian proportions
The exact reptilian species should be artistically interpreted from the reference subject rather than forcing the subject into one specific Earth reptile.
The result should feel like a believable intelligent alien reptile.
Do not simply add scales to a human.
Do not create a human face with a reptile snout pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon lizard.
Do not make the subject look like a generic Earth crocodile, snake, lizard, dinosaur, or other specific reptile unless the reference naturally supports that interpretation.
The subject should appear to naturally belong to an intelligent, spacefaring Reptilian species.
The exact reptilian characteristics should be artistically interpreted while remaining grounded in the reference subject.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed scale rendering
- naturalistic anatomy
- strong three-dimensional form
- realistic reptilian eyes
- detailed facial structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking scales
- photographic cutout appearance
- visible costume elements
- human body with superficial reptile features

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- chest/scaled neck continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition)
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower chest/scaled anatomy should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

SCALE EDGE QUALITY

Preserve natural scale and skin detail around:
- head
- jaw
- cheeks
- neck
- shoulders
- chest
Fine scale and skin transitions should remain natural at the silhouette.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine surface detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional scale shading
- subtle variation across the reptilian skin
The rim lighting should separate the subject from the transparent background without becoming a visible glow.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into reptilian coloration.
Translate human characteristics into biologically appropriate reptilian features rather than simply copying them literally.
For example:
- hair color may influence scale coloration
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become scale coloration
- recognizable markings may become scale patterns
- skin coloration may influence the species' natural coloration where appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel biologically coherent for a reptilian species.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Reptilian Stellaris species
Do not sacrifice the reptilian transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic reptile.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent reptilian species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Reptilian.
- The reptilian anatomy is coherent.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head placement and margin above the head vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/scaled anatomy reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural scale/skin detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Reptilian species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
3/11 — Reptilian
```

---

## 4. Amphibian

**Source heading:** `STELLAR XENO — AMPHIBIAN XENOTYPE PORTRAIT GENERATION — 4/11`  
**Source footer:** `4/11 — Amphibian`  
**Status:** DOCUMENTED

```text
STELLAR XENO — AMPHIBIAN XENOTYPE PORTRAIT GENERATION — 4/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style AMPHIBIAN species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into an Amphibian category.
The goal is to reinterpret the subject as a believable Stellaris Amphibian species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with an amphibian species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics
- approximate face shape
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into skin coloration or patterning
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as an Amphibian Stellaris species."
It should NOT feel like:
"A random fantasy amphibian."
Do not create a generic amphibian character unrelated to the reference.

==================================================

AMPHIBIAN TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably an Amphibian Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- amphibian head structure
- smooth or naturally textured amphibian skin
- large or otherwise species-appropriate amphibian eyes
- amphibian facial structure
- appropriate mouth and jaw structure
- subtle amphibian skin folds where biologically appropriate
- amphibian coloration and patterning
- appropriate neck and chest anatomy
- coherent amphibian proportions
The result should feel like a believable intelligent alien amphibian.
The amphibian design should be inspired by real amphibian biology without simply copying one specific Earth frog, toad, salamander, or newt.
Do not simply add amphibian skin to a human.
Do not create a human face with frog eyes pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon frog.
Do not make the subject look like a generic Earth frog, toad, salamander, or newt unless the reference naturally supports that interpretation.
The subject should appear to naturally belong to an intelligent, spacefaring Amphibian species.
The exact amphibian characteristics should be artistically interpreted while remaining grounded in the reference subject.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed amphibian skin rendering
- naturalistic anatomy
- strong three-dimensional form
- realistic eyes
- detailed facial structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking skin
- photographic cutout appearance
- visible costume elements
- human body with superficial amphibian features

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- chest/skin continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition)
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower chest should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

SKIN EDGE QUALITY

Preserve natural amphibian skin detail around:
- head
- cheeks
- jaw
- neck
- shoulders
- chest
Skin texture should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine skin detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional skin shading
- subtle variation across the amphibian skin
The rim lighting should separate the subject from the transparent background without becoming a visible glow.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into amphibian coloration.
Translate human characteristics into biologically appropriate amphibian features rather than simply copying them literally.
For example:
- hair color may influence skin coloration
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become skin patterning
- recognizable markings may become amphibian coloration or patterns
- natural skin tones may influence the species' base coloration where appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel biologically coherent for an amphibian species.
Avoid excessively bright fantasy colors unless they naturally support the reference subject.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably an Amphibian Stellaris species
Do not sacrifice the amphibian transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic amphibian.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent amphibian species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Amphibian.
- The amphibian anatomy is coherent.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head placement and margin above the head vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/skin reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural amphibian skin detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Amphibian species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
4/11 — Amphibian
```

---

## 5. Arthropoid

**Source heading:** `STELLAR XENO — ARTHROPOID XENOTYPE PORTRAIT GENERATION — 5/11`  
**Source footer:** `5/11 — Arthropoid`  
**Status:** DOCUMENTED

```text
STELLAR XENO — ARTHROPOID XENOTYPE PORTRAIT GENERATION — 5/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style ARTHROPOID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into an Arthropoid category.
The goal is to reinterpret the subject as a believable Stellaris Arthropoid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with an arthropoid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics where they can translate into arthropoid anatomy
- approximate face shape and silhouette
- distinctive expression or emotional presence
- recognizable coloration
- hairstyle/color where it can naturally translate into exoskeletal or surface coloration
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as an Arthropoid Stellaris species."
It should NOT feel like:
"A random fantasy insect person."
Do not create a generic arthropoid character unrelated to the reference.

==================================================

ARTHROPOID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably an Arthropoid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- arthropod-inspired head structure
- coherent exoskeletal anatomy
- species-appropriate eyes
- compound eyes or other biologically coherent visual organs
- antennae or other sensory structures where appropriate
- mandibles or other appropriate mouth structures
- segmented facial and neck structures
- natural exoskeleton texture
- arthropoid coloration and patterning
- appropriate thorax/chest anatomy
- coherent arthropoid proportions
The design should feel like a sophisticated alien arthropod rather than a literal Earth insect.
The exact arthropoid biology should be artistically interpreted from the reference subject.
Do not simply add antennae to a human.
Do not create a human face with insect eyes pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon insect.
Do not make the subject look like a generic Earth ant, beetle, bee, wasp, spider, mantis, or other specific arthropod unless the reference naturally supports that interpretation.
The subject should appear to naturally belong to an intelligent, spacefaring Arthropoid species.
The final anatomy should be internally coherent, with the facial structures, sensory organs, mouthparts, neck, and chest all belonging to the same biological creature.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed exoskeleton rendering
- subtle organic surface texture
- naturalistic alien anatomy
- strong three-dimensional form
- realistic species-appropriate eyes
- detailed facial/head structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking exoskeleton
- photographic cutout appearance
- visible costume elements
- human body with superficial insect features

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest/thorax visible
- thorax/chest continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition) and antennae
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Account for antennae or other sensory structures when establishing the top margin.
Do not leave a large empty void that makes the subject look tiny.
Do not leave transparent space beneath the chest/thorax.
The lower thorax should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

EXOSKELETON EDGE QUALITY

Preserve natural detail around:
- head
- antennae
- mandibles
- cheeks
- neck
- shoulders
- thorax
- other fine sensory structures
Fine structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
- missing antennae tips
- clipped sensory structures
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine structures simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial/head shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional exoskeleton shading
- subtle variation across the alien surface
The rim lighting should separate the subject from the transparent background without becoming a visible glow.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into arthropoid coloration.
Translate human characteristics into biologically appropriate arthropoid features rather than simply copying them literally.
For example:
- hair color may influence exoskeleton coloration
- eye color may influence species-appropriate visual organs where appropriate
- distinctive facial coloration may become exoskeletal patterning
- recognizable markings may become shell/plate coloration
- clothing colors should not be copied as clothing; they may influence natural coloration only when appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel biologically coherent for an alien arthropoid species.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably an Arthropoid Stellaris species
Do not sacrifice the arthropoid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic insect or alien.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent arthropoid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Arthropoid.
- The arthropoid anatomy is coherent.
- The head, sensory organs, mouthparts, and thorax belong to the same species.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head/antennae placement and top margin vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/thorax reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine antennae and other sensory structures are preserved.
- The edges contain natural exoskeleton detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Arthropoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
5/11 — Arthropoid
```

---

## 6. Molluscoid

**Source heading:** `STELLAR XENO — MOLLUSCOID XENOTYPE PORTRAIT GENERATION — 6/11`  
**Source footer:** `6/11 — Molluscoid`  
**Status:** DOCUMENTED

```text
STELLAR XENO — MOLLUSCOID XENOTYPE PORTRAIT GENERATION — 6/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style MOLLUSCOID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Molluscoid category.
The goal is to reinterpret the subject as a believable Stellaris Molluscoid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a molluscoid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics
- approximate face shape and silhouette
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into skin, mantle, or other molluscoid coloration
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Molluscoid Stellaris species."
It should NOT feel like:
"A random fantasy mollusk person."
Do not create a generic molluscoid character unrelated to the reference.

==================================================

MOLLUSCOID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Molluscoid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- molluscoid head structure
- species-appropriate soft-bodied facial anatomy
- molluscoid eyes or other appropriate visual organs
- tentacles, tendrils, feelers, or other sensory structures where appropriate
- soft organic skin or mantle-like surfaces
- subtle molluscan textures
- appropriate mouth structure
- molluscoid coloration and patterning
- coherent neck and upper-body anatomy
- believable molluscoid proportions
The exact species should be artistically interpreted rather than simply copying a real-world octopus, squid, snail, slug, or other mollusk.
The result should feel like a sophisticated intelligent alien species that evolved from a molluscoid biological lineage.
Do not simply add tentacles to a human.
Do not create a human face with a squid mouth pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon octopus or squid.
Do not make the subject look like a generic Earth mollusk unless the reference naturally supports that interpretation.
The subject should appear to naturally belong to an intelligent, spacefaring Molluscoid species.
The exact molluscoid characteristics should be artistically interpreted while remaining grounded in the reference subject.
The anatomy should remain coherent: sensory structures, facial anatomy, neck, and chest should all appear to belong to the same biological creature.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed organic skin and surface rendering
- naturalistic alien anatomy
- strong three-dimensional form
- realistic species-appropriate eyes
- detailed facial/head structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking skin
- photographic cutout appearance
- visible costume elements
- human body with superficial mollusk features

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- upper-body/molluscoid anatomy continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition) and any sensory structures
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Account for tentacles, tendrils, feelers, or other sensory structures when establishing the top margin.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower body should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

ORGANIC EDGE QUALITY

Preserve natural biological detail around:
- head
- cheeks
- sensory structures
- tendrils
- neck
- shoulders
- chest
- other fine organic structures
Fine structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
- clipped tentacles or sensory structures
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine biological detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional organic-surface shading
- subtle variation across the molluscoid skin
The rim lighting should separate the subject from the transparent background without becoming a visible glow.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into molluscoid coloration.
Translate human characteristics into biologically appropriate molluscoid features rather than simply copying them literally.
For example:
- hair color may influence skin or mantle coloration
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become natural skin patterning
- recognizable markings may become molluscoid pigmentation patterns
- natural skin tones may influence the species' base coloration where appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel biologically coherent for an alien molluscoid species.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Molluscoid Stellaris species
Do not sacrifice the molluscoid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic mollusk or alien.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent molluscoid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Molluscoid.
- The molluscoid anatomy is coherent.
- The head, sensory structures, mouth, neck, and chest belong to the same species.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head/sensory structure placement and top margin vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/upper body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine biological structures are preserved.
- The edges contain natural organic detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Molluscoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
6/11 — Molluscoid
```

---

## 7. Fungoid

**Source heading:** `STELLAR XENO — FUNGOID XENOTYPE PORTRAIT GENERATION — 7/11`  
**Source footer:** `7/11 — Fungoid`  
**Status:** DOCUMENTED

```text
STELLAR XENO — FUNGOID XENOTYPE PORTRAIT GENERATION — 7/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style FUNGOID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Fungoid category.
The goal is to reinterpret the subject as a believable Stellaris Fungoid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a fungoid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics where biologically appropriate
- approximate face shape and silhouette
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into fungal coloration, growth, or surface patterning
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Fungoid Stellaris species."
It should NOT feel like:
"A random mushroom creature."
Do not create a generic fungoid character unrelated to the reference.

==================================================

FUNGOID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Fungoid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- fungal or mycelial head structure
- organic fungal facial anatomy
- fungal surface textures
- mushroom-like or fungal growth structures where appropriate
- species-appropriate eyes or sensory organs
- fungal pigmentation and coloration
- organic fungal patterns
- mycelial or fibrous surface details
- appropriate neck and chest anatomy
- coherent fungoid proportions
The exact fungal biology should be artistically interpreted rather than simply turning the subject into a human-shaped mushroom.
The result should feel like a sophisticated intelligent alien organism whose biology is genuinely fungal.
Do not simply put mushrooms on a human.
Do not create a human face with mushroom caps pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon mushroom.
Do not make the subject look like a generic Earth mushroom or fungus unless the reference naturally supports that interpretation.
The subject should appear to naturally belong to an intelligent, spacefaring Fungoid species.
The fungal structures should appear biologically integrated into the subject rather than attached as decorations.
The exact fungoid characteristics should be artistically interpreted while remaining grounded in the reference subject.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed fungal surface rendering
- intricate organic textures
- naturalistic alien anatomy
- strong three-dimensional form
- realistic species-appropriate eyes
- detailed facial/head structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking surfaces
- photographic cutout appearance
- visible costume elements
- human body with superficial fungal features

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- fungal chest/body structures continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition) and any fungal growth structures
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Account for fungal growths or other biological structures when establishing the top margin.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower chest/body should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border
- floating spores or environmental particles
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

FUNGAL EDGE QUALITY

Preserve natural fungal and organic detail around:
- head
- fungal growth structures
- cheeks
- neck
- shoulders
- chest
- fine mycelial structures where appropriate
Fine biological structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
- clipped fungal structures
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine biological detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial/head shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional fungal surface shading
- subtle variation across fungal tissues and growth structures
The rim lighting should separate the subject from the transparent background without becoming a visible glow.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into fungoid coloration.
Translate human characteristics into biologically appropriate fungal features rather than simply copying them literally.
For example:
- hair color may influence fungal pigmentation
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become fungal surface coloration
- recognizable markings may become natural fungal patterns
- skin tones may influence the organism's base coloration where appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel biologically coherent for an alien fungal organism.
Avoid making the entire subject uniformly brown, gray, or mushroom-white unless that naturally supports the reference.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Fungoid Stellaris species
Do not sacrifice the fungoid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic mushroom creature.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent fungoid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Fungoid.
- The fungal biology is coherent.
- The fungal structures appear biologically integrated.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head/fungal structure placement and top margin vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine fungal structures are preserved.
- The edges contain natural organic/fungal detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Fungoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
7/11 — Fungoid
```

---

## 8. Plantoid

**Source heading:** `STELLAR XENO — PLANTOID XENOTYPE PORTRAIT GENERATION — 8/11`  
**Source footer:** `8/11 — Plantoid`  
**Status:** DOCUMENTED

```text
STELLAR XENO — PLANTOID XENOTYPE PORTRAIT GENERATION — 8/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style PLANTOID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Plantoid category.
The goal is to reinterpret the subject as a believable Stellaris Plantoid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a plantoid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics where biologically appropriate
- approximate face shape and silhouette
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into leaves, foliage, bark, petals, or plant pigmentation
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Plantoid Stellaris species."
It should NOT feel like:
"A random plant person."
Do not create a generic plantoid character unrelated to the reference.

==================================================

PLANTOID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Plantoid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- plant-derived head structure
- botanical facial structures
- leaf, petal, bark, vine, or other plant structures where appropriate
- plant-like eyes or other biologically coherent visual organs
- natural plant textures
- organic bark or stem-like structures where appropriate
- botanical coloration and patterning
- plant-derived neck and chest anatomy
- coherent plantoid proportions
The exact plant biology should be artistically interpreted from the reference subject rather than forcing the subject into one specific Earth plant.
The result should feel like a sophisticated intelligent alien organism whose biology is genuinely plant-based.
Do not simply put leaves on a human.
Do not create a human face with flowers pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon plant.
Do not make the subject look like a generic tree, flower, vine, or other Earth plant unless the reference naturally supports that interpretation.
The plant structures should appear biologically integrated into the subject rather than attached as decorations.
The subject should appear to naturally belong to an intelligent, spacefaring Plantoid species.
The exact botanical characteristics should be artistically interpreted while remaining grounded in the reference subject.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed botanical surface rendering
- intricate organic textures
- naturalistic alien anatomy
- strong three-dimensional form
- realistic species-appropriate eyes
- detailed facial/head structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking plant surfaces
- photographic cutout appearance
- visible costume elements
- human body with superficial plant features

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- plant-derived chest/body structures continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition) and any botanical structures
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Account for leaves, branches, petals, vines, or other botanical structures when establishing the top margin.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower chest/body should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- UI
- frame
- border
- floating leaves
- environmental plants
- vines detached from the subject
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

BOTANICAL EDGE QUALITY

Preserve natural botanical detail around:
- head
- leaves
- petals
- vines
- branches
- cheeks
- neck
- shoulders
- chest
Fine plant structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
- clipped leaves or botanical structures
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine botanical detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial/head shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional botanical surface shading
- subtle variation across leaves, bark, petals, and plant tissues
The rim lighting should separate the subject from the transparent background without becoming a visible glow.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into plantoid coloration.
Translate human characteristics into biologically appropriate plant features rather than simply copying them literally.
For example:
- hair color may influence foliage or plant pigmentation
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become botanical coloration
- recognizable markings may become leaf, bark, petal, or pigmentation patterns
- skin tones may influence the organism's base coloration where appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel biologically coherent for an alien plant-based species.
Do not make the entire subject uniformly green unless that naturally supports the reference.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Plantoid Stellaris species
Do not sacrifice the plantoid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic plant creature.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent plantoid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Plantoid.
- The plant-based biology is coherent.
- The botanical structures appear biologically integrated.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head/botanical structure placement and top margin vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine botanical structures are preserved.
- The edges contain natural plant detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Plantoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
8/11 — Plantoid
```

---

## 9. Lithoid

**Source heading:** `STELLAR XENO — LITHOID XENOTYPE PORTRAIT GENERATION — 9/11`  
**Source footer:** `9/11 — Lithoid`  
**Status:** DOCUMENTED

```text
STELLAR XENO — LITHOID XENOTYPE PORTRAIT GENERATION — 9/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style LITHOID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Lithoid category.
The goal is to reinterpret the subject as a believable Stellaris Lithoid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a lithoid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics where biologically appropriate
- approximate face shape and silhouette
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into mineral coloration or crystalline structures
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Lithoid Stellaris species."
It should NOT feel like:
"A random rock creature."
Do not create a generic lithoid character unrelated to the reference.

==================================================

LITHOID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Lithoid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- mineral-based head structure
- stone or crystalline facial anatomy
- geological surface textures
- rock-like facial planes
- mineral or crystalline formations where appropriate
- species-appropriate eyes or other visual organs
- stone-based neck and chest anatomy
- geological coloration and patterning
- coherent lithoid proportions
- subtle mineral inclusions or crystalline details
The exact lithoid composition should be artistically interpreted rather than simply turning the subject into a statue.
The result should feel like a living, intelligent alien organism composed of geological and mineral materials.
Do not simply make the human subject look like a person carved from stone.
Do not create a human face with rocks pasted onto it.
Do not create a statue.
Do not create a costume.
Do not create a mascot.
Do not create an anthropomorphic cartoon rock.
Do not make the subject look like a generic Earth boulder or sculpture.
The subject should appear to naturally belong to an intelligent, spacefaring Lithoid species.
The mineral structures should appear biologically integrated into the subject rather than attached as decorations.
The exact geological characteristics should be artistically interpreted while remaining grounded in the reference subject.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed mineral and stone rendering
- realistic crystalline and geological textures
- naturalistic alien anatomy
- strong three-dimensional form
- realistic species-appropriate eyes
- detailed facial/head structure
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking stone
- photographic cutout appearance
- visible costume elements
- human body with superficial rock features
- ordinary human statue appearance

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- lithoid chest/body continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition) and any mineral structures
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Account for crystalline formations or other mineral structures when establishing the top margin.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower lithoid body should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- rocks surrounding the subject
- floating crystals
- environmental geology
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

MINERAL EDGE QUALITY

Preserve natural mineral detail around:
- head
- crystalline structures
- cheeks
- jaw
- neck
- shoulders
- chest
Fine crystalline or geological structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
- clipped crystal formations
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine mineral detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial/head shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional stone shading
- realistic mineral reflections
- subtle variation across different mineral surfaces
The rim lighting should separate the subject from the transparent background without becoming a visible glow.
Crystalline surfaces may catch slightly stronger highlights, but they must remain physically believable and integrated into the lighting.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into lithoid coloration.
Translate human characteristics into biologically appropriate mineral features rather than simply copying them literally.
For example:
- hair color may influence mineral coloration
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become mineral patterning
- recognizable markings may become bands, veins, or crystalline patterns
- natural skin tones may influence the base mineral coloration where appropriate
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
The resulting colors should feel like a coherent mineral composition.
Avoid making the subject uniformly gray unless that naturally supports the reference.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Lithoid Stellaris species
Do not sacrifice the lithoid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic rock creature.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent lithoid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Lithoid.
- The lithoid anatomy is coherent.
- The mineral structures appear biologically integrated.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head/mineral structure placement and top margin vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine crystalline/mineral structures are preserved.
- The edges contain natural geological detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Lithoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
9/11 — Lithoid
```

---

## 10. Necroid

**Source heading:** `STELLAR XENO — NECROID XENOTYPE PORTRAIT GENERATION — 10/11`  
**Source footer:** `10/11 — Necroid`  
**Status:** DOCUMENTED

```text
STELLAR XENO — NECROID XENOTYPE PORTRAIT GENERATION — 10/11

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style NECROID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Necroid category.
The goal is to reinterpret the subject as a believable Stellaris Necroid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a necroid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics
- approximate face shape and silhouette
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into necroid coloration or surface structure
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Necroid Stellaris species."
It should NOT feel like:
"A random undead monster."
Do not create a generic necroid character unrelated to the reference.

==================================================

NECROID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Necroid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- necroid facial structure
- subtly unnatural or otherworldly anatomy
- distinctive eyes appropriate to a necroid species
- pale, dark, desaturated, or unusual biological coloration
- necrotic or corpse-inspired surface textures
- subtly elongated or unusual facial proportions where appropriate
- distinctive teeth or mouth structure where appropriate
- unusual skin or tissue characteristics
- appropriate neck and chest anatomy
- coherent necroid proportions
The result should feel like a naturally evolved intelligent alien species with an eerie, death-associated biology.
The necroid appearance should be sophisticated and alien rather than simply making the subject look like a human zombie.
Do not simply add zombie makeup to a human.
Do not create a human face with fake wounds pasted onto it.
Do not create a costume.
Do not create a mascot.
Do not create a generic horror monster.
Do not use excessive decay or graphic decomposition.
Do not include exposed organs, gore, blood, or graphic wounds.
The subject should appear to naturally belong to an intelligent, spacefaring Necroid species.
The exact necroid characteristics should be artistically interpreted while remaining grounded in the reference subject.
The unsettling quality should come primarily from the species' biology, anatomy, coloration, and expression rather than graphic horror.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed organic surface rendering
- naturalistic alien anatomy
- strong three-dimensional form
- realistic eyes
- detailed facial structure
- subtle necroid biological details
- soft directional lighting
- subtle rim lighting
- slightly desaturated but rich colors
- serious/intelligent expression
- polished Paradox-style species portrait presentation
The result should look like an official Stellaris species portrait rather than fan-art pasted into the game.
Avoid:
- anime
- cartoon
- cel shading
- exaggerated fantasy art
- mascot design
- comedic expression
- plastic-looking skin
- photographic cutout appearance
- visible costume elements
- human body with superficial undead features
- graphic horror
- gore
- blood
- exposed organs

==================================================

PORTRAIT COMPOSITION

==================================================
UNIVERSAL COMPOSITION VARIETY
==================================================

Consistent art direction, variable individual composition.
Same species identity + different individual portrait composition.

Allow natural variation in:

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

Possible compositions include (possibilities, NOT a fixed rotation schedule):

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

Each portrait independently receives a natural composition appropriate
to its reference. Do not cycle left/right/frontal across a roster.

ANTI-TEMPLATE:
Do not repeat centered frontal portraits, perfectly symmetrical poses,
identical head placement, identical camera distance, identical torso
exposure, identical gaze direction, or identical body orientation.
Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY (not random cameras):
Avoid extreme camera angles, dramatic perspective distortion, cropped
faces, awkward anatomy, poses that obscure identity, excessive profile
views, extreme zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, physical build, natural
asymmetry, minor markings, scars, coloration, eye coloration/intensity,
surface characteristics, minor anatomical variation, material wear,
environmental adaptation, and personality — subordinate to the reference.
Do not change fundamental anatomy. Do not turn the subject into a
different species. Target: slightly different individuals of the same
species.

Use the established Stellar Xeno portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject generally readable as a Stellaris species portrait (facing may vary naturally; not locked to dead-center frontal)
- head generally in the upper portion of the frame (exact placement may vary naturally)
- upper chest visible
- necroid chest/body continuing to the bottom edge
- usually a modest transparent margin above the head (exact margin may vary with composition)
- subject generally occupies approximately 80–95% of the vertical frame, with natural variation
The subject should remain at a readable Stellaris species-portrait scale. Exact crop distance and torso exposure may vary naturally.
Do not leave a large empty void that makes the subject look tiny.
Do not leave a large unused transparent band beneath the bust when the composition is a standard cropped portrait-bust (exact torso crop may vary).
The lower chest/body should naturally continue beyond the bottom edge of the portrait.
The photograph is the identity reference.
It is NOT the composition reference.

==================================================

TRANSPARENCY

The final image must have genuine RGBA transparency.
The subject must remain opaque.
Everything outside the subject must be transparent.
Do NOT include:
- photographic background
- room
- landscape
- furniture
- people
- objects
- sky
- scenery
- space
- stars
- planets
- smoke
- fog
- floating particles
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.

==================================================

NECROID EDGE QUALITY

Preserve natural biological detail around:
- head
- ears or other head structures where appropriate
- cheeks
- jaw
- neck
- shoulders
- chest
Fine biological structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
The silhouette should look naturally integrated rather than digitally clipped.
Do not aggressively erase fine biological detail simply to create a perfectly hard silhouette.

==================================================

LIGHTING

Use lighting appropriate for a Stellaris portrait displayed directly over the game's interface.
Use:
- soft directional lighting
- realistic facial shading
- natural highlights
- subtle rim lighting
- realistic eye reflections
- dimensional skin/tissue shading
- subtle shadowing around facial structures
The rim lighting should separate the subject from the transparent background without becoming a visible glow.
The lighting may create a slightly eerie atmosphere through contrast and shading, but the portrait must remain clean and readable.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into necroid coloration.
Translate human characteristics into biologically appropriate necroid features rather than simply copying them literally.
For example:
- hair color may influence surface or tissue coloration
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become biological pigmentation
- recognizable markings may become natural skin/tissue patterns
- natural skin tones may influence the species' base coloration where appropriate
Use desaturated, unusual, or subtly unnatural colors where appropriate to establish the Necroid identity.
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
Avoid excessive red blood tones or graphic horror coloration.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Necroid Stellaris species
Do not sacrifice the necroid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic undead creature.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent necroid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Xeno processing.
Output should be:
- square
- high resolution
- suitable for genuine RGBA transparency
- isolated subject
- no background
- no text
- no logo
- no watermark
- no border
- no frame
- no UI
Do NOT create a DDS.
Do NOT modify Stellaris files.
This image will later be placed into the Stellar Xeno ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Necroid.
- The necroid anatomy is coherent.
- The result is eerie/otherworldly without relying on graphic gore.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject generally occupies approximately 80–95% of the vertical frame, with natural variation appropriate to anatomy and composition.
- Head placement and margin above the head vary naturally within a readable portrait-bust crop (not a fixed template).
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural biological detail.
- There are no halos or environmental fringes.
- There is no blood, gore, exposed organs, or graphic decomposition.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Necroid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Xeno portrait pipeline."
10/11 — Necroid
```

---

## 11. Machine

**Status:** CREATED (project standard — Universal Machine Xenotype)  
**Pipeline selector:** IMPLEMENTED  
**Note:** This prompt was **created for Stellar Xeno** as part of the prompt-system expansion. It did not exist in the original ChatGPT export attachment.

```text
STELLAR XENO — UNIVERSAL MACHINE XENOTYPE

Using the provided creature portrait as the exact biological identity
reference, reinterpret this creature as a sophisticated synthetic Machine
species from the Stellaris universe.

The reference creature determines the species identity.

Preserve its recognizable:

- anatomy
- proportions
- silhouette
- facial structure
- distinctive features
- coloration
- markings
- personality

Do not redesign the creature into a generic robot.

Instead, imagine that this exact species has been completely reconstructed
as an advanced synthetic organism by an alien civilization.

==================================================
CORE MACHINE TRANSFORMATION
==================================================

Transform the creature's biological anatomy into purpose-built synthetic
anatomy.

The underlying body must clearly be mechanical, engineered, and artificial.

Translate biological characteristics into synthetic equivalents:

fur → subtle synthetic surface texture
feathers → thin integrated synthetic feather-like surface structures
scales → fine interlocking synthetic surface panels
skin → engineered synthetic material
horns → integrated structural or sensory components
ears → synthetic sensory structures
claws → precision mechanical digits
eyes → advanced optical sensors
nose/beak/muzzle → engineered equivalents preserving the original silhouette
tails → articulated synthetic structures

Do not simply cover the biological creature with armor.

Rebuild the anatomy as a machine.

==================================================
CRITICAL MACHINE SURFACE RULE
==================================================

Organic surface characteristics must remain primarily TEXTURE rather than
large 3D geometry.

This is especially important for fur.

Fur should NOT become:

- fluffy 3D fur
- long individual hair
- flowing locks
- large synthetic hair masses
- furry armor
- sculpted hair volumes

Instead use:

- microtexture
- shallow surface relief
- material variation
- roughness variation
- subtle directional patterns
- short integrated synthetic fibers
- fine embossed texture

The machine's underlying anatomy must remain visually dominant.

The biological identity should survive through:

- shape
- silhouette
- proportions
- coloration
- surface pattern

rather than excessive physical fur/feather/scale geometry.

==================================================
MACHINE ANATOMY
==================================================

Use sophisticated alien synthetic construction:

- engineered structural anatomy
- segmented composite surfaces
- articulated joints
- synthetic musculature
- recessed seams
- precision-machined components
- ceramic composites
- dark alloys
- brushed metal
- synthetic polymers
- integrated sensors
- subtle circuitry
- internal structural elements
- restrained emissive components

Every mechanical element should appear purposeful.

Avoid decorative mechanical clutter.

Avoid excessive:

- wires
- gears
- pistons
- exposed machinery
- industrial robotics

The mechanical anatomy must follow the original creature's natural body plan.

A canine remains canine.
An avian remains avian.
A reptile remains reptilian.
An arthropod remains arthropod.

Do not force humanoid anatomy onto the creature.

==================================================
STELLARIS MACHINE AESTHETIC
==================================================

The result should feel like a sophisticated alien Machine species from
Stellaris.

It should feel:

- alien
- intelligent
- sophisticated
- engineered
- elegant
- functional
- technologically advanced
- species-specific
- unusual
- believable

This is an alien Machine species, not an Earth robot.

Avoid:

- humanoid robots
- androids
- Transformers
- cyberpunk robots
- military robots
- industrial machinery
- generic robot animals
- animals wearing robotic armor
- fantasy golems
- exposed mechanical skeletons

The machine should feel like an actual alien species reconstructed into
synthetic existence.

==================================================
MACHINE COLOR
==================================================

Preserve the reference creature's recognizable coloration while translating
biological colors into synthetic materials.

Examples:

brown → bronze / warm brown composite
black → graphite / black alloy
white → ivory ceramic / pale composite
blue → blue synthetic material / metallic blue
green → green ceramic / alloy
red → deep red composite / controlled metallic accents
golden → warm gold / bronze

Do not make every Machine portrait silver or gray.

Do not cover the creature in neon lighting.

Emissive elements should be small and restrained.

==================================================
MACHINE FACE
==================================================

The face is the most important identity feature.

Preserve:

- eye spacing
- eye placement
- facial proportions
- muzzle/beak
- forehead
- cheeks
- ears
- expression

Convert these into synthetic equivalents without destroying the creature's
personality.

Do not give every Machine creature an emotionless robotic face.

==================================================
MACHINE PORTRAIT STYLE
==================================================

Finished Stellaris species-selection portrait.

Realistic high-detail science-fiction digital artwork.

Sophisticated 3D-rendered materials.

Realistic mechanical shading.

Detailed but controlled surface construction.

Subtle directional lighting.

Subtle rim lighting.

Serious intelligent presence.

Professional game artwork.

==================================================
MACHINE COMPOSITION
==================================================

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
Do not force every Machine portrait to be centered, frontal, symmetrical,
identical in crop, or identical in camera distance.
Do not repeat mugshot / identification-photo staging.

NATURAL VARIETY ONLY:
Avoid extreme camera angles, perspective distortion, cropped faces,
awkward anatomy, identity-obscuring poses, excessive profile, extreme
zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, build, asymmetry, minor
markings, surface wear, coloration intensity, and personality while
remaining the same synthetic species.

FLEXIBLE FRAMING:
Square portrait-bust suitable for Stellaris species selection.
Subject generally occupies approximately 80–95% of the vertical frame
with natural variation. Exact framing depends on anatomy and composition.
Do not require perfect centering or identical head placement.

==================================================
MACHINE TRANSPARENCY
==================================================

True RGBA transparency.

No background, scenery, environment, frame, border, text, logo,
watermark, or surrounding glow.

Clean transparent edges with no white, black, or colored halo.

==================================================
MACHINE FINAL TEST
==================================================

The viewer should think:

"That is clearly the same creature, but this species is synthetic."

Not:

"That's an animal wearing robot armor."

Not:

"That's a generic robot shaped like an animal."

Do NOT create a DDS.
Do NOT modify Stellaris files.
```

---

## 12. Toxoid

**Status:** CREATED (project standard — Universal Toxoid Xenotype)  
**Pipeline selector:** IMPLEMENTED (Stellaris 4.4.x `toxoids` / `TOX`)  
**Note:** This prompt was **created for Stellar Xeno** as part of the prompt-system expansion to match the Universal Machine / variety standard. It replaces the earlier export-derived Toxoid body so Machine and Toxoid share one coherent prompt system.

```text
STELLAR XENO — UNIVERSAL TOXOID XENOTYPE

Using the provided creature portrait as the exact biological identity
reference, reinterpret this creature as a sophisticated Toxoid species
from the Stellaris universe.

The reference creature determines the species identity and anatomy.

Preserve:

- head shape
- facial proportions
- eye placement
- muzzle/beak/mouth
- ears/horns/antennae
- body plan
- silhouette
- distinctive markings
- coloration
- personality

Do not turn the creature into a generic monster.

The result should look like the same species evolved to survive an
extremely toxic, chemically hostile alien environment.

==================================================
CORE TOXOID TRANSFORMATION
==================================================

Reinterpret the creature as an organism adapted to:

- toxic atmospheres
- corrosive environments
- chemical contamination
- mutagenic substances
- industrial pollution
- poisonous ecosystems
- hazardous biological environments

The creature should appear biologically altered and environmentally
adapted rather than simply covered in slime.

Its anatomy should feel like the result of generations of survival in a
hostile toxic ecosystem.

Introduce appropriate signs of:

- mutation
- abnormal growth
- hardened tissue
- chemical-resistant skin
- exposed biological structures
- unusual coloration
- asymmetry
- protective membranes
- toxic glands
- specialized breathing organs
- chemical filtration structures
- corrosive secretions
- biological containment adaptations

Do not use all of these simultaneously.

Choose adaptations that make anatomical sense for the reference creature.

==================================================
TOXOID VISUAL LANGUAGE
==================================================

The design should fit the visual language of Stellaris Toxoids:

grotesque but intelligent
strange but believable
mutated but functional
industrial but biological
hazardous but sophisticated

The creature should feel like an organism adapted to an environment that
would be inhospitable to normal life.

Possible visual elements include:

- toxic membranes
- translucent tissue
- chemical sacs
- swollen biological structures
- hardened plates
- abnormal glands
- exposed veins or tubes
- respirator structures
- filtration organs
- breathing apparatus
- protective masks
- containment collars
- hoses and tubes
- salvaged industrial components
- crude functional protective equipment
- worn environmental gear

Do not use all of them.

Select only elements that make biological and anatomical sense.

==================================================
BIOLOGY FIRST
==================================================

The creature remains an organism.

Do not turn it into a robot.
Do not turn it into a cyborg by default.
Do not cover the entire body in armor.
Do not replace the anatomy with machinery.

Biology must remain visually dominant.

Equipment, when appropriate, should support, contain, filter, protect,
or exploit the creature's biology.

==================================================
TOXOID SURFACE DETAIL
==================================================

Keep biological surface characteristics primarily as TEXTURE rather than
excessive 3D geometry.

Use:

- subtle surface texture
- shallow relief
- material variation
- pores
- scales
- wrinkles
- scars
- chemical staining
- discoloration
- wetness
- restrained biological patterning

Avoid:

- giant fur masses
- long individual hairs
- excessive tentacles
- huge slime strands
- excessive dripping goo
- giant biological growths
- exaggerated spikes
- cartoon mutations

The silhouette should remain clean enough for a Stellaris species portrait.

==================================================
TOXOID COLOR
==================================================

Preserve the reference creature's recognizable coloration.

Possible toxic accents include:

- sickly yellow
- chemical green
- poisonous teal
- cyan
- toxic turquoise
- acidic orange
- rust
- bruised purple
- diseased blue
- deep brown
- industrial gray
- dirty ivory

Toxic colors should remain secondary accents.

Do not make every Toxoid neon green.

==================================================
TOXOID BIOLOGY
==================================================

Where appropriate introduce:

- specialized eyes
- secondary eyelids
- protective membranes
- filtration organs
- chemical-resistant skin
- toxic glands
- venom sacs
- modified respiratory structures
- unusual mouths
- reinforced teeth
- hardened claws
- corrosive secretions
- glowing chemical organs
- translucent tissues
- asymmetrical mutations

These adaptations must appear functional rather than decorative.

Ask visually:

"Why would this organism need this structure to survive?"

==================================================
TOXOID EQUIPMENT
==================================================

If equipment is appropriate, use improvised alien industrial equipment:

- battered respirators
- sealed collars
- pressure hoses
- chemical tanks
- filtration systems
- protective masks
- environmental suits
- crude containment systems
- scavenged machinery
- industrial plating
- worn metal
- rubberized components
- dirty tubing
- small warning lights

Equipment should appear:

- used
- functional
- industrial
- patched together
- purpose-built

Avoid sleek futuristic armor.
Avoid excessive machinery.

==================================================
STELLARIS TOXOID AESTHETIC
==================================================

The finished creature should communicate:

"This creature lives somewhere that would kill you."

It should feel:

- alien
- mutated
- toxic
- resilient
- strange
- slightly grotesque
- intelligent
- functional
- environmentally adapted
- industrial
- darkly whimsical

Avoid:

- generic horror
- fantasy monsters
- zombies
- demons
- generic aliens
- humanoid mutants unless the reference is humanoid
- cartoon gross-out design

==================================================
TOXOID FACE
==================================================

The face is the most important identity feature.

Preserve:

- eye position
- eye spacing
- muzzle/beak
- mouth
- cheeks
- forehead
- ears
- horns
- facial proportions
- expression

Mutate these features without destroying their identity.

Do not make every Toxoid angry or monstrous.

==================================================
TOXOID PORTRAIT STYLE
==================================================

Finished Stellaris species-selection portrait.

Realistic high-detail science-fiction digital artwork.

Sophisticated creature design.

Detailed biological materials.

Controlled surface detail.

Realistic lighting.

Subtle rim lighting.

Strong facial readability.

Professional strategy-game concept art.

Alien but believable.

Not photorealistic wildlife photography.
Not generic fantasy concept art.
Not a generic AI monster.

==================================================
TOXOID COMPOSITION
==================================================

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
Do not force every Toxoid portrait into the same centered frontal
composition. Do not stage mugshot / identification-photo compositions.

NATURAL VARIETY ONLY:
Avoid extreme camera angles, perspective distortion, cropped faces,
awkward anatomy, identity-obscuring poses, excessive profile, extreme
zoom, and excessive negative space.

INDIVIDUAL VARIETY:
Allow subtle variation in expression, maturity, build, asymmetry, minor
markings, scars, toxic accent intensity, and personality while remaining
the same species.

FLEXIBLE FRAMING:
Square portrait-bust suitable for Stellaris species selection.
Subject generally occupies approximately 80–95% of the vertical frame
with natural variation. Exact framing depends on anatomy and composition.
Do not require perfect centering or identical head placement.

==================================================
TOXOID TRANSPARENCY
==================================================

True RGBA transparency.

No scenery, toxic planet, laboratory, space, stars, floor, environmental
background, border, frame, text, logo, watermark, or surrounding glow.

Clean transparent edges with no white, black, or colored halo.

==================================================
TOXOID FINAL TEST
==================================================

The result should make the viewer think:

"That's clearly the same creature, but it evolved on a toxic world."

Not:

"That's just a gross monster."

Not:

"That's a normal animal covered in slime."

Not:

"That's a generic alien."

Make the toxicity feel like evolutionary history rather than a visual
effect.

Do NOT create a DDS.
Do NOT modify Stellaris files.
```

---
## Future work (documentation only)

1. Obtain and document the missing **Mammalian** human→xenotype generation prompt from authoritative source material (or author a Universal Mammalian prompt in the same style as Machine/Toxoid).
2. Keep prompt library and [portrait-variety-standard.md](portrait-variety-standard.md) aligned when xenotype transforms change.
3. Dog-development framing history in [portrait-prompts.md](portrait-prompts.md) remains historical; prefer this library + variety standard for new generation work.

---

## Validation checklist (prompt system)

- [x] Machine prompt **CREATED** (did not exist previously in this library as a full body)
- [x] Toxoid prompt **CREATED** to Universal Toxoid standard (coherent with Machine + variety system)
- [x] Universal composition variety applied to documented xenotype prompts
- [x] Rigid ~91–92% occupancy guidance replaced with flexible ~80–95% framing
- [x] Universal vs xenotype-specific rules documented in [portrait-variety-standard.md](portrait-variety-standard.md)