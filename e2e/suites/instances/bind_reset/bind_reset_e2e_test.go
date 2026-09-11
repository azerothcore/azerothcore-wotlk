//go:build e2e

package bind_reset_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// BIND-* : instance party baselines + ritual summon (3 roles) + #10708.

// game_tele name on this realm (not "Stockades"). Exterior entrance on map 0.
const teleTheStockade = "TheStockade"

// Stockade interior (map 34) — real dungeon instance, not PackagePad / outdoor isolation pads.
// Coords match areatrigger "Stormwind Stockades Entrance" (quieter than deeper hall packs).
// Used for ritual summon, bind soft checks, and co-located .summon into one instance copy.
var stockadeInterior = e2eharness.Position3{
	X: 54.23, Y: 0.28, Z: -18.34, Map: 34,
}

// teleDungeonOrPrecondition runs a named tele and fails as precondition if position/map did not move.
func teleDungeonOrPrecondition(t *testing.T, bot *e2eharness.ScenarioBot, name string) (mapID uint32) {
	t.Helper()
	x0, y0, z0, m0 := bot.Pos()
	bot.TeleNamed(t, name)
	x1, y1, z1, m1 := bot.Pos()
	moved := m1 != m0 || e2eharness.Distance3D(x0, y0, z0, x1, y1, z1) > 5
	if !moved {
		e2eharness.Preconditionf(t,
			"named tele %q did not move player (still map=%d pos=%.1f,%.1f,%.1f) — missing game_tele?",
			name, m1, x1, y1, z1)
	}
	return m1
}

// BIND-01: party of 2 formed (instance group precondition).
func TestBind_PartyFormedForInstance(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "instance", "multi_bot"}, Runtime: "short", Category: "instances/bind_reset"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindPty", Count: 2, Level: 80})
	e2eharness.FormParty(t, bots[0], bots[1])
	if !bots[0].InGroup() || !bots[1].InGroup() {
		e2eharness.Assertf(t, "party not formed in0=%v in1=%v", bots[0].InGroup(), bots[1].InGroup())
	}
	t.Logf("PASS instance party formed")
}

// BIND-02: named dungeon tele (TheStockade) world alive.
func TestBind_NamedDungeonTele(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instance"}, Runtime: "med", Category: "instances/bind_reset"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "BindStk", Level: 80})
	// AC game_tele is "TheStockade" (not "Stockades"); wrong name hangs TeleNamed ~60s.
	m := teleDungeonOrPrecondition(t, bot, teleTheStockade)
	bot.AssertWorldAlive(t)
	t.Logf("PASS named dungeon tele map=%d", m)
}

// BIND-03: group shared tele attempt.
func TestBind_GroupTeleTogether(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instance", "multi_bot"}, Runtime: "med", Category: "instances/bind_reset"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindGrp", Count: 2, Level: 80})
	e2eharness.FormParty(t, bots[0], bots[1])
	var maps []uint32
	for _, b := range bots {
		maps = append(maps, teleDungeonOrPrecondition(t, b, teleTheStockade))
	}
	if maps[0] != maps[1] {
		e2eharness.Assertf(t, "group not on same map after named tele leader=%d mate=%d", maps[0], maps[1])
	}
	if !bots[0].InGroup() || !bots[1].InGroup() {
		e2eharness.Assertf(t, "party split after tele in0=%v in1=%v", bots[0].InGroup(), bots[1].InGroup())
	}
	t.Logf("PASS group tele together map=%d", maps[0])
}

// partyInStockadeForRitual places all three bots in the same Stockade instance.
// Separate .go xyz into map 34 can open different instance IDs — leader enters first, then
// GM .summon pulls helper and far into that copy.
//
// EffectSummonPlayer CheckCast requires a selectable same-raid target; casting while the
// far player is on another map fails under GM .cast and often under dungeon access checks.
// Issue the ritual / summon request while co-located in the instance, then send far outside
// before AcceptSummon when the test needs the exterior.
func partyInStockadeForRitual(t *testing.T, initiator, helper, far *e2eharness.ScenarioBot) {
	t.Helper()
	e2eharness.FormParty(t, initiator, helper, far)

	// Initiator enters Stockade interior (real instance map 34) — not PackagePad.
	initiator.Teleport(t, stockadeInterior.X, stockadeInterior.Y, stockadeInterior.Z, stockadeInterior.Map)
	_, _, _, im := initiator.Pos()
	if im != stockadeInterior.Map {
		e2eharness.Preconditionf(t, "initiator not on Stockade map %d (got %d)", stockadeInterior.Map, im)
	}

	for _, mate := range []*e2eharness.ScenarioBot{helper, far} {
		before := mate.World.TeleportSeq()
		initiator.GM(t, ".summon "+mate.Name)
		if err := mate.World.WaitForTeleportAfter(before, 15*time.Second); err != nil {
			e2eharness.Preconditionf(t, "%s .summon into Stockade: %v", mate.Name, err)
		}
		_, _, _, mm := mate.Pos()
		if mm != stockadeInterior.Map {
			e2eharness.Preconditionf(t, "%s not on Stockade map after .summon (map=%d)", mate.Name, mm)
		}
	}

	// Trash near the entrance can peel selection / break portal completion cast 7720.
	for _, b := range []*e2eharness.ScenarioBot{initiator, helper, far} {
		b.CombatStop(t)
		b.FlushWorld(t)
	}
}

// sendFarOutsideStockade moves far to the exterior entrance (map 0) while leaving a
// pending summon intact (do this only after SMSG_SUMMON_REQUEST).
func sendFarOutsideStockade(t *testing.T, far *e2eharness.ScenarioBot) {
	t.Helper()
	teleDungeonOrPrecondition(t, far, teleTheStockade)
	_, _, _, m := far.Pos()
	if m == stockadeInterior.Map {
		e2eharness.Preconditionf(t, "far still on instance map %d after exterior tele", m)
	}
}

// BIND-04: 3-role ritual summon inside Stockade, then far accepts from exterior.
//
// Flow (portal GO 179944, reqParticipants=2):
//  1. all three enter the same Stockade instance
//  2. initiator + helper run the portal; far receives SMSG_SUMMON_REQUEST
//  3. far leaves to exterior, then AcceptSummon back into the instance
func TestBind_RitualSummonAccept(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "instance", "multi_bot", "serial"},
		Runtime:  "short",
		Category: "instances/bind_reset",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindRt", Count: 3, Level: 80})
	initiator, helper, far := bots[0], bots[1], bots[2]
	partyInStockadeForRitual(t, initiator, helper, far)

	waitSummon, cancelSummon := far.ArmSummonRequest()
	defer cancelSummon()
	e2eharness.RitualSummon(t, initiator, helper, far)
	req, err := waitSummon(25 * time.Second)
	if err != nil {
		e2eharness.Preconditionf(t, "no SMSG_SUMMON_REQUEST after ritual: %v", err)
	}

	// Leave instance while summon is pending, then accept back in.
	sendFarOutsideStockade(t, far)

	far.AcceptSummon(t, req.SummonerGUID)
	far.AssertWorldAlive(t)
	initiator.AssertWorldAlive(t)

	_, _, _, farMap := far.Pos()
	if farMap != stockadeInterior.Map {
		e2eharness.Assertf(t, "after AcceptSummon expected Stockade map %d, far map=%d",
			stockadeInterior.Map, farMap)
	}
	fx, fy, fz, _ := far.Pos()
	ix, iy, iz, _ := initiator.Pos()
	if e2eharness.Distance3D(fx, fy, fz, ix, iy, iz) > 40 {
		e2eharness.Assertf(t, "after AcceptSummon far still far from initiator (d=%.1f)",
			e2eharness.Distance3D(fx, fy, fz, ix, iy, iz))
	}
	t.Logf("PASS ritual summon accept into instance summoner=0x%X farMap=%d", req.SummonerGUID, farMap)
}

// OPEN(e2e): re-enable when AC#10708 is fixed — post-reset AcceptSummon must co-locate maps.
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/10708
/*
func TestBind_ResetSummonExploit_10708(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instance", "issue", "multi_bot", "serial"},
		Runtime:  "long",
		Issue:    10708,
		Category: "instances/bind_reset",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "BindX7", Count: 3, Level: 80})
	initiator, helper, far := bots[0], bots[1], bots[2]
	partyInStockadeForRitual(t, initiator, helper, far)

	waitSummon, cancelSummon := far.ArmSummonRequest()
	defer cancelSummon()
	e2eharness.RitualSummon(t, initiator, helper, far)
	req, err := waitSummon(25 * time.Second)
	if err != nil {
		e2eharness.Preconditionf(t, "no SMSG_SUMMON_REQUEST: %v", err)
	}

	sendFarOutsideStockade(t, far)
	initiator.LeaderResetInstances(t, 5*time.Second)

	far.AcceptSummon(t, req.SummonerGUID)
	far.AssertWorldAlive(t)
	initiator.AssertWorldAlive(t)

	_, _, _, farMap := far.Pos()
	_, _, _, leadMap := initiator.Pos()
	if farMap != leadMap {
		e2eharness.Assertf(t, "after reset+AcceptSummon far map=%d initiator map=%d (summoner=0x%X)",
			farMap, leadMap, req.SummonerGUID)
	}
	t.Logf("PASS #10708 path farMap=%d leadMap=%d", farMap, leadMap)
}
*/

// BIND-05: character_instance row present after instance map enter + save.
func TestBind_CharacterInstanceAfterEnter(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "instance"}, Runtime: "med", Category: "instances/bind_reset"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "BindDB", Level: 80})
	bot.Teleport(t, stockadeInterior.X, stockadeInterior.Y, stockadeInterior.Z, stockadeInterior.Map)
	_, _, _, m := bot.Pos()
	if m != stockadeInterior.Map {
		e2eharness.Preconditionf(t, "expected Stockade map %d after .go xyz, got %d", stockadeInterior.Map, m)
	}
	bot.Save(t)
	var n int
	var lastErr error
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		lastErr = bot.CharDB.QueryRow(
			`SELECT COUNT(*) FROM character_instance WHERE guid=?`, bot.GUID,
		).Scan(&n)
		if lastErr == nil && n > 0 {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	if lastErr != nil {
		e2eharness.HarnessFailf(t, "character_instance query: %v", lastErr)
	}
	if n <= 0 {
		e2eharness.Assertf(t, "expected character_instance row after Stockade enter+save, got count=%d map=%d", n, m)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS character_instance rows=%d map=%d", n, m)
}
