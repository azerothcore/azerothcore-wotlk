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
