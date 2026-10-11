//go:build e2e

package lifecycle_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// QLIFE-03 / #26549: STAY_ALIVE quest fails on death.
func TestAC_26549_StayAliveFailsOnDeath(t *testing.T) {
	// serial: DieMust + CharDB save race under parallel pad thrash.
	meta.Begin(t, meta.TestMeta{
		// smoke: STAY_ALIVE fail-on-death is in core (#26989 / #26549).
		Tags:     []string{"short", "quests", "issue", "smoke", "serial"},
		Runtime:  "short",
		Issue:    26549,
		Category: "quests/lifecycle",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "QAlive",
		Class:  e2eharness.ClassWarrior,
		Level:  30,
	})
	// AddQuest waits for INCOMPLETE in CharDB (async .quest add under thrash).
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.Teleport(t, -9222.58, -2147.87, 63.814, e2eharness.MapEasternKingdoms)

	bot.DieAndRepop(t)
	// CharDB quest status is async after .save — always re-save and re-read.
	st, ok := bot.QuestStatusAfterSave(t, e2eharness.QuestRethbanGauntlet)
	if !ok {
		e2eharness.HarnessFailf(t, "quest row missing after death")
	}
	if st != e2eharness.QuestStatusFailed {
		// CharDB lag after FailQuest — poll, do not fixed-sleep once.
		deadline := time.Now().Add(5 * time.Second)
		for time.Now().Before(deadline) && st != e2eharness.QuestStatusFailed {
			time.Sleep(100 * time.Millisecond)
			st, ok = bot.QuestStatusAfterSave(t, e2eharness.QuestRethbanGauntlet)
			if !ok {
				e2eharness.HarnessFailf(t, "quest row missing after death (retry)")
			}
		}
	}
	if st != e2eharness.QuestStatusFailed {
		// ConfirmedBugf(t, 26549, ...) — core FailQuestsOnDeath is on this branch; hard-fail.
		e2eharness.Assertf(t, "quest status=%d (%s) after death+repop, want FAILED(5)",
			st, e2eharness.QuestStatusName(st))
	}
	t.Logf("PASS quest failed on death (status=%s)", e2eharness.QuestStatusName(st))
}

// QLIFE-01: AddQuest → incomplete status after save.
func TestQuest_AddQuestIncomplete(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/lifecycle"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "QAdd",
		Level:  30,
	})
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.AssertQuestStatus(t, e2eharness.QuestRethbanGauntlet, e2eharness.QuestStatusIncomplete)
	t.Logf("PASS AddQuest → incomplete")
}

// QLIFE-02: quest status survives save round-trip.
func TestQuest_StatusSurvivesSave(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/lifecycle"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "QSave",
		Level:  30,
	})
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	st, ok := bot.QuestStatusAfterSave(t, e2eharness.QuestRethbanGauntlet)
	if !ok {
		e2eharness.HarnessFailf(t, "quest missing after save")
	}
	if st != e2eharness.QuestStatusIncomplete {
		e2eharness.Assertf(t, "want incomplete after save, got %d", st)
	}
	t.Logf("PASS quest status survives save")
}

// QLIFE-04: quest status after relog remains Incomplete (not row-presence only).
func TestQuest_StatusSurvivesRelog(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests", "protocol"}, Runtime: "short", Category: "quests/lifecycle"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "QRelog",
		Level:  30,
	})
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.AssertQuestStatus(t, e2eharness.QuestRethbanGauntlet, e2eharness.QuestStatusIncomplete)
	bot.Save(t)
	bot.Relog(t)
	bot.AssertWorldAlive(t)
	// Product oracle: status byte must still be Incomplete after relog.
	bot.AssertQuestStatus(t, e2eharness.QuestRethbanGauntlet, e2eharness.QuestStatusIncomplete)
	t.Logf("PASS quest incomplete after relog")
}

// QLIFE-05: second AddQuest of same ID is safe (no crash).
func TestQuest_ReAddSameQuestNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/lifecycle"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "QDup",
		Level:  30,
	})
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.AssertWorldAlive(t)
	bot.AssertQuestStatus(t, e2eharness.QuestRethbanGauntlet, e2eharness.QuestStatusIncomplete)
	t.Logf("PASS re-add same quest no crash")
}
