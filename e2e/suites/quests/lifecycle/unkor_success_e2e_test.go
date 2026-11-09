//go:build e2e

package lifecycle_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	questDontKillTheFatOne uint32 = 9889
	questSuccess           uint32 = 9890
	creatureUnkor          uint32 = 18262
)

// A player who turned in Don't Kill the Fat One but let Unkor turn hostile again before
// accepting Success! must be able to beat him into submission once more, since he is
// the only starter of Success!.
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26277
func TestAC_26277_UnkorSubmitsForSuccess(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "quests", "issue", "serial"},
		Runtime:  "short",
		Issue:    26277,
		Category: "quests/lifecycle",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Unkor",
		Race:   e2eharness.RaceOrc,
		Class:  e2eharness.ClassWarrior,
		Level:  70,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))

	bot.AddQuest(t, questDontKillTheFatOne)
	bot.GM(t, fmt.Sprintf(".quest complete %d", questDontKillTheFatOne))
	bot.GM(t, fmt.Sprintf(".quest reward %d", questDontKillTheFatOne))
	bot.Save(t)
	if !questRewarded(t, bot, questDontKillTheFatOne) {
		e2eharness.Preconditionf(t, "quest %d was not rewarded by GM setup", questDontKillTheFatOne)
	}
	if _, inLog := bot.QuestStatus(t, questSuccess); inLog || questRewarded(t, bot, questSuccess) {
		e2eharness.Preconditionf(t, "quest %d already taken before Unkor submits", questSuccess)
	}

	unkorGUID := bot.Spawn(t, creatureUnkor, 10*time.Second)
	bot.CombatReady(t)
	bot.DamageToFraction(t, unkorGUID, 0.25, 20*time.Second)
	bot.FlushWorld(t)

	if hp, maxHP := bot.UnitHP(unkorGUID); hp == 0 {
		e2eharness.ConfirmedBugf(t, 26277, "Unkor died instead of submitting (hp=0/%d)", maxHP)
	}

	if err := bot.World.QuestgiverHello(unkorGUID); err != nil {
		e2eharness.HarnessFailf(t, "Unkor hello: %v", err)
	}
	if err := bot.World.QuestgiverAcceptQuest(unkorGUID, questSuccess); err != nil {
		e2eharness.HarnessFailf(t, "accept quest=%d: %v", questSuccess, err)
	}
	bot.FlushWorld(t)

	status, accepted := bot.QuestStatusAfterSave(t, questSuccess)
	if !accepted {
		e2eharness.ConfirmedBugf(t, 26277, "Unkor did not submit, quest %d could not be accepted", questSuccess)
	}
	if status != e2eharness.QuestStatusIncomplete {
		e2eharness.Assertf(t, "quest %d accepted with unexpected status=%s", questSuccess,
			e2eharness.QuestStatusName(status))
	}
	t.Logf("PASS Unkor submitted again and quest %d was accepted (status=%s)", questSuccess,
		e2eharness.QuestStatusName(status))
}

func questRewarded(t *testing.T, bot *e2eharness.ScenarioBot, questID uint32) bool {
	t.Helper()
	var rewarded int
	if err := bot.CharDB.QueryRow(
		"SELECT COUNT(*) FROM character_queststatus_rewarded WHERE guid = ? AND quest = ?",
		bot.GUID, questID,
	).Scan(&rewarded); err != nil {
		e2eharness.HarnessFailf(t, "query rewarded quest=%d: %v", questID, err)
	}
	return rewarded == 1
}
