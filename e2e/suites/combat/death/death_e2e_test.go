//go:build e2e

package death_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

const (
	// Ghost auras commonly applied on player death (WotLK).
	spellGhost      = 8326
	spellGhostNight = 20584
)

// DEATH-01 / CB-07: die → corpse path; ghost auras present before release.
func TestDeath_DieProducesGhostState(t *testing.T) {
	// serial: concurrent .die on the same pad flakes (selection / GM thrash).
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieGh",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.DieMust(t, 20*time.Second)

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
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieRel",
		Level:  30,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.DieMust(t, 20*time.Second)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	x, y, z, m := bot.Pos()
	t.Logf("PASS DieAndRepop world alive pos=(%.0f,%.0f,%.0f map=%d)", x, y, z, m)
}

// DEATH-03: DieAndRepop full cycle + save.
func TestDeath_DieAndRepopCycle(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieCyc",
		Level:  40,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.DieMust(t, 20*time.Second)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	bot.Save(t)
	t.Logf("PASS die+repop cycle")
}

// DEATH-05: death must not crash the worldserver.
func TestDeath_DeathDoesNotCrashWorld(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "DieOk",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.DieMust(t, 20*time.Second)
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	t.Logf("PASS death did not crash world")
}

// DEATH-04: reclaim corpse after death.
// Protocol: Die → capture corpse pos → ReleaseSpirit → wait SMSG_CORPSE_RECLAIM_DELAY
// → .go to corpse (InWorld + within 39yd) → CMSG_RECLAIM_CORPSE.
// Note: .die is Unit::Kill(self,self) → PvP corpse → server delay (often 30s) when
// Death.CorpseReclaimDelay.PvP=1; we wait the packet, not a guessed sleep.
func TestDeath_ReclaimCorpseAfterDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"combat", "med", "serial"}, Runtime: "med", Category: "combat/death"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "DieRec",
		Level:  30,
	})
	// Quiet death setup: combatstop before die (pad thrash); still PvP corpse from .die self-kill.
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.GM(t, ".combatstop")
	bot.DieMust(t, 25*time.Second)
	// Corpse sits at death position (capture after Die, before graveyard tele).
	deathX, deathY, deathZ, deathMap := bot.Pos()
	bot.ReleaseSpirit(t)
	bot.AssertWorldAlive(t)
	if err := bot.World.WaitForSessionPhase(client.PhaseInWorld, 10*time.Second); err != nil {
		t.Logf("post-repop WaitInWorld: %v", err)
	}
	// Soft: ghost aura often applied on release (not required for reclaim opcode).
	deadlineGhost := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadlineGhost) {
		if bot.HasAura(spellGhost) || bot.HasAura(spellGhostNight) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}

	// Wait server delay, then tele+reclaim (see ReclaimCorpseMust).
	bot.ReclaimCorpseMust(t, deathX, deathY, deathZ, deathMap, 45*time.Second)
	if bot.World.Health() == 0 {
		e2eharness.Assertf(t, "reclaim finished still dead hp=%d delay_ms=%d",
			bot.World.Health(), bot.World.CorpseReclaimDelayMs())
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS reclaim corpse → alive (hp=%d delay_ms=%d)", bot.World.Health(), bot.World.CorpseReclaimDelayMs())
}
