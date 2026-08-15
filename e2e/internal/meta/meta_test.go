package meta

import (
	"testing"
)

func TestGate_NoEnvRuns(t *testing.T) {
	for _, key := range []string{"E2E_ISSUE", "E2E_RUNTIME", "E2E_SKIP_TAGS", "E2E_TAGS"} {
		t.Setenv(key, "")
	}
	// Should not skip when no filters set.
	Gate(t, TestMeta{Tags: []string{"smoke", "short"}, Runtime: "short"})
}

func TestSplitCSV(t *testing.T) {
	got := splitCSV(" smoke, Short , ")
	if len(got) != 2 || got[0] != "smoke" || got[1] != "short" {
		t.Fatalf("got %#v", got)
	}
}

func TestHasTag_Serial(t *testing.T) {
	m := TestMeta{Tags: []string{"med", "serial", "loot"}}
	if !HasTag(m, "serial") {
		t.Fatal("expected serial tag")
	}
	if HasTag(m, "smoke") {
		t.Fatal("unexpected smoke tag")
	}
	// Case-insensitive
	if !HasTag(m, "SERIAL") {
		t.Fatal("expected case-insensitive serial match")
	}
}

// TestBegin_DefaultSerial documents that Begin does not call t.Parallel by default.
func TestBegin_DefaultSerial(t *testing.T) {
	Begin(t, TestMeta{Tags: []string{"unit", "serial"}, Runtime: "short"})
	// Reaching here means Gate ran and default serial path did not panic.
}

// TestBegin_ParallelOptIn allows t.Parallel only when tagged parallel (not serial).
func TestBegin_ParallelOptIn(t *testing.T) {
	Begin(t, TestMeta{Tags: []string{"unit", "parallel"}, Runtime: "short"})
}
