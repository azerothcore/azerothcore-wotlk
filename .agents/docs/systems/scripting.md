# Scripting hooks

Hook virtuals live in `src/server/game/Scripting/ScriptDefines/*.h`, their `ScriptMgr::On*`/`Can*` dispatchers in the
matching `*.cpp`, dispatch macros in `ScriptMgrMacros.h`.

## Implementing a hook

Inherit the matching base (`PlayerScript`, `WorldScript`, …) and register it with `new MyClass();` (or its
`RegisterXxxScript` macro) inside `AddSC_<name>()`. Full hook list: https://www.azerothcore.org/wiki/hooks-script.

## Adding a hook

- Reuse first: check whether existing hooks already cover the need (e.g. `WorldScript::OnUpdate`,
  `WorldScript::OnShutdown`, `OnPlayerBeforeLogout`, `ServerScript::CanPacketSend`). Add a hook only for a real gap.
- Name it generically and put it on the closest existing script type. Never create a script type for one feature or
  consumer (e.g. `PlayerbotScript`); a new generic type (e.g. `SessionScript`) only when no existing type fits.
- When it overlaps an existing hook, the PR states what it adds over that hook (timing, scope, parameters).
- On a type with a hook enum (`PLAYERHOOK_*`, `WORLDHOOK_*`, …; backs `ScriptRegistry<T>::EnabledHooks`), the hook gets
  its own enum entry and dispatches through `CALL_ENABLED_HOOKS` / `CALL_ENABLED_BOOLEAN_HOOKS`, never
  `ExecuteScript<>` / `IsValidBoolScript<>` or a hand-rolled `ReturnValidBool` fold, so a module's `enabledHooks` list
  can turn it off.
- A veto hook returns `bool` defaulting to `true` (core proceeds), is named like its type's existing veto hooks
  (`OnPlayerCan<Action>` on `PlayerScript`, `Can<Action>` elsewhere) and dispatches as
  `CALL_ENABLED_BOOLEAN_HOOKS(T, HOOK, !script-><Hook>(...))` like `OnPlayerCanRepopAtGraveyard`. Never a
  default-`false` "return true to take over" hook.

## Dispatch cost

- With no script registered a hook must cost nothing, above all per-packet and per-session-update hooks: a dispatcher
  does no per-call work (copies, built containers, computed arguments) before the empty-registry check (the macros, or
  an explicit `ScriptRegistry<T>::ScriptPointerList.empty()` early return).
- Pass arguments straight through; never copy an object the virtual takes by `const&` (the script can't mutate it, so
  the copy is pure per-call cost).
