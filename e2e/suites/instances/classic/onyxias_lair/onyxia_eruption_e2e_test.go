//go:build e2e

package onyxiaslair_test

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"io"
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
	spellBellowingRoar = uint32(18431)
	spellFireball      = uint32(18392)
	spellFireball25    = uint32(68926)
	spellEruption      = uint32(17731)
	spellEruption25    = uint32(69294)

	smsgGameObjectCustomAnim = uint16(0x0B3)
)

// The Lava Fissures that sit above the lair floor. Retail sniffs show only these passing an
// Eruption on; a fissure sunk below the floor erupts when hit but its own Eruption hits nothing.
var lavaFissuresAboveFloor = map[uint32]bool{
	176811: true, 176814: true, 176821: true, 176824: true, 176827: true, 176829: true,
	176830: true, 176839: true, 176841: true, 176908: true, 176921: true,
}

// The 52 Lava Fissure templates; each has exactly one spawn on map 249.
func isLavaFissure(entry uint32) bool {
	return (entry >= 176513 && entry <= 176515) || (entry >= 176809 && entry <= 176842) ||
		(entry >= 176908 && entry <= 176922)
}

type castSeen struct {
	at     time.Time
	caster uint64
	spell  uint32
	// The Lava Fissures the cast hit, from its SMSG_SPELL_GO.
	hits map[uint32]bool
	// Where a Roar was cast from: Onyxia's position as the server had it when it landed.
	x, y, z float32
	hasSrc  bool
}

type animSeen struct {
	at   time.Time
	guid uint64
}

type eruptionObserver struct {
	mu         sync.Mutex
	fireballAt time.Time
	roarStarts []castSeen
	roarGos    []castSeen
	eruptions  []castSeen
	anims      []animSeen
}

func newEruptionObserver(t *testing.T, bot *e2eharness.ScenarioBot, onyxia uint64) *eruptionObserver {
	o := &eruptionObserver{}
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		now := time.Now()
		switch opcode {
		case client.SmsgSpellStart, client.SmsgSpellGo:
			caster, spell, ok := castHeader(data)
			if !ok {
				return
			}
			o.mu.Lock()
			defer o.mu.Unlock()
			switch {
			case caster == onyxia && (spell == spellFireball || spell == spellFireball25) && o.fireballAt.IsZero():
				o.fireballAt = now
			case caster == onyxia && spell == spellBellowingRoar:
				c := castSeen{at: now, caster: caster, spell: spell}
				if opcode == client.SmsgSpellStart {
					o.roarStarts = append(o.roarStarts, c)
					return
				}
				o.roarGos = append(o.roarGos, withTargets(c, data))
			case opcode == client.SmsgSpellGo && (spell == spellEruption || spell == spellEruption25):
				o.eruptions = append(o.eruptions, withTargets(castSeen{at: now, caster: caster, spell: spell}, data))
			}
		case smsgGameObjectCustomAnim:
			if len(data) < 12 {
				return
			}
			guid := binary.LittleEndian.Uint64(data[:8])
			if !isLavaFissure(uint32((guid >> 24) & 0xFFFFFF)) {
				return
			}
			o.mu.Lock()
			o.anims = append(o.anims, animSeen{at: now, guid: guid})
			o.mu.Unlock()
		}
	})
	t.Cleanup(cancel)
	return o
}

func (o *eruptionObserver) firstFireball() time.Time {
	o.mu.Lock()
	defer o.mu.Unlock()
	return o.fireballAt
}

func (o *eruptionObserver) snapshot() (starts, gos, eruptions []castSeen, anims []animSeen) {
	o.mu.Lock()
	defer o.mu.Unlock()
	return append([]castSeen(nil), o.roarStarts...), append([]castSeen(nil), o.roarGos...),
		append([]castSeen(nil), o.eruptions...), append([]animSeen(nil), o.anims...)
}

type landingSeen struct {
	start  time.Time
	length time.Duration
	fromZ  float32
	toZ    float32
}

// watchLanding records the first of Onyxia's splines that drops her 10y or more: the phase 3
// landing. It parses SMSG_MONSTER_MOVE itself because the harness reads the animation fields
// under the wrong flag bit, which garbles the duration of MoveLand's animated spline.
func watchLanding(t *testing.T, bot *e2eharness.ScenarioBot, onyxia uint64) func() landingSeen {
	var mu sync.Mutex
	var seen landingSeen
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgMonsterMove {
			return
		}
		guid, fromZ, toZ, length, ok := monsterMoveDrop(data)
		if !ok || guid != onyxia || fromZ-toZ < 10 {
			return
		}
		mu.Lock()
		defer mu.Unlock()
		if seen.start.IsZero() {
			seen = landingSeen{start: time.Now(), length: length, fromZ: fromZ, toZ: toZ}
		}
	})
	t.Cleanup(cancel)
	return func() landingSeen {
		mu.Lock()
		defer mu.Unlock()
		return seen
	}
}

// monsterMoveDrop reads an SMSG_MONSTER_MOVE as AzerothCore's PacketBuilder writes it: the mover's
// packed GUID, a byte, the start point, the spline id, the facing, the flags, the animation and
// parabolic extras when flagged, the duration, then the path.
func monsterMoveDrop(data []byte) (guid uint64, fromZ, toZ float32, length time.Duration, ok bool) {
	const (
		flagFlying     = 0x00002000
		flagCatmullrom = 0x00040000
		flagAnimation  = 0x00200000
		flagParabolic  = 0x00000800
	)
	off := 0
	u32 := func() (uint32, bool) {
		if off+4 > len(data) {
			return 0, false
		}
		v := binary.LittleEndian.Uint32(data[off:])
		off += 4
		return v, true
	}
	f32 := func() (float32, bool) {
		v, ok := u32()
		return math.Float32frombits(v), ok
	}

	if off >= len(data) {
		return
	}
	mask := data[off]
	off++
	for bit := 0; bit < 8; bit++ {
		if mask&(1<<uint(bit)) == 0 {
			continue
		}
		if off >= len(data) {
			return
		}
		guid |= uint64(data[off]) << (8 * uint(bit))
		off++
	}
	off++    // unk byte
	off += 8 // start x, y
	if fromZ, ok = f32(); !ok {
		return
	}
	off += 4 // spline id
	if off >= len(data) {
		return 0, 0, 0, 0, false
	}
	facing := data[off]
	off++
	switch facing {
	case 1: // stop: no path follows
		return 0, 0, 0, 0, false
	case 2:
		off += 12
	case 3:
		off += 8
	case 4:
		off += 4
	}
	flags, ok := u32()
	if !ok {
		return
	}
	if flags&flagAnimation != 0 {
		off += 1 + 4
	}
	duration, ok := u32()
	if !ok {
		return
	}
	if flags&flagParabolic != 0 {
		off += 4 + 4
	}
	count, ok := u32()
	if !ok || count == 0 {
		return 0, 0, 0, 0, false
	}
	if flags&(flagFlying|flagCatmullrom) != 0 {
		off += int(count-1)*12 + 8 // every point in full; skip to the last one's z
	} else {
		off += 8 // linear paths send the destination first, then packed offsets
	}
	if toZ, ok = f32(); !ok {
		return
	}
	return guid, fromZ, toZ, time.Duration(duration) * time.Millisecond, true
}

type fissurePos struct{ x, y, z float32 }

func loadLavaFissures(t *testing.T) map[uint32]fissurePos {
	t.Helper()
	db, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.Preconditionf(t, "world DB: %v", err)
	}
	defer db.Close()
	rows, err := db.Query("SELECT `id`, `position_x`, `position_y`, `position_z` FROM `gameobject` WHERE `map` = ?", onyxiasLairMap)
	if err != nil {
		e2eharness.Preconditionf(t, "load Onyxia's Lair gameobjects: %v", err)
	}
	defer rows.Close()
	out := map[uint32]fissurePos{}
	for rows.Next() {
		var id uint32
		var p fissurePos
		if err := rows.Scan(&id, &p.x, &p.y, &p.z); err != nil {
			e2eharness.Preconditionf(t, "scan gameobject: %v", err)
		}
		if isLavaFissure(id) {
			out[id] = p
		}
	}
	if len(out) != 52 {
		e2eharness.Preconditionf(t, "found %d Lava Fissure spawns on map %d, want 52", len(out), onyxiasLairMap)
	}
	return out
}

func dist3(ax, ay, az, bx, by, bz float32) float32 {
	return float32(math.Sqrt(float64((ax-bx)*(ax-bx) + (ay-by)*(ay-by) + (az-bz)*(az-bz))))
}

// Phase 3 Eruption, measured against retail sniffs: Bellowing Roar's own activate-object effect
// sets off every Lava Fissure within 13y of Onyxia when the cast lands, and each fissure casts
// Eruption itself. Only a fissure above the lair floor passes it on, to every fissure within 13y
// in the same tick, so a Roar erupts a cluster around her and never the whole floor. Every hit
// plays the fissure's crack animation. A fissure's 10s trap cooldown keeps it from erupting twice
// in a row, and nothing erupts before a Roar lands. Who hit what is read from each cast's
// SMSG_SPELL_GO hit list, and the Roar's reach from the position it was cast from, since the
// client's cached position for Onyxia is only where her last spline started.
// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/27843
func TestOnyxia_EruptionFollowsBellowingRoar(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances"},
		Runtime:  "long",
		Category: "instances/classic/onyxias_lair",
	})

	const (
		// West of fissures 176827-176830. Onyxia chasing the bot Roars from among them, and the ones
		// above the floor pass the Eruption on to fissures well beyond her reach, so every run has
		// eruptions that only a working chain sets off.
		padX, padY, padZ = float32(-37.0), float32(-205.0), float32(-87.5)

		sampleEvery = 100 * time.Millisecond
		// Walk to the takeoff spot, a ~10s climb, the flight north, then the first Fireball.
		airborneBy = 60 * time.Second
		// Up to a 3s Fireball, a ~10s descent, 2s on the ground, then a Roar every 22-26s.
		roarsBy   = 90 * time.Second
		wantRoars = 2

		roarRadius      = float32(13)
		fissureRadius   = float32(13)
		mustEruptWithin = float32(11)
		rangeSlack      = float32(2)
		// The Roar and every Eruption it chains into are cast in one server tick.
		eruptLead  = 250 * time.Millisecond
		eruptTrail = time.Second
		// Lava Fissure trap cooldown, less a margin for packet timing.
		fissureCooldown = 9500 * time.Millisecond

		// Retail: 9.87s from 25y up. Onyxia flies 25-29y above the floor.
		landingMin = 8 * time.Second
		landingMax = 13 * time.Second
		// Retail: 2.0s. Widened for the AI update tick and packet delivery.
		roarAfterTouchdownMin = 1500 * time.Millisecond
		roarAfterTouchdownMax = 3500 * time.Millisecond
	)

	fissures := loadLavaFissures(t)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "OnyErp", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80,
	})

	// GM mode stays on through the instance enter.
	bot.Teleport(t, padX, padY, padZ, onyxiasLairMap)
	if _, _, _, m := bot.Pos(); m != onyxiasLairMap {
		e2eharness.Preconditionf(t, "bot not in Onyxia's Lair after the pad tele map=%d", m)
	}
	onyxia := bot.WaitUnit(t, npcOnyxia, 15*time.Second)
	obs := newEruptionObserver(t, bot, onyxia)

	// God mode: Deep Breath, Eruption and the whelps would kill an ungeared bot.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.Engage(t, onyxia, 15*time.Second)
	bot.DamageToFraction(t, onyxia, 0.64, 30*time.Second)

	// Only drop her to 40% once she has reached a waypoint at flight height, as in the sniff: her
	// Fireballs are only cast there. The cached position alone passes while she is still climbing.
	for deadline := time.Now().Add(airborneBy); obs.firstFireball().IsZero(); {
		if time.Now().After(deadline) {
			e2eharness.Preconditionf(t, "Onyxia cast no Fireball within %s of dropping below 65%%", airborneBy)
		}
		time.Sleep(sampleEvery)
	}
	landing := watchLanding(t, bot, onyxia)
	bot.DamageToFraction(t, onyxia, 0.39, 30*time.Second)
	phase3At := time.Now()

	for deadline := time.Now().Add(roarsBy); ; {
		if _, gos, _, _ := obs.snapshot(); len(gos) >= wantRoars {
			break
		}
		if time.Now().After(deadline) {
			_, gos, _, _ := obs.snapshot()
			e2eharness.Assertf(t, "%d Bellowing Roars landed within %s of Onyxia dropping below 40%%, want %d", len(gos), roarsBy, wantRoars)
		}
		time.Sleep(sampleEvery)
	}
	// Let the last Roar's eruptions arrive.
	time.Sleep(eruptTrail)
	starts, gos, eruptions, anims := obs.snapshot()

	// The landing: straight down from the flight, about 10s at 2.5y/s, then the first Roar 2s
	// after touchdown.
	land := landing()
	if land.start.IsZero() {
		e2eharness.Assertf(t, "no spline dropped Onyxia 10y or more after she was damaged below 40%%")
	}
	if land.length < landingMin || land.length > landingMax {
		e2eharness.Assertf(t, "landing from z %.1f to %.1f took %s, want %s-%s",
			land.fromZ, land.toZ, land.length.Round(time.Millisecond), landingMin, landingMax)
	}
	if len(starts) == 0 {
		e2eharness.HarnessFailf(t, "Bellowing Roar landed %d times but no SMSG_SPELL_START for it arrived", len(gos))
	}
	touchdown := land.start.Add(land.length)
	if gap := starts[0].at.Sub(touchdown); gap < roarAfterTouchdownMin || gap > roarAfterTouchdownMax {
		e2eharness.Assertf(t, "first Bellowing Roar started %s after touchdown, want %s-%s",
			gap.Round(time.Millisecond), roarAfterTouchdownMin, roarAfterTouchdownMax)
	}
	t.Logf("landing: descent from z %.1f to %.1f began %+.1fs from the 39%% damage and took %s, first Roar %s after touchdown",
		land.fromZ, land.toZ, land.start.Sub(phase3At).Seconds(),
		land.length.Round(time.Millisecond), starts[0].at.Sub(touchdown).Round(time.Millisecond))

	fissureOf := func(guid uint64) (uint32, fissurePos, bool) {
		entry := uint32((guid >> 24) & 0xFFFFFF)
		p, ok := fissures[entry]
		return entry, p, ok
	}

	// Every Eruption comes from a fissure, inside the tick of a landing Roar.
	windowOf := make([]int, len(eruptions))
	for i, e := range eruptions {
		if _, _, ok := fissureOf(e.caster); !ok {
			e2eharness.Assertf(t, "Eruption %d cast by 0x%X, not a Lava Fissure", e.spell, e.caster)
		}
		windowOf[i] = -1
		for r, g := range gos {
			if !e.at.Before(g.at.Add(-eruptLead)) && !e.at.After(g.at.Add(eruptTrail)) {
				windowOf[i] = r
				break
			}
		}
		if windowOf[i] < 0 {
			var near []string
			for _, s := range starts {
				near = append(near, fmt.Sprintf("start %+.1fs", e.at.Sub(s.at).Seconds()))
			}
			e2eharness.Assertf(t, "fissure 0x%X erupted %s after Onyxia dropped below 40%% but not when a Bellowing Roar landed (%s)",
				e.caster, e.at.Sub(phase3At).Round(time.Millisecond), strings.Join(near, ", "))
		}
	}

	// No fissure erupts twice inside its trap cooldown.
	byFissure := map[uint64][]time.Time{}
	for _, e := range eruptions {
		byFissure[e.caster] = append(byFissure[e.caster], e.at)
	}
	for guid, times := range byFissure {
		sort.Slice(times, func(i, j int) bool { return times[i].Before(times[j]) })
		for i := 1; i < len(times); i++ {
			if gap := times[i].Sub(times[i-1]); gap < fissureCooldown {
				entry, _, _ := fissureOf(guid)
				e2eharness.Assertf(t, "fissure %d erupted twice %s apart, inside its 10s trap cooldown", entry, gap.Round(time.Millisecond))
			}
		}
	}

	// Per Roar, judged from the hit lists the server sent: the Roar hits every fissure near Onyxia, an
	// erupting fissure above the floor hits every fissure near it and a sunk one hits none, everything
	// hit erupts unless its cooldown still runs, nothing else erupts, and every erupting fissure plays
	// its crack animation.
	judged, chainedTotal := 0, 0
	var summary []string
	for r, g := range gos {
		if !g.hasSrc {
			e2eharness.HarnessFailf(t, "Roar %d: SMSG_SPELL_GO carried no source location to place Onyxia by", r+1)
		}
		erupted := map[uint32]castSeen{}
		for i, e := range eruptions {
			if windowOf[i] == r {
				entry, _, _ := fissureOf(e.caster)
				erupted[entry] = e
			}
		}

		t.Logf("roar %d: Onyxia at (%.1f, %.1f, %.1f), hit %s, erupted %s",
			r+1, g.x, g.y, g.z, fissureNames(g.hits), fissureNames(erupted))

		// What set each fissure off this Roar.
		hitBy := map[uint32]string{}
		for entry := range g.hits {
			p := fissures[entry]
			if d := dist3(g.x, g.y, g.z, p.x, p.y, p.z); d > roarRadius+rangeSlack {
				e2eharness.Assertf(t, "Roar %d hit fissure %d %.1fy from Onyxia, beyond its %.0fy", r+1, entry, d, roarRadius)
			}
			hitBy[entry] = "the Roar"
		}
		for entry, p := range fissures {
			if d := dist3(g.x, g.y, g.z, p.x, p.y, p.z); d <= mustEruptWithin && !g.hits[entry] {
				e2eharness.Assertf(t, "Roar %d missed fissure %d %.1fy from Onyxia", r+1, entry, d)
			}
		}

		for source, e := range erupted {
			if e.hits == nil {
				e2eharness.HarnessFailf(t, "Roar %d: could not read the hit list of fissure %d's Eruption", r+1, source)
			}
			if !lavaFissuresAboveFloor[source] {
				if len(e.hits) > 0 {
					e2eharness.Assertf(t, "Roar %d: fissure %d sits below the floor, yet its Eruption hit %s; only fissures above the floor pass an Eruption on",
						r+1, source, fissureNames(e.hits))
				}
				continue
			}
			s := fissures[source]
			for entry := range e.hits {
				p := fissures[entry]
				if d := dist3(s.x, s.y, s.z, p.x, p.y, p.z); d > fissureRadius+rangeSlack {
					e2eharness.Assertf(t, "Roar %d: fissure %d's Eruption hit fissure %d %.1fy away, beyond its %.0fy", r+1, source, entry, d, fissureRadius)
				}
				if _, ok := hitBy[entry]; !ok {
					hitBy[entry] = fmt.Sprintf("fissure %d's Eruption", source)
				}
			}
			for entry, p := range fissures {
				if d := dist3(s.x, s.y, s.z, p.x, p.y, p.z); entry != source && d <= mustEruptWithin && !e.hits[entry] {
					e2eharness.Assertf(t, "Roar %d: fissure %d's Eruption missed fissure %d %.1fy away", r+1, source, entry, d)
				}
			}
		}

		for entry, by := range hitBy {
			if _, ok := erupted[entry]; ok {
				continue
			}
			// A fissure still on cooldown from the previous Roar stays quiet.
			onCooldown := false
			for _, e := range eruptions {
				if en, _, _ := fissureOf(e.caster); en == entry && e.at.Before(g.at.Add(-eruptLead)) && g.at.Sub(e.at) < 10*time.Second {
					onCooldown = true
				}
			}
			if !onCooldown {
				e2eharness.Assertf(t, "Roar %d: fissure %d was hit by %s but did not erupt", r+1, entry, by)
			}
		}

		direct, chained := 0, 0
		for entry, e := range erupted {
			switch by, ok := hitBy[entry]; {
			case !ok:
				e2eharness.Assertf(t, "Roar %d: fissure %d erupted without being hit by the Roar or by an erupting fissure above the floor", r+1, entry)
			case by == "the Roar":
				direct++
			default:
				chained++
			}
			animated := false
			for _, a := range anims {
				if a.guid == e.caster && !a.at.Before(g.at.Add(-eruptLead)) && !a.at.After(g.at.Add(eruptTrail)) {
					animated = true
					break
				}
			}
			if !animated {
				e2eharness.Assertf(t, "Roar %d: fissure %d erupted without a crack animation", r+1, entry)
			}
		}
		if len(erupted) > 0 {
			judged++
		}
		chainedTotal += chained
		summary = append(summary, fmt.Sprintf("roar %d at %+.1fs: %d fissures (%d direct, %d chained)",
			r+1, g.at.Sub(phase3At).Seconds(), len(erupted), direct, chained))
	}
	if judged == 0 {
		e2eharness.Preconditionf(t, "none of the %d Roars landed near a Lava Fissure: %s", len(gos), strings.Join(summary, "; "))
	}
	if chainedTotal == 0 {
		e2eharness.Preconditionf(t, "no fissure erupted only through a chain, so passing an Eruption on went unjudged; Onyxia Roared too far from the pad's cluster: %s",
			strings.Join(summary, "; "))
	}

	t.Logf("%s", strings.Join(summary, "; "))
	t.Logf("PASS eruptions: %d Roars, %d Eruptions (%d only through a chain), %d crack animations, all set off by a landing Roar and chained only through fissures above the floor, none inside a fissure's cooldown",
		len(gos), len(eruptions), chainedTotal, len(anims))
}

func fissureNames[V any](set map[uint32]V) string {
	var names []string
	for entry := range set {
		names = append(names, fmt.Sprint(entry))
	}
	sort.Strings(names)
	return strings.Join(names, " ")
}

// withTargets adds what an SMSG_SPELL_GO says about c's targets: the Lava Fissures it hit and, for a
// cast from the caster's own position, where that was. hits stays nil when the packet cannot be read.
func withTargets(c castSeen, data []byte) castSeen {
	hits, src, hasSrc, ok := spellGoTargets(data)
	if !ok {
		return c
	}
	c.hits = map[uint32]bool{}
	for _, guid := range hits {
		if high := uint16(guid >> 48); high != 0xF110 && high != 0xF111 {
			continue
		}
		if entry := uint32((guid >> 24) & 0xFFFFFF); isLavaFissure(entry) {
			c.hits[entry] = true
		}
	}
	c.x, c.y, c.z, c.hasSrc = src[0], src[1], src[2], hasSrc
	return c
}

// spellGoTargets reads an SMSG_SPELL_GO as Spell::SendSpellGo writes it: the cast-item and caster
// packed GUIDs, the cast counter, spell id, cast flags and timestamp, the hit GUIDs, the misses, then
// SpellCastTargets::Write, of which only the source location is kept.
func spellGoTargets(data []byte) (hits []uint64, src [3]float32, hasSrc, ok bool) {
	const (
		targetFlagUnit           = 0x00000002
		targetFlagItem           = 0x00000010
		targetFlagSourceLocation = 0x00000020
		targetFlagCorpseEnemy    = 0x00000200
		targetFlagGameObject     = 0x00000800
		targetFlagTradeItem      = 0x00001000
		targetFlagCorpseAlly     = 0x00008000
		targetFlagUnitMinipet    = 0x00010000
		spellMissReflect         = 11
	)
	r := bytes.NewReader(data)
	for i := 0; i < 2; i++ {
		if _, err := readPackedGUID(r); err != nil {
			return
		}
	}
	var head struct {
		CastCount          uint8
		Spell, Flags, Time uint32
	}
	if binary.Read(r, binary.LittleEndian, &head) != nil {
		return
	}
	var count uint8
	if binary.Read(r, binary.LittleEndian, &count) != nil {
		return
	}
	hits = make([]uint64, count)
	if binary.Read(r, binary.LittleEndian, hits) != nil {
		return
	}
	if binary.Read(r, binary.LittleEndian, &count) != nil {
		return
	}
	for i := 0; i < int(count); i++ {
		var miss struct {
			GUID   uint64
			Reason uint8
		}
		if binary.Read(r, binary.LittleEndian, &miss) != nil {
			return
		}
		if miss.Reason == spellMissReflect {
			if _, err := r.ReadByte(); err != nil {
				return
			}
		}
	}
	var mask uint32
	if binary.Read(r, binary.LittleEndian, &mask) != nil {
		return
	}
	if mask&(targetFlagUnit|targetFlagCorpseAlly|targetFlagGameObject|targetFlagCorpseEnemy|targetFlagUnitMinipet) != 0 {
		if _, err := readPackedGUID(r); err != nil {
			return
		}
	}
	if mask&(targetFlagItem|targetFlagTradeItem) != 0 {
		if _, err := readPackedGUID(r); err != nil {
			return
		}
	}
	if mask&targetFlagSourceLocation != 0 {
		// The transport GUID the position is relative to, empty on the lair floor.
		if _, err := readPackedGUID(r); err != nil {
			return
		}
		if binary.Read(r, binary.LittleEndian, &src) != nil {
			return
		}
		hasSrc = true
	}
	return hits, src, hasSrc, true
}

func readPackedGUID(r io.ByteReader) (uint64, error) {
	mask, err := r.ReadByte()
	if err != nil {
		return 0, err
	}
	var guid uint64
	for bit := 0; bit < 8; bit++ {
		if mask&(1<<uint(bit)) == 0 {
			continue
		}
		b, err := r.ReadByte()
		if err != nil {
			return 0, err
		}
		guid |= uint64(b) << (8 * uint(bit))
	}
	return guid, nil
}

// castHeader reads the caster GUID and spell id from an SMSG_SPELL_START or SMSG_SPELL_GO header:
// cast-item packed GUID, caster packed GUID, cast counter, spell id.
func castHeader(data []byte) (caster uint64, spell uint32, ok bool) {
	off := 0
	var guids [2]uint64
	for i := 0; i < 2; i++ {
		if off >= len(data) {
			return 0, 0, false
		}
		mask := data[off]
		off++
		for bit := 0; bit < 8; bit++ {
			if mask&(1<<uint(bit)) == 0 {
				continue
			}
			if off >= len(data) {
				return 0, 0, false
			}
			guids[i] |= uint64(data[off]) << (8 * uint(bit))
			off++
		}
	}
	off++
	if off+4 > len(data) {
		return 0, 0, false
	}
	return guids[1], binary.LittleEndian.Uint32(data[off : off+4]), true
}
