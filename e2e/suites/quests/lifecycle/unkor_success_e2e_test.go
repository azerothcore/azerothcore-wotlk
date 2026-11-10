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

	bot.GM(t, fmt.Sprintf(".quest add %d", questDontKillTheFatOne))
	bot.GM(t, fmt.Sprintf(".quest complete %d", questDontKillTheFatOne))
	bot.GM(t, fmt.Sprintf(".quest reward %d", questDontKillTheFatOne))
	if !waitQuestRewarded(t, bot, questDontKillTheFatOne, 10*time.Second) {
		e2eharness.Preconditionf(t, "quest %d was not rewarded by GM setup", questDontKillTheFatOne)
	}
	if _, inLog := bot.QuestStatus(t, questSuccess); inLog || waitQuestRewarded(t, bot, questSuccess, 0) {
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

	// .save is throttled to once per 20s on accounts without RBAC "save without delay";
	// the logout save in Relog always runs.
	bot.Relog(t)
	status, accepted := bot.QuestStatus(t, questSuccess)
	if !accepted {
		e2eharness.ConfirmedBugf(t, 26277, "Unkor did not submit, quest %d could not be accepted", questSuccess)
	}
	// Success! has no objectives, so it is complete as soon as it is accepted.
	if status != e2eharness.QuestStatusComplete {
		e2eharness.Assertf(t, "quest %d accepted with unexpected status=%s", questSuccess,
			e2eharness.QuestStatusName(status))
	}
	t.Logf("PASS Unkor submitted again and quest %d was accepted (status=%s)", questSuccess,
		e2eharness.QuestStatusName(status))
}

// Rewarding a quest saves the character asynchronously, so the row can land a moment later.
func waitQuestRewarded(t *testing.T, bot *e2eharness.ScenarioBot, questID uint32, timeout time.Duration) bool {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for {
		var rewarded int
		if err := bot.CharDB.QueryRow(
			"SELECT COUNT(*) FROM character_queststatus_rewarded WHERE guid = ? AND quest = ?",
			bot.GUID, questID,
		).Scan(&rewarded); err != nil {
			e2eharness.HarnessFailf(t, "query rewarded quest=%d: %v", questID, err)
		}
		if rewarded == 1 || !time.Now().Before(deadline) {
			return rewarded == 1
		}
		time.Sleep(200 * time.Millisecond)
	}
}
