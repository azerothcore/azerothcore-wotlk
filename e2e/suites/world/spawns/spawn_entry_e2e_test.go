//go:build e2e

package spawns_test

import (
	"database/sql"
	"encoding/binary"
	"fmt"
	"math"
	"sort"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/28488
//
// A spawn point can list the entries it spawns as (`creature_spawn_entry`,
// `gameobject_spawn_entry`), and a spawn group can limit the entries of its members
// (`spawn_group_entry`). These tests read the lists from the world database, so they
// follow the data, and assert what a player sees on the spawn points.
//
// Respawns are forced with GM commands (`.respawn creature guid`, `.gobject respawn`)
// so a cycle takes seconds, not the spawn's own timer. The commands only set the timer
// to now; the entry is rolled by the same code a natural respawn runs.

const (
	mapKalimdor  = uint32(1)
	mapNorthrend = uint32(571)
	mapZulGurub  = uint32(309)

	rocketCarRubble   = uint32(19868) // any entry of the Shimmering Flats rubble set
	injuredWarsong    = uint32(27106) // any entry of the Injured Warsong set
	zgSnakePackGroup  = uint32(105)
	questRocketParts  = uint32(1110)
	spellOpeningKneel = uint32(6478) // Opening, lock type 13: what lock 43 of the rubble asks for

	spotRadius = float32(3) // a spawn's object is looked for this close to its point
)

type spawnPoint struct {
	spawnID uint32
	ownID   uint32
	x, y, z float32
	entries []uint32
}

func (s spawnPoint) lists(entry uint32) bool {
	for _, e := range s.entries {
		if e == entry {
			return true
		}
	}
	return false
}

func worldDB(t *testing.T) *sql.DB {
	t.Helper()
	db, err := e2eharness.OpenWorldDB()
	if err != nil {
		e2eharness.HarnessFailf(t, "world DB: %v", err)
	}
	t.Cleanup(func() { _ = db.Close() })
	return db
}

// spawnPoints returns every spawn of `table` (creature or gameobject) on mapID whose
// entry list contains `anyEntry`, each with its whole list.
func spawnPoints(t *testing.T, db *sql.DB, table string, mapID, anyEntry uint32) []spawnPoint {
	t.Helper()
	query := fmt.Sprintf("SELECT s.guid, s.id, s.position_x, s.position_y, s.position_z, e.entry "+
		"FROM `%s` s JOIN `%s_spawn_entry` e ON e.guid = s.guid "+
		"WHERE s.map = ? AND s.guid IN (SELECT guid FROM `%s_spawn_entry` WHERE entry = ?) "+
		"ORDER BY s.guid, e.Idx", table, table, table)
	rows, err := db.Query(query, mapID, anyEntry)
	if err != nil {
		e2eharness.Preconditionf(t, "%s_spawn_entry is not readable (pending SQL not applied?): %v", table, err)
	}
	defer rows.Close()

	var points []spawnPoint
	for rows.Next() {
		var p spawnPoint
		var entry uint32
		if err := rows.Scan(&p.spawnID, &p.ownID, &p.x, &p.y, &p.z, &entry); err != nil {
			e2eharness.HarnessFailf(t, "scan %s spawn entry: %v", table, err)
		}
		if n := len(points); n > 0 && points[n-1].spawnID == p.spawnID {
			points[n-1].entries = append(points[n-1].entries, entry)
			continue
		}
		p.entries = []uint32{entry}
		points = append(points, p)
	}
	if len(points) == 0 {
		e2eharness.Preconditionf(t, "no %s spawn on map %d lists entry %d", table, mapID, anyEntry)
	}
	return points
}

// visit puts the bot on a spawn point with a fresh view of it. The harness drops its
// object cache on every teleport, while the server only sends the objects that newly come
// into view, so a hop between two nearby points leaves the cache without the objects both
// points see. Going through the package pad first makes the server send everything again.
func visit(t *testing.T, bot *e2eharness.ScenarioBot, p spawnPoint, mapID uint32) {
	t.Helper()
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.Teleport(t, p.x, p.y, p.z, mapID)
}

func dist2D(ax, ay, bx, by float32) float32 {
	return float32(math.Hypot(float64(ax-bx), float64(ay-by)))
}

func distinct(entries []uint32) []uint32 {
	seen := map[uint32]bool{}
	var out []uint32
	for _, e := range entries {
		if !seen[e] {
			seen[e] = true
			out = append(out, e)
		}
	}
	sort.Slice(out, func(i, j int) bool { return out[i] < out[j] })
	return out
}

// livingAt returns the living creatures of the listed entries standing on the point.
func livingAt(bot *e2eharness.ScenarioBot, p spawnPoint, radius float32, entries []uint32) []e2eharness.UnitSnap {
	var out []e2eharness.UnitSnap
	for _, u := range bot.UnitsByEntry(60, entries...) {
		obj := bot.World.GetObject(u.GUID)
		if obj != nil && dist2D(obj.PosX, obj.PosY, p.x, p.y) <= radius {
			out = append(out, u)
		}
	}
	return out
}

// tryLivingAt polls until exactly one living creature of the list stands on the point.
func tryLivingAt(bot *e2eharness.ScenarioBot, p spawnPoint, timeout time.Duration) (e2eharness.UnitSnap, int) {
	deadline := time.Now().Add(timeout)
	var last []e2eharness.UnitSnap
	for time.Now().Before(deadline) {
		if last = livingAt(bot, p, spotRadius, p.entries); len(last) == 1 {
			return last[0], 1
		}
		time.Sleep(50 * time.Millisecond)
	}
	return e2eharness.UnitSnap{}, len(last)
}

func waitLivingAt(t *testing.T, bot *e2eharness.ScenarioBot, p spawnPoint, timeout time.Duration) e2eharness.UnitSnap {
	t.Helper()
	unit, count := tryLivingAt(bot, p, timeout)
	if count != 1 {
		e2eharness.Assertf(t, "spawn %d: %d living creatures of %v on its point after %s, want exactly 1",
			p.spawnID, count, p.entries, timeout)
	}
	return unit
}

// gameObjectAt returns the gameobject of the list standing on the point (0 if none) and
// how many of them stand there. The harness finds one object per entry, so two objects of
// the same entry on one point count as one.
func gameObjectAt(bot *e2eharness.ScenarioBot, p spawnPoint) (guid uint64, entry uint32, count int) {
	for _, e := range p.entries {
		g := bot.World.FindGameObjectByEntry(e, 30)
		if g == 0 {
			continue
		}
		obj := bot.World.GetObject(g)
		if obj == nil || dist2D(obj.PosX, obj.PosY, p.x, p.y) > spotRadius {
			continue
		}
		guid, entry = g, e
		count++
	}
	return
}

// tryGameObjectAt polls until exactly one gameobject of the list, other than notGUID,
// stands on the point.
func tryGameObjectAt(bot *e2eharness.ScenarioBot, p spawnPoint, notGUID uint64, timeout time.Duration) (uint64, uint32, int) {
	deadline := time.Now().Add(timeout)
	count := 0
	for time.Now().Before(deadline) {
		var guid uint64
		var entry uint32
		if guid, entry, count = gameObjectAt(bot, p); count == 1 && guid != notGUID {
			return guid, entry, 1
		}
		time.Sleep(50 * time.Millisecond)
	}
	if count == 1 {
		count = 0 // only the old object is there
	}
	return 0, 0, count
}

func waitGameObjectAt(t *testing.T, bot *e2eharness.ScenarioBot, p spawnPoint, notGUID uint64, timeout time.Duration) (uint64, uint32) {
	t.Helper()
	guid, entry, count := tryGameObjectAt(bot, p, notGUID, timeout)
	if count != 1 {
		e2eharness.Assertf(t, "gameobject spawn %d: %d objects of %v on its point after %s, want exactly 1 new one",
			p.spawnID, count, p.entries, timeout)
	}
	return guid, entry
}

// lootChest opens a chest the way a player does (the Opening spell on the object), takes
// everything and closes the window, which consumes a consumable chest. v1.0.8 of the
// harness has no gameobject-target cast helper, so the packet is built here, with the
// CMSG_CAST_SPELL layout WorldSession::HandleCastSpellOpcode reads.
func lootChest(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, spell uint32) {
	t.Helper()
	loot := make(chan []byte, 1)
	cancel := bot.World.AddPacketHook(func(op uint16, data []byte) {
		if op == client.SmsgLootResponse && len(data) >= 8 && binary.LittleEndian.Uint64(data) == guid {
			select {
			case loot <- append([]byte(nil), data...):
			default:
			}
		}
	})
	defer cancel()

	payload := make([]byte, 11) // cast count, spell, cast flags, target flags, packed-GUID mask
	binary.LittleEndian.PutUint32(payload[1:5], spell)
	binary.LittleEndian.PutUint32(payload[6:10], 0x0800) // TARGET_FLAG_GAMEOBJECT
	for i := uint(0); i < 8; i++ {
		if b := byte(guid >> (8 * i)); b != 0 {
			payload[10] |= 1 << i
			payload = append(payload, b)
		}
	}
	if err := bot.World.SendPacketRaw(client.CmsgCastSpell, payload); err != nil {
		e2eharness.HarnessFailf(t, "Opening packet: %v", err)
	}

	select {
	case data := <-loot:
		if len(data) < 14 || len(data) < 14+22*int(data[13]) {
			e2eharness.Preconditionf(t, "chest 0x%X refused the opening or sent malformed loot: %x", guid, data)
		}
		for i := 0; i < int(data[13]); i++ {
			bot.LootTakeItem(t, data[14+i*22])
		}
	case <-time.After(12 * time.Second):
		e2eharness.Preconditionf(t, "chest 0x%X: no loot response to Opening spell %d", guid, spell)
	}
	bot.LootRelease(t, guid)
}

func waitObjectGone(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, timeout time.Duration) {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for bot.World.GetObject(guid) != nil {
		if time.Now().After(deadline) {
			e2eharness.Assertf(t, "looted consumable chest 0x%X stayed visible for %s", guid, timeout)
		}
		time.Sleep(25 * time.Millisecond)
	}
}

// Every Rocket Car Rubble point in the Shimmering Flats lists six entries. A player
// walking the field sees one rubble per point, each one of that point's entries and not
// all the same; looting a rubble away and letting it respawn brings a new object back on
// the same point that, over a few respawns, is not always the same entry.
func TestSpawnEntry_GameObjectRollsItsEntry(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "world", "spawns", "serial"},
		Runtime:  "med",
		Category: "world/spawns",
	})

	const censusPoints = 12
	const respawns = 10 // all ten the same entry: (1/6)^9 on six even entries

	db := worldDB(t)
	points := spawnPoints(t, db, "gameobject", mapKalimdor, rocketCarRubble)
	if len(points) < censusPoints {
		e2eharness.Preconditionf(t, "only %d Rocket Car Rubble spawns list their entries, want %d", len(points), censusPoints)
	}

	// GM mode stays on: the field is full of hostile basilisks and scorpids.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "SpnGo", Race: e2eharness.RaceHuman, Level: 80})
	bot.AddQuest(t, questRocketParts) // the rubble only drops its quest item to a player on the quest

	// A point can be empty for a while (looted by someone else), and two objects on one
	// point is always wrong. The census needs most points up, not all of them.
	var census []uint32
	var up []spawnPoint
	rolledAway := 0
	for _, p := range points[:censusPoints] {
		visit(t, bot, p, mapKalimdor)
		_, entry, count := tryGameObjectAt(bot, p, 0, 6*time.Second)
		if count > 1 {
			e2eharness.Assertf(t, "gameobject spawn %d: %d objects of %v on one point", p.spawnID, count, p.entries)
		}
		if count == 0 {
			t.Logf("gameobject spawn %d: nothing on its point, skipped", p.spawnID)
			continue
		}
		up = append(up, p)
		census = append(census, entry)
		if entry != p.ownID {
			rolledAway++
		}
	}
	t.Logf("census: %d of %d points up, entries %v, %d not on the spawn's own id", len(up), censusPoints, census, rolledAway)
	if len(up) < censusPoints*2/3 {
		e2eharness.Preconditionf(t, "only %d of %d rubble points hold a rubble", len(up), censusPoints)
	}
	if len(distinct(census)) < 2 {
		e2eharness.Assertf(t, "all %d rubble points hold entry %d: the entry lists are not rolled", len(up), census[0])
	}

	p := up[0]
	visit(t, bot, p, mapKalimdor)
	guid, entry := waitGameObjectAt(t, bot, p, 0, 20*time.Second)
	seen := []uint32{entry}
	for i := 0; i < respawns; i++ {
		lootChest(t, bot, guid, spellOpeningKneel)
		waitObjectGone(t, bot, guid, 10*time.Second)
		bot.GM(t, fmt.Sprintf(".gobject respawn %d", p.spawnID))

		// The entry is part of a gameobject's guid, so a re-rolled spawn is a new object.
		newGUID, newEntry := waitGameObjectAt(t, bot, p, guid, 20*time.Second)
		if !p.lists(newEntry) {
			e2eharness.Assertf(t, "spawn %d respawned as %d, not one of %v", p.spawnID, newEntry, p.entries)
		}
		guid = newGUID
		seen = append(seen, newEntry)
	}
	if len(distinct(seen)) < 2 {
		e2eharness.Assertf(t, "spawn %d came back as entry %d on all %d respawns, its list is %v",
			p.spawnID, seen[0], respawns, p.entries)
	}

	bot.AssertWorldAlive(t)
	t.Logf("PASS gameobject spawn %d rolled %v over %d respawns", p.spawnID, seen, respawns)
}

// Every Injured Warsong point in Borean Tundra lists four entries. One creature stands on
// each point, each one of that point's entries and not all the same; killed and respawned,
// it comes back on its point as one of them, and not always the same one.
func TestSpawnEntry_CreatureRollsItsEntry(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "world", "spawns", "serial"},
		Runtime:  "med",
		Category: "world/spawns",
	})

	const respawns = 12 // all twelve the same entry: (1/4)^11 on four even entries

	db := worldDB(t)
	points := spawnPoints(t, db, "creature", mapNorthrend, injuredWarsong)

	// Horde, with GM mode left on: the points are inside Warsong Hold.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "SpnCr", Race: e2eharness.RaceOrc, Level: 80})

	// These creatures fight the Nerubians that raid the hold, so a point can be empty for a
	// while. The census needs most points up, not all of them.
	var census []uint32
	var up []spawnPoint
	for _, p := range points {
		visit(t, bot, p, mapNorthrend)
		unit, count := tryLivingAt(bot, p, 6*time.Second)
		if count > 1 {
			e2eharness.Assertf(t, "spawn %d: %d living creatures of %v on one point", p.spawnID, count, p.entries)
		}
		if count == 0 {
			t.Logf("spawn %d: nobody alive on its point, skipped", p.spawnID)
			continue
		}
		up = append(up, p)
		census = append(census, unit.Entry)
	}
	t.Logf("census: %d of %d points up, entries %v", len(up), len(points), census)
	if len(up) < 8 {
		e2eharness.Preconditionf(t, "only %d of %d Injured Warsong points hold a living creature", len(up), len(points))
	}
	if len(distinct(census)) < 2 {
		e2eharness.Assertf(t, "all %d Injured Warsong points hold entry %d: the entry lists are not rolled", len(up), census[0])
	}

	p := up[0]
	visit(t, bot, p, mapNorthrend)
	unit := waitLivingAt(t, bot, p, 20*time.Second)
	seen := []uint32{unit.Entry}
	for i := 0; i < respawns; i++ {
		bot.DamageKill(t, []uint64{unit.GUID}, 0, 15*time.Second)
		bot.GM(t, fmt.Sprintf(".respawn creature guid %d", p.spawnID))

		unit = waitLivingAt(t, bot, p, 20*time.Second)
		if !p.lists(unit.Entry) {
			e2eharness.Assertf(t, "spawn %d respawned as %d, not one of %v", p.spawnID, unit.Entry, p.entries)
		}
		seen = append(seen, unit.Entry)
	}
	if len(distinct(seen)) < 2 {
		e2eharness.Assertf(t, "spawn %d came back as entry %d on all %d respawns, its list is %v",
			p.spawnID, seen[0], respawns, p.entries)
	}

	bot.AssertWorldAlive(t)
	t.Logf("PASS creature spawn %d rolled %v over %d respawns", p.spawnID, seen, respawns)
}

// describeUnits lists the living creatures of the entries the bot sees, each with the
// member point nearest to it, for a failure message.
func describeUnits(bot *e2eharness.ScenarioBot, members []spawnPoint, entries []uint32) string {
	px, py, _, _, _ := bot.World.Position()
	out := fmt.Sprintf("bot at (%.1f, %.1f)", px, py)
	for _, u := range bot.UnitsByEntry(100, entries...) {
		obj := bot.World.GetObject(u.GUID)
		if obj == nil {
			continue
		}
		nearest, best := uint32(0), float32(math.MaxFloat32)
		for _, m := range members {
			if d := dist2D(obj.PosX, obj.PosY, m.x, m.y); d < best {
				nearest, best = m.spawnID, d
			}
		}
		out += fmt.Sprintf("; %#x entry %d hp %d/%d at (%.1f, %.1f), %.1f from point %d",
			u.GUID, u.Entry, u.Health, u.MaxHealth, obj.PosX, obj.PosY, best, nearest)
	}
	return out
}

type groupLimit struct {
	entry    uint32
	minCount int
	maxCount int // 0 = no limit
}

// packMembers returns the living creatures of the group's entries that stay on a member
// point through an observation window. A patrol of the same entries walks through this
// pack: its path passes 1.5 yards from one member point, so one look cannot tell a member
// from a passer-by. A member is on its point in nearly every sample; the patrol needs under
// 4 seconds to cross a point's radius, so the window has to be well above that.
func packMembers(bot *e2eharness.ScenarioBot, members []spawnPoint, entries []uint32, window time.Duration) map[uint32]e2eharness.UnitSnap {
	// The members wander 3 yards around points at least 6.8 apart: some slack for a
	// position read mid-move, and the nearest point wins where two radii overlap.
	const memberRadius = float32(4.5)
	sightings := map[uint64]map[uint32]int{} // creature guid -> spawn id of a point -> samples seen on it
	units := map[uint64]e2eharness.UnitSnap{}
	samples := 0
	for deadline := time.Now().Add(window); time.Now().Before(deadline); time.Sleep(250 * time.Millisecond) {
		samples++
		for _, u := range bot.UnitsByEntry(60, entries...) {
			obj := bot.World.GetObject(u.GUID)
			if obj == nil {
				continue
			}
			nearest, best := uint32(0), memberRadius
			for _, m := range members {
				if d := dist2D(obj.PosX, obj.PosY, m.x, m.y); d <= best {
					nearest, best = m.spawnID, d
				}
			}
			if nearest != 0 {
				if sightings[u.GUID] == nil {
					sightings[u.GUID] = map[uint32]int{}
				}
				sightings[u.GUID][nearest]++
				units[u.GUID] = u
			}
		}
	}

	// A creature belongs to the point it was seen on most, and is a member when it was on
	// the pack's points in at least 3 of 4 samples. Where two claim a point, the steadier wins.
	out := map[uint32]e2eharness.UnitSnap{}
	held := map[uint32]int{}
	for guid, points := range sightings {
		total, home, most := 0, uint32(0), 0
		for spawnID, seen := range points {
			total += seen
			if seen > most {
				home, most = spawnID, seen
			}
		}
		if total*4 < samples*3 || total <= held[home] {
			continue
		}
		out[home], held[home] = units[guid], total
	}
	return out
}

func checkGroupLimits(t *testing.T, when string, pack map[uint32]e2eharness.UnitSnap, limits []groupLimit, minSize, maxSize int) map[uint32]int {
	t.Helper()
	counts := map[uint32]int{}
	for _, u := range pack {
		counts[u.Entry]++
	}
	if len(pack) < minSize || len(pack) > maxSize {
		e2eharness.Assertf(t, "%s: %d pack members alive (%v), want %d to %d", when, len(pack), counts, minSize, maxSize)
	}
	for _, l := range limits {
		if counts[l.entry] < l.minCount {
			e2eharness.Assertf(t, "%s: %d of entry %d, the group asks for at least %d (%v)", when, counts[l.entry], l.entry, l.minCount, counts)
		}
		if l.maxCount > 0 && counts[l.entry] > l.maxCount {
			e2eharness.Assertf(t, "%s: %d of entry %d, the group allows at most %d (%v)", when, counts[l.entry], l.entry, l.maxCount, counts)
		}
	}
	return counts
}

// The snake pack at the Zul'Gurub entrance is one spawn group that sets the entries of
// its members: 3 or 4 snakes, with at least one of each entry the group gives a minimum.
// The minimums must hold when the instance is first seen and after every single respawn,
// and the last holder of a minimum entry must come back as that entry.
func TestSpawnGroup_EntryMinimumsHoldAcrossRespawns(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "world", "spawns", "instance", "serial"},
		Runtime:  "med",
		Category: "world/spawns",
	})

	const respawns = 8

	db := worldDB(t)

	rows, err := db.Query("SELECT entry, minCount, maxCount FROM spawn_group_entry WHERE groupId = ? AND spawnType = 0", zgSnakePackGroup)
	if err != nil {
		e2eharness.Preconditionf(t, "spawn_group_entry is not readable (pending SQL not applied?): %v", err)
	}
	var limits []groupLimit
	var entries []uint32
	for rows.Next() {
		var l groupLimit
		if err := rows.Scan(&l.entry, &l.minCount, &l.maxCount); err != nil {
			e2eharness.HarnessFailf(t, "scan spawn_group_entry: %v", err)
		}
		limits = append(limits, l)
		entries = append(entries, l.entry)
	}
	rows.Close()

	rows, err = db.Query("SELECT c.guid, c.id, c.position_x, c.position_y, c.position_z, g.chance FROM spawn_group g "+
		"JOIN creature c ON c.guid = g.spawnId WHERE g.groupId = ? AND g.spawnType = 0 AND c.map = ? ORDER BY c.guid",
		zgSnakePackGroup, mapZulGurub)
	if err != nil {
		e2eharness.Preconditionf(t, "spawn_group.chance is not readable (pending SQL not applied?): %v", err)
	}
	var members []spawnPoint
	always := 0
	for rows.Next() {
		var m spawnPoint
		var chance float32
		if err := rows.Scan(&m.spawnID, &m.ownID, &m.x, &m.y, &m.z, &chance); err != nil {
			e2eharness.HarnessFailf(t, "scan spawn_group: %v", err)
		}
		m.entries = entries
		members = append(members, m)
		if chance <= 0 {
			always++
		}
	}
	rows.Close()
	if len(limits) == 0 || len(members) == 0 {
		e2eharness.Preconditionf(t, "spawn group %d has %d entry rows and %d members on map %d",
			zgSnakePackGroup, len(limits), len(members), mapZulGurub)
	}

	// GM mode stays on, so the pack and the patrol crossing it ignore the bot. A new
	// character gets a fresh instance, so the group is rolled for this run.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "SpnGr", Race: e2eharness.RaceHuman, Level: 80})
	bot.Teleport(t, members[0].x, members[0].y, members[0].z, mapZulGurub)
	bot.WaitUnitAny(t, 30*time.Second, entries...)

	pack := packMembers(bot, members, entries, 8*time.Second)
	counts := checkGroupLimits(t, "first roll", pack, limits, always, len(members))
	t.Logf("first roll: %d members %v", len(pack), counts)

	soleHolderCycles := 0
	for i := 0; i < respawns; i++ {
		// Alternate between the only holder of an entry with a minimum, which has no choice on
		// respawn, and a member that is free to change.
		wantForced := i%2 == 0
		var victimSpawn uint32
		var victim e2eharness.UnitSnap
		forced := false
		for spawnID, u := range pack {
			sole := false
			for _, l := range limits {
				if l.entry == u.Entry && l.minCount > 0 && counts[u.Entry] == l.minCount {
					sole = true
				}
			}
			if victimSpawn == 0 || (sole == wantForced && forced != wantForced) {
				victimSpawn, victim, forced = spawnID, u, sole
			}
		}

		bot.DamageKill(t, []uint64{victim.GUID}, 0, 15*time.Second)
		bot.GM(t, fmt.Sprintf(".respawn creature guid %d", victimSpawn))

		deadline := time.Now().Add(40 * time.Second)
		for {
			pack = packMembers(bot, members, entries, 8*time.Second)
			if _, back := pack[victimSpawn]; back || time.Now().After(deadline) {
				break
			}
		}
		back, ok := pack[victimSpawn]
		if !ok {
			e2eharness.Assertf(t, "respawn %d: member %d did not come back on its point; in sight: %s",
				i+1, victimSpawn, describeUnits(bot, members, entries))
		}
		counts = checkGroupLimits(t, fmt.Sprintf("respawn %d of member %d", i+1, victimSpawn), pack, limits, always, len(members))
		if forced {
			soleHolderCycles++
			if back.Entry != victim.Entry {
				e2eharness.Assertf(t, "respawn %d: member %d was the last of entry %d and came back as %d",
					i+1, victimSpawn, victim.Entry, back.Entry)
			}
		}
		t.Logf("respawn %d: member %d was %d (last of its entry: %v), now %d; pack %v",
			i+1, victimSpawn, victim.Entry, forced, back.Entry, counts)
	}
	if soleHolderCycles == 0 {
		e2eharness.Preconditionf(t, "no respawn in %d hit the last holder of a minimum entry; the minimum was never under test", respawns)
	}

	bot.AssertWorldAlive(t)
	t.Logf("PASS group %d kept its minimums over %d respawns, %d of them of a last holder", zgSnakePackGroup, respawns, soleHolderCycles)
}
