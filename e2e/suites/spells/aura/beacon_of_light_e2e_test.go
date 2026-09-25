//go:build e2e

package aura_test

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"math"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	spellBeaconOfLight          = uint32(53563)
	spellLightsBeacon           = uint32(53651)
	spellBeaconHolyLight        = uint32(53652)
	spellBeaconFlashOfLight     = uint32(53653)
	spellBeaconHolyShock        = uint32(53654)
	spellHolyLight              = uint32(48782)
	spellFlashOfLight           = uint32(48785)
	spellHolyShock              = uint32(48825)
	spellHolyShockHealing       = uint32(48821)
	spellLayOnHands             = uint32(48788)
	spellDevotionAura           = uint32(48942)
	spellImprovedDevotionAura   = uint32(20140)
	spellImprovedDevotionEffect = uint32(63514)

	smsgSpellHealLog = uint16(0x0150)
	healingBonusPct  = uint32(6)
	testMaxHealth    = uint32(200_000)

	// Distances from the Beacon target, who casts Devotion Aura and owns Light's Beacon.
	healerDistance    = float32(25)
	recipientDistance = float32(51)
)

type spellHealLog struct {
	Target   uint64
	Caster   uint64
	SpellID  uint32
	Heal     uint32
	Overheal uint32
}

type beaconHealCase struct {
	name            string
	castSpell       uint32
	sourceHealSpell uint32
	beaconHealSpell uint32
}

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27756
//
// Improved Devotion Aura gives grouped targets 6% more healing received. Beacon
// only copies heals on members of its target's party or raid (Light's Beacon is
// an area raid aura, 60 yd), so every bot is grouped. The recipient stands 51 yd
// from the Beacon target: past Improved Devotion's 40 yd party aura (43 with both
// combat reaches) but inside Light's Beacon, which supplies the target-without-
// bonus case. Healing the paladin supplies the both-targets-have-the-bonus case.
// Beacon must use its target's bonus exactly once for all four source heals.
func TestAC_27756_BeaconUsesTargetHealingBonusOnce(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "spells", "issue", "multi_bot"},
		Runtime:  "med",
		Issue:    27756,
		Category: "spells/aura",
	})

	bots := e2eharness.NewScenario(t, e2eharness.ScenarioOpts{
		Prefix: "Bcn277",
		Bots: []e2eharness.BotSpec{
			{Role: "healer", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80},
			{Role: "beacon", Race: e2eharness.RaceHuman, Class: e2eharness.ClassPaladin, Level: 80},
			{Role: "recipient", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80},
		},
	})
	healer := e2eharness.ByRole(t, bots, "healer")
	beacon := e2eharness.ByRole(t, bots, "beacon")
	recipient := e2eharness.ByRole(t, bots, "recipient")

	pad := e2eharness.PackagePad(t)
	e2eharness.FormPartyAtPad(t, pad, healer, beacon, recipient)
	defer e2eharness.DisbandParty(t, healer, beacon, recipient)

	// The Beacon target stays on the pad. The healer stands halfway to the recipient, in
	// range of both for every heal. The pad's floor is level for 70 yd along this line.
	diagonal := float32(math.Sqrt2 / 2)
	dirX, dirY := -diagonal, diagonal
	healer.Teleport(t, pad.X+dirX*healerDistance, pad.Y+dirY*healerDistance, pad.Z, pad.Map)
	recipient.Teleport(t, pad.X+dirX*recipientDistance, pad.Y+dirY*recipientDistance, pad.Z, pad.Map)

	for _, spellID := range []uint32{spellBeaconOfLight, spellHolyLight, spellFlashOfLight, spellHolyShock, spellLayOnHands} {
		healer.Learn(t, spellID)
	}
	beacon.Learn(t, spellImprovedDevotionAura)
	beacon.Learn(t, spellDevotionAura)

	for _, bot := range bots {
		e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{Power: true})
	}
	healer.GM(t, ".cheat cooldown on")
	healer.FlushWorld(t)

	beacon.CastMust(t, spellDevotionAura, 0, 10*time.Second)
	healer.WaitUnitAura(t, beacon.GUID, spellImprovedDevotionEffect, 10*time.Second)
	healer.WaitUnitAura(t, healer.GUID, spellImprovedDevotionEffect, 10*time.Second)
	if recipient.HasAura(spellImprovedDevotionEffect) {
		e2eharness.Preconditionf(t, "recipient %.0f yd away unexpectedly has Improved Devotion Aura effect %d",
			recipientDistance, spellImprovedDevotionEffect)
	}

	healLogs := make(chan spellHealLog, 64)
	cancelHealLogs := healer.World.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode != smsgSpellHealLog {
			return
		}
		if event, ok := parseSpellHealLog(data); ok {
			select {
			case healLogs <- event:
			default:
			}
		}
	})
	defer cancelHealLogs()

	cases := []beaconHealCase{
		{name: "Holy Light", castSpell: spellHolyLight, sourceHealSpell: spellHolyLight, beaconHealSpell: spellBeaconHolyLight},
		{name: "Flash of Light", castSpell: spellFlashOfLight, sourceHealSpell: spellFlashOfLight, beaconHealSpell: spellBeaconFlashOfLight},
		{name: "Holy Shock", castSpell: spellHolyShock, sourceHealSpell: spellHolyShockHealing, beaconHealSpell: spellBeaconHolyShock},
		{name: "Lay on Hands", castSpell: spellLayOnHands, sourceHealSpell: spellLayOnHands, beaconHealSpell: spellBeaconHolyShock},
	}

	matrices := []struct {
		name              string
		source            *e2eharness.ScenarioBot
		wantBeaconHealing func(uint32) uint32
	}{
		{
			name:   "Beacon target bonus only",
			source: recipient,
			wantBeaconHealing: func(sourceHeal uint32) uint32 {
				return sourceHeal + sourceHeal*healingBonusPct/100
			},
		},
		{
			name:   "Both targets have the bonus",
			source: healer,
			wantBeaconHealing: func(sourceHeal uint32) uint32 {
				return sourceHeal
			},
		},
	}

	for _, matrix := range matrices {
		t.Run(matrix.name, func(t *testing.T) {
			wantSourceBonus := matrix.source == healer
			if got := matrix.source.HasAura(spellImprovedDevotionEffect); got != wantSourceBonus {
				e2eharness.Preconditionf(t, "%s Improved Devotion Aura effect=%v, want %v", matrix.source.Name, got, wantSourceBonus)
			}

			for _, testCase := range cases {
				t.Run(testCase.name, func(t *testing.T) {
					prepareInjuredPlayer(t, matrix.source)
					prepareInjuredPlayer(t, beacon)
					drainHealLogs(healLogs)

					healer.CastMust(t, spellBeaconOfLight, beacon.GUID, 10*time.Second)
					healer.WaitUnitAura(t, beacon.GUID, spellBeaconOfLight, 10*time.Second)
					healer.WaitUnitAura(t, matrix.source.GUID, spellLightsBeacon, 10*time.Second)
					drainHealLogs(healLogs)

					healer.CastMust(t, testCase.castSpell, matrix.source.GUID, 10*time.Second)
					sourceLog, beaconLog := waitForBeaconHealPair(t, healLogs, matrix.source.GUID,
						testCase.sourceHealSpell, beacon.GUID, testCase.beaconHealSpell, 10*time.Second)
					if sourceLog.Heal == 0 || beaconLog.Heal == 0 {
						e2eharness.ConfirmedBugf(t, 27756, "%s produced zero healing source=%d Beacon=%d",
							testCase.name, sourceLog.Heal, beaconLog.Heal)
					}

					want := matrix.wantBeaconHealing(sourceLog.Heal)
					if !withinOne(beaconLog.Heal, want) {
						e2eharness.ConfirmedBugf(t, 27756,
							"%s: source healed %d but Beacon healed %d, want %d (source overheal=%d, Beacon overheal=%d)",
							testCase.name, sourceLog.Heal, beaconLog.Heal, want, sourceLog.Overheal, beaconLog.Overheal)
					}
					t.Logf("PASS %s source=%d Beacon=%d want=%d", testCase.name, sourceLog.Heal, beaconLog.Heal, want)
				})
			}
		})
	}
}

func prepareInjuredPlayer(t *testing.T, bot *e2eharness.ScenarioBot) {
	t.Helper()
	if err := bot.World.SetTarget(bot.GUID); err != nil {
		e2eharness.Preconditionf(t, "%s select self before health setup: %v", bot.Name, err)
	}
	bot.GM(t, fmt.Sprintf(".modify hp %d", testMaxHealth))
	bot.FlushWorld(t)
	waitForSelfHealth(t, bot, func(health, maxHealth uint32) bool {
		return health == testMaxHealth && maxHealth == testMaxHealth
	}, "full health after .modify hp")

	bot.Damage(t, bot.GUID, testMaxHealth/2)
	waitForSelfHealth(t, bot, func(health, maxHealth uint32) bool {
		return health > 0 && health < maxHealth
	}, "damage before healing")
}

func waitForSelfHealth(t *testing.T, bot *e2eharness.ScenarioBot, ready func(uint32, uint32) bool, state string) {
	t.Helper()
	deadline := time.Now().Add(10 * time.Second)
	for time.Now().Before(deadline) {
		health, maxHealth := bot.World.Health(), bot.World.MaxHealth()
		if ready(health, maxHealth) {
			return
		}
		time.Sleep(40 * time.Millisecond)
	}
	e2eharness.Preconditionf(t, "%s never reached %s (health=%d/%d)", bot.Name, state, bot.World.Health(), bot.World.MaxHealth())
}

func waitForBeaconHealPair(t *testing.T, logs <-chan spellHealLog, sourceTarget uint64, sourceSpell uint32,
	beaconTarget uint64, beaconSpell uint32, timeout time.Duration) (spellHealLog, spellHealLog) {
	t.Helper()
	deadline := time.NewTimer(timeout)
	defer deadline.Stop()

	var sourceLog, beaconLog spellHealLog
	for sourceLog.Heal == 0 || beaconLog.Heal == 0 {
		select {
		case event := <-logs:
			switch {
			case event.Target == sourceTarget && event.SpellID == sourceSpell:
				sourceLog = event
			case event.Target == beaconTarget && event.SpellID == beaconSpell:
				beaconLog = event
			}
		case <-deadline.C:
			e2eharness.ConfirmedBugf(t, 27756,
				"missing heal logs source(target=0x%X spell=%d heal=%d) Beacon(target=0x%X spell=%d heal=%d)",
				sourceTarget, sourceSpell, sourceLog.Heal, beaconTarget, beaconSpell, beaconLog.Heal)
		}
	}
	return sourceLog, beaconLog
}

func drainHealLogs(logs <-chan spellHealLog) {
	for {
		select {
		case <-logs:
		default:
			return
		}
	}
}

func parseSpellHealLog(data []byte) (spellHealLog, bool) {
	reader := bytes.NewReader(data)
	target, ok := readPackedGUID(reader)
	if !ok {
		return spellHealLog{}, false
	}
	caster, ok := readPackedGUID(reader)
	if !ok {
		return spellHealLog{}, false
	}

	event := spellHealLog{Target: target, Caster: caster}
	if binary.Read(reader, binary.LittleEndian, &event.SpellID) != nil ||
		binary.Read(reader, binary.LittleEndian, &event.Heal) != nil ||
		binary.Read(reader, binary.LittleEndian, &event.Overheal) != nil {
		return spellHealLog{}, false
	}
	return event, true
}

func readPackedGUID(reader *bytes.Reader) (uint64, bool) {
	mask, err := reader.ReadByte()
	if err != nil {
		return 0, false
	}

	var guid uint64
	for index := uint(0); index < 8; index++ {
		if mask&(1<<index) == 0 {
			continue
		}
		value, err := reader.ReadByte()
		if err != nil {
			return 0, false
		}
		guid |= uint64(value) << (index * 8)
	}
	return guid, true
}

func withinOne(got, want uint32) bool {
	if got > want {
		return got-want <= 1
	}
	return want-got <= 1
}
