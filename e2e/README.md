# AzerothCore live-stack e2e

Protocol-level regression tests for this repository. They import
[`github.com/walkline/AzerothGhost/e2e/e2eharness`](https://github.com/walkline/AzerothGhost)
and run against a live authserver + worldserver + MySQL.

## Layout

| Path | Role |
|------|------|
| `smoke/` | Fast connectivity / login guards |
| `suites/<category>/…` | Hierarchical scenarios (directory = category) |
| `internal/meta` | `TestMeta` + env tag filters |
| `internal/fixtures` | Shared pads / IDs |

Design docs: `.agents/plans/e2e-army/` (layout, policy, taxonomy, specs).

## Run

```bash
cd e2e
# optional: set E2E_* from .env.example
go test -tags=e2e ./smoke -count=1 -v -timeout 15m -parallel 2
make e2e-smoke
make e2e-category C=quests
make e2e-sub C=spells/aura
E2E_TAGS=smoke go test -tags=e2e ./suites/... -count=1 -v -timeout 20m -parallel 2
```

## Policy

See `.agents/plans/e2e-army/phase0/A2_E2E_POLICY.md` (to be promoted to
`.agents/docs/e2e-policy.md`). Harness authoring: AzerothGhost `e2e/LLM_GUIDE.md`.
