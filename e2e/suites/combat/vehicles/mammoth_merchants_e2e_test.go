//go:build e2e

package vehicles_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/3778
// Fixture: the Traveler's Tundra Mammoth, whose mount aura makes the player the vehicle base.
const (
	// Traveler's Tundra Mammoth, Alliance (item 44235) mounts creature 32633.
	spellMammothAlliance uint32 = 61425
	// The npc_spellclick_spells ride spell of 32633: on the player exactly while a vendor is seated.
	spellMammothSeatAura uint32 = 61424
	// vehicle_template_accessory of 32633: Hakmud of Argus (seat 1) and Gnimo (seat 2).
	merchantHakmud uint32 = 32638
	merchantGnimo  uint32 = 32639

	mapObsidianSanctum = uint32(615)
	// Dragonblight, outdoors and clear of the raid portal's areatrigger.
	teleMammothOutside = "ObsidianDragonshrine"
	// Stock game_tele into the Obsidian Sanctum raid itself.
	teleMammothInside = "TheObsidianSanctumInstance"

	vendorWait = 20 * time.Second
)

// mammothState reports the mount, anything still seated on it, and which vendors this map has.
func mammothState(bot *e2eharness.ScenarioBot) (mounted, seated bool, missing []uint32) {
	mounted = bot.HasAura(spellMammothAlliance)
	seated = bot.HasAura(spellMammothSeatAura)
	for _, entry := range []uint32{merchantHakmud, merchantGnimo} {
		if bot.FindUnit(entry, 0) == 0 {
			missing = append(missing, entry)
		}
	}
	return mounted, seated, missing
}

// waitMammothSeated polls until the mount carries both vendors, then returns the last state.
func waitMammothSeated(bot *e2eharness.ScenarioBot, timeout time.Duration) (mounted, seated bool, missing []uint32) {
	deadline := time.Now().Add(timeout)
	for {
		mounted, seated, missing = mammothState(bot)
		if mounted && seated && len(missing) == 0 {
			return mounted, seated, missing
		}
		if !time.Now().Before(deadline) {
			return mounted, seated, missing
		}
		time.Sleep(100 * time.Millisecond)
	}
}

// AC-1/AC-2: mount in the world, cross into the Obsidian Sanctum, come back out.
func TestAC_3778_MammothMerchantsSurviveMapChange(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "combat", "vehicles", "issue"},
		Runtime:  "short",
		Issue:    3778,
		Category: "combat/vehicles",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "VehMam",
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassWarrior,
		Level:  80,
	})

	// Mount in the world first, as the report has it.
	bot.TeleNamed(t, teleMammothOutside)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapNorthrend {
		e2eharness.Preconditionf(t, "not in Northrend after .tele %s (map=%d)", teleMammothOutside, m)
	}
	bot.Learn(t, spellMammothAlliance)
	_ = bot.CastOrGM(t, spellMammothAlliance, 0, 10*time.Second)
	if !bot.HasAura(spellMammothAlliance) {
		bot.ApplyAura(t, spellMammothAlliance)
	}
	mounted, seated, missing := waitMammothSeated(bot, vendorWait)
	if !mounted || !seated || len(missing) > 0 {
		e2eharness.Preconditionf(t,
			"mammoth not mounted with both vendors before any map change (mounted=%v seated=%v missingEntries=%v auras=%v)",
			mounted, seated, missing, bot.World.SelfAuras())
	}
	t.Logf("mounted with both vendors in Northrend, entering the Obsidian Sanctum")

	bot.TeleNamed(t, teleMammothInside)
	if _, _, _, m := bot.Pos(); m != mapObsidianSanctum {
		e2eharness.Preconditionf(t, "not in the Obsidian Sanctum after .tele %s (map=%d)", teleMammothInside, m)
	}
	mounted, seated, missing = waitMammothSeated(bot, vendorWait)
	if !mounted {
		e2eharness.Assertf(t, "mammoth mount aura %d lost entering the instance", spellMammothAlliance)
	}
	if !seated || len(missing) > 0 {
		e2eharness.ConfirmedBugf(t, 3778,
			"vendors did not come through the instance portal with the mount (seated=%v missingEntries=%v auras=%v)",
			seated, missing, bot.World.SelfAuras())
	}
	t.Logf("PASS AC#3778 both vendors seated on the mammoth inside the Obsidian Sanctum")

	bot.TeleNamed(t, teleMammothOutside)
	if _, _, _, m := bot.Pos(); m != e2eharness.MapNorthrend {
		e2eharness.Preconditionf(t, "not back in Northrend after .tele %s (map=%d)", teleMammothOutside, m)
	}
	mounted, seated, missing = waitMammothSeated(bot, vendorWait)
	if !mounted {
		e2eharness.Assertf(t, "mammoth mount aura %d lost leaving the instance", spellMammothAlliance)
	}
	if !seated || len(missing) > 0 {
		e2eharness.ConfirmedBugf(t, 3778,
			"vendors did not come back out of the instance with the mount (seated=%v missingEntries=%v auras=%v)",
			seated, missing, bot.World.SelfAuras())
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS AC#3778 both vendors still seated on the mammoth back in the world")
}
