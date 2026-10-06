//go:build e2e

package immunity_test

import (
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27355
// Cyclone makes its target immune to another Cyclone while active, so the Druid
// cannot refresh it on the same target (only re-cast after it ends).
func TestAC_27355_CycloneCannotReapplyWhileActive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "combat", "issue", "serial"},
		Runtime:  "med",
		Issue:    27355,
		Category: "spells/immunity",
	})

	const (
		spellCyclone = uint32(33786) // Druid Cyclone (WotLK)
		dummy        = uint32(32171) // hostile dummy; no CC immunity
		cycloneDur   = 6 * time.Second
		recastDelay  = 4500 * time.Millisecond // leave time to observe an immune instant recast
		judgeSlack   = 500 * time.Millisecond
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Cyc27", Race: e2eharness.RaceTauren,
		Class: e2eharness.ClassDruid, Level: 80, LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// Northshire strip (map 0): open and spawn-safe.
	const (
		cx, cy, cz float32 = -8904.0, -128.0, 81.0
		cm         uint32  = 0
	)
	bot.Teleport(t, cx, cy, cz, cm)
	bot.CombatReadyFull(t)
	bot.CombatStop(t)
	bot.FlushWorld(t)
	bot.Learn(t, spellCyclone)
	// Remove cast time so the second cast cannot land after the first aura expires.
	bot.GM(t, ".cheat casttime on")

	guid := bot.Spawn(t, dummy, 30*time.Second)
	if guid == 0 {
		e2eharness.Preconditionf(t, "failed to spawn Cyclone target")
	}
	_ = bot.World.SetTarget(guid)
	bot.Face(t, guid)

	// First Cyclone must land and hold the target.
	bot.CastMust(t, spellCyclone, guid, 15*time.Second)
	bot.WaitUnitAura(t, guid, spellCyclone, 3*time.Second)
	firstAppliedAt := time.Now()

	// Recast while the first Cyclone is about to expire. A refresh (the bug) would
	// replace it with a fresh DR'd aura that outlasts the ~6s window; an immune recast
	// leaves the original to end on its own.
	recastAt := firstAppliedAt.Add(recastDelay)
	for time.Now().Before(recastAt) && bot.UnitHasAura(guid, spellCyclone) {
		time.Sleep(50 * time.Millisecond)
	}
	if !bot.UnitHasAura(guid, spellCyclone) {
		e2eharness.Preconditionf(t, "Cyclone faded before the recast window")
	}
	bot.Face(t, guid)
	if result, err := bot.TryCast(t, spellCyclone, guid, 10*time.Second); err != nil {
		e2eharness.HarnessFailf(t, "second Cyclone produced no cast result: %v", err)
	} else if !result.Success {
		e2eharness.Preconditionf(t, "second Cyclone failed to cast: %s", e2eharness.SpellFailReasonName(result.FailReason))
	}

	// After the recast the target must drop out within the time left of the first
	// Cyclone; still being cycloned past that means it was refreshed.
	deadline := firstAppliedAt.Add(cycloneDur + judgeSlack)
	if !time.Now().Before(deadline) {
		e2eharness.Preconditionf(t, "cast response arrived after the observation window")
	}
	for time.Now().Before(deadline) {
		if !bot.UnitHasAura(guid, spellCyclone) {
			break
		}
		time.Sleep(50 * time.Millisecond)
	}
	if bot.UnitHasAura(guid, spellCyclone) {
		e2eharness.ConfirmedBugf(t, 27355,
			"second Cyclone refreshed the active Cyclone; recast should be immune")
	}
	// The spell must become usable again once its immunity aura has ended.
	bot.Face(t, guid)
	bot.CastMust(t, spellCyclone, guid, 10*time.Second)
	bot.WaitUnitAura(t, guid, spellCyclone, 3*time.Second)
	bot.AssertWorldAlive(t)
	t.Logf("PASS second Cyclone did not refresh active Cyclone on dummy 0x%X", guid)
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/25481
// PR:    https://github.com/azerothcore/azerothcore-wotlk/pull/25984
// Lady Vashj (21212) is guarded by four shield generators; entering phase 2 must
// summon all four beams and apply one Magic Barrier (38112) per generator.
func TestAC_25481_LadyVashjFourMagicBarriers(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "spells", "instances", "issue", "serial"},
		Runtime:  "long",
		Issue:    25481,
		Category: "spells/immunity",
	})

	const (
		npcLadyVashj      = uint32(21212)
		spellMagicBarrier = uint32(38112)
	)

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Vashj", Level: 80, LearnAllClass: true,
	})
	// Enter the raid instance while still GM (a solo, non-GM player cannot be placed
	// on a raid map). CombatReady below drops GM mode and enables god so Vashj
	// actually engages us instead of ignoring an invisible GM.
	bot.GoCreatureID(t, npcLadyVashj)
	vashj := bot.WaitUnit(t, npcLadyVashj, 30*time.Second)
	if vashj == 0 {
		e2eharness.Preconditionf(t, "Lady Vashj (21212) not found after .go creature id 21212")
	}
	// Observe slots before phase 2. GetActiveAuras deduplicates spell IDs, and
	// AuraStacks returns the maximum stack count, not the number of applications.
	var auraMu sync.Mutex
	auraSlots := make(map[uint8]uint32)
	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != auraUpdate && opcode != auraUpdateAll {
			return
		}
		target, slots, ok := decodeAuraSlots(data)
		if !ok || target != vashj {
			return
		}
		auraMu.Lock()
		defer auraMu.Unlock()
		applyAuraSlots(auraSlots, slots, opcode == auraUpdateAll)
	})
	defer cancel()
	bot.CombatReadyFull(t)
	bot.Engage(t, vashj, 20*time.Second)
	// Phase 2 starts at 70% HP; drop her below that without killing her.
	bot.DamageToFraction(t, vashj, 0.5, 30*time.Second)

	// The four phase-2 beams each apply their own Magic Barrier (one aura slot per
	// generator/caster), so count aura applications rather than stack count.
	barriers := func() int {
		auraMu.Lock()
		defer auraMu.Unlock()
		n := 0
		for _, id := range auraSlots {
			if id == spellMagicBarrier {
				n++
			}
		}
		return n
	}
	deadline := time.Now().Add(8 * time.Second)
	seen := 0
	for time.Now().Before(deadline) {
		seen = barriers()
		if seen >= 4 {
			break
		}
		time.Sleep(100 * time.Millisecond)
	}
	t.Logf("Lady Vashj Magic Barrier applications=%d (want 4)", seen)
	if seen == 0 {
		e2eharness.Preconditionf(t, "no Magic Barrier applied in phase 2 (encounter/reach not driven)")
	}
	if seen < 4 {
		e2eharness.ConfirmedBugf(t, 25481,
			"Lady Vashj has %d Magic Barrier application(s) in phase 2, expected 4 (positive school-immunity stacking broke)",
			seen)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS Lady Vashj has 4 Magic Barriers in phase 2")
}
