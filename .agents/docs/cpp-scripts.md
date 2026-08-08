# C++ scripts

Scripts inherit from a `ScriptObject` subclass (`SpellScript`, `AuraScript`, `CreatureScript`, `InstanceMapScript`, `GameObjectScript`, `CommandScript`, …). Two registration styles coexist:

- **Spell / aura scripts**: `RegisterSpellScript(ClassName)` (or `RegisterSpellAndAuraScriptPair(...)`) inside `AddSC_<name>()`.
- **Creature scripts**: prefer `RegisterCreatureAI(ClassName)` for new code; legacy zones still use `new ClassName();`. Match the surrounding pattern.

Then declare and call `AddSC_<name>()` from the regional loader (`Spells/spells_script_loader.cpp`, `EasternKingdoms/eastern_kingdoms_script_loader.cpp`, …).

**SmartAI** (data-driven creature behaviour) lives in the world DB's `smart_scripts` table, not C++ (engine: `src/server/game/AI/SmartScripts/`). For new creature behaviour prefer SmartAI (via the SQL update workflow); reach for `CreatureScript` only when SmartAI's event/action vocabulary isn't enough.

**Module hooks** (e.g. `OnPlayerLogin`, `OnWorldUpdate`, `OnSpellCast`) are declared in `src/server/game/Scripting/ScriptDefines/*.h`. Implement by inheriting the matching base (`PlayerScript`, `WorldScript`, …) and registering with `new MyClass();` (or its `RegisterXxxScript` macro) inside `AddSC_<name>()`. Full list: https://www.azerothcore.org/wiki/hooks-script.

**Conventions:**

- Script ids (action/event/data/phase) get named enum entries — never raw literals, even when the file already uses them: add the entry and convert that literal's every call site and handler in the same change.
- A `SpellScript`/`AuraScript` without a matching `spell_script_names` row is inert — ship the binding SQL update in the same change as the C++ registration.
- Never add `UNIT_FLAG*` / `UNIT_FLAG2*` / `UNIT_DYNFLAG*` values without sniff or upstream evidence; the same flag used in another script is not evidence.
- Trigger NPCs (`creature_template.flags_extra` 0x80) have no threat list — `SelectTarget` / `AddThreat` / `UpdateVictim` chains on them silently do nothing. A never-evading helper NPC left on a boss's threatened-by list also stalls the boss's evade/reset forever; make such helpers `IMMUNE_TO_NPC`.
- A spell id missing from Wowhead is inconclusive — check the world DB's `spell_dbc` table (server-side spells) before concluding a sniffed id doesn't exist.

Custom (non-upstream) scripts go in `src/server/scripts/Custom/` (gitignored).
