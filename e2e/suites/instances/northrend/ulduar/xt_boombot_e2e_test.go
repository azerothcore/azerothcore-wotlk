//go:build e2e

package ulduar_test

import (
	"encoding/binary"
	"fmt"
	"math"
	"sync"
	"testing"
	"time"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	_ "github.com/go-sql-driver/mysql"
)

const (
	xtBoom              = uint32(62834)
	xtRechargeBoom      = uint32(62835)
	xtRechargeScrap     = uint32(62828)
	xtRechargePummeller = uint32(62831)
	xtRoot              = uint32(42716) // Self Root Forever (No Visual), fixture positioning only
)

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27699
// Use Recharge's real summons and their AI, not a GM cast of Boom. The encounter state is
// fixture setup: this does not test the heart phase or its add-spawn cadence.
// Boom must survive its own instakill long enough to damage nearby players and chain to adds.
func TestAC_27699_XTBoombotExplosion(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags: []string{"long", "instances", "issue"}, Runtime: "long",
		Issue: 27699, Category: "instances/northrend/ulduar",
	})
	for mode := uint32(0); mode <= 1; mode++ {
		t.Run(fmt.Sprintf("raid_%d", 10+15*mode), func(t *testing.T) {
			bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
				Prefix: "XtBoom", Race: e2eharness.RaceHuman, Class: e2eharness.ClassWarrior, Level: 80,
			})
			// MSG_SET_RAID_DIFFICULTY, before entering the instance. The Boombot health below
			// also checks that we actually entered the requested difficulty.
			payload := make([]byte, 4)
			binary.LittleEndian.PutUint32(payload, mode)
			if err := bot.World.SendPacketRaw(0x4EB, payload); err != nil {
				e2eharness.HarnessFailf(t, "set raid difficulty: %v", err)
			}
			bot.FlushWorld(t)
			bot.Teleport(t, 819.243, -10.9022, 409.804, e2eharness.MapUlduar)
			xt := bot.WaitUnit(t, 33293, 15*time.Second)
			bot.GM(t, ".instance setbossstate 3 1")
			bot.FlushWorld(t)
			t.Cleanup(func() {
				bot.CleanupOwnedSummons(t)
				bot.GM(t, ".instance setbossstate 3 0")
			})
			record := &xtBoomRecord{}
			cancel := bot.World.AddPacketHook(record.packet)
			defer cancel()
			prepare := func(t *testing.T) {
				t.Helper()
				xtSelect(t, bot, bot.World.CharGUID())
				bot.GM(t, ".modify hp 100000")
				bot.GM(t, ".cheat god off")
				e2eharness.CombatReady(t, bot.World, e2eharness.CombatReadyOpts{})
				if !xtPoll(5*time.Second, func() bool {
					hp, maxHP := bot.UnitHP(bot.World.CharGUID())
					return hp == 100000 && maxHP == 100000
				}) {
					hp, maxHP := bot.UnitHP(bot.World.CharGUID())
					e2eharness.Preconditionf(t, "damage recipient health=%d/%d, want 100000", hp, maxHP)
				}
			}
			spawn := func(t *testing.T, gather bool) uint64 {
				t.Helper()
				guid := xtSpawn(t, bot, xtRechargeBoom, 33346, gather)
				_, maxHP := bot.UnitHP(guid)
				want := uint32(12600)
				if mode == 1 {
					want = 50400
				}
				if maxHP != want {
					e2eharness.Preconditionf(t, "Boombot health=%d, want %d for difficulty %d", maxHP, want, mode)
				}
				return guid
			}

			if !t.Run("nonlethal_then_lethal", func(t *testing.T) {
				guid := spawn(t, true)
				prepare(t)
				hp, _ := bot.UnitHP(guid)
				bot.Damage(t, guid, hp*3/5)
				bot.FlushWorld(t)
				if !xtPoll(5*time.Second, func() bool {
					left, _ := bot.UnitHP(guid)
					return left < hp || record.casts(guid, xtBoom) > 0
				}) {
					e2eharness.Preconditionf(t, "nonlethal hit did not lower Boombot health")
				}
				// Cross the old 50% threshold without killing it. Watch past a proximity tick.
				xtObserve(t, 2*time.Second, func() {
					left, _ := bot.UnitHP(guid)
					if left == 0 || left > hp/2 || record.casts(guid, xtBoom) != 0 {
						e2eharness.ConfirmedBugf(t, 27699, "nonlethal hit: hp=%d, Boom casts=%d", left, record.casts(guid, xtBoom))
					}
				})
				left, _ := bot.UnitHP(guid)
				bot.Damage(t, guid, left) // one hit, never retry a failed detonation
				xtRequireDeath(t, bot, record, guid, 5*time.Second)
				xtRequirePlayerDamage(t, bot, record, guid)
			}) {
				return
			}

			if !t.Run("chain_and_scrapbot_credit", func(t *testing.T) {
				first := spawn(t, true)
				second := spawn(t, true)
				scrap := xtSpawn(t, bot, xtRechargeScrap, 33343, true)
				prepare(t)
				// A 25-player Boombot has more health than one Boom. Lower it with a real
				// nonlethal hit so the next explosion, not the fixture, triggers the chain.
				hp, _ := bot.UnitHP(second)
				bot.Damage(t, second, hp-1000)
				bot.FlushWorld(t)
				if !xtPoll(5*time.Second, func() bool {
					left, _ := bot.UnitHP(second)
					return left < hp || record.casts(second, xtBoom) > 0
				}) {
					e2eharness.Preconditionf(t, "nonlethal hit did not lower the secondary Boombot's health")
				}
				if left, _ := bot.UnitHP(second); left == 0 || left > 1000 || record.casts(second, xtBoom) != 0 {
					e2eharness.ConfirmedBugf(t, 27699, "secondary Boombot exploded on nonlethal setup damage")
				}
				hp, _ = bot.UnitHP(first)
				bot.Damage(t, first, hp)
				xtRequireChainDeath(t, bot, record, first, second)
				xtRequireChainDeath(t, bot, record, second, first)
				if !xtPoll(5*time.Second, func() bool {
					damage, hit := record.hit(first, second)
					scrapHP, _ := bot.UnitHP(scrap)
					_, scrapHit := record.hit(first, scrap)
					_, chainScrapHit := record.hit(second, scrap)
					return hit && damage.damage > 0 && scrapHP == 0 && (scrapHit || chainScrapHit) &&
						record.casts(bot.World.CharGUID(), 65037) > 0
				}) {
					e2eharness.ConfirmedBugf(t, 27699, "missing Boom chain, Scrapbot kill, or 65037 achievement-credit cast")
				}
				xtRequirePlayerDamage(t, bot, record, first)
				xtRequirePlayerDamage(t, bot, record, second)
			}) {
				return
			}

			if !t.Run("robot_damage", func(t *testing.T) {
				// Wowhead recommends killing Boombots to damage the surrounding robots.
				// https://www.wowhead.com/wotlk/guide/raids/ulduar/xt-002-deconstructor-strategy
				// Isolate each recipient type so a second Boom cannot mask a missing hit.
				for _, tc := range []struct {
					name         string
					spell, entry uint32
					count        int
					wantDead     bool
				}{
					{"scrapbot_wave", xtRechargeScrap, 33343, 3, true},
					{"pummeller", xtRechargePummeller, 33344, 1, false},
				} {
					if !t.Run(tc.name, func(t *testing.T) {
						prepare(t)
						// Only the player gets god mode, to survive Pummeller attacks during
						// setup. Leave the NPC recipients' health, faction and defenses unchanged.
						bot.CheatGod(t)
						bot.FlushWorld(t)
						t.Cleanup(func() {
							bot.CleanupOwnedSummons(t)
							xtSelect(t, bot, bot.World.CharGUID())
							bot.CombatStop(t)
							bot.GM(t, ".cheat god off")
							bot.FlushWorld(t)
						})
						bomb := spawn(t, true)
						var nearby []uint64
						for i := 0; i < tc.count; i++ {
							nearby = append(nearby, xtSpawn(t, bot, tc.spell, tc.entry, true))
						}
						bot.Teleport(t, 794.243, -10.9022, 409.804, e2eharness.MapUlduar)
						outside := xtSpawn(t, bot, tc.spell, tc.entry, true)
						bot.Teleport(t, 819.243, -10.9022, 409.804, e2eharness.MapUlduar)
						if !tc.wantDead {
							// Tank the Pummeller with a nondamaging Warrior Taunt. Otherwise its
							// only opponent could be the dying Boombot, allowing an immediate evade/heal.
							for _, guid := range nearby {
								xtSelect(t, bot, guid)
								bot.GM(t, ".cast 355 triggered")
								if !xtPoll(5*time.Second, func() bool { return e2eharness.UnitInCombat(bot.World, guid) }) {
									e2eharness.Preconditionf(t, "Pummeller did not enter combat after Taunt")
								}
							}
						}
						targets := append(append([]uint64{}, nearby...), outside)
						before := make(map[uint64]uint32)
						// Reacquire every GUID after teleport, including the untouched control.
						if !xtPoll(5*time.Second, func() bool {
							source := bot.World.GetObject(bomb)
							if source == nil || source.Health() == 0 || !bot.UnitHasAura(bomb, xtRoot) {
								return false
							}
							for _, guid := range targets {
								target := bot.World.GetObject(guid)
								if target == nil || target.Health() == 0 || !bot.UnitHasAura(guid, xtRoot) {
									return false
								}
								distance := e2eharness.Distance3D(source.PosX, source.PosY, 0, target.PosX, target.PosY, 0)
								if math.Abs(float64(source.PosZ-target.PosZ)) > 0.5 ||
									(guid == outside && (distance < 20 || distance > 30)) ||
									(guid != outside && distance > 5) || target.Health() != target.MaxHealth() {
									return false
								}
								before[guid] = target.Health()
							}
							return true
						}) {
							e2eharness.Preconditionf(t, "robot recipients not full-health and rooted inside/outside Boom range")
						}
						creditBefore := record.casts(bot.World.CharGUID(), 65037)
						hp, _ := bot.UnitHP(bomb)
						bot.Damage(t, bomb, hp) // do not damage any recipient directly
						for _, guid := range nearby {
							var hit xtBoomHit
							var remaining uint32
							if !xtPoll(5*time.Second, func() bool {
								var ok bool
								if hit, ok = record.hit(bomb, guid); !ok || hit.damage == 0 || hit.school != 4 {
									return false
								}
								remaining, _ = bot.UnitHP(guid)
								if tc.wantDead {
									return remaining == 0 && hit.damage >= before[guid]
								}
								return remaining > 0 && remaining < before[guid] &&
									before[guid]-remaining == hit.damage
							}) {
								e2eharness.ConfirmedBugf(t, 27699,
									"Boom from %x did not correctly damage %s %x: HP %d -> %d, damage=%d school=%d",
									bomb, tc.name, guid, before[guid], remaining, hit.damage, hit.school)
							}
							t.Logf("PASS Boom %x -> %s %x: Fire damage=%d, HP %d -> %d",
								bomb, tc.name, guid, hit.damage, before[guid], remaining)
						}
						xtRequireDeath(t, bot, record, bomb, 5*time.Second)
						xtObserve(t, 2*time.Second, func() {
							controlHP, _ := bot.UnitHP(outside)
							if _, hit := record.hit(bomb, outside); hit || controlHP != before[outside] {
								e2eharness.ConfirmedBugf(t, 27699, "outside %s %x was hit or lost health", tc.name, outside)
							}
							if tc.wantDead && record.casts(bot.World.CharGUID(), 65037)-creditBefore != tc.count {
								e2eharness.ConfirmedBugf(t, 27699, "Scrapbot wave did not grant exactly %d kill-credit casts", tc.count)
							}
						})
					}) {
						return
					}
				}
			}) {
				return
			}

			if !t.Run("range", func(t *testing.T) {
				// Boom (62834), radius 13 = 10 yards. Its destination-area entry selector
				// checks center-to-center 2D distance, not the size-adjusted .distance value.
				// https://www.wowhead.com/wotlk/spell=62834/boom
				// Keep both actors on the same floor and avoid the exact floating-point edge.
				for _, tc := range []struct {
					distance float32
					wantHit  bool
				}{
					{5, true},
					{9.5, true},
					{10.5, false},
					{15, false},
					{25, false},
				} {
					if !t.Run(fmt.Sprintf("%.1f_yards", tc.distance), func(t *testing.T) {
						guid := spawn(t, true)
						add := bot.World.GetObject(guid)
						if add == nil {
							e2eharness.Preconditionf(t, "Boombot disappeared before range setup")
						}
						// The root can stop the gathered add just short of the player. Anchor
						// to its observed position, not the fixture's nominal teleport point.
						bot.Teleport(t, add.PosX-tc.distance, add.PosY, add.PosZ, e2eharness.MapUlduar)
						var measured float32
						positioned := func() bool {
							add := bot.World.GetObject(guid)
							if add == nil || add.Health() == 0 || !bot.UnitHasAura(guid, xtRoot) {
								return false
							}
							x, y, z, mapID := bot.Pos()
							measured = e2eharness.Distance3D(x, y, 0, add.PosX, add.PosY, 0)
							return mapID == e2eharness.MapUlduar &&
								math.Abs(float64(z-add.PosZ)) <= 0.1 &&
								math.Abs(float64(measured-tc.distance)) <= 0.1
						}
						// Teleport clears the cache; wait for the same rooted GUID and its pose.
						if !xtPoll(5*time.Second, positioned) {
							e2eharness.Preconditionf(t, "range setup: want %.1f yards, observed %.3f", tc.distance, measured)
						}
						prepare(t)
						if !positioned() {
							e2eharness.Preconditionf(t, "actors moved before range detonation: %.3f yards", measured)
						}
						t.Logf("Boombot %x: measured %.3f yards, expect hit=%t", guid, measured, tc.wantHit)
						hp, _ := bot.UnitHP(guid)
						bot.Damage(t, guid, hp*2) // retain the overkill regression case
						xtRequireDeath(t, bot, record, guid, 5*time.Second)
						if tc.wantHit {
							xtRequirePlayerDamage(t, bot, record, guid)
						} else {
							// Require a real explosion above before accepting the absence of damage.
							xtObserve(t, 2*time.Second, func() {
								if _, hit := record.hit(guid, bot.World.CharGUID()); hit {
									e2eharness.ConfirmedBugf(t, 27699, "Boom hit outside 10 yards at %.3f yards", measured)
								}
							})
						}
						t.Logf("PASS Boom range: %.3f yards, hit=%t", measured, tc.wantHit)
						bot.Teleport(t, 819.243, -10.9022, 409.804, e2eharness.MapUlduar)
					}) {
						return
					}
				}
			}) {
				return
			}

			t.Run("reach_xt_without_damage", func(t *testing.T) {
				// No root, forced movement, or hit: the native follow/proximity timers must
				// get this one to XT and detonate it. Keep this last in case XT enters combat.
				prepare(t)
				guid := spawn(t, false)
				atXT := false
				if !xtPoll(60*time.Second, func() bool {
					add, boss := bot.World.GetObject(guid), bot.World.GetObject(xt)
					if add != nil && boss != nil {
						dx, dy, dz := add.PosX-boss.PosX, add.PosY-boss.PosY, add.PosZ-boss.PosZ
						// XT's combat reach is much larger than a player's. This checks arrival
						// at the boss, not an exact melee-range boundary or a timer duration.
						atXT = atXT || dx*dx+dy*dy+dz*dz < 20*20
						if add.Health() != 0 && add.Health() != add.MaxHealth() {
							e2eharness.Preconditionf(t, "proximity Boombot took unrelated damage before detonation")
						}
					}
					return record.instakills(guid) > 0
				}) || !atXT {
					e2eharness.ConfirmedBugf(t, 27699, "undamaged Boombot did not reach XT and self-destruct")
				}
				xtRequireDeath(t, bot, record, guid, 5*time.Second)
			})
		})
	}
}

func xtSelect(t *testing.T, bot *e2eharness.ScenarioBot, guid uint64) {
	t.Helper()
	if err := bot.World.SetTarget(guid); err != nil {
		e2eharness.HarnessFailf(t, "select %x: %v", guid, err)
	}
}

func xtSpawn(t *testing.T, bot *e2eharness.ScenarioBot, spell, entry uint32, gather bool) uint64 {
	t.Helper()
	known := make(map[uint64]bool)
	for _, unit := range bot.UnitsByEntry(0, entry) {
		known[unit.GUID] = true
	}
	bot.CastSelfGM(t, spell)
	var guid uint64
	if !xtPoll(10*time.Second, func() bool {
		for _, unit := range bot.UnitsByEntry(0, entry) {
			if !known[unit.GUID] {
				guid = unit.GUID
				return true
			}
		}
		return false
	}) {
		e2eharness.Preconditionf(t, "Recharge %d did not produce NPC %d", spell, entry)
	}
	if !gather {
		return guid
	}
	xtSelect(t, bot, guid)
	bot.GM(t, fmt.Sprintf(".aura %d", xtRoot))
	bot.WaitUnitAura(t, guid, xtRoot, 5*time.Second)
	// Recharge has a random 15-yard destination. Hold the add through its initial
	// follow timer (4s for Boombots, 2s for Scrapbots), then gather it for the AoE cases.
	xtObserve(t, 5*time.Second, func() {
		if hp, _ := bot.UnitHP(guid); hp == 0 || !bot.UnitHasAura(guid, xtRoot) {
			e2eharness.Preconditionf(t, "add %x died or lost its fixture root", guid)
		}
	})
	bot.GM(t, fmt.Sprintf(".unaura %d", xtRoot))
	bot.GM(t, ".cometome")
	bot.FlushWorld(t)
	x, y, z, _ := bot.Pos()
	if !xtPoll(15*time.Second, func() bool {
		obj := bot.World.GetObject(guid)
		if obj == nil {
			return false
		}
		dx, dy, dz := obj.PosX-x, obj.PosY-y, obj.PosZ-z
		return dx*dx+dy*dy+dz*dz < 1
	}) {
		e2eharness.Preconditionf(t, "add %x did not reach the AoE fixture position", guid)
	}
	bot.GM(t, fmt.Sprintf(".aura %d", xtRoot))
	bot.WaitUnitAura(t, guid, xtRoot, 5*time.Second)
	return guid
}

func xtPoll(timeout time.Duration, ready func() bool) bool {
	deadline := time.Now().Add(timeout)
	for {
		if ready() {
			return true
		}
		if !time.Now().Before(deadline) {
			return false
		}
		time.Sleep(50 * time.Millisecond)
	}
}

func xtObserve(t *testing.T, duration time.Duration, check func()) {
	t.Helper()
	deadline := time.Now().Add(duration)
	for {
		check()
		if !time.Now().Before(deadline) {
			return
		}
		time.Sleep(50 * time.Millisecond)
	}
}

func xtRequireDeath(t *testing.T, bot *e2eharness.ScenarioBot, record *xtBoomRecord, guid uint64, timeout time.Duration) {
	t.Helper()
	if !xtPoll(timeout, func() bool {
		hp, _ := bot.UnitHP(guid)
		return record.instakills(guid) == 1 && hp == 0
	}) {
		e2eharness.ConfirmedBugf(t, 27699, "Boombot %x did not die through Boom's self-instakill", guid)
	}
	// Removal alone isn't death evidence. Require its self-instakill packet and exactly
	// one cast, including after another proximity tick could have run.
	xtObserve(t, 2*time.Second, func() {
		if record.casts(guid, xtBoom) != 1 || record.instakills(guid) != 1 {
			e2eharness.ConfirmedBugf(t, 27699, "Boombot %x exploded more or less than once", guid)
		}
	})
}

func xtRequireChainDeath(t *testing.T, bot *e2eharness.ScenarioBot, record *xtBoomRecord, guid, other uint64) {
	t.Helper()
	// The other explosion can kill this bot before its own self-instakill is processed.
	// Without an instakill packet, require a populated dead unit and the other bot's hit.
	// A missing cache entry alone is not death evidence.
	if !xtPoll(5*time.Second, func() bool {
		if record.casts(guid, xtBoom) != 1 {
			return false
		}
		if record.instakills(guid) == 1 {
			hp, _ := bot.UnitHP(guid)
			return hp == 0
		}
		unit := bot.World.GetObject(guid)
		hit, ok := record.hit(other, guid)
		return unit != nil && unit.MaxHealth() > 0 && unit.Health() == 0 &&
			ok && hit.damage > 0 && hit.school == 4
	}) {
		e2eharness.ConfirmedBugf(t, 27699, "chain Boombot %x did not explode once and die", guid)
	}
	xtObserve(t, 2*time.Second, func() {
		if record.casts(guid, xtBoom) != 1 || record.instakills(guid) > 1 {
			e2eharness.ConfirmedBugf(t, 27699, "chain Boombot %x exploded or self-killed more than once", guid)
		}
	})
	t.Logf("PASS chain Boombot %x: one explosion and confirmed death, self-instakills=%d", guid, record.instakills(guid))
}

func xtRequirePlayerDamage(t *testing.T, bot *e2eharness.ScenarioBot, record *xtBoomRecord, guid uint64) {
	t.Helper()
	var hit xtBoomHit
	if !xtPoll(5*time.Second, func() bool {
		var ok bool
		hit, ok = record.hit(guid, bot.World.CharGUID())
		return ok
	}) {
		e2eharness.ConfirmedBugf(t, 27699, "Boombot %x did no damage to the nearby player", guid)
	}
	// This protects AC's existing estimated 15-18k weapon range, not a claim of an
	// exact retail number. Boom applies 95-105%; restore mitigation, then undo crits.
	raw := float64(hit.damage) + float64(hit.absorb) + float64(hit.resist) + float64(hit.blocked)
	if hit.flags&2 != 0 {
		raw /= 2
	}
	if hit.damage == 0 || hit.school != 4 || raw < 14248 || raw > 18902 {
		e2eharness.ConfirmedBugf(t, 27699, "Boom damage=%d school=%d unmitigated noncrit=%g", hit.damage, hit.school, raw)
	}
	t.Logf("PASS Boombot %x: one native detonation, Fire damage=%d (normalized %.0f)", guid, hit.damage, raw)
}

type xtBoomHit struct {
	caster, target                         uint64
	damage, absorb, resist, blocked, flags uint32
	school                                 byte
}

type xtBoomCast struct {
	caster uint64
	spell  uint32
}

type xtBoomRecord struct {
	mu    sync.Mutex
	goes  []xtBoomCast
	kills []uint64
	hits  []xtBoomHit
}

func (r *xtBoomRecord) packet(opcode uint16, data []byte) {
	r.mu.Lock()
	defer r.mu.Unlock()
	switch opcode {
	case client.SmsgSpellGo:
		spell, ok := castSpellID(data)
		if !ok || (spell != xtBoom && spell != 65037) {
			return
		}
		_, off := readPackedGUID(data, 0)
		caster, _ := readPackedGUID(data, off)
		r.goes = append(r.goes, xtBoomCast{caster, spell})
	case 0x032F: // SMSG_SPELLINSTAKILLLOG: unpacked caster, target, spell
		if len(data) >= 20 && binary.LittleEndian.Uint32(data[16:]) == xtBoom {
			caster, target := binary.LittleEndian.Uint64(data), binary.LittleEndian.Uint64(data[8:])
			if caster == target {
				r.kills = append(r.kills, caster)
			}
		}
	case 0x0250: // SMSG_SPELLNONMELEEDAMAGELOG: packed target, caster, then damage details
		target, off := readPackedGUID(data, 0)
		caster, off := readPackedGUID(data, off)
		if off+32 > len(data) || binary.LittleEndian.Uint32(data[off:]) != xtBoom {
			return
		}
		p := data[off:]
		r.hits = append(r.hits, xtBoomHit{
			caster: caster, target: target, damage: binary.LittleEndian.Uint32(p[4:]), school: p[12],
			absorb: binary.LittleEndian.Uint32(p[13:]), resist: binary.LittleEndian.Uint32(p[17:]),
			blocked: binary.LittleEndian.Uint32(p[23:]), flags: binary.LittleEndian.Uint32(p[27:]),
		})
	}
}

func (r *xtBoomRecord) casts(guid uint64, spell uint32) int {
	r.mu.Lock()
	defer r.mu.Unlock()
	n := 0
	for _, cast := range r.goes {
		if cast.caster == guid && cast.spell == spell {
			n++
		}
	}
	return n
}

func (r *xtBoomRecord) instakills(guid uint64) int {
	r.mu.Lock()
	defer r.mu.Unlock()
	n := 0
	for _, killed := range r.kills {
		if killed == guid {
			n++
		}
	}
	return n
}

func (r *xtBoomRecord) hit(caster, target uint64) (xtBoomHit, bool) {
	r.mu.Lock()
	defer r.mu.Unlock()
	for _, hit := range r.hits {
		if hit.caster == caster && hit.target == target {
			return hit, true
		}
	}
	return xtBoomHit{}, false
}
