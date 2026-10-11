//go:build e2e

package vehicles_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// VEH-* : EnterVehicle / ExitVehicle / IsOnVehicle via Stormwind Steed.
// Armistice (64373) is required by creature_template vehicle conditions.
// spell_area only keeps that aura on the Argent Tournament grounds; PackagePad
// (Outland) applies it then strips it, and VehicleAI ejects the rider.

const spellArmistice uint32 = 64373

func placeAtArgentTournament(t *testing.T, bots ...*e2eharness.ScenarioBot) {
	t.Helper()
	for i, bot := range bots {
		if i == 0 {
			bot.TeleNamed(t, "ArgentTournament")
			continue
		}
		x, y, z, m := bots[0].Pos()
		bot.Teleport(t, x+1.5*float32(i), y, z, m)
	}
}

func ensureArmistice(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	// spell_area autocast only. Do not GM-apply: that would hide an area regression.
	deadline := time.Now().Add(8 * time.Second)
	for time.Now().Before(deadline) {
		if bot.HasAura(spellArmistice) {
			return
		}
		time.Sleep(50 * time.Millisecond)
	}
	e2eharness.Preconditionf(t, "Armistice %d missing after Argent Tournament enter (spell_area)", spellArmistice)
}

func spawnAndBoardSteed(t *testing.T, bot *e2eharness.ScenarioBot) uint64 {
	t.Helper()
	ensureArmistice(t, bot)
	vehGUID := bot.Spawn(t, e2eharness.CreatureStormwindSteed, 15*time.Second)
	if vehGUID == 0 {
		e2eharness.Preconditionf(t, "Stormwind Steed spawn returned guid 0")
	}
	// Re-check immediately before click: spell_area can strip a stale apply.
	ensureArmistice(t, bot)
	bot.EnterVehicle(t, vehGUID, 12*time.Second)
	if !bot.IsOnVehicle() {
		e2eharness.Preconditionf(t, "not on steed 0x%X after enter (charm=0x%X)", vehGUID, bot.World.PlayerCharmGUID())
	}
	return vehGUID
}

// VEH-01: two bots at the pad; one boards a Stormwind Steed.
func TestVehicles_MultiBotColocated(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "multi_bot"}, Runtime: "short", Category: "combat/vehicles"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "VehCol", Count: 2, Level: 80})
	placeAtArgentTournament(t, bots...)
	vehGUID := spawnAndBoardSteed(t, bots[0])
	bots[1].AssertWorldAlive(t)
	t.Logf("PASS vehicle multi-bot colocation boarded=0x%X", vehGUID)
}

// VEH-02: relog on the pad, then board a Stormwind Steed.
func TestVehicles_RelogAfterTeleBaseline(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "protocol"}, Runtime: "short", Category: "combat/vehicles"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehRl", Level: 80})
	placeAtArgentTournament(t, bot)
	bot.Save(t)
	bot.Relog(t)
	vehGUID := spawnAndBoardSteed(t, bot)
	t.Logf("PASS relog then board steed 0x%X", vehGUID)
}

// VEH-03: passenger hard-drop while on a vehicle must leave the probe world alive.
func TestVehicles_HardDisconnectWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/vehicles"})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehPr", Level: 10})
	vic := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehVc", Level: 80})
	placeAtArgentTournament(t, vic)
	vehGUID := spawnAndBoardSteed(t, vic)
	e2eharness.HardDisconnectAndProbe(t, vic, probe, 0)
	t.Logf("PASS passenger hard-drop world alive steed=0x%X", vehGUID)
}

// VEH-04: EnterVehicle → IsOnVehicle → ExitVehicle on Stormwind Steed fixture.
func TestVehicles_EnterExitStormwindSteed(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/vehicles"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehEn", Level: 80})
	placeAtArgentTournament(t, bot)
	if bot.IsOnVehicle() {
		e2eharness.Preconditionf(t, "already on vehicle before enter")
	}
	vehGUID := spawnAndBoardSteed(t, bot)
	bot.ExitVehicle(t, 12*time.Second)
	if bot.IsOnVehicle() {
		e2eharness.Assertf(t, "still IsOnVehicle after ExitVehicle (0x%X)", bot.VehicleGUID())
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS EnterVehicle/ExitVehicle Stormwind Steed 0x%X", vehGUID)
}
