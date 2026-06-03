# AGENTS.md

This is an AzerothCore 3.3.5a server repo.

Project goal:
Create a custom AzerothCore module inside `modules/mod-duo-roguelike`.

Rules:
- Prefer module hooks over editing core files.
- Do not modify client files.
- Do not add copyrighted client data.
- Do not add database credentials, secrets, or local paths.
- Keep changes clean and easy to review.
- If a hook signature is uncertain, inspect the local AzerothCore headers first.
- If a feature cannot be safely implemented, document it as a limitation instead of forcing a hack.

Build expectations:
- Keep code compatible with AzerothCore C++ style.
- Avoid unnecessary core edits.
- SQL should be idempotent where practical.
- Document install/test steps in the module README.

Useful paths:
- `modules/`
- `src/server/game/Scripting/ScriptMgr.h`
- `src/server/scripts/`
- `conf/`
- `data/sql/`
