# AGENTS.md

AzerothCore is a C++ MMORPG server emulator for World of Warcraft 3.3.5a (WotLK), built with CMake, backed by MySQL.

## Agent rules

- **Do not configure or build unless explicitly asked.** Builds are slow and rarely needed for code changes.
- **Never edit SQL files outside `data/sql/updates/pending_db_*/` unless explicitly requested.** `data/sql/base/`,
  `data/sql/archive/` and `data/sql/updates/db_*/` are immutable.
- Formatting follows `.editorconfig`: UTF-8, LF, max 120 cols, trailing newline, no trailing whitespace; 4-space indent
  for C++ (tabs forbidden), 2-space for JSON/YAML/sh/ts/js.
- **Do not write live-stack e2e tests unless the user explicitly asks**, nor `e2e/local/` scratch tests to validate a
  fix; don't mention missing coverage unless asked. Existing `e2e/` tests that break after a change may be updated.
  Before writing or changing any `e2e/` test, read `e2e/README.md` and `.agents/docs/e2e-policy.md`.
- Planning docs go in `.agents/plans/<task-slug>/` (gitignored), named `<task-slug>.<TYPE>.md` (`PLAN`, `REQUIREMENTS`,
  `ANALYSIS`, …).
- **Credit upstream authors.** Code, a mechanism, or data mirrored from another core (TrinityCore, cMaNGOS, …) is
  committed with `--author` naming the original commit's author (extra sources as `Co-authored-by`), even when rewritten
  against AC or confirmed by own sniffs; find them in the upstream file's commit history.

## Repository layout

- `src/common/` — networking (Asio), crypto, config, logging, shared utilities.
- `src/server/game/` — core gameplay; compiled into worldserver.
- `src/server/scripts/` — content scripts grouped by region (`EasternKingdoms/`, `Northrend/`, …), class
  (`Spells/spell_mage.cpp`, …), and domain (`Commands/`, `Pet/`, `OutdoorPvP/`, `World/`).
- `src/server/database/` — DB abstraction and schema updater.
- `src/server/shared/` — code shared by auth and world servers.
- `src/server/apps/{authserver,worldserver}/` — entry points (ports 3724 and 8085).
- `src/test/` — unit tests + mocks.
- `e2e/` — live-stack Go e2e (AzerothGhost harness); see `e2e/README.md`.
- `data/sql/` — `base/` (historical schema), `updates/db_*/` (merged), `updates/pending_db_*/` (in-flight), `custom/`
  (gitignored).
- `modules/` — external modules (see below).
- `apps/` — helper scripts; `apps/codestyle/` holds the lint scripts.
- `conf/dist/` — distributed config templates; `conf/*.conf` is gitignored.
- `deps/` — vendored third-party dependencies.

## Modules

External modules live in `modules/`, each a subdir with its own `CMakeLists.txt`. Disable with
`-DDISABLED_AC_MODULES="mod1;mod2"`. See `modules/how_to_make_a_module.md`.

## Persisting lessons

When a user correction reveals a lesson that generalizes, offer to persist it into these docs (placement per
`.agents/docs/README.md`): use the `/self-improve` skill if installed, otherwise suggest the user to install it and read
this page: https://www.azerothcore.org/wiki/agentic-engineering

## Read also

BEFORE starting the task, and again once you know what you will change, read every doc whose trigger matches, then
follow each doc's own "Read also" list:

- Writing or modifying any C++ (`src/**`, `modules/**`) → `.agents/docs/cpp-guidelines.md`
- Any change under `src/server/scripts/**` → `.agents/docs/cpp-scripts.md`
- Creating or modifying any SQL (`*.sql`) → `.agents/docs/sql-guidelines.md`
- Any change under `src/server/scripts/**` or `data/sql/updates/pending_db_world/**`, or any `smart_scripts` SQL →
  `.agents/docs/retail-evidence.md`
- Compiling, configuring or running tests, plan-given commands included; editing CMake files, `deps/**`,
  `.github/workflows/**`, `.github/actions/**` or `.github/SECURITY.md` → `.agents/docs/build.md`
- Editing any `*.conf.dist` → `.agents/docs/systems/config.md`
- Reviewing a changeset or PR, or opening or updating a PR → `.agents/docs/code-review.md`
- Self-reviewing, or opening or updating a PR → also `.agents/docs/self-review-rules.md`
- Capturing a lesson or adding/updating agent docs → `.agents/docs/README.md`
