# Movement

## Paths

- A multi-node route (walk, patrol) lives in `waypoint_data`, `move_type` per sniffed spline, and runs from there: C++
  `MovePath` or the `creature_addon` path, SmartAI `WAYPOINT_START` (232, pathSource 0). Never hardcoded `Position`
  arrays or MOVE_TO_POS chains.
- Path id = spawn guid * 10 (+ n for extra paths) when the creature has a spawn guid; without one there is no fixed
  scheme.
- Don't copy a DB path into script data; if unavoidable, name its `waypoint_data` path id beside the copy so both get
  edited together.
- `waypoints` + `ESCORT_START` (53) is for escort behaviour (quest escorts, escort despawn/fail handling); C++
  `npc_escortAI` escorts keep their route in `script_waypoint`.
- A patrol that must begin after a scripted moment (spawn or emerge animation, an event) is started with 232 from that
  event, not auto-started via `creature_addon.path_id` / MovementType 2.
- Random roaming from spawn onward is `creature.MovementType` 1 with a nonzero `wander_distance`, event-driven roaming
  `RANDOM_MOVE`; chained MOVE_TO_POS on self from MovementInform drifts away from the spawn point.

## Single points

One-off points (charge, fight, outro spots) stay in C++ as a commented `Position` table used with `MovePoint`; leave
orientation out unless a sniff gives it, so the move computes the facing.

## Speed

- `waypoint_data.velocity` stays 0 so the creature's own walk/run speed applies (per `move_type`); set it only for
  special movement (jumps, vehicles, smoothed flying splines).
- `velocity` is absolute yd/s; `creature_template.speed_walk`/`speed_run` multiply the base speed (walk 2.5, run
  7.0). Template speeds aren't always sniffed: before changing or relying on one, divide the sniffed speed by the base
  and compare.
- A creature falling behind its group: check its template speed against the sniff as above; if it matches, fix the
  move type (e.g. walk instead of run), not the speed.

## Spawn state

A creature rooted, hovering or flying from spawn onward (e.g. as sniffed) gets a `creature_template_movement` row when
every spawn of it behaves that way, else a `creature_movement_override` row per spawn (keyed by `SpawnId`; NULL columns
fall back to the template). Values: `Rooted`=1; `Flight`=1 DisableGravity, 2 CanFly; `Ground`=2 Hover. Scripts and
auras stay for temporary, event-driven changes.
