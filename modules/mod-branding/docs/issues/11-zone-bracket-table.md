# #11 — Zone bracket table for downscaling (§2.1)

**Status:** open · **Deps:** none · **Parallel-safe:** yes · **Size:** S–M

## Context
`ScalingMgr::PlayerOutgoingFactor` currently derives the zone bracket from the built-in
`AreaTableEntry::area_level` (v1, zero data). The design wants an admin-tunable per-zone bracket
(and event-phase override, §2.1). Reference: **mod-zone-difficulty**'s `zone_difficulty_info` table
shape (study, do not import — see §2.3).

## Scope
- SQL (`pending_db_world`): `branding_zone_bracket` (zone_id, target_level) — InnoDB; codestyle-sql.
- Adapter: load the table into `ScalingMgr`; `PlayerOutgoingFactor` uses the configured target level
  for the zone, falling back to `area_level` when no row exists.
- Keep the pure `ScalingFactor` core unchanged (it already takes a target level).
- (Optional, note for later) event-phase override slot so an active event can supply the bracket.

## Acceptance
- Standard DoD (incl. codestyle-sql). A configured zone overrides `area_level`; unconfigured zones
  keep current behaviour.

## Touch points
`ScalingMgr.*`, new `pending_db_world` SQL. Self-contained to the scaling adapter.
