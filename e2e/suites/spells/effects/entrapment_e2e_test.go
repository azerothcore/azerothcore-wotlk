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

const (
	spellFrostTrap     uint32 = 13809 // places GO 164639, which casts 63487 -> triggers 13810
	spellFrostTrapAura uint32 = 13810 // the persistent slow; carries the trap-activation proc
	spellEntrapmentR3  uint32 = 19388 // 100% on trap activation (SpellPhaseMask FINISH)
	spellEntrapmentR3R uint32 = 64804 // the 4s root Entrapment rank 3 triggers on the victim

	// The hunter casts the root, and a level 80 caster with no hit rating lands a spell
	// on a level 80 target 96% of the time, which failed about one case in twenty.
	// Warrior's Precision rank 5 is a passive +5% spell hit with no class restriction;
	// that takes the root to the 100% cap so a miss can never pose as the bug.
	spellPlusFiveSpellHit uint32 = 13845

	// Attackable, never dies, no AI and no mechanic immunity, so the trap's
	// NearestAttackableNoTotemUnitInObjectRangeCheck picks it and the root can land.
	entrapDummy uint32 = 32171

	// Far enough that the trap's activation radius (2.5yd) and the root's own area
	// around the victim cannot reach the hunter, so the case can only pass if the root
	// is centred on the victim.
	entrapHunterAway float32 = 25

	// Each case lays its trap on fresh ground: a Frost Trap Aura dynobject outlives the
	// trap by 30s, and one left over from the previous case would slow the next dummy
	// before its own trap fired.
	entrapCaseSpacing float32 = 40
)

// Since the trap GameObject casts its own spells (PR #26152), Frost Trap Aura is cast
// with the GO as caster. Spell::_handle_finish_phase returned early for any non-unit
// caster, so the finish-phase proc that carries PROC_FLAG_DONE_TRAP_ACTIVATION never
// reached the hunter and Entrapment stopped rooting anything. #17825 reported the root
// landing only when the hunter stood on the trap, so both placements are covered.
//
// Oracle: whether the hunter stands on the trap or 25yd away, the unit that trips a
// Frost Trap gets Entrapment's root.
//
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/17825
// Regression from: https://github.com/azerothcore/azerothcore-wotlk/pull/26152
func TestAC_17825_EntrapmentRootsTrapVictim(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "multi_bot"},
		Runtime:  "med",
		Issue:    17825,
		Category: "spells/effects",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "Entrap",
		Bots: []e2eharness.BotSpec{
			{Role: "hunter", Race: e2eharness.RaceDwarf, Class: e2eharness.ClassHunter, Level: 80, LearnAllClass: true},
			// Stays in GM mode: traps ignore GM players, so it can stand on the trap to
			// spawn the dummy there and watch its auras without tripping anything.
			{Role: "placer", Race: e2eharness.RaceDwarf, Level: 80},
		},
	})
	hunter := e2eharness.ByRole(t, bots, "hunter")
	placer := e2eharness.ByRole(t, bots, "placer")

	// Spawn opens the world DB lazily, ties its Close to the calling (sub)test and caches
	// it on the bot, so the second subtest would inherit a closed handle and lose spawn
	// cleanup. Open it here so it lives as long as the parent test.
	worldDB, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.HarnessFailf(t, "open world DB: %v", err)
	}
	t.Cleanup(func() { _ = worldDB.Close() })
	placer.WorldDB = worldDB

	pad := e2eharness.PackagePad(t)
	hunter.TeleportPad(t, pad)
	placer.TeleportPad(t, pad)

	// `.learn all my class` already teaches talents; Learn is a no-op then. The talent's
	// passive aura gets no visible client slot, so the spell list is what can be checked.
	for _, id := range []uint32{spellEntrapmentR3, spellFrostTrap, spellPlusFiveSpellHit} {
		hunter.Learn(t, id)
		if !hunter.World.KnowsSpell(id) {
			e2eharness.Preconditionf(t, "hunter does not know spell %d after .learn", id)
		}
	}
	hunter.CombatReady(t)

	for i, tc := range []struct {
		name string
		away bool
	}{
		{"HunterOnTrap", false},
		{"HunterAwayFromTrap", true},
	} {
		t.Run(tc.name, func(t *testing.T) {
			x, y := pad.X+float32(i)*entrapCaseSpacing, pad.Y
			goGround(t, hunter, x, y)
			goGround(t, placer, x, y)
			tx, ty, tz, _ := hunter.Pos()

			hunter.GM(t, ".cooldown")
			hunter.CastMust(t, spellFrostTrap, 0, 10*time.Second)

			if tc.away {
				goGround(t, hunter, tx+entrapHunterAway, ty)
				hx, hy, hz, _ := hunter.Pos()
				if d := e2eharness.Distance3D(hx, hy, hz, tx, ty, tz); d < entrapHunterAway-5 {
					e2eharness.Preconditionf(t, "hunter only %.1fyd from the trap", d)
				}
			}

			dummy := placer.Spawn(t, entrapDummy, 15*time.Second)
			if dummy == 0 {
				e2eharness.Preconditionf(t, "failed to spawn dummy %d on the trap", entrapDummy)
			}

			// The trap arms 1s after placement; Frost Trap Aura on the dummy is the proof
			// it fired, so a missing root below is Entrapment's fault and not the trap's.
			if !waitUnitAura(placer, dummy, spellFrostTrapAura, 10*time.Second) {
				e2eharness.Preconditionf(t, "Frost Trap never fired on dummy 0x%X (no aura %d)", dummy, spellFrostTrapAura)
			}
			if !waitUnitAura(placer, dummy, spellEntrapmentR3R, 3*time.Second) {
				e2eharness.ConfirmedBugf(t, 17825, "Frost Trap fired on dummy 0x%X but Entrapment root %d never landed (hunter away=%v)",
					dummy, spellEntrapmentR3R, tc.away)
			}
			t.Logf("PASS Entrapment rooted dummy 0x%X (hunter away=%v)", dummy, tc.away)
		})
	}
}

// goGround teleports bot to x, y on its current map at ground height: `.go xyz` without a
// z snaps to the terrain, so nearby case spots need no hand-captured heights.
func goGround(t *testing.T, bot *e2eharness.ScenarioBot, x, y float32) {
	t.Helper()
	e2eharness.MustGMTeleport(t, bot.World, fmt.Sprintf(".go xyz %.2f %.2f", x, y))
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		bx, by, _, _ := bot.Pos()
		if dx, dy := bx-x, by-y; dx*dx+dy*dy < 1 {
			return
		}
		time.Sleep(40 * time.Millisecond)
	}
	bx, by, _, _ := bot.Pos()
	e2eharness.HarnessFailf(t, "teleport to %.1f, %.1f left the bot at %.1f, %.1f", x, y, bx, by)
}

func waitUnitAura(bot *e2eharness.ScenarioBot, guid uint64, spellID uint32, timeout time.Duration) bool {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if bot.UnitHasAura(guid, spellID) {
			return true
		}
		time.Sleep(40 * time.Millisecond)
	}
	return false
}
