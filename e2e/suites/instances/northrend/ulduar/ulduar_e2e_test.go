//go:build e2e

package ulduar_test

import (
	"fmt"
	"math"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

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

// Elder Brightleaf's Unstable Sun Beams must not outlive him. The beams are spell summons that
// nothing in the engine despawns, so while the elder's event map was the only thing removing them
// every kill taken with a wave up left the beams on the ground permanently.
// Issue: https://github.com/chromiecraft/chromiecraft/issues/10163
func TestUlduar_BrightleafSunBeamsDespawnAfterDeath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances"},
		Runtime:  "med",
		Category: "instances/northrend/ulduar",
	})

	const (
		npcElderBrightleaf = uint32(32915)
		npcUnstableSunBeam = uint32(33050)
		// Each beam despawns itself after a randomised 18-25s; the oracle allows the worst case
		// plus slack for the kill and the object-cache round trip.
		beamMaxLifetime = 25 * time.Second
		beamSearchRange = float32(150)
		// The elder's own beam sits on him, so "landed on the player" is only distinguishable
		// from "stacked on the elder" while the bot stands clear of him by more than this.
		beamOnPlayerRange = float32(3)
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Bleaf",
		Level:  80,
	})

	// Raid interior pad (game_tele BossFreya), same as the Freya test: .go xyz is reliable while a
	// missing custom tele name hangs TeleNamed for 60s. Stay GM through the raid enter.
	bot.Teleport(t, 2326.82, -48.131, 424.963, e2eharness.MapUlduar)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "not in Ulduar after Freya pad tele map=%d", m)
	}
	bot.GoCreatureID(t, npcElderBrightleaf)
	bot.CombatReady(t)

	// Evade beside the elder can leave a 0 HP object in cache; re-poll for a living one.
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
	bot.Engage(t, elder, 15*time.Second)

	// First wave lands ~6s after the pull, then every 22-26s.
	var wave []sunBeamSnap
	waveDeadline := time.Now().Add(40 * time.Second)
	for {
		if wave = sunBeamsInCache(bot, npcUnstableSunBeam, beamSearchRange); len(wave) > 0 {
			break
		}
		if !time.Now().Before(waveDeadline) {
			e2eharness.Preconditionf(t, "no Unstable Sun Beam spawned within 40s of engaging Elder Brightleaf")
		}
		time.Sleep(250 * time.Millisecond)
	}
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
	// 62207 summons one beam at the elder and force-casts 62221 on every player in range, each
	// summoning one at their own feet. A forced cast whose target mask takes no unit target must
	// not inherit the original caster as its destination, or every beam stacks on the elder.
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
