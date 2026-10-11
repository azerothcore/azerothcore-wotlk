//go:build e2e

package lifecycle_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	questReportToKadrakBarrens    uint32 = 6541
	questReportToKadrakStonetalon uint32 = 6542
	creatureThork                 uint32 = 3429
	creatureDarnTalongrip         uint32 = 11821
	creatureKadrak                uint32 = 8582
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27417
func TestAC_27417_ReportToKadrakGating(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "quests", "issue", "serial"},
		Runtime:  "short",
		Issue:    27417,
		Category: "quests/lifecycle",
	})

	tests := []struct {
		name          string
		prefix        string
		firstQuest    uint32
		firstStarter  uint32
		secondQuest   uint32
		secondStarter uint32
	}{
		{
			"BarrensThenStonetalon", "KadrakA",
			questReportToKadrakBarrens, creatureThork,
			questReportToKadrakStonetalon, creatureDarnTalongrip,
		},
		{
			"StonetalonThenBarrens", "KadrakB",
			questReportToKadrakStonetalon, creatureDarnTalongrip,
			questReportToKadrakBarrens, creatureThork,
		},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
				Prefix: tc.prefix,
				Race:   e2eharness.RaceOrc,
				Class:  e2eharness.ClassWarrior,
				Level:  17,
			})
			bot.TeleportPad(t, e2eharness.PackagePad(t))

			firstStarterGUID := bot.Spawn(t, tc.firstStarter, 10*time.Second)
			secondStarterGUID := bot.Spawn(t, tc.secondStarter, 10*time.Second)
			kadrakGUID := bot.Spawn(t, creatureKadrak, 10*time.Second)
			bot.GM(t, ".gm off")
			bot.FlushWorld(t)

			acceptReportQuest(t, bot, firstStarterGUID, tc.firstQuest, true)
			acceptReportQuest(t, bot, secondStarterGUID, tc.secondQuest, false)
			rewardReportQuest(t, bot, kadrakGUID, tc.firstQuest)
			acceptReportQuest(t, bot, secondStarterGUID, tc.secondQuest, true)
			rewardReportQuest(t, bot, kadrakGUID, tc.secondQuest)
			t.Logf("PASS quests %d then %d completed sequentially", tc.firstQuest, tc.secondQuest)
		})
	}
}

func acceptReportQuest(
	t *testing.T,
	bot *e2eharness.ScenarioBot,
	starterGUID uint64,
	questID uint32,
	wantAccepted bool,
) {
	t.Helper()
	if err := bot.World.QuestgiverHello(starterGUID); err != nil {
		e2eharness.HarnessFailf(t, "questgiver hello quest=%d: %v", questID, err)
	}
	if err := bot.World.QuestgiverAcceptQuest(starterGUID, questID); err != nil {
		e2eharness.HarnessFailf(t, "accept quest=%d: %v", questID, err)
	}
	bot.FlushWorld(t)
	status, accepted := bot.QuestStatusAfterSave(t, questID)

	if !wantAccepted {
		if accepted {
			e2eharness.ConfirmedBugf(t, 27417, "quest %d accepted with sibling active (status=%s)",
				questID, e2eharness.QuestStatusName(status))
		}
		return
	}

	if !accepted {
		e2eharness.ConfirmedBugf(t, 27417, "quest %d was not accepted", questID)
	}
	if status != e2eharness.QuestStatusIncomplete && status != e2eharness.QuestStatusComplete {
		e2eharness.Assertf(t, "quest %d accepted with unexpected status=%s", questID,
			e2eharness.QuestStatusName(status))
	}
}

func rewardReportQuest(t *testing.T, bot *e2eharness.ScenarioBot, kadrakGUID uint64, questID uint32) {
	t.Helper()
	if err := bot.World.QuestgiverHello(kadrakGUID); err != nil {
		e2eharness.HarnessFailf(t, "Kadrak hello quest=%d: %v", questID, err)
	}
	if err := bot.World.QuestgiverCompleteQuest(kadrakGUID, questID); err != nil {
		e2eharness.HarnessFailf(t, "complete quest=%d: %v", questID, err)
	}
	bot.FlushWorld(t)
	if err := bot.World.QuestgiverChooseReward(kadrakGUID, questID, 0); err != nil {
		e2eharness.HarnessFailf(t, "choose reward quest=%d: %v", questID, err)
	}
	bot.FlushWorld(t)
	bot.Save(t)

	var rewarded int
	if err := bot.CharDB.QueryRow(
		"SELECT COUNT(*) FROM character_queststatus_rewarded WHERE guid = ? AND quest = ?",
		bot.GUID, questID,
	).Scan(&rewarded); err != nil {
		e2eharness.HarnessFailf(t, "query rewarded quest=%d: %v", questID, err)
	}
	if rewarded != 1 {
		e2eharness.ConfirmedBugf(t, 27417, "quest %d was not rewarded", questID)
	}
}
