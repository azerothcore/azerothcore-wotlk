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
  changes nothing for spawns without a guid script. Both then share one event list, and `link` resolves to the first
  row with that `id`, so number the guid rows clear of the entry script's (from 1000).
- `TALK` (action 1) to a creature target (not a pet): `action_param3` = 0 makes the target speak its own line; 1 has
  the script owner speak, with the target as `$n`. Target `SELF` with 0 makes the last invoker `$n`.
- Caster combat movement is cast flag 64 (`SMARTCAST_COMBAT_MOVE`) on the main spell's cast rows: a successful cast
  stops combat movement and only a failed attempt (range, OOM, LOS) restarts it, so give that row a short repeat
  timer. When rewriting a block, replace hand-scripted combat movement (`ALLOW_COMBAT_MOVEMENT`, action 21, with
  phase rows keyed on mana or range) with it, after tracing the `event_phase_mask` and `link` of every row those
  phases gate: keep or move their other effects (e.g. a phase-1-only Frost Nova), and clear masks that no phase sets.
- A timed self-buff is kept up by `UPDATE` (event 60) on a short timer with cast flag 32
  (`SMARTCAST_AURA_NOT_PRESENT`), not by random out-of-combat recast timers.
- A new or changed SmartAI event, action or target parameter (`SmartScriptMgr.h` enum comment or param struct) needs
  follow-up PRs to the wiki `smart_scripts` page and to Keira3's SmartAI editor (`azerothcore/Keira3`); list both in
  the plan and the PR's TODO list.
