# #08 — Allegiance adapter (§12)

**Status:** open · **Deps:** none (light synergy with #01/#02) · **Parallel-safe:** yes · **Size:** S–M

## Context
`core/allegiance/Allegiance` is tested: `AllegianceEfficiency(player, contentAlignment)` — match
rewards, mismatch/None neutral, never a penalty (soft, non-restricting §12). Needs per-character
selection + an application point.

## Scope
- Persistence: `character_allegiance` (guid, allegiance) — SQL `pending_db_characters`.
- Adapter: `AllegianceMgr` — load/save; `Efficiency(guid, contentAlignment)` via the core.
- Selection: `.branding allegiance set <id>` (mostly-permanent per §12; reforging-ritual respec is a
  later enhancement). Validate + persist.
- Application: multiply an XP/reward source by the efficiency when content alignment matches — e.g.
  apply to event reward grants (`EventMgr::ResolveReward`) or discovery/proficiency XP. Pick one
  clear application point for v1.

## Acceptance
- Standard DoD (incl. codestyle-sql). Matching allegiance gives the configured bonus; mismatch is
  exactly neutral (never < 1.0).

## Touch points
`src/Allegiance*.*` (new), `pending_db_characters` SQL, one reward/XP application point. Independent.
