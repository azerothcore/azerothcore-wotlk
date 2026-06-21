# #15 — Full worldserver build + link verification & CI (infra)

**Status:** open · **Deps:** none · **Parallel-safe:** yes · **Size:** M

## Context
Adapters are **compile-verified** (`g++ -fsyntax-only` against real headers) but the full
worldserver **link** has never been run — the one step not machine-proven. CI should also guard the
fast core tests + linters + core purity on every change.

## Scope
- One-off: full build with the module — `cmake .. -DSCRIPTS=static -DMODULES=static && make -j` +
  `make install`; fix any link-stage issues; boot a realm and smoke-test `.branding info` and an
  event loop.
- CI pipeline (GitLab CI per org workflow — `.gitlab-ci.yml`):
  - build the standalone core tests target + run `ctest` (fast, every push).
  - run `codestyle-cpp.py` + `codestyle-sql.py`.
  - core-purity guard: fail if `src/core/` includes any AzerothCore header.
  - (heavier, optional/nightly) full module build to catch link regressions.
- Hooks (org workflow): gitleaks + linters as pre-commit hooks.

## Acceptance
- Standard DoD. Green pipeline; documented build command in the module README; the link step passes.

## Touch points
`.gitlab-ci.yml`, git hooks, build scripts. No module source changes (except fixes the link surfaces).
Pure infra — fully parallel.
