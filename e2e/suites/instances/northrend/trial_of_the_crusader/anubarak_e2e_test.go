//go:build e2e

package trial_of_the_crusader_test

import (
	"encoding/binary"
	"math"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
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

	spellBurrowerSubmerge = uint32(67322)
	spellSubmergeBurrower = uint32(68394)

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

// pullAnubarak spawns a temp Anub'arak in his chamber and pulls him onto the bot, which leaves GM
// mode but stays in god mode so it survives the fight.
func pullAnubarak(t *testing.T, bot *e2eharness.ScenarioBot) (boss uint64, pulledAt time.Time) {
	t.Helper()

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, anubX, anubY, anubZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}

	e2eharness.SpawnNPC(t, bot.World, npcAnubarak)
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

	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	pulledAt = time.Now()
	bot.Damage(t, boss, 1)
	bot.WaitUnitCombat(t, boss, 10*time.Second)
	t.Logf("Anub'arak engaged")
	return boss, pulledAt
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
		// Summon Scarab follows the Submerge cast by 1.2s.
		auraWindow = 5 * time.Second
		// The 50s aura's last tick can land as it expires.
		lastScarabMax = 54 * time.Second
		// Emerge comes about 64s after the Submerge cast.
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
	boss, pulledAt := pullAnubarak(t, bot)

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

// A Nerubian Burrower below 80% health and off Permafrost starts Submerge (67322), a 2s cast. When
// it completes the burrower turns unselectable and casts Submerge Burrower (68394), which lands
// with a Full Heal, and it comes back up with Emerge (65982) 31s later.
//
// Drive: Anub'arak pulled onto a god-mode bot; his first burrower is left at full health for a few
// seconds, then `.damage`d below 80%.
// Oracle: no Submerge while above 80%, Submerge within one health check of dropping below it, the
// burrower unselectable, at full health and under Submerge Burrower, then Emerge 31s later with
// the flag and the aura gone.
func TestToC_AnubarakBurrowerSubmerge(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances"},
		Runtime:  "long",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	const (
		// The first burrower comes 11s into the fight.
		burrowerWindow = 20 * time.Second
		// Several of the burrower's 1.6s health checks.
		fullHealthHold = 5 * time.Second
		// One health check plus latency.
		submergeStartWindow = 4 * time.Second
		// Submerge and Submerge Burrower are 2s casts.
		underWindow = 8 * time.Second
		healWindow  = 3 * time.Second
		// The burrower stays under for 31s.
		emergeMin, emergeMax  = 29 * time.Second, 35 * time.Second
		emergedWindow         = 3 * time.Second
		unitFlagNotSelectable = uint32(0x02000000)
		poll                  = 100 * time.Millisecond
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "AnubBur", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	_, pulledAt := pullAnubarak(t, bot)

	var burrower uint64
	for deadline := pulledAt.Add(burrowerWindow); burrower == 0 && time.Now().Before(deadline); time.Sleep(poll) {
		for _, u := range bot.NearbyUnits(2000) {
			if guidEntry(u.GUID) == npcBurrower && u.Health() > 0 {
				burrower = u.GUID
				break
			}
		}
	}
	if burrower == 0 {
		e2eharness.Preconditionf(t, "no Nerubian Burrower within %s of the pull", burrowerWindow)
	}
	t.Logf("burrower guid=0x%X %s after the pull", burrower, time.Since(pulledAt).Round(time.Millisecond))

	var mu sync.Mutex
	var starts []time.Time
	gos := map[uint32]time.Time{}
	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != 0x0131 && opcode != 0x0132 { // SMSG_SPELL_START, SMSG_SPELL_GO
			return
		}
		caster, spell, ok := spellGoCaster(data)
		if !ok || caster != burrower {
			return
		}
		mu.Lock()
		defer mu.Unlock()
		if opcode == 0x0131 {
			if spell == spellBurrowerSubmerge {
				starts = append(starts, time.Now())
			}
			return
		}
		if _, seen := gos[spell]; !seen {
			gos[spell] = time.Now()
		}
	})
	t.Cleanup(unhook)

	startCount := func() int {
		mu.Lock()
		defer mu.Unlock()
		return len(starts)
	}
	burrowerGo := func(spell uint32) time.Time {
		mu.Lock()
		defer mu.Unlock()
		return gos[spell]
	}
	notSelectable := func() bool {
		o := bot.World.GetObject(burrower)
		return o != nil && o.Value(client.UnitFieldFlags)&unitFlagNotSelectable != 0
	}

	if hp, maxHP := bot.WaitUnitHPKnown(t, burrower, 5*time.Second); hp*5 < maxHP*4 {
		e2eharness.Preconditionf(t, "burrower already below 80%% health (%d/%d) before the damage", hp, maxHP)
	}
	for deadline := time.Now().Add(fullHealthHold); time.Now().Before(deadline); time.Sleep(poll) {
		if n := startCount(); n > 0 {
			hp, maxHP := bot.UnitHP(burrower)
			e2eharness.Assertf(t, "burrower started Submerge (%d) at %d/%d health; it only tries below 80%%",
				spellBurrowerSubmerge, hp, maxHP)
		}
	}

	bot.DamageToFraction(t, burrower, 0.7, 10*time.Second)
	droppedAt := time.Now()
	for deadline := droppedAt.Add(submergeStartWindow); startCount() == 0 && time.Now().Before(deadline); {
		time.Sleep(poll)
	}
	if startCount() == 0 {
		e2eharness.Assertf(t, "burrower did not start Submerge (%d) within %s of dropping below 80%% health",
			spellBurrowerSubmerge, submergeStartWindow)
	}
	mu.Lock()
	startedAt := starts[0]
	mu.Unlock()
	t.Logf("Submerge started %s after the damage", startedAt.Sub(droppedAt).Round(time.Millisecond))

	var underAt time.Time
	for deadline := startedAt.Add(underWindow); underAt.IsZero() && time.Now().Before(deadline); time.Sleep(poll) {
		underAt = burrowerGo(spellSubmergeBurrower)
	}
	if underAt.IsZero() {
		e2eharness.Assertf(t, "no Submerge Burrower (%d) within %s of the Submerge start (Submerge completed: %t)",
			spellSubmergeBurrower, underWindow, !burrowerGo(spellBurrowerSubmerge).IsZero())
	}
	t.Logf("Submerge Burrower landed %s after the Submerge start", underAt.Sub(startedAt).Round(time.Millisecond))

	healed := false
	for deadline := underAt.Add(healWindow); !healed && time.Now().Before(deadline); time.Sleep(poll) {
		hp, maxHP := bot.UnitHP(burrower)
		healed = maxHP > 0 && hp == maxHP && notSelectable() && bot.UnitHasAura(burrower, spellSubmergeBurrower)
	}
	if !healed {
		hp, maxHP := bot.UnitHP(burrower)
		e2eharness.Assertf(t, "submerged burrower at %d/%d health, unselectable %t, Submerge Burrower aura %t; want full health, unselectable and the aura",
			hp, maxHP, notSelectable(), bot.UnitHasAura(burrower, spellSubmergeBurrower))
	}

	var emergedAt time.Time
	for deadline := underAt.Add(emergeMax); emergedAt.IsZero() && time.Now().Before(deadline); time.Sleep(poll) {
		emergedAt = burrowerGo(spellEmerge)
	}
	if emergedAt.IsZero() {
		e2eharness.Assertf(t, "burrower did not Emerge (%d) within %s of going under", spellEmerge, emergeMax)
	}
	if under := emergedAt.Sub(underAt); under < emergeMin {
		e2eharness.Assertf(t, "burrower emerged %s after going under; it stays under 31s", under.Round(time.Millisecond))
	}

	up := false
	for deadline := emergedAt.Add(emergedWindow); !up && time.Now().Before(deadline); time.Sleep(poll) {
		up = !notSelectable() && !bot.UnitHasAura(burrower, spellSubmergeBurrower)
	}
	if !up {
		e2eharness.Assertf(t, "emerged burrower still unselectable (%t) or under Submerge Burrower (%t)",
			notSelectable(), bot.UnitHasAura(burrower, spellSubmergeBurrower))
	}
	t.Logf("PASS burrower submerged %s after dropping below 80%%, stayed under %s",
		startedAt.Sub(droppedAt).Round(time.Millisecond), emergedAt.Sub(underAt).Round(time.Millisecond))
}
