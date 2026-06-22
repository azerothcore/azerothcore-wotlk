# #22 — Heroic Overlay & small-group reward scaling (epic, §2.4)

**Status:** open · **Epic:** self · **Deps:** §2.2 group-size core (designed; encounter/reward wiring still open per §2.3 status) · **Parallel-safe:** children yes (worktree) · **Size:** epic (L total)

## Context
Players want **every** dungeon and raid runnable as a **max-level heroic** via the *native* client
Normal/Heroic UI — including classic/TBC content that has **no** native heroic difficulty in
`MapDifficulty.dbc`. §2.4 adds this as a fourth scaling consideration that **composes** onto §2.1
(per-player downscale) and §2.2 (group-size encounter+reward), **without** importing mod-autobalance
(§2.3 stands: reference for hook points + the count-snapshot exploit, reimplement downward-only).

The linchpin (§2.4.1): key off the **selected** difficulty (`Player/Group::GetDungeonDifficulty()` /
`GetRaidDifficulty()`), **not** `Map::GetDifficulty()`. WotLK content engages the engine's real
heroic (untouched); classic/TBC runs normal but the selected `…_HEROIC` flag drives the overlay. One
native toggle, all content, no DBC/client patch.

## Scope (delivered by children)
- **#23 heroic-tier core** — pure `src/core/scaling/heroic/` (`HeroicContext` → encounter muls,
  level target, reward-tier bonus) + the new `RewardScale.currencyMul` term (§2.4.2/§2.4.3) + tests.
- **#24 heroic-overlay adapter** — read selected difficulty, apply heroic encounter scaling on top of
  the §2.2 encounter hooks, level-target to cap, snapshot-at-grant, native-heroic deference, the
  `branding_heroic_exception` mechanic-exception table (§2.4.6).
- **#25 heroic reward wiring** — `currencyMul` + heroic tier bonus through the §9.4 personal-loot
  delivery path; conf knobs; SQL.

## Acceptance
Standard DoD. The four §2.4.5 invariants GoogleTested in the pure core. End-to-end: with Heroic
selected in the native UI, a classic/TBC instance tunes to max level and grants the heroic reward
tier; a 5-man MC clear grants ≈⅛ branding currency vs a full raid (steeper than its item reduction);
native-heroic WotLK content is **not** double-scaled.

## Touch points
New `src/core/scaling/heroic/*`, new adapter TU(s) under `src/`, §2.2 `RewardScale` struct,
§9.4 delivery path, `conf/mod_branding.conf.dist`, `pending_db_world` (exception table),
`mod_branding_loader.cpp` (register), `ARCHITECTURE.md` §2.4 (done).
