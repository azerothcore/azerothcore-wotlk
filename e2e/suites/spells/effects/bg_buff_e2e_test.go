//go:build e2e

package effects_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// bgBuff is one battleground power-up: a trap GameObject that casts its spell on the
// player who walks into it.
type bgBuff struct {
	name       string
	gameObject uint32
	spell      uint32
}

var bgBuffs = []bgBuff{
	{"Speed", 179871, 23451},
	{"Restoration", 179904, 23493},
	{"Berserking", 179905, 23505},
}

// Since PR #26152 (https://github.com/azerothcore/azerothcore-wotlk/pull/26152) a
// battleground buff casts its spell itself instead of through a trigger creature that made
// the player the original caster. In Warsong Gulch both Berserking buffs and the Horde
// Restoration vanished without a buff: Spell::CheckCast measured line of sight from the
// GameObject's floor position, which the floor under the player blocks. The Alliance
// Restoration buffed without healing, as its tick healed by the caster, now the GameObject.
//
// The harness cannot queue for a battleground, so the buffs are spawned instead: on outdoor
// terrain, and where the Ulduar Antechamber teleporter stands, a floor known to block that ray.
//
// Oracle: each buff, walked into by a player, puts its aura on that player, and Restoration
// then heals them by a tenth of their health.
func TestBattlegroundBuff_AppliesToPlayerOnAnyFloor(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells"},
		Runtime:  "med",
		Category: "spells/effects",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "BGBuff", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80,
	})

	// Spawn opens the world DB lazily and ties its Close to the calling subtest; opening it
	// here keeps spawn cleanup working in every subtest, not only the first.
	worldDB, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.HarnessFailf(t, "open world DB: %v", err)
	}
	t.Cleanup(func() { _ = worldDB.Close() })
	bot.WorldDB = worldDB

	pad := e2eharness.PackagePad(t)
	for _, spot := range []struct {
		name  string
		place func(*testing.T)
		// buffAt pins the buff to this position, with the player half a yard above it;
		// nil leaves both where the bot stands.
		buffAt *e2eharness.Position3
	}{
		{"OutdoorTerrain", func(t *testing.T) { bot.TeleportPad(t, pad) }, nil},
		// The Ulduar Teleporter spawn 34935 position, where line of sight from a GameObject to
		// the player standing on it crosses the floor. GM mode is on here for the raid enter.
		{"UlduarAntechamberFloor", func(t *testing.T) {
			bot.Teleport(t, 1498.05, -24.3509, 420.966, e2eharness.MapUlduar)
		}, &e2eharness.Position3{X: 1498.05, Y: -24.3509, Z: 420.966, Map: e2eharness.MapUlduar}},
	} {
		t.Run(spot.name, func(t *testing.T) {
			for _, buff := range bgBuffs {
				t.Run(buff.name, func(t *testing.T) {
					// A game master is invisible to the buff and is never picked as its target.
					bot.GM(t, ".gm on")
					spot.place(t)
					self := bot.World.CharGUID()
					_ = bot.World.SetTarget(self)
					bot.GM(t, ".unaura all")
					// Half health, so a Restoration tick shows.
					bot.GM(t, ".revive")
					bot.FlushWorld(t)
					_, full := bot.UnitHP(self)
					bot.GM(t, fmt.Sprintf(".modify hp %d", full))
					bot.GM(t, fmt.Sprintf(".damage %d", full/2))

					spawnID := bot.SpawnGameObject(t, buff.gameObject)
					if at := spot.buffAt; at != nil {
						if spawnID == 0 {
							e2eharness.Preconditionf(t, "%s buff GO %d spawn id unknown, cannot move it", buff.name, buff.gameObject)
						}
						bot.GM(t, fmt.Sprintf(".gobject move %d %.4f %.4f %.4f", spawnID, at.X, at.Y, at.Z))
						bot.Teleport(t, at.X, at.Y, at.Z+0.5, at.Map)
					}
					if waitTrapGO(bot, buff.gameObject, true, 5*time.Second) == 0 {
						e2eharness.Preconditionf(t, "%s buff GO %d never appeared", buff.name, buff.gameObject)
					}
					hpBefore, maxHP := bot.UnitHP(self)
					if hpBefore == 0 || hpBefore >= maxHP {
						e2eharness.Preconditionf(t, "bot health %d/%d after .damage, cannot see a heal", hpBefore, maxHP)
					}

					bot.GM(t, ".gm off")
					bot.FlushWorld(t)

					deadline := time.Now().Add(6 * time.Second)
					for !bot.UnitHasAura(self, buff.spell) {
						if time.Now().After(deadline) {
							e2eharness.Assertf(t, "%s buff %d never put aura %d on the player at %s",
								buff.name, buff.gameObject, buff.spell, spot.name)
						}
						time.Sleep(50 * time.Millisecond)
					}

					// Each Restoration tick restores 10% of maximum health, far above regeneration.
					if buff.spell == 23493 {
						healed := hpBefore + maxHP/10
						for hp, _ := bot.UnitHP(self); hp < healed; hp, _ = bot.UnitHP(self) {
							if time.Now().After(deadline) {
								e2eharness.Assertf(t, "Restoration aura on the player at %s but health only went %d -> %d of %d",
									spot.name, hpBefore, hp, maxHP)
							}
							time.Sleep(50 * time.Millisecond)
						}
					}
					hp, _ := bot.UnitHP(self)
					t.Logf("PASS %s buff put aura %d on the player at %s (health %d -> %d of %d)",
						buff.name, buff.spell, spot.name, hpBefore, hp, maxHP)
				})
			}
		})
	}
}
