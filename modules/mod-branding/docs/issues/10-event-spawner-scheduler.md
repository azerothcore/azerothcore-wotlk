# #10 — Event spawner / scheduler (§9.1)

**Status:** open · **Deps:** builds on existing event scaffold; coordinate with #12 persistence · **Size:** M–L

## Context
Events are currently **GM-started** (`.branding event start`). The design wants ambient, auto-running
events (§9.1): periodic invasions/resource-surges/elite-hunts/profession-anomalies per zone, with
their own creature spawns and lifecycle (start → active → contained/expired → cooldown).

## Scope
- Data (`pending_db_world`): `branding_event_def` (zone, type, goal, spawn group, period, duration).
- Scheduler: a `WorldScript`/`EventMap`-driven loop that starts/stops events per their schedule
  (no ad-hoc tick counters). Spawn/despawn the event's creatures on start/end.
- Auto-subscribe on zone entry (`OnPlayerUpdateZone`) — enroll players present in an active-event
  zone (the capture path already scores by current zone).
- Containment-driven completion: when `Containment` hits 1.0, resolve the event (announce, allow
  claims) and enter cooldown.

## Acceptance
- Standard DoD (incl. codestyle-sql). An event auto-starts on schedule, spawns mobs, accrues
  containment from kills, completes at 100%, and goes on cooldown.

## Touch points
`EventMgr.*` (lifecycle), new `src/EventScheduler.*`, `pending_db_world` SQL. **Coordinate with #12**
(both touch `EventMgr`); land #12 first or add scheduler in a new TU.
