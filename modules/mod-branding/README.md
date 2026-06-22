# mod-branding

An AzerothCore (WotLK 3.3.5a) module implementing the interconnected progression systems:
Branding, Brand Proficiency/Knowledge, Mastery, Invasions/Events, Contribution-based personal
loot, Zone/Event scaling, Allegiance, Account Vault, and the Economy loop.

The authoritative spec is [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md). The work backlog is in
[`docs/issues/INDEX.md`](docs/issues/INDEX.md).

## Architecture in one paragraph

The module is split into **pure cores** and **thin adapters** (ARCHITECTURE.md §2):

- `src/core/<system>/` — pure C++20 + STL game logic. **No AzerothCore headers.** Deterministic,
  dependency-injected (clock/RNG/config are passed in), and unit-tested in isolation with
  GoogleTest. This split is what makes the fast test loop below possible, and it is enforced in CI
  by the **core-purity** guard.
- `src/*.cpp` — adapter layer. One feature per translation unit, each pulling in the real
  AzerothCore headers and registering via `Addmod_brandingScripts()` in
  `src/mod_branding_loader.cpp`. Adapters are thin: they marshal game state into core types, call
  the core, and write results back. **No raw `Player*`/`Creature*` stored past a tick** — cache by
  `ObjectGuid`.

## 1. Fast standalone test loop (the TDD inner loop)

The cores build and test in **seconds** without configuring or compiling the worldserver. This is
the loop you use while writing logic (red → green → refactor). It builds only `src/core/` +
GoogleTest via `tests/standalone/CMakeLists.txt`.

```bash
# From the AzerothCore repo root:
cmake -S modules/mod-branding/tests/standalone -B /tmp/bt-branding
cmake --build /tmp/bt-branding -j"$(nproc)"

# Run directly...
/tmp/bt-branding/branding_core_tests
# ...or via ctest:
ctest --test-dir /tmp/bt-branding --output-on-failure
```

Current suite: **87 GoogleTests** across the pure cores (proficiency, discovery, scaling,
contribution, effects, catalyst, mastery, allegiance, economy, vault, …). The build uses
`-Wall -Wextra` and C++20 to mirror CI.

## 2. Full worldserver build (with the module)

This compiles the whole server with `mod-branding` linked in statically. It is **slow** (CMake +
a large C++ compile) and only needed to verify the link stage and to run in-game. Do not run it as
part of the inner loop.

```bash
# From the AzerothCore repo root:
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$HOME/azeroth-server" \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DSCRIPTS=static -DMODULES=static
make -j"$(nproc)"
make install
```

CMake auto-detects the module (it appears in the static-modules list) and installs
`mod_branding.conf` from `conf/mod_branding.conf.dist`. Set `Branding.Enable = 1` in the config to
turn it on, then smoke-test in-game with `.branding info` and an event loop.

> The full link is intentionally **not** run in the fast CI pipeline (it is a manual/nightly
> `full-link-build` job — see `.gitlab-ci.yml`). Per issue #15, the adapters are otherwise
> compile-verified (next section); only the multi-hour link is gated behind the manual job.

## 3. Adapter compile-verification (`-fsyntax-only`)

Between the fast core loop (no AzerothCore headers) and the full link (everything), there is a
cheap middle gate: compile each adapter translation unit against the **real** AzerothCore headers
with `g++ -fsyntax-only` — type-checking without producing objects or linking. This catches
missing includes, wrong types, and API drift in seconds.

```bash
# 1. Configure the full tree once to emit compile_commands.json (no build needed):
cd build
cmake .. -DSCRIPTS=static -DMODULES=static -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# 2. Syntax-check a touched adapter using its exact compile flags from the DB. Example:
ADAPTER=modules/mod-branding/src/ProficiencyMgr.cpp
FLAGS=$(python3 - "$ADAPTER" <<'PY'
import json, shlex, sys
tu = sys.argv[1]
for e in json.load(open("compile_commands.json")):
    if e["file"].endswith(tu) or tu in e["file"]:
        parts = shlex.split(e["command"])
        # drop the compiler and any -o/-c so we can add -fsyntax-only
        out = [p for p in parts[1:] if p not in ("-c",)]
        print(" ".join(out)); break
PY
)
g++ -fsyntax-only -std=c++20 $FLAGS "$ADAPTER" && echo "OK: $ADAPTER"
```

Verified this way: `BrandingConfig`, `ProficiencyMgr`, `ProficiencyScripts`, and the other adapter
TUs. (This verification already caught a real bug — `BrandingConfig.cpp` using `uint32` without
`Define.h`.)

## CI & hooks (issue #15)

- **`.gitlab-ci.yml`** — fast pipeline on every push: `core-tests` (build + run the standalone
  suite), `codestyle-cpp`, `codestyle-sql`, `core-purity`, and a `gitleaks` secret scan. The heavy
  full link is a separate manual/nightly `full-link-build` job. In the monorepo, wire it in without
  touching core build files by adding to the root `.gitlab-ci.yml`:

  ```yaml
  include:
    - local: 'modules/mod-branding/.gitlab-ci.yml'
  ```

- **`tools/core-purity.sh`** — the CORE-PURITY guard. Fails if any quoted `#include` under
  `src/core/` resolves to something that is not itself a `src/core/` header (i.e. an AzerothCore
  dependency). Run it directly: `bash modules/mod-branding/tools/core-purity.sh`.

- **`tools/pre-commit`** — pre-commit hook running gitleaks + the linters + core-purity + the fast
  core tests (org workflow). Install from the repo root:

  ```bash
  ln -sf ../../modules/mod-branding/tools/pre-commit .git/hooks/pre-commit
  ```

  `gitleaks` is optional (the hook warns and continues if it is not installed); install it from
  <https://github.com/gitleaks/gitleaks>. Bypass in an emergency with `git commit --no-verify`.

## Linting

```bash
# C++ (codestyle-cpp.py scans "<cwd>/src", so run it from the module root):
cd modules/mod-branding && python3 ../../apps/codestyle/codestyle-cpp.py

# SQL (compares the working tree to origin/master; run from the repo root):
python3 apps/codestyle/codestyle-sql.py
```

## Layout

```
modules/mod-branding/
├── .gitlab-ci.yml          # fast CI pipeline (+ manual full-link job)
├── README.md               # this file
├── conf/
│   └── mod_branding.conf.dist
├── data/
│   └── sql/db-world/       # module-owned world content (auto-imported by AC)
├── docs/
│   ├── ARCHITECTURE.md     # authoritative spec
│   └── issues/             # parallel-development backlog
├── src/
│   ├── core/<system>/      # pure C++20 logic, no AC headers, GoogleTested
│   ├── *.cpp / *.h         # thin adapters (one feature per TU)
│   └── mod_branding_loader.cpp
├── tests/
│   ├── <system>/           # GoogleTests per core
│   └── standalone/         # fast standalone CMake target
└── tools/
    ├── branding-craft/     # #27/#29 craft single-source-of-truth: emits world SQL + client DBC patch
    ├── invasion-authoring/ # Qt6 invasion editor
    ├── core-purity.sh      # CORE-PURITY guard
    └── pre-commit          # gitleaks + linters + tests hook
```
