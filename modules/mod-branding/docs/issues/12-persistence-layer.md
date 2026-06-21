# #12 — Persistence for event participation + account economy ceiling (§9.3#5)

**Status:** open · **Deps:** none · **Parallel-safe:** yes (land early to reduce churn) · **Size:** M

## Context
`EventMgr` holds participation (`ParticipationState`, points) and per-account economy-ceiling state
(`AccountEconomyState`) in memory only — all reset on worldserver restart. For the §9.3#5 account
ceiling to actually bound an alt-army across sessions, it must persist.

## Scope
- SQL (`pending_db_characters` + `pending_db_auth`):
  - `character_event_participation` (guid, points_this_hour, hour_window_start, day_start, + per-type
    daily counters — store as a small blob/columns).
  - `account_economy_ledger` (account, materials_this_period, currency_this_period, period_start).
- Adapter: load on login (character) / first-touch (account), flush on logout + periodic.
  Keep `ObjectGuid`/account keys; reuse the Slice-1 load/save pattern in `ProficiencyMgr`.
- No pure-core changes (the structs already exist); this is IO only.

## Acceptance
- Standard DoD (incl. codestyle-sql). Round-trip test: load(save(state)) == state.
- Account ceiling survives a simulated relog (manual verify note in PR).

## Touch points
`EventMgr.*` (load/save), new SQL in both `pending_db_*`. Coordinate with #10 (event-spawner) which
also touches `EventMgr` — prefer landing this first.
