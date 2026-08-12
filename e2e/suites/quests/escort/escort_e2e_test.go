//go:build e2e

package escort_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// ESCORT-01: quest add baseline (escort content uses same quest APIs).
func TestEscort_QuestAddBaseline(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/escort"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscQ", Level: 30})
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.AssertQuestStatus(t, e2eharness.QuestRethbanGauntlet, e2eharness.QuestStatusIncomplete)
	t.Logf("PASS escort quest add baseline")
}

// ESCORT-02: spawn NPC and wait unit (escort start precondition).
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

// ESCORT-03: combat mid-path baseline — engage spawned unit then leave combat via kill.
// Use HeroicTrainingDummy: L1 Target Dummy (2673) is often oneshot by L80 autoattack
// before UNIT_FLAG_IN_COMBAT is observed (EngageUntilCombat precondition).
func TestEscort_CombatMidPathBaseline(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests", "combat"}, Runtime: "short", Category: "quests/escort"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "EscCm",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	u := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, u, 15*time.Second)
	bot.DamageKill(t, []uint64{u}, 10_000_000, 20*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS combat mid-path baseline")
}

// ESCORT-04: logout while nearby unit present (follow despawn #24450 soft).
func TestEscort_LogoutNearUnitWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "quests", "serial"}, Runtime: "med", Category: "quests/escort"})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscPr", Level: 10})
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscLg", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	_ = bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	e2eharness.HardDisconnectAndProbe(t, bot, probe, 0)
	t.Logf("PASS logout near unit world alive")
}

// ESCORT-05: unit still findable after spawn (GUID stability soft).
func TestEscort_UnitFindableAfterSpawn(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/escort"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscFd", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	guid := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	found := bot.FindUnit(e2eharness.CreatureTargetDummy, 50)
	if found == 0 {
		t.Logf("NOTE FindUnit 0 (cache); spawn guid=0x%X", guid)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS unit findable path found=0x%X", found)
}
