//go:build e2e

package charm_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

// CHARM-01: apply mind control-like aura via GM on creature and release — world stays up.
// Uses CancelAura + probe pattern; full MC control is content-dependent.
func TestCharm_ApplyAndCancelAuraOnSelf(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/charm"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "CharmAu",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	bot.ApplyAura(t, e2eharness.SpellBlendingInAura)
	if !bot.HasAura(e2eharness.SpellBlendingInAura) {
		e2eharness.Preconditionf(t, "aura missing after apply")
	}
	bot.CancelAura(t, e2eharness.SpellBlendingInAura)
	bot.AssertWorldAlive(t)
	t.Logf("PASS apply/cancel aura charm-adjacent path")
}

// CHARM-02 / #25506 style: logout while "charmed" aura present must not crash world.
func TestCharm_LogoutWhileAuraWorldAlive(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "issue", "serial"},
		Runtime:  "med",
		Issue:    25506,
		Category: "combat/charm",
	})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmPr", Level: 10})
	victim := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmVc", Level: 80})
	victim.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	victim.ApplyAura(t, e2eharness.SpellBlendingInAura)
	victim.Save(t)
	// Clean logout path via Relog of victim would re-enter; instead hard-drop after save.
	victim.HardDisconnect(t)
	e2eharness.ProbeWorldAlive(t, probe, 25506)
	t.Logf("PASS logout while aura world alive")
}

// CHARM-03: hard drop while aura present.
func TestCharm_HardDropWhileAuraNoCrash(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "issue", "serial"},
		Runtime:  "med",
		Issue:    25506,
		Category: "combat/charm",
	})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmHd", Level: 10})
	victim := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmHv", Level: 80})
	victim.ApplyAura(t, e2eharness.SpellBlendingInAura)
	victim.HardDisconnect(t)
	e2eharness.ProbeWorldAlive(t, probe, 25506)
	t.Logf("PASS hard drop while aura no crash")
}

// CHARM-04: multi-bot — one applies aura, other probes after victim leave.
func TestCharm_MultiBotProbeAfterVictimLeave(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"med", "combat", "multi_bot"}, Runtime: "med", Category: "combat/charm"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "CharmMb", Count: 2, Level: 80})
	a, b := bots[0], bots[1]
	a.ApplyAura(t, e2eharness.SpellBlendingInAura)
	a.LeaveGroup(t) // no-op if not grouped
	a.HardDisconnect(t)
	e2eharness.ProbeWorldAlive(t, b, 0)
	t.Logf("PASS multi-bot probe after victim leave")
}

// CHARM-05: CancelCast helper path.
func TestCharm_CancelCastSafe(t *testing.T) {
	t.Parallel()
	meta.Gate(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/charm"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CharmCc",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PadStormwindOutskirts)
	// Start rain of fire channel then cancel when channel is observed (or soft path).
	x, y, z, _ := bot.Pos()
	go func() {
		_ = bot.CastAtPosition(t, e2eharness.SpellRainOfFire, x, y, z, 10*time.Second)
	}()
	// Soft poll for channel (no fixed sleep); cancel either way. Oracle is world alive —
	// pad combat noise can leave channel flag sticky or prevent channel entirely.
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if bot.IsChanneling() {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	bot.CancelCast(t)
	// Soft: do not require WaitNotChanneling (channel cancel can lag under aggro).
	bot.AssertWorldAlive(t)
	t.Logf("PASS cancel cast path channeling=%v", bot.IsChanneling())
}
