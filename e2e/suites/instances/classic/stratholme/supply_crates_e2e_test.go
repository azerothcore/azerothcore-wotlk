//go:build e2e

package stratholme_test

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"sync/atomic"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	spellDisarmTrap    = uint32(1842)
	spellOpening       = uint32(3365)
	spellOpeningChest  = uint32(11437)
	spellPlagueMist    = uint32(16432)
	spellConjureMilton = uint32(21078)
	spellJinxed        = uint32(24184)
	spellLandMine      = uint32(54355)

	goNormalSupplyCrate     = uint32(176224)
	goStratholmeSupplyCrate = uint32(181085)
	goPassYourRite          = uint32(178325)
	goJinxedHoodooPile      = uint32(180229)
	goJinxedHoodooTrap      = uint32(180244)
	goLandMine              = uint32(191502)

	npcMiltonBeats          = uint32(13082)
	questTheManorRavenholdt = uint32(6681)

	targetFlagGameObject = uint32(0x00000800)
)

var trappedSupplyCrates = []struct {
	parent uint32
	trap   uint32
}{
	{goSupplyCrate1, 175535},
	{goSupplyCrate2, 175536},
	{goSupplyCrate3, 175534},
	{goSupplyCrate4, 175537},
}

type gameObjectSpellOutcome uint8

const (
	gameObjectSpellTimedOut gameObjectSpellOutcome = iota
	gameObjectSpellLoot
	gameObjectSpellReleased
	gameObjectSpellCastFailed
)

type gameObjectSpellResult struct {
	outcome    gameObjectSpellOutcome
	items      []client.LootItem
	failReason uint8
}

// AzerothGhost v1.0.8 can send and observe raw packets, but does not yet expose
// a gameobject-target spell helper. Keep the small protocol adapter local to this
// regression suite so AC does not depend on an unreleased harness API.
func writePackedGUID(buf *bytes.Buffer, guid uint64) {
	packed := make([]byte, 9)
	size := 1
	for i := uint8(0); guid != 0; i++ {
		if guid&0xFF != 0 {
			packed[0] |= 1 << i
			packed[size] = byte(guid)
			size++
		}
		guid >>= 8
	}
	buf.Write(packed[:size])
}

func gameObjectCastPayload(spellID uint32, guid uint64) []byte {
	buf := new(bytes.Buffer)
	buf.WriteByte(0) // cast count
	_ = binary.Write(buf, binary.LittleEndian, spellID)
	buf.WriteByte(0) // cast flags
	_ = binary.Write(buf, binary.LittleEndian, targetFlagGameObject)
	writePackedGUID(buf, guid)
	return buf.Bytes()
}

func castGameObjectAndWait(t *testing.T, bot *e2eharness.ScenarioBot, spellID uint32, guid uint64, timeout time.Duration) e2eharness.SpellCastResult {
	t.Helper()
	bot.Session.ArmSpellWaiter()
	if err := bot.World.SendPacketRaw(client.CmsgCastSpell, gameObjectCastPayload(spellID, guid)); err != nil {
		e2eharness.HarnessFailf(t, "cast spell %d at gameobject 0x%X: %v", spellID, guid, err)
	}
	result, err := bot.Session.WaitSpellID(spellID, timeout)
	if err != nil {
		e2eharness.HarnessFailf(t, "wait for spell %d at gameobject 0x%X: %v", spellID, guid, err)
	}
	return result
}

func lootReleaseGUID(data []byte) (uint64, bool) {
	if len(data) < 8 {
		return 0, false
	}
	return binary.LittleEndian.Uint64(data[:8]), true
}

func useGameObjectSpell(t *testing.T, bot *e2eharness.ScenarioBot, spellID uint32, guid uint64, timeout time.Duration) gameObjectSpellResult {
	t.Helper()
	resultCh := make(chan gameObjectSpellResult, 3)
	cancelLoot := bot.World.AddLootOpenedHook(func(lootGUID uint64, items []client.LootItem) {
		if lootGUID != guid {
			return
		}
		select {
		case resultCh <- gameObjectSpellResult{outcome: gameObjectSpellLoot, items: items}:
		default:
		}
	})
	defer cancelLoot()

	cancelRelease := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgLootReleaseResponse {
			return
		}
		releaseGUID, ok := lootReleaseGUID(data)
		if !ok || releaseGUID != guid {
			return
		}
		select {
		case resultCh <- gameObjectSpellResult{outcome: gameObjectSpellReleased}:
		default:
		}
	})
	defer cancelRelease()

	cancelCast := bot.World.AddSpellCastResultHook(func(resultSpellID uint32, success bool, failReason uint8) {
		if resultSpellID != spellID || success {
			return
		}
		select {
		case resultCh <- gameObjectSpellResult{outcome: gameObjectSpellCastFailed, failReason: failReason}:
		default:
		}
	})
	defer cancelCast()

	if err := bot.World.SendPacketRaw(client.CmsgCastSpell, gameObjectCastPayload(spellID, guid)); err != nil {
		e2eharness.HarnessFailf(t, "cast spell %d at gameobject 0x%X: %v", spellID, guid, err)
	}

	timer := time.NewTimer(timeout)
	defer timer.Stop()
	select {
	case result := <-resultCh:
		return result
	case <-timer.C:
		return gameObjectSpellResult{outcome: gameObjectSpellTimedOut}
	}
}

func releaseLootAndWait(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, timeout time.Duration) {
	t.Helper()
	released := make(chan struct{}, 1)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgLootReleaseResponse {
			return
		}
		releaseGUID, ok := lootReleaseGUID(data)
		if !ok || releaseGUID != guid {
			return
		}
		select {
		case released <- struct{}{}:
		default:
		}
	})
	defer cancel()

	bot.LootRelease(t, guid)
	select {
	case <-released:
	case <-time.After(timeout):
		e2eharness.ConfirmedBugf(t, 12285, "gameobject 0x%X did not acknowledge loot release within %s", guid, timeout)
	}
}

func skipPackedGUID(data []byte, offset int) (int, bool) {
	if offset >= len(data) {
		return offset, false
	}
	mask := data[offset]
	offset++
	for i := uint8(0); i < 8; i++ {
		if mask&(1<<i) != 0 {
			offset++
			if offset > len(data) {
				return offset, false
			}
		}
	}
	return offset, true
}

func spellGoID(data []byte) (uint32, bool) {
	offset, ok := skipPackedGUID(data, 0)
	if !ok {
		return 0, false
	}
	offset, ok = skipPackedGUID(data, offset)
	if !ok || offset+5 > len(data) {
		return 0, false
	}
	offset++ // cast count
	return binary.LittleEndian.Uint32(data[offset : offset+4]), true
}

func armSpellGoCounter(bot *e2eharness.ScenarioBot, spellID uint32) (count func() int32, cancel func()) {
	var observed atomic.Int32
	cancel = bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellGo {
			return
		}
		if got, ok := spellGoID(data); ok && got == spellID {
			observed.Add(1)
		}
	})
	return observed.Load, cancel
}

func assertSpellGoCount(t *testing.T, count func() int32, spellID uint32, want int32) {
	t.Helper()
	// Trap casts are immediate. This quiet window also catches a duplicate cast
	// arriving on the following gameobject update.
	time.Sleep(750 * time.Millisecond)
	if got := count(); got != want {
		e2eharness.ConfirmedBugf(t, 12285, "observed spell %d %d times, want %d", spellID, got, want)
	}
}

func assertGameObjectGone(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, label string, timeout time.Duration) {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if bot.World.GetObject(guid) == nil {
			return
		}
		time.Sleep(20 * time.Millisecond)
	}
	e2eharness.ConfirmedBugf(t, 12285, "%s 0x%X remained spawned for %s", label, guid, timeout)
}

func assertGameObjectAbsentFor(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, label string, window time.Duration) {
	t.Helper()
	deadline := time.Now().Add(window)
	for time.Now().Before(deadline) {
		if bot.World.GetObject(guid) != nil {
			e2eharness.ConfirmedBugf(t, 12285, "%s 0x%X respawned before %s elapsed", label, guid, window)
		}
		time.Sleep(20 * time.Millisecond)
	}
}

func waitGameObjectGUID(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64, label string, timeout time.Duration) {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if bot.World.GetObject(guid) != nil {
			return
		}
		time.Sleep(20 * time.Millisecond)
	}
	e2eharness.ConfirmedBugf(t, 12285, "%s 0x%X did not respawn within %s", label, guid, timeout)
}

// Opening and Disarm Trap must both consume the trap-only Supply Crate and its
// linked trap. The fourth crate also has a valid client spell, allowing an exact
// once assertion for the linked Plague Mist cast on Opening.
func TestAC_12285_SupplyCrateOpenAndDisarm(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "gameobject", "issue", "serial"},
		Runtime:  "med",
		Issue:    12285,
		Category: "instances/classic/stratholme",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "SCrate",
		Class:         e2eharness.ClassRogue,
		Level:         80,
		LearnAllClass: true,
	})
	bot.Learn(t, spellOpening)
	pad := e2eharness.PackagePad(t)

	for _, crate := range trappedSupplyCrates {
		t.Run(fmt.Sprintf("open_%d", crate.parent), func(t *testing.T) {
			bot.TeleportPad(t, pad)
			if spawnID := bot.SpawnGameObject(t, crate.parent); spawnID == 0 {
				e2eharness.Preconditionf(t, "failed to create cleanup-backed Supply Crate entry=%d", crate.parent)
			}
			parentGUID := bot.WaitGameObject(t, crate.parent, 10*time.Second)
			trapGUID := bot.WaitGameObject(t, crate.trap, 10*time.Second)

			var count func() int32
			cancel := func() {}
			if crate.parent == goSupplyCrate4 {
				count, cancel = armSpellGoCounter(bot, spellPlagueMist)
			}
			defer cancel()

			// Keep GM mode on so the proximity path cannot win the race. Opening
			// itself must synchronously trigger the linked trap.
			result := useGameObjectSpell(t, bot, spellOpening, parentGUID, 10*time.Second)
			if result.outcome == gameObjectSpellCastFailed {
				e2eharness.ConfirmedBugf(t, 12285, "Opening Supply Crate %d failed reason=%d (%s)", crate.parent, result.failReason, e2eharness.SpellFailReasonName(result.failReason))
			}
			if result.outcome != gameObjectSpellReleased {
				e2eharness.ConfirmedBugf(t, 12285, "Opening Supply Crate %d returned outcome=%d, want loot release", crate.parent, result.outcome)
			}
			assertGameObjectGone(t, bot, parentGUID, "Supply Crate", 10*time.Second)
			assertGameObjectGone(t, bot, trapGUID, "linked Supply Crate trap", 10*time.Second)
			if count != nil {
				assertSpellGoCount(t, count, spellPlagueMist, 1)
			}
		})

		t.Run(fmt.Sprintf("disarm_%d", crate.parent), func(t *testing.T) {
			bot.TeleportPad(t, pad)
			if spawnID := bot.SpawnGameObject(t, crate.parent); spawnID == 0 {
				e2eharness.Preconditionf(t, "failed to create cleanup-backed Supply Crate entry=%d", crate.parent)
			}
			parentGUID := bot.WaitGameObject(t, crate.parent, 10*time.Second)
			trapGUID := bot.WaitGameObject(t, crate.trap, 10*time.Second)
			bot.Teleport(t, pad.X+19, pad.Y, pad.Z, pad.Map)

			var count func() int32
			cancel := func() {}
			if crate.parent == goSupplyCrate4 {
				count, cancel = armSpellGoCounter(bot, spellPlagueMist)
			}
			defer cancel()

			bot.CombatReady(t)
			cast := castGameObjectAndWait(t, bot, spellDisarmTrap, trapGUID, 10*time.Second)
			if !cast.Success {
				e2eharness.ConfirmedBugf(t, 12285, "Disarm Trap on Supply Crate %d failed reason=%d (%s)", crate.parent, cast.FailReason, e2eharness.SpellFailReasonName(cast.FailReason))
			}
			assertGameObjectGone(t, bot, trapGUID, "disarmed Supply Crate trap", 10*time.Second)
			assertGameObjectGone(t, bot, parentGUID, "disarmed Supply Crate", 10*time.Second)
			if count != nil {
				assertSpellGoCount(t, count, spellPlagueMist, 0)
			}
		})
	}
}

// Loot-bearing chests must still open normally, while a standard linked-trap
// chest must retain both its loot and its one linked spell cast.
func TestAC_12285_LinkedChestRegressionMatrix(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "instances", "gameobject", "issue", "serial"},
		Runtime:  "med",
		Issue:    12285,
		Category: "instances/classic/stratholme",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "SCReg", Level: 80})
	bot.Learn(t, spellOpening)
	pad := e2eharness.PackagePad(t)

	for _, entry := range []uint32{goNormalSupplyCrate, goStratholmeSupplyCrate} {
		bot.TeleportPad(t, pad)
		if spawnID := bot.SpawnGameObject(t, entry); spawnID == 0 {
			e2eharness.Preconditionf(t, "failed to create cleanup-backed loot chest entry=%d", entry)
		}
		guid := bot.WaitGameObject(t, entry, 10*time.Second)
		result := useGameObjectSpell(t, bot, spellOpening, guid, 10*time.Second)
		if result.outcome != gameObjectSpellLoot {
			e2eharness.ConfirmedBugf(t, 12285, "loot-bearing chest %d returned outcome=%d, want loot window", entry, result.outcome)
		}
		if len(result.items) == 0 {
			e2eharness.ConfirmedBugf(t, 12285, "loot-bearing chest %d opened with no items", entry)
		}
		releaseLootAndWait(t, bot, guid, 5*time.Second)
	}

	bot.TeleportPad(t, pad)
	if spawnID := bot.SpawnGameObject(t, goJinxedHoodooPile); spawnID == 0 {
		e2eharness.Preconditionf(t, "failed to create cleanup-backed Jinxed Hoodoo Pile")
	}
	pileGUID := bot.WaitGameObject(t, goJinxedHoodooPile, 10*time.Second)
	_ = bot.WaitGameObject(t, goJinxedHoodooTrap, 10*time.Second)
	count, cancel := armSpellGoCounter(bot, spellJinxed)
	defer cancel()
	result := useGameObjectSpell(t, bot, spellOpening, pileGUID, 10*time.Second)
	if result.outcome != gameObjectSpellLoot {
		e2eharness.ConfirmedBugf(t, 12285, "Jinxed Hoodoo Pile returned outcome=%d, want loot window", result.outcome)
	}
	assertSpellGoCount(t, count, spellJinxed, 1)
	releaseLootAndWait(t, bot, pileGUID, 5*time.Second)
}

// The quest chest must still fire its linked trap and summon one Milton Beats;
// a trap-only chest now also produces the explicit successful loot release.
func TestAC_12285_PassYourRiteSummonsOneMilton(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "gameobject", "issue", "serial"},
		Runtime:  "short",
		Issue:    12285,
		Category: "instances/classic/stratholme",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Milton",
		Class:  e2eharness.ClassRogue,
		Level:  80,
	})
	bot.Learn(t, spellOpeningChest)
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.AddQuest(t, questTheManorRavenholdt)

	baseline := make(map[uint64]struct{})
	for _, unit := range bot.UnitsByEntry(200, npcMiltonBeats) {
		baseline[unit.GUID] = struct{}{}
	}
	if spawnID := bot.SpawnGameObject(t, goPassYourRite); spawnID == 0 {
		e2eharness.Preconditionf(t, "failed to create cleanup-backed Pass Your Rite chest")
	}
	guid := bot.WaitGameObject(t, goPassYourRite, 10*time.Second)
	count, cancel := armSpellGoCounter(bot, spellConjureMilton)
	defer cancel()
	result := useGameObjectSpell(t, bot, spellOpeningChest, guid, 10*time.Second)
	if result.outcome != gameObjectSpellReleased {
		e2eharness.ConfirmedBugf(t, 12285, "Pass Your Rite returned outcome=%d, want loot release", result.outcome)
	}
	waiterKnown := make(map[uint64]struct{}, len(baseline))
	for guid := range baseline {
		waiterKnown[guid] = struct{}{}
	}
	miltons := bot.WaitNewUnits(t, waiterKnown, []uint32{npcMiltonBeats}, 10*time.Second)
	if len(miltons) != 1 {
		e2eharness.ConfirmedBugf(t, 12285, "Pass Your Rite summoned %d Milton Beats, want 1", len(miltons))
	}
	assertSpellGoCount(t, count, spellConjureMilton, 1)
	spawned := bot.World.GetObject(miltons[0].GUID)
	if spawned == nil || !spawned.HasKnownPosition() {
		e2eharness.Preconditionf(t, "summoned Milton Beats 0x%X has no observable position", miltons[0].GUID)
	}
	playerX, playerY, playerZ, _ := bot.Pos()
	if distance := spawned.DistanceTo(playerX, playerY, playerZ); distance > 10 {
		e2eharness.ConfirmedBugf(t, 12285, "Milton Beats spawned %.1f yards from the opened chest, want at most 10", distance)
	}

	// Allow a duplicate summon to arrive on a later update before counting again.
	newCount := 0
	for _, unit := range bot.UnitsByEntry(120, npcMiltonBeats) {
		if _, existed := baseline[unit.GUID]; !existed {
			newCount++
		}
	}
	if newCount != 1 {
		e2eharness.ConfirmedBugf(t, 12285, "Pass Your Rite left %d new Milton Beats, want exactly 1", newCount)
	}
}

// Disarming a normal non-consumable trap must not cast its damage spell and
// must preserve the template's ten-second respawn delay.
func TestAC_12285_LandMineDisarmUsesRespawnDelay(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "gameobject", "issue", "serial"},
		Runtime:  "med",
		Issue:    12285,
		Category: "instances/classic/stratholme",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "LMine",
		Class:         e2eharness.ClassRogue,
		Level:         80,
		LearnAllClass: true,
	})

	// Static spawn 55453 is isolated from the other Storm Peaks mine clusters
	// and has a ten-second database respawn time.
	const (
		mineX   = float32(5985.16)
		mineY   = float32(-664.707)
		mineZ   = float32(373.689)
		mineMap = uint32(571)
	)
	bot.Teleport(t, mineX, mineY, mineZ, mineMap)
	mineGUID := bot.WaitGameObject(t, goLandMine, 10*time.Second)
	bot.Teleport(t, mineX-19, mineY, mineZ, mineMap)

	count, cancel := armSpellGoCounter(bot, spellLandMine)
	defer cancel()
	bot.CombatReady(t)
	cast := castGameObjectAndWait(t, bot, spellDisarmTrap, mineGUID, 10*time.Second)
	if !cast.Success {
		e2eharness.ConfirmedBugf(t, 12285, "Land Mine disarm failed reason=%d (%s)", cast.FailReason, e2eharness.SpellFailReasonName(cast.FailReason))
	}
	assertGameObjectGone(t, bot, mineGUID, "Land Mine", 3*time.Second)
	assertSpellGoCount(t, count, spellLandMine, 0)
	assertGameObjectAbsentFor(t, bot, mineGUID, "Land Mine", 5*time.Second)
	waitGameObjectGUID(t, bot, mineGUID, "Land Mine", 8*time.Second)
}
