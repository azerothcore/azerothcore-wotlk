//go:build e2e

package trial_of_the_crusader_test

import (
	"encoding/binary"
	"slices"
	"sync"
	"testing"
	"time"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	_ "github.com/go-sql-driver/mysql"
)

type spikeCast struct {
	spell    uint32
	serverMS uint32
	hits     []uint64
	at       time.Time
}

type spikeEmote struct {
	receiver uint64
	at       time.Time
}

// In retail sniffs the pursuing spike starts every pursuit, the first one and each restart after
// breaking on a Frost Sphere, by casting 65920 and the 67470 area dummy on every player in the same
// tick, then marks one player with 67574 and emotes 1.6s later. A target lost mid-pursuit is
// re-marked at once, without 67470.
//
// Drive: the real spike summon (66169) in Anub'arak's chamber, with both paladins standing on a
// Frost Sphere turned into Permafrost, so the first pursuit breaks on arrival and restarts. The
// first marked player casts Divine Shield on the way.
// Oracle: the spike's SMSG_SPELL_GO packets, timed by their server timestamps, and its emote. The
// first pursuit's 67470 goes out before the bots know the spike, so for it only the held position
// and the delayed mark are checked; the restart checks 67470 itself. 65920 is never checked: it is
// cast triggered and has no visual, so the core sends no SPELL_GO for it.
func TestToC_PursuingSpikesTargetSearch(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags: []string{"med", "instances", "multi_bot"}, Runtime: "med",
		Category: "instances/trial_of_the_crusader",
	})
	const (
		npcSphere = uint32(34606)
		npcSpike  = uint32(34660)

		speed1     = uint32(65920)
		search     = uint32(67470)
		mark       = uint32(67574)
		spikeFail  = uint32(66181)
		shield     = uint32(642)
		permafrost = uint32(66193)

		// EVENT_SPIKE_MARK is 1.6s; creatures in a dungeon can update a few world ticks late.
		markMin = 1500 * time.Millisecond
		markMax = 2300 * time.Millisecond
		// The spike's appearance is read by polling the object cache, so it lags its spawn.
		firstMarkMin = 1300 * time.Millisecond
		// Anub'arak's position (trial_of_the_crusader.h LOC_ANUB) and a spot 35 yards west of it.
		casterX, casterY = float32(785.90), float32(133.42)
		playerX, playerY = float32(750.90), float32(133.42)
		floorZ           = float32(142.612)
	)

	bots := newSpikeRaid(t)
	a, b := bots[0], bots[1]
	a.Teleport(t, casterX, casterY, floorZ, 649)
	b.Teleport(t, playerX, playerY, floorZ, 649)
	caster, _ := a.SpawnPersistent(t, 12999, 10*time.Second)
	a.Teleport(t, playerX, playerY, floorZ, 649)
	for _, bot := range bots {
		bot.Learn(t, shield)
		selectSpikeUnit(t, bot, bot.GUID)
		bot.GM(t, ".modify hp 1000000")
		e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{Power: true})
		bot.FlushWorld(t)
	}
	a.WaitUnitGUID(t, b.GUID, 10*time.Second)
	a.WaitUnitGUID(t, caster, 10*time.Second)

	e2eharness.SpawnNPC(t, a.World, npcSphere)
	sphere := a.WaitUnit(t, npcSphere, 5*time.Second)
	t.Cleanup(func() {
		if a.World.GetObject(sphere) != nil {
			selectSpikeUnit(t, a, sphere)
			a.GM(t, ".npc delete")
		}
	})
	// npc_frost_sphere takes no lethal damage: it drops to the floor and casts Permafrost, a
	// persistent area aura whose slow lands on the players standing in it.
	a.Damage(t, sphere, 10000000)
	a.WaitUnitAura(t, a.GUID, permafrost, 5*time.Second)
	if obj := a.World.GetObject(sphere); obj == nil || !obj.HasKnownPosition() {
		e2eharness.Preconditionf(t, "Permafrost sphere 0x%X has no known position", sphere)
	} else if x, y, z := obj.InterpolatedPosition(); e2eharness.Distance3D(x, y, z, playerX, playerY, floorZ) > 4 {
		e2eharness.Preconditionf(t, "Permafrost sphere landed at (%.1f, %.1f, %.1f), too far from the players", x, y, z)
	}

	var mu sync.Mutex
	var casts []spikeCast
	var emotes []spikeEmote
	unhook := a.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case 0x0132: // SMSG_SPELL_GO
			if c, caster, ok := parseSpikeSpellGo(data); ok && spikeGUIDEntry(caster) == npcSpike {
				c.at = time.Now()
				mu.Lock()
				casts = append(casts, c)
				mu.Unlock()
			}
		case 0x0096: // SMSG_MESSAGECHAT
			if sender, receiver, ok := parseRaidBossEmote(data); ok && spikeGUIDEntry(sender) == npcSpike {
				mu.Lock()
				emotes = append(emotes, spikeEmote{receiver: receiver, at: time.Now()})
				mu.Unlock()
			}
		}
	})
	t.Cleanup(unhook)
	castAt := func(i int) spikeCast {
		mu.Lock()
		defer mu.Unlock()
		return casts[i]
	}
	// waitCast returns the index of the first spike cast of spell at or after index from, or -1.
	waitCast := func(from int, spell uint32, timeout time.Duration) int {
		found := -1
		waitSpikeCondition(timeout, func() bool {
			mu.Lock()
			defer mu.Unlock()
			for i := from; i < len(casts); i++ {
				if casts[i].spell == spell {
					found = i
					return true
				}
			}
			return false
		})
		return found
	}
	castsBetween := func(from, to int, spells ...uint32) []uint32 {
		mu.Lock()
		defer mu.Unlock()
		var out []uint32
		for _, c := range casts[from:to] {
			if slices.Contains(spells, c.spell) {
				out = append(out, c.spell)
			}
		}
		return out
	}
	// waitMarkHoldingStill waits for the first mark at or after index from and returns its index.
	// From since until the mark, the spike must not target anyone or move.
	waitMarkHoldingStill := func(label string, from int, since time.Time, spike uint64) int {
		// SPELL_GO is sent at once, the object update that clears the old target and stops the
		// chase only at the end of the map update.
		const grace = 250 * time.Millisecond
		var sx, sy, sz float32
		anchored := false
		iMark := -1
		for deadline := since.Add(markMax + time.Second); time.Now().Before(deadline); time.Sleep(25 * time.Millisecond) {
			if iMark = waitCast(from, mark, 0); iMark >= 0 {
				break
			}
			if time.Since(since) < grace {
				continue
			}
			if target := a.UnitTarget(spike); target != 0 {
				e2eharness.Assertf(t, "%s: spike targets 0x%X before marking anyone", label, target)
			}
			obj := a.World.GetObject(spike)
			if obj == nil || !obj.HasKnownPosition() {
				continue
			}
			x, y, z := obj.InterpolatedPosition()
			if !anchored {
				sx, sy, sz, anchored = x, y, z, true
			} else if d := e2eharness.Distance3D(x, y, z, sx, sy, sz); d > 1.5 {
				e2eharness.Assertf(t, "%s: spike moved %.1f yards before marking anyone", label, d)
			}
		}
		if iMark < 0 {
			e2eharness.Assertf(t, "%s: no 67574 mark within %s", label, markMax+time.Second)
		}
		return iMark
	}
	// checkPursuitStart asserts the 67470 hit list at index iSearch, then the mark 1.6s later, and
	// returns the mark's index.
	checkPursuitStart := func(label string, iSearch int, spike uint64, wantHits []uint64) int {
		start := castAt(iSearch)
		for _, guid := range wantHits {
			if !slices.Contains(start.hits, guid) {
				e2eharness.Assertf(t, "%s: 67470 missed player 0x%X, hits=%X", label, guid, start.hits)
			}
		}
		iMark := waitMarkHoldingStill(label, iSearch, start.at, spike)
		gap := msBetween(start.serverMS, castAt(iMark).serverMS)
		if gap < markMin || gap > markMax {
			e2eharness.Assertf(t, "%s: 67574 landed %s after 67470, want %s-%s", label, gap, markMin, markMax)
		}
		t.Logf("%s: 67470 hits=%X, mark on 0x%X %s later", label, start.hits, castAt(iMark).hits, gap)
		return iMark
	}

	selectSpikeUnit(t, a, caster)
	// Same spell as EVENT_SPELL_SUMMON_SPIKE; see TestAC_14076_PursuingSpikesImmunity.
	a.GM(t, ".cast self 66169")
	spike := a.WaitUnit(t, npcSpike, 10*time.Second)
	appeared := time.Now()
	t.Cleanup(func() {
		selectSpikeUnit(t, a, spike)
		a.GM(t, ".npc delete")
	})

	// The first pursuit starts in Reset() while the spike is being added to the map, before any
	// client has its create packet, so its 67470 never reaches the bots. Time that mark
	// from the spike's appearance instead; the restart below checks the 67470 burst itself.
	iMark := waitMarkHoldingStill("first pursuit", 0, appeared, spike)
	first := castAt(iMark)
	if gap := first.at.Sub(appeared); gap < firstMarkMin || gap > markMax {
		e2eharness.Assertf(t, "first pursuit: 67574 landed %s after the spike appeared, want %s-%s", gap, firstMarkMin, markMax)
	}
	t.Logf("first pursuit: mark on %X %s after the spike appeared", first.hits, first.at.Sub(appeared).Round(time.Millisecond))
	if len(first.hits) != 1 || (first.hits[0] != a.GUID && first.hits[0] != b.GUID) {
		e2eharness.Assertf(t, "first pursuit: 67574 hit %X, want one of the players", first.hits)
	}
	marked, other := a, b
	if first.hits[0] == b.GUID {
		marked, other = b, a
	}
	if !waitSpikeCondition(time.Second, func() bool {
		mu.Lock()
		defer mu.Unlock()
		for _, e := range emotes {
			if e.receiver == marked.GUID && e.at.Sub(first.at).Abs() < 500*time.Millisecond {
				return true
			}
		}
		return false
	}) {
		e2eharness.Assertf(t, "first pursuit: no raid boss emote naming 0x%X with the mark", marked.GUID)
	}
	t.Log("PASS: first pursuit holds still, then marks and emotes 1.6s after the spike appears")

	marked.CastMust(t, shield, marked.GUID, 5*time.Second)
	iRemark := waitCast(iMark+1, mark, 3*time.Second)
	if iRemark < 0 {
		e2eharness.Assertf(t, "mid-pursuit: spike did not re-mark after Divine Shield on 0x%X", marked.GUID)
	}
	if hits := castAt(iRemark).hits; !slices.Contains(hits, other.GUID) {
		e2eharness.Assertf(t, "mid-pursuit: re-mark hit %X, want 0x%X", hits, other.GUID)
	}
	if extra := castsBetween(iMark+1, iRemark, speed1, search); len(extra) != 0 {
		e2eharness.Assertf(t, "mid-pursuit: spike restarted the pursuit (%v) instead of re-marking", extra)
	}
	t.Log("PASS: a target lost mid-pursuit is re-marked at once, without 67470")

	iFail := waitCast(iRemark, spikeFail, 20*time.Second)
	if iFail < 0 {
		e2eharness.Preconditionf(t, "spike never broke on the Permafrost sphere")
	}
	iSearch2 := waitCast(iFail, search, 8*time.Second)
	if iSearch2 < 0 {
		mu.Lock()
		var seen []uint32
		for _, c := range casts[iFail:] {
			seen = append(seen, c.spell)
		}
		mu.Unlock()
		e2eharness.Assertf(t, "restart: no 67470 within 8s of breaking on the sphere, spike SPELL_GOs since: %v", seen)
	}
	// The first marked player may still be under Divine Shield, so only the other must be hit.
	checkPursuitStart("restart", iSearch2, spike, []uint64{other.GUID})
	t.Log("PASS: a restart after a Frost Sphere casts 67470 on the players, then marks 1.6s later")
}

// parseSpikeSpellGo reads a 3.3.5 SMSG_SPELL_GO: packed item caster and caster guids, cast count,
// spell id, cast flags, server ms timestamp, then the hit count and full hit guids.
func parseSpikeSpellGo(data []byte) (c spikeCast, caster uint64, ok bool) {
	_, off := readSpikePackedGUID(data, 0)
	caster, off = readSpikePackedGUID(data, off)
	off++ // cast count
	if off+13 > len(data) {
		return c, 0, false
	}
	c.spell = binary.LittleEndian.Uint32(data[off:])
	c.serverMS = binary.LittleEndian.Uint32(data[off+8:])
	n := int(data[off+12])
	off += 13
	if off+8*n > len(data) {
		return c, 0, false
	}
	for i := 0; i < n; i++ {
		c.hits = append(c.hits, binary.LittleEndian.Uint64(data[off+8*i:]))
	}
	return c, caster, true
}

// parseRaidBossEmote reads a creature CHAT_MSG_RAID_BOSS_EMOTE (ChatHandler::BuildChatPacket): type,
// language, sender guid, flags, sender name, then the receiver guid.
func parseRaidBossEmote(data []byte) (sender, receiver uint64, ok bool) {
	const chatMsgRaidBossEmote = 0x29
	if len(data) < 21 || data[0] != chatMsgRaidBossEmote {
		return 0, 0, false
	}
	sender = binary.LittleEndian.Uint64(data[5:])
	off := 21 + int(binary.LittleEndian.Uint32(data[17:]))
	if off+8 > len(data) {
		return 0, 0, false
	}
	return sender, binary.LittleEndian.Uint64(data[off:]), true
}

func readSpikePackedGUID(data []byte, off int) (uint64, int) {
	if off >= len(data) {
		return 0, off
	}
	mask := data[off]
	off++
	var guid uint64
	for i := 0; i < 8; i++ {
		if mask&(1<<i) != 0 {
			if off >= len(data) {
				return guid, off
			}
			guid |= uint64(data[off]) << (8 * i)
			off++
		}
	}
	return guid, off
}

func spikeGUIDEntry(guid uint64) uint32 {
	return uint32((guid >> 24) & 0xFFFFFF)
}

// msBetween returns to - from for server ms timestamps, which wrap at 2^32.
func msBetween(from, to uint32) time.Duration {
	return time.Duration(int32(to-from)) * time.Millisecond
}
