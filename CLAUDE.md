# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AzerothCore is an open-source MMORPG server emulator for World of Warcraft patch 3.3.5a (Wrath of the Lich King). It's written in C++17, built with CMake, using MySQL/MariaDB for data storage. Licensed under GNU GPL v2. Current version: 15.0.0-dev.

## Build Commands

### Configure and build (out-of-source build required)

- Skip building unless explicitly requested.

```bash
# Create build directory and configure
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/azeroth-server -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DSCRIPTS=static -DMODULES=static

# Build (use appropriate core count)
make -j$(nproc)
make install
```

### Key CMake options

- `SCRIPTS`: none, static, dynamic, minimal-static, minimal-dynamic (default: static)
- `MODULES`: none, static, dynamic (default: static)
- `APPS_BUILD`: none, all, auth-only, world-only (default: all)
- `TOOLS_BUILD`: none, all, db-only, maps-only (default: none)
- `BUILD_TESTING`: Enable unit tests (default: OFF)
- `USE_COREPCH` / `USE_SCRIPTPCH`: Precompiled headers (default: ON)

CMake version required: 3.16-3.22.

### Unit tests

```bash
# Configure with testing enabled
cmake .. -DBUILD_TESTING=ON
make -j$(nproc)

# Run tests
./src/test/unit_tests
# or
ctest
```

Tests use Google Test and live in `src/test/`. The test binary links against the `game` library.

### Codestyle checks (CI-enforced)

```bash
# C++ codestyle
python apps/codestyle/codestyle-cpp.py

# SQL codestyle
python apps/codestyle/codestyle-sql.py
```

## Architecture

### Two server executables
- **authserver** (`src/server/apps/authserver/`): Handles authentication and realm selection (port 3724)
- **worldserver** (`src/server/apps/worldserver/`): Main game server handling all gameplay (port 8085)

### Source layout (`src/`)

- **`src/common/`** - Shared libraries: networking (Asio), cryptography, configuration, logging, threading, collision detection, utilities
- **`src/server/game/`** - Core game logic (~52 subsystems), the heart of the worldserver
- **`src/server/scripts/`** - Content scripts (bosses, spells, commands, instances)
- **`src/server/database/`** - Database abstraction layer and schema updater
- **`src/server/shared/`** - Code shared between auth and world servers (packets, network, realm definitions)
- **`src/test/`** - Unit tests (Google Test)

### Key game subsystems (`src/server/game/`)

| Directory | Purpose |
|-----------|---------|
| **Entities/** | Core game objects: `Player`, `Creature`, `Unit`, `Item`, `GameObject` |
| **Spells/** | Spell mechanics, aura system, spell effects |
| **Maps/** | Map management, grid system, instancing |
| **Handlers/** | Client packet handlers (one file per system). These are methods on `WorldSession` |
| **AI/** | Creature AI framework |
| **Scripting/** | Script system (`ScriptMgr`, `ScriptObject` subclasses) |
| **Server/** | `WorldSession` (per-player connection), `World` (global state), opcode definitions |
| **Movement/** | Movement generators and pathfinding |
| **Combat/** | Combat formulas and threat management |
| **Conditions/** | Condition system for scripting and DB-driven logic |
| **Loot/** | Loot generation and distribution |
| **Quests/** | Quest tracking and completion logic |
| **Groups/** | Party and raid group management |
| **Guilds/** | Guild management system |
| **Battlegrounds/** | PvP battleground logic |
| **DungeonFinding/** | LFG/LFD system |
| **DataStores/** | DBC data loading (client data files) |
| **Accounts/** | Account management |
| **Chat/** | Chat system and channels |
| **Achievements/** | Achievement system |
| **AuctionHouse/** | Auction house logic |
| **Warden/** | Anti-cheat system |
| **Weather/** | Weather system |
| **Globals/** | `ObjectMgr` and global data caches |

### Scripts layout (`src/server/scripts/`)

```
scripts/
├── Commands/          # GM commands (cs_*.cpp)
├── EasternKingdoms/   # Zone, dungeon, and raid scripts
├── Kalimdor/          # Zone, dungeon, and raid scripts
├── Northrend/         # Zone, dungeon, and raid scripts (Ulduar, ICC, etc.)
├── Outland/           # Zone, dungeon, and raid scripts
├── Spells/            # Spell scripts by class (spell_dk.cpp, spell_mage.cpp, etc.)
├── World/             # World-wide event and gossip scripts
├── Events/            # Seasonal event scripts
├── Pet/               # Pet AI and spell scripts
├── OutdoorPvP/        # Outdoor PvP zone scripts
└── Custom/            # Custom user scripts (gitignored)
```

### Scripting system

Scripts follow a registration pattern:
1. Define a class inheriting from `SpellScript`, `CreatureScript`, `CommandScript`, etc.
2. Implement an `AddSC_*()` function that calls `RegisterSpellScript(ClassName)` or similar
3. The `AddSC_*()` is declared and called from the regional `*_script_loader.cpp`
4. Script loaders per region: `spells_script_loader.cpp`, `northrend_script_loader.cpp`, etc.

**Spell scripts** are organized by class: `spell_dk.cpp`, `spell_mage.cpp`, `spell_generic.cpp`, etc. Scriptnames should be prefixed with `spell_<class>_`.

**Boss scripts** use `ScriptedCreature` base and follow the pattern:
```cpp
struct boss_example : public BossAI
{
    boss_example(Creature* creature) : BossAI(creature, DATA_BOSS_ID) { }
    // Event-driven using EventMap
};
```

**Command scripts** inherit from `CommandScript` and define `GetCommands()` returning a `ChatCommandTable`.

**Creature scripts** use `struct` with `ScriptedAI` or `BossAI` base and `RegisterCreatureAI(StructName)`.

### Hook system

The `ScriptMgr` class in `src/server/game/Scripting/ScriptMgr.h` defines all available hooks. Hook categories include: ServerScript, WorldScript, FormulaScript, MapScript, InstanceMapScript, ItemScript, CreatureScript, GameObjectScript, AreaTriggerScript, BattlegroundScript, CommandScript, WeatherScript, AuctionHouseScript, ConditionScript, VehicleScript, PlayerScript, AccountScript, GuildScript, GroupScript, UnitScript, and more.

### Three databases
- **acore_auth** - Accounts, realm list, bans (`data/sql/base/db_auth/`)
- **acore_characters** - Character data, inventories, progress (`data/sql/base/db_characters/`)
- **acore_world** - Game content: creatures, items, quests, spells, loot (`data/sql/base/db_world/`)

### Database access patterns

- Uses prepared statements for all queries: `CharacterDatabasePreparedStatement*`, `WorldDatabasePreparedStatement*`, `LoginDatabasePreparedStatement*`
- Transaction support: `CharacterDatabase.BeginTransaction()` / `CommitTransaction(trans)`
- Async queries: `CharacterDatabase.Execute(stmt)` for fire-and-forget
- Statement IDs are defined in enums (e.g., `CHAR_UPD_*`, `CHAR_INS_*`, `CHAR_DEL_*`)

### SQL file placement

- **Pending updates**: `data/sql/updates/pending_db_world/`, `pending_db_characters/`, `pending_db_auth/` - New SQL changes go here with random filenames
- **Merged updates**: `data/sql/updates/db_world/`, `db_characters/`, `db_auth/` - After PR merge
- **Base schemas**: `data/sql/base/db_world/`, `db_characters/`, `db_auth/` - Initial database setup
- **Archive**: `data/sql/archive/` - Old archived SQL updates
- SQL files outside `data/sql/updates/pending_*` folders should never be updated in PRs
- Changes to `base/` or `archive/` directories trigger CI warnings and require maintainer approval

### Logging system

Uses a custom logging framework with `LOG_*` macros:
```cpp
LOG_ERROR("category", "Message with {} formatting", variable);
LOG_WARN("category", "...");
LOG_INFO("category", "...");
LOG_DEBUG("category", "...");
LOG_TRACE("category", "...");
```
Categories include: `network`, `network.opcode`, `server`, `sql.sql`, `misc`, etc.

### Module system

External modules are loaded from the `modules/` directory. Each module is a subdirectory with its own `CMakeLists.txt`. Disable specific modules with `-DDISABLED_AC_MODULES="mod1;mod2"`. Module skeleton: https://github.com/azerothcore/skeleton-module/

### Dependencies

Bundled in `deps/`: boost, MySQL client, OpenSSL, zlib, recastnavigation (pathfinding), g3dlite (geometry), fmt (string formatting), argon2 (password hashing), jemalloc (memory allocator), utf8cpp, SFMT (random numbers), libmpq, readline, and others.

## Commit Message Format

Uses Conventional Commits:
```
Type(Scope/Subscope): Short description (max 50 chars)
```

- **Types**: feat, fix, refactor, style, docs, test, chore
- **Scopes**: Core (C++ changes), DB (SQL changes)
- **Subscopes**: Relevant subsystem (Spells, Scripts, Server, Ulduar, SAI, etc.)
- **Rules**: Capitalize subject, imperative mood, no period at end, max 50 chars title, max 72 chars per line in body
- **Examples**:
  - `fix(Core/Spells): Fix damage calculation for Fireball`
  - `fix(DB/SAI): Missing spell to NPC Hogger`
  - `feat(Core/Commands): New GM command to do something`
  - `fix(Scripts/Ulduar): Fix Mimiron phase transition`
  - `chore(DB): import pending files`

## Code Style

### C++ (4-space indentation, no tabs)

- UTF-8 encoding, LF line endings
- Max 80 character line length
- No braces around single-line `if`/`else`/`for`/`while` statements
- Multi-line block braces go on a new line (not trailing `if`/`else`)
- Use `{}` with `fmt` formatting for log/output instead of `%u`/`%s` etc.
- `auto const&` syntax (not `const auto&`)
- `Type const*` syntax (not `const Type*`), e.g., `Player const* player`
- `static` before type: `static uint32 someVar`
- No `if(` or `if ( ` — use `if (condition)` with single space
- No double semicolons `;;`
- No trailing whitespace, no multiple consecutive blank lines
- Use `'f'` suffix for float literals: `234.3456f`
- Never declare multiple pointers on one line
- All headers must have include guards (`#ifndef __NAME_H` / `#define __NAME_H`)

### Naming conventions

- **Public/protected members**: `UpperCamelCase` — `SomeGuid`, `ShadowBoltTimer`
- **Private members**: underscore prefix + `lowerCamelCase` — `_someGuid`, `_count`
- **Methods**: `UpperCamelCase` — `DoSomething(uint32 someNumber)`
- **Parameters**: `lowerCamelCase` — `someNumber`, `targetPlayer`
- **Constants/enums**: `UPPER_SNAKE_CASE` with standard prefixes:
  - Spells: `SPELL_MAGE_FIREBALL`, `SPELL_GENERIC_BERSERK`
  - NPCs: `NPC_IRON_CONSTRUCT`
  - Items: `ITEM_*`
  - GameObjects: `GO_*`
  - Quests: `QUEST_*`
  - Text: `SAY_AGGRO`, `EMOTE_JETS`
  - Events: `EVENT_SPELL_SCORCH`
  - Data: `DATA_BOSS_ID`
  - Achievements: `ACHIEV_*`
  - Models: `MODEL_*`
- **WorldObjects**: `GameObject* go;`, `Creature* creature;`, `Player* player;`

### CI-enforced codestyle checks (will fail your PR)

The `codestyle-cpp.py` script checks:
- No multiple consecutive blank lines (including at end of file)
- No trailing whitespace
- No `ObjectGuid::GetCounter()` — use `ObjectGuid::ToString().c_str()`
- No `GetTypeId() == TYPEID_PLAYER` — use `IsPlayer()`, `IsCreature()`, `IsItem()`, `IsGameObject()`, `IsDynamicObject()` instead
- No direct `UNIT_NPC_FLAGS` access — use `GetNpcFlags()`, `HasNpcFlag()`, `SetNpcFlag()`, `RemoveNpcFlag()`, `ReplaceAllNpcFlags()`
- No direct `ITEM_FIELD_FLAGS` access — use `IsRefundable()`, `IsBOPTradable()`, `IsWrapped()`
- No `Flags & ITEM_FLAG_*` — use `HasFlag(ItemFlag)`, `HasFlag2(ItemFlag2)`, `HasFlagCu(ItemFlagsCustom)`
- No `const auto&` — use `auto const&`
- No `const Type*` — use `Type const*`
- No tabs (4 spaces required)
- No opening brace on same line as `if`/`else`

### SQL style

- Always use backticks around table and column names: `` `creature_template` ``
- Single quotes for string values, no quotes for numeric values
- DELETE before INSERT (never use REPLACE)
- DELETE/UPDATE must include at least primary key in WHERE clause
- Prefer IN clause for multiple values: `WHERE entry IN (1, 2, 3)`
- Use variables for repeated entries: `SET @ENTRY := 7727;`
- Compact queries: bundle multiple rows in single INSERT
- For flags: use bitwise operations (`|` to add, `&~` to remove), never override entire flag field
- Table naming: `snake_case` (`creature_loot_template`)
- Column naming: `UpperCamelCase` with uppercase acronyms (`PositionX`, `DisplayID`, `ItemGUID`)
- Use `INT` not `INT(11)`, never use `MEDIUMINT`
- Engine: InnoDB only (CI enforced)
- Charset: `utf8mb4`, Collation: `utf8mb4_unicode_ci` (`utf8mb4_bin` for name columns)
- SQL files in `pending_*` directories use random filenames
- No `EntryOrGuid` — use `entryorguid` (lowercase)
- Don't edit `broadcast_text` table unless approved with sniff data
- Don't DELETE from `creature_template`, `gameobject_template`, `item_template`, `quest_template`
- End every SQL statement with a semicolon
- 4-space indentation, no tabs
- No trailing whitespace, no multiple blank lines

## CI/CD Pipelines

CI runs on every PR and includes:
- **codestyle.yml**: C++ codestyle checks + cppcheck static analysis (triggers on `src/` changes)
- **sql-codestyle.yml**: SQL codestyle checks (triggers on `data/` changes)
- **core-build-pch.yml**: Linux build with PCH (clang-15 on Ubuntu 22.04, clang-18 on Ubuntu 24.04)
- **core-build-nopch.yml**: Linux build without PCH (clang-15, clang-18, gcc-14)
- **macos_build.yml**: macOS compatibility testing
- **windows_build.yml**: Windows compatibility testing
- **core_modules_build.yml**: Module compilation testing

The build compiles with `-Werror` — all warnings are errors.

## PR Requirements

- AI tool usage must be disclosed in PRs (checkbox in PR template)
- In-game testing expected and documented
- Changes to generic code require regression testing of related systems
- Cherry-picks must credit original authors with `--author` tag
- Sources should be provided (live servers, sniffs, video evidence, knowledge databases)
- SQL changes go in `data/sql/updates/pending_*` directories only

## Key Patterns and Conventions

### File header

Every source file starts with the GPL v2 license header:
```cpp
/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * ...
 */
```

### Enum definitions for game data

Always define spell/NPC/item IDs as named enum constants at the top of script files:
```cpp
enum MySpells
{
    SPELL_FIREBALL      = 12345,
    SPELL_FROSTBOLT     = 12346,
};

enum MyNPCs
{
    NPC_HELPER          = 54321,
};
```

### Smart AI (SAI)

Database-driven AI for creatures is done via the `smart_scripts` table. Subscope for SAI changes is `DB/SAI`.

### Configuration files

Configuration templates live in `conf/dist/` (e.g., `worldserver.conf.dist`, `authserver.conf.dist`). Never edit dist files directly; runtime configs go in `conf/` (gitignored).

## Important Links

- Wiki: https://www.azerothcore.org/wiki
- C++ Code Standards: https://www.azerothcore.org/wiki/cpp-code-standards
- SQL Standards: https://www.azerothcore.org/wiki/sql-standards
- Hooks guide: https://www.azerothcore.org/wiki/hooks-script
- Contributing: https://www.azerothcore.org/wiki/contribute
- Doxygen: https://www.azerothcore.org/pages/doxygen/index.html
- Discord: https://discord.gg/gkt4y2x
