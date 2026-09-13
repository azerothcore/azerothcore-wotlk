//go:build e2e

package smoke_test

import (
	"math"
	"testing"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// SMOKE-07 first: fresh-account create (run early — late runs saw flaky auth EOF
// after several login/relog cycles against a cold native stack).
func TestSmoke_FirstTimeCharacterCreate(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"smoke", "short", "protocol", "serial"}, Runtime: "short", Category: "smoke"})

	// Prefix must stay short: auth rejects account names >17 chars (closes with EOF).
	// MakeBotIdents builds Prefix + 2-digit index + 8 hex = Prefix+10; keep Prefix <= 7.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SmCre",
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassWarrior,
		Level:  1,
	})
	if bot.GUID == 0 {
		e2eharness.Preconditionf(t, "character create/login produced GUID 0")
	}
	if !e2eharness.SessionAlive(bot.Session) {
		e2eharness.HarnessFailf(t, "session dead after character create")
	}
	t.Logf("PASS first-time create guid=%d name=%s", bot.GUID, bot.Name)
}

// SMOKE-01: valid login → enter world
func TestSmoke_ValidLoginEnterWorld(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"smoke", "short", "protocol", "serial"}, Runtime: "short", Category: "smoke"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SmLogin",
		Level:  10,
	})
	if !e2eharness.SessionAlive(bot.Session) {
		e2eharness.HarnessFailf(t, "session not alive after NewSolo")
	}
	if bot.GUID == 0 {
		e2eharness.Preconditionf(t, "player GUID is 0 after enter world")
	}
	x, y, z, mapID := bot.Pos()
	if math.IsNaN(float64(x)) || math.IsNaN(float64(y)) || math.IsNaN(float64(z)) {
		e2eharness.HarnessFailf(t, "invalid position after login")
	}
	t.Logf("PASS login enter world guid=%d map=%d pos=(%.1f,%.1f,%.1f)", bot.GUID, mapID, x, y, z)
}

// SMOKE-02: probe world alive after login
func TestSmoke_ProbeWorldAliveAfterLogin(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"smoke", "short", "serial"}, Runtime: "short", Category: "smoke"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SmProbe",
		Level:  10,
	})
	bot.AssertWorldAlive(t)
	bot.GM(t, ".gm on")
	t.Logf("PASS world alive after login")
}

// SMOKE-03: teleport pad success
func TestSmoke_TeleportPadSuccess(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"smoke", "short", "protocol", "serial"}, Runtime: "short", Category: "smoke"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SmTele",
		Level:  80,
	})
	pad := e2eharness.PackagePad(t)
	bot.TeleportPad(t, pad)
	x, y, z, mapID := bot.Pos()
	if mapID != pad.Map {
		e2eharness.Preconditionf(t, "expected pad map %d after tele, got %d", pad.Map, mapID)
	}
	if math.IsNaN(float64(x)) || math.IsNaN(float64(y)) || math.IsNaN(float64(z)) {
		e2eharness.HarnessFailf(t, "invalid pos after pad tele")
	}
	if !bot.Alive() {
		e2eharness.HarnessFailf(t, "session/player not alive after pad tele")
	}
	t.Logf("PASS pad tele map=%d pos=(%.1f,%.1f,%.1f)", mapID, x, y, z)
}

// SMOKE-05: relog same character, world still alive
func TestSmoke_RelogSameCharacterWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"smoke", "short", "protocol", "serial"}, Runtime: "short", Category: "smoke"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "SmRelog",
		Level:  20,
	})
	guidBefore := bot.GUID
	bot.Save(t)
	bot.Relog(t)
	// Relog already WaitForLogin; AssertWorldAlive probes the fresh session.
	bot.AssertWorldAlive(t)
	if bot.GUID != guidBefore {
		e2eharness.HarnessFailf(t, "expected GUID %d after relog, got %d", guidBefore, bot.GUID)
	}
	t.Logf("PASS relog world alive guid=%d", bot.GUID)
}
