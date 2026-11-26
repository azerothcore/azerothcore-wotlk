# C++ scripts

Scripts derive from a `ScriptObject` subclass (`SpellScript`, `AuraScript`, `CreatureScript`, `InstanceMapScript`,
`GameObjectScript`, `CommandScript`, …) and register inside `AddSC_<name>()`:

- Spell/aura scripts: `RegisterSpellScript(ClassName)` or `RegisterSpellAndAuraScriptPair(...)`.
- Creature scripts: `RegisterCreatureAI(ClassName)` for new code; legacy zones use `new ClassName();`. Match the
  surrounding pattern.

Declare and call `AddSC_<name>()` from the regional loader (`Spells/spells_script_loader.cpp`,
`EasternKingdoms/eastern_kingdoms_script_loader.cpp`, …).

Custom (non-upstream) scripts go in `src/server/scripts/Custom/` (gitignored).

## Conventions

- Script ids (spell/action/event/data/phase) get named entries in the file's existing enum, never raw literals or
  `static constexpr` class members, even where the file already uses them: add the entry and convert that literal's
  every call site and handler in the same change; a touched line holding a raw spell id gets converted too. A new
  action/event/data/phase entry continues its enum's numbering (no jump to e.g. 100); a spell entry keeps its spell
  id. Define each value once (no enum entry duplicating a `constexpr`). Timer durations are exempt: inline
  (`events.Repeat(4900ms)`), or named where the file already names its timers.
- File-local free helper functions are `static`, never in an anonymous namespace.
- Remove from what the change adds or touches: commented-out enum entries, actions and constants nothing uses, and
  unreachable code (e.g. after the `return` in `Reset()`'s `DONE` branch). Before deleting an unused spell constant,
  check whether retail casts it (e.g. as the summon spell); if so, the fix is to cast it. Read values from spell data
  (`GetSpellInfo()->Effects[i].CalcValue()`), not per-id branches.
- Use the existing helpers, not hand-rolled versions:
  - Combat target: `SelectTarget(SelectTargetMethod::…, pos, dist)`, not a loop over `Map::PlayerList`; a negative
    `dist` sets a minimum range (e.g. `-8.0f` for a charge).
  - Re-add a creature to its DB formation: `if (!c->GetFormation()) c->SearchFormation();`.
  - Grid search over several entries: one `GetCreatureListWithEntryInGrid(list, std::vector<uint32>{…}, range)`, not
    one call per entry.

## Scope of a fix

- New creature behaviour goes in SmartAI (world DB `smart_scripts`, via the SQL update workflow; engine in
  `src/server/game/AI/SmartScripts/`); write a `CreatureScript` only when SmartAI's event/action vocabulary isn't
  enough.
- Before writing a fix or adding a call or hook, check what already does that job and leave it out; keep C++ for
  what these can't do:
  - core on that path (`CanAIAttack` and threat-list offline refs, `UpdateVictim` under the creature's react state,
    spell target/destination selection, the client packet handler, `Unit::Kill` already calling
    `setDeathState(JustDied)`, which sets the corpse remove time)
  - the base class (`BossAI::_JustEngagedWith` already runs `SetBossState(IN_PROGRESS)`)
  - earlier code paths in the same script (events a phase transition already cancelled)
  - DB data (`smart_scripts` actions, `spell_linked_spell` rows)
- Change only what causes the bug. Leave behaviour it doesn't require (event delays, timers, spawn timing) untouched
  unless a sniff or upstream core shows it is wrong.
- When the creature's AI already casts the spell or owns the summon, fix target pick, facing or placement there, not
  with a new `SpellScript` and `spell_script_names` row; a spell script fits when it hooks the spell retail uses for
  that job (e.g. a sniffed helper or dummy spell) or is the `OnDestinationTargetSelect` Z-fix in `systems/spells.md`.

## Read also

- Class deriving `ScriptedAI`, `BossAI`, `CreatureAI`, `GameObjectAI` or another AI base, or registered via
  `RegisterCreatureAI`/`RegisterGameObjectAI` → `systems/creature-ai.md`
- `instance_*.cpp`, a class deriving `InstanceScript`/`InstanceMapScript`, or calls to `SetBossState`/`GetBossState`,
  `instance->SetData`/`GetData`/`GetGuidData`, `CheckRequiredBosses`, `LoadObjectData`/`ObjectData`,
  `LoadSummonData`/`SummonData` or `instance->GetCreature(DATA_*)`, a non-`BossAI` creature AI calling
  `GetInstanceScript()`, summoning a creature in an instance's scripts, or removing a DB spawn for the lockout
  (`DespawnOrUnsummon`, `Delete()`) → `systems/instance-scripts.md`
- `SpellScript`/`AuraScript`, or code that summons (`SummonCreature`, `SummonGameObject`, `DoSummon*`,
  `JustSummoned`) → `systems/spells.md`
- Rewriting a script, replacing SmartAI with C++, or porting a script → `systems/ports-and-rewrites.md`
- `SetData`/`DoAction` on a creature or gameobject whose `AIName` is `SmartAI`/`SmartGameObjectAI` →
  `systems/smartai.md`
- Movement code (`GetMotionMaster()->Move*`, `MovePath`, `MovePoint`, `Position` arrays) → `systems/movement.md`
