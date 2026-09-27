//go:build e2e

package onyxiaslair_test

import (
	"encoding/binary"
	"fmt"
	"math"
	"sort"
	"strings"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	onyxiasLairMap = uint32(249)
	npcOnyxia      = uint32(10184)
	npcWhelp       = uint32(11262)
	goOnyxiaEgg    = uint32(176511)

	spellTeleportSelf = uint32(42527)

	// Sent by GameObject::DespawnOrUnsummon ahead of the destroy, while the egg is still cached.
	smsgGameObjectDespawnAnim = uint16(0x215)
)

type spotKind int

const (
	spotPoint spotKind = iota
	spotLiftoffOnly
	spotEgg
)

type spot struct {
	kind spotKind
	x, y float32
}

func (s spot) String() string {
	return fmt.Sprintf("(%.1f, %.1f)", s.x, s.y)
}

// boss_onyxia.cpp's WhelpSpawnPoints, WhelpLiftoffOnlyPoint and the eight back-row eggs next to
// them, the only eggs a sniffed kill ever hatched. Summons land on the exact coordinates.
var whelpSpots = []spot{
	{spotPoint, -102.75786, -198.85912},
	{spotPoint, -107.54872, -198.04468},
	{spotPoint, -112.76325, -196.49747},
	{spotPoint, -117.191, -196.107},
	{spotPoint, -99.41064, -198.543},
	{spotPoint, -104.5892, -233.16988},
	{spotPoint, -107.39845, -230.61523},
	{spotPoint, -110.02973, -233.42484},
	{spotPoint, -113.6534, -231.24023},
	{spotPoint, -115.66789, -234.56912},
	{spotLiftoffOnly, -107.17814, -232.05528},
	{spotEgg, -103.47102, -199.9189},
	{spotEgg, -106.70401, -235.04318},
	{spotEgg, -106.77378, -227.09634},
	{spotEgg, -111.04669, -201.00967},
	{spotEgg, -111.54843, -199.27588},
	{spotEgg, -112.76019, -232.20369},
	{spotEgg, -113.54922, -198.28697},
	{spotEgg, -114.866, -197.40495},
}

// Closest spots are 1.28y apart, so half a yard cannot pick the wrong one.
const spotTolerance = float32(0.5)

func spotAt(x, y float32) int {
	best, bestDist := -1, float32(math.MaxFloat32)
	for i, s := range whelpSpots {
		if d := float32(math.Hypot(float64(s.x-x), float64(s.y-y))); d < bestDist {
			best, bestDist = i, d
		}
	}
	if bestDist > spotTolerance {
		return -1
	}
	return best
}

func spotsOfKind(kind spotKind) []int {
	var out []int
	for i, s := range whelpSpots {
		if s.kind == kind {
			out = append(out, i)
		}
	}
	return out
}

type whelpSeen struct {
	guid   uint64
	seenAt time.Time
	diedAt time.Time
	x, y   float32
	spot   int
}

type eggHatch struct {
	at   time.Time
	x, y float32
	spot int
}

// whelpObserver records every whelp create with where it appeared and when its health hit 0, and
// every egg despawn with its position, all timed on arrival at the client.
type whelpObserver struct {
	mu        sync.Mutex
	whelps    map[uint64]*whelpSeen
	hatches   []eggHatch
	teleports int
	badEggs   int
	// Without a whelp ever going for the bot, zero teleports would prove nothing.
	targetedBot bool
}

func newWhelpObserver(t *testing.T, bot *e2eharness.ScenarioBot, sampleEvery time.Duration) *whelpObserver {
	o := &whelpObserver{whelps: map[uint64]*whelpSeen{}}

	cancelHook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case smsgGameObjectDespawnAnim:
			if len(data) < 8 {
				return
			}
			guid := binary.LittleEndian.Uint64(data[:8])
			if uint32((guid>>24)&0xFFFFFF) != goOnyxiaEgg {
				return
			}
			now := time.Now()
			egg := bot.World.GetObject(guid)
			o.mu.Lock()
			defer o.mu.Unlock()
			if egg == nil {
				o.badEggs++
				return
			}
			o.hatches = append(o.hatches, eggHatch{at: now, x: egg.PosX, y: egg.PosY, spot: spotAt(egg.PosX, egg.PosY)})
		case client.SmsgSpellGo:
			if id, ok := castSpellID(data); ok && id == spellTeleportSelf {
				o.mu.Lock()
				o.teleports++
				o.mu.Unlock()
			}
		}
	})

	stop := make(chan struct{})
	done := make(chan struct{})
	go func() {
		defer close(done)
		ticker := time.NewTicker(sampleEvery)
		defer ticker.Stop()
		for {
			select {
			case <-stop:
				return
			case <-ticker.C:
			}
			now := time.Now()
			units := bot.World.GetNearbyUnits(250)
			o.mu.Lock()
			for _, u := range units {
				entry := u.Entry
				if entry == 0 {
					entry = uint32((u.GUID >> 24) & 0xFFFFFF)
				}
				if entry != npcWhelp {
					continue
				}
				w, ok := o.whelps[u.GUID]
				if !ok {
					w = &whelpSeen{guid: u.GUID, seenAt: now, x: u.PosX, y: u.PosY, spot: spotAt(u.PosX, u.PosY)}
					o.whelps[u.GUID] = w
				}
				if e2eharness.UnitTargetGUIDFromObj(u) == bot.World.CharGUID() {
					o.targetedBot = true
				}
				if w.diedAt.IsZero() && u.Health() == 0 && u.MaxHealth() > 0 {
					w.diedAt = now
				}
			}
			o.mu.Unlock()
		}
	}()

	t.Cleanup(func() {
		cancelHook()
		close(stop)
		<-done
	})
	return o
}

func (o *whelpObserver) whelpsBetween(from, to time.Time) []whelpSeen {
	o.mu.Lock()
	defer o.mu.Unlock()
	var out []whelpSeen
	for _, w := range o.whelps {
		if !w.seenAt.Before(from) && w.seenAt.Before(to) {
			out = append(out, *w)
		}
	}
	sort.Slice(out, func(i, j int) bool { return out[i].seenAt.Before(out[j].seenAt) })
	return out
}

func (o *whelpObserver) hatchesBetween(from, to time.Time) []eggHatch {
	o.mu.Lock()
	defer o.mu.Unlock()
	var out []eggHatch
	for _, h := range o.hatches {
		if !h.at.Before(from) && h.at.Before(to) {
			out = append(out, h)
		}
	}
	return out
}

func (o *whelpObserver) whelp(guid uint64) whelpSeen {
	o.mu.Lock()
	defer o.mu.Unlock()
	if w, ok := o.whelps[guid]; ok {
		return *w
	}
	return whelpSeen{}
}

func (o *whelpObserver) counters() (teleports, badEggs int, targetedBot bool) {
	o.mu.Lock()
	defer o.mu.Unlock()
	return o.teleports, o.badEggs, o.targetedBot
}

func (o *whelpObserver) waitFirstWhelp(timeout time.Duration, sampleEvery time.Duration) time.Time {
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		o.mu.Lock()
		var first time.Time
		for _, w := range o.whelps {
			if first.IsZero() || w.seenAt.Before(first) {
				first = w.seenAt
			}
		}
		o.mu.Unlock()
		if !first.IsZero() {
			return first
		}
		time.Sleep(sampleEvery)
	}
	return time.Time{}
}

// assertEggHatches checks that the eggs hatched in a window are exactly the eight back-row eggs,
// each once, and that each released one whelp on the egg after Summon Onyxia Whelp's 2s cast.
func assertEggHatches(t *testing.T, what string, hatches []eggHatch, whelps []whelpSeen, delayMin, delayMax time.Duration) {
	t.Helper()
	hatched := map[int]eggHatch{}
	for _, h := range hatches {
		if h.spot < 0 || whelpSpots[h.spot].kind != spotEgg {
			e2eharness.Assertf(t, "%s: egg at (%.1f, %.1f) hatched, not one of the back-row eggs next to the rookery points", what, h.x, h.y)
		}
		if prev, dup := hatched[h.spot]; dup {
			e2eharness.Assertf(t, "%s: egg %s hatched twice, %s apart", what, whelpSpots[h.spot], h.at.Sub(prev.at).Round(time.Millisecond))
		}
		hatched[h.spot] = h
	}
	var missing []string
	for _, i := range spotsOfKind(spotEgg) {
		if _, ok := hatched[i]; !ok {
			missing = append(missing, whelpSpots[i].String())
		}
	}
	if len(missing) > 0 {
		e2eharness.Assertf(t, "%s: %d of 8 back-row eggs hatched, never hatched: %s", what, len(hatched), strings.Join(missing, " "))
	}

	for i, h := range hatched {
		var released []time.Duration
		for _, w := range whelps {
			if w.spot == i && w.seenAt.After(h.at) {
				released = append(released, w.seenAt.Sub(h.at))
			}
		}
		if len(released) != 1 {
			e2eharness.Assertf(t, "%s: egg %s released %d whelps after hatching, want 1 (delays %v)", what, whelpSpots[i], len(released), released)
		}
		if released[0] < delayMin || released[0] > delayMax {
			e2eharness.Assertf(t, "%s: egg %s released its whelp %s after hatching, want %s-%s",
				what, whelpSpots[i], released[0].Round(time.Millisecond), delayMin, delayMax)
		}
	}
}

// Onyxia's phase 2 whelps, measured against a retail sniff of a full kill:
//   - At liftoff one whelp appears on each of ten rookery points plus a liftoff-only point.
//   - Half a second later (the end of Rookery Whelp Spawn-in Spell) each new whelp hatches the
//     nearest standing egg within 4 yards; a whelp appears on the egg 2s later and hatches in turn.
//     That hatches the same eight back-row eggs every wave: 19 whelps at liftoff.
//   - A rookery point respawns its whelp 30-60s after the previous one died, never while it lives,
//     and the liftoff-only point never does. Eggs are back 30s after hatching, so the next wave
//     hatches all eight again: 18 whelps.
//
// The bot fights on the lair floor, which every whelp can walk to, so none may cast Teleport Self.
func TestOnyxia_WhelpCadence(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances"},
		Runtime:  "long",
		Category: "instances/classic/onyxias_lair",
	})

	const (
		// Inside Onyxia's 113y leash and within 80y of every rookery point and egg, so all of
		// them stay in sight on realms that cut instance visibility to 120y.
		padX, padY, padZ = float32(-40.0), float32(-215.0), float32(-84.0)

		sampleEvery = 25 * time.Millisecond
		// Onyxia walks to her takeoff spot after dropping below 65% and yells as she lifts off.
		liftoffWindow = 60 * time.Second
		// All eleven points are summoned in one tick.
		burstSpread = 1500 * time.Millisecond
		// The longest liftoff hatch chain runs three eggs deep, its last whelp 7.5s in.
		burstSettle   = 12 * time.Second
		hatchDelayMin = 1500 * time.Millisecond
		hatchDelayMax = 3 * time.Second
		// 30-60s, widened for the AI update tick and packet delivery.
		respawnMin = 29 * time.Second
		respawnMax = 62 * time.Second
		chainSlack = 12 * time.Second
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "OnyWhp", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80,
	})

	// GM mode stays on through the instance enter.
	bot.Teleport(t, padX, padY, padZ, onyxiasLairMap)
	if _, _, _, m := bot.Pos(); m != onyxiasLairMap {
		e2eharness.Preconditionf(t, "bot not in Onyxia's Lair after the pad tele map=%d", m)
	}
	onyxia := bot.WaitUnit(t, npcOnyxia, 15*time.Second)

	obs := newWhelpObserver(t, bot, sampleEvery)
	if early := obs.waitFirstWhelp(2*time.Second, sampleEvery); !early.IsZero() {
		e2eharness.Preconditionf(t, "whelps already up before the pull; the instance is not fresh")
	}

	// God mode: Deep Breath and the whelps would kill an ungeared bot long before wave two.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.Engage(t, onyxia, 15*time.Second)
	bot.DamageToFraction(t, onyxia, 0.64, 30*time.Second)

	liftoff := obs.waitFirstWhelp(liftoffWindow, sampleEvery)
	if liftoff.IsZero() {
		e2eharness.Preconditionf(t, "no whelp within %s of Onyxia dropping below 65%%", liftoffWindow)
	}
	t.Logf("first whelp at liftoff %s", liftoff.Format(time.StampMilli))

	// Wave one: the liftoff burst and its egg chains.
	time.Sleep(time.Until(liftoff.Add(burstSettle)))
	burstEnd := liftoff.Add(burstSettle)
	burst := obs.whelpsBetween(liftoff, burstEnd)
	burstHatches := obs.hatchesBetween(liftoff, burstEnd)

	for _, w := range burst {
		if w.spot < 0 {
			e2eharness.Assertf(t, "liftoff: whelp 0x%X appeared at (%.1f, %.1f), none of the rookery points or back-row eggs", w.guid, w.x, w.y)
		}
	}
	for _, i := range append(spotsOfKind(spotPoint), spotsOfKind(spotLiftoffOnly)...) {
		var at []time.Duration
		for _, w := range burst {
			if w.spot == i {
				at = append(at, w.seenAt.Sub(liftoff))
			}
		}
		if len(at) != 1 || at[0] > burstSpread {
			e2eharness.Assertf(t, "liftoff: point %s got %d whelps (at %v after the first), want 1 within %s",
				whelpSpots[i], len(at), at, burstSpread)
		}
	}
	assertEggHatches(t, "liftoff", burstHatches, burst, hatchDelayMin, hatchDelayMax)
	if len(burst) != 19 {
		e2eharness.Assertf(t, "liftoff: %d whelps within %s, want 19 (11 points + 8 eggs)", len(burst), burstSettle)
	}
	t.Logf("liftoff: %d whelps, %d eggs hatched", len(burst), len(burstHatches))

	// Kill wave one; each point's respawn is timed from its own whelp's death.
	var guids []uint64
	pointWhelp := map[int]uint64{}
	for _, w := range burst {
		guids = append(guids, w.guid)
		if whelpSpots[w.spot].kind != spotEgg {
			pointWhelp[w.spot] = w.guid
		}
	}
	bot.DamageKill(t, guids, 10_000_000, 30*time.Second)
	killDone := time.Now()

	deathOf := map[int]time.Time{}
	for i, g := range pointWhelp {
		died := obs.whelp(g).diedAt
		if died.IsZero() {
			e2eharness.HarnessFailf(t, "whelp 0x%X at %s never showed 0 health after DamageKill", g, whelpSpots[i])
		}
		deathOf[i] = died
	}

	// Wave two: every point comes back once, 30-60s after its whelp died, and hatches the eggs again.
	waveEnd := killDone.Add(respawnMax + chainSlack)
	time.Sleep(time.Until(waveEnd))
	wave := obs.whelpsBetween(burstEnd, waveEnd)
	waveHatches := obs.hatchesBetween(burstEnd, waveEnd)

	var delays []string
	for _, w := range wave {
		if w.spot < 0 {
			e2eharness.Assertf(t, "wave two: whelp 0x%X appeared at (%.1f, %.1f), none of the rookery points or back-row eggs", w.guid, w.x, w.y)
		}
		if whelpSpots[w.spot].kind == spotLiftoffOnly {
			e2eharness.Assertf(t, "wave two: the liftoff-only point %s respawned a whelp %s after liftoff",
				whelpSpots[w.spot], w.seenAt.Sub(liftoff).Round(time.Millisecond))
		}
	}
	for _, i := range spotsOfKind(spotPoint) {
		var at []time.Duration
		for _, w := range wave {
			if w.spot == i {
				at = append(at, w.seenAt.Sub(deathOf[i]))
			}
		}
		if len(at) != 1 {
			e2eharness.Assertf(t, "wave two: point %s got %d whelps after its whelp died (at %v), want 1", whelpSpots[i], len(at), at)
		}
		if at[0] < respawnMin || at[0] > respawnMax {
			e2eharness.Assertf(t, "wave two: point %s respawned %s after its whelp died, want %s-%s",
				whelpSpots[i], at[0].Round(time.Millisecond), respawnMin, respawnMax)
		}
		delays = append(delays, fmt.Sprintf("%s=%.1fs", whelpSpots[i], at[0].Seconds()))
	}
	assertEggHatches(t, "wave two", waveHatches, wave, hatchDelayMin, hatchDelayMax)
	if len(wave) != 18 {
		e2eharness.Assertf(t, "wave two: %d whelps, want 18 (10 points + 8 eggs)", len(wave))
	}
	t.Logf("wave two: %d whelps, %d eggs hatched, respawn after death: %s", len(wave), len(waveHatches), strings.Join(delays, " "))

	teleports, badEggs, targetedBot := obs.counters()
	if badEggs > 0 {
		e2eharness.HarnessFailf(t, "%d egg despawns arrived for eggs missing from the object cache", badEggs)
	}
	if !targetedBot {
		e2eharness.Assertf(t, "no whelp ever targeted the bot, so the Teleport Self check below would pass without a chase")
	}
	if teleports > 0 {
		e2eharness.Assertf(t, "%d whelps cast Teleport Self at a bot standing on the lair floor they can walk to", teleports)
	}
	t.Logf("PASS whelps: 19 at liftoff, 18 in wave two, points respawn 30-60s after death, no teleports")
}

// castSpellID pulls the spell id out of an SMSG_SPELL_GO header: cast-item and caster packed
// GUIDs, then a cast counter. The harness exposes neither the header nor a packed-GUID reader.
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
	off++
	if off+4 > len(data) {
		return 0, false
	}
	return binary.LittleEndian.Uint32(data[off : off+4]), true
}
