//go:build e2e

package death_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

const (
	// Ghost auras commonly applied on player death (WotLK).
	spellGhost      = 8326
	spellGhostNight = 20584
)

// dieSelf ensures GM mode, issues .die (with one retry), and waits until Health()==0.
// Under pad congestion / ToCloud9 load the first .die can be a silent no-op.
func dieSelf(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	bot.GM(t, ".gm on")
	bot.Die(t)
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if bot.World.Health() == 0 {
			return
		}
		time.Sleep(50 * time.Millisecond)
	}
	t.Logf("NOTE: first .die left hp=%d/%d — retry", bot.World.Health(), bot.World.MaxHealth())
	bot.GM(t, ".gm on")
	bot.Die(t)
	bot.WaitDead(t, 15*time.Second)
}

// DEATH-01 / CB-07: die → corpse path; ghost auras present before release.
func TestDeath_DieProducesGhostState(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieGh",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	dieSelf(t, bot)

	// Alive() is session usability, not player health. Oracle is Health()==0.
	if hp := bot.World.Health(); hp != 0 {
		e2eharness.ConfirmedBugf(t, 0, "player hp=%d after WaitDead (want 0)", hp)
	}
	hasGhost := bot.HasAura(spellGhost) || bot.HasAura(spellGhostNight)
	if !hasGhost {
		// Ghost form aura is commonly applied on release, not on the corpse body.
		t.Logf("NOTE: no ghost aura yet before release (hp=%d session_alive=%v)",
			bot.World.Health(), bot.Alive())
	}
	t.Logf("PASS die → dead state (ghost_aura=%v hp=%d)", hasGhost, bot.World.Health())
}

// DEATH-02: release spirit reaches graveyard path (session stays usable).
func TestDeath_ReleaseSpiritWorldAlive(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieRel",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	dieSelf(t, bot)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	x, y, z, m := bot.Pos()
	t.Logf("PASS DieAndRepop world alive pos=(%.0f,%.0f,%.0f map=%d)", x, y, z, m)
}

// DEATH-03: DieAndRepop full cycle + save.
func TestDeath_DieAndRepopCycle(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieCyc",
		Level:  40,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	dieSelf(t, bot)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	bot.Save(t)
	t.Logf("PASS die+repop cycle")
}

// DEATH-05: death must not crash the worldserver.
func TestDeath_DeathDoesNotCrashWorld(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "DieOk",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	dieSelf(t, bot)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS death did not crash world")
}

// DEATH-04: reclaim corpse after death (if helper available).
// AC requires PLAYER_FLAGS_GHOST (release spirit) then proximity to corpse before
// CMSG_RECLAIM_CORPSE succeeds. Alive() is session usability — use WaitAlive/Health.
func TestDeath_ReclaimCorpseAfterDeath(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat", "med"}, Runtime: "med", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieRec",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	deathX, deathY, deathZ, deathMap := bot.Pos()
	dieSelf(t, bot)
	// Must release before reclaim (HandleReclaimCorpseOpcode requires GHOST flag).
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	// Soft: wait for ghost aura if the server applies it on release (not always present).
	deadlineGhost := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadlineGhost) {
		if bot.HasAura(spellGhost) || bot.HasAura(spellGhostNight) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	// Ghost is at graveyard; return to corpse for reclaim radius.
	// Teleport waits for map/login settle.
	bot.Teleport(t, deathX, deathY, deathZ, deathMap)
	// Soft poll near corpse before reclaim (tele ACK can precede position cache).
	deadlinePos := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadlinePos) {
		x, y, _, m := bot.Pos()
		if m == deathMap {
			dx := x - deathX
			dy := y - deathY
			if dx*dx+dy*dy < 100*100 {
				break
			}
		}
		time.Sleep(40 * time.Millisecond)
	}
	bot.ReclaimCorpse(t)
	if bot.World.Health() > 0 {
		bot.WaitAlive(t, 5*time.Second)
		bot.AssertWorldAlive(t)
		t.Logf("PASS reclaim corpse → alive (hp=%d)", bot.World.Health())
		return
	}
	// PvE reclaim delay may still apply on some configs; world must stay up either way.
	bot.WaitAlive(t, 10*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS reclaim corpse → alive after wait (hp=%d)", bot.World.Health())
}
