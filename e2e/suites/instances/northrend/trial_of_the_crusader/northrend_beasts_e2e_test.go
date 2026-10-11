//go:build e2e

package trial_of_the_crusader_test

import (
	"encoding/binary"
	"fmt"
	"math"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	mapTrialOfTheCrusader = uint32(649)
	npcGormok             = uint32(34796)
	npcSnobold            = uint32(34800)
	npcTirion             = uint32(34996)

	// Arena centre (trial_of_the_crusader.h LOC_CENTER).
	centerX, centerY, centerZ = float32(563.67), float32(139.57), float32(393.84)

	seatWindow  = 15 * time.Second
	sampleEvery = 200 * time.Millisecond
)

// spawnGormok summons a temp Gormok in the arena and waits for the Snobold Vassals riding him.
// His intro needs Barrett's gossip, which the harness cannot send, so the instance never runs its
// Northrend Beasts flow for him.
func spawnGormok(t *testing.T, bot *e2eharness.ScenarioBot) (gormok uint64, riders []uint64) {
	t.Helper()

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, centerX, centerY, centerZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}

	// Tirion watches from the stands, so once he is cached the arena's leftovers from an earlier
	// test (a dead Gormok, its Snobolds) are too and can't be mistaken for the new spawn.
	bot.WaitUnit(t, npcTirion, 20*time.Second)
	known := map[uint64]struct{}{}
	for _, u := range bot.UnitsByEntry(0, npcGormok) {
		known[u.GUID] = struct{}{}
	}
	for _, g := range snobolds(bot) {
		known[g] = struct{}{}
	}

	e2eharness.SpawnNPC(t, bot.World, npcGormok)
	for deadline := time.Now().Add(20 * time.Second); gormok == 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
		for _, u := range bot.UnitsByEntry(0, npcGormok) {
			if _, old := known[u.GUID]; !old && u.Health > 0 {
				gormok = u.GUID
				break
			}
		}
	}
	if gormok == 0 {
		e2eharness.Preconditionf(t, "no new living Gormok after .npc add temp")
	}
	t.Logf("Gormok guid=0x%X", gormok)
	t.Cleanup(func() {
		if hp, _ := bot.UnitHP(gormok); hp == 0 {
			return
		}
		if err := bot.World.SetTarget(gormok); err == nil {
			bot.GM(t, ".npc delete")
		}
	})

	for deadline := time.Now().Add(seatWindow); time.Now().Before(deadline); time.Sleep(sampleEvery) {
		riders = riders[:0]
		for _, g := range snobolds(bot) {
			if _, old := known[g]; !old {
				riders = append(riders, g)
			}
		}
		if len(riders) == 4 {
			break
		}
	}
	if len(riders) == 0 {
		e2eharness.Preconditionf(t, "no Snobold Vassal seated on Gormok 0x%X within %s", gormok, seatWindow)
	}
	t.Logf("%d Snobolds riding Gormok: %v", len(riders), guidList(riders))
	return gormok, riders
}

// snobolds lists the living Snobold Vassals in the object cache. The harness stores a passenger's
// seat offset as its position, which puts a seated Snobold near (0,0,0), hundreds of yards from the
// bot; search wide and match on the GUID's entry.
func snobolds(bot *e2eharness.ScenarioBot) []uint64 {
	var out []uint64
	for _, u := range bot.NearbyUnits(2000) {
		if uint32((u.GUID>>24)&0xFFFFFF) == npcSnobold && u.Health() > 0 {
			out = append(out, u.GUID)
		}
	}
	return out
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/27942
//
// Gormok carries four Snobold Vassals as vehicle accessories. His death ejects them, and the
// boss script used to despawn every Snobold that was not riding a player right after. Per sniff
// they stay on the ground, keep bombing and join the fight a few seconds after landing.
//
// Drive: a temp Gormok is killed with `.damage`, which ignores his NON_ATTACKABLE flag.
// Oracle: every Snobold that rode him is still alive well after his death, each then targets
// the bot, and once the bot dies they all despawn instead of being left behind in the arena.
func TestToC_GormokSnoboldsFightAfterDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		// Snobolds must outlive Gormok's death handling, which runs in the same tick.
		surviveWindow = 3 * time.Second
		// Dismounted Snobolds engage 5s after Gormok dies.
		engageWindow  = 12 * time.Second
		despawnWindow = 15 * time.Second
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "GrmSnb", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	gormok, riders := spawnGormok(t, bot)

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

// Gormok throws a Snobold at a random player. A Snobold casts Jump to Hand on him to climb into
// his hand, and the 2.5s aura expiring releases it 23 yards ahead of him at hand height. Per sniff a
// throw at a player who can't carry it lands short: the Snobold walks back, climbs onto a free
// seat and heals to full.
//
// Drive: the temp Gormok skips the instance flow that makes players carriers, so every throw at
// the bot misses. `.damage` pulls him; he stays passive, but his throw timer runs.
// Oracle: one Snobold casts Jump to Hand (66342), then Rising Anger (66636) as the aura expires,
// lands well away from Gormok, and casts Full Heal (17683) once it is back on a seat.
func TestToC_GormokSnoboldMissedThrowReturns(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		spellJumpToHand  = uint32(66342)
		spellRisingAnger = uint32(66636)
		spellFullHeal    = uint32(17683)
		smsgSpellGo      = uint16(0x0132)

		// Gormok picks a Snobold 16-24s after the pull.
		throwWindow = 30 * time.Second
		// Jump to Hand's aura lasts 2.5s; allow for world tick and network jitter.
		releaseMin, releaseMax = 2000 * time.Millisecond, 3500 * time.Millisecond
		// The throw lands 23 yards ahead of Gormok.
		landMin, landMax = float32(18), float32(28)
		// Lands after ~0.8s, waits 1.1s, walks back, then heals 1.2s after boarding.
		returnWindow = 12 * time.Second
	)

	type spellGo struct {
		at     time.Time
		caster uint64
	}
	var mu sync.Mutex
	gos := map[uint32][]spellGo{}

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "GrmThr", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	gormok, riders := spawnGormok(t, bot)
	isRider := map[uint64]bool{}
	for _, g := range riders {
		isRider[g] = true
	}

	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != smsgSpellGo {
			return
		}
		caster, off := readPackedGUID(data, 0)
		_, off = readPackedGUID(data, off) // caster unit
		off++                              // cast count
		if !isRider[caster] || off+4 > len(data) {
			return
		}
		spell := binary.LittleEndian.Uint32(data[off:])
		if spell != spellJumpToHand && spell != spellRisingAnger && spell != spellFullHeal {
			return
		}
		mu.Lock()
		gos[spell] = append(gos[spell], spellGo{at: time.Now(), caster: caster})
		mu.Unlock()
	})
	t.Cleanup(unhook)

	waitGo := func(spell uint32, caster uint64, after time.Time, timeout time.Duration) (spellGo, bool) {
		for deadline := time.Now().Add(timeout); time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
			mu.Lock()
			for _, g := range gos[spell] {
				if !g.at.Before(after) && (caster == 0 || g.caster == caster) {
					mu.Unlock()
					return g, true
				}
			}
			mu.Unlock()
		}
		return spellGo{}, false
	}

	// Out of GM mode so Gormok can pick the bot; god keeps it up through his stomps.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	pulledAt := time.Now()
	bot.Damage(t, gormok, 1)
	bot.WaitUnitCombat(t, gormok, 10*time.Second)

	jump, ok := waitGo(spellJumpToHand, 0, pulledAt, throwWindow)
	if !ok {
		e2eharness.Assertf(t, "no Snobold cast Jump to Hand (%d) within %s of the pull", spellJumpToHand, throwWindow)
	}
	snobold := jump.caster
	t.Logf("Snobold 0x%X jumped to Gormok's hand %s after the pull", snobold, jump.at.Sub(pulledAt).Round(time.Millisecond))

	anger, ok := waitGo(spellRisingAnger, snobold, jump.at, releaseMax+time.Second)
	if !ok {
		e2eharness.Assertf(t, "Snobold 0x%X never cast Rising Anger (%d) after Jump to Hand; the aura expiry must release it",
			snobold, spellRisingAnger)
	}
	held := anger.at.Sub(jump.at)
	if held < releaseMin || held > releaseMax {
		e2eharness.Assertf(t, "Snobold 0x%X left the hand %s after Jump to Hand, want %s-%s (the aura's 2.5s)",
			snobold, held.Round(time.Millisecond), releaseMin, releaseMax)
	}
	t.Logf("Snobold 0x%X released %s after Jump to Hand", snobold, held.Round(time.Millisecond))

	// The fall spline starts where the throw put the Snobold. The harness misreads a falling
	// spline's destination, so judge the landing spot by the spline's start.
	time.Sleep(300 * time.Millisecond)
	landed := bot.World.GetObject(snobold).Clone()
	boss := bot.World.GetObject(gormok).Clone()
	if landed == nil || boss == nil {
		e2eharness.HarnessFailf(t, "Snobold 0x%X or Gormok 0x%X left the object cache after the throw", snobold, gormok)
	}
	dx, dy := landed.StartX-boss.PosX, landed.StartY-boss.PosY
	dist := float32(math.Sqrt(float64(dx*dx + dy*dy)))
	if dist < landMin || dist > landMax {
		e2eharness.Assertf(t, "Snobold 0x%X landed %.1f yards from Gormok, want %.0f-%.0f (thrown 23 yards ahead of him)",
			snobold, dist, landMin, landMax)
	}
	t.Logf("Snobold 0x%X landed %.1f yards from Gormok", snobold, dist)

	heal, ok := waitGo(spellFullHeal, snobold, anger.at, returnWindow)
	if !ok {
		e2eharness.Assertf(t, "Snobold 0x%X never cast Full Heal (%d) within %s of the missed throw; it must walk back and reboard Gormok",
			snobold, spellFullHeal, returnWindow)
	}
	if hp, _ := bot.UnitHP(gormok); hp == 0 {
		e2eharness.HarnessFailf(t, "Gormok 0x%X died during the throw; the return path never ran", gormok)
	}
	t.Logf("PASS Snobold 0x%X missed the bot, walked back and healed %s after the throw",
		snobold, heal.at.Sub(anger.at).Round(time.Millisecond))
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

// readPackedGUID reads a WoW packed GUID starting at off and returns the guid and the next offset.
// The first byte is a bitmask; each set bit i contributes byte i of the guid, low bit first.
func readPackedGUID(b []byte, off int) (uint64, int) {
	if off >= len(b) {
		return 0, off
	}
	mask := b[off]
	off++
	var guid uint64
	for i := 0; i < 8; i++ {
		if mask&(1<<uint(i)) != 0 {
			if off >= len(b) {
				break
			}
			guid |= uint64(b[off]) << (8 * uint(i))
			off++
		}
	}
	return guid, off
}
