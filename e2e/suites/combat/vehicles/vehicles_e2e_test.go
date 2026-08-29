//go:build e2e

package vehicles_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

// VEH-* : EnterVehicle / ExitVehicle / IsOnVehicle via Stormwind Steed on PackagePad.

// spellArmistice (64373) is required by creature_template vehicle conditions
// on Stormwind Steed 33217. VehicleAI/SmartAI ExitVehicle the rider without it
// (conditions.comment: "Vehicle Stormwind Steed requires aura Armistice").
const spellArmistice uint32 = 64373

func spawnAndBoardSteed(t *testing.T, bot *e2eharness.ScenarioBot) (vehGUID, boarded uint64) {
	t.Helper()
	bot.ApplyAura(t, spellArmistice)
	if !bot.HasAura(spellArmistice) {
		e2eharness.Preconditionf(t, "Armistice %d not on player (steed vehicle condition)", spellArmistice)
	}
	vehGUID = bot.Spawn(t, e2eharness.CreatureStormwindSteed, 15*time.Second)
	if vehGUID == 0 {
		e2eharness.Preconditionf(t, "Stormwind Steed spawn returned guid 0")
	}
	boarded = bot.EnterVehicle(t, vehGUID, 12*time.Second)
	if !bot.IsOnVehicle() {
		e2eharness.Preconditionf(t, "not on steed 0x%X after enter (charm=0x%X)", vehGUID, bot.World.PlayerCharmGUID())
	}
	return vehGUID, boarded
}

// VEH-01: two bots at the pad; one boards a Stormwind Steed.
func TestVehicles_MultiBotColocated(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "multi_bot"}, Runtime: "short", Category: "combat/vehicles"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "VehCol", Count: 2, Level: 80})
	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAllPad(t, bots, pad)
	vehGUID, _ := spawnAndBoardSteed(t, bots[0])
	bots[1].AssertWorldAlive(t)
	t.Logf("PASS vehicle multi-bot colocation boarded=0x%X", vehGUID)
}

// VEH-02: relog on the pad, then board a Stormwind Steed.
func TestVehicles_RelogAfterTeleBaseline(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "protocol"}, Runtime: "short", Category: "combat/vehicles"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehRl", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.Save(t)
	bot.Relog(t)
	vehGUID, _ := spawnAndBoardSteed(t, bot)
	t.Logf("PASS relog then board steed 0x%X", vehGUID)
}

// VEH-03: passenger hard-drop while on a vehicle must leave the probe world alive.
func TestVehicles_HardDisconnectWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/vehicles"})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehPr", Level: 10})
	vic := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehVc", Level: 80})
	vic.TeleportPad(t, e2eharness.PackagePad(t))
	vehGUID, _ := spawnAndBoardSteed(t, vic)
	e2eharness.HardDisconnectAndProbe(t, vic, probe, 0)
	t.Logf("PASS passenger hard-drop world alive steed=0x%X", vehGUID)
}

// VEH-04: EnterVehicle → IsOnVehicle → ExitVehicle on Stormwind Steed fixture.
func TestVehicles_EnterExitStormwindSteed(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/vehicles"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehEn", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	if bot.IsOnVehicle() {
		e2eharness.Preconditionf(t, "already on vehicle before enter")
	}
	vehGUID, _ := spawnAndBoardSteed(t, bot)
	bot.ExitVehicle(t, 12*time.Second)
	if bot.IsOnVehicle() {
		e2eharness.Assertf(t, "still IsOnVehicle after ExitVehicle (0x%X)", bot.VehicleGUID())
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS EnterVehicle/ExitVehicle Stormwind Steed 0x%X", vehGUID)
}


