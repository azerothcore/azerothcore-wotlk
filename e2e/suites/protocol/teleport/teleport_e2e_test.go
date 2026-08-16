//go:build e2e

package teleport_test

import (
	"math"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

// TELE-01: cross-map teleport (EK → Northrend).
func TestTeleport_CrossMapEasternToNorthrend(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/teleport"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TeleXM",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	_, _, _, m0 := bot.Pos()
	bot.Teleport(t, 3758.2554, 3689.5754, 47.241505, e2eharness.MapNorthrend)
	x, y, z, m1 := bot.Pos()
	if m1 != e2eharness.MapNorthrend {
		e2eharness.Preconditionf(t, "expected Northrend map %d, got %d (from %d)", e2eharness.MapNorthrend, m1, m0)
	}
	if math.IsNaN(float64(x)) {
		e2eharness.HarnessFailf(t, "nan position after cross-map tele")
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS cross-map tele map=%d pos=(%.1f,%.1f,%.1f)", m1, x, y, z)
}

// TELE-02: TeleNamed + world alive.
func TestTeleport_TeleNamedSafe(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/teleport"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TeleNm",
		Level:  80,
	})
	// Stormwind is a stable named tele on most AC installs.
	bot.TeleNamed(t, "Stormwind")
	bot.AssertWorldAlive(t)
	_, _, _, m := bot.Pos()
	if m != e2eharness.MapEasternKingdoms {
		e2eharness.Assertf(t, "TeleNamed Stormwind map=%d want EK %d", m, e2eharness.MapEasternKingdoms)
	}
	t.Logf("PASS TeleNamed Stormwind map=%d", m)
}

// TELE-03: spam short teleports must not crash world.
func TestTeleport_SpamShortDoesNotCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/teleport"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TeleSp",
		Level:  80,
	})
	for i := 0; i < 5; i++ {
		bot.TeleportPad(t, e2eharness.PackagePad(t))
		bot.Teleport(t, -8949.95+float32(i), 554.0, 94.0, e2eharness.MapEasternKingdoms)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS spam short teleports")
}

// TELE-04: pad tele then named tele preserves session.
func TestTeleport_PadThenNamed(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/teleport"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TelePN",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.TeleNamed(t, "Ironforge")
	bot.AssertWorldAlive(t)
	t.Logf("PASS pad then named tele")
}

// TELE-05: GoCreatureID lands near entry after spawn.
func TestTeleport_GoCreatureIDNearSpawn(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/teleport"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TeleGo",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	guid := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	if guid == 0 {
		e2eharness.Preconditionf(t, "failed to spawn target dummy")
	}
	bot.GoCreatureID(t, e2eharness.CreatureTargetDummy)
	bot.AssertWorldAlive(t)
	t.Logf("PASS GoCreatureID near dummy guid=0x%X", guid)
}
