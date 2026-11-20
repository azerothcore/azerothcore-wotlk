//go:build e2e

package obtain_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	itemWaterBucket     = 32971 // conjured; casts spellHasWaterBucket on obtain
	spellHasWaterBucket = 42336
	itemHauntedMemento  = 40110 // not conjured; casts spellHaunted on obtain
	spellHaunted        = 53768
)

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/28469
//
// A conjured item is deleted while the inventory loads once its owner has been offline for more
// than 15 minutes. That deletion bypasses the item removal path that strips the item's obtain
// aura, so the saved aura used to come back on every login with no item left to remove it.
//
// The Haunted Memento is the control: it is not conjured, so it survives the same login and its
// obtain aura must stay. Its aura arriving also proves the login aura snapshot has reached the
// client before the Water Bucket aura is asserted absent.
//
// Green on a fixed core; "AC#28469 CONFIRMED BUG" on an unfixed one.
func TestAC_28469_ObtainAuraRemovedWithConjuredItemOnLogin(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "items", "issue"},
		Runtime:  "short",
		Category: "items/obtain",
		Issue:    28469,
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "ObtAura",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))

	bot.AddItemWait(t, itemWaterBucket, 1)
	bot.AddItemWait(t, itemHauntedMemento, 1)
	if !waitAura(bot, spellHasWaterBucket, 5*time.Second) || !waitAura(bot, spellHaunted, 5*time.Second) {
		e2eharness.Preconditionf(t, "obtain auras %d and %d not both applied by their items (auras=%v)",
			spellHasWaterBucket, spellHaunted, bot.World.SelfAuras())
	}

	if err := bot.World.SendLogout(); err != nil {
		e2eharness.HarnessFailf(t, "logout: %v", err)
	}
	if err := bot.World.WaitForLogout(30 * time.Second); err != nil {
		t.Logf("logout wait: %v (continuing)", err)
	}
	bot.Close()
	backdateLogout(t, bot)
	bot.Relog(t)

	if !waitAura(bot, spellHaunted, 10*time.Second) {
		e2eharness.Assertf(t, "obtain aura %d of the still held item %d is gone after login (auras=%v)",
			spellHaunted, itemHauntedMemento, bot.World.SelfAuras())
	}
	if n := waitInventoryCount(t, bot, itemWaterBucket, 0); n != 0 {
		e2eharness.Preconditionf(t, "conjured item %d survived the login (count=%d): logout_time backdate did not take",
			itemWaterBucket, n)
	}
	if bot.HasAura(spellHasWaterBucket) {
		e2eharness.ConfirmedBugf(t, 28469, "obtain aura %d outlived its conjured item %d deleted on login (auras=%v)",
			spellHasWaterBucket, itemWaterBucket, bot.World.SelfAuras())
	}
	t.Logf("PASS obtain aura %d removed with conjured item %d on login; aura %d kept with held item %d",
		spellHasWaterBucket, itemWaterBucket, spellHaunted, itemHauntedMemento)
}

func waitAura(bot *e2eharness.ScenarioBot, spellID uint32, timeout time.Duration) bool {
	for deadline := time.Now().Add(timeout); time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
		if bot.HasAura(spellID) {
			return true
		}
	}
	return bot.HasAura(spellID)
}

// backdateLogout moves the offline character's logout an hour into the past, well beyond the
// 15 minute lifetime of conjured items. The logout save runs asynchronously and writes
// logout_time itself, so it has to land first: the account is flagged offline only after that
// save was queued, and the Water Bucket aura row is written by it.
func backdateLogout(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	var (
		online, auraRows int
		lastErr          error
	)
	for deadline := time.Now().Add(15 * time.Second); time.Now().Before(deadline); time.Sleep(100 * time.Millisecond) {
		lastErr = bot.CharDB.QueryRow(`
			SELECT c.online, (SELECT COUNT(*) FROM character_aura a WHERE a.guid = c.guid AND a.spell = ?)
			FROM characters c WHERE c.guid = ?`, spellHasWaterBucket, bot.GUID).Scan(&online, &auraRows)
		if lastErr == nil && online == 0 && auraRows > 0 {
			break
		}
	}
	if lastErr != nil || online != 0 || auraRows == 0 {
		e2eharness.Preconditionf(t, "logout save not visible in CharDB (online=%d, aura %d rows=%d, err=%v)",
			online, spellHasWaterBucket, auraRows, lastErr)
	}
	if _, err := bot.CharDB.Exec(`UPDATE characters SET logout_time = logout_time - 3600 WHERE guid = ?`, bot.GUID); err != nil {
		e2eharness.HarnessFailf(t, "backdate logout_time: %v", err)
	}
}

// waitInventoryCount polls CharDB until the character holds want of entry; the deletion of an
// item dropped while the inventory loads is committed asynchronously.
func waitInventoryCount(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32, want int) int {
	t.Helper()
	got := -1
	for deadline := time.Now().Add(5 * time.Second); time.Now().Before(deadline); time.Sleep(100 * time.Millisecond) {
		if got = bot.InventoryCountNoSave(t, entry); got == want {
			break
		}
	}
	return got
}
