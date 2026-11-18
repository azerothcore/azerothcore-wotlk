# C++ guidelines

Run the linter before claiming a change is done: `python apps/codestyle/codestyle-cpp.py`

## Code style

Hard rules (CI builds with `-Werror` and runs `cppcheck`):

- Allman braces. No braces around single-line statements. `if (x)`, never `if(x)` or `if ( x )`.
- `auto const&` (not `const auto&`); `Type const*` (not `const Type*`).
- `{}` format specifiers (`fmt`-style), not `%u`/`%s`.
- Typed helpers, not raw flag access:
  - `IsPlayer()`, `IsCreature()`, `IsItem()`, … not `GetTypeId() == TYPEID_*`.
  - `GetNpcFlags()`, `Has/Set/RemoveNpcFlag()`, `ReplaceAllNpcFlags()` not `*Flag(UNIT_NPC_FLAGS, …)`.
  - `IsRefundable()`, `IsBOPTradable()`, `IsWrapped()` not `HasFlag(ITEM_FIELD_FLAGS, …)`.
  - `HasFlag(ItemFlag)` / `HasFlag2(ItemFlag2)` / `HasFlagCu(ItemFlagsCustom)` not bitwise `Flags & ITEM_FLAG…`.
  - `ObjectGuid::ToString().c_str()` not `ObjectGuid::GetCounter()`.

## Project helpers

- **Logging**: `LOG_INFO("category.sub", "msg with {}", arg)` (also `LOG_WARN`/`ERROR`/`DEBUG`/`TRACE`), macro in
  `src/common/Logging/Log.h`. Categories are hierarchical, dot-separated (`server.loading`, `entities.player`,
  `sql.dev`). No `printf`-style, `sLog->` or `TC_LOG_*`.
- **Random**: `src/common/Utilities/Random.h` helpers (`urand`, `irand`, `frand`, `rand32`, `rand_chance`,
  `roll_chance_f`, `roll_chance_i`), not `std::rand` or `<random>`.
- **Strings**: `Acore::StringFormat(fmt, args...)` (`{}` placeholders), in `src/common/Utilities/StringFormat.h`.
- **Namespace**: project-wide `Acore::`; rename `Trinity::` remnants when porting.
- **DB queries**: `PreparedStatement` (via `WorldDatabase` / `CharacterDatabase` / `LoginDatabase` and the
  prepared-statement enums), not raw query strings. Non-blocking reads go async:
  `_queryProcessor.AddCallback(db.AsyncQuery(stmt).WithPreparedCallback(...))` (or `WithCallback`). Multi-statement
  writes wrap in `SQLTransaction` + `Execute` / `AppendPreparedStatement`.

## Object lifetime

- Don't store a raw `Player*` / `Creature*` / `Unit*` past the current call/tick; the object can be removed (logout,
  despawn, instance unload) and the pointer dangles. Store the `ObjectGuid` and resolve at use time via
  `ObjectAccessor::FindPlayer(guid)`, `Map::GetCreature(guid)`, etc.

## Read also

- A class deriving a hook script type from `ScriptDefines/*.h` (`PlayerScript`, `WorldScript`, `ServerScript`, …) →
  `systems/scripting.md`
- Adding, moving or editing a `sConfigMgr->GetOption` call → `systems/config.md`
- `SpellInfoCorrections.cpp` → `systems/spells.md`
- `src/server/game/AI/**` outside `SmartScripts/`, or an AI class (`ScriptedAI`, `BossAI`, `CreatureAI`, `GameObjectAI`,
  …) under `modules/` → `systems/creature-ai.md`
- A `SpellScript`/`AuraScript` under `modules/` → `systems/spells.md`
- An `InstanceScript`/`InstanceMapScript` under `modules/` → `systems/instance-scripts.md`
- Porting C++ from TrinityCore/cMaNGOS → `systems/ports-and-rewrites.md`
