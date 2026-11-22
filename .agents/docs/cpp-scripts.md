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

- Script ids (action/event/data/phase) get named enum entries, never raw literals, even where the file already uses
  them: add the entry and convert that literal's every call site and handler in the same change.

## Scope of a fix

- New creature behaviour goes in SmartAI (world DB `smart_scripts`, via the SQL update workflow; engine in
  `src/server/game/AI/SmartScripts/`); write a `CreatureScript` only when SmartAI's event/action vocabulary isn't
  enough.

## Read also

- Class deriving `ScriptedAI`, `BossAI`, `CreatureAI`, `GameObjectAI` or another AI base, or registered via
  `RegisterCreatureAI`/`RegisterGameObjectAI` → `systems/creature-ai.md`
- `instance_*.cpp`, a class deriving `InstanceScript`/`InstanceMapScript`, calls to `LoadObjectData`/`ObjectData`,
  `LoadSummonData`/`SummonData` or `instance->GetCreature(DATA_*)`, or summoning a creature in an instance's scripts
  → `systems/instance-scripts.md`
- `SpellScript`/`AuraScript` → `systems/spells.md`
- `SetData`/`DoAction` on a creature or gameobject whose `AIName` is `SmartAI`/`SmartGameObjectAI` →
  `systems/smartai.md`
- Movement code (`GetMotionMaster()->Move*`, `MovePath`, `MovePoint`, `Position` arrays) → `systems/movement.md`
