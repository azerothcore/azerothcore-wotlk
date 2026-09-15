//go:build e2e

package dalaran_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	dalaranMap   uint32 = 571
	settleWindow        = 9 * time.Second
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/4467
//
// Dalaran's faction guards used to decide "is this player trespassing" from how
// close a fruit vendor was and which way the guard happened to face, which ejected
// players standing on public ground — a mailbox, the street, the sewers — while
// leaving most of each sanctum unwatched.
//
// They now eject on where the player is: the sanctum area ids, plus the WMO groups
// that make up each quarter's buildings, since most of that ground reports the
// plain Dalaran area id and cannot be told from neutral space by area alone.
//
// Both directions are asserted, because each alone is easy to satisfy wrongly.
// Checking only that public ground is safe would pass a build where the guards
// never fire; checking only the sanctums would pass the original bug untouched.
type trespassCase struct {
	name      string
	x, y, z   float32
	wantEject bool
	why       string
}

func TestAC_4467_DalaranGuardsOnlyEjectFromRestrictedAreas(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "world", "issue", "serial"},
		Runtime:  "med",
		Issue:    4467,
		Category: "world/dalaran",
	})

	horde := []trespassCase{
		{"MailboxByHerosWelcome", 5740.3, 680.9, 644.7, false, "public mailbox outside the inn"},
		// Deliberately a few yards off the trespasser destination (5758.79, 678.359,
		// 642.726): standing on it would make an ejection a zero-yard move that the
		// displacement oracle below could never see.
		{"StreetOutsideHerosWelcome", 5750.0, 678.8, 642.8, false, "the public street beside the spell's destination"},
		{"UnderbellySewers", 5759.2, 716.1, 618.6, false, "the public sewers"},
		{"SilverEnclaveThreshold", 5754.83, 718.36, 641.71, true, "past the guards into the Enclave"},
		{"SilverEnclaveCourtyard", 5740.3, 739.6, 641.9, true, "Alliance sanctum"},
		{"DeepSilverEnclave", 5671.43, 724.48, 653.41, true, "deep Alliance quarter"},
		{"InsideAHerosWelcome", 5725.674, 683.2177, 646.565, true, "the Alliance inn"},
	}
	alliance := []trespassCase{
		{"MailboxBySunreaverSide", 5893.2, 528.2, 641.4, false, "public mailbox on the Horde side"},
		{"LegerdemainLoungeAlliance", 5847.97, 635.43, 647.57, false, "neutral inn, 35.4y from a guard so really evaluated"},
		{"SunreaversSanctuary", 5862.0, 520.3, 655.5, true, "Horde sanctum"},
		{"InsideTheFilthyAnimal", 5892.3, 505.75, 641.65, true, "the Horde inn"},
	}

	run := func(t *testing.T, race uint8, cases []trespassCase) {
		// GM mode must be off: npc_mageguard_dalaran skips IsGameMaster(), so a GM
		// is never ejected and every case would pass vacuously.
		bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
			Prefix: "Tres",
			Race:   race,
			Class:  e2eharness.ClassWarrior,
			Level:  80,
		})
		e2eharness.MustGM(t, bot.World, ".gm off")
		// The whole oracle rests on GM mode being off - IsGameMaster() short-circuits
		// the guard check - so ack it on the world thread rather than assume it took.
		bot.FlushWorld(t)

		for _, c := range cases {
			t.Run(c.name, func(t *testing.T) {
				e2eharness.TeleportGo(t, bot.World, c.x, c.y, c.z, dalaranMap)

				ejected := false
				deadline := time.Now().Add(settleWindow)
				for time.Now().Before(deadline) {
					ax, ay, az, _ := bot.Pos()
					if e2eharness.Distance3D(ax, ay, az, c.x, c.y, c.z) > 10 {
						ejected = true
						break
					}
					time.Sleep(250 * time.Millisecond)
				}

				switch {
				case c.wantEject && !ejected:
					e2eharness.Assertf(t, "%s (%.2f, %.2f, %.2f): a hostile player was not ejected from %s; "+
						"the restricted ground is unguarded", c.name, c.x, c.y, c.z, c.why)
				case !c.wantEject && ejected:
					e2eharness.Assertf(t, "%s (%.2f, %.2f, %.2f): a player standing on %s was teleported away; "+
						"this is the AC#4467 regression — public ground is not the faction quarter",
						c.name, c.x, c.y, c.z, c.why)
				default:
					t.Logf("PASS %-26s ejected=%-5v (%s)", c.name, ejected, c.why)
				}
			})
		}
	}

	t.Run("Horde", func(t *testing.T) { run(t, e2eharness.RaceOrc, horde) })
	t.Run("Alliance", func(t *testing.T) { run(t, e2eharness.RaceHuman, alliance) })
}
