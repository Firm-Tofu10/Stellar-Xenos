# Stellar Dogos — Portrait Testing

In-game compatibility matrix for static dog portraits.

**Gold-standard test portrait:** Oakley (`sd_dog_02`) — currently the strongest visual reference and already confirmed working in species creation.

Related: [development-roadmap.md](development-roadmap.md) Phase 2, [portrait-workflow.md](portrait-workflow.md).

---

## Certainty

| Label | Meaning |
|-------|---------|
| **CONFIRMED** | Observed in Stellaris 4.4.6 |
| **NEEDS TEST** / **NEEDS VERIFICATION** | Not yet proven in that context |

Do **not** assume species-creation success proves all other portrait contexts.

---

## Compatibility matrix

| Game location | Status |
|---------------|--------|
| Empire creation | **CONFIRMED** (Piglet/Oakley/Angus) |
| Species selection | **CONFIRMED** (Piglet/Oakley/Angus) |
| Cedar (`sd_dog_cedar`) Mammalian species creation | **NEEDS VERIFICATION** |
| Liberty (`sd_dog_liberty`) Mammalian species creation | **NEEDS VERIFICATION** (Phase 7 file registration **CONFIRMED**) |
| Sparrow (`sd_dog_sparrow`) Avian species creation | **NEEDS VERIFICATION** (Phase 7 file registration **CONFIRMED**) |
| Other xenotype species creation (Rep/Aqu/…) | **NEEDS VERIFICATION** (registration mapping **IMPLEMENTED**) |
| Species screen | **NEEDS TEST** |
| Leader selection | **NEEDS TEST** |
| Leader portrait | **NEEDS TEST** |
| Council | **NEEDS TEST** |
| Government / Empire screen | **NEEDS TEST** |
| Diplomacy | **NEEDS TEST** |
| Contacts | **NEEDS TEST** |
| Faction / other leader UI | **NEEDS TEST** |
| Events containing leader portraits | **NEEDS TEST** |
| Fleet / army interfaces (if applicable) | **NEEDS TEST** |

### Phase 6/7 in-game checklist

After enabling **SD Static Portrait Test**:

- [ ] Cedar / Liberty appear under Mammalian
- [ ] Sparrow appears under Avian
- [ ] Correct artwork / transparency / framing
- [ ] No corruption / missing texture
- [ ] Piglet / Oakley / Angus still work

Do **not** treat a species-creation pass as proof of leaders, council, diplomacy, or other contexts.

---

## Same asset vs different portrait pipelines

**Question:** Does one static portrait DDS work correctly everywhere Stellaris displays that portrait?

**Current status:** **NEEDS VERIFICATION**.

Do not assume:

```text
species portrait success
  = leader portrait success
  = council portrait success
  = diplomacy portrait success
```

**Action:** Test Oakley across contexts **before** designing the portrait importer around universal portrait reuse.

| Outcome | Implication |
|---------|-------------|
| Same asset works everywhere | Importer can stay simple (one DDS per dog) |
| Different contexts need different assets | Document requirements before implementing the importer |

---

## Per-location checklist

For each tested location, record:

- [ ] Portrait appears
- [ ] Correct image (Oakley / expected dog)
- [ ] Transparency correct (no rectangular plate)
- [ ] Crop correct (bottom-edge framing where expected)
- [ ] Scale correct
- [ ] No rendering errors / missing texture / pink void

Also note `error.log` / `game.log` lines mentioning the portrait ID or DDS path when investigating failures.

---

## Suggested audit procedure (Phase 2)

1. Enable the production mod (`mod/stellar_dogos/`). The experiment folder may still exist as a reference copy.
2. Create or load an empire using **Oakley** (`sd_dog_02`).
3. Walk the matrix above in a single play session when possible.
4. Capture notes (and screenshots if useful) per row.
5. Update this document's Status column from **NEEDS TEST** → **CONFIRMED** or **FAILED** with notes.
6. Update [development-roadmap.md](development-roadmap.md) Phase 2 accordingly.
7. Only then finalize importer design (Phase 3).

---

## Already known (species creation)

**CONFIRMED** for the static `texturefile` path in Stellaris 4.4.6:

- Portrait appears under Mammalian
- Piglet, Oakley, and Angus selectable
- Transparent framing works when alpha is correct
- Bottom-edge crop / ~91–92% fill looks correct for Piglet/Oakley in that UI

These confirmations do **not** close Phase 2.
