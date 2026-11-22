# Movement

## Paths

- A multi-node route (walk, patrol, escort) lives in `waypoint_data`, `move_type` per sniffed spline, and runs from
  there: C++ `MoveWaypoint` (`MovePath` drops move types, delays and orientations) or the `creature_addon` path,
  SmartAI `WAYPOINT_START` (232, pathSource 0). Never hardcoded `Position` arrays or MOVE_TO_POS chains.
- Path id = spawn guid * 10 (+ n for extra paths) when the creature has a spawn guid; without one there is no fixed
  scheme.
- Don't copy a DB path into script data; if unavoidable, name its `waypoint_data` path id beside the copy so both get
  edited together.
- `ESCORT_*` actions and their `waypoints` table are a holdover whose escort handling retail escorts rarely match: use
  them only for a detail `waypoint_data` can't express. `script_waypoint` (C++ `npc_escortAI`) is deprecated.
- A path that runs once, or a patrol that must begin after a scripted moment (spawn or emerge animation, an event), is
  started from that event (SAI 232, or `MoveWaypoint` in the C++ script owning it), not auto-started via
  `creature_addon.path_id` / MovementType 2.
- A node's orientation applies only with a nonzero `delay`. A sniffed facing-only move (turn in place) is its own node:
  the previous position repeated, with that orientation and a delay of at least 1 ms.
- Random roaming from spawn onward is `creature.MovementType` 1 with a nonzero `wander_distance`, event-driven roaming
  `RANDOM_MOVE`; chained MOVE_TO_POS on self from MovementInform drifts away from the spawn point.

## Single points

In C++ scripts, one-off points (charge, fight, outro spots) are named `Position` constants used with `MovePoint`. An
orientation sets the facing on arrival; never precompute the travel angle, the move does that itself.

## Speed

- `waypoint_data.velocity` stays 0 so the creature's own speed applies (walk or run per `move_type`, swim or flight
  while swimming or flying); set it only for special movement (jumps, vehicles, smoothed flying splines).
- `velocity` is absolute yd/s; `creature_template.speed_walk`/`speed_run`/`speed_swim`/`speed_flight` multiply the
  base speed (walk 2.5, run 7.0, swim 4.722222, flight 7.0). Template speeds aren't always sniffed: before changing or
  relying on one, divide the sniffed speed by the base and compare.
- A creature falling behind its group: check its template speed against the sniff as above; if it matches, fix the
  move type (e.g. walk instead of run), not the speed.

## Spawn state

Rooted, hovering and flying from spawn onward are sniffed states that, like speed or unit flags, can differ per spawn.
A creature gets a `creature_template_movement` row when most of its spawns share the state, and a
`creature_movement_override` row (keyed by `SpawnId`; NULL columns fall back to the template) for each spawn that
differs from the template. Values: `Rooted`=1; `Flight`=1 DisableGravity, 2 CanFly; `Ground`=2 Hover. Scripts and
auras stay for temporary, event-driven changes.
