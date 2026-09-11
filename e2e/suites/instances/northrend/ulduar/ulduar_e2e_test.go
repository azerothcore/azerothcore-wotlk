//go:build e2e

package ulduar_test

import (
	"encoding/binary"
	"fmt"
	"math"
	"regexp"
	"strconv"
	"strings"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// OPEN(e2e): re-enable when AC#26266 is fixed — Charge near Kologarn must not drop below bridge Z.
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/26266
// Placement: charge pad ~15y west of Kologarn spawn (1797.15,-24.4,448.7) at (1782.15,-24.4,448.7).
/*
func TestUlduar_KologarnChargeWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "issue"},
		Runtime:  "long",
		Issue:    26266,
		Category: "instances/northrend/ulduar",
	})
	posCharge := e2eharness.Position3{X: 1782.15, Y: -24.4027, Z: 448.741, Map: e2eharness.MapUlduar}
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldKol", Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	bot.TeleNamed(t, "Kologarn")
	bot.Teleport(t, posCharge.X, posCharge.Y, posCharge.Z, posCharge.Map)
	kolo := bot.WaitUnit(t, e2eharness.CreatureKologarn, 30*time.Second)
	bot.Learn(t, e2eharness.SpellBattleStance)
	bot.Learn(t, e2eharness.SpellCharge)
	bot.CombatReadyFull(t)
	bot.CastSelfGM(t, e2eharness.SpellBattleStance)
	preX, preY, preZ, _ := bot.Pos()
	bot.Face(t, kolo)
	res, err := bot.TryCast(t, e2eharness.SpellCharge, kolo, 12*time.Second)
	if err != nil {
		e2eharness.Assertf(t, "Charge cast result timeout: %v", err)
	} else if res == nil || !res.Success {
		e2eharness.Assertf(t, "Charge fail reason=%s", e2eharness.SpellFailReasonName(res.FailReason))
	}
	deadline := time.Now().Add(1500 * time.Millisecond)
	for time.Now().Before(deadline) {
		x, y, z, _ := bot.Pos()
		if e2eharness.Distance3D(preX, preY, preZ, x, y, z) > 1.0 {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	x, y, z, m := bot.Pos()
	if z < preZ-20 {
		e2eharness.Assertf(t, "Charge landed below bridge: z=%.1f preZ=%.1f pos=(%.1f,%.1f) map=%d", z, preZ, x, y, m)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Kologarn charge path map=%d pos=(%.1f,%.1f,%.1f)", m, x, y, z)
}
*/

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27556
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27557
// Kologarn created while BOSS_KOLOGARN is already DONE must come up as a
// stationary corpse (the instance reload branch), not fall into the pit again.
// The boss state is set before his grid loads, so OnCreatureCreate runs the
// DONE branch on a fresh instance without waiting for an instance unload.
// He loads alive here and is flipped to a corpse, unlike a lockout reload where
// he loads dead, so the arms stay seated; that does not affect the assertions.
// Oracle is `.npc info` (server-side health, flags, position): the harness
// misparses this create packet (vehicle block + spline), so the object cache
// cannot be trusted for it.
func TestAC_27556_KologarnReloadedAsStationaryCorpse(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue"},
		Runtime:  "med",
		Issue:    27556,
		Category: "instances/northrend/ulduar",
	})

	const (
		bossKologarn          = 5 // ulduar.h BOSS_KOLOGARN
		encounterDone         = 3 // EncounterState DONE
		spawnZ                = 448.741
		unitFlagNotSelectable = uint32(0x02000000)
	)
	posBridge := e2eharness.Position3{X: 1782.15, Y: -24.4027, Z: spawnZ, Map: e2eharness.MapUlduar}
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldKol",
		Level:  80,
	})

	// Enter far from Kologarn so his grid is not loaded when the state is set.
	bot.TeleNamed(t, "UlduarInstance")
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after .tele UlduarInstance (map=%d)", m)
	}
	if bot.FindUnit(e2eharness.CreatureKologarn, 0) != 0 {
		e2eharness.Preconditionf(t, "Kologarn already tracked before the boss state was set")
	}
	bot.GM(t, fmt.Sprintf(".instance setbossstate %d %d", bossKologarn, encounterDone))
	bot.FlushWorld(t)

	bot.Teleport(t, posBridge.X, posBridge.Y, posBridge.Z, posBridge.Map)
	kolo := bot.WaitUnit(t, e2eharness.CreatureKologarn, 30*time.Second)

	// A MoveFall launched at creation needs a moment to move the server-side
	// position before .npc info reports it.
	time.Sleep(3 * time.Second)
	if err := bot.World.SetTarget(kolo); err != nil {
		e2eharness.Preconditionf(t, "SetTarget Kologarn: %v", err)
	}
	info := strings.Join(gmSystemMessages(t, bot, ".npc info"), "\n")

	hp := matchUint(t, info, `\(current\): (\d+)\.`, "health")
	flags := matchUint(t, info, `Unit Flags: (\d+)\.`, "unit flags")
	z := matchFloat(t, info, `Position: \S+ \S+ (\S+)\.`, "position Z")

	if hp != 0 {
		e2eharness.Assertf(t, "Kologarn created with hp=%d, want 0 (corpse)", hp)
	}
	if math.Abs(z-spawnZ) > 2.0 {
		e2eharness.Assertf(t, "Kologarn corpse Z=%.2f, want spawn Z %.2f (fell, issue #27556)", z, spawnZ)
	}
	if flags&unitFlagNotSelectable == 0 {
		e2eharness.Assertf(t, "Kologarn corpse missing UNIT_FLAG_NOT_SELECTABLE (flags=0x%X)", flags)
	}

	bot.AssertWorldAlive(t)
	t.Logf("PASS AC#27556 Kologarn came up as a stationary corpse (z=%.2f flags=0x%X)", z, flags)
}

// gmSystemMessages runs a GM command and returns the CHAT_MSG_SYSTEM lines it
// produced. The trailing FlushWorld (.gps) guarantees the command output has
// arrived; its own reply is included and harmless.
func gmSystemMessages(t *testing.T, bot *e2eharness.ScenarioBot, cmd string) []string {
	t.Helper()
	var mu sync.Mutex
	var msgs []string
	cancel := bot.World.AddPacketHook(func(op uint16, data []byte) {
		// type u8, lang u32, sender u64, unk u32, target u64, len u32, text
		if op != client.SmsgMessageChat || len(data) < 29 || data[0] != 0x00 { // CHAT_MSG_SYSTEM
			return
		}
		n := int(binary.LittleEndian.Uint32(data[25:29]))
		if n <= 0 || 29+n > len(data) {
			return
		}
		mu.Lock()
		msgs = append(msgs, strings.TrimRight(string(data[29:29+n]), "\x00"))
		mu.Unlock()
	})
	defer cancel()
	bot.GM(t, cmd)
	bot.FlushWorld(t)
	mu.Lock()
	defer mu.Unlock()
	return append([]string(nil), msgs...)
}

func matchUint(t *testing.T, text, pattern, what string) uint32 {
	t.Helper()
	m := regexp.MustCompile(pattern).FindStringSubmatch(text)
	if m == nil {
		e2eharness.Preconditionf(t, "%s not found in .npc info output:\n%s", what, text)
	}
	v, err := strconv.ParseUint(m[1], 10, 32)
	if err != nil {
		e2eharness.Preconditionf(t, "%s %q: %v", what, m[1], err)
	}
	return uint32(v)
}

func matchFloat(t *testing.T, text, pattern, what string) float64 {
	t.Helper()
	m := regexp.MustCompile(pattern).FindStringSubmatch(text)
	if m == nil {
		e2eharness.Preconditionf(t, "%s not found in .npc info output:\n%s", what, text)
	}
	v, err := strconv.ParseFloat(m[1], 64)
	if err != nil {
		e2eharness.Preconditionf(t, "%s %q: %v", what, m[1], err)
	}
	return v
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27095
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27113
// Killing an older Allies of Nature set must not accelerate the next wave
// (only the current set's death reschedules EVENT_FREYA_ADDS_SPAM to 5s).
func TestAC_27095_FreyaAlliesSpawnRateReduction(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "issue"},
		Runtime:  "long",
		Issue:    27095,
		Category: "instances/northrend/ulduar",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Freya",
		Level:  80,
	})
	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).

	const (
		npcFreya10          = uint32(32906)
		npcFreya25          = uint32(33360)
		npcStormLasher      = uint32(32919)
		npcWaterSpirit      = uint32(33202)
		npcSnaplasher       = uint32(32916)
		npcConservator      = uint32(33203)
		npcDetonatingLasher = uint32(32918)
	)
	allyEntries := []uint32{
		npcStormLasher, npcWaterSpirit, npcSnaplasher,
		npcConservator, npcDetonatingLasher,
	}
	kindName := map[uint32]string{
		npcStormLasher: "Trio", npcWaterSpirit: "Trio", npcSnaplasher: "Trio",
		npcConservator: "Conservator", npcDetonatingLasher: "Lashers",
	}
	label := func(entry uint32) string {
		if n, ok := kindName[entry]; ok {
			return n
		}
		return "Unknown"
	}

	// Raid interior pad (game_tele BossFreya). .go xyz is reliable; a missing
	// custom "Freya" name hangs TeleNamed for 60s.
	bot.Teleport(t, 2326.82, -48.131, 424.963, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after Freya pad tele map=%d", m)
	}
	bot.GoCreatureID(t, npcFreya10)
	// Now drop GM. FlushWorld/.gps beside Freya can evade her out of cache,
	// so re-acquire a living GUID before Engage/FaceUnit.
	bot.CombatReady(t)

	// Evade can leave a 0 HP object in cache. Re-poll until we have a living
	// Freya, not only when the GUID disappears.
	var freyaGUID uint64
	deadline := time.Now().Add(30 * time.Second)
	for {
		freyaGUID = bot.WaitUnitAny(t, 10*time.Second, npcFreya10, npcFreya25)
		if hp, maxHP := bot.UnitHP(freyaGUID); maxHP > 0 && hp > 0 {
			if bot.World.GetObject(freyaGUID) != nil {
				break
			}
		}
		if !time.Now().Before(deadline) {
			e2eharness.Preconditionf(t, "no living Freya in cache after GoCreatureID (last=0x%X)", freyaGUID)
		}
		time.Sleep(50 * time.Millisecond)
	}
	bot.Engage(t, freyaGUID, 15*time.Second)

	tr := e2eharness.NewSpawnSetTracker(allyEntries, 3*time.Second)
	tr.KindOf = func(entry uint32) string { return label(entry) }
	// Waves are ~60s apart. 90s covers two waves; 4m just delayed a miss.
	sets := tr.WaitSets(t, bot.World, 2, 90*time.Second)
	t.Logf("Set1=%s units=%d  Set2=%s units=%d  gap=%s",
		sets[0].Kind, len(sets[0].Guids),
		sets[1].Kind, len(sets[1].Guids),
		sets[1].SpawnT.Sub(sets[0].SpawnT).Round(time.Millisecond))

	// Detonating Lashers explode on death — if Set1 is Lashers, wait for Set3
	// and kill Set2 (still: older set while a newer set is up).
	if sets[0].Kind == "Lashers" {
		sets = tr.WaitSets(t, bot.World, 3, 150*time.Second)
	}

	var older, newer e2eharness.SpawnSet
	if sets[0].Kind == "Lashers" {
		older, newer = sets[1], sets[2]
	} else {
		older, newer = sets[0], sets[1]
	}
	if older.Kind == "Lashers" {
		e2eharness.Preconditionf(t, "cannot find a non-Lasher older set to kill without collateral explosions")
	}

	tr.Poll(bot.World, time.Now())

	var olderLive []uint64
	for _, g := range older.Guids {
		if hp, _ := bot.UnitHP(g); hp > 0 {
			olderLive = append(olderLive, g)
		}
	}
	if len(olderLive) == 0 {
		switch older.Kind {
		case "Trio":
			olderLive = e2eharness.LivingByEntries(bot.World, 120, npcStormLasher, npcWaterSpirit, npcSnaplasher)
		case "Conservator":
			olderLive = e2eharness.LivingByEntries(bot.World, 120, npcConservator)
		default:
			olderLive = e2eharness.LivingByEntries(bot.World, 120, older.Entry)
		}
	}
	var newerEntries []uint32
	switch newer.Kind {
	case "Trio":
		newerEntries = []uint32{npcStormLasher, npcWaterSpirit, npcSnaplasher}
	case "Conservator":
		newerEntries = []uint32{npcConservator}
	case "Lashers":
		newerEntries = []uint32{npcDetonatingLasher}
	default:
		newerEntries = []uint32{newer.Entry}
	}
	newerN, _ := e2eharness.CountLivingWithRetry(bot.World, 120, newerEntries, 2*time.Second)
	if len(olderLive) == 0 {
		e2eharness.Preconditionf(t, "older set (%s) already dead before damage step", older.Kind)
	}
	if newerN == 0 {
		e2eharness.Preconditionf(t, "newer set (%s) already dead before damage step", newer.Kind)
	}

	bot.DamageKill(t, olderLive, 10_000_000, 10*time.Second)
	killT := time.Now()

	knownAtKill := tr.Known()
	for _, s := range bot.UnitsByEntry(120, allyEntries...) {
		knownAtKill[s.GUID] = struct{}{}
	}
	fresh := bot.WaitNewUnits(t, knownAtKill, allyEntries, 75*time.Second)
	if len(fresh) == 0 {
		e2eharness.Preconditionf(t, "no new ally set spawned within 75s after older-set kill")
	}
	nextT := time.Now()
	fromNewer := nextT.Sub(newer.SpawnT)
	fromKill := nextT.Sub(killT)
	t.Logf("next set=%s units=%d  (Δ from newer spawn=%s, Δ from older kill=%s)",
		label(fresh[0].Entry), len(fresh),
		fromNewer.Round(time.Millisecond), fromKill.Round(time.Millisecond))

	e2eharness.AssertIntervalNotAccelerated(t, 27095, fromKill, fromNewer, e2eharness.IntervalBugOpts{
		MaxFromEvent:    20 * time.Second,
		MaxFromBaseline: 45 * time.Second,
	})
	t.Logf("PASS AC#27095 next set not accelerated by killing older set")
}

// ULDUAR-03: Ulduar map enter via named tele stays in-world.
func TestUlduar_NamedTeleEnter(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "UldEnt",
		Level:  80,
	})
	// Stock game_tele "Ulduar" is Storm Peaks entrance (map 571), not raid 603.
	bot.TeleNamed(t, "Ulduar")
	bot.AssertWorldAlive(t)
	_, _, _, m := bot.Pos()
	if m != e2eharness.MapNorthrend {
		e2eharness.Assertf(t, "TeleNamed Ulduar map=%d want Northrend %d", m, e2eharness.MapNorthrend)
	}
	t.Logf("PASS Ulduar named tele map=%d (Storm Peaks entrance)", m)
}

// ULDUAR-04: engage + DamageKill path on a trash/dummy (raid helper training).
// L1 Target Dummy (2673) is oneshot by L80 before combat flag — use HeroicTrainingDummy.
func TestUlduar_DamageKillPathSafe(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "UldDmg",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	dummy := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	bot.CombatReady(t)
	bot.Engage(t, dummy, 20*time.Second)
	bot.DamageKill(t, []uint64{dummy}, 50_000_000, 20*time.Second)
	hp, _ := bot.UnitHP(dummy)
	if hp > 0 {
		e2eharness.Assertf(t, "dummy 0x%X still alive hp=%d after DamageKill", dummy, hp)
	}
	t.Logf("PASS DamageKill path dummy=0x%X dead", dummy)
}

// ULDUAR-05: dual-bot login near Freya does not thrash auth.
func TestUlduar_MultiBotLoginNearBossPad(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instances", "multi_bot"}, Runtime: "med", Category: "instances/northrend/ulduar"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "UldDuo",
		Count:  2,
		Level:  80,
	})
	for _, b := range bots {
		b.Teleport(t, 2326.82, -48.131, 424.963, e2eharness.MapUlduar)
	}
	_, _, _, m0 := bots[0].Pos()
	_, _, _, m1 := bots[1].Pos()
	if m0 != e2eharness.MapUlduar || m1 != e2eharness.MapUlduar {
		e2eharness.Assertf(t, "Freya pad maps leader=%d mate=%d want %d", m0, m1, e2eharness.MapUlduar)
	}
	t.Logf("PASS multi-bot Freya pad login n=%d map=%d", len(bots), m0)
}
