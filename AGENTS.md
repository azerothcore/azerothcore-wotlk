# AGENTS.md

AzerothCore is a C++ MMORPG server emulator for World of Warcraft 3.3.5a (WotLK), built with CMake, backed by MySQL.

## Agent rules

- **Do not configure or build unless explicitly asked.** Builds are slow and rarely needed for code changes.
- **Never edit SQL files outside `data/sql/updates/pending_db_*/` unless explicitly requested. ** `data/sql/base/`, `data/sql/archive/`, and `data/sql/updates/db_*/` are immutable.

## Build

Out-of-source build is required (in-source is blocked).

```bash
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/azeroth-server -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DSCRIPTS=static -DMODULES=static
make -j$(nproc) && make install
```

C++20 required (`CMAKE_CXX_STANDARD 20`). Useful flags: `BUILD_TESTING=ON` (Google Test), `NOPCH=1` (disable precompiled headers). Full set in `conf/dist/config.cmake`. `compile_commands.json` is exported automatically.

Tests (Google Test, in `src/test/`): configure `-DBUILD_TESTING=ON`, then `ctest` or `./src/test/unit_tests` from the build dir.

## Repository layout

- `src/common/` — networking (Asio), crypto, config, logging, shared utilities.
- `src/server/game/` — core gameplay; compiled into worldserver.
- `src/server/scripts/` — content scripts grouped by region (`EasternKingdoms/`, `Northrend/`, …), class (`Spells/spell_mage.cpp`, …), and domain (`Commands/`, `Pet/`, `OutdoorPvP/`, `World/`).
- `src/server/database/` — DB abstraction and schema updater.
- `src/server/shared/` — code shared by auth and world servers.
- `src/server/apps/{authserver,worldserver}/` — entry points (ports 3724 and 8085).
- `src/test/` — Google Test unit tests + mocks.
- `data/sql/` — `base/` (historical schema), `updates/db_*/` (merged), `updates/pending_db_*/` (in-flight, **edit here**), `custom/` (gitignored).
- `modules/` — external modules (each a subdir with its own `CMakeLists.txt`). Disable with `-DDISABLED_AC_MODULES="mod1;mod2"`. See `modules/how_to_make_a_module.md`.
- `apps/` — helper scripts; `apps/codestyle/` holds the lint scripts.
- `conf/dist/` — distributed config templates; `conf/*.conf` is gitignored.
- `deps/` — vendored third-party dependencies.

## Adding SQL updates

1. `cd data/sql/updates/pending_db_world/` (or `pending_db_auth` / `pending_db_characters`).
2. `./create_sql.sh` generates an empty `rev_<timestamp>.sql` to write into.
3. Conventions enforced by `apps/codestyle/codestyle-sql.py`: every `INSERT` preceded by a matching `DELETE` (idempotency); no double semicolons; no multiple blank lines; InnoDB engine.

The three databases:

- `acore_auth` — accounts, realm list, IP/account bans, session keys. Shared across all realms.
- `acore_characters` — per-character state: characters, inventory, in-progress quests, mail, guilds, arena teams, achievements. One per realm.
- `acore_world` — static game content: creature/gameobject/item/quest templates, spawn lists, loot tables, SmartAI scripts, gossip, conditions. Read-mostly; rebuilt from SQL.

## Code style

Formatting (charset, indent width, line length, final newline, trailing whitespace) follows `.editorconfig`.

Run the linters before claiming a change is done:

```bash
python apps/codestyle/codestyle-cpp.py     # C++
python apps/codestyle/codestyle-sql.py     # SQL (compares to origin/master)
```

Hard rules (also enforced by CI with `-Werror`, plus `cppcheck`):

- 4-space indent for C++ (tabs forbidden); 2-space for JSON/YAML/sh/ts/js. UTF-8, LF, max 120 cols, trailing newline.
- Allman braces. No braces around single-line statements. `if (x)` — never `if(x)` or `if ( x )`.
- `auto const&` (not `const auto&`); `Type const*` (not `const Type*`).
- Use `{}` format specifiers (`fmt`-style), not `%u`/`%s`.
- Use the typed helpers, not raw flag access:
  - `IsPlayer()`, `IsCreature()`, `IsItem()`, … instead of `GetTypeId() == TYPEID_*`.
  - `GetNpcFlags()`, `HasNpcFlag()`, `SetNpcFlag()`, `RemoveNpcFlag()`, `ReplaceAllNpcFlags()` instead of `*Flag(UNIT_NPC_FLAGS, …)`.
  - `IsRefundable()`, `IsBOPTradable()`, `IsWrapped()` instead of `HasFlag(ITEM_FIELD_FLAGS, …)`.
  - `HasFlag(ItemFlag)` / `HasFlag2(ItemFlag2)` / `HasFlagCu(ItemFlagsCustom)` instead of bitwise `Flags & ITEM_FLAG…`.
  - `ObjectGuid::ToString().c_str()` instead of `ObjectGuid::GetCounter()`.

## Project conventions

- **Logging**: `LOG_INFO("category.sub", "msg with {}", arg)` (also `LOG_WARN`/`ERROR`/`DEBUG`/`TRACE`). Categories are hierarchical, dot-separated (`server.loading`, `entities.player`, `sql.dev`). No `printf`-style, no `sLog->`, no `TC_LOG_*`. Macro in `src/common/Logging/Log.h`.
- **Random**: use helpers in `src/common/Utilities/Random.h` — `urand`, `irand`, `frand`, `rand32`, `rand_chance`, `roll_chance_f`, `roll_chance_i`. Not `std::rand` or `<random>`.
- **Strings**: `Acore::StringFormat(fmt, args...)` (`{}` placeholders) — `src/common/Utilities/StringFormat.h`.
- **Config**: `sConfigMgr->GetOption<T>("Name", default)`.
- **Namespace**: project-wide `Acore::` (no `Trinity::` remnants — rename when porting from upstream forks).
- **Long-lived references**: don't store a raw `Player*` / `Creature*` / `Unit*` past the current call/tick — the object can be removed (logout, despawn, instance unload) and the pointer dangles. Store the `ObjectGuid` and resolve at use time via `ObjectAccessor::FindPlayer(guid)`, `Map::GetCreature(guid)`, etc.
- **DB queries**: use `PreparedStatement` (via `WorldDatabase` / `CharacterDatabase` / `LoginDatabase` and the prepared-statement enums), not raw query strings. Non-blocking reads go async: `_queryProcessor.AddCallback(db.AsyncQuery(stmt).WithPreparedCallback(...))` (or `WithCallback`). Multi-statement writes wrap in `SQLTransaction` + `Execute` / `AppendPreparedStatement`.
- **Timed actions in AI**: use `EventMap` (event id → delay; simple) or `TaskScheduler` (lambdas, repeats, cancellation), both members of `CreatureAI` — don't roll your own tick counters. See any boss script under `src/server/scripts/`.

## Scripting registration

Scripts inherit from a `ScriptObject` subclass (`SpellScript`, `AuraScript`, `CreatureScript`, `InstanceMapScript`, `GameObjectScript`, `CommandScript`, …). Two registration styles coexist:

- **Spell / aura scripts**: `RegisterSpellScript(ClassName)` (or `RegisterSpellAndAuraScriptPair(...)`) inside `AddSC_<name>()`.
- **Creature scripts**: prefer `RegisterCreatureAI(ClassName)` for new code; legacy zones still use `new ClassName();`. Match the surrounding pattern.

Then declare and call `AddSC_<name>()` from the regional loader (`Spells/spells_script_loader.cpp`, `EasternKingdoms/eastern_kingdoms_script_loader.cpp`, …).

**SmartAI** (data-driven creature behaviour) lives in the world DB's `smart_scripts` table, not C++ (engine: `src/server/game/AI/SmartScripts/`). For new creature behaviour prefer SmartAI (via the SQL update workflow); reach for `CreatureScript` only when SmartAI's event/action vocabulary isn't enough.

**Module hooks** (e.g. `OnPlayerLogin`, `OnWorldUpdate`, `OnSpellCast`) are declared in `src/server/game/Scripting/ScriptDefines/*.h`. Implement by inheriting the matching base (`PlayerScript`, `WorldScript`, …) and registering with `new MyClass();` (or its `RegisterXxxScript` macro) inside `AddSC_<name>()`. Full list: https://www.azerothcore.org/wiki/hooks-script.

Custom (non-upstream) scripts go in `src/server/scripts/Custom/` (gitignored).
