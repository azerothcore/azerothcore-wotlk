//go:build e2e

package gameevents_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/24380
//
// Six Call to Arms holidays each light their own pair of PvP banners, and every
// pair is spawned at the same positions. Dalaran has four such positions, two per
// side. Alterac Valley and Arathi Basin had their banners on the wrong sides, so
// Sunreaver's Sanctuary flew Alliance colours; Warsong Gulch was already correct.
//
// Standing at one position on each side, this starts a holiday at a time and
// asserts the banner that spawns belongs to that side and its opposite does not.
// Warsong is included as a control: it was correct before the fix and must stay
// correct, which separates a targeted swap from a blanket one.
//
// REALM STATE: starting a holiday re-anchors its schedule in the running
// worldserver — GameEventMgr::StartEvent sets Start to now and StopEvent sets it
// to now minus the length, so the next natural occurrence shifts by up to a full
// cycle. These events have world_event = 0, so no schedule state is persisted and
// a worldserver restart restores it, but the suite still wants a realm it does not
// share with players. A holiday already running is left strictly
// alone, because stopping it afterwards would end the real one.
//
// Whether it is running has to be asked of the server, not of game_event: for Call
// to Arms the stored start_time, length and occurence are replaced at load time
// from Holidays.dbc (GameEventMgr::LoadFromDB -> SetHolidayEventTime), so the row
// is not the schedule in force — the shipped start_time values are from 2010. A
// banner of the holiday's own pair already standing here is the server's own state
// and needs no second source.
func TestAC_24380_CallToArmsBannerFactions(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "world", "gameevents", "issue", "serial"},
		Runtime:  "med",
		Issue:    24380,
		Category: "world/gameevents",
	})

	const (
		mapNorthrend = uint32(571)

		eventAlteracValley = 18
		eventWarsongGulch  = 19
		eventArathiBasin   = 20

		goHordeCTF       = uint32(180394)
		goHordeAV        = uint32(180395)
		goHordeArathi    = uint32(180396)
		goAllianceArathi = uint32(180398)
		goAllianceAV     = uint32(180399)
		goAllianceCTF    = uint32(180400)
	)

	// One banner position per side. Sunreaver's Sanctuary is Horde: it also holds
	// the Horde Isle of Conquest portal niche and the Sunreaver guardian mages. The
	// Silver Enclave is Alliance, beside the Stormpike and League of Arathor
	// emissaries. Dalaran has two more positions, one per side, spawned identically.
	type spot struct {
		name      string
		short     string
		anchorNPC uint32 // permanent NPC here, waited on to prove the area has streamed
		x, y, z   float32
		ownBanner map[int]uint32 // holiday -> banner that belongs on this side
		foeBanner map[int]uint32 // holiday -> banner that must not be here
	}
	spots := []spot{
		{
			name: "Sunreaver's Sanctuary (Horde)", short: "SunreaverHorde",
			anchorNPC: 29255, // Sunreaver Guardian Mage, 4.6 yd away
			x:         5914.19, y: 554.681, z: 661.245,
			ownBanner: map[int]uint32{eventAlteracValley: goHordeAV, eventArathiBasin: goHordeArathi, eventWarsongGulch: goHordeCTF},
			foeBanner: map[int]uint32{eventAlteracValley: goAllianceAV, eventArathiBasin: goAllianceArathi, eventWarsongGulch: goAllianceCTF},
		},
		{
			name: "Silver Enclave (Alliance)", short: "SilverEnclaveAlliance",
			anchorNPC: 29254, // Silver Covenant Guardian Mage, 18.8 yd away
			x:         5664.81, y: 791.002, z: 653.698,
			ownBanner: map[int]uint32{eventAlteracValley: goAllianceAV, eventArathiBasin: goAllianceArathi, eventWarsongGulch: goAllianceCTF},
			foeBanner: map[int]uint32{eventAlteracValley: goHordeAV, eventArathiBasin: goHordeArathi, eventWarsongGulch: goHordeCTF},
		},
	}
	holidays := []struct {
		id    int
		name  string
		short string
	}{
		{eventAlteracValley, "Alterac Valley", "AlteracValley"},
		{eventArathiBasin, "Arathi Basin", "ArathiBasin"},
		{eventWarsongGulch, "Warsong Gulch (control, already correct)", "WarsongControl"},
	}

	// NewSolo leaves GM mode on, which this test needs: npc_mageguard_dalaran
	// teleports opposite-faction players out of both enclaves and only skips that
	// for a GM. Do not add CombatReady here.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CtaBn", Level: 80})

	for _, s := range spots {
		bot.Teleport(t, s.x, s.y, s.z, mapNorthrend)
		// A far tele clears the object cache and refills it asynchronously, so wait
		// for a permanent neighbour before trusting any "is this banner here" probe.
		// The guardian mages are ordinary spawns; the Call to Arms emissaries beside
		// them are event-linked and would only appear when a holiday is already
		// running, which is the very thing being probed for.
		bot.WaitUnit(t, s.anchorNPC, 20*time.Second)

		for _, h := range holidays {
			// A subtest per position and holiday, so one failure does not mask the
			// rest. That matters for the control: it has to be seen passing even on
			// data where the other two holidays fail.
			t.Run(fmt.Sprintf("%s/%s", s.short, h.short), func(t *testing.T) {
				own := s.ownBanner[h.id]
				foe := s.foeBanner[h.id]

				alreadyRunning := e2eharness.TryNearbyGameObjectByEntry(t, bot.World, own, 2*time.Second) != 0 ||
					e2eharness.TryNearbyGameObjectByEntry(t, bot.World, foe, 2*time.Second) != 0
				if alreadyRunning {
					t.Logf("%s already running; asserting against it and leaving the schedule alone", h.name)
				} else {
					bot.GM(t, fmt.Sprintf(".event start %d", h.id))
					defer bot.GM(t, fmt.Sprintf(".event stop %d", h.id))
				}

				if guid := e2eharness.TryNearbyGameObjectByEntry(t, bot.World, own, 20*time.Second); guid == 0 {
					e2eharness.Assertf(t, "%s during %s: banner %d for this side did not spawn", s.name, h.name, own)
				}
				// The pair spawns together, so by now the wrong one would be here too.
				if guid := e2eharness.TryNearbyGameObjectByEntry(t, bot.World, foe, 3*time.Second); guid != 0 {
					e2eharness.Assertf(t, "%s during %s: banner %d belongs to the other side (guid 0x%X)", s.name, h.name, foe, guid)
				}
				t.Logf("OK %s during %s: %d present, %d absent", s.name, h.name, own, foe)
			})
		}
	}

	bot.AssertWorldAlive(t)
	if !t.Failed() {
		t.Logf("PASS both Dalaran banner positions match their side across three holidays")
	}
}
