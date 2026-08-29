# e2e/local — scratch / debug tests (not committed)

Put **throwaway** live-stack tests here while debugging a core/script change.
Everything under this directory is **gitignored** except this README.

## When to use

| Put it here | Promote to |
|-------------|------------|
| One-off repro while fixing a bug | `suites/…` or `suites/issues/` once it should stay green |
| Agent exploratory scenario | Same — only keep if policy says e2e is warranted |
| Experiments with harness APIs | Drop or move when done |

Do **not** put permanent regressions here; CI and reviewers only look at `smoke/` and `suites/`.

## How to run

From `e2e/` with stack up and `E2E_*` set (see parent [README.md](../README.md)):

```bash
# all scratch packages
go test -tags=e2e ./local/... -count=1 -v -timeout 30m -parallel 1

# one file’s package (create local/foo/foo_e2e_test.go)
go test -tags=e2e ./local/foo -count=1 -v -timeout 15m -parallel 1
```

From the repository root: `make -C e2e e2e-local`. From `e2e/`: `make e2e-local`.

## Minimal skeleton

```go
//go:build e2e

package local_debug_test

import (
	"testing"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

func TestLocal_Scratch(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"local", "short"},
		Runtime:  "short",
		Category: "local",
	})
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Loc",
		Class:  e2eharness.ClassWarrior,
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// … drive and assert …
	t.Logf("PASS local scratch")
}
```

Authoring rules: AzerothGhost `e2e/LLM_GUIDE.md`. When to keep e2e long-term: `.agents/docs/e2e-policy.md`.
