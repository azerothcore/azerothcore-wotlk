// Package meta provides TestMeta gating for AC e2e category/tag filters.
package meta

import (
	"os"
	"strconv"
	"strings"
	"testing"
)

// TestMeta describes cross-cutting filters for a live e2e test.
// Call Gate at the start of every test (before expensive setup).
type TestMeta struct {
	// Tags are comma-free tokens, e.g. "smoke", "short", "multi_bot", "issue", "parallel".
	// Live e2e defaults to serial (no t.Parallel) so in-package tests do not thrash
	// one PackagePad. Opt in with tag "parallel" only when pad-safe.
	Tags []string
	// Issue is an optional AC GitHub issue number (0 = none).
	Issue int
	// Category is a path-like label, e.g. "spells/aura" (informational; directory is primary).
	Category string
	// Runtime: short | med | long
	Runtime string
}

// Gate skips the test when env filters exclude it.
// Prefer Begin(t, m) which also enforces parallel policy (serial by default).
//
// Env:
//
//	E2E_TAGS       — comma list; test must include ALL listed tags (AND)
//	E2E_SKIP_TAGS  — comma list; test skipped if it has ANY listed tag
//	E2E_ISSUE      — if set, only tests with matching Issue run
//	E2E_RUNTIME    — if set, only tests with matching Runtime run
func Gate(t *testing.T, m TestMeta) {
	t.Helper()

	if want := strings.TrimSpace(os.Getenv("E2E_ISSUE")); want != "" {
		n, err := strconv.Atoi(want)
		if err != nil {
			t.Fatalf("meta: invalid E2E_ISSUE=%q: %v", want, err)
		}
		if m.Issue != n {
			t.Skipf("meta: E2E_ISSUE=%d, test issue=%d", n, m.Issue)
		}
	}

	if want := strings.TrimSpace(os.Getenv("E2E_RUNTIME")); want != "" {
		if !strings.EqualFold(m.Runtime, want) {
			t.Skipf("meta: E2E_RUNTIME=%s, test runtime=%s", want, m.Runtime)
		}
	}

	have := tagSet(m.Tags)

	if raw := strings.TrimSpace(os.Getenv("E2E_SKIP_TAGS")); raw != "" {
		for _, tag := range splitCSV(raw) {
			if _, ok := have[tag]; ok {
				t.Skipf("meta: skip tag %q matched", tag)
			}
		}
	}

	if raw := strings.TrimSpace(os.Getenv("E2E_TAGS")); raw != "" {
		for _, tag := range splitCSV(raw) {
			if _, ok := have[tag]; !ok {
				t.Skipf("meta: required tag %q missing (have %v)", tag, m.Tags)
			}
		}
	}
}

// HasTag reports whether m.Tags contains tag (case-insensitive).
func HasTag(m TestMeta, tag string) bool {
	_, ok := tagSet(m.Tags)[strings.ToLower(strings.TrimSpace(tag))]
	return ok
}

// Begin runs Gate then optionally t.Parallel().
// Default is serial: PackagePad is sticky per package, so in-package parallel
// would co-locate bots on the same pad. Tag "parallel" to opt in (use only when
// tests do not share pad placement, or with go test -parallel 1 which no-ops Parallel).
// Tag "serial" is accepted as an explicit no-op for readability.
func Begin(t *testing.T, m TestMeta) {
	t.Helper()
	Gate(t, m)
	if HasTag(m, "parallel") && !HasTag(m, "serial") {
		t.Parallel()
	}
}

func tagSet(tags []string) map[string]struct{} {
	out := make(map[string]struct{}, len(tags))
	for _, t := range tags {
		t = strings.ToLower(strings.TrimSpace(t))
		if t != "" {
			out[t] = struct{}{}
		}
	}
	return out
}

func splitCSV(s string) []string {
	parts := strings.Split(s, ",")
	out := make([]string, 0, len(parts))
	for _, p := range parts {
		p = strings.ToLower(strings.TrimSpace(p))
		if p != "" {
			out = append(out, p)
		}
	}
	return out
}
