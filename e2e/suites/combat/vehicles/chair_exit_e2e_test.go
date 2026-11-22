//go:build e2e

package vehicles_test

import (
	"fmt"
	"math"
	"regexp"
	"strconv"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const creatureTurkeyChair uint32 = 34812

// Mulgore plains 0.25 yd under the ground. Chairs on a Bountiful Table keep the table's Z beside it, which
// puts many of them this far under the ground or more (up to 0.59 yd at Goldshire's guid 52737).
var sunkenChairSpot = e2eharness.Position3{X: -1374.33, Y: 445.73, Z: 83.99, O: 0, Map: e2eharness.MapKalimdor}

var (
	gpsPosRe   = regexp.MustCompile(`X: (\S+) Y: (\S+) Z: (\S+) Orientation`)
	gpsFloorRe = regexp.MustCompile(`FloorZ: (\S+) `)
)

type gpsReading struct{ x, y, z, floorZ float64 }

func parseFloats(raw ...[]byte) ([]float64, bool) {
	vals := make([]float64, len(raw))
	for i, r := range raw {
		v, err := strconv.ParseFloat(string(r), 64)
		if err != nil {
			return nil, false
		}
		vals[i] = v
	}
	return vals, true
}

// readGps returns the server's position of the bot and the floor under it, from `.gps` on itself.
// Each line of the reply is its own SMSG_MESSAGECHAT; the position line comes before the floor line.
func readGps(t *testing.T, bot *e2eharness.ScenarioBot) gpsReading {
	t.Helper()
	got := make(chan gpsReading, 1)
	var mu sync.Mutex
	var pos []float64
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgMessageChat {
			return
		}
		mu.Lock()
		defer mu.Unlock()
		if m := gpsPosRe.FindSubmatch(data); m != nil {
			pos, _ = parseFloats(m[1], m[2], m[3])
			return
		}
		m := gpsFloorRe.FindSubmatch(data)
		if m == nil || pos == nil {
			return
		}
		floor, ok := parseFloats(m[1])
		if !ok {
			return
		}
		select {
		case got <- gpsReading{pos[0], pos[1], pos[2], floor[0]}:
		default:
		}
	})
	defer cancel()

	if err := bot.World.SetTarget(0); err != nil {
		e2eharness.HarnessFailf(t, "clear target before .gps: %v", err)
	}
	bot.GM(t, ".gps")
	select {
	case r := <-got:
		return r
	case <-time.After(5 * time.Second):
		e2eharness.HarnessFailf(t, "no position reply to .gps")
	}
	return gpsReading{}
}

// settledGps waits for the exit spline to finish, i.e. two equal `.gps` positions in a row.
func settledGps(t *testing.T, bot *e2eharness.ScenarioBot) gpsReading {
	t.Helper()
	prev := readGps(t, bot)
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		time.Sleep(200 * time.Millisecond)
		cur := readGps(t, bot)
		if cur.x == prev.x && cur.y == prev.y && cur.z == prev.z {
			return cur
		}
		prev = cur
	}
	e2eharness.HarnessFailf(t, "position still changing 5s after leaving the chair")
	return gpsReading{}
}

// https://github.com/azerothcore/azerothcore-wotlk/pull/28542
// Leaving a vehicle sends the passenger to the vehicle's own position. Pilgrim's Bounty chairs sit beside
// their table at the table's Z, often a little under the ground, and leaving one dropped the player
// through the world. The exit must end on the floor.
func TestVehicles_ChairExitUnderFloorLandsOnFloor(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/vehicles"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "VehCh", Level: 80})
	p := sunkenChairSpot
	e2eharness.MustGMTeleport(t, bot.World, fmt.Sprintf(".go xyz %.2f %.2f %.2f %d %.2f", p.X, p.Y, p.Z, p.Map, p.O))
	spot := readGps(t, bot)
	if spot.floorZ-spot.z < 0.1 {
		e2eharness.Preconditionf(t, "chair spot Z %.2f is not under the floor (%.2f); the fixture no longer exercises the exit",
			spot.z, spot.floorZ)
	}

	chair := bot.Spawn(t, creatureTurkeyChair, 15*time.Second)
	bot.EnterVehicle(t, chair, 12*time.Second)
	bot.ExitVehicle(t, 12*time.Second)

	r := settledGps(t, bot)
	t.Logf("chair 0x%X at Z %.2f: exit at (%.2f, %.2f, %.2f), floor %.2f", chair, spot.z, r.x, r.y, r.z, spot.floorZ)
	// The chair stands where the bot spawned it, so the exit must stay on that spot. The floor measured there
	// before boarding is the reference: a lookup at the exit point finds nothing once it is 2 yd or more under.
	if math.Hypot(r.x-spot.x, r.y-spot.y) > 0.1 {
		e2eharness.Assertf(t, "exit at (%.2f, %.2f) left the chair spot (%.2f, %.2f)", r.x, r.y, spot.x, spot.y)
	}
	if r.z < spot.floorZ-0.05 {
		e2eharness.Assertf(t, "exit Z %.2f is %.2f yd under the floor (%.2f)", r.z, spot.floorZ-r.z, spot.floorZ)
	}
	t.Logf("PASS chair exit lands on the floor")
}
