package meta

import (
	"testing"
)

func TestGate_NoEnvRuns(t *testing.T) {
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

// TestBegin_SerialDoesNotParallel documents that Begin with serial must not call t.Parallel.
// We cannot assert Parallel state after the fact, but we can ensure Gate still runs and
// serial HasTag short-circuits (no panic / skip under default env).
func TestBegin_SerialDoesNotParallel(t *testing.T) {
	Begin(t, TestMeta{Tags: []string{"unit", "serial"}, Runtime: "short"})
	// If Begin incorrectly Parallel'd a serial test under a parent that already Parallel'd,
	// go test would panic. Reaching here means the serial branch returned after Gate.
}
