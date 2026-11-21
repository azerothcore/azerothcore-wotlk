# Instance scripts

Encounter state and object storage of `InstanceScript`/`InstanceMapScript` (`instance_*.cpp`) and the scripts that
read or write it.

## Boss states

- Track encounter progress only in boss states (`SetBossState`/`GetBossState`): no parallel `SetData`/`Encounter[]`
  copy, and overrides such as `IsEncounterInProgress()` read the boss states.
- `BossAI` resets its state on evade and reset; other scripts (event NPCs, `ScriptedAI` bosses) must set
  `NOT_STARTED`/`FAIL` when the event fails, as a state left `IN_PROGRESS` blocks out-of-combat resurrection and
  raid zone-in.
- Boss prerequisites go in the instance's `CheckRequiredBosses` override. `BossAI::_JustEngagedWith` already calls
  it, so `BossAI` subclasses calling `_JustEngagedWith` must not re-check.

## Persisted vs runtime state

- AI members and `InstanceScript` fields outside the save data (boss states, persistent data slots,
  `WriteSaveDataMore`/`ReadSaveDataMore`) are lost on respawn, map unload or restart.
- Code that reruns after evade, `Reset()` or a reload (`Reset`, `JustRespawned`, `OnCreatureCreate`,
  `OnGameObjectCreate`) decides whether an event already ran from persisted state (boss state, saved fields, a DB
  spawn's saved respawn time), not from runtime members alone or the creature's current position, and resumes the
  event from it instead of replaying it.
- Append new fields at the end of `WriteSaveDataMore`/`ReadSaveDataMore` and read each with
  `if (!(data >> x)) x = <default>;`, so old saves keep the default (a failed `>>` writes 0). The save stream runs
  headers, boss states, persistent data slots, then More: a new boss or persistent data slot misaligns an old save's
  later values.
- To remove a DB-spawned object for the rest of the lockout, `DespawnOrUnsummon(0ms, <respawn>)`, which saves the
  respawn time; `Delete()` saves none, so the object returns when the map reloads. For a summoned object either works.
  A DB gameobject whose template can't despawn (neither `GetDespawnPossibility()` nor `IsDespawnAtAction()`) ignores
  its saved respawn time on load: remove it from persisted instance state in `OnGameObjectCreate`.

## ObjectData slots

- Each entry in the `ObjectData` tables passed to `LoadObjectData` maps to a `DATA_*` slot holding a single guid:
  `OnCreatureCreate` overwrites it unconditionally and `OnCreatureRemove` erases it when the current holder despawns.
  A summon with a listed entry thus redirects every `instance->GetCreature(DATA_X)` to itself and, once it despawns,
  empties the slot while the original spawn still lives.
- Never summon an entry listed in `ObjectData`; use a dedicated entry or track the summon through the summoner's
  `SummonList`/guid member.
- `JustSummoned` fires only on the direct summoner: boss adds spawned by an intermediate creature (e.g. a portal NPC
  casting the summon) skip the boss's `SummonList` and outlive its death and evade. Register them through the
  instance's `SummonData` table (`LoadSummonData`: add entry → boss `DATA_*` slot), never per-add `JustSummoned` calls;
  the boss must be in `ObjectData` and any `OnCreatureCreate` override must call the base.
