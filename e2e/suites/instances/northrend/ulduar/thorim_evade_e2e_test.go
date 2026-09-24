//go:build e2e

package ulduar_test

import (
	"strings"
	"sync/atomic"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Thorim despawns on evade (HARD_RESET, PR #27059). When his own melee kills the last player,
// the evade runs inside that damage call, and the damage-shield pass that follows still calls
// DealDamage on the now-dead Thorim with 0 damage because Retribution Aura persists through
// death. His defeat check (damage >= health) then held on 0 health: the Cache of Storms spawned,
// the encounter credit fired and DONE was written on an object already queued for removal, while
// the scheduled respawn brought back a fresh Thorim whose Reset cleared the state again. The
// encounter reopened and a second defeat produced a second chest.
//
// Drive: a paladin bait with Retribution Aura stands in the arena, a second bot on the balcony
// unlocks the ring phase and pulls Thorim down onto the bait, whose death is the wipe.
// Oracle: no Cache of Storms after the evade, Thorim respawns hostile, and a real lethal hit on the
// respawned Thorim still yields (chest spawns, he turns friendly and unattackable).
//
// The defeat block writes DONE before its CombatStop; that call ends Thorim's combat inside the
// same damage call, and JustExitedCombat evades unless the boss state already reads DONE. An
// evade there would reset him mid-outro: hostile again, home on the balcony, NOT_STARTED. So the
// yield subtest also follows the outro: Thorim stays friendly until his teleport removes him, no
// hostile Thorim comes back, and the instance save keeps his encounter DONE.
func TestUlduar_ThorimEvadeDespawnDoesNotYield(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances", "multi_bot"},
		Runtime:  "long",
		Category: "instances/northrend/ulduar",
	})

	const (
		npcThorim           = uint32(32865)
		npcRunicColossus    = uint32(32872)
		npcAncientRuneGiant = uint32(32873)

		goCacheOfStorms10     = uint32(194312)
		goCacheOfStorms10Hard = uint32(194313)

		spellRetributionAura = uint32(54043)

		// SMSG_SPELLNONMELEEDAMAGELOG (3.3.5a); the harness has no constant for it.
		opSpellNonMeleeDamageLog = uint16(0x0250)

		unitFlagNonAttackable = uint32(0x00000002)
		factionFriendly       = uint32(35)

		// Thorim's DB spawn on the balcony; the jump-down needs the hitter above z 430.
		balconyX, balconyY, balconyZ = float32(2131.02), float32(-297.65), float32(438.331)
		// Arena floor (game_tele BossThorim), inside GetArenaPlayer()'s box.
		arenaX, arenaY, arenaZ = float32(2135.35), float32(-251.086), float32(419.743)
		// In front of the Ancient Rune Giant; the Runic Colossus is ~100y from here, in cache range.
		gauntletX, gauntletY, gauntletZ = float32(2134.57), float32(-430.0), float32(438.331)

		// A chest spawned by the bug is created in the same tick as the death.
		chestWindow = 6 * time.Second
		// DespawnOnEvade's default respawn delay is 20s.
		respawnWindow = 45 * time.Second
		lethalHit     = uint32(50_000_000)
		// The defeat outro is four timed lines (about 35s) and ends with Thorim teleporting out.
		outroWindow = 90 * time.Second

		// instance.data is the DataHeader chars, then one EncounterState per boss, space separated.
		saveHeaderFields = 2  // "UU"
		bossThorim       = 10 // BOSS_THORIM in ulduar.h
		encounterDone    = "3"
	)

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "ThEvd",
		Bots: []e2eharness.BotSpec{
			{Role: "driver", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true},
			{Role: "bait", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80, LearnAllClass: true},
		},
	})
	driver := e2eharness.ByRole(t, bots, "driver")
	bait := e2eharness.ByRole(t, bots, "bait")

	// A plain tele would hand each bot its own instance copy; .summon pulls the bait into the
	// driver's. Stay GM through the raid enter.
	e2eharness.FormParty(t, driver, bait)
	// Reset any Ulduar the leader is bound to so a re-run does not enter a still-loaded instance
	// left mid-fight by a previous run (harmless no-op on a fresh account).
	driver.LeaderResetInstances(t, 5*time.Second)
	driver.Teleport(t, balconyX, balconyY, balconyZ, e2eharness.MapUlduar)
	if _, _, _, m := driver.Pos(); m != e2eharness.MapUlduar {
		e2eharness.Preconditionf(t, "driver not in Ulduar after balcony tele map=%d", m)
	}
	driverGUID := driver.World.CharGUID()
	before := bait.World.TeleportSeq()
	driver.GM(t, ".summon "+bait.Name)
	if err := bait.World.WaitForTeleportAfter(before, 15*time.Second); err != nil {
		e2eharness.Preconditionf(t, "bait .summon into Ulduar: %v", err)
	}
	colocated := time.Now().Add(15 * time.Second)
	for bait.World.GetObject(driverGUID) == nil {
		if !time.Now().Before(colocated) {
			e2eharness.Preconditionf(t, "bait never saw the driver after .summon: separate instance copies")
		}
		time.Sleep(100 * time.Millisecond)
	}

	// The jump-down is gated on the Ancient Rune Giant's death (ACTION_ALLOW_HIT). Both gauntlet
	// golems are Thorim's summons, up since his Reset; nothing is engaged yet, so GM damage is fine.
	driver.Teleport(t, gauntletX, gauntletY, gauntletZ, e2eharness.MapUlduar)
	giant := driver.WaitUnit(t, npcAncientRuneGiant, 15*time.Second)
	colossus := driver.WaitUnit(t, npcRunicColossus, 15*time.Second)
	driver.DamageKill(t, []uint64{giant, colossus}, 10_000_000, 20*time.Second)

	driver.Teleport(t, balconyX, balconyY, balconyZ, e2eharness.MapUlduar)
	bait.Teleport(t, arenaX, arenaY, arenaZ, e2eharness.MapUlduar)
	// Co-location is already proven (the bait saw the driver's own GUID); the bait never needs
	// Thorim in its cache, since the packet hook matches him by GUID from raw packets. Creature
	// GUIDs are shared across one instance, so the driver's Thorim GUID is the bait's too.
	thorim := driver.WaitUnit(t, npcThorim, 15*time.Second)
	driver.CombatReady(t)

	// The bait must stay killable by Thorim's melee, so it is left out of god mode (CombatReady
	// would enable it). Retribution Aura is the death-persistent damage shield that lets the shield
	// pass reach Thorim after the bait is already dead.
	bait.GM(t, ".gm off")
	bait.GM(t, ".cheat god off")
	bait.FlushWorld(t)
	bait.CastMust(t, spellRetributionAura, bait.World.CharGUID(), 10*time.Second)
	if !bait.HasAura(spellRetributionAura) {
		e2eharness.Preconditionf(t, "bait has no Retribution Aura after the cast")
	}
	// The bait keeps its (small) full health; Thorim's melee kills it in a swing or two, and every
	// swing reflects Retribution Aura back at him.

	// Only Thorim's own hits on the bait matter: his melee (SMSG_ATTACKERSTATEUPDATE, attacker then
	// target) runs the death-persistent shield pass that reproduces the bug, a spell
	// (SMSG_SPELLNONMELEEDAMAGELOG, target then caster) does not. Both opcodes are broadcast for
	// nearby combat too, so filter by GUID or the driver's own hits would misclassify the death.
	baitGUID := bait.World.CharGUID()
	var lastMelee, lastSpell atomic.Int64
	cancelHook := bait.World.AddPacketHook(func(opcode uint16, data []byte) {
		switch opcode {
		case client.SmsgAttackerStateUpdate:
			attacker, off := readPackedGUID(data, 4) // after uint32 HitInfo
			if target, _ := readPackedGUID(data, off); attacker == thorim && target == baitGUID {
				lastMelee.Store(time.Now().UnixNano())
			}
		case opSpellNonMeleeDamageLog:
			target, off := readPackedGUID(data, 0)
			if caster, _ := readPackedGUID(data, off); caster == thorim && target == baitGUID {
				lastSpell.Store(time.Now().UnixNano())
			}
		}
	})
	defer cancelHook()

	// Killing the Ancient Rune Giant already set ACTION_ALLOW_HIT, so a player hit from the balcony
	// (z > 430) drops Thorim into the ring phase. He resets threat onto the arena player (the bait)
	// and chases her.
	dx, dy, dz, _ := driver.Pos()
	t.Logf("driver on balcony at (%.1f,%.1f,%.1f)", dx, dy, dz)
	if dz <= 430 {
		e2eharness.Preconditionf(t, "driver stands at z=%.1f, below the balcony threshold the jump needs", dz)
	}
	jumpDeadline := time.Now().Add(15 * time.Second)
	jumped := false
	for time.Now().Before(jumpDeadline) {
		driver.Damage(t, thorim, 1)
		obj := driver.World.GetObject(thorim)
		if obj != nil && obj.PosZ < 430 {
			jumped = true
			break
		}
		time.Sleep(500 * time.Millisecond)
	}
	if !jumped {
		e2eharness.Preconditionf(t, "Thorim did not jump into the arena after balcony hits")
	}
	// The driver leaves combat so the bait's death is the wipe that ends Thorim's combat.
	driver.CombatStop(t)

	bait.WaitDead(t, 25*time.Second)
	diedAt := time.Now()
	if lastMelee.Load() == 0 || lastSpell.Load() > lastMelee.Load() {
		e2eharness.Preconditionf(t, "bait died to a spell, not to Thorim's melee: no damage-shield pass to judge")
	}
	t.Logf("bait died to melee at %s", diedAt.Format(time.StampMilli))

	// A chest here is the defeat block running on the despawning Thorim. This drive never summons
	// Sif, so Thorim lacks the Touch of Dominion trigger (62565) and the ring phase flags hard mode;
	// the defeat block would then spawn the hard-mode Cache (194313), so accept either entry.
	if g := anyCacheOfStorms(t, driver.World, goCacheOfStorms10, goCacheOfStorms10Hard, chestWindow); g != 0 {
		e2eharness.Assertf(t, "Cache of Storms 0x%X spawned from Thorim's evade despawn", g)
	}

	// The hard reset brings back a fresh, hostile Thorim on the balcony. On the buggy core the same
	// evade also produced the chest above; here he is simply attackable again.
	respawned := waitHostileThorim(t, driver, npcThorim, unitFlagNonAttackable, factionFriendly, respawnWindow)
	if respawned == thorim {
		e2eharness.Preconditionf(t, "Thorim 0x%X was never despawned by the evade (HARD_RESET missing?)", thorim)
	}
	t.Logf("after evade: respawned hostile Thorim 0x%X (was 0x%X)", respawned, thorim)

	// A real lethal hit on the respawned Thorim must still yield: chest spawns and he turns friendly
	// and unattackable. This proves the guard did not break the normal defeat.
	t.Run("LethalHitStillYields", func(t *testing.T) {
		driver.Damage(t, respawned, lethalHit)
		chest := anyCacheOfStorms(t, driver.World, goCacheOfStorms10, goCacheOfStorms10Hard, 10*time.Second)
		if chest == 0 {
			e2eharness.Assertf(t, "no Cache of Storms after a lethal hit on Thorim")
		}
		yieldDeadline := time.Now().Add(5 * time.Second)
		yielded := false
		for time.Now().Before(yieldDeadline) {
			obj := driver.World.GetObject(respawned)
			if obj != nil && obj.Value(client.UnitFieldFlags)&unitFlagNonAttackable != 0 && obj.Value(client.UnitFieldFaction) == factionFriendly {
				yielded = true
				break
			}
			time.Sleep(50 * time.Millisecond)
		}
		if !yielded {
			e2eharness.Assertf(t, "Thorim not friendly and unattackable after his defeat")
		}
		t.Logf("PASS lethal hit yields: chest=0x%X", chest)

		// The outro must run to the teleport without an evade: Thorim never turns hostile again while
		// he is still there, and his removal from the cache is the teleport, not a hard reset.
		outroDeadline := time.Now().Add(outroWindow)
		gone := false
		for time.Now().Before(outroDeadline) {
			obj := driver.World.GetObject(respawned)
			if obj == nil {
				gone = true
				break
			}
			if obj.Value(client.UnitFieldFlags)&unitFlagNonAttackable == 0 || obj.Value(client.UnitFieldFaction) != factionFriendly {
				e2eharness.Assertf(t, "Thorim evaded through his outro: flags=0x%X faction=%d",
					obj.Value(client.UnitFieldFlags), obj.Value(client.UnitFieldFaction))
			}
			time.Sleep(200 * time.Millisecond)
		}
		if !gone {
			e2eharness.Assertf(t, "Thorim still in the arena %s after his defeat: outro never reached the teleport", outroWindow)
		}
		t.Logf("outro done: Thorim 0x%X left through the teleport", respawned)

		// DONE blocks the respawn (BossAI::CanRespawn); a hostile Thorim here is a reset encounter.
		noRespawnDeadline := time.Now().Add(respawnWindow)
		for time.Now().Before(noRespawnDeadline) {
			for _, g := range e2eharness.LivingByEntries(driver.World, 120, npcThorim) {
				obj := driver.World.GetObject(g)
				if obj != nil && obj.Value(client.UnitFieldFlags)&unitFlagNonAttackable == 0 && obj.Value(client.UnitFieldFaction) != factionFriendly {
					e2eharness.Assertf(t, "hostile Thorim 0x%X respawned after the defeat outro", g)
				}
			}
			time.Sleep(500 * time.Millisecond)
		}

		// The instance save is what a later reload reads; the defeat must leave BOSS_THORIM at DONE.
		state := thorimSavedState(t, driver, saveHeaderFields, bossThorim, 10*time.Second)
		if state != encounterDone {
			e2eharness.Assertf(t, "instance save has Thorim at state %s after the outro, want DONE (%s)", state, encounterDone)
		}
		t.Logf("PASS outro survives defeat: no respawn, saved state=%s", state)
	})

	t.Logf("PASS Thorim evade despawn does not yield: old=0x%X respawned=0x%X", thorim, respawned)
}

// thorimSavedState reads the bot's bound Ulduar save and returns the Thorim boss-state field.
func thorimSavedState(t *testing.T, b *e2eharness.ScenarioBot, headerFields, bossIndex int, timeout time.Duration) string {
	t.Helper()
	var data string
	var lastErr error
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		lastErr = b.CharDB.QueryRow(`
			SELECT i.data FROM instance i
			JOIN character_instance ci ON ci.instance = i.id
			WHERE ci.guid = ? AND i.map = ?
			ORDER BY i.id DESC LIMIT 1`, b.GUID, e2eharness.MapUlduar).Scan(&data)
		if lastErr == nil && len(strings.Fields(data)) > headerFields+bossIndex {
			break
		}
		time.Sleep(250 * time.Millisecond)
	}
	if lastErr != nil {
		e2eharness.HarnessFailf(t, "instance save query: %v", lastErr)
	}
	fields := strings.Fields(data)
	if len(fields) <= headerFields+bossIndex {
		e2eharness.Preconditionf(t, "instance save data too short for Ulduar: %q", data)
	}
	t.Logf("instance save: %q", data)
	return fields[headerFields+bossIndex]
}

// waitHostileThorim waits for a living Thorim that is attackable and not friendly.
func waitHostileThorim(t *testing.T, b *e2eharness.ScenarioBot, entry, nonAttackable, friendly uint32, timeout time.Duration) uint64 {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		for _, g := range e2eharness.LivingByEntries(b.World, 120, entry) {
			obj := b.World.GetObject(g)
			if obj == nil {
				continue
			}
			if obj.Value(client.UnitFieldFlags)&nonAttackable == 0 && obj.Value(client.UnitFieldFaction) != friendly {
				return g
			}
		}
		time.Sleep(100 * time.Millisecond)
	}
	e2eharness.Assertf(t, "no hostile Thorim within %s of the evade", timeout)
	return 0
}

// anyCacheOfStorms returns the guid of the first Cache of Storms of either entry found in range,
// or 0 if none appears within timeout.
func anyCacheOfStorms(t *testing.T, w *client.WorldClient, normal, hard uint32, timeout time.Duration) uint64 {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for {
		for _, entry := range []uint32{normal, hard} {
			if g := w.FindGameObjectByEntry(entry, 60); g != 0 {
				return g
			}
		}
		if !time.Now().Before(deadline) {
			return 0
		}
		time.Sleep(100 * time.Millisecond)
	}
}

// readPackedGUID reads a WoW packed GUID starting at off and returns the guid and the next offset.
// The first byte is a bitmask; each set bit i contributes byte i of the guid, low bit first.
func readPackedGUID(b []byte, off int) (uint64, int) {
	if off >= len(b) {
		return 0, off
	}
	mask := b[off]
	off++
	var guid uint64
	for i := 0; i < 8; i++ {
		if mask&(1<<uint(i)) != 0 {
			if off >= len(b) {
				break
			}
			guid |= uint64(b[off]) << (8 * uint(i))
			off++
		}
	}
	return guid, off
}
