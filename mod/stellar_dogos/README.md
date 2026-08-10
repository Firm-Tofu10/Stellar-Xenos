# Stellar Xeno

**Custom Stellaris species portraits from your own images.**

**Stellar Xeno** is a Stellaris **4.4.x** (Pegasus) mod that adds selectable **static species portraits** across multiple Stellaris species types (xenotypes).

This Workshop package is the **game mod only**. It contains portrait definitions, portrait sets, category exposure, and DDS textures so Stellaris can load the included portraits.

## What this mod includes

Registered portraits appear under their species type in empire/species creation, including:

- **Mammalian** — Piglet, Oakley, Angus, Bruce, Cedar, Liberty, Maple  
- **Avian** — Sparrow, Zaldrin  
- **Reptilian** — Lemon, Pepper, Nova  
- **Fungoid** — Blitz  

Additional xenotypes are supported by the **local Portrait Creator** tooling in the project repository (Amphibian, Arthropoid, Molluscoid, Plantoid, Lithoid, Necroid, Machine, Toxoid, and more). Those tools are **not** shipped inside this Workshop package.

## What this mod does NOT include

- The local **Portrait Creator** (PowerShell intake → DDS → registration)
- `ImgHERE/` staging, source PNGs, or developer scripts
- A claim of full verification in every Stellaris UI context (leaders, council, diplomacy, …)

To create and register **new** portraits on your own PC, use the project repository (local tooling), then update/republish this mod package if you are the author.

Repository (Portrait Creator / development):  
https://github.com/Firm-Tofu10/Stellar-Dogos

## How to use (players)

1. Subscribe to **Stellar Xeno** on Steam Workshop (or install this folder as a local mod).
2. Enable **Stellar Xeno** in the Stellaris launcher.
3. Create an empire → choose the matching species type → select a Stellar Xeno portrait.

Do **not** copy files into the vanilla Stellaris installation.

## Local install (authors / testers)

For local testing without Workshop:

1. Place this folder under `Documents/Paradox Interactive/Stellaris/mod/` (folder name may remain the internal `stellar_dogos` path).
2. Ensure a launcher `.mod` descriptor exists with a `path=` pointing at **this folder** (forward slashes). The package `descriptor.mod` itself must **not** contain a developer-machine absolute path.
3. Enable **Stellar Xeno** in the launcher.

## Status

- Species-creation portraits: working for the currently registered portraits in this package.
- Full UI contexts (leaders, council, diplomacy, …): **not fully verified**.
- Steam Workshop ID: assigned by Steam on first upload (`remote_file_id` — do not invent).

## Revert

Disable or unsubscribe the mod. No vanilla files need restoring.
