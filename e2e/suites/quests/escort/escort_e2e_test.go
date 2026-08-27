//go:build e2e

package escort_test

import (
	"fmt"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

// OPEN(e2e): replace this package with a real escort quest fixture (start → follow →
// complete/fail oracle). Until then only keep spawn/cache helpers that have hard asserts.

// ESCORT-02: unit still findable after spawn (hard GUID/cache oracle).
func TestEscort_UnitFindableAfterSpawn(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "quests"}, Runtime: "short", Category: "quests/escort"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "EscFd", Level: 80})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	guid := bot.Spawn(t, e2eharness.CreatureTargetDummy, 15*time.Second)
	found := bot.FindUnit(e2eharness.CreatureTargetDummy, 50)
	if found == 0 {
		e2eharness.Assertf(t, "FindUnit 0 after spawn guid=0x%X", guid)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS unit findable found=0x%X spawn=0x%X", found, guid)
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/24450
// Quest 12512 Leave No One Behind: bandage Crusader Jonathan (28133) summons
// follower 28136 (SMART_ACTION_FOLLOW). Logout must despawn the follower
// (SmartAI::UpdateFollow when FindPlayer fails).
// https://www.wowhead.com/wotlk/quest=12512/leave-no-one-behind
func TestAC_24450_FollowDespawnsOnLogout(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "quests", "ai", "issue", "serial"},
		Runtime:  "med",
		Issue:    24450,
		Category: "quests/escort",
	})

	const (
		questLeaveNoOneBehind = uint32(12512)
		itemCrusadersBandage  = uint32(38330)
		spellCrusadersBandage = uint32(50662)
		npcJonathanWorld      = uint32(28133) // sitting world spawn
		npcJonathanFollow     = uint32(28136) // summoned follower
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "EscFol",
		Level:  80,
	})
	bot.AddQuest(t, questLeaveNoOneBehind)
	bot.AddItem(t, itemCrusadersBandage, 1)
	bot.GoCreatureID(t, npcJonathanWorld)
	worldNPC := bot.WaitUnit(t, npcJonathanWorld, 20*time.Second)
	if worldNPC == 0 {
		e2eharness.Preconditionf(t, "Crusader Jonathan %d not at world spawn", npcJonathanWorld)
	}
	bot.DespawnNearbyEntry(t, npcJonathanFollow, 80)

	// 50662 is an item spell; client CastSpell without USE_ITEM never SPELL_GOs.
	// Targeted `.cast` is the GM stand-in for using Crusader's Bandage on Jonathan.
	known := map[uint64]struct{}{}
	for _, u := range bot.UnitsByEntry(80, npcJonathanFollow) {
		known[u.GUID] = struct{}{}
	}
	if err := bot.World.SetTarget(worldNPC); err != nil {
		e2eharness.Preconditionf(t, "SetTarget Jonathan 0x%X: %v", worldNPC, err)
	}
	bot.GM(t, fmt.Sprintf(".cast %d", spellCrusadersBandage))
	fresh := bot.WaitNewUnits(t, known, []uint32{npcJonathanFollow}, 20*time.Second)
	if len(fresh) == 0 {
		e2eharness.Preconditionf(t, "bandage did not summon a new follow-NPC %d", npcJonathanFollow)
	}
	follower := fresh[0].GUID
	t.Logf("follower 28136 guid=0x%X after bandage", follower)

	// UpdateFollow only ticks every 1s. A tight Relog can come back before
	// FindPlayer fails, so stay offline past that timer, then login.
	if err := bot.World.SendLogout(); err != nil {
		e2eharness.HarnessFailf(t, "logout: %v", err)
	}
	if err := bot.World.WaitForLogout(30 * time.Second); err != nil {
		t.Logf("logout wait: %v (continuing)", err)
	}
	bot.Close()
	time.Sleep(2 * time.Second)
	bot.Relog(t)
	// Fresh snapshot: sitting Jonathan must be in the create set first.
	if bot.WaitUnit(t, npcJonathanWorld, 20*time.Second) == 0 {
		e2eharness.Preconditionf(t, "after login, world Jonathan %d not in object cache — snapshot not ready", npcJonathanWorld)
	}
	if obj := bot.World.GetObject(follower); obj != nil {
		e2eharness.Assertf(t, "follow-NPC %d still in snapshot after logout (guid=0x%X)", npcJonathanFollow, follower)
	}
	if leftover := bot.FindUnit(npcJonathanFollow, 80); leftover != 0 {
		e2eharness.Assertf(t, "follow-NPC %d still in world after logout (guid=0x%X)", npcJonathanFollow, leftover)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS AC#24450 follower %d despawned after logout", npcJonathanFollow)
}
