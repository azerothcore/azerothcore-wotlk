# C++ guidelines

Run the linter before claiming a change is done: `python apps/codestyle/codestyle-cpp.py`

## Code style

Hard rules (CI builds with `-Werror` and runs `cppcheck`; the linter checks only some of these):

- Allman braces for multi-line bodies; trivial inline header accessors stay on one line as the header writes them
  (`bool IsX() const { return _x; }`), even when a review bot suggests expanding them. No braces around single-line
  statements. `if (x)`, never `if(x)` or `if ( x )`.
- `auto const&` (not `const auto&`); `Type const*` (not `const Type*`). `*`/`&` bind to the type: `Unit* target`,
  `WorldPacket& data`, never `Unit * target` / `WorldPacket &data`.
- `{}` format specifiers (`fmt`-style), not `%u`/`%s`.
- Typed helpers, not raw field or flag access:
  - `IsPlayer()`, `IsCreature()`, `IsItem()`, … not `GetTypeId() == TYPEID_*`.
  - `GetNpcFlags()`, `Has/Set/RemoveNpcFlag()`, `ReplaceAllNpcFlags()` not `*Flag(UNIT_NPC_FLAGS, …)`.
  - `Has/Set/RemoveGameObjectFlag()`, `ReplaceAllGameObjectFlags()` not `HasFlag`/`SetFlag`/`RemoveFlag`/
    `SetUInt32Value(GAMEOBJECT_FLAGS, …)`.
  - `SetEmoteState()` / `ClearEmoteState()` not `SetUInt32Value(UNIT_NPC_EMOTESTATE, …)`.
  - `IsRefundable()`, `IsBOPTradable()`, `IsWrapped()` not `HasFlag(ITEM_FIELD_FLAGS, …)`.
  - `HasFlag(ItemFlag)` / `HasFlag2(ItemFlag2)` / `HasFlagCu(ItemFlagsCustom)` not bitwise `Flags & ITEM_FLAG…`.
  - `ObjectGuid::ToString().c_str()` not `ObjectGuid::GetCounter()`.

Reviewer conventions, not linted; apply them to new or changed code only, never reformat untouched code:

- After a braceless single-statement `if`/`else` body (early-return guards and wrapped conditions included), leave an
  empty line before the next statement in the same block, even `return;`/`break;`. None before `else`/`else if` or a
  closing brace.
- Include order, across the whole include block (untouched lines too) of every added or touched `.cpp` and `.h`: a
  `.cpp`'s own header first (`"Foo.h"` for `Foo.cpp`), then quoted project headers alphabetically, then library
  headers (`<...>`) alphabetically.
- Data members per the [code standards](https://www.azerothcore.org/wiki/cpp-code-standards): public/protected
  `PascalCase` (`CachedScriptId`), private `_camelCase` (`_accountId`), never `m_`. This covers members of declarations
  you move or re-declare (e.g. a class moved from a `.cpp` into a header); don't rename untouched `m_` members.
- Wrapped conditions align to the first character after the opening paren. Wrapped argument/parameter lists follow
  the surrounding continuation style: paren-aligned, or indented from the statement; never indented less than the
  statement. When a rename or move changes the text before an opening paren (dropped `Class<T>::`, renamed function),
  realign every paren-aligned continuation line it owns, in calls and signatures.
- New files under `src/` start with the AzerothCore license header most siblings in the same directory carry, copied
  verbatim (mostly GPLv2+, AGPL in a few subsystems such as `TC9Sidecar/`), not an IDE "Created by" banner. Vendored
  third-party code keeps its original header.

## Comments

- Explain the non-obvious why, briefly. Crash signatures, stack details, dates and fix history go in the commit message
  or PR description.
- Keep comments (SQL too) true to the code: update or delete any your change makes untrue (e.g. a "MUST be valid" note
  above a new null guard), and check each claim a comment makes (what a check filters, where an object spawns, why a
  state is safe) against the code.

## Project helpers

- **Logging**: `LOG_INFO("category.sub", "msg with {}", arg)` (also `LOG_WARN`/`ERROR`/`DEBUG`/`TRACE`), macro in
  `src/common/Logging/Log.h`. Categories are hierarchical, dot-separated (`server.loading`, `entities.player`,
  `sql.dev`). No `printf`-style logging, `sLog->out*` or `TC_LOG_*`.
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
- `NearTeleportTo`/`TeleportTo`, aura removal or `Dismount`, and anything reaching AI or script hooks
  (`AtTargetAttacked` → `JustEnteredCombat`) can delete `this` (e.g. a `Vehicle` kit freed through
  `RemoveVehicleKit`) or a unit you hold (despawn, evade). Copy what you need (GUIDs) before the call; afterwards bail
  out or re-resolve by GUID, never touch members or cached pointers. Call a script hook you add ahead of an action
  immediately before that action, so nothing runs on stale state in between.

## Before submitting

- Strip leftovers from the code you add, ported code included: investigation `LOG_DEBUG`/`LOG_TRACE`, commented-out
  blocks, stale merge/TODO notes, unreachable code (a `return` after `[[noreturn]]` `ABORT()`, a branch your own
  earlier guard in the function rules out), unused `#include`s, and new headers, constants, enum values or prepared
  statements nothing in core uses, unless a named module needs one it cannot define itself; name that module in the
  PR. Keep existing defensive checks in code the change doesn't touch.
- Don't duplicate in added code: extend an existing loop or block instead of a parallel one; put a block you'd repeat
  into one helper; don't re-check what the called helper already checks; reuse existing constants and accessors
  (`M_PI`, `GetPosition(x, y, z)`) instead of local copies or spelled-out x/y/z; within a call, pass an
  already-resolved object instead of looking its GUID up again via `ObjectAccessor`. Leave pre-existing duplication
  alone unless the task is about it.

## Read also

- C++ under `src/` outside `src/server/scripts/` and `src/test/` → `systems/core-changes.md`
- Adding/changing a declaration in a header under `src/` outside `src/server/scripts/` (signature, accessor, getter,
  virtual, nested type, constant/`#define`, `#include`); code, strings, comments or compile flags added for or naming
  a module (`MOD_*`); `src/server/game/TC9Sidecar/**`; a `sScriptMgr` hook's return value used as an index, count or id
  → `systems/core-api.md`
- `src/server/game/Scripting/**`, a class deriving a hook script type from `ScriptDefines/*.h` (`PlayerScript`,
  `WorldScript`, `ServerScript`, …), or adding a script hook or a `sScriptMgr->On*`/`Can*` call →
  `systems/scripting.md`
- `WorldConfig.*`, a `CONFIG_*`/`RATE_*` value, adding, moving or editing a `sConfigMgr->GetOption` call, or startup
  checks in `src/server/apps/**/Main.cpp` → `systems/config.md`
- `src/server/game/Spells/**` (incl. `SpellInfoCorrections.cpp`), or a `SpellScript`/`AuraScript` under `modules/` →
  `systems/spells.md`
- `src/server/game/AI/**` outside `SmartScripts/`, or an AI class (`ScriptedAI`, `BossAI`, `CreatureAI`, `GameObjectAI`,
  …) under `modules/` → `systems/creature-ai.md`
- `src/server/game/AI/SmartScripts/**` → `systems/smartai.md`
- An `InstanceScript`/`InstanceMapScript` under `modules/` → `systems/instance-scripts.md`
