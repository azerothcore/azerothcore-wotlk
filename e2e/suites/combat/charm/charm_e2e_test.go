//go:build e2e

package charm_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Battle Shout ranks (player-cast, cancelable). Do not use GM .aura / 45614 Blending In
// (SPELL_ATTR0_NO_AURA_CANCEL → CMSG_CANCEL_AURA is a silent no-op).
var battleShoutRanks = []uint32{
	47436, // rank 9 (WotLK)
	47434, 25289, 11551, 11550, 11549, 6192, 5242, 6673,
}

func firstBattleShoutAura(bot *e2eharness.ScenarioBot) uint32 {
	for _, id := range battleShoutRanks {
		if bot.HasAura(id) {
			return id
		}
	}
	return 0
}

// CHARM-01: client-cast a cancelable buff then CMSG_CANCEL_AURA must remove it.
func TestCharm_ApplyAndCancelAuraOnSelf(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat"}, Runtime: "short", Category: "combat/charm"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CharmAu",
		Class:         e2eharness.ClassWarrior,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// Rage for Battle Shout (SPELL_FAILED_NO_POWER without it).
	bot.GM(t, ".cheat power on")
	bot.FlushWorld(t)
	// Prefer highest rank first (learn-all knows it).
	castID := battleShoutRanks[0]
	bot.Learn(t, castID)
	bot.CastMust(t, castID, 0, 10*time.Second)
	deadline := time.Now().Add(3 * time.Second)
	var auraID uint32
	for time.Now().Before(deadline) {
		auraID = firstBattleShoutAura(bot)
		if auraID != 0 {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if auraID == 0 {
		e2eharness.Preconditionf(t, "no Battle Shout aura after cast %d", castID)
	}
	bot.CancelAura(t, auraID)
	// Product oracle: CMSG_CANCEL_AURA must remove a cancelable positive aura.
	deadline = time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		if firstBattleShoutAura(bot) == 0 {
			break
		}
		time.Sleep(40 * time.Millisecond)
	}
	if still := firstBattleShoutAura(bot); still != 0 {
		e2eharness.Assertf(t, "aura %d still present after CancelAura", still)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS apply/cancel aura %d removed", auraID)
}

// OPEN(e2e): re-enable when AC#25506 is fixed — Yogg-Saron mind-control disconnect must not crash.
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/25506
// These bodies were not a Yogg MC repro (Blending In + hard drop). Keep commented until a real charm path exists.
/*
func TestCharm_LogoutWhileAuraWorldAlive(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "issue", "serial"},
		Runtime:  "med",
		Issue:    25506,
		Category: "combat/charm",
	})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmPr", Level: 10})
	victim := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmVc", Level: 80})
	victim.TeleportPad(t, e2eharness.PackagePad(t))
	victim.ApplyAura(t, e2eharness.SpellBlendingInAura)
	victim.Save(t)
	e2eharness.HardDisconnectAndProbe(t, victim, probe, 25506)
	t.Logf("PASS logout while aura world alive")
}

func TestCharm_HardDropWhileAuraNoCrash(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "issue", "serial"},
		Runtime:  "med",
		Issue:    25506,
		Category: "combat/charm",
	})

	probe := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmHd", Level: 10})
	victim := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "CharmHv", Level: 80})
	victim.ApplyAura(t, e2eharness.SpellBlendingInAura)
	e2eharness.HardDisconnectAndProbe(t, victim, probe, 25506)
	t.Logf("PASS hard drop while aura no crash")
}
*/

// CHARM-04: multi-bot — one applies aura, other probes after victim leave.
func TestCharm_MultiBotProbeAfterVictimLeave(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"med", "combat", "multi_bot", "serial"}, Runtime: "med", Category: "combat/charm"})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{Prefix: "CharmMb", Count: 2, Level: 80})
	a, b := bots[0], bots[1]
	a.ApplyAura(t, e2eharness.SpellBlendingInAura)
	a.LeaveGroup(t) // no-op if not grouped
	e2eharness.HardDisconnectAndProbe(t, a, b, 0)
	t.Logf("PASS multi-bot probe after victim leave")
}

// CHARM-05: CancelCast helper path — start a self-channel, then CancelCastWhenChanneling.
// Uses Hellfire (self-channel) instead of ground-targeted Rain of Fire: DEST casts flake on
// a noisy pad / after tele, and rank-1 RoF is often replaced after `.learn all my class`.
func TestCharm_CancelCastSafe(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "combat", "serial"}, Runtime: "short", Category: "combat/charm"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix:        "CharmCc",
		Class:         e2eharness.ClassWarlock,
		Level:         80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// gm off + mana for a real channel (account GM still allows .modify).
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: false, Power: true})

	// Prefer max-rank Hellfire; fall back to rank 1. Match any channel spell (rank rewrite).
	channelSpells := []uint32{e2eharness.SpellHellfireMax, e2eharness.SpellHellfire}
	var canceled bool
	for attempt := 0; attempt < 3 && !canceled; attempt++ {
		spell := channelSpells[attempt%len(channelSpells)]
		if err := bot.World.CastSpell(spell, bot.GUID); err != nil {
			e2eharness.HarnessFailf(t, "CastSpell hellfire %d: %v", spell, err)
		}
		// spellID 0 = any channel (server may channel a different rank than cast id).
		canceled = bot.CancelCastWhenChanneling(t, 0, 4*time.Second)
		if !canceled {
			bot.CancelCast(t)
			// Top up mana and retry.
			bot.GM(t, ".modify mana 999999")
			bot.FlushWorld(t)
		}
	}
	if !canceled {
		e2eharness.Preconditionf(t, "CancelCast path: no channel observed after Hellfire retries (channel=%d)", bot.ChannelSpell())
		return
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS cancel cast path channeling=%v canceled=%v channel_spell=%d", bot.IsChanneling(), canceled, bot.ChannelSpell())
}
