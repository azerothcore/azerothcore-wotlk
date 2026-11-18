# SmartAI

Data-driven behaviour in the world DB's `smart_scripts` (engine: `src/server/game/AI/SmartScripts/`). Names below drop
the `SMART_EVENT_`/`SMART_ACTION_`/`SMART_TARGET_` prefix; numbers are their ids.

- Check every param against the `SmartEvent`/`SmartAction` structs in `SmartScriptMgr.h` and the validation in
  `SmartScriptMgr.cpp`, not the enums' inline comments, which can be stale (`CALL_TIMED_ACTIONLIST` is id, timerType,
  allowOverride).
- Edits rewrite the full block: `DELETE` + `INSERT` of every row for the `(entryorguid, source_type)` pair, the
  `DELETE` matching both columns; never a partial `UPDATE`, not even for a comment-only fix.

## Evidence

- Sniff data (your own, the reviewer's, or upstream sniff-verified rows) is the norm; match it across all sniffed
  runs:
  - min/max delays where retail varies;
  - each spawn's or summon's own point and path when they differ (a shared offset is fine within about a yard);
  - run vs walk from the spline flags;
  - a fixed orientation or a face-target action, whichever the sniff shows;
  - the consistent casts and emotes of every participant, not only the main actor's.
- Rows forcing combat or targeting (Add Threat, Taunt, Start Attacking, ReactState Passive/Aggressive toggles on
  summons) need a sniff showing them: creatures aggro by detection range and are aggressive by default.
- Never invent a helper creature (e.g. an invisible stalker with `ADD_AURA`) to fake a spell effect; fix the spell
  itself: its DB data (e.g. spell `conditions`), or a SpellScript or AuraScript when data can't.

## Entry and GUID scripts

- A GUID script (`entryorguid` = -spawn guid) fully replaces the entry script for that spawn. Only exception:
  `CREATURE_FLAG_EXTRA_DONT_OVERRIDE_ENTRY_SAI` (`flags_extra` 0x08000000) on a creature template loads both into one
  event list, so GUID rows must not reuse any entry-script `id` (use 1000+ or continue after the entry's highest id).
  Gameobjects have no such flag.
- When only some spawns of an entry need extra or different SmartAI, set that flag and give those spawns GUID scripts
  holding only the spawn-specific rows. Never copy entry rows into a new GUID script, condition entry rows on a spawn's
  own guid (see https://www.azerothcore.org/wiki/introduction-to-smartai, part III), or replay actions through
  waypoint paths. Entry rows that apply only to some spawns (e.g. a shorter respawn in one area) move into those spawns'
  GUID scripts.
- The flag makes all GUID scripts of the template's spawns run the entry rows too: when setting it, turn each existing
  one into a continuation of the entry script. Before changing an entry's `smart_scripts`, check its spawns' GUID
  scripts: mirror the change into each one that copies the changed rows or calls the same actionlists, or set the flag.

## Signals and targets

- Signal a SmartAI receiver with `DO_ACTION` (223) → `ACTION_DONE` (72). `SET_DATA` (45) stores the value on the
  receiver (read by `CONDITION_AI_DATA`, `INC_DATA` or `GetData`) and raises `DATA_SET` (38); use it only when the
  value must persist, when the receiver uses its creature or gameobject sender (as action invoker, or, creature only,
  as condition target 0: `ACTION_DONE` passes none, so `ACTION_INVOKER` falls back to a stale last invoker), or when
  the receiver is a gameobject (no `ACTION_DONE` on gameobject SmartAI). If the receiver's existing signals use
  `SET_DATA`, keep it rather than mixing in `DO_ACTION`. A C++ AI receiver gets whichever of `SetData`/`DoAction` it
  implements.
- Address a creature the script just summoned by storing it from `SUMMONED_UNIT` (17) with `STORE_TARGET_LIST` (64) and
  targeting `STORED` (12), not by range targets. Storing replaces the list, so acting on it right after each summon
  reaches that summon. To keep several same-entry summons addressable later, give each its own list id, e.g. switch
  event phase between the summons and use phase-gated event-17 rows (`creature_summon_groups` can't tell same-entry
  summons apart).

## Sequences and timers

- Start each step of a scripted sequence (quest scene, escort, emerge-then-patrol) from the event that triggers it on
  retail, plus a sniffed delay after it if needed, never from guessed delays measured from the scene start. E.g.
  `MOVEMENTINFORM` (34) on a MOVE_TO_POS point id, `WAYPOINT_ENDED` (109), an emerge or other visible cast, a
  participant evading or leaving combat. Sniffed fixed timers (a delay after a step, a despawn) stay fine. A sniffed
  fixed repeat count (e.g. 7 requests) ends the repeating event at that count, not by an overall timer.
- Pick `CALL_TIMED_ACTIONLIST` (80) timerType (param2) by intent: 0 = out of combat only, pausing while engaged (lists
  that must not pull the creature out of a fight); 1 = in combat only; 2 = always (sequences that must finish or keep
  running through combat).
- SAI timers freeze while a creature evades (UpdateAI is skipped).
- A sequence that sets state only a later step clears (unit flags, react state, faction, formation/group membership)
  needs On Reset rows undoing it in case it stalls. SmartAI's evade reset restores none of these: it only resets
  event phase, re-arms timers and not-repeatable events (except `event_flags` 0x100 rows), and clears counters and
  the last invoker.

## Idle state, buffs and casts

- OOC setup that should hold whenever the creature is idle at home (infinite channels, react state, emote/stand
  state) starts from `RESET` (25): it fires on spawn, respawn and on getting home after an evade, so needs no "not
  evading" condition. Several RESET rows run in order without `LINK`. Prefer it over a non-repeatable OOC `UPDATE`,
  which re-arms on every reset anyway.
- Keep a self-buff up, including a timed one that expires (e.g. a 30-min armor buff), with a repeating `UPDATE` (60)
  (initial delay, ~5s repeat) casting on self with `SMARTCAST_AURA_NOT_PRESENT` (32). Not a `HAS_AURA` (23)
  missing-aura row: it recasts instantly after a dispel such as Purge, unlike retail.
- No cast flag 1 (`SMARTCAST_INTERRUPT_PREVIOUS`, in `CAST`/`SELF_CAST`/`CROSS_CAST`/`INVOKER_CAST`/`CUSTOM_CAST`)
  on new rows: it's legacy (unrelated to `event_flags` 1 = not repeatable). On a rewritten row that inherited it, drop
  it unless the script really must cut the caster's current cast. Without it, only `CAST`/`CUSTOM_CAST` on timed
  events (`UPDATE`, `HEALTH_PCT`, actionlist steps, …) wait for a cast in progress.

## Removing and renumbering

- SmartEvent conditions are `conditions` rows with SourceTypeOrReferenceId 22, SourceEntry = entryorguid, SourceId =
  source_type, SourceGroup = event id + 1; a leftover one silently gates whatever event now holds that id. When a
  change renumbers, removes or repurposes event ids (including wiping `smart_scripts` or clearing AIName), update or
  delete them in the same SQL file, scoping the DELETE by SourceTypeOrReferenceId, SourceEntry and SourceId and
  re-inserting the conditions still needed.
- Deleting `smart_scripts` rows or actionlists: in the same change, fix everything still referencing them (other
  entries or spawns calling those actionlists, their SmartEvent conditions).

## No-op rows

Don't add rows or conditions that change nothing, e.g. Set ReactState Aggressive on a creature nothing made passive;
a "target alive" condition the target type already enforces (`CREATURE_RANGE` (9) and `CREATURE_DISTANCE` (11) have
an alive param; `CLOSEST_CREATURE` (19) finds only living creatures unless its dead param is set). A negated check
("no living X within N yd") still needs its condition.
