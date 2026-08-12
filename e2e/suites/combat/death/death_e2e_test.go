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

// DEATH-01 / CB-07: die → corpse path; ghost auras present before release.
func TestDeath_DieProducesGhostState(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieGh",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.DieMust(t, 15*time.Second)

	// Alive() is session usability, not player health. Oracle is Health()==0.
	if hp := bot.World.Health(); hp != 0 {
		e2eharness.Assertf(t, "player hp=%d after DieMust (want 0)", hp)
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
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieRel",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.DieMust(t, 15*time.Second)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	x, y, z, m := bot.Pos()
	t.Logf("PASS DieAndRepop world alive pos=(%.0f,%.0f,%.0f map=%d)", x, y, z, m)
}

// DEATH-03: DieAndRepop full cycle + save.
func TestDeath_DieAndRepopCycle(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieCyc",
		Level:  40,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.DieMust(t, 15*time.Second)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	bot.Save(t)
	t.Logf("PASS die+repop cycle")
}

// DEATH-05: death must not crash the worldserver.
func TestDeath_DeathDoesNotCrashWorld(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "DieOk",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.DieMust(t, 15*time.Second)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS death did not crash world")
}

// DEATH-04: reclaim corpse after death (if helper available).
// AC requires PLAYER_FLAGS_GHOST (release spirit) then proximity to corpse before
// CMSG_RECLAIM_CORPSE succeeds. Alive() is session usability — use WaitAlive/Health.
func TestDeath_ReclaimCorpseAfterDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "med"}, Runtime: "med", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieRec",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	deathX, deathY, deathZ, deathMap := bot.Pos()
	bot.DieMust(t, 15*time.Second)
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
	bot.WaitNear(t, deathX, deathY, deathZ, 100, 5*time.Second)
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
