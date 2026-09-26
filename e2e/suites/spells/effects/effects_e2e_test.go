//go:build e2e

package effects_test

import (
	"fmt"
	"math"
	"strings"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// OPEN(e2e): re-enable when AC#26774 is fixed
// https://github.com/azerothcore/azerothcore-wotlk/issues/26774
// Must assert client item-use / dummy rank (not CastOrGM + any 2673).
/*
func TestEffects_TargetDummySummon(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "spells", "issue"},
		Runtime:  "short",
		Issue:    26774,
		Category: "spells/effects",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FxDummy",
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.AddItem(t, e2eharness.ItemTargetDummy, 1)
	bot.Learn(t, e2eharness.SpellSummonTargetDummy)
	_ = bot.CastOrGM(t, e2eharness.SpellSummonTargetDummy, 0, 10*time.Second)
	u := bot.WaitUnit(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	if u == 0 {
		e2eharness.Preconditionf(t, "target dummy not observed")
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS target dummy summon guid=0x%X", u)
}
*/

// FX-02: Charge effect moves player (warrior).
// WotLK Charge rank 3 (11578): Battle Stance, 8–25 yd, out of combat.
func TestEffects_ChargeEffect(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "combat"}, Runtime: "short", Category: "spells/effects"})

	const spellChargeRank3 = uint32(11578)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "FxChg",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	// PackagePad is isolation only — mountain pads return SPELL_FAILED_NOPATH (56).
	// Northshire open strip (map 0) is flat and mmaps-friendly for Charge.
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	const (
		chargeX   float32 = -8904.0
		chargeY   float32 = -128.0
		chargeZ   float32 = 81.0
		chargeMap uint32  = 0
	)
	bot.Teleport(t, chargeX, chargeY, chargeZ, chargeMap)
	bot.CombatStop(t)
	bot.CombatReadyFull(t)
	bot.CombatStop(t)
	bot.FlushWorld(t)
	bot.Learn(t, e2eharness.SpellBattleStance)
	bot.Learn(t, spellChargeRank3)
	bot.CastMust(t, e2eharness.SpellBattleStance, 0, 10*time.Second)
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if bot.HasAura(e2eharness.SpellBattleStance) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !bot.HasAura(e2eharness.SpellBattleStance) {
		e2eharness.Preconditionf(t, "Battle Stance missing before Charge")
	}
	// 31146 is long-lived (2673 KillSelfs at 15s — Charge setup exceeds that).
	dummy := bot.Spawn(t, e2eharness.CreatureHeroicTrainingDummy, 15*time.Second)
	// 8–25 yd charge range on flat ground.
	bot.Teleport(t, chargeX+12, chargeY, chargeZ, chargeMap)
	x0, y0, z0, _ := bot.Pos()
	_ = bot.World.SetTarget(dummy)
	bot.Face(t, dummy)
	bot.CastMust(t, spellChargeRank3, dummy, 10*time.Second)
	// Snapshot is the step-back point; Charge must close toward the dummy.
	deadline = time.Now().Add(2 * time.Second)
	var moved float32
	for time.Now().Before(deadline) {
		x1, y1, z1, _ := bot.Pos()
		moved = e2eharness.Distance3D(x0, y0, z0, x1, y1, z1)
		if moved >= 1.0 {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if moved < 1.0 {
		e2eharness.Assertf(t, "Charge SPELL_GO ok but player did not leave step-back (moved=%.1f)", moved)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS charge effect moved=%.1fy", moved)
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/26997
// Sweeping Strikes + Execute on a ≤20% target with a second living ≤20% target
// nearby must not crash (CheckProc stored a raw Unit* that HandleProc deref'd).
// Training dummies absorb damage (npc_training_dummy::DamageTaken = 0) so they
// never enter Execute's 20% HealthState. Player-vs-player in Northshire fails
// SPELL_FAILED_BAD_TARGETS (sanctuary / PvP flag race). Use two hostile mobs.
func TestAC_26997_SweepingStrikesExecuteNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "multi_bot", "serial"},
		Runtime:  "med",
		Issue:    26997,
		Category: "spells/effects",
	})

	const (
		spellExecuteMax = uint32(47471) // WotLK Execute rank 9
		// High-HP test dummies with empty ScriptName (they take damage). L1-L6
		// world mobs die to a L80 autoattack during DamageToFraction.
		unkillableDummy80      = uint32(32171)
		unkillableDummy80Armor = uint32(32847) // different entry — Spawn despawns nearby same-entry
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "SwpEx",
		Bots: []e2eharness.BotSpec{
			{Role: "arms", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "probe", Level: 10},
		},
	})
	arms := e2eharness.ByRole(t, bots, "arms")
	probe := e2eharness.ByRole(t, bots, "probe")

	// Northshire strip — flat, melee range for Sweeping Strikes extra attack.
	const (
		x, y, z float32 = -8904.0, -128.0, 81.0
		m       uint32  = 0
	)
	arms.Teleport(t, x, y, z, m)
	probe.Teleport(t, x-8, y, z, m)

	arms.CombatReadyFull(t)
	arms.Learn(t, e2eharness.SpellBattleStance)
	arms.Learn(t, e2eharness.SpellSweepingStrikes)
	arms.Learn(t, spellExecuteMax)
	arms.CastMust(t, e2eharness.SpellBattleStance, 0, 10*time.Second)
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		if arms.HasAura(e2eharness.SpellBattleStance) {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if !arms.HasAura(e2eharness.SpellBattleStance) {
		e2eharness.Preconditionf(t, "Battle Stance missing before Execute")
	}

	c1 := arms.Spawn(t, unkillableDummy80, 15*time.Second)
	c2 := arms.Spawn(t, unkillableDummy80Armor, 15*time.Second)
	arms.CombatStop(t)
	if c1 == 0 || c2 == 0 {
		e2eharness.Preconditionf(t, "failed to spawn Execute targets c1=0x%X c2=0x%X", c1, c2)
	}
	arms.DamageToFraction(t, c1, 0.19, 20*time.Second)
	arms.DamageToFraction(t, c2, 0.19, 20*time.Second)
	for _, v := range []struct {
		name string
		g    uint64
	}{{"c1", c1}, {"c2", c2}} {
		hp, maxHP := arms.UnitHP(v.g)
		if maxHP == 0 || hp == 0 || float64(hp)/float64(maxHP) > 0.2 {
			e2eharness.Preconditionf(t, "%s not in execute range (hp=%d/%d guid=0x%X)", v.name, hp, maxHP, v.g)
		}
	}

	arms.CastMust(t, e2eharness.SpellSweepingStrikes, 0, 10*time.Second)
	if !arms.HasAura(e2eharness.SpellSweepingStrikes) {
		e2eharness.Preconditionf(t, "Sweeping Strikes aura %d missing", e2eharness.SpellSweepingStrikes)
	}
	_ = arms.World.SetTarget(c1)
	arms.Face(t, c1)
	res, err := arms.TryCast(t, spellExecuteMax, c1, 15*time.Second)
	if err != nil {
		e2eharness.ProbeWorldAlive(t, probe, 26997)
		e2eharness.HarnessFailf(t, "AC#26997: no Execute cast result: %v", err)
	}
	e2eharness.ProbeWorldAlive(t, probe, 26997)
	if !res.Success {
		e2eharness.Assertf(t, "Execute failed reason=%s", e2eharness.SpellFailReasonName(res.FailReason))
	}
	t.Logf("PASS AC#26997 Sweeping Strikes Execute world alive (c1=0x%X c2=0x%X)", c1, c2)
}

// FX-04: grounding totem summon exists (#26584 ecosystem).
func TestEffects_GroundingTotemSummon(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells"}, Runtime: "short", Category: "spells/effects"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "FxTot",
		Race:          e2eharness.RaceOrc,
		Class:         e2eharness.ClassShaman,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.GiveTotems(t)
	bot.CombatReady(t)
	_ = bot.CastOrGM(t, e2eharness.SpellGroundingTotem, 0, 10*time.Second)
	totem := bot.WaitUnit(t, e2eharness.CreatureGroundingTotem, 15*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS grounding totem summon guid=0x%X", totem)
}

// FX-05: Create-item / learn path for dummy reagents stays healthy.
func TestEffects_AddItemCreatePath(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "spells", "items"}, Runtime: "short", Category: "spells/effects"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FxItem",
		Level:  80,
	})
	bot.AddItemWait(t, e2eharness.ItemCorpseDust, 3)
	bot.AssertInventoryAtLeast(t, e2eharness.ItemCorpseDust, 3)
	t.Logf("PASS create-item seed path count>=3")
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/27621
// Spell::EffectForceCast handed the forced cast the original caster as its unit target. When the
// triggered spell takes no unit target but does need a destination, Spell::InitExplicitTargets
// turns that unit target into the destination, so the forced cast resolves against the unit that
// forced the cast instead of against the unit that was forced to cast it.
//
// Both trigger shapes are covered: 62221 and 62293 summon at the destination itself, while 48757
// summons at a fixed offset behind it (TARGET_DEST_DEST_BACK).
func TestEffects_ForceCastDestination(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "spells"}, Runtime: "med", Category: "spells/effects"})

	const (
		// Northshire open strip (map 0): flat ground, and no ambient summons of these entries to
		// confuse a placement oracle.
		stripX   float32 = -8904.0
		stripY   float32 = -128.0
		stripZ   float32 = 81.0
		stripMap uint32  = 0

		// Unkillable Test Dummy 80: faction 7, so the bot is a valid TARGET_UNIT_SRC_AREA_ENEMY
		// pick for the area force-casts, and no ScriptName to interfere.
		driverEntry = uint32(32171)

		// The driver's own summon lands on the driver, so bot and driver must stand further apart
		// than any oracle radius below.
		driverStandOff = float32(15)
		cacheRange     = float32(90)
		summonWait     = 12 * time.Second
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FxFC",
		Level:  80,
	})

	// GM command failures are reported as system chat only, so a drive that summons nothing would
	// otherwise be indistinguishable from a placement bug.
	var chatMu sync.Mutex
	var chat []string
	bot.World.OnChatMessage = func(_, msg string, _ uint8) {
		chatMu.Lock()
		chat = append(chat, msg)
		chatMu.Unlock()
	}
	lastChat := func(n int) string {
		chatMu.Lock()
		defer chatMu.Unlock()
		if len(chat) < n {
			n = len(chat)
		}
		return strings.Join(chat[len(chat)-n:], " | ")
	}

	bot.Teleport(t, stripX, stripY, stripZ, stripMap)
	bot.CombatReady(t)
	driver := bot.Spawn(t, driverEntry, 20*time.Second)
	if driver == 0 {
		e2eharness.Preconditionf(t, "no force-cast driver %d spawned", driverEntry)
	}
	// .npc add drops the driver on the bot, where both candidate destinations coincide.
	bot.Teleport(t, stripX+driverStandOff, stripY, stripZ, stripMap)
	bot.CombatReady(t)
	bot.CombatStop(t)
	driver = bot.WaitUnit(t, driverEntry, 20*time.Second) // the tele cleared the object cache
	if driver == 0 {
		e2eharness.Preconditionf(t, "driver %d not back in cache after stepping clear", driverEntry)
	}

	for _, tc := range []struct {
		name        string
		spellID     uint32
		summonEntry uint32
		onCaster    float32
		what        string
	}{
		// 62207 summons 33050 at the caster and force-casts 62221 on every player within 100 yd;
		// 62221 summons at its own caster's position.
		{"UnstableSunBeam", 62207, 33050, 4, "at the forced caster"},
		// 62301 force-casts 62293 on enemies within 100 yd; 62293 summons the crater marker at its
		// own caster's position. This is the path the removed SpellInfoCorrections entry covered.
		{"CosmicSmash", 62301, 33104, 4, "at the forced caster"},
		// 48759 force-casts 48757 on its explicit target; 48757 summons 3 yd behind the
		// destination, so the offset shape is covered too.
		{"SummonBehindForcedCaster", 48759, 27439, 6, "3 yd behind the forced caster"},
	} {
		t.Run(tc.name, func(t *testing.T) {
			known := summonGUIDs(summonsInCache(bot, tc.summonEntry, cacheRange))
			bot.Face(t, driver)
			bot.FlushWorld(t)
			// No "triggered": TRIGGERED_FULL_DEBUG_MASK carries TRIGGERED_IGNORE_EFFECTS, which
			// would send the cast without running a single effect.
			bot.GM(t, fmt.Sprintf(".cast back %d", tc.spellID))

			fresh := waitNewSummons(bot, tc.summonEntry, cacheRange, known, summonWait)
			if len(fresh) == 0 {
				e2eharness.Preconditionf(t, "%d force-cast produced no new %d within %s (last chat: %s) (cache: %s)",
					tc.spellID, tc.summonEntry, summonWait, lastChat(3), dumpNearby(bot, cacheRange))
			}
			drv := bot.World.GetObject(driver)
			if drv == nil {
				e2eharness.Preconditionf(t, "driver 0x%X left the object cache before the summon landed", driver)
			}
			bx, by, bz, _ := bot.Pos()
			for _, s := range fresh {
				t.Logf("%d -> %d guid=0x%X at (%.1f,%.1f,%.1f) dist bot=%.1f driver=%.1f",
					tc.spellID, tc.summonEntry, s.guid, s.x, s.y, s.z,
					e2eharness.Distance3D(bx, by, bz, s.x, s.y, s.z),
					e2eharness.Distance3D(drv.PosX, drv.PosY, drv.PosZ, s.x, s.y, s.z))
			}
			near, toBot := nearestSummon(fresh, bx, by, bz)
			toDriver := e2eharness.Distance3D(drv.PosX, drv.PosY, drv.PosZ, near.x, near.y, near.z)
			if toBot > tc.onCaster {
				e2eharness.Assertf(t, "%d: nearest of %d summoned %d sits %.1fy from the forced caster and %.1fy from the original caster, expected %s - the forced cast inherited the original caster as its destination",
					tc.spellID, len(fresh), tc.summonEntry, toBot, toDriver, tc.what)
			}
			t.Logf("PASS %d summoned %d %.1fy from the forced caster (%.1fy from the original caster)",
				tc.spellID, tc.summonEntry, toBot, toDriver)
		})
	}
}

type forceCastSummon struct {
	guid    uint64
	x, y, z float32
}

// summonsInCache snapshots every tracked unit of one template within maxDist.
func summonsInCache(bot *e2eharness.ScenarioBot, entry uint32, maxDist float32) []forceCastSummon {
	var out []forceCastSummon
	for _, u := range bot.World.GetNearbyUnits(maxDist) {
		if u.Entry != entry {
			continue
		}
		out = append(out, forceCastSummon{guid: u.GUID, x: u.PosX, y: u.PosY, z: u.PosZ})
	}
	return out
}

func summonGUIDs(summons []forceCastSummon) map[uint64]struct{} {
	out := make(map[uint64]struct{}, len(summons))
	for _, s := range summons {
		out[s.guid] = struct{}{}
	}
	return out
}

func newSummons(bot *e2eharness.ScenarioBot, entry uint32, maxDist float32, known map[uint64]struct{}) []forceCastSummon {
	var out []forceCastSummon
	for _, s := range summonsInCache(bot, entry, maxDist) {
		if _, seen := known[s.guid]; seen {
			continue
		}
		out = append(out, s)
	}
	return out
}

// waitNewSummons waits for a unit of entry that was not in known, then settles briefly so a second
// summon from the same cast (62207 also places one on its own caster) joins the same batch.
// Novelty by GUID is what keeps a permanent summon left by an earlier run out of the oracle.
func waitNewSummons(bot *e2eharness.ScenarioBot, entry uint32, maxDist float32,
	known map[uint64]struct{}, timeout time.Duration) []forceCastSummon {
	deadline := time.Now().Add(timeout)
	for {
		if fresh := newSummons(bot, entry, maxDist, known); len(fresh) > 0 {
			time.Sleep(700 * time.Millisecond)
			return newSummons(bot, entry, maxDist, known)
		}
		if !time.Now().Before(deadline) {
			return nil
		}
		time.Sleep(250 * time.Millisecond)
	}
}

// dumpNearby lists the tracked units around the bot, so a drive that summoned nothing can be told
// apart from a summon the client never received.
func dumpNearby(bot *e2eharness.ScenarioBot, maxDist float32) string {
	bx, by, bz, _ := bot.Pos()
	var parts []string
	for _, u := range bot.World.GetNearbyUnits(maxDist) {
		parts = append(parts, fmt.Sprintf("%d@%.0fy", u.Entry, e2eharness.Distance3D(bx, by, bz, u.PosX, u.PosY, u.PosZ)))
	}
	if len(parts) == 0 {
		return "no units tracked"
	}
	return strings.Join(parts, ",")
}

func nearestSummon(summons []forceCastSummon, x, y, z float32) (forceCastSummon, float32) {
	var best forceCastSummon
	bestDist := float32(math.MaxFloat32)
	for _, s := range summons {
		if d := e2eharness.Distance3D(x, y, z, s.x, s.y, s.z); d < bestDist {
			best, bestDist = s, d
		}
	}
	return best, bestDist
}
