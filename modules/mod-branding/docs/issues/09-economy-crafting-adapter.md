# #09 — Economy / crafting adapter (§8.6)

**Status:** open · **Deps:** none (synergy with #06 vault, #05 item branding) · **Parallel-safe:** yes · **Size:** M

## Context
`core/economy/Economy` is tested: `CanCraft` / `ResolveCraft` (consume exact inputs → output + char
XP, reject insufficient). Needs to be wired to a real resource + recipe source so the closed loop
(invade→fragments, dungeon→mats, craft→item) works.

## Scope
- Resource representation is **decided** (§16.3, #35): fragments/materials are config-mapped **item
  entries** (`Branding.Economy.FragmentItemId` / `MaterialItemId`), not a currency table. Define
  `branding_recipe` data (`pending_db_world`): inputs → output item + char XP. Use the §16.1/§16.4
  canonical terms (Material, Fragment, Recipe).
- Adapter: `EconomyMgr` — load recipes; a craft entry point (gossip/command) that reads the player's
  resources, calls `ResolveCraft`, consumes inputs (RemoveItem), and grants output via
  `RewardDelivery`.
- Hook fragment/material faucets: event reward already grants mats (#reward-claim); ensure crafting
  consumes the same representation.

## Acceptance
- Standard DoD (incl. codestyle-sql). Crafting consumes exact inputs and yields the output; a craft
  with insufficient resources is cleanly refused (mirror the core tests in-world).

## Touch points
`src/Economy*.*` (new), `pending_db_world` recipe SQL, `RewardDelivery`. Independent; the shared
resource representation is fixed by §16.3 (#35) — coordinate consumption with #06 (vault stores them)
and #05 (item upgrades spend them).
