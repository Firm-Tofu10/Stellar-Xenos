# Stellar Dogos (Stellaris mod)

Custom **static** species portraits for Stellaris **Pegasus / v4.4.x**.

This folder is the **production Stellaris mod package**. It contains portrait definitions, sets, category exposure, and DDS textures.

It does **not** contain the Portrait Creator tools, `ImgHERE/` source workflow, or repository development scripts. Those live at the repository root (`tools/`, `ImgHERE/`, docs).

## Install for local testing

1. Ensure `Documents\Paradox Interactive\Stellaris\mod\` exists.
2. Create a launcher `.mod` descriptor whose `path=` points at **this folder** (use forward slashes).
3. Enable **Stellar Dogos** in the Stellaris launcher.
4. Create an empire, pick the species type that matches your portrait, and select it.

Do **not** copy files into the vanilla Stellaris install.

## Status

- Species-creation portraits: working for the currently registered dogs (see definitions in this package).
- Full UI contexts (leaders, council, diplomacy, …): **not fully verified**.
- Steam Workshop: **not packaged / not published** yet.

## Revert

Disable or remove the launcher `.mod` descriptor. No vanilla files need restoring.
