//go:build e2e

package ulduar_test

import (
	"encoding/binary"
	"fmt"
	"math"
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

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27602
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27614
// A Laughing Skull's Lunatic Gaze (64168) must not reach a player behind the brain
// room's geometry. 64168 has no ignore-LoS attribute of its own; it used to inherit
// one from the aura that triggers it (64167), so the skulls drained sanity through
// walls. The clear-line half runs first and is the fixture check: without sanity
// loss there, the blocked half proves nothing.
func TestAC_27602_LaughingSkullGazeLoS(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue"},
		Runtime:  "med",
		Issue:    27602,
		Category: "instances/northrend/ulduar",
	})

	const (
		npcLaughingSkull = uint32(33990)
		spellSanity      = uint32(63050)

		// Icecrown illusion chamber floor. The pair sits 18 yd either side of the
		// skull: due west is open, due east is behind structure (verified in-world
		// with a LoS-respecting player cast at 12, 18 and 24 yd).
		skullX, skullY, skullZ = float32(1930.0), float32(-120.0), float32(240.07)
		clearX, clearY         = float32(1912.0), float32(-120.0)
		blockedX, blockedY     = float32(1948.0), float32(-120.0)

		// 64167 ticks every second for 2 sanity; 8s leaves margin for spawn settle.
		gazeWindow = 8 * time.Second
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "YoggLo", Race: e2eharness.RaceHuman, Level: 80,
	})

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	bot.Teleport(t, skullX, skullY, skullZ, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after brain room tele map=%d", m)
	}
	// The skulls are SummonCreature'd by the Brain AI, not by a spell, so a GM spawn
	// is the fixture rather than a stand-in for a summon path. 64167 rides on
	// creature_template_addon, so the spawn gazes on its own with no AI to drive.
	skull := bot.Spawn(t, npcLaughingSkull, 30*time.Second)

	// Drop GM so the gaze can select the bot; god mode absorbs the 1749/s it deals.
	bot.CombatReady(t)
	bot.CheatGod(t)

	// Sanity carries AURA_INTERRUPT_FLAG_CHANGE_MAP, so apply it after the tele.
	sanityLost := func(label string, px, py float32) int {
		bot.Teleport(t, px, py, skullZ, e2eharness.MapUlduar)
		bot.WaitUnitGUID(t, skull, 15*time.Second) // tele clears the object cache
		bot.Face(t, skull)                         // 64168 only takes targets facing the caster
		bot.ApplyAura(t, spellSanity)
		before := bot.AuraStacks(spellSanity)
		if before == 0 {
			e2eharness.Preconditionf(t, "%s: Sanity 63050 did not apply", label)
		}
		time.Sleep(gazeWindow)
		after := bot.AuraStacks(spellSanity)
		bot.CancelAura(t, spellSanity)
		t.Logf("%s pos=(%.1f,%.1f) skull=0x%X sanity %d -> %d", label, px, py, skull, before, after)
		return before - after
	}

	clearLoss := sanityLost("CLEAR", clearX, clearY)
	if clearLoss <= 0 {
		e2eharness.Preconditionf(t, "fixture dead: skull 0x%X drained no sanity with a clear line", skull)
	}
	blockedLoss := sanityLost("BLOCKED", blockedX, blockedY)
	if blockedLoss > 0 {
		e2eharness.ConfirmedBugf(t, 27602,
			"Lunatic Gaze drained %d sanity through the brain room geometry (clear line drained %d)",
			blockedLoss, clearLoss)
	}
	t.Logf("PASS Lunatic Gaze LoS: clear drained %d, blocked drained %d", clearLoss, blockedLoss)
}

const (
	npcElderBrightleaf = uint32(32915)
	npcUnstableSunBeam = uint32(33050)
	// Freya's hard-mode activation banishes each living elder and takes the beams over herself,
	// summoning 33170 instead. Brightleaf then schedules nothing, so name that state if the wave
	// never arrives rather than reporting a bare timeout.
	npcFreyaSunBeam        = uint32(33170)
	spellPurpleBanish      = uint32(61014)
	spellBrightleafEssence = uint32(62485)
	spellDrainedOfPower    = uint32(62467)
	beamSearchRange        = float32(150)
)

// Elder Brightleaf's own spawn. Not the BossFreya pad: that pad sits 12y from Freya, and aggroing
// her banishes every living elder, after which he schedules no beams for the life of the instance.
var brightleafSpawn = e2eharness.Position3{X: 2385.09, Y: 131.341, Z: 440.201, Map: e2eharness.MapUlduar}

// Elder Brightleaf's Unstable Sun Beams must not outlive him, and each wave must land one beam on
// the elder plus one under a player in range. Before the fix the beams were hand-summoned with no
// duration and the elder's event map was the only thing that removed them, so a kill taken with a
// wave up left them standing for the life of the instance.
// Issue: https://github.com/chromiecraft/chromiecraft/issues/10163
func TestUlduar_BrightleafSunBeamsDespawnAfterDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/ulduar",
	})

	const (
		// Each beam despawns itself after a randomised 18-25s; the oracle allows the worst case
		// plus slack for the kill and the object-cache round trip. Do not widen it past 30s: that
		// is 62221's summon duration, the engine backstop that would despawn the player's beam by
		// itself and hide the regression this guards.
		beamMaxLifetime = 25 * time.Second
		// The elder's own beam sits on him, so "landed on the player" is only distinguishable
		// from "stacked on the elder" while the bot stands clear of him by more than this.
		beamOnPlayerRange = float32(3)
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Bleaf",
		Level:  80,
	})

	// Stay GM through the raid enter.
	bot.TeleportPad(t, brightleafSpawn)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after Brightleaf tele map=%d", m)
	}
	bot.GoCreatureID(t, npcElderBrightleaf)
	bot.CombatReady(t)

	elder := waitLivingBrightleaf(t, bot)
	bot.Engage(t, elder, 15*time.Second)

	wave := waitBrightleafWave(t, bot, elder)
	bx, by, bz, _ := bot.Pos()
	elderObj := bot.World.GetObject(elder)
	if elderObj == nil {
		e2eharness.Preconditionf(t, "Elder Brightleaf 0x%X left the object cache before the wave landed", elder)
	}
	ex, ey, ez := elderObj.PosX, elderObj.PosY, elderObj.PosZ
	if botToElder := e2eharness.Distance3D(bx, by, bz, ex, ey, ez); botToElder <= beamOnPlayerRange {
		e2eharness.Preconditionf(t, "bot stands %.1fy from the elder, too close for the placement oracle to discriminate (need > %.1fy)",
			botToElder, beamOnPlayerRange)
	}
	nearestToBot := float32(math.MaxFloat32)
	for _, b := range wave {
		toBot := e2eharness.Distance3D(bx, by, bz, b.x, b.y, b.z)
		if toBot < nearestToBot {
			nearestToBot = toBot
		}
		t.Logf("beam 0x%X at (%.1f,%.1f,%.1f) dist bot=%.1f elder=%.1f", b.guid, b.x, b.y, b.z,
			toBot, e2eharness.Distance3D(ex, ey, ez, b.x, b.y, b.z))
	}
	// 62207 summons one beam at the elder and force-casts 62221 on the players its script picks,
	// each summoning one at their own feet. A forced cast whose target mask takes no unit target
	// must not inherit the original caster as its destination, or every beam stacks on the elder.
	if nearestToBot > beamOnPlayerRange {
		e2eharness.Assertf(t, "no Unstable Sun Beam landed on the player: nearest of %d beams is %.1fy away",
			len(wave), nearestToBot)
	}

	// Kill him with the wave still up — that is the state that used to leak.
	bot.DamageKill(t, []uint64{elder}, 10_000_000, 30*time.Second)
	killT := time.Now()

	cutoff := killT.Add(beamMaxLifetime + 15*time.Second)
	for {
		left := sunBeamsInCache(bot, npcUnstableSunBeam, beamSearchRange)
		if len(left) == 0 {
			break
		}
		if !time.Now().Before(cutoff) {
			e2eharness.Assertf(t, "%d Unstable Sun Beam(s) still up %s after Elder Brightleaf died: %v",
				len(left), time.Since(killT).Round(time.Second), sunBeamGUIDs(left))
		}
		time.Sleep(500 * time.Millisecond)
	}
	t.Logf("PASS %d sun beams all gone %s after Elder Brightleaf died",
		len(wave), time.Since(killT).Round(time.Millisecond))
}

type sunBeamSnap struct {
	guid    uint64
	x, y, z float32
}

// sunBeamsInCache reports beams by presence, not liveness: the bug is the object still existing.
// unitFlags reads UNIT_FIELD_FLAGS off a unit in the object cache.
func unitFlags(bot *e2eharness.ScenarioBot, guid uint64) uint32 {
	obj := bot.World.GetObject(guid)
	if obj == nil {
		return 0
	}
	return obj.Value(client.UnitFieldFlags)
}

// elderNotSelectable reports the flag boss_freya_elder_brightleaf::JustEngagedWith gates on.
func elderNotSelectable(bot *e2eharness.ScenarioBot, guid uint64) bool {
	return unitFlags(bot, guid)&client.UnitFlagNotSelectable != 0
}

func sunBeamsInCache(bot *e2eharness.ScenarioBot, entry uint32, maxDist float32) []sunBeamSnap {
	var out []sunBeamSnap
	for _, u := range bot.World.GetNearbyUnits(maxDist) {
		if u.Entry != entry {
			continue
		}
		out = append(out, sunBeamSnap{guid: u.GUID, x: u.PosX, y: u.PosY, z: u.PosZ})
	}
	return out
}

func sunBeamGUIDs(beams []sunBeamSnap) []string {
	out := make([]string, len(beams))
	for i, b := range beams {
		out[i] = fmt.Sprintf("0x%X", b.guid)
	}
	return out
}

// waitLivingBrightleaf returns the elder from the bot's object cache once he is alive and able to
// schedule beams. Evade beside him can leave a 0 HP object behind, so re-poll rather than trust the
// first hit.
func waitLivingBrightleaf(t *testing.T, bot *e2eharness.ScenarioBot) uint64 {
	t.Helper()
	var elder uint64
	deadline := time.Now().Add(30 * time.Second)
	for {
		elder = bot.WaitUnit(t, npcElderBrightleaf, 10*time.Second)
		if hp, maxHP := bot.UnitHP(elder); maxHP > 0 && hp > 0 && bot.World.GetObject(elder) != nil {
			break
		}
		if !time.Now().Before(deadline) {
			e2eharness.Preconditionf(t, "no living Elder Brightleaf in cache after GoCreatureID (last=0x%X)", elder)
		}
		time.Sleep(50 * time.Millisecond)
	}
	if bot.UnitHasAura(elder, spellPurpleBanish) || bot.UnitHasAura(elder, spellBrightleafEssence) {
		e2eharness.Preconditionf(t, "Elder Brightleaf is banished into Freya's hard mode in this instance, so he schedules no sun beams")
	}

	// Freya's hard-mode activation full-heals every living elder, flags it
	// UNIT_FLAG_NOT_SELECTABLE, turns it REACT_PASSIVE and puts it in combat with the zone.
	// Either leftover suppresses the beams: boss_freya_elder_brightleaf::JustEngagedWith returns
	// on that flag without scheduling anything, and an elder still in combat never gets a second
	// JustEngagedWith when this bot pulls it. The banish auras applied alongside are dropped when
	// Freya resets, so the aura checks above see a healthy elder either way. Killing it and
	// respawning runs the Reset that clears both.
	if elderNotSelectable(bot, elder) || bot.UnitInCombat(elder) {
		t.Logf("Elder Brightleaf is left over from a Freya pull in this instance (flags=0x%X inCombat=%v); respawning him",
			unitFlags(bot, elder), bot.UnitInCombat(elder))
		bot.DamageKill(t, []uint64{elder}, 10_000_000, 15*time.Second)
		if err := bot.World.SetTarget(elder); err != nil {
			e2eharness.Preconditionf(t, "select Elder Brightleaf to respawn: %v", err)
		}
		bot.GM(t, ".respawn")
		respawned := time.Now().Add(30 * time.Second)
		for {
			elder = bot.WaitUnit(t, npcElderBrightleaf, 10*time.Second)
			if hp, maxHP := bot.UnitHP(elder); maxHP > 0 && hp > 0 && !elderNotSelectable(bot, elder) && !bot.UnitInCombat(elder) {
				break
			}
			if !time.Now().Before(respawned) {
				e2eharness.Preconditionf(t, "Elder Brightleaf still unpullable after respawn (flags=0x%X inCombat=%v), so he schedules no sun beams",
					unitFlags(bot, elder), bot.UnitInCombat(elder))
			}
			time.Sleep(250 * time.Millisecond)
		}
	}
	return elder
}

// waitBrightleafWave returns the first Unstable Sun Beam wave after the pull, settled so neither a
// count nor a placement check is judged on whichever summon reached the cache first. The first wave
// lands ~6s after the pull and the next is 22-26s behind it, which is what keeps the settle window
// from folding two waves into one measurement.
func waitBrightleafWave(t *testing.T, bot *e2eharness.ScenarioBot, elder uint64) []sunBeamSnap {
	t.Helper()
	var wave []sunBeamSnap
	deadline := time.Now().Add(70 * time.Second)
	for {
		if wave = sunBeamsInCache(bot, npcUnstableSunBeam, beamSearchRange); len(wave) > 0 {
			break
		}
		if !time.Now().Before(deadline) {
			hp, maxHP := bot.UnitHP(elder)
			t.Logf("no wave: elder hp=%d/%d flags=0x%X inCombat=%v banished=%v essence=%v drained=%v 33050@500y=%d 33170@500y=%d",
				hp, maxHP,
				unitFlags(bot, elder),
				bot.UnitInCombat(elder),
				bot.UnitHasAura(elder, spellPurpleBanish),
				bot.UnitHasAura(elder, spellBrightleafEssence),
				bot.UnitHasAura(elder, spellDrainedOfPower),
				len(sunBeamsInCache(bot, npcUnstableSunBeam, 500)),
				len(sunBeamsInCache(bot, npcFreyaSunBeam, 500)))
			e2eharness.Preconditionf(t, "no Unstable Sun Beam spawned within 70s of engaging Elder Brightleaf")
		}
		time.Sleep(250 * time.Millisecond)
	}
	for settle := time.Now().Add(5 * time.Second); time.Now().Before(settle); {
		time.Sleep(500 * time.Millisecond)
		grown := sunBeamsInCache(bot, npcUnstableSunBeam, beamSearchRange)
		if len(grown) <= len(wave) {
			break
		}
		wave = grown
	}
	return wave
}

// One Unstable Sun Beam wave must stay capped however many players stand under the elder. 62207
// summons one beam at his feet and force-casts 62221 on every enemy player inside 100y, and that
// effect carries no MaxAffectedTargets, so an uncapped core gives a 25-man raid 26 beams a cast.
// Reported as https://github.com/chromiecraft/chromiecraft/issues/10177
func TestUlduar_BrightleafSunBeamsCappedPerWave(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "multi_bot"},
		Runtime:  "med",
		Category: "instances/northrend/ulduar",
	})

	const (
		botCount = 3
		// A party enters Ulduar at 10-man normal, where the script picks 1 player, and effect 0
		// adds the elder's own beam on top. Three players in range is what makes the cap
		// measurable: uncapped this wave is botCount+1 beams, capped it is 2.
		wantMaxBeamsPerWave = 2
		// 62207's force-cast radius. A bot outside it is not a candidate, which would shrink the
		// wave for the wrong reason and leave the oracle proving nothing.
		beamCastRange = float32(100)
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "BlfCap",
		Count:  botCount,
		Level:  80,
	})
	leader, mates := bots[0], bots[1:]
	e2eharness.FormParty(t, leader, mates...)

	// Stay GM through the raid enter and the summons.
	leader.TeleportPad(t, brightleafSpawn)
	if _, _, _, m := leader.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "leader not in Ulduar after Brightleaf tele map=%d", m)
	}
	leader.GoCreatureID(t, npcElderBrightleaf)

	// A plain tele would hand each mate its own instance copy. `.summon` pulls them into the
	// leader's, which is the only way three players end up facing one elder.
	leaderGUID := leader.World.CharGUID()
	for _, mate := range mates {
		before := mate.World.TeleportSeq()
		leader.GM(t, ".summon "+mate.Name)
		if err := mate.World.WaitForTeleportAfter(before, 15*time.Second); err != nil {
			e2eharness.Preconditionf(t, "%s .summon into Ulduar: %v", mate.Name, err)
		}
		if _, _, _, m := mate.Pos(); m != e2eharness.MapUlduar {
			e2eharness.Preconditionf(t, "%s not in Ulduar after .summon (map=%d)", mate.Name, m)
		}
		// Seeing the leader's own GUID is the co-location proof: creature GUIDs repeat across
		// instance copies, player GUIDs do not.
		colocated := time.Now().Add(15 * time.Second)
		for mate.World.GetObject(leaderGUID) == nil {
			if !time.Now().Before(colocated) {
				e2eharness.Preconditionf(t, "%s never saw the leader after .summon: separate instance copies", mate.Name)
			}
			time.Sleep(100 * time.Millisecond)
		}
	}

	// GM mode keeps a player off a creature's hostile target list, so a mate left in GM would be
	// skipped by the force-cast and the wave would look capped on an uncapped core.
	for _, b := range bots {
		b.CombatReady(t)
	}

	elder := waitLivingBrightleaf(t, leader)
	elderObj := leader.World.GetObject(elder)
	if elderObj == nil {
		e2eharness.Preconditionf(t, "Elder Brightleaf 0x%X left the object cache before the pull", elder)
	}
	for _, b := range bots {
		x, y, z, _ := b.Pos()
		if d := e2eharness.Distance3D(x, y, z, elderObj.PosX, elderObj.PosY, elderObj.PosZ); d > beamCastRange {
			e2eharness.Preconditionf(t, "%s stands %.1fy from the elder, outside 62207's %.0fy radius",
				b.Name, d, beamCastRange)
		}
	}
	leader.Engage(t, elder, 15*time.Second)

	wave := waitBrightleafWave(t, leader, elder)
	for _, b := range wave {
		t.Logf("beam 0x%X at (%.1f,%.1f,%.1f) dist elder=%.1f", b.guid, b.x, b.y, b.z,
			e2eharness.Distance3D(elderObj.PosX, elderObj.PosY, elderObj.PosZ, b.x, b.y, b.z))
	}
	if len(wave) > wantMaxBeamsPerWave {
		e2eharness.Assertf(t, "one Unstable Sun Beam wave placed %d beams with %d players in range, want at most %d: %v",
			len(wave), botCount, wantMaxBeamsPerWave, sunBeamGUIDs(wave))
	}
	t.Logf("PASS %d sun beam(s) in one wave with %d players in range", len(wave), botCount)
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27590
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27628
// Psychosis (63795) and Malady of the Mind (63830) must skip players sitting at 40 Sanity
// or less. Both pick a random enemy through TARGET_UNIT_SRC_AREA_ENEMY over a 50000 yd
// radius and AzerothCore never filtered that list, so the players closest to going insane
// kept being the ones picked.
//
// Sara is faction 35 and can never own an enemy list, so she cannot be the fixture caster.
// A Laughing Skull is the stand-in: faction 14, NullCreatureAI, no threat list, and the
// Lunatic Gaze test above already proves its spells select the bot as an enemy. Its own
// gaze is stripped first, otherwise the 2 sanity a second it drains drowns the oracle.
func TestAC_27590_PsychosisSkipsLowSanity(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue"},
		Runtime:  "med",
		Issue:    27590,
		Category: "instances/northrend/ulduar",
	})

	const (
		npcLaughingSkull = uint32(33990)
		spellSanity      = uint32(63050)
		spellSanityWell  = uint32(64169)
		spellLunaticGaze = uint32(64167)
		spellPsychosis   = uint32(63795)
		spellMalady      = uint32(63830)

		// Icecrown illusion chamber floor, the pad the Lunatic Gaze test spawns on.
		padX, padY, padZ = float32(1930.0), float32(-120.0), float32(240.07)

		// Threshold from the 2009-07-02 hotfix: at or below it neither spell may pick the player.
		sanityFloor = 40

		// Where the walk down starts. A Sanity Well tops up in steps of 20 from the single
		// stack `.aura` creates, so 1 -> 21 -> 41 -> 61 lands here and Psychosis then steps
		// 61 -> 52 -> 43 -> 34, straddling the threshold without overshooting it far.
		sanityStart = 60

		// 63795 is a 2.9s cast and target selection only runs once it completes. A cast that
		// finds nobody expires quietly, so the no-drain half has to burn the whole window.
		castWindow = 8 * time.Second

		// Well ticks every 2s; this only has to outlast the three steps up to sanityStart.
		rampWindow = 20 * time.Second

		// Enough steps to walk sanityStart down past the threshold at 9 a hit, with room to spare.
		maxPsychosisCasts = 20
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "YoggPs", Race: e2eharness.RaceHuman, Level: 80,
	})

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	bot.Teleport(t, padX, padY, padZ, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after brain room tele map=%d", m)
	}
	skull := bot.Spawn(t, npcLaughingSkull, 30*time.Second)

	// GM casts and aura edits both act on the current selection, so every one of them says
	// out loud which unit it means.
	selectUnit := func(label string, guid uint64) {
		t.Helper()
		if err := bot.World.SetTarget(guid); err != nil {
			e2eharness.Preconditionf(t, "select %s 0x%X: %v", label, guid, err)
		}
	}
	selectSkull := func() { t.Helper(); selectUnit("skull", skull) }
	selectSelf := func() { t.Helper(); selectUnit("self", bot.World.CharGUID()) }

	selectSkull()
	bot.GM(t, fmt.Sprintf(".unaura %d", spellLunaticGaze))

	// Drop GM so the spells can select the bot; god mode absorbs the damage half of Psychosis.
	bot.CombatReady(t)
	bot.CheatGod(t)

	// Sanity carries AURA_INTERRUPT_FLAG_CHANGE_MAP, so apply it after the tele. `.aura`
	// creates it at one stack, which is already under the threshold, so a Sanity Well
	// buff tops it up the same way Freya's wells do in the fight.
	bot.ApplyAura(t, spellSanity)
	bot.ApplyAura(t, spellSanityWell)
	rampDeadline := time.Now().Add(rampWindow)
	for bot.AuraStacks(spellSanity) < sanityStart && time.Now().Before(rampDeadline) {
		time.Sleep(250 * time.Millisecond)
	}
	// CMSG_CANCEL_AURA does not take the well off, so strip it server side.
	selectSelf()
	bot.GM(t, fmt.Sprintf(".unaura %d", spellSanityWell))

	start := bot.AuraStacks(spellSanity)
	if start <= sanityFloor {
		e2eharness.Preconditionf(t, "Sanity ramped to %d stacks, need more than %d to drive the threshold", start, sanityFloor)
	}

	// Every later delta is attributed to the spell under test, so nothing else may be moving
	// sanity now: this catches both a skull that still gazes and a well that never came off.
	time.Sleep(3 * time.Second)
	if quiet := bot.AuraStacks(spellSanity); quiet != start {
		e2eharness.Preconditionf(t, "sanity still moving on its own before the first cast (%d -> %d), skull 0x%X", start, quiet, skull)
	}

	// `.cast self` makes the *selected* unit cast on itself. Psychosis and Malady take their
	// real targets from the area around the caster, which is the same selection path Sara
	// drives in phase 2. Returns the stacks the bot lost, 0 if the cast never reached it.
	castFromSkull := func(spellID uint32) int {
		t.Helper()
		before := bot.AuraStacks(spellSanity)
		selectSkull()
		bot.GM(t, fmt.Sprintf(".cast self %d", spellID))
		deadline := time.Now().Add(castWindow)
		for time.Now().Before(deadline) {
			if now := bot.AuraStacks(spellSanity); now != before {
				return before - now
			}
			time.Sleep(200 * time.Millisecond)
		}
		return 0
	}

	// Fixture check: at full sanity the spell must reach the bot at all. Without this a
	// mis-aimed `.cast self` (it falls back to the caster's own player when nothing is
	// selected) would read as a clean pass on both of the assertions below.
	if lost := castFromSkull(spellMalady); lost <= 0 {
		e2eharness.Preconditionf(t, "fixture dead: Malady of the Mind drained nothing at %d sanity", bot.AuraStacks(spellSanity))
	}

	lastValid := 0
	for i := 0; i < maxPsychosisCasts; i++ {
		before := bot.AuraStacks(spellSanity)
		if before <= sanityFloor {
			break
		}
		lost := castFromSkull(spellPsychosis)
		if lost <= 0 {
			e2eharness.ConfirmedBugf(t, 27590,
				"Psychosis drained nothing at %d sanity, which is above the %d threshold", before, sanityFloor)
		}
		lastValid = before
		t.Logf("Psychosis at %d sanity drained %d -> %d", before, lost, bot.AuraStacks(spellSanity))
	}

	atFloor := bot.AuraStacks(spellSanity)
	if atFloor > sanityFloor {
		e2eharness.Preconditionf(t, "never reached the threshold, stuck at %d sanity after %d casts", atFloor, maxPsychosisCasts)
	}

	if lost := castFromSkull(spellPsychosis); lost > 0 {
		e2eharness.ConfirmedBugf(t, 27590,
			"Psychosis drained %d sanity from a player at %d, at or below the %d threshold", lost, atFloor, sanityFloor)
	}
	atFloor = bot.AuraStacks(spellSanity)
	if lost := castFromSkull(spellMalady); lost > 0 {
		e2eharness.ConfirmedBugf(t, 27590,
			"Malady of the Mind drained %d sanity from a player at %d, at or below the %d threshold", lost, atFloor, sanityFloor)
	}

	t.Logf("PASS low sanity targeting: both spells landed down to %d sanity and neither reached the player at %d", lastValid, atFloor)
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27455
// An Ancient Water Spirit's Tidal Wave (62653, 25-man rank 62935) is a 2s cast that surges the
// spirit forward and knocks everything in its path off its feet with a second spell, 62654
// (25-man 62936). Kicking the cast used to stop the surge and nothing else: the script queued
// that second spell on a standalone 3s EventMap timer started at cast time, so the damage and
// knockback still went out on an empty cast bar.
//
// The oracle is whether the spirit casts 62654 at all, read off SMSG_SPELL_GO. That is the
// mechanism the bug is about, and it holds regardless of who the cone ends up covering. The
// knockback the player actually receives (SMSG_MOVE_KNOCK_BACK, which AC sends to the knocked
// player's own session out of Unit::KnockbackFrom) is logged next to it but is not the oracle:
// it depends on where the bot is standing when the wave goes off, and the harness never acks a
// knockback, which makes repeat knockbacks in one session unreliable.
//
// An uninterrupted wave is measured too. Without it a quiet window after a Kick proves nothing:
// it would pass just as happily against a spirit that never casts anything.
//
// A lone spawned spirit rather than Freya's Allies of Nature waves, because the trio is one of
// three wave kinds picked at random roughly every 60s and a real pull spends minutes rolling
// for the subject. The wave is scheduled from JustEngagedWith and needs nothing from Freya.
func TestAC_27455_TidalWaveInterruptStopsKnockback(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "issue"},
		Runtime:  "med",
		Issue:    27455,
		Category: "instances/northrend/ulduar",
	})

	const (
		npcWaterSpirit = uint32(33202)
		// spelldifficulty_dbc swaps the 10-man ids for the 25-man ones on a 25-man instance.
		spellTidalWave10 = uint32(62653)
		spellTidalWave25 = uint32(62935)
		spellTidalDmg10  = uint32(62654)
		spellTidalDmg25  = uint32(62936)
		spellKick        = uint32(1766)

		// game_tele BossRazorscale, not Freya's platform: the spirit only needs the Ulduar
		// instance script (RegisterUlduarCreatureAI), and this is the emptiest ground in the
		// raid, with nothing spawned inside 100y. Fighting it in the Conservatory pulls Freya
		// herself, and her Allies of Nature then land Conservator's Grip (62532) on the bot,
		// which is pacify-silence and blocks Kick outright.
		padX, padY, padZ = float32(589.2), float32(-145.0), float32(391.5)

		botHealth = 10000000

		// JustEngagedWith schedules the first wave at 12s and repeats on that interval.
		waveWindow = 40 * time.Second
		// 2s cast, then the surge. Everything the cast does has happened inside this.
		resolveWindow = 5 * time.Second
		sampleEvery   = 20 * time.Millisecond
		// Kick is a melee ability and can be dodged or parried, which leaves the cast running.
		// Take the next wave when that happens rather than calling the run unjudgeable.
		kickAttempts = 6
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "TidWav", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassRogue, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	bot.Teleport(t, padX, padY, padZ, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after pad tele map=%d", m)
	}

	spirit := bot.Spawn(t, npcWaterSpirit, 30*time.Second)
	t.Logf("Ancient Water Spirit guid=0x%X", spirit)

	// Only now drop GM: Spawn turns it on for `.npc add` and leaves it on, and the spirit picks
	// its target through SelectTargetFromPlayerList, which skips game masters. Note the bare
	// CombatReady helpers would also turn `.cheat god` on, leaving the bot invulnerable.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{})
	if err := bot.World.SetTarget(bot.World.CharGUID()); err != nil {
		e2eharness.Preconditionf(t, "select self: %v", err)
	}
	bot.GM(t, fmt.Sprintf(".modify hp %d", botHealth))
	// A fresh level-80 character still carries its starting weapon skills, and an unarmed bot
	// misses a level-81 elite with Kick most of the time.
	bot.GM(t, ".maxskill")

	bot.Engage(t, spirit, 15*time.Second)

	var (
		mu        sync.Mutex
		castStart time.Time
		castGo    time.Time
		dmgGo     time.Time
		knockAt   time.Time
	)
	isWave := func(id uint32) bool { return id == spellTidalWave10 || id == spellTidalWave25 }
	isDamage := func(id uint32) bool { return id == spellTidalDmg10 || id == spellTidalDmg25 }
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case client.SmsgSpellStart:
			if id, ok := castSpellID(data); ok && isWave(id) {
				mu.Lock()
				castStart = time.Now()
				mu.Unlock()
			}
		case client.SmsgSpellGo:
			id, ok := castSpellID(data)
			if !ok {
				return
			}
			mu.Lock()
			if isWave(id) {
				castGo = time.Now()
			} else if isDamage(id) {
				dmgGo = time.Now()
			}
			mu.Unlock()
		case client.SmsgMoveKnockBack:
			mu.Lock()
			knockAt = time.Now()
			mu.Unlock()
		}
	})
	defer cancel()

	reset := func() {
		mu.Lock()
		castStart, castGo, dmgGo, knockAt = time.Time{}, time.Time{}, time.Time{}, time.Time{}
		mu.Unlock()
	}
	snapshot := func() (start, done, dmg, knock time.Time) {
		mu.Lock()
		defer mu.Unlock()
		return castStart, castGo, dmgGo, knockAt
	}

	// The creature's combat flag reaches the object cache a beat after Engage, so a spirit that
	// evades is only called out once it has been seen fighting.
	sawCombat := false
	status := func() string {
		hp, _ := bot.UnitHP(spirit)
		self, _ := bot.UnitHP(bot.World.CharGUID())
		return fmt.Sprintf("inCombat=%v target=0x%X spiritHP=%d botHP=%d",
			bot.UnitInCombat(spirit), bot.UnitTarget(spirit), hp, self)
	}
	waitCast := func(what string) {
		deadline := time.Now().Add(waveWindow)
		for time.Now().Before(deadline) {
			if start, _, _, _ := snapshot(); !start.IsZero() {
				return
			}
			if bot.UnitInCombat(spirit) {
				sawCombat = true
			} else if sawCombat {
				e2eharness.Preconditionf(t, "spirit left combat while waiting for the %s wave (%s)", what, status())
			}
			time.Sleep(sampleEvery)
		}
		e2eharness.Preconditionf(t, "no Tidal Wave cast within %s (%s wave, %s)", waveWindow, what, status())
	}

	// Target and facing are settled up front so the only thing between seeing a cast start and
	// the Kick going out is one CMSG_CAST_SPELL.
	if err := bot.World.SetTarget(spirit); err != nil {
		e2eharness.Preconditionf(t, "select spirit: %v", err)
	}
	bot.Face(t, spirit)

	var kickedDmg, kickedKnock, kickedStart time.Time
	interrupted := false
	var lastFail string
	for attempt := 1; attempt <= kickAttempts && !interrupted; attempt++ {
		reset()
		waitCast("interrupted")
		kicked := false
		for deadline := time.Now().Add(1200 * time.Millisecond); time.Now().Before(deadline); {
			// Re-faced every attempt: a wave that went off leaves the spirit 40y past the
			// bot, and Kick on a target behind it is SPELL_FAILED_UNIT_NOT_INFRONT.
			bot.Face(t, spirit)
			res, err := bot.TryCast(t, spellKick, spirit, 500*time.Millisecond)
			if err != nil {
				lastFail = err.Error()
			} else if res.Success {
				kicked = true
				break
			} else {
				lastFail = e2eharness.SpellFailReasonName(res.FailReason)
			}
		}
		if !kicked {
			t.Logf("attempt %d: Kick never went out (%s, casterFlags=0x%X, auras=%v)",
				attempt, lastFail, casterFlags(bot), bot.World.SelfAuras())
			continue
		}
		time.Sleep(resolveWindow)
		start, done, dmg, knock := snapshot()
		if !done.IsZero() {
			// Kick went out but was dodged or parried; the cast ran to completion.
			t.Logf("attempt %d: Kick did not land, wave completed %s after cast start",
				attempt, done.Sub(start).Round(time.Millisecond))
			continue
		}
		interrupted = true
		kickedStart, kickedDmg, kickedKnock = start, dmg, knock
	}
	if !interrupted {
		e2eharness.Preconditionf(t, "no Tidal Wave was interrupted in %d attempts (last Kick result: %s, %s)",
			kickAttempts, lastFail, status())
	}
	t.Logf("kicked wave: damage cast=%v knockback=%v", !kickedDmg.IsZero(), !kickedKnock.IsZero())

	// Control: let the next one through, so the quiet window above means something.
	reset()
	waitCast("uninterrupted")
	time.Sleep(resolveWindow)
	plainStart, plainGo, plainDmg, plainKnock := snapshot()
	if plainGo.IsZero() {
		e2eharness.Preconditionf(t, "Tidal Wave started but never completed without an interrupt")
	}
	if plainDmg.IsZero() {
		e2eharness.Preconditionf(t,
			"an uninterrupted Tidal Wave never cast its damage spell; the interrupt oracle would be vacuous")
	}
	t.Logf("uninterrupted wave: damage cast %s after cast start, knockback=%v",
		plainDmg.Sub(plainStart).Round(time.Millisecond), !plainKnock.IsZero())

	if !kickedDmg.IsZero() {
		e2eharness.ConfirmedBugf(t, 27455,
			"interrupted Tidal Wave still cast its damage and knockback %s after the cast started",
			kickedDmg.Sub(kickedStart).Round(time.Millisecond))
	}
	t.Logf("PASS AC#27455 kicked Tidal Wave cast no damage spell within %s", resolveWindow)
}

// casterFlags reads UNIT_FIELD_FLAGS off the bot, so a refused cast names the state that
// refused it.
func casterFlags(bot *e2eharness.ScenarioBot) uint32 {
	obj := bot.World.GetObject(bot.World.CharGUID())
	if obj == nil {
		return 0
	}
	return obj.Value(client.UnitFieldFlags)
}

// castSpellID pulls the spell id out of an SMSG_SPELL_START / SMSG_SPELL_GO header, which both
// open with the cast-item and caster packed GUIDs and a cast counter ahead of it. The harness
// parses SPELL_GO for its own waiters but exposes neither the header nor a packed-GUID reader.
func castSpellID(data []byte) (uint32, bool) {
	off := 0
	for i := 0; i < 2; i++ {
		if off >= len(data) {
			return 0, false
		}
		mask := data[off]
		off++
		for bit := 0; bit < 8; bit++ {
			if mask&(1<<uint(bit)) != 0 {
				off++
			}
		}
	}
	off++ // cast count
	if off+4 > len(data) {
		return 0, false
	}
	return binary.LittleEndian.Uint32(data[off : off+4]), true
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27539
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/27630
// Big Bang is an 8s cast the raid survives by hiding inside a black hole. When it ends
// Algalon holds still for 3s before he picks the fight back up; AzerothCore resumed melee,
// Quantum Strike and the chase on the very next AI tick instead.
//
// The oracle is the bots' combined health, compared against a running peak because the pool
// regenerates while the fight runs: regeneration only raises the peak, so any decrease at all
// is Algalon landing something. Big Bang
// triggers 64445 on every player for exactly one second at the moment the cast lands, which
// is the protocol-visible marker the window is measured from. Reading the total rather than
// one bot's health keeps a tank swap mid-window from reading as a quiet boss.
//
// Two bots, because a solo one is not enough to hold the encounter up. Phase Punch's 5th
// stack applies 64417, a SPELL_AURA_PHASE that moves its target out of Algalon's phase for
// good (taking 64412 off afterwards does not remove it). With one player that leaves every
// threat reference offline via !CanSeeOrDetect, and Algalon sits flagged in combat unable to
// touch anyone. A second body is what a real raid's tank swap provides.
//
// Living Constellations are killed on sight because their Arcane Barrage is the one other
// thing that can reach a bot inside the window. Collapsing Stars are left alone: all four
// spawn points sit about 20y from where Algalon lands, well clear of a black hole's 6y reach.
func TestAC_27539_AlgalonBigBangStasis(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "issue", "multi_bot"},
		Runtime:  "long",
		Issue:    27539,
		Category: "instances/northrend/ulduar",
	})

	const (
		npcAlgalon             = uint32(32871)
		npcLivingConstellation = uint32(33052)
		// Enough to drop a constellation in one hit.
		constellationHit = uint32(500000)

		goPlanetarium10 = uint32(194628)
		goPlanetarium25 = uint32(194752)
		itemKey10       = uint32(45797)
		itemKey25       = uint32(45798)

		spellPhasePunch = uint32(64412)
		// The 5th Phase Punch stack: SPELL_AURA_PHASE, misc 16, the same phase a black hole
		// puts a player in.
		spellPhasePunchShift = uint32(64417)
		spellRemovePhase     = uint32(64445)

		// Planetarium console, where Brann spawns and the summon roleplay starts.
		consoleX, consoleY, consoleZ = float32(1646.2), float32(-174.7), float32(427.3)
		// Off AlgalonLandPos, where he sets down. Standing on his exact coordinates leaves
		// the facing check no direction and every swing returns SMSG_ATTACKSWING_BAD_FACING.
		landX, landY, landZ = float32(1632.668), float32(-308.5), float32(417.321)

		botHealth = 10000000

		// Brann's walk plus Algalon's descent before EVENT_INTRO_FINISH drops SetImmuneToPC.
		introWindow = 4 * time.Minute
		// 90s fight timer plus the intro delay (26s on a first pull), with slack.
		bigBangWindow = 3 * time.Minute

		// Big Bang's damage and its 64445 marker come out of the same cast; give the health
		// update from that cast time to arrive before the quiet window opens.
		settle = 700 * time.Millisecond
		// The script holds Algalon for 3s, but the server starts counting when it applies
		// 64445 and this window starts when the client *sees* it, so the tail of a full 3s
		// window runs past the moment he is allowed to move again. Stop short of the boundary
		// by enough to cover that lag plus a world tick. A boss that never held still at all
		// lands something around 1s, far inside what is still asserted.
		stasisWindow = 2300 * time.Millisecond
		// Quantum Strike repeats every 3-4.5s and melee is faster, so a boss that resumed
		// lands something well inside this.
		resumeWindow = 10 * time.Second

		sampleEvery = 100 * time.Millisecond
		// Throttle for the sweep that keeps the bots targetable and the field clear.
		sweepEvery = 3 * time.Second
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "AlgBB",
		Bots: []e2eharness.BotSpec{
			{Role: "tank", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "spare", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
		},
	})
	tank := e2eharness.ByRole(t, bots, "tank")
	spare := e2eharness.ByRole(t, bots, "spare")

	// Stay GM through the raid enter (.go xyz onto 603 is ignored after .gm off).
	for _, b := range bots {
		b.Teleport(t, consoleX, consoleY, consoleZ, e2eharness.MapUlduar)
		if _, _, _, m := b.Pos(); m != e2eharness.MapUlduar {
			e2eharness.Preconditionf(t, "%s not in Ulduar after console pad tele map=%d", b.Name, m)
		}
	}

	// The console is a locked goober with one key entry per raid size, and which one spawned
	// depends on the difficulty this instance came up at. Carry both.
	tank.AddItem(t, itemKey10, 1)
	tank.AddItem(t, itemKey25, 1)

	console := e2eharness.TryNearbyGameObjectByEntry(t, tank.World, goPlanetarium10, 15*time.Second)
	if console == 0 {
		console = e2eharness.TryNearbyGameObjectByEntry(t, tank.World, goPlanetarium25, 15*time.Second)
	}
	if console == 0 {
		e2eharness.Preconditionf(t, "no Celestial Planetarium Access console (%d/%d) at the pad", goPlanetarium10, goPlanetarium25)
	}
	tank.GameObjectUse(t, console)

	// Brann walks the intro from the console end of the room; wait it out on the platform
	// Algalon lands on. Instance grids are always loaded, so the roleplay runs regardless.
	tank.Teleport(t, landX, landY, landZ, e2eharness.MapUlduar)
	spare.Teleport(t, landX+4, landY-2, landZ, e2eharness.MapUlduar)
	algalon := tank.WaitUnit(t, npcAlgalon, introWindow)
	t.Logf("Algalon summoned guid=0x%X", algalon)

	// Pulling him mid-roleplay is not the same fight: JustEngagedWith calls events.Reset(),
	// which drops the pending EVENT_INTRO_FINISH that clears SetImmuneToPC, and he then never
	// reaches EVENT_INTRO_TIMER_DONE to turn REACT_AGGRESSIVE. Wait for the flag to clear.
	immune := func() bool {
		o := tank.World.GetObject(algalon)
		return o == nil || o.Value(client.UnitFieldFlags)&client.UnitFlagImmuneToPC != 0
	}
	introDeadline := time.Now().Add(introWindow)
	for immune() && time.Now().Before(introDeadline) {
		time.Sleep(500 * time.Millisecond)
	}
	if immune() {
		e2eharness.Preconditionf(t, "Algalon 0x%X still UNIT_FLAG_IMMUNE_TO_PC after %s; intro roleplay never finished", algalon, introWindow)
	}
	t.Logf("intro roleplay done, Algalon attackable")

	// Drop GM so he fights back, then make both bots able to sit through a Big Bang. Note the
	// bare CombatReady/CombatReadyFull helpers turn `.cheat god` on, which would leave the
	// bots invulnerable and every quiet window vacuous: this oracle needs real damage.
	for _, b := range bots {
		e2eharness.CombatReady(t, b.World, e2eharness.CombatReadyOpts{})
		if err := b.World.SetTarget(b.World.CharGUID()); err != nil {
			e2eharness.Preconditionf(t, "%s select self: %v", b.Name, err)
		}
		b.GM(t, fmt.Sprintf(".modify hp %d", botHealth))
	}

	tank.Engage(t, algalon, 60*time.Second)
	t.Logf("engaged Algalon, waiting for Big Bang")

	totalHP := func() uint32 {
		var sum uint32
		for _, b := range bots {
			hp, _ := b.UnitHP(b.World.CharGUID())
			sum += hp
		}
		return sum
	}

	sweep := func() bool {
		// Stripped every pass rather than on a stack threshold: a missed read is
		// unrecoverable, because once the 5th stack lands 64417 stays on and taking 64412 off
		// does not remove it. This is the tank swap a real raid does, and Phase Punch only
		// comes around every 15.5s.
		for _, b := range bots {
			if err := b.World.SetTarget(b.World.CharGUID()); err == nil {
				b.GM(t, fmt.Sprintf(".unaura %d", spellPhasePunch))
				b.GM(t, fmt.Sprintf(".unaura %d", spellPhasePunchShift))
			}
		}
		if guids := e2eharness.LivingByEntries(tank.World, 300, npcLivingConstellation); len(guids) > 0 {
			tank.DamageKill(t, guids, constellationHit, 10*time.Second)
			t.Logf("cleared %d Living Constellation(s)", len(guids))
		}
		bossHP, _ := tank.UnitHP(algalon)
		t.Logf("sweep: total hp=%d boss hp=%d bossTarget=0x%X inCombat=%v",
			totalHP(), bossHP, tank.UnitTarget(algalon), tank.UnitInCombat(algalon))
		tank.Attack(t, algalon)
		return tank.UnitInCombat(algalon)
	}

	startHP := totalHP()
	var bigBangAt time.Time
	lastSweep := time.Time{}
	waitDeadline := time.Now().Add(bigBangWindow)
	for time.Now().Before(waitDeadline) {
		if tank.HasAura(spellRemovePhase) || spare.HasAura(spellRemovePhase) {
			bigBangAt = time.Now()
			break
		}
		if time.Since(lastSweep) >= sweepEvery {
			if !sweep() {
				e2eharness.Preconditionf(t, "Algalon left combat before Big Bang (total hp %d -> %d)", startHP, totalHP())
			}
			lastSweep = time.Now()
		}
		time.Sleep(sampleEvery)
	}
	if bigBangAt.IsZero() {
		e2eharness.Preconditionf(t, "no Big Bang (%d) within %s of the pull", spellRemovePhase, bigBangWindow)
	}

	// Oracle liveness: if nothing has been hitting the bots up to here, a quiet window proves
	// nothing at all.
	preHP := totalHP()
	if preHP >= startHP {
		e2eharness.Preconditionf(t, "bots took no damage before Big Bang (total %d -> %d), the quiet window would be vacuous", startHP, preHP)
	}
	t.Logf("Big Bang landed, total hp %d -> %d", startHP, preHP)

	// The bots regenerate while this runs, so the total is not monotonic and a plain
	// "below the value at window start" check would let regeneration mask a hit. Compare
	// against a running peak instead: regeneration only raises it, and any decrease at all
	// is Algalon landing something.
	time.Sleep(settle)
	quietHP := totalHP()
	peakHP := quietHP
	for time.Since(bigBangAt) < stasisWindow {
		hp := totalHP()
		if hp < peakHP {
			e2eharness.ConfirmedBugf(t, 27539,
				"Algalon acted %s after Big Bang, inside the 3s stasis: total hp %d -> %d",
				time.Since(bigBangAt).Round(time.Millisecond), peakHP, hp)
		}
		if hp > peakHP {
			peakHP = hp
		}
		time.Sleep(sampleEvery)
	}

	// The window must be quiet because he is holding still, not because he evaded or the bots
	// stopped being targets: he has to come back swinging right after it.
	resumed := false
	resumeDeadline := time.Now().Add(resumeWindow)
	for time.Now().Before(resumeDeadline) {
		hp := totalHP()
		if hp < peakHP {
			resumed = true
			break
		}
		if hp > peakHP {
			peakHP = hp
		}
		time.Sleep(sampleEvery)
	}
	if !resumed {
		e2eharness.Preconditionf(t,
			"Algalon never resumed within %s of the stasis ending (total hp still %d, in combat=%v) — the quiet window proves nothing",
			resumeWindow, quietHP, tank.UnitInCombat(algalon))
	}

	t.Logf("PASS Big Bang stasis: no damage for %s after the cast, then Algalon resumed", stasisWindow)
}
