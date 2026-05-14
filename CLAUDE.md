# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **NostrumWoW** — a custom World of Warcraft 3.3.5a private server built on AzerothCore. It is a progression-phased, community-focused server with optional hardcore mode. See `NOSTRUM.md` for the full feature and design reference.

AzerothCore is an open-source MMORPG server emulator for World of Warcraft patch 3.3.5a (Wrath of the Lich King). It's a C++ project built with CMake, using MySQL for data storage. Licensed under GNU GPL v2.

## Custom Modules

All NostrumWoW-specific logic lives in `modules/`. Do not modify core files unless a feature genuinely cannot be implemented via a module hook.

| Module | Purpose |
|--------|---------|
| `mod-nostrum-progression` | Enforces level cap and instance/BG/LFG content locks per progression phase |
| `mod-nostrum-rates` | Centralized XP, reputation, loot, and money multipliers |
| `mod-nostrum-bg-xp` | BG completion XP with anti-AFK and daily bonus |
| `mod-nostrum-hardcore` | Opt-in hardcore and self-found hardcore mode |
| `mod-nostrum-guide` | New player guide NPCs in all starting zones |
| `mod-nostrum-starter` | One-time starter bag for fresh level-1 characters |
| `mod_nostrum_instant_mail` | Instant player-to-player mail delivery |
| `mod-level-rewards` | Gold mailed to players at level milestones |
| `mod-dual-spec-19` | Dual spec available from level 19 |
| `mod-cfbg` | Mixed-faction battlegrounds (third-party) |

### Custom DB entry ranges (do not reuse)

- `item_template` entry `900100`: Nostrum Starter Bag
- `creature_template` entries `900001`–`900002`: Guide NPCs
- `creature` / `gameobject` GUIDs `9000001`–`9000008`: Guide NPC spawns

### Module SQL

Module SQL files live in `modules/<name>/data/sql/` or `modules/<name>/sql/`. When a module creates tables at startup via `OnStartup()`, the SQL file is kept for reference and manual installation. Always run pending module SQL against the correct database (`acore_world` or `acore_characters`) before deploying.

### Key implementation notes

- **Cross-faction** is handled entirely via `AllowTwoSide.*` settings in `worldserver.conf`. All options are set to `1`.
- **Cross-faction RDF** works via `AllowTwoSide.Interaction.Group = 1` — `LFGMgr::SetTeam()` normalizes all players to the same queue. No core patch needed.
- **Cross-faction BGs** are handled entirely by `mod-cfbg`.
- **Session iteration** in modules: use `sWorldSessionMgr->GetAllSessions()` from `WorldSessionMgr.h`. Do not use `sWorld->GetAllSessions()` — that method does not exist on `IWorld`.
- **MariaDB compatibility**: `MySQLConnection.cpp` guards `mysql_stmt_bind_named_param` with `!defined(MARIADB_VERSION_ID) && MYSQL_VERSION_ID >= 80300`. The SSL block is also guarded for MariaDB. Do not remove these guards.

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

- **Entities/** - Core game objects: `Player`, `Creature`, `Unit`, `Item`, `GameObject`
- **Spells/** - Spell mechanics, aura system, spell effects
- **Maps/** - Map management, grid system, instancing
- **Handlers/** - Client packet handlers (one file per system: `MovementHandler.cpp`, `SpellHandler.cpp`, etc.). These are methods on `WorldSession`
- **AI/** - Creature AI framework
- **Scripting/** - Script system with typed base classes (`ScriptObject` subclasses: `CreatureScript`, `SpellScript`, `InstanceMapScript`, `GameObjectScript`, `CommandScript`, etc.)
- **Server/** - `WorldSession` (per-player connection), `World` (global state), opcode definitions

### Scripting system

Scripts follow a registration pattern:
1. Define a class inheriting from `SpellScript`, `CreatureScript`, etc.
2. Implement an `AddSC_*()` function that calls `RegisterSpellScript(ClassName)` (or similar)
3. The `AddSC_*()` is declared and called from the regional `*_script_loader.cpp`
4. Script loaders per region: `spells_script_loader.cpp`, `eastern_kingdoms_script_loader.cpp`, `northrend_script_loader.cpp`, etc.
5. Spell script files are organized by class: `spell_dk.cpp`, `spell_mage.cpp`, `spell_generic.cpp`, etc.

### Three databases
- **acore_auth** - Accounts, realm list, bans (`data/sql/base/db_auth/`)
- **acore_characters** - Character data, inventories, progress (`data/sql/base/db_characters/`)
- **acore_world** - Game content: creatures, items, quests, spells, loot (`data/sql/base/db_world/`)

- SQL updates go in `data/sql/updates/pending_*` with separate subdirectories per database until pull request is merged. Pending SQL files are assigned random names.
- SQL updates go in `data/sql/updates/` with separate subdirectories per database after their pull request is merged.
- SQL files outside the `data/sql/updates/pending_*` folders should never be updated.

### Module system

External modules are loaded from the `modules/` directory. Each module is a subdirectory with its own `CMakeLists.txt`. Disable specific modules with `-DDISABLED_AC_MODULES="mod1;mod2"`. Module skeleton: https://github.com/azerothcore/skeleton-module/

### Dependencies

Bundled in `deps/`: boost, MySQL client, OpenSSL, zlib, recastnavigation (pathfinding), g3dlite (geometry), fmt, argon2, jemalloc, and others.

## VPS Access (Production Server)

SSH into the NostrumWoW production VPS using the readonly key:

```bash
ssh -i ~/.ssh/nostrum_readonly readonly@62.238.22.143 "<command>"
```

- **Key**: `~/.ssh/nostrum_readonly` (no passphrase)
- **User**: `readonly` (limited permissions)
- **Project root on VPS**: `/opt/nostrum`
- **Constraints**: no interactive sessions — only one-off commands via `terminal` tool. No PTY, no password prompts. Pipe output back for analysis.
- **Useful paths**: `conf/` (configs), `docker-compose.yml`, `.env`, `scripts/`, `sql/`

## Commit Message Format

Uses Conventional Commits:
```
Type(Scope/Subscope): Short description (max 50 chars)
```

- **Types**: feat, fix, refactor, style, docs, test, chore
- **Scopes**: Core (C++ changes), DB (SQL changes)
- **Examples**: `fix(Core/Spells): Fix damage calculation for Fireball`, `fix(DB/SAI): Missing spell to NPC Hogger`

## Code Style

- 4-space indentation for C++ (no tabs)
- 2-space indentation for JSON, YAML, shell scripts
- UTF-8 encoding, LF line endings
- Max 80 character line length
- No braces around single-line statements
- Use {} to parse variables into output instead of %u etc.
- CI enforces code style checks and compiles with `-Werror`

## PR Requirements

- AI tool usage must be disclosed in PRs
- In-game testing expected
- Changes to generic code require regression testing of related systems
