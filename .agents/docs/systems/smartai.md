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
- Per-spawn behaviour (one spawn's path, emote loop or RP) goes in guid SAI: `entryorguid` = `-guid`, template
  `AIName` = `SmartAI`. A guid script replaces the entry script for that spawn, so also set
  `CREATURE_FLAG_EXTRA_DONT_OVERRIDE_ENTRY_SAI` (`flags_extra` 0x08000000) to load both; it is template-wide and
  changes nothing for spawns without a guid script.
- `TALK` (action 1) to a creature target (not a pet): `action_param3` = 0 makes the target speak its own line; 1 has
  the script owner speak, with the target as `$n`. With target `SELF`, the last invoker is `$n`.
