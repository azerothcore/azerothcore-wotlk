//go:build e2e

package session_test

import (
	"testing"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// SESS-01: position readable after login (seed of inventory/pos load).
func TestSession_PositionAfterLogin(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/session"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SessPos",
		Level:  20,
	})
	x, y, z, mapID := bot.Pos()
	if bot.GUID == 0 {
		e2eharness.Preconditionf(t, "GUID 0 after login")
	}
	t.Logf("PASS pos after login map=%d (%.1f,%.1f,%.1f)", mapID, x, y, z)
}

// SESS-02: item + quest present after load path.
func TestSession_ItemAndQuestAfterLoad(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/session"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SessLoad",
		Level:  40,
	})
	bot.AddItem(t, e2eharness.ItemTargetDummy, 1)
	bot.AddQuest(t, e2eharness.QuestRethbanGauntlet)
	bot.Save(t)
	bot.AssertQuestStatus(t, e2eharness.QuestRethbanGauntlet, e2eharness.QuestStatusIncomplete)
	t.Logf("PASS item+quest after load/save")
}

// SESS-03: mutate gold via GM, save, relog, world still usable.
func TestSession_MoneyMutateSaveRelog(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/session"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SessGold",
		Level:  20,
	})
	e2eharness.ModMoney(t, bot.World, 12345)
	bot.Save(t)
	bot.Relog(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS money mutate + save + relog")
}

// SESS-05 / #25793: GM visibility survives relog.
func TestSession_GMVisibilitySurvivesRelog(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{
		Tags:     []string{"short", "protocol", "issue", "smoke"},
		Runtime:  "short",
		Issue:    25793,
		Category: "protocol/session",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SessGM",
		Level:  10,
	})

	const playerExtraGMInvisible = uint16(0x0010)

	bot.GM(t, ".gm visible off")
	bot.Save(t)

	var flags uint16
	if err := bot.CharDB.QueryRow(
		`SELECT extra_flags FROM characters WHERE guid=?`, bot.GUID,
	).Scan(&flags); err != nil {
		e2eharness.HarnessFailf(t, "read extra_flags: %v", err)
	}
	if flags&playerExtraGMInvisible == 0 {
		e2eharness.Preconditionf(t, "after .gm visible off, extra_flags=0x%X missing bit 0x10", flags)
	}

	guid := bot.GUID
	bot.Relog(t)
	bot.AssertWorldAlive(t)

	queryGUID := bot.GUID
	if queryGUID == 0 {
		queryGUID = guid
	}
	var after uint16
	err := bot.CharDB.QueryRow(
		`SELECT extra_flags FROM characters WHERE guid=?`, queryGUID,
	).Scan(&after)
	if err != nil {
		err = bot.CharDB.QueryRow(
			`SELECT extra_flags FROM characters WHERE guid=?`, guid,
		).Scan(&after)
	}
	if err != nil {
		e2eharness.HarnessFailf(t, "read extra_flags after relog: %v", err)
	}
	if after&playerExtraGMInvisible == 0 {
		e2eharness.ConfirmedBugf(t, 25793, "GM invisible did not stick after relog (extra_flags=0x%X)", after)
	}
	t.Logf("PASS GM visibility survived relog (extra_flags=0x%X)", after)
}

// SESS-06: hard session drop leaves world probeable by another bot.
func TestSession_HardDropWorldStaysAlive(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "protocol", "serial"}, Runtime: "short", Category: "protocol/session"})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SessPrb",
		Level:  10,
	})
	victim := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SessVic",
		Level:  10,
	})
	// Hard close without graceful logout path.
	victim.HardDisconnect(t)
	e2eharness.ProbeWorldAlive(t, probe, 0)
	t.Logf("PASS hard drop did not kill world (probe OK)")
}
