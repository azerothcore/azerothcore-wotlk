# Scripting hooks

Hook virtuals live in `src/server/game/Scripting/ScriptDefines/*.h`.

## Implementing a hook

Inherit the matching base (`PlayerScript`, `WorldScript`, …) and register it with `new MyClass();` (or its
`RegisterXxxScript` macro) inside `AddSC_<name>()`. Full hook list: https://www.azerothcore.org/wiki/hooks-script.
