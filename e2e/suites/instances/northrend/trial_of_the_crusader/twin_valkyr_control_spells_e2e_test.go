//go:build e2e

package trial_of_the_crusader_test

import (
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	spellHittinYa               = uint32(66073)
	spellAuraStateVulnerable    = uint32(68402)
	spellAuraStateRaidEncounter = uint32(68403)
	spellSpecial2DummyCooldown  = uint32(66061)

	// UNIT_FIELD_AURASTATE (OBJECT_END + 0x37); aura state n is bit n-1.
	unitFieldAuraState        = uint16(0x3D)
	auraStateVulnerableBit    = uint32(1) << (19 - 1)
	auraStateRaidEncounterBit = uint32(1) << (22 - 1)

	// Uber Spell Controller ticks every 45s; the special starts on the AI update after the tick.
	specialPeriod = 45 * time.Second
	specialSlack  = 1500 * time.Millisecond
	// The other twin's 66061 is cast in the same AI update as the vortex start.
	specialCooldownWindow = time.Second
)

// Uber Spell Controller on every difficulty (SpellDifficulty 470).
var uberSpellController = []uint32{66829, 67315, 67316, 67317}

// Vortex and Twin's Pact on every difficulty, true for a vortex (SpellDifficulty 390, 402, 466, 467).
var valkyrSpecials = map[uint32]bool{
	66046: true, 67206: true, 67207: true, 67208: true, // Light Vortex
	66058: true, 67182: true, 67183: true, 67184: true, // Dark Vortex
	65875: false, 67303: false, 67304: false, 67305: false, // Twin's Pact, Eydis
	65876: false, 67306: false, 67307: false, 67308: false, // Twin's Pact, Fjola
}

type valkyrCast struct {
	at     time.Time
	isGo   bool
	caster uint64
	spell  uint32
}

// waitAuraState waits until the unit's UNIT_FIELD_AURASTATE has the bit and returns the field.
func waitAuraState(bot *e2eharness.ScenarioBot, guid uint64, bit uint32, timeout time.Duration) uint32 {
	var field uint32
	for deadline := time.Now().Add(timeout); time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
		if o := bot.World.GetObject(guid); o != nil {
			field = o.Value(unitFieldAuraState)
			if field&bit != 0 {
				return field
			}
		}
	}
	return field
}

// waitUnitAuraAny waits until the unit carries one of the spells and returns when it was first seen.
func waitUnitAuraAny(bot *e2eharness.ScenarioBot, guid uint64, spells []uint32, timeout time.Duration) time.Time {
	for deadline := time.Now().Add(timeout); time.Now().Before(deadline); time.Sleep(50 * time.Millisecond) {
		for _, s := range spells {
			if bot.UnitHasAura(guid, s) {
				return time.Now()
			}
		}
	}
	return time.Time{}
}

// PR: https://github.com/azerothcore/azerothcore-wotlk/pull/28539
//
// Fjola Lightbane and Eydis Darkbane carry their encounter's control spells:
//   - Val'kyr Twins Hittin' Ya (66073), cast by both once they spawn, marks whoever they melee.
//   - Uber Spell Controller (66829 and its difficulty variants), cast by Fjola on engage. Each 45s tick
//     starts the next vortex or Twin's Pact.
//   - Aura State Raid Encounter (68403) on Fjola and Aura State Vulnerable (68402) on Eydis, cast on
//     engage, raise aura states 22 and 19.
//   - Creature Special 2 Dummy Cooldown (66061), cast by the twin not casting a vortex as it starts,
//     never on a pact. Its category cooldown locks that twin's Touch of Light/Darkness, which stays
//     server-side and is not asserted.
//
// Temp twins stay REACT_PASSIVE (only the encounter intro makes them aggressive), so they never melee
// and the 66072 mark is not asserted.
//
// Drive: temp twins are spawned on the bot and pulled with `.damage`; the bot stays in god mode until
// it has seen both a vortex and a pact (at most three specials).
// Oracle: a Hittin' Ya SMSG_SPELL_GO from each twin after it spawns and the aura on both before the
// pull; SMSG_SPELL_GO and the aura for the controller and 68403 (with aura state 22) from Fjola and
// for 68402 (with aura state 19) from Eydis after the pull, none of the auras before; every special
// starting a whole number of 45s periods after the controller cast; a 66061 SMSG_SPELL_GO from the
// other twin alone within 1s of each vortex start, and from neither twin around a pact.
func TestToC_TwinValkyrControlSpells(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"long", "instances"},
		Runtime:  "long",
		Category: "instances/northrend/trial_of_the_crusader",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "VlkCtl", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})

	// Stay GM through the raid enter (.go xyz onto a raid map is ignored after .gm off).
	bot.Teleport(t, centerX, centerY, centerZ, mapTrialOfTheCrusader)
	if _, _, _, m := bot.Pos(); m != mapTrialOfTheCrusader {
		e2eharness.Preconditionf(t, "bot not in Trial of the Crusader after tele map=%d", m)
	}
	bot.WaitUnit(t, npcTirion, 20*time.Second)

	// Hooked before the spawn to catch the spawn-time Hittin' Ya casts.
	var mu sync.Mutex
	var casts []valkyrCast
	unhook := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != client.SmsgSpellStart && opcode != client.SmsgSpellGo {
			return
		}
		caster, spell, ok := spellGoCaster(data)
		if entry := guidEntry(caster); !ok || (entry != npcFjola && entry != npcEydis) {
			return
		}
		mu.Lock()
		casts = append(casts, valkyrCast{time.Now(), opcode == client.SmsgSpellGo, caster, spell})
		mu.Unlock()
	})
	t.Cleanup(unhook)
	// goAt returns when the caster's SMSG_SPELL_GO of a matching spell arrived, zero if it never did.
	goAt := func(caster uint64, match func(uint32) bool, timeout time.Duration) time.Time {
		for deadline := time.Now().Add(timeout); ; time.Sleep(50 * time.Millisecond) {
			mu.Lock()
			for _, c := range casts {
				if c.isGo && c.caster == caster && match(c.spell) {
					mu.Unlock()
					return c.at
				}
			}
			mu.Unlock()
			if time.Now().After(deadline) {
				return time.Time{}
			}
		}
	}
	is := func(id uint32) func(uint32) bool { return func(s uint32) bool { return s == id } }
	isController := func(s uint32) bool {
		for _, id := range uberSpellController {
			if s == id {
				return true
			}
		}
		return false
	}

	fjola := spawnTemp(t, bot, npcFjola)
	eydis := spawnTemp(t, bot, npcEydis)
	names := map[uint64]string{fjola: "Fjola", eydis: "Eydis"}
	t.Logf("Fjola guid=0x%X Eydis guid=0x%X", fjola, eydis)

	for _, guid := range []uint64{fjola, eydis} {
		if goAt(guid, is(spellHittinYa), 5*time.Second).IsZero() {
			e2eharness.Assertf(t, "%s 0x%X sent no SMSG_SPELL_GO for Val'kyr Twins Hittin' Ya (%d) after spawning", names[guid], guid, spellHittinYa)
		}
		if waitUnitAuraAny(bot, guid, []uint32{spellHittinYa}, 5*time.Second).IsZero() {
			e2eharness.Assertf(t, "%s 0x%X has no Val'kyr Twins Hittin' Ya (%d) after spawning", names[guid], guid, spellHittinYa)
		}
	}
	for _, c := range []struct {
		guid   uint64
		spells []uint32
	}{
		{fjola, append([]uint32{spellAuraStateRaidEncounter}, uberSpellController...)},
		{eydis, []uint32{spellAuraStateVulnerable}},
	} {
		for _, s := range c.spells {
			if bot.UnitHasAura(c.guid, s) {
				e2eharness.Assertf(t, "%s already carries %d before the pull; it belongs to engage", names[c.guid], s)
			}
		}
	}
	t.Logf("both twins cast Hittin' Ya (%d) after spawning and carry it, with no engage aura before the pull", spellHittinYa)

	// Out of GM mode so the twins engage the bot; god keeps it up through the specials and the orbs.
	e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{God: true})
	bot.Damage(t, fjola, 1)
	bot.WaitUnitCombat(t, fjola, 10*time.Second)
	bot.WaitUnitCombat(t, eydis, 10*time.Second)

	controllerAt := goAt(fjola, isController, 3*time.Second)
	if controllerAt.IsZero() {
		e2eharness.Assertf(t, "Fjola sent no SMSG_SPELL_GO for Uber Spell Controller (66829 or a difficulty variant) within %s of the pull", 3*time.Second)
	}
	if waitUnitAuraAny(bot, fjola, uberSpellController, 3*time.Second).IsZero() {
		e2eharness.Assertf(t, "Fjola has no Uber Spell Controller (66829 or a difficulty variant) within %s of the pull", 3*time.Second)
	}
	for _, c := range []struct {
		guid  uint64
		spell uint32
		bit   uint32
		state int
	}{
		{fjola, spellAuraStateRaidEncounter, auraStateRaidEncounterBit, 22},
		{eydis, spellAuraStateVulnerable, auraStateVulnerableBit, 19},
	} {
		if goAt(c.guid, is(c.spell), 3*time.Second).IsZero() {
			e2eharness.Assertf(t, "%s 0x%X sent no SMSG_SPELL_GO for %d on the pull", names[c.guid], c.guid, c.spell)
		}
		if waitUnitAuraAny(bot, c.guid, []uint32{c.spell}, 3*time.Second).IsZero() {
			e2eharness.Assertf(t, "%s 0x%X has no %d after the pull", names[c.guid], c.guid, c.spell)
		}
		if field := waitAuraState(bot, c.guid, c.bit, 3*time.Second); field&c.bit == 0 {
			e2eharness.Assertf(t, "%s carries %d but UNIT_FIELD_AURASTATE is 0x%X, without aura state %d", names[c.guid], c.spell, field, c.state)
		}
	}
	t.Logf("after the pull Fjola casts and carries Uber Spell Controller and %d with aura state 22, Eydis %d with aura state 19",
		spellAuraStateRaidEncounter, spellAuraStateVulnerable)

	type special struct {
		at     time.Time
		caster uint64
		spell  uint32
		vortex bool
	}
	collect := func() (specials []special, sawVortex, sawPact bool) {
		mu.Lock()
		defer mu.Unlock()
		for _, c := range casts {
			if vortex, ok := valkyrSpecials[c.spell]; ok && !c.isGo {
				specials = append(specials, special{c.at, c.caster, c.spell, vortex})
				sawVortex = sawVortex || vortex
				sawPact = sawPact || !vortex
			}
		}
		return specials, sawVortex, sawPact
	}

	// The rotation never repeats a special before all four ran, so three specials always include a
	// vortex and a pact.
	specialsTimeout := 3*specialPeriod + 10*time.Second
	specials, sawVortex, sawPact := collect()
	for deadline := controllerAt.Add(specialsTimeout); !(sawVortex && sawPact) && len(specials) < 3 && time.Now().Before(deadline); {
		time.Sleep(100 * time.Millisecond)
		specials, sawVortex, sawPact = collect()
	}
	if len(specials) == 0 {
		e2eharness.Assertf(t, "no vortex or Twin's Pact started within %s of the Uber Spell Controller cast", specialsTimeout)
	}
	// Let the other twin's 66061 arrive after the last special started.
	time.Sleep(specialCooldownWindow + time.Second)
	mu.Lock()
	snapshot := append([]valkyrCast(nil), casts...)
	mu.Unlock()
	for i, s := range specials {
		since := s.at.Sub(controllerAt)
		tick := time.Duration(int64((since+specialPeriod/2)/specialPeriod)) * specialPeriod
		if tick == 0 || since-tick > specialSlack || tick-since > specialSlack {
			e2eharness.Assertf(t, "special %d (%s cast %d) started %s after Uber Spell Controller, not on a 45s tick",
				i+1, names[s.caster], s.spell, since.Round(time.Millisecond))
		}

		var cooldownCasters []uint64
		for _, c := range snapshot {
			if d := c.at.Sub(s.at); c.isGo && c.spell == spellSpecial2DummyCooldown && d > -specialCooldownWindow && d < specialCooldownWindow {
				cooldownCasters = append(cooldownCasters, c.caster)
			}
		}
		other := fjola
		if s.caster == fjola {
			other = eydis
		}
		switch {
		case s.vortex && (len(cooldownCasters) != 1 || cooldownCasters[0] != other):
			e2eharness.Assertf(t, "vortex %d by %s at +%s: Creature Special 2 Dummy Cooldown (%d) came from %v; it must come from %s alone",
				s.spell, names[s.caster], since.Round(time.Millisecond), spellSpecial2DummyCooldown, cooldownCasters, names[other])
		case !s.vortex && len(cooldownCasters) != 0:
			e2eharness.Assertf(t, "Twin's Pact %d by %s at +%s came with Creature Special 2 Dummy Cooldown (%d) from %v; pacts lock no Touch",
				s.spell, names[s.caster], since.Round(time.Millisecond), spellSpecial2DummyCooldown, cooldownCasters)
		}
		t.Logf("special %d: %s cast %d at +%s (vortex=%v), 66061 from %d twin(s)",
			i+1, names[s.caster], s.spell, since.Round(time.Millisecond), s.vortex, len(cooldownCasters))
	}
	if !(sawVortex && sawPact) {
		e2eharness.Assertf(t, "%d specials gave vortex=%v pact=%v; the special rotation must show both within three", len(specials), sawVortex, sawPact)
	}

	// Killing them runs their death cleanup, which despawns the orbs Fjola summons once engaged.
	bot.DamageKill(t, []uint64{fjola, eydis}, 0, 15*time.Second)
	t.Logf("PASS the twins cast Hittin' Ya after spawning, the controller and aura-state spells on engage, start each special on a controller tick, and the other twin casts 66061 on every vortex only")
}
