//go:build e2e

package trial_of_the_crusader_test

import (
	"encoding/binary"
	"math"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	npcAnubarak = uint32(34564)
	npcScarab   = uint32(34605)
	npcBurrower = uint32(34607)
	npcBurrow   = uint32(34862)

	spellSubmerge     = uint32(65981)
	spellEmerge       = uint32(65982)
	spellSummonScarab = uint32(66339)

	// Anub'arak's chamber (trial_of_the_crusader.h LOC_ANUB).
	anubX, anubY, anubZ = float32(785.90), float32(133.42), float32(142.612)
)

// Nerubian Burrow spots (boss_anubarak_trial.cpp AnubLocs).
var burrowSpots = [4][2]float32{
	{694.886353, 102.484665},
	{731.987244, 83.382469},
	{694.500671, 185.363968},
	{740.184509, 193.443390},
}

// spellGoCaster reads the caster guid and spell id from a 3.3.5 SMSG_SPELL_GO.
func spellGoCaster(data []byte) (caster uint64, spell uint32, ok bool) {
	caster, off := readPackedGUID(data, 0)
	_, off = readPackedGUID(data, off) // caster unit
	off++                              // cast count
	if off+4 > len(data) {
		return 0, 0, false
	}
	return caster, binary.LittleEndian.Uint32(data[off:]), true
}

func guidEntry(guid uint64) uint32 {
	return uint32((guid >> 24) & 0xFFFFFF)
}

// nearestBurrow returns the index of the burrow spot closest to (x, y) and its distance.
func nearestBurrow(x, y float32) (int, float32) {
	best, bestDist := 0, float32(math.MaxFloat32)
	for i, b := range burrowSpots {
		dx, dy := x-b[0], y-b[1]
		if d := float32(math.Sqrt(float64(dx*dx + dy*dy))); d < bestDist {
			best, bestDist = i, d
		}
	}
	return best, bestDist
}

// While Anub'arak is submerged, one Summon Scarab (66339) puts a 50s aura on all four Nerubian
// Burrows, and each burrow summons Swarm Scarabs on its own 4s ticks until the aura runs out.
// The burrows summon the scarabs, so Anub'arak only despawns them on a wipe because the instance
// hands them to him through its summon data.
//
// Drive: a temp Anub'arak in his chamber, pulled with `.damage`, submerges 80s into the fight.
// Oracle: right after his Submerge all four burrows carry Summon Scarab at once, scarabs come out
// of more than one burrow and stop once the aura expires, before he emerges, and every scarab and
// burrower is gone shortly after the bot dies. The core sends no SPELL_GO for the triggered Summon
// Scarab cast, so its aura on the burrows is what the test reads.
func TestToC_AnubarakScarabsFromAllBurrows(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances"},
		Runtime:  "long",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		// Submerge, a 2s cast, starts 80s after the pull.
		submergeWindow = 95 * time.Second
		// Summon Scarab follows the Submerge cast by 0.5s.
		auraWindow = 5 * time.Second
		// The 50s aura's last tick can land as it expires.
		lastScarabMax = 54 * time.Second
		// Emerge comes about 60s after the Submerge cast.
		emergeWindow = 75 * time.Second
		// A burrow summons right where it stands.
		burrowRadius  = float32(15)
		despawnWindow = 15 * time.Second
		poll          = 100 * time.Millisecond
	)

	var mu sync.Mutex
	gos := map[uint32]time.Time{}

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "AnubScb", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, anubX, anubY, anubZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}

	e2eharness.SpawnNPC(t, bot.World, npcAnubarak)
	var boss uint64
	for deadline := time.Now().Add(20 * time.Second); boss == 0 && time.Now().Before(deadline); time.Sleep(sampleEvery) {
		for _, u := range bot.NearbyUnits(2000) {
			if guidEntry(u.GUID) == npcAnubarak && u.Health() > 0 {
				boss = u.GUID
				break
			}
		}
	}
	if boss == 0 {
		e2eharness.Preconditionf(t, "no living Anub'arak after .npc add temp")
	}
	t.Logf("Anub'arak guid=0x%X", boss)
	t.Cleanup(func() {
		if hp, _ := bot.UnitHP(boss); hp == 0 {
			return
		}
		if err := bot.World.SetTarget(boss); err == nil {
			bot.GM(t, ".npc delete")
		}
	})

	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != 0x0132 { // SMSG_SPELL_GO
			return
		}
		caster, spell, ok := spellGoCaster(data)
		if !ok || caster != boss || (spell != spellSubmerge && spell != spellEmerge) {
			return
		}
		mu.Lock()
		if _, seen := gos[spell]; !seen {
			gos[spell] = time.Now()
		}
		mu.Unlock()
	})
	t.Cleanup(unhook)

	bossGo := func(spell uint32) time.Time {
		mu.Lock()
		defer mu.Unlock()
		return gos[spell]
	}

	// Out of GM mode so Anub'arak fights the bot; god keeps it up until the wipe below.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	pulledAt := time.Now()
	bot.Damage(t, boss, 1)
	bot.WaitUnitCombat(t, boss, 10*time.Second)
	t.Logf("Anub'arak engaged")

	var submergedAt time.Time
	for deadline := pulledAt.Add(submergeWindow); submergedAt.IsZero() && time.Now().Before(deadline); time.Sleep(poll) {
		submergedAt = bossGo(spellSubmerge)
	}
	if submergedAt.IsZero() {
		e2eharness.Preconditionf(t, "Anub'arak did not submerge within %s of the pull", submergeWindow)
	}
	t.Logf("Anub'arak submerged %s after the pull", submergedAt.Sub(pulledAt).Round(time.Millisecond))

	var burrows []uint64
	for _, u := range bot.NearbyUnits(2000) {
		if guidEntry(u.GUID) == npcBurrow {
			burrows = append(burrows, u.GUID)
		}
	}
	if len(burrows) != len(burrowSpots) {
		e2eharness.Preconditionf(t, "%d Nerubian Burrows in the object cache, want %d", len(burrows), len(burrowSpots))
	}
	carrying := func() int {
		n := 0
		for _, g := range burrows {
			if bot.UnitHasAura(g, spellSummonScarab) {
				n++
			}
		}
		return n
	}
	most := 0
	for deadline := submergedAt.Add(auraWindow); most < len(burrows) && time.Now().Before(deadline); time.Sleep(poll) {
		most = max(most, carrying())
	}
	if most < len(burrows) {
		e2eharness.Assertf(t, "at most %d of %d Nerubian Burrows carried Summon Scarab (%d) at once within %s of the Submerge; one cast covers all four",
			most, len(burrows), spellSummonScarab, auraWindow)
	}
	t.Logf("all %d burrows carry Summon Scarab %s after the Submerge", len(burrows), time.Since(submergedAt).Round(time.Millisecond))

	// Scarabs already around (the idle ones before the pull) are not burrow summons.
	known := map[uint64]struct{}{}
	for _, u := range bot.NearbyUnits(2000) {
		if guidEntry(u.GUID) == npcScarab {
			known[u.GUID] = struct{}{}
		}
	}

	type spawn struct {
		at     time.Duration
		burrow int
	}
	scarabs := map[uint64]spawn{}
	burrowers := map[uint64]struct{}{}
	var emergedAt time.Time
	for deadline := submergedAt.Add(emergeWindow); emergedAt.IsZero() && time.Now().Before(deadline); time.Sleep(poll) {
		for _, u := range bot.NearbyUnits(2000) {
			switch guidEntry(u.GUID) {
			case npcBurrower:
				if u.Health() > 0 {
					burrowers[u.GUID] = struct{}{}
				}
			case npcScarab:
				if _, old := known[u.GUID]; old {
					continue
				}
				known[u.GUID] = struct{}{}
				o := u.Clone()
				i, d := nearestBurrow(o.PosX, o.PosY)
				if d > burrowRadius {
					e2eharness.Assertf(t, "scarab 0x%X appeared at (%.1f, %.1f), %.1f yards from the nearest burrow; burrows summon them where they stand",
						u.GUID, o.PosX, o.PosY, d)
				}
				scarabs[u.GUID] = spawn{at: time.Since(submergedAt), burrow: i}
				t.Logf("scarab 0x%X from burrow %d %s after the Submerge", u.GUID, i+1, time.Since(submergedAt).Round(time.Millisecond))
			}
		}
		emergedAt = bossGo(spellEmerge)
	}
	if emergedAt.IsZero() {
		e2eharness.Assertf(t, "Anub'arak did not emerge within %s of the Submerge", emergeWindow)
	}
	t.Logf("Anub'arak emerged %s after the Submerge", emergedAt.Sub(submergedAt).Round(time.Millisecond))

	if len(scarabs) == 0 {
		e2eharness.Assertf(t, "no scarab came out of the burrows while Anub'arak was submerged")
	}
	used := map[int]struct{}{}
	var last time.Duration
	for _, s := range scarabs {
		used[s.burrow] = struct{}{}
		if s.at > last {
			last = s.at
		}
	}
	if len(used) < 2 {
		e2eharness.Assertf(t, "all %d scarabs came from one burrow; Summon Scarab feeds all four", len(scarabs))
	}
	if last > lastScarabMax {
		e2eharness.Assertf(t, "a scarab appeared %s after the Submerge; the 50s aura must have stopped them by %s",
			last.Round(time.Millisecond), lastScarabMax)
	}
	t.Logf("%d scarabs from %d burrows, last %s after the Submerge", len(scarabs), len(used), last.Round(time.Millisecond))

	var adds []uint64
	for g := range scarabs {
		if hp, _ := bot.UnitHP(g); hp > 0 {
			adds = append(adds, g)
		}
	}
	for g := range burrowers {
		if hp, _ := bot.UnitHP(g); hp > 0 {
			adds = append(adds, g)
		}
	}
	if len(adds) == 0 {
		e2eharness.Preconditionf(t, "no living scarab or burrower left to check the wipe despawn")
	}

	// The wipe: with the bot dead Anub'arak evades and despawns his summons.
	bot.DieMust(t, 25*time.Second)
	diedAt := time.Now()
	for deadline := diedAt.Add(despawnWindow); time.Now().Before(deadline); time.Sleep(sampleEvery) {
		if len(present(bot, adds)) == 0 {
			break
		}
	}
	if left := present(bot, adds); len(left) > 0 {
		e2eharness.Assertf(t, "%d of %d scarab(s)/burrower(s) %v still around %s after the wipe; Anub'arak must despawn them",
			len(left), len(adds), guidList(left), despawnWindow)
	}
	// Anub'arak himself evades and stays, so his absence would mean the bot lost its view of the
	// chamber, not that the adds despawned.
	if bot.World.GetObject(boss) == nil {
		e2eharness.HarnessFailf(t, "Anub'arak 0x%X left the object cache with his adds; the despawn check proves nothing", boss)
	}
	t.Logf("PASS Summon Scarab on all %d burrows, %d scarabs from %d burrows, %d adds despawned %s after the wipe",
		len(burrows), len(scarabs), len(used), len(adds), time.Since(diedAt).Round(time.Millisecond))
}
