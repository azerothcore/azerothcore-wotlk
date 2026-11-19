# SmartAI

Data-driven behaviour in the world DB's `smart_scripts` (engine: `src/server/game/AI/SmartScripts/`).

- Edits rewrite the full block: `DELETE` + `INSERT` of every row for the `(entryorguid, source_type)` pair, the
  `DELETE` matching both columns; never a partial `UPDATE`, not even for a comment-only fix.
- SmartAI `SET_DATA` (action 45) stores the value on a SmartAI target, readable by `CONDITION_AI_DATA` and `INC_DATA`,
  and raises `DATA_SET` (event 38). Toward a SmartAI receiver, use it only when the value must persist; a pure signal
  uses `DO_ACTION` (action 223) → `ACTION_DONE` (event 72). `SET_DATA` stays when the receiver uses its creature or
  gameobject sender — as action invoker, or (creature only) as condition target 0; `ACTION_DONE` passes none, so
  `ACTION_INVOKER` falls back to a stale last invoker — or when the receiver is a gameobject (no `ACTION_DONE` on
  gameobject SmartAI). A C++ AI receiver gets whichever of `SetData` / `DoAction` it implements.
- Caster combat movement is cast flag 64 (`SMARTCAST_COMBAT_MOVE`) on the main spell's cast rows: the caster stands
  while it casts and moves on range, OOM or LOS. Replace hand-scripted combat movement (`ALLOW_COMBAT_MOVEMENT`,
  action 21, with phase rows keyed on mana or range) on sight when rewriting a block.
- A timed self-buff is kept up by `UPDATE` (event 60) on a short timer with cast flag 32
  (`SMARTCAST_AURA_NOT_PRESENT`), not by random out-of-combat recast timers.
