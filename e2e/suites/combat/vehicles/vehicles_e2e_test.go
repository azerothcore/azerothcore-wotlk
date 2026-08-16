//go:build e2e

package vehicles_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

// VEH-* : EnterVehicle / ExitVehicle / IsOnVehicle via Mechano-hog spawn on PackagePad.

// VEH-01: two bots at the pad; one boards a Stormwind Steed.
func TestVehicles_MultiBotColocated(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "multi_bot"}, Runtime: "short", Category: "combat/vehicles"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "VehCol", Count: 2, Level: 80})
	pad := e2eharness.PackagePad(t)
	e2eharness.TeleportAllPad(t, bots, pad)
	vehGUID := bots[0].Spawn(t, e2eharness.CreatureStormwindSteed, 15*time.Second)
	got := bots[0].EnterVehicle(t, vehGUID, 12*time.Second)
	if !bots[0].IsOnVehicle() {
		e2eharness.Assertf(t, "leader not on vehicle after enter (guid=0x%X)", got)
	}
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
	vehGUID := bot.Spawn(t, e2eharness.CreatureStormwindSteed, 15*time.Second)
	got := bot.EnterVehicle(t, vehGUID, 12*time.Second)
	if !bot.IsOnVehicle() {
		e2eharness.Assertf(t, "not on vehicle after relog+enter (guid=0x%X)", got)
	}
	t.Logf("PASS relog then board steed 0x%X", vehGUID)
}

// VEH-03: passenger hard-drop while on a vehicle must leave the probe world alive.
func TestVehicles_HardDisconnectWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/vehicles"})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehPr", Level: 10})
	vic := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehVc", Level: 80})
	vic.TeleportPad(t, e2eharness.PackagePad(t))
	vehGUID := vic.Spawn(t, e2eharness.CreatureStormwindSteed, 15*time.Second)
	got := vic.EnterVehicle(t, vehGUID, 12*time.Second)
	if !vic.IsOnVehicle() {
		e2eharness.Preconditionf(t, "victim not on vehicle before drop (guid=0x%X)", got)
	}
	e2eharness.HardDisconnectAndProbe(t, vic, probe, 0)
	t.Logf("PASS passenger hard-drop world alive steed=0x%X", vehGUID)
}

// VEH-04: EnterVehicle → IsOnVehicle → ExitVehicle on Stormwind Steed fixture.
func TestVehicles_EnterExitStormwindSteed(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/vehicles"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehEn", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// SpawnPersistent registers SQL+live cleanup for pad litter.
	// Stormwind Steed: friendly, SPELLCLICK, not UNINTERACTIBLE (unlike Mechano-hog).
	vehGUID := bot.Spawn(t, e2eharness.CreatureStormwindSteed, 15*time.Second)
	if vehGUID == 0 {
		e2eharness.Preconditionf(t, "Stormwind Steed spawn returned guid 0")
	}
	if bot.IsOnVehicle() {
		e2eharness.Preconditionf(t, "already on vehicle before enter")
	}

	got := bot.EnterVehicle(t, vehGUID, 12*time.Second)
	if !bot.IsOnVehicle() {
		e2eharness.Assertf(t, "IsOnVehicle false after EnterVehicle (guid=0x%X charm=0x%X)", got, bot.World.PlayerCharmGUID())
	}
	bot.ExitVehicle(t, 12*time.Second)
	if bot.IsOnVehicle() {
		e2eharness.Assertf(t, "still IsOnVehicle after ExitVehicle (0x%X)", bot.VehicleGUID())
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS EnterVehicle/ExitVehicle Stormwind Steed 0x%X", vehGUID)
}


