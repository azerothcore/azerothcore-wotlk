//go:build e2e

package escort_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// TODO(e2e): replace this package with a real escort quest fixture (start → follow →
// complete/fail oracle). Until then only keep spawn/cache helpers that have hard asserts.

// ESCORT-01: spawn NPC and wait unit (precondition for future escort start).
func TestEscort_SpawnAndWaitUnit(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests", "ai"}, Runtime: "short", Category: "quests/escort"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscSp", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	guid := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	if guid == 0 {
		e2eharness.Preconditionf(t, "spawn returned 0")
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS spawn/wait unit guid=0x%X", guid)
}

// ESCORT-02: unit still findable after spawn (hard GUID/cache oracle).
func TestEscort_UnitFindableAfterSpawn(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/escort"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscFd", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	guid := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	found := bot.FindUnit(e2eharness.CreatureTargetDummy, 50)
	if found == 0 {
		e2eharness.Assertf(t, "FindUnit 0 after spawn guid=0x%X", guid)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS unit findable found=0x%X spawn=0x%X", found, guid)
}

// TODO(e2e): re-enable when a real escort logout/despawn oracle exists (#24450 class).
/*
func TestEscort_LogoutNearUnitWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "quests", "serial"}, Runtime: "med", Category: "quests/escort"})
	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscPr", Level: 10})
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscLg", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	_ = bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	e2eharness.HardDisconnectAndProbe(t, bot, probe, 0)
	t.Logf("PASS logout near unit world alive")
}
*/
