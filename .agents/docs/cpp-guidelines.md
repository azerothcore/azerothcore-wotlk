# C++ guidelines

Run the linter before claiming a change is done: `python apps/codestyle/codestyle-cpp.py`

## Code style

Hard rules (also enforced by CI with `-Werror`, plus `cppcheck`):

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
