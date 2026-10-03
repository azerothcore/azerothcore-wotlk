//go:build e2e

package trial_of_the_crusader_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/27942
//
// Gormok carries four Snobold Vassals as vehicle accessories. His death ejects them, and the
// boss script used to despawn every Snobold that was not riding a player right after. Per sniff
// they stay on the ground, keep bombing and join the fight a few seconds after landing.
//
// Drive: a temp Gormok is summoned in the arena (his intro needs Barrett's gossip, which the
// harness cannot send) and killed with `.damage`, which ignores his NON_ATTACKABLE flag.
// Oracle: every Snobold that rode him is still alive well after his death, each then targets
// the bot, and once the bot dies they all despawn instead of being left behind in the arena.
func TestToC_GormokSnoboldsFightAfterDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		mapTrialOfTheCrusader = uint32(649)
		npcGormok             = uint32(34796)
		npcSnobold            = uint32(34800)
		npcTirion             = uint32(34996)

		// Arena centre (trial_of_the_crusader.h LOC_CENTER).
		centerX, centerY, centerZ = float32(563.67), float32(139.57), float32(393.84)

		seatWindow = 15 * time.Second
		// The old script despawned them inside Gormok's JustDied; this is far past that.
		surviveWindow = 3 * time.Second
		// Dismounted Snobolds engage 5s after Gormok dies.
		engageWindow  = 12 * time.Second
		despawnWindow = 15 * time.Second
		sampleEvery   = 200 * time.Millisecond
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "GrmSnb", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, centerX, centerY, centerZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}

	known := map[uint64]struct{}{}
	for _, u := range bot.UnitsByEntry(0, npcGormok) {
		known[u.GUID] = struct{}{}
	}
	e2eharness.SpawnNPC(t, bot.World, npcGormok)
	fresh := bot.WaitNewUnits(t, known, []uint32{npcGormok}, 20*time.Second)
	if len(fresh) == 0 {
		e2eharness.Preconditionf(t, "no new Gormok after .npc add temp")
	}
	gormok := fresh[0].GUID
	t.Logf("Gormok guid=0x%X", gormok)
	t.Cleanup(func() {
		if hp, _ := bot.UnitHP(gormok); hp == 0 {
			return
		}
		if err := bot.World.SetTarget(gormok); err == nil {
			bot.GM(t, ".npc delete")
		}
	})

	// The harness stores a passenger's seat offset as its position, which puts a seated Snobold
	// near (0,0,0), hundreds of yards from the bot; search wide and match on the GUID's entry.
	snobolds := func() []uint64 {
		var out []uint64
		for _, u := range bot.NearbyUnits(2000) {
			if uint32((u.GUID>>24)&0xFFFFFF) == npcSnobold && u.Health() > 0 {
				out = append(out, u.GUID)
			}
		}
		return out
	}
	var riders []uint64
	for deadline := time.Now().Add(seatWindow); time.Now().Before(deadline); time.Sleep(sampleEvery) {
		if riders = snobolds(); len(riders) == 4 {
			break
		}
	}
	if len(riders) == 0 {
		e2eharness.Preconditionf(t, "no Snobold Vassal seated on Gormok 0x%X within %s", gormok, seatWindow)
	}
	t.Logf("%d Snobolds riding Gormok: %v", len(riders), guidList(riders))

	// Out of GM mode so the Snobolds can pick the bot; god keeps it up until the wipe below.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.DamageKill(t, []uint64{gormok}, 0, 15*time.Second)
	killedAt := time.Now()
	t.Logf("Gormok dead")

	for time.Since(killedAt) < surviveWindow {
		for _, g := range riders {
			if hp, _ := bot.UnitHP(g); bot.World.GetObject(g) == nil || hp == 0 {
				e2eharness.Assertf(t, "Snobold 0x%X gone %s after Gormok died; his riders must stay and fight",
					g, time.Since(killedAt).Round(time.Millisecond))
			}
		}
		time.Sleep(sampleEvery)
	}
	t.Logf("all %d Snobolds still alive %s after Gormok died", len(riders), surviveWindow)

	me := bot.World.CharGUID()
	pending := map[uint64]struct{}{}
	for _, g := range riders {
		pending[g] = struct{}{}
	}
	for deadline := killedAt.Add(engageWindow); len(pending) > 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
		for g := range pending {
			if bot.UnitTarget(g) == me {
				t.Logf("Snobold 0x%X engaged the bot %s after Gormok died", g, time.Since(killedAt).Round(time.Millisecond))
				delete(pending, g)
			}
		}
	}
	if len(pending) > 0 {
		var left []uint64
		for g := range pending {
			left = append(left, g)
		}
		e2eharness.Assertf(t, "%d Snobold(s) %v never targeted the bot within %s of Gormok's death",
			len(left), guidList(left), engageWindow)
	}

	// Tirion watches from the stands and stays put through the wipe, so his absence afterwards
	// would mean the bot simply lost its view of the arena, not that the Snobolds despawned.
	tirion := bot.World.FindUnitByEntry(npcTirion, 0)
	if tirion == 0 {
		e2eharness.Preconditionf(t, "no Tirion (%d) in the object cache to vouch for the despawn check", npcTirion)
	}

	// The wipe: with nobody left to fight they evade, and a dismounted Snobold despawns on evade.
	bot.DieMust(t, 25*time.Second)
	diedAt := time.Now()
	for deadline := diedAt.Add(despawnWindow); time.Now().Before(deadline); time.Sleep(sampleEvery) {
		if len(present(bot, riders)) == 0 {
			break
		}
	}
	if left := present(bot, riders); len(left) > 0 {
		e2eharness.Assertf(t, "%d Snobold(s) %v still in the arena %s after the wipe; dismounted Snobolds must despawn on evade",
			len(left), guidList(left), despawnWindow)
	}
	if bot.World.GetObject(tirion) == nil {
		e2eharness.HarnessFailf(t, "Tirion 0x%X left the object cache with the Snobolds; the despawn check proves nothing", tirion)
	}
	t.Logf("PASS %d Snobolds outlived Gormok, engaged the bot and despawned %s after the wipe",
		len(riders), time.Since(diedAt).Round(time.Millisecond))
}

func present(bot *e2eharness.ScenarioBot, guids []uint64) []uint64 {
	var out []uint64
	for _, g := range guids {
		if bot.World.GetObject(g) != nil {
			out = append(out, g)
		}
	}
	return out
}

func guidList(guids []uint64) string {
	s := ""
	for i, g := range guids {
		if i > 0 {
			s += " "
		}
		s += fmt.Sprintf("0x%X", g)
	}
	return s
}
