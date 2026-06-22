# #24 — Heroic-overlay adapter (selected-difficulty read + encounter scaling) (§2.4.1/§2.4.4/§2.4.6)

**Status:** open · **Epic:** #22 · **Deps:** #23 (heroic core) · **Parallel-safe:** yes (worktree) · **Size:** M–L

## Context
Wires the §2.4 core into the world. The hard rule (§2.4.1): read the **selected** difficulty from the
player/group, **not** `Map::GetDifficulty()` — the native UI flag persists even when a classic/TBC map
falls back to normal. Encounter scaling reuses the §2.2 hook points (reimplemented per §2.3, not
mod-autobalance).

## Scope
- **Adapter** `src/HeroicOverlay.{h,cpp}` (+ `HeroicConfig : IHeroicConfig`):
  - Resolve `HeroicContext` at instance-creature spawn/grant: `selected` from
    `Group::GetRaidDifficulty()`/`GetDungeonDifficulty()` (fall back to the entering `Player`'s);
    `nativeHeroicMap` from whether the map has a real heroic `MapDifficulty` row; `maxLevel` from the
    config cap.
  - Apply `HeroicHealthMul`/`HeroicDamageMul`/`HeroicLevelTarget` **on top of** the §2.2 encounter
    scalar (multiplicative compose, §2.4.4). Defer entirely when `nativeHeroicMap`.
  - **Snapshot, not pull** (Risk #4): sample group size + selected difficulty at grant / continuously,
    cache by **`ObjectGuid`** (never store raw `Player*`/`Creature*`), re-evaluate on roster/difficulty
    change — never sample at pull.
- **Mechanic-exception table** (§2.4.6) `branding_heroic_exception` (map/boss → recommended-min-bodies
  + note), loaded into a pure lookup at startup/`.reload config`. **Advisory only** — surfaced to the
  group (addon/UI hint) so they bring an appropriately sized raid (e.g. a 10-man for Four Horsemen);
  it does **not** gate entry, force a minimum, or disable the overlay. The encounter still scales to
  whatever size enters (§2.2).
- **Command** `.branding heroic` (show resolved context for the current instance; debug).
- **Conf** `Branding.Heroic.Enable`, level cap, encounter mul curve params, per-content-type enables.
- **SQL** `pending_db_world`: `branding_heroic_exception`. Every `INSERT` preceded by a matching
  `DELETE`; InnoDB; 4-space indent; trailing newline.

## Acceptance
Standard DoD (incl. `-fsyntax-only` on each touched adapter TU with its `compile_commands.json`
flags). With Heroic selected: a classic/TBC instance scales to the level cap and engine-heroic WotLK
content is left untouched (no double-scale). Group size/difficulty changes update the cached context
without a relog. No raw entity pointer stored past a call.

## Touch points
New `src/HeroicOverlay.*`, the §2.2 encounter-scaling adapter hook, `BrandingCommandScript.cpp`,
`mod_branding_loader.cpp`, `conf/mod_branding.conf.dist`, `pending_db_world/`.
