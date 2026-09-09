//go:build e2e

package aura_test

import (
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27279
// Aura of Despair blocks Life Tap's mana restoration, but must not prevent the
// glyph buff. Apply the encounter aura as setup; drive Life Tap by client cast.
func TestAC_27279_LifeTapGlyphUnderDespair(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:    []string{"short", "spells", "aura", "issue", "serial"},
		Runtime: "short", Issue: 27279, Category: "spells/aura",
	})
	const (
		lifeTap   = uint32(1454)
		demonSkin = uint32(687)
		glyph     = uint32(63320)
		glyphBuff = uint32(63321)
		despair   = uint32(62692)
	)
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Tap272", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarlock, Level: 80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	bot.Learn(t, lifeTap)
	bot.Learn(t, demonSkin)
	// Glyph 63320 is passive and is not sent as a visible aura. Learning it
	// applies the passive without waiting for a nonexistent client aura slot.
	bot.Learn(t, glyph)
	bot.GM(t, ".gm off")
	bot.GM(t, ".cheat power off")
	// GCD is unrelated to this proc oracle; keep consecutive client casts deterministic.
	bot.GM(t, ".cheat cooldown on")
	bot.FlushWorld(t)
	self := bot.World.CharGUID()
	waitGlyph := func() {
		t.Helper()
		timer := time.NewTimer(3 * time.Second)
		defer timer.Stop()
		ticker := time.NewTicker(40 * time.Millisecond)
		defer ticker.Stop()
		for !bot.HasAura(glyphBuff) {
			select {
			case <-timer.C:
				e2eharness.ConfirmedBugf(t, 27279, "Life Tap cast did not apply glyph buff 63321")
			case <-ticker.C:
			}
		}
	}
	// Establish the normal glyph path before testing blocked mana restoration.
	bot.CastMust(t, lifeTap, self, 10*time.Second)
	waitGlyph()
	bot.CancelAura(t, glyphBuff)
	bot.WaitAuraGone(t, glyphBuff, 3*time.Second)

	bot.ApplyAura(t, despair)
	// Spend mana after Despair disables regeneration, so a full mana bar cannot
	// conceal a broken immunity. Demon Skin does not belong to the glyph mask.
	bot.CastMust(t, demonSkin, self, 10*time.Second)
	bot.WaitUnitAura(t, self, demonSkin, 3*time.Second)
	bot.FlushWorld(t)
	before, maximum := bot.PlayerPower()
	if maximum == 0 || before >= maximum || bot.HasAura(glyphBuff) || !bot.HasAura(despair) {
		e2eharness.Preconditionf(t, "need Despair, missing mana and no old glyph buff (mana=%d/%d)", before, maximum)
	}
	bot.CastMust(t, lifeTap, self, 10*time.Second)
	waitGlyph()
	bot.FlushWorld(t)
	after, _ := bot.PlayerPower()
	if !bot.HasAura(despair) {
		e2eharness.Preconditionf(t, "Aura of Despair disappeared before the assertion")
	}
	if after != before {
		e2eharness.ConfirmedBugf(t, 27279, "Life Tap changed mana under Despair: %d -> %d", before, after)
	}
	bot.AssertWorldAlive(t)
	t.Logf("PASS glyph 63321 procs normally and under Despair; blocked mana remains %d", after)
}
