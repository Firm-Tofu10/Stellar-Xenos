# Stellar Dogos — Portrait Generation Prompt Library

This file is the **authoritative library of xenotype-specific image-generation prompts** for Stellar Dogos.

## Important distinction

These prompts are **not** software commands and **not** part of the PowerShell portrait pipeline.

They are copy/paste prompts for an **external image-generation model** (for example ChatGPT with image generation).

Workflow:

1. Choose a Stellaris xenotype.
2. Copy the matching prompt from this library.
3. Provide a reference photograph to the image model with that prompt.
4. Save the finished square RGBA portrait into `ImgHERE/`.
5. Run the Stellar Dogos Portrait Creator (`tools\portrait-pipeline.ps1`).
6. Enter the character's name and select the matching species type in the tool.

These prompts do **not** create DDS files, portrait IDs, definitions, sets, or categories, and they do **not** modify Stellaris.

Related:

- Dog-development / framing history: [portrait-prompts.md](portrait-prompts.md)
- Technical pipeline: [portrait-workflow.md](portrait-workflow.md)
- Player overview: [../README.md](../README.md)

---

## Source of truth for this library

Prompt bodies below were extracted from the attached ChatGPT export:

`c:\Users\bryso\Downloads\Stellaris.html`

Wording is preserved from that source. Formatting (line breaks / section rules) may reflect Google Docs HTML export structure.

---

## Status legend

| Label | Meaning |
|-------|---------|
| **DOCUMENTED** | Full prompt text present in the source attachment and copied here |
| **ABSENT FROM SOURCE** | Expected by project plan, but **not present** as a full prompt body in the attachment |
| **PROMPT ONLY** | Image-generation documentation exists; pipeline selector support may differ |

---

## Inventory (expected vs found)

| # (project order) | Xenotype | In attachment? | Source heading / number | Pipeline selector today |
|-------------------|----------|----------------|-------------------------|-------------------------|
| 1 | Mammalian | **ABSENT** (referenced only as `1/11`) | No `MAMMALIAN XENOTYPE` prompt body in the export | **IMPLEMENTED** |
| 2 | Avian | **DOCUMENTED** | `STELLAR DOGOS — AVIAN XENOTYPE PORTRAIT GENERATION TEST` (also referenced as `2/11`) | **IMPLEMENTED** |
| 3 | Reptilian | **DOCUMENTED** | `… REPTILIAN … — 3/11` / footer `3/11 — Reptilian` | **IMPLEMENTED** |
| 4 | Amphibian | **DOCUMENTED** | `… AMPHIBIAN … — 4/11` / footer `4/11 — Amphibian` | **IMPLEMENTED** (display Amphibian → aquatic) |
| 5 | Arthropoid | **DOCUMENTED** | `… ARTHROPOID … — 5/11` / footer `5/11 — Arthropoid` | **IMPLEMENTED** |
| 6 | Molluscoid | **DOCUMENTED** | `… MOLLUSCOID … — 6/11` / footer `6/11 — Molluscoid` | **IMPLEMENTED** |
| 7 | Fungoid | **DOCUMENTED** | `… FUNGOID … — 7/11` / footer `7/11 — Fungoid` | **IMPLEMENTED** |
| 8 | Plantoid | **DOCUMENTED** | `… PLANTOID … — 8/11` / footer `8/11 — Plantoid` | **IMPLEMENTED** |
| 9 | Lithoid | **DOCUMENTED** | `… LITHOID … — 9/11` / footer `9/11 — Lithoid` | **IMPLEMENTED** |
| 10 | Necroid | **DOCUMENTED** | `… NECROID … — 10/11` / footer `10/11 — Necroid` | **IMPLEMENTED** |
| 11 | Machine | **ABSENT FROM SOURCE** | No Machine prompt in the export | **IMPLEMENTED** in selector; **no generation prompt in this attachment** |
| 12 | Toxoid | **DOCUMENTED (PROMPT ONLY)** | `… TOXOID … — 11/12` / footer `11/12 — Toxoid` | **NOT YET IMPLEMENTED** |

### Numbering / naming notes (preserved from source)

1. The export originally numbered species prompts as **`n/11`**. Toxoid was added as **`11/12`**, so the denominator changes mid-library. That inconsistency is preserved; it is not “fixed” here.
2. Avian’s source title is **`… GENERATION TEST`**, not `2/11` in the title line. ChatGPT narration separately calls Avian **`2/11`**.
3. After the user wrote `use this as a reference and make Mammalian now`, the export contains a **second Avian** prompt body still titled Avian — **not** a Mammalian prompt. That duplicate is omitted from the library body; only the first complete Avian prompt is included below.
4. ChatGPT narration states “Mammalian was 1/11”, but the **Mammalian prompt text itself is not in the attachment**.
5. **Machine** is never present in the attachment (no title, no body).

### Toxoid status (intentional)

| Item | Status |
|------|--------|
| Toxoid image-generation prompt | **AVAILABLE** (documented below) |
| Toxoid in Portrait Creator xenotype selector | **NOT YET IMPLEMENTED** |
| Toxoid registration / DDS path | **NOT YET IMPLEMENTED** |

Do not treat Toxoid as selectable in the current software pipeline.

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
                Stellar Dogos
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

Example: photograph of yourself + **Avian** prompt → “this person as an Avian Stellaris species” → drop PNG in `ImgHERE/` → run Portrait Creator → enter name → select Avian.

---

## Shared purpose (every xenotype prompt)

Each documented prompt is meant to:

- use the uploaded photograph as the identity reference
- preserve recognizable characteristics
- transform the subject into the selected Stellaris xenotype
- create a believable intelligent alien species
- avoid simply adding superficial features to a human
- use realistic Stellaris-style portrait presentation
- use the established Stellar Dogos portrait framing
- produce a square portrait
- target approximately 91–92% vertical subject occupancy
- keep the subject isolated
- use genuine RGBA transparency
- avoid backgrounds, UI, frames, watermarks
- avoid DDS generation and Stellaris file modification

The biological transformation sections differ per xenotype and are kept specific in each prompt body.

---

## 1. Mammalian

**Status:** ABSENT FROM SOURCE

The attachment references Mammalian as **`1/11`** in ChatGPT narration (`Since Mammalian was 1/11 and Avian is 2/11…`), and the user asked to “make Mammalian now,” but **no Mammalian xenotype prompt body** appears in `Stellaris.html`.

Until that prompt is supplied from source material, do not invent a Mammalian xenotype prompt here.

Historical **dog / Mammalian development** prompts (Piglet, framing, transparency) remain in [portrait-prompts.md](portrait-prompts.md). Those are development artifacts, not a substitute for the missing human→Mammalian xenotype prompt from this export.

---

## 2. Avian

**Source heading:** `STELLAR DOGOS — AVIAN XENOTYPE PORTRAIT GENERATION TEST`  
**Source number (narration):** `2/11`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — AVIAN XENOTYPE PORTRAIT GENERATION TEST

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

Use the established Stellar Dogos portrait framing.

The final portrait must be:

- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- chest/feathering continuing to the bottom edge
- small transparent margin above the head
- approximately 91–92% vertical subject occupancy

The subject should occupy approximately the same visual scale as the
existing Stellar Dogos portraits.

Do not leave a large empty area above the head.

Do not leave transparent space beneath the chest.

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

Generate the artwork at high resolution for later Stellar Dogos processing.

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

This image will later be placed into the Stellar Dogos ImgHERE intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head.
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
framed for the existing Stellar Dogos portrait pipeline."
```

---

## 3. Reptilian

**Source heading:** `STELLAR DOGOS — REPTILIAN XENOTYPE PORTRAIT GENERATION — 3/11`  
**Source footer:** `3/11 — Reptilian`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — REPTILIAN XENOTYPE PORTRAIT GENERATION — 3/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- chest/scaled neck continuing to the bottom edge
- small transparent margin above the head
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Reptilian.
- The reptilian anatomy is coherent.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head.
- The chest/scaled anatomy reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural scale/skin detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Reptilian species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
3/11 — Reptilian
```

---

## 4. Amphibian

**Source heading:** `STELLAR DOGOS — AMPHIBIAN XENOTYPE PORTRAIT GENERATION — 4/11`  
**Source footer:** `4/11 — Amphibian`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — AMPHIBIAN XENOTYPE PORTRAIT GENERATION — 4/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- chest/skin continuing to the bottom edge
- small transparent margin above the head
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Amphibian.
- The amphibian anatomy is coherent.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head.
- The chest/skin reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural amphibian skin detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Amphibian species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
4/11 — Amphibian
```

---

## 5. Arthropoid

**Source heading:** `STELLAR DOGOS — ARTHROPOID XENOTYPE PORTRAIT GENERATION — 5/11`  
**Source footer:** `5/11 — Arthropoid`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — ARTHROPOID XENOTYPE PORTRAIT GENERATION — 5/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest/thorax visible
- thorax/chest continuing to the bottom edge
- small transparent margin above the head and antennae
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Account for antennae or other sensory structures when establishing the top margin.
Do not leave a large empty area above the head.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head and antennae.
- The chest/thorax reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine antennae and other sensory structures are preserved.
- The edges contain natural exoskeleton detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Arthropoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
5/11 — Arthropoid
```

---

## 6. Molluscoid

**Source heading:** `STELLAR DOGOS — MOLLUSCOID XENOTYPE PORTRAIT GENERATION — 6/11`  
**Source footer:** `6/11 — Molluscoid`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — MOLLUSCOID XENOTYPE PORTRAIT GENERATION — 6/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- upper-body/molluscoid anatomy continuing to the bottom edge
- small transparent margin above the head and any sensory structures
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Account for tentacles, tendrils, feelers, or other sensory structures when establishing the top margin.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head and sensory structures.
- The chest/upper body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine biological structures are preserved.
- The edges contain natural organic detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Molluscoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
6/11 — Molluscoid
```

---

## 7. Fungoid

**Source heading:** `STELLAR DOGOS — FUNGOID XENOTYPE PORTRAIT GENERATION — 7/11`  
**Source footer:** `7/11 — Fungoid`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — FUNGOID XENOTYPE PORTRAIT GENERATION — 7/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- fungal chest/body structures continuing to the bottom edge
- small transparent margin above the head and any fungal growth structures
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Account for fungal growths or other biological structures when establishing the top margin.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head and fungal structures.
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine fungal structures are preserved.
- The edges contain natural organic/fungal detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Fungoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
7/11 — Fungoid
```

---

## 8. Plantoid

**Source heading:** `STELLAR DOGOS — PLANTOID XENOTYPE PORTRAIT GENERATION — 8/11`  
**Source footer:** `8/11 — Plantoid`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — PLANTOID XENOTYPE PORTRAIT GENERATION — 8/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- plant-derived chest/body structures continuing to the bottom edge
- small transparent margin above the head and any botanical structures
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Account for leaves, branches, petals, vines, or other botanical structures when establishing the top margin.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head and botanical structures.
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine botanical structures are preserved.
- The edges contain natural plant detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Plantoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
8/11 — Plantoid
```

---

## 9. Lithoid

**Source heading:** `STELLAR DOGOS — LITHOID XENOTYPE PORTRAIT GENERATION — 9/11`  
**Source footer:** `9/11 — Lithoid`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — LITHOID XENOTYPE PORTRAIT GENERATION — 9/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- lithoid chest/body continuing to the bottom edge
- small transparent margin above the head and any mineral structures
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Account for crystalline formations or other mineral structures when establishing the top margin.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head and mineral structures.
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine crystalline/mineral structures are preserved.
- The edges contain natural geological detail.
- There are no halos or environmental fringes.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Lithoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
9/11 — Lithoid
```

---

## 10. Necroid

**Source heading:** `STELLAR DOGOS — NECROID XENOTYPE PORTRAIT GENERATION — 10/11`  
**Source footer:** `10/11 — Necroid`  
**Status:** DOCUMENTED

```text
STELLAR DOGOS — NECROID XENOTYPE PORTRAIT GENERATION — 10/11

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

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- necroid chest/body continuing to the bottom edge
- small transparent margin above the head
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

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
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head.
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- The edges contain natural biological detail.
- There are no halos or environmental fringes.
- There is no blood, gore, exposed organs, or graphic decomposition.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Necroid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
10/11 — Necroid
```

---

## 11. Machine

**Status:** ABSENT FROM SOURCE

No Machine xenotype portrait-generation prompt appears in `Stellaris.html` (no title line, no body, no `n/11` Machine footer).

The Portrait Creator selector may still list Machine for registration; that is separate from this missing generation prompt.

---

## 12. Toxoid

**Source heading:** `STELLAR DOGOS — TOXOID XENOTYPE PORTRAIT GENERATION — 11/12`  
**Source footer:** `11/12 — Toxoid`  
**Status:** DOCUMENTED — image-generation prompt only  

**Pipeline:** Toxoid is **not** in the interactive Portrait Creator selector and is **not** registered by the current pipeline. Future implementation task.

```text
STELLAR DOGOS — TOXOID XENOTYPE PORTRAIT GENERATION — 11/12

Using the provided photograph as the EXACT identity reference, transform the subject into a finished Stellaris-style TOXOID species portrait.
This is an artwork-generation task.
The photograph is the authoritative reference for the subject's identity, recognizable characteristics, expression, and overall visual identity.
The goal is NOT to simply place the human subject into a Toxoid category.
The goal is to reinterpret the subject as a believable Stellaris Toxoid species while preserving enough recognizable characteristics that the result clearly originates from the supplied person.

==================================================

IDENTITY PRESERVATION

Preserve the recognizable identity of the reference subject wherever compatible with a Toxoid species.
Preserve important characteristics such as:
- overall facial identity
- recognizable eye characteristics
- approximate face shape and silhouette
- distinctive expression
- recognizable coloration
- hairstyle/color where it can naturally translate into toxic biological coloration, tissue, or surface structures
- distinctive markings or visual features where appropriate
- overall personality and presence
The result should feel like:
"This person as a Toxoid Stellaris species."
It should NOT feel like:
"A random toxic alien."
Do not create a generic Toxoid character unrelated to the reference.

==================================================

TOXOID TRANSFORMATION

Transform the subject's physical characteristics so the result is unmistakably a Toxoid Stellaris species.
The transformation should affect the appropriate biological characteristics, including:
- unusual mutated or chemically adapted head structure
- distinctive alien facial anatomy
- unusual but biologically coherent eyes
- toxic-adapted skin or outer biological surfaces
- chemically altered or mutated tissue structures
- unusual organic growths or biological adaptations where appropriate
- toxic coloration and patterning
- appropriate neck and chest anatomy
- coherent Toxoid proportions
The design should communicate that this species has evolved or adapted to a hostile, chemically dangerous environment.
Possible visual characteristics may include:
- corrosive-looking biological textures
- unusual skin or tissue coloration
- asymmetrical biological structures
- specialized breathing or sensory structures
- protective biological surfaces
- subtle mutation-like features
- toxic glands or organic structures where appropriate
These characteristics must remain biologically coherent and integrated into the creature.
Do not simply cover a human in green slime.
Do not simply add mutations to a human face.
Do not create a human wearing a hazardous-material suit.
Do not create a costume.
Do not create a mascot.
Do not create a cartoon monster.
Do not create a generic radioactive alien unrelated to the reference.
The subject should appear to naturally belong to an intelligent, spacefaring Toxoid species.
The exact toxic and mutated characteristics should be artistically interpreted while remaining grounded in the reference subject.
The result should feel like a species that has genuinely adapted to toxic or chemically hostile environments rather than a healthy species that has merely been painted green.

==================================================

STELLARIS ART STYLE

Render the result as a realistic Stellaris species portrait.
Target:
- realistic sci-fi digital painting
- detailed organic surface rendering
- believable mutated biology
- naturalistic alien anatomy
- strong three-dimensional form
- realistic eyes
- detailed facial structure
- subtle toxic biological details
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
- plastic-looking biological surfaces
- photographic cutout appearance
- visible costume elements
- human body with superficial toxic features
- excessive glowing effects
- generic radioactive monster appearance

==================================================

PORTRAIT COMPOSITION

Use the established Stellar Dogos portrait framing.
The final portrait must be:
- square
- portrait-bust composition
- subject facing generally toward the viewer
- head in the upper-middle portion
- upper chest visible
- Toxoid chest/body continuing to the bottom edge
- small transparent margin above the head
- approximately 91–92% vertical subject occupancy
The subject should occupy approximately the same visual scale as the existing Stellar Dogos portraits.
Do not leave a large empty area above the head.
Do not leave transparent space beneath the chest.
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
- toxic clouds
- smoke
- floating particles
- environmental chemicals
- UI
- frame
- border
Do not replace the background with white, black, gray, or another color.
The surrounding pixels must contain real transparency.
Toxic characteristics must be part of the subject itself, not environmental effects surrounding the subject.

==================================================

TOXIC BIOLOGICAL EDGE QUALITY

Preserve natural biological detail around:
- head
- cheeks
- unusual growths
- sensory structures
- neck
- shoulders
- chest
Fine biological structures should transition naturally into transparency.
Avoid:
- white halos
- black halos
- green halos
- colored fringes
- artificial glow
- hard cutout edges
- background contamination
- clipped biological structures
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
- dimensional biological-surface shading
- subtle variation across mutated and toxic-adapted tissues
The rim lighting should separate the subject from the transparent background without becoming a visible glow.
Any unusual coloration or biological luminescence should remain subtle and integrated into the organism rather than becoming an environmental effect.

==================================================

COLOR

Preserve recognizable colors from the reference photograph where they can naturally translate into Toxoid coloration.
Translate human characteristics into biologically appropriate toxic-adapted features rather than simply copying them literally.
For example:
- hair color may influence biological surface coloration
- eye color should remain recognizable where appropriate
- distinctive facial coloration may become toxic-adapted skin coloration
- recognizable markings may become biological pigmentation patterns
- natural skin tones may influence the species' base coloration where appropriate
Toxoid coloration may include unusual biological colors such as muted greens, yellows, purples, blues, browns, or other chemically adapted tones where appropriate.
Do not arbitrarily replace the subject's recognizable colors with unrelated colors.
Avoid making the entire subject uniformly neon green.
The result should feel like a naturally evolved toxic organism rather than a glowing radioactive character.

==================================================

IMPORTANT IDENTITY / TRANSFORMATION BALANCE

This is the most important part of the test.
The result must be BOTH:
- recognizably derived from the supplied person
- unmistakably a Toxoid Stellaris species
Do not sacrifice the Toxoid transformation just to preserve a human face.
Do not sacrifice the subject's identity just to create a generic toxic alien.
The target is a believable evolutionary/species reinterpretation of the specific reference subject.
The subject should look like the same individual translated into a believable intelligent Toxoid species.

==================================================

TECHNICAL TARGET

Generate the artwork at high resolution for later Stellar Dogos processing.
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
This image will later be placed into the Stellar Dogos ImgHERE/ intake workflow.

==================================================

FINAL VALIDATION

Before finishing, verify:
- The subject is clearly derived from the reference photograph.
- The subject is unmistakably Toxoid.
- The Toxoid biology is coherent.
- Toxic/adaptive characteristics appear biologically integrated.
- The subject does not simply look like a human covered in toxic effects.
- The face/identity remains recognizable.
- The result looks like a Stellaris species portrait.
- The portrait is square.
- The subject occupies approximately 91–92% of the vertical canvas.
- There is only a small margin above the head.
- The chest/body reaches the bottom edge.
- There is no background.
- The subject is isolated cleanly.
- Fine biological structures are preserved.
- The edges contain natural biological detail.
- There are no halos or environmental fringes.
- There are no environmental toxic clouds or particles.
- There is no text, UI, frame, or watermark.
The final result should look like:
"The exact person from the supplied photograph, evolutionarily and artistically reimagined as a believable intelligent Toxoid species from Stellaris, professionally painted as a finished species portrait and framed for the existing Stellar Dogos portrait pipeline."
11/12 — Toxoid
```

---

## Future work (documentation only)

1. Obtain and document the missing **Mammalian** and **Machine** xenotype generation prompts from authoritative source material (do not invent).
2. Add **Toxoid** to the interactive xenotype selector and registration path.
3. Leader portrait variants.
4. Changing xenotype on an existing registered portrait.
5. Broader Stellaris UI-context verification.
6. Workshop packaging.
7. Multiple xenotype versions of the same reference subject.

