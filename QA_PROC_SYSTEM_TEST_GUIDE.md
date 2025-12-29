# QAston Proc System - Comprehensive QA Test Guide

This document provides a complete testing checklist for the ported QAston proc system from TrinityCore. Each test includes the proc configuration being validated and step-by-step instructions.

---

## Recent Bug Fixes (Priority Testing)

### Fix: Direct heals trigger PROC_SPELL_TYPE_HEAL procs
**Why:** SpellTypeMask=0x2 (HEAL) procs were not firing for direct heals.

**Test Steps:**
```
.learn 53501          -- Sheath of Light (Paladin)
.cast 19750           -- Flash of Light on target
```
- [x] Verify HoT is applied after Flash of Light crit (SpellTypeMask=0x2, HitMask=0x2)

### Fix: TAKEN procs checked on correct unit
**Why:** Damage/heal taken procs were checking the wrong unit.

**Test Steps:**
```
.aura 49005           -- Mark of Blood on enemy
# Attack the enemy
```
- [x] Verify YOU receive the heal, not the enemy (TAKEN proc on action target)

### Fix: Triggered spells don't fire CAST phase procs
**Why:** Channeled spell ticks were consuming Clearcasting/Arcane Potency charges.

**Test Steps:**
```
.learn 31571          -- Arcane Potency
.aura 12536           -- Apply Clearcasting
.cast 10                -- Blizzard (channeled)
```
- [x] Verify Arcane Potency buff persists through Blizzard channel
- [x] Only consumed when casting Arcane Blast/Missiles directly

---

## Proc System Reference

### Proc Flags (ProcFlags column)
```
0x00000001 = KILLED              0x00000002 = KILL
0x00000004 = DONE_MELEE_AUTO     0x00000008 = TAKEN_MELEE_AUTO
0x00000010 = DONE_SPELL_MELEE    0x00000020 = TAKEN_SPELL_MELEE
0x00000040 = DONE_RANGED_AUTO    0x00000080 = TAKEN_RANGED_AUTO
0x00010000 = DONE_SPELL_MAGIC_NEG
0x00040000 = DONE_PERIODIC       0x00080000 = TAKEN_PERIODIC
0x00100000 = TAKEN_DAMAGE
0x00400000 = DONE_MAINHAND       0x00800000 = DONE_OFFHAND
```

### SpellTypeMask
```
0x1 = DAMAGE    0x2 = HEAL    0x4 = NO_DMG_HEAL    0x7 = ALL
```

### SpellPhaseMask
```
0x1 = CAST    0x2 = HIT    0x4 = FINISH
```

### HitMask
```
0x001 = NORMAL    0x002 = CRITICAL    0x004 = MISS
0x010 = DODGE     0x020 = PARRY       0x040 = BLOCK
0x070 = DODGE|PARRY|BLOCK (for Turn the Tables)
```

### AttributesMask
```
0x1 = REQ_EXP_OR_HONOR    0x2 = TRIGGERED_CAN_PROC
0x4 = REQ_SPELLMOD        0x8 = REQ_MANA_COST
```

---

## Death Knight Tests

### Butchery (48979, 49483)
**Proc Config:** `AttributesMask=0x1` (REQ_EXP_OR_HONOR)
**Why:** Tests that PROC_ATTR_REQ_EXP_OR_HONOR correctly filters kills.

**Test Steps:**
```
.learn 48979                    -- Butchery Rank 1
# Find a critter (no XP)
# Kill it - should NOT proc
# Find level-appropriate mob and kill - should proc
```
- [x] Does NOT proc on critter (no XP/Honor)
- [x] DOES proc on XP-granting mob kill
- [x] Grants 10 Runic Power (Rank 1) or 20 RP (Rank 2)

---

### Mark of Blood (49005)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2` (HIT)
**Why:** Tests TAKEN damage proc that heals the attacker.

**Test Steps:**
```
# Target an enemy
.cast 49005                     -- Apply Mark of Blood
# Let enemy melee attack you
```
- [x] Each melee hit on you heals you for 4% of YOUR max health
- [x] Procs from enemy auto attacks
- [x] Procs from enemy melee spells

---

### Necrosis (51459-51464)
**Proc Config:** `ProcFlags=0x4` (DONE_MELEE_AUTO)
**Why:** Tests melee auto attack proc adding shadow damage.

**Test Steps:**
```
.learn 51459                    -- Necrosis Rank 1 (4%)
.go creature id 32666           -- Training Dummy
# Enable auto attack, watch combat log
```
- [x] Each melee auto attack deals bonus Shadow damage
- [x] Damage = 4/8/12/16/20% of weapon damage per rank
- [x] Only procs from auto attacks, not specials

---

### Sudden Doom (49018, 49529, 49530)
**Proc Config:** `SpellFamilyName=15` (DK), `SpellFamilyMask=0x01400000`, `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests main-hand auto attack proc with spell family filter.

**Test Steps:**
```
.learn 49018                    -- Sudden Doom Rank 1 (5%)
.go creature id 32666
# Auto attack until proc
```
- [x] Procs from main-hand melee attacks
- [x] Grants Sudden Doom buff (free Death Coil)
- [x] 5/10/15% chance per rank

---

### Blade Barrier (49182, 49500, 49501)
**Proc Config:** `SpellFamilyName=15`, `SpellPhaseMask=0x2` (HIT)
**Why:** Tests proc that activates when Blood Runes are depleted.

**Test Steps:**
```
.learn 49182                    -- Blade Barrier Rank 1
# Use Blood Strike twice to deplete Blood Runes
.cast 45902                     -- Blood Strike
.cast 45902
```
- [x] Blade Barrier buff appears when both Blood Runes on cooldown
- [x] 2/4/6% damage reduction per rank

---

### Rime / Freezing Fog (49188, 49796)
**Proc Config:** `SpellFamilyName=15`, `SpellFamilyMask1=0x00020000` (Obliterate), `SpellPhaseMask=0x2`
**Why:** Tests Obliterate-specific proc for free Howling Blast.

**Test Steps:**
```
.learn 49188                    -- Rime Rank 1 (15%)
.cooldown
.cast 49020                     -- Obliterate
```
- [x] Procs Freezing Fog buff on Obliterate hit
- [x] Next Howling Blast is free and instant
- [x] 15% chance per rank

---

### Threat of Thassarian (65661)
**Proc Config:** `ProcFlags=0x10` (DONE_SPELL_MELEE), `SpellFamilyMask=0x00400011|0x20020004`, `Chance=100`
**Why:** Tests dual-wield proc for specific DK abilities.

**Test Steps:**
```
.learn 65661                    -- Threat of Thassarian
# Equip two 1H weapons
.cast 49998                     -- Death Strike
.cast 49020                     -- Obliterate
.cast 45462                     -- Plague Strike
```
- [x] Death Strike hits with both weapons
- [x] Obliterate hits with both weapons
- [x] Off-hand damage is reduced

---

### Wandering Plague (49217, 49654, 49655)
**Proc Config:** `SpellFamilyMask2=0x00000002` (diseases), `Cooldown=1000`
**Why:** Tests disease tick proc with internal cooldown.

**Test Steps:**
```
.learn 49217                    -- Wandering Plague Rank 1
.cast 45462                     -- Plague Strike (applies Blood Plague)
# Wait for disease ticks near other enemies
```
- [x] Disease tick damage can proc Wandering Plague
- [x] 1 second internal cooldown between procs
- [x] Spreads to nearby enemies

---

### Killing Machine (51124)
**Proc Config:** `ProcFlags=0x10010` (DONE_SPELL_MELEE|DONE_MELEE_AUTO), `SpellFamilyMask=0x2|0x6`, `HitMask=0x8` (unused), `Charges=1`
**Why:** Tests charge-based proc consumed by specific abilities.

**Test Steps:**
```
.aura 51124                     -- Apply Killing Machine
.cast 45477                     -- Icy Touch
```
- [x] Killing Machine buff consumed on Icy Touch
- [x] Also consumed by: Howling Blast, Frost Strike, Obliterate
- [x] Guarantees critical hit

---

## Druid Tests

### Leader of the Pack (24932)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2` (HIT), `HitMask=0x2` (CRITICAL)
**Why:** Tests critical-hit-only proc with internal cooldown.

**Test Steps:**
```
.learn 17007                    -- Leader of the Pack
.morph 8571                     -- Cat Form appearance
.go creature id 32666
# Crit the dummy
```
- [x] Heals for 4% max HP on melee/ranged crit
- [x] 6 second internal cooldown (check combat log timestamps) - Fixed in spell script
- [x] Only procs on YOUR crits, not party members

---

### Omen of Clarity (16864)
**Proc Config:** `ProcsPerMinute=6`
**Why:** Tests PPM (procs per minute) calculation.

**Test Steps:**
```
.learn 16864                    -- Omen of Clarity
.go creature id 32666
# Auto attack for 2 minutes, count procs
```
- [x] ~6% chance per hit (not PPM)
- [x] Grants Clearcasting (next ability free)
- [x] Procs from both melee and spells

---

### Savage Defense (62600, 62606)
**Proc Config:** `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Bear Form crit proc creating absorb shield.

**Test Steps:**
```
.learn 62600                    -- Savage Defense
.morph 29414                    -- Bear Form appearance
.go creature id 32666
# Crit the dummy
```
- [x] Absorb shield appears on melee crit
- [x] Shield value = 25% of Attack Power
- [x] Only works in Bear Form

---

### Glyph of Starfire (54845)
**Proc Config:** `SpellFamilyMask=0x4` (Starfire), `ProcFlags=0x10000` (DONE_SPELL_MAGIC_NEG), `SpellTypeMask=0x1`
**Why:** Tests proc that extends existing DoT duration.

**Test Steps:**
```
.additem 40916                  -- Glyph of Starfire (apply glyph)
.cast 8921                      -- Moonfire on target
.cast 2912                      -- Starfire
```
- [x] Moonfire duration extended by 3 seconds
- [x] Maximum 9 second extension (3 Starfires)
- [x] Only extends Moonfire, not other DoTs

---

## Hunter Tests

### Thrill of the Hunt (34497-34499)
**Proc Config:** `SpellFamilyName=9`, `SpellFamilyMask=0x00060800|0x00800001|0x00000201`, `HitMask=0x2` (CRITICAL)
**Why:** Tests mana refund proc on specific shot criticals.

**Test Steps:**
```
.learn 34497                    -- Thrill of the Hunt Rank 1
.go creature id 32666
.cast 49050                     -- Aimed Shot (crit)
```
- [x] Returns 40% of shot mana cost on crit
- [x] Works with: Arcane, Aimed, Multi, Steady, Explosive, Kill Shot
- [x] 33/66/100% chance per rank

---

### Lock and Load (56342)
**Proc Config:** `SpellFamilyMask=0x18|0x08000000|0x00024000`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests trap-triggered proc.

**Test Steps:**
```
.learn 56342                    -- Lock and Load
.cast 13809                     -- Frost Trap
# Trigger trap with enemy
```
- [x] Procs from Frost Trap, Freezing Trap, Snake Trap triggers
- [x] Also procs from Black Arrow ticks
- [x] Grants 2 free Explosive/Arcane Shots

---

## Mage Tests

### Combustion (11129)
**Proc Config:** `SchoolMask=4` (Fire), `SpellFamilyName=3`, `SpellFamilyMask=0x08C00017|0x00031048`
**Why:** Tests Fire-school-only proc that stacks and consumes.

**Test Steps:**
```
.cast 11129                     -- Activate Combustion
.cast 133                       -- Fireball (try to crit)
# Watch stacks increase on crit, ability ends on non-crit
```
- [x] Stacks increase on Fire spell critical
- [x] Consumed (ends) on Fire non-critical
- [x] Only Fire school spells count

---

### Hot Streak (44445-44448)
**Proc Config:** `SpellFamilyMask=0x13|0x00011000`, `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests consecutive-crit tracking for instant Pyroblast.

**Test Steps:**
```
.learn 44445                    -- Hot Streak Rank 1
# Get 2 consecutive Fire crits (Fireball, Scorch, Fire Blast)
.cast 133                       -- Fireball (crit)
.cast 2948                      -- Scorch (crit)
```
- [x] First crit = Heating Up buff
- [x] Second consecutive crit = Hot Streak (instant Pyro)
- [x] Non-crit resets counter

---

### Arcane Potency (31571, 31572)
**Proc Config:** `ProcFlags=0x4000` (DONE_SPELL_MAGIC_POS), `SpellFamilyMask1=0x22|0x8`, `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests proc that requires Clearcasting active, FINISH phase.

**Test Steps:**
```
.learn 31571                    -- Arcane Potency Rank 1
.aura 12536                     -- Apply Clearcasting
.cast 30451                     -- Arcane Blast
```
- [x] Arcane Potency buff gained when Clearcasting consumed
- [x] NOT consumed by Blizzard ticks (triggered spells)
- [x] Only on FINISH phase of cast

---

### Fingers of Frost (74396)
**Proc Config:** `Charges` system
**Why:** Tests charge-based buff consumed by shatter spells.

**Test Steps:**
```
.aura 74396                     -- Apply Fingers of Frost (2 charges)
.cast 30455                     -- Ice Lance
.cast 30455                     -- Ice Lance again
```
- [x] First Ice Lance consumes 1 charge
- [x] Second Ice Lance consumes last charge
- [x] Deep Freeze also consumes charges

---

### Missile Barrage (44401)
**Proc Config:** `SpellFamilyMask=0x800`, `ProcFlags=0x1000` (DONE_SPELL_NONE_NEG), `Charges=1`, `HitMask=0x8` (AttributesMask)
**Why:** Tests charge drop on Arcane Missiles cast.

**Test Steps:**
```
.aura 44401                     -- Apply Missile Barrage
.cast 5143                      -- Arcane Missiles
```
- [x] Buff consumed when Arcane Missiles cast
- [x] Arcane Missiles channels faster
- [x] Only drops on Arcane Missiles, not other spells

---

## Paladin Tests

### Seal of Vengeance (31801) / Seal of Corruption (53736)
**Proc Config:** `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests stacking debuff proc from melee.

**Test Steps:**
```
.cast 31801                     -- Seal of Vengeance
.go creature id 32666
# Melee attack repeatedly
```
- [x] Holy Vengeance stacks applied (max 5)
- [x] Each stack increases DoT damage
- [x] Judgement damage scales with stacks

---

### Judgement of Light (20185)
**Proc Config:** `ProcsPerMinute=15`, `SpellTypeMask=0x1`
**Why:** Tests PPM heal proc on judged target.

**Test Steps:**
```
.cast 20271                     -- Judgement of Light on target
# Have multiple attackers hit the target
```
- [x] ~15 procs per minute
- [x] Heals attacker for 2% of their max HP
- [x] Works for all attackers, not just Paladin

---

### Righteous Vengeance (53380-53382)
**Proc Config:** `SpellFamilyMask=0x00800000|0x00028000`, `HitMask=0x2` (CRITICAL)
**Why:** Tests crit-only DoT proc from specific abilities.

**Test Steps:**
```
.learn 53380                    -- Righteous Vengeance Rank 1
.cast 35395                     -- Crusader Strike (get crit)
.cast 53385                     -- Divine Storm (get crit)
```
- [x] DoT applied on Crusader Strike crit
- [x] DoT applied on Divine Storm crit
- [x] DoT applied on Judgement crit

---

### Sacred Shield (53601)
**Proc Config:** `ProcFlags=0x100000` (TAKEN_DAMAGE), 6 sec cooldown implied by script
**Why:** Tests damage-taken proc with internal cooldown.

**Test Steps:**
```
.cast 53601                     -- Sacred Shield on self
# Take damage from enemy
```
- [x] Absorb shield proc on damage taken
- [x] 6 second internal cooldown
- [x] Absorb scales with spell power

---

## Priest Tests

### Vampiric Embrace (15286)
**Proc Config:** `SchoolMask=32` (Shadow), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests Shadow-school-only healing proc.

**Test Steps:**
```
.cast 15286                     -- Vampiric Embrace
.cast 589                       -- Shadow Word: Pain
# Wait for ticks
```
- [x] Shadow damage heals you and party
- [x] Only Shadow school (not Holy/Discipline)
- [x] Healing split between self and party

---

### Body and Soul (64127, 65081)
**Proc Config:** `SpellFamilyMask=0x1|0x1` (Power Word: Shield), `SpellTypeMask=0x6` (HEAL|NO_DMG_HEAL)
**Why:** Tests PW:S cast proc for movement speed.

**Test Steps:**
```
.learn 64127                    -- Body and Soul Rank 1
.cast 17                        -- Power Word: Shield on ally
```
- [x] Target gains movement speed buff
- [x] 30%/60% speed increase per rank
- [x] 4 second duration

---

## Rogue Tests

### Setup (13983, 14070, 14071)
**Proc Config:** `HitMask=0x18` (DODGE|PARRY), `Cooldown=1000`
**Why:** Tests dodge/parry-taken proc with ICD.

**Test Steps:**
```
.learn 13983                    -- Setup Rank 1
# Get attacked by enemy, dodge/parry attacks
```
- [x] Gain combo point when YOU dodge
- [x] 1 second internal cooldown
- [x] 33/66/100% chance per rank

---

### Turn the Tables (51627-51629)
**Proc Config:** `HitMask=0x70` (DODGE|PARRY|BLOCK = 0x10|0x20|0x40)
**Why:** Tests avoidance-based damage buff.

**Test Steps:**
```
.learn 51627                    -- Turn the Tables Rank 1
# Get attacked, dodge/parry/block
```
- [x] Damage buff on dodge
- [x] Damage buff on parry
- [x] Damage buff on block

---

### Cut to the Chase (51664-51667)
**Proc Config:** `SpellFamilyMask=0x20000|0x8` (Eviscerate, Envenom), `SpellTypeMask=0x1`
**Why:** Tests finisher proc that refreshes Slice and Dice.

**Test Steps:**
```
.learn 51664                    -- Cut to the Chase Rank 1
.aura 5171                      -- Slice and Dice (short duration)
.cast 2098                      -- Eviscerate (with combo points)
```
- [x] Slice and Dice refreshed to max duration
- [x] Works with Eviscerate
- [x] Works with Envenom

---

## Shaman Tests

### Windfury Weapon (33757)
**Proc Config:** `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `Cooldown=3000`
**Why:** Tests weapon enchant proc with internal cooldown.

**Test Steps:**
```
# Apply Windfury Weapon to main hand
.go creature id 32666
# Auto attack, watch for extra swings
```
- [x] Extra attacks proc on melee
- [x] 3 second internal cooldown
- [x] Bonus AP on extra attacks

---

### Maelstrom Weapon (51528-51532)
**Proc Config:** `ProcsPerMinute=4/8/12/16/20` per rank, `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests PPM stacking proc.

**Test Steps:**
```
.learn 51532                    -- Maelstrom Weapon Rank 5 (PPM 20)
.go creature id 32666
# Melee attack, watch stacks
```
- [x] Stacks build on melee hits
- [x] Max 5 stacks
- [x] PPM increases per rank (4/8/12/16/20)
- [x] 5 stacks = instant cast Lightning Bolt/Chain Lightning/Heal

---

### Lightning Overload (30675-30678)
**Proc Config:** `SpellFamilyMask=0x3` (LB, CL), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests spell-specific proc that casts additional spell.

**Test Steps:**
```
.learn 30675                    -- Lightning Overload Rank 1
.cast 403                       -- Lightning Bolt
```
- [x] Chance to proc extra Lightning Bolt
- [x] Extra bolt deals 50% damage
- [x] No threat, no mana cost

---

### Ancestral Awakening (51556-51558)
**Proc Config:** `SpellFamilyMask=0xC0|0x10` (heals), `SpellTypeMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests heal crit proc that smart-heals lowest ally.

**Test Steps:**
```
.learn 51556                    -- Ancestral Awakening Rank 1
# Have injured party members
.cast 331                       -- Healing Wave (crit)
```
- [x] Procs on Healing Wave/Lesser HW/Riptide crit
- [x] Heals lowest HP party member
- [x] 30% of heal amount

---

## Warlock Tests

### Nightfall (18094-18095)
**Proc Config:** `SpellFamilyMask=0xA` (Corruption, Drain Life), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests DoT tick proc for instant Shadow Bolt.

**Test Steps:**
```
.learn 18094                    -- Nightfall Rank 1
.cast 172                       -- Corruption
# Wait for ticks
```
- [x] Shadow Trance proc on Corruption tick
- [x] Also procs from Drain Life ticks
- [x] Next Shadow Bolt instant cast

---

### Decimation (63156-63158)
**Proc Config:** `SpellFamilyMask=0x1|0xC0` (SB, Incinerate), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests health-threshold-based proc.

**Test Steps:**
```
.learn 63156                    -- Decimation Rank 1
# Get target below 35% HP
.cast 686                       -- Shadow Bolt
```
- [x] Only procs when target below 35% HP
- [x] Next Soul Fire instant and 0 mana
- [x] Procs from Shadow Bolt or Incinerate

---

### Demonic Pact (53646)
**Proc Config:** `SpellTypeMask=0x0`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests pet crit proc that buffs raid.

**Test Steps:**
```
.learn 53646                    -- Demonic Pact
# Summon demon pet
# Have pet crit target
```
- [x] Procs on pet critical strike
- [x] Grants spell power buff to raid
- [x] Buff = 10% of Warlock's spell power

---

## Warrior Tests

### Deep Wounds (12834, 12849, 12867)
**Proc Config:** `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests melee crit proc that applies bleed DoT.

**Test Steps:**
```
.learn 12834                    -- Deep Wounds Rank 1
.go creature id 32666
# Melee crit the dummy
```
- [x] Bleed DoT applied on melee crit
- [x] Damage based on weapon damage
- [x] 16/32/48% of weapon damage per rank

---

### Sword and Board (46951-46953)
**Proc Config:** `SpellFamilyMask=0x400|0x40` (Devastate, Revenge), `SpellPhaseMask=0x2`
**Why:** Tests ability-specific proc that resets Shield Slam.

**Test Steps:**
```
.learn 46951                    -- Sword and Board Rank 1
.cast 47498                     -- Devastate
```
- [x] Chance to reset Shield Slam cooldown
- [x] Also refunds Shield Slam rage cost
- [x] Procs from Devastate and Revenge

---

### Second Wind (29834-29838)
**Proc Config:** `SpellTypeMask=0x5` (DAMAGE|NO_DMG_HEAL) - stun/immobilize detection
**Why:** Tests CC-triggered regen proc.

**Test Steps:**
```
.learn 29834                    -- Second Wind Rank 1
# Get stunned by enemy ability
```
- [x] Procs when stunned
- [x] Procs when immobilized (root)
- [x] Regenerates health and rage

---

## Pet Procs (Hunter)

### Culling the Herd (61680-61681)
**Proc Config:** `SpellFamilyMask1=0x10000000`, `SpellTypeMask=0x1`, `HitMask=0x2` (CRITICAL)
**Why:** Tests pet crit proc that buffs both hunter and pet.

**Test Steps:**
```
# Add pet spell directly to database (pet talents can't be learned via command):
# INSERT INTO pet_spell (guid, spell, active) VALUES (<pet_guid>, 61681, 193);
# Ensure GM invisibility is OFF (.gm visible on) or pet can't target hunter
# Have pet use Bite/Claw/Smack and crit target
```
- [x] Pet crit grants damage buff
- [x] Buff applies to hunter AND pet (via TARGET_UNIT_CASTER and TARGET_UNIT_MASTER)
- [x] 1/2/3% damage increase per rank

---

## Item/Trinket Procs

### Deathbringer's Will (71519 Normal, 71562 Heroic)
**Proc Config:** `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `Cooldown=105000`
**Why:** Tests class-specific proc with long ICD.

**Test Steps:**
```
.additem 50362                  -- Deathbringer's Will (Normal)
# Equip and attack target
```
- [x] Procs class-appropriate stat buff
- [x] 105 second internal cooldown
- [x] Different buffs for different classes

---

### Tiny Abomination in a Jar (71406 Normal, 71545 Heroic)
**Proc Config:** `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `Chance=50`
**Why:** Tests charge-stacking proc trinket.

**Test Steps:**
```
.additem 50351                  -- Tiny Abomination in a Jar
# Attack target, watch Mote of Anger stacks
```
- [x] 50% chance to gain Mote of Anger
- [x] At 8 stacks, consume for attack proc
- [x] Motes stack on melee/ranged damage

---

### Persistent Shield / Scarab Brooch (26467)
**Proc Config:** `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2` (HIT)
**Why:** Tests heal proc that creates absorb shield on healed target. Uses `SPELL_AURA_PROC_TRIGGER_SPELL` (aligned with TrinityCore - removed AC-specific SpellInfoCorrections override).

**Test Steps:**
```
.additem 21625                  -- Scarab Brooch
# Equip the trinket
.cast 2050                      -- Lesser Heal on target
```
- [x] Absorb shield appears on healed target
- [x] Shield = 15% of heal amount
- [x] Does NOT replace stronger existing shield from same caster
- [x] Works with all direct heals

---

## Boss Encounter Procs

### Deathbringer Saurfang - Blood Link (72176)
**Why:** Tests boss mechanic proc that excludes specific spell.

**Test Steps:**
```
# In ICC, engage Deathbringer Saurfang
# Have Blood Beasts attack players
```
- [ ] Blood Beasts generate Blood Power for Saurfang
- [ ] Does NOT proc from Mark of the Fallen Champion damage
- [ ] Works with absorbed damage

---

## Automated Unit Tests

Run the automated test suite:
```bash
cd build
make unit_tests
./src/test/unit_tests --gtest_filter="SpellProc*"
```

Test files:
- `SpellProcTest.cpp` - Core proc logic
- `SpellProcDataDrivenTest.cpp` - Database entries
- `SpellProcIntegrationTest.cpp` - Full integration

---

## Additional Death Knight Tests

### Unholy Blight (49194)
**Script:** `spell_dk_unholy_blight`
**Why:** Tests Death Coil damage proc applying DoT based on damage dealt.

**Test Steps:**
```
.learn 49194                    -- Unholy Blight
.cast 47541                     -- Death Coil on enemy
```
- [x] Unholy Blight DoT applied after Death Coil
- [x] DoT damage = 10% of Death Coil damage over 10 sec
- [x] Glyph of Unholy Blight increases damage by 40%

**With Glyph:**
```
.additem 45803                  -- Glyph of Unholy Blight (apply glyph)
.learn 49194                    -- Unholy Blight
.cast 47541                     -- Death Coil on enemy
```

---

### Vendetta (49015-49017)
**Script:** `spell_dk_vendetta`
**Why:** Tests kill proc that heals based on max health.

**Test Steps:**
```
.learn 49015                    -- Vendetta Rank 1
# Kill an enemy that grants XP/Honor
```
- [x] Heals for 2/4/6% of max health on kill (per rank)
- [x] Only procs on kills that grant XP/Honor

---

### Runic Power Back on Snare/Root (61257)
**Script:** `spell_dk_pvp_4p_bonus`
**Why:** Tests proc when snare/root is applied to DK.

**Test Steps:**
```
# DK PvP 4P - Relentless Gladiator's Dreadplate (need 4 pieces)
.additem 40791                  -- Relentless Gladiator's Dreadplate Chestpiece
.additem 40811                  -- Relentless Gladiator's Dreadplate Gauntlets
.additem 40830                  -- Relentless Gladiator's Dreadplate Helm
.additem 40851                  -- Relentless Gladiator's Dreadplate Legguards
# Equip all 4 pieces
# Get snared or rooted by an enemy
```
- [x] Grants Runic Power when snared/rooted (code review verified)
- [x] Part of PvP 4P set bonus

---

### Death Rune Mastery
**Script:** `spell_dk_death_rune`
**Why:** Tests converting runes to Death Runes on proc.

**Test Steps:**
```
.learn 49467                    -- Death Rune Mastery
# Use Obliterate or Death Strike
```
- [x] Frost/Unholy runes become Death Runes

---

### Glyph of Death Grip (62259)
**Script:** `spell_dk_glyph_of_death_grip`
**Why:** Tests glyph resetting Death Grip cooldown on kill.

**Test Steps:**
```
.additem 43541                  -- Glyph of Death Grip (apply glyph)
.cast 49576                     -- Death Grip an enemy
# Kill the target
```
- [x] Death Grip cooldown resets when you kill a target that grants XP/Honor

---

### Glyph of Scourge Strike (58642)
**Script:** `spell_dk_glyph_of_scourge_strike`
**Why:** Tests glyph extending disease duration.

**Test Steps:**
```
.additem 43551                  -- Glyph of Scourge Strike (apply glyph)
.cast 45462                     -- Plague Strike (applies Blood Plague)
.cast 45477                     -- Icy Touch (applies Frost Fever)
.cast 55090                     -- Scourge Strike
```
- [x] Extends disease duration by 3 sec (up to 9 sec max)

---

## Additional Druid Tests

### Glyph of Innervate (54832)
**Script:** `spell_dru_glyph_of_innervate`
**Why:** Tests glyph giving caster mana when casting Innervate on others.

**Test Steps:**
```
.additem 40908                  -- Glyph of Innervate (apply glyph)
.cast 29166                     -- Innervate on friendly target
```
- [x] Caster receives 45% of Innervate effect when cast on another player

---

### Glyph of Rake (54821)
**Script:** `spell_dru_glyph_of_rake`
**Why:** Tests glyph adding stun to Rake when used from stealth.

**Test Steps:**
```
.additem 40903                  -- Glyph of Rake (apply glyph)
.morph 8571                     -- Cat Form appearance
.cast 5215                      -- Prowl (stealth)
.cast 48574                     -- Rake
```
- [x] Rake stuns target for 3 sec when used from stealth

---

### Glyph of Rejuvenation (54754)
**Script:** `spell_dru_glyph_of_rejuvenation`
**Why:** Tests glyph bonus heal when Rejuv target is low health.

**Test Steps:**
```
.additem 40913                  -- Glyph of Rejuvenation (apply glyph)
.damage 5000                    -- Damage target to below 50% HP
.cast 48441                     -- Rejuvenation
```
- [x] Bonus heal when target is below 50% health

---

### Eclipse (48516-48518)
**Script:** `spell_dru_eclipse`
**Why:** Tests Solar/Lunar eclipse proc alternation.

**Test Steps:**
```
.learn 48516                    -- Eclipse Rank 1
# Cast Starfire until Lunar Eclipse procs
# Cast Wrath until Solar Eclipse procs
```
- [x] Starfire crits proc Lunar Eclipse (bonus Wrath damage)
- [x] Wrath crits proc Solar Eclipse (bonus Starfire crit)
- [x] Eclipse states alternate correctly

---

### Revitalize (48539-48541)
**Script:** `spell_dru_revitalize`
**Why:** Tests HoT tick proc restoring resources.

**Test Steps:**
```
.learn 48539                    -- Revitalize Rank 1
.cast 774                       -- Rejuvenation on target
```
- [ ] Rejuv/Wild Growth/Lifebloom ticks have chance to restore resources
- [ ] Restores mana/rage/energy/runic power based on target class

---

### Glyph of Shred (54815)
**Script:** `spell_dru_glyph_of_shred`
**Why:** Tests glyph extending Rip duration.

**Test Steps:**
```
.additem 40901                  -- Glyph of Shred (apply glyph)
.morph 8571                     -- Cat Form appearance
.mod energy 100
# Build combo points and apply Rip
.cast 49800                     -- Rip
.cast 48572                     -- Shred
```
- [x] Shred extends Rip duration by 2 sec (up to 6 sec max)

---

### T10 Restoration 4P Bonus (70664)
**Script:** `spell_dru_t10_restoration_4p_bonus_dummy`
**Why:** Tests set bonus Rejuv jump to new target.

**Test Steps:**
```
# T10 Resto Druid - Sanctified Lasherweave (need 4 pieces)
.additem 51145                  -- Sanctified Lasherweave Vestment (Chest)
.additem 51143                  -- Sanctified Lasherweave Headguard (Head)
.additem 51138                  -- Sanctified Lasherweave Gauntlets (Hands)
.additem 51136                  -- Sanctified Lasherweave Legplates (Legs)
# Equip all 4 pieces
# In a group, cast Rejuvenation repeatedly
.cast 48441                     -- Rejuvenation
```
- [x] Rejuvenation has 2% chance to jump to a new raid member without Rejuv (or self if solo)

---

## Additional Hunter Tests

### Hunting Party (53290-53292)
**Script:** `spell_hun_hunting_party`
**Why:** Tests party mana regen on crit.

**Test Steps:**
```
.learn 53290                    -- Hunting Party Rank 1
# Land critical hits with Arcane Shot, Explosive Shot, or Steady Shot
```
- [x] Crits grant Replenishment to party
- [x] 1% mana per 5 sec for 15 sec

---

### Rapid Recuperation (53228-53232)
**Script:** `spell_hun_rapid_recuperation`
**Why:** Tests mana regen during Rapid Fire.

**Test Steps:**
```
.learn 53228                    -- Rapid Recuperation Rank 1
.cast 3045                      -- Rapid Fire
```
- [x] Gain mana regen while Rapid Fire is active
- [x] Also triggers from Rapid Killing buff

---

### Glyph of Mend Pet (57870)
**Script:** `spell_hun_glyph_of_mend_pet`
**Why:** Tests glyph happiness restoration.

**Test Steps:**
```
.additem 43350                  -- Glyph of Mend Pet (apply glyph)
# Summon pet and apply a debuff (curse/poison/disease)
.cast 48990                     -- Mend Pet
```
- [x] Mend Pet has 25% chance to cleanse Curse/Poison/Disease from pet

---

### Piercing Shots (53234-53236)
**Script:** `spell_hun_piercing_shots`
**Why:** Tests crit bleed proc.

**Test Steps:**
```
.learn 53234                    -- Piercing Shots Rank 1
# Crit with Aimed Shot, Steady Shot, or Chimera Shot
```
- [x] Crit applies bleed DoT
- [x] DoT = 10/20/30% of crit damage over 8 sec

---

## Additional Priest Tests

### Improved Spirit Tap (15337-15338)
**Script:** `spell_pri_improved_spirit_tap`
**Why:** Tests mana regen proc on Mind Blast crit.

**Test Steps:**
```
.learn 15337                    -- Improved Spirit Tap Rank 1
# Crit with Mind Blast or Shadow Word: Death
```
- [x] Grants Spirit Tap buff (increased spirit/mana regen)

---

### Blessed Recovery (27811-27816)
**Script:** `spell_pri_blessed_recovery`
**Why:** Tests heal over time proc when crit.

**Test Steps:**
```
.learn 27811                    -- Blessed Recovery Rank 1
# Get crit by an enemy
```
- [x] HoT applied when you receive a critical strike
- [x] Heals 5/10/15% of crit damage over 6 sec

---

### T10 Healer 2P Bonus (70770)
**Script:** `spell_pri_t10_heal_2p_bonus`
**Why:** Tests set bonus proc.

**Test Steps:**
```
# T10 Holy/Disc Priest - Sanctified Crimson Acolyte (need 2 pieces)
.additem 51178                  -- Sanctified Crimson Acolyte Hood (Head)
.additem 51179                  -- Sanctified Crimson Acolyte Gloves (Hands)
# Equip both pieces
.cast 48071                     -- Flash Heal
```
- [x] Procs Blessed Healing HoT (33% of heal over 9 sec)

---

## Additional Rogue Tests

### Glyph of Backstab (56800)
**Script:** `spell_rog_glyph_of_backstab`
**Why:** Tests glyph extending Rupture.

**Test Steps:**
```
.additem 42956                  -- Glyph of Backstab (apply glyph)
.mod energy 100
# Build combo points
.cast 48672                     -- Rupture
.cast 48657                     -- Backstab
```
- [x] Backstab extends Rupture by 2 sec (up to 6 sec max)

---

### Master of Subtlety (31223-31225)
**Script:** `spell_rog_stealth_buff_tracker` + SpellAuras.cpp hardcoded logic
**Why:** Tests damage bonus after stealth break.

**Test Steps:**
```
.learn 31223                    -- Master of Subtlety Rank 1
# Enter stealth - should get 10% damage buff (31665)
# Break stealth with an attack - buff persists for 6 seconds
```
- [x] Buff (31665) applied on stealth enter
- [x] Buff persists 6 seconds after stealth break (tracker 31666)

---

### Deadly Brew (51625-51626)
**Script:** `spell_rog_deadly_brew`
**Why:** When applying Instant/Wound/Mind-Numbing Poison, also applies Crippling Poison.

**Test Steps:**
```
.learn 51625                    -- Deadly Brew Rank 1
.additem 6947 20                -- Instant Poison
# Apply Instant Poison to weapon, attack target
```
- [x] Target gets Crippling Poison (3409) when Instant Poison procs

---

### Quick Recovery (31244-31245)
**Script:** `spell_rog_quick_recovery`
**Why:** Tests energy refund on finishing move.

**Test Steps:**
```
.learn 31244                    -- Quick Recovery Rank 1
# Use finishing move that doesn't kill target
```
- [x] Refunds 40/80% of energy cost if finishing move doesn't kill

---

### Overkill (58426)
**Script:** `spell_rog_stealth_buff_tracker` + SpellAuras.cpp hardcoded logic
**Why:** Tests energy regen bonus after stealth.

**Test Steps:**
```
.learn 58426                    -- Overkill
# Enter stealth - get buff (58427)
# Break stealth - buff persists 20 sec
```
- [x] 30% energy regen bonus for 20 sec after leaving stealth
- [x] Refreshes on re-entering stealth

---

## Additional Shaman Tests

### Glyph of Healing Wave (55440)
**Script:** `spell_sha_glyph_of_healing_wave`
**Why:** Tests self-heal when healing others.

**Test Steps:**
```
.additem 41534                  -- Glyph of Healing Wave (apply glyph)
.damage 2000                    -- Damage self for testing
.cast 49273                     -- Healing Wave on friendly target
```
- [x] Caster heals for 20% of Healing Wave amount

---

### Spirit Hunt (58877)
**Script:** `spell_sha_spirit_hunt`
**Why:** Tests Spirit Wolf heal on damage.

**Test Steps:**
```
.cast 51533                     -- Feral Spirit
# Spirit Wolves attack enemy
```
- [x] Spirit Wolf heals owner when dealing damage

---

### Frozen Power (63373-63374)
**Script:** `spell_sha_frozen_power`
**Why:** Tests Frost Shock root on distant targets (>15 yards).

**Test Steps:**
```
.learn 63373                    -- Frozen Power Rank 1
# Stand > 15 yards from target
.cast 49236                     -- Frost Shock (max rank) on distant target
```
- [x] Frost Shock roots target when cast from > 15 yards
- [x] Does NOT root when cast from < 15 yards
- **BUG:** Earthbind Totem incorrectly procs this - needs separate investigation

---

### Astral Shift (51474-51478)
**Script:** `spell_sha_astral_shift_aura`
**Why:** Tests damage reduction when stunned.

**Test Steps:**
```
.learn 51474                    -- Astral Shift Rank 1
# Get stunned, feared, or silenced
```
- [x] 30% damage reduction while CC'd (buff 52179 appears)

---

### Improved Water Shield (16180-16196)
**Script:** `spell_sha_imp_water_shield`
**Why:** Tests Water Shield proc on crit heal.

**Test Steps:**
```
.learn 16180                    -- Improved Water Shield Rank 1
.cast 52127                     -- Water Shield
# Crit with a heal spell
```
- [x] Critical heals consume Water Shield charge
- [x] 33/66/100% chance per rank

---

### Shamanistic Rage (30823)
**Script:** `spell_sha_shamanistic_rage`
**Why:** Tests mana restore on melee hit.

**Test Steps:**
```
.learn 30823                    -- Shamanistic Rage
.cast 30823                     -- Activate Shamanistic Rage
# Melee attack enemies
```
- [x] Melee hits restore mana based on AP

---

### Static Shock (51525-51527)
**Script:** `spell_sha_static_shock`
**Why:** Tests Lightning Shield proc on melee hit.

**Test Steps:**
```
.cast 49281                     -- Lightning Shield Rank 11
.aura 51527                     -- Static Shock Rank 3
# Attack target - Lightning Shield procs on YOUR melee hits
```
- [x] Melee attacks have chance to trigger Lightning Shield charge
- **FIXED:** Added missing `spell_sha_lightning_shield` script and spell_script_names entry

---

### T8 Elemental 4P Bonus (64928)
**Script:** `spell_sha_t8_electrified`
**Why:** Tests Lightning Bolt crit DoT proc.

**Test Steps:**
```
# T8 Elemental Shaman - Conqueror's Worldbreaker (need 4 pieces)
.additem 46206                  -- Conqueror's Worldbreaker Hauberk (Chest)
.additem 46207                  -- Conqueror's Worldbreaker Gloves (Hands)
.additem 46209                  -- Conqueror's Worldbreaker Helm (Head)
.additem 46211                  -- Conqueror's Worldbreaker Shoulderpads (Shoulders)
# Equip all 4 pieces
.cast 49238                     -- Lightning Bolt (try to crit)
```
- [x] Crit applies Electrified DoT

---

## Additional Warlock Tests

### Glyph of Life Tap (63320)
**Script:** `spell_warl_glyph_of_life_tap`
**Why:** Tests spirit buff after Life Tap.

**Test Steps:**
```
.additem 45785                  -- Glyph of Life Tap (apply glyph)
.cast 57946                     -- Life Tap (Rank 8)
```
- [x] Grants 20% spirit as spell power for 40 sec

---

### Improved Drain Soul (18213-18372)
**Script:** `spell_warl_improved_drain_soul`
**Why:** Tests mana restore on kill with Drain Soul.

**Test Steps:**
```
.learn 18213                    -- Improved Drain Soul Rank 1
# Kill enemy with Drain Soul active
```
- [x] Restores 7/15% max mana on kill
- [x] 100% chance to proc Soul Shard

---

### Seed of Corruption (27243)
**Script:** `spell_warl_seed_of_corruption_dummy`
**Why:** Tests AoE explosion proc.

**Test Steps:**
```
.cast 27243                     -- Seed of Corruption
# Deal damage to target until seed explodes
```
- [x] Explodes after taking enough damage
- [x] Deals AoE damage to nearby enemies
- [x] Only one Seed per Warlock per target
- **NOTE:** Test on real mobs, not Training Dummies (dummies have 1 HP which triggers low-health explosion)

---

### Soul Leech (30293-30295)
**Script:** `spell_warl_soul_leech`
**Why:** Tests health restore on Shadow/Fire damage.

**Test Steps:**
```
.learn 30293                    -- Soul Leech Rank 1
# Cast Shadow Bolt or Incinerate
```
- [x] Restores 10/20/30% of damage as health
- [x] Works with Shadow Bolt, Shadowburn, Chaos Bolt, Soul Fire, Incinerate

---

## Additional Warrior Tests

### T10 Melee 4P Bonus Extra Proc
**Script:** `spell_warr_extra_proc`
**Why:** Tests T10 bonus charge on Sudden Death/Bloodsurge.

**Test Steps:**
```
# T10 DPS Warrior - Sanctified Ymirjar Lord's (need 4 pieces)
.additem 51214                  -- Sanctified Ymirjar Lord's Battleplate (Chest)
.additem 51212                  -- Sanctified Ymirjar Lord's Helmet (Head)
.additem 51213                  -- Sanctified Ymirjar Lord's Gauntlets (Hands)
.additem 51210                  -- Sanctified Ymirjar Lord's Shoulderplates (Shoulders)
# Equip all 4 pieces
# Enter Battle Stance, attack to proc Sudden Death or Bloodsurge
.learn 29723                    -- Sudden Death (if not known)
```
- [x] T10 4P grants extra free Execute/Slam charge

---

### Glyph of Blocking (58374)
**Script:** `spell_warr_glyph_of_blocking`
**Why:** Tests block value increase on Shield Slam.

**Test Steps:**
```
.additem 43425                  -- Glyph of Blocking (apply glyph)
# Equip a shield
.cast 47488                     -- Shield Slam (Rank 8)
```
- [x] Shield Slam increases block value for 10 sec

---

### T10 Protection 4P Bonus (70844)
**Script:** `spell_warr_item_t10_prot_4p_bonus`
**Why:** Tests Bloodrage absorb shield proc.

**Test Steps:**
```
# T10 Protection Warrior - Sanctified Ymirjar Lord's (need 4 pieces)
.additem 51220                  -- Sanctified Ymirjar Lord's Breastplate (Chest)
.additem 51221                  -- Sanctified Ymirjar Lord's Greathelm (Head)
.additem 51222                  -- Sanctified Ymirjar Lord's Handguards (Hands)
.additem 51224                  -- Sanctified Ymirjar Lord's Pauldrons (Shoulders)
# Or just apply the bonus directly:
.aura 70844                     -- Item - Warrior T10 Protection 4P Bonus
.cast 2687                      -- Bloodrage
```
- [x] Bloodrage costs no health
- [x] Bloodrage grants absorb shield equal to 20% max health

---

## Item Proc Tests

### Alchemist's Stone (17619)
**Script:** `spell_item_alchemists_stone`
**Why:** Tests potion bonus from Alchemist's Stone.

**Test Steps:**
```
# Choose one of these Alchemist Stones:
.additem 13503                  -- Alchemist's Stone (Original)
# OR for WotLK versions:
.additem 44322                  -- Mercurial Alchemist Stone (SP)
.additem 44323                  -- Indestructible Alchemist's Stone (Tank)
.additem 44324                  -- Mighty Alchemist's Stone (AP)
# Equip the trinket
.additem 33447                  -- Runic Healing Potion
# Use the potion
```
- [x] Increases potion effect by 40%

---

### Aura of Madness (39446) - Darkmoon Card: Madness
**Script:** `spell_item_aura_of_madness`
**Why:** Tests random proc on killing blow.

**Test Steps:**
```
.additem 31859                  -- Darkmoon Card: Madness
# Equip the trinket
# Kill a mob that yields XP or honor
```
- [x] Random proc effect on killing blow (XP/honor mobs)
- [x] Various buffs like Paranoia, Manic, Narcissism, etc.

---

### Deadly Precision (71564)
**Script:** `spell_item_deadly_precision`
**Why:** Tests armor pen on-use buff that loses stacks on spell hit.

**Test Steps:**
```
.additem 50259                  -- Nevermelting Ice Crystal (caster trinket)
# Use trinket - applies Deadly Precision buff with 5 stacks of armor pen
# Cast damaging spells - each hit removes a stack
```
- [x] Using trinket applies 5 stacks of armor penetration
- [x] Spell hits remove stacks one at a time

---

### Black Bow of the Betrayer (29969)
**Script:** `spell_gen_black_bow_of_the_betrayer`
**Why:** Tests mana drain proc.

**Test Steps:**
```
.additem 32336                  -- Black Bow of the Betrayer
.additem 41586                  -- Terrorshaft Arrow (ammo)
# Equip the bow
# Target a caster mob with mana
.cast 49045                     -- Arcane Shot
# Or auto shot
```
- [x] Drains mana from target, restores to shooter

---

## Generic/Boss Proc Tests

### Vampiric Touch (52723) - Generic
**Script:** `spell_gen_vampiric_touch`
**Why:** Tests generic vampiric healing proc.

**Test Steps:**
```
# Encounter with Vampiric Touch mechanic
```
- [ ] Heals attacker based on damage dealt

---

### Overlord's Brand (69172/69173)
**Script:** `spell_gen_overlords_brand`
**Why:** Tests Deathwhisper add damage redirect.

**Test Steps:**
```
.tele icecrown
# Engage Deathwhisper with Cult Adherents
```
- [ ] Damage to branded player redirects to Deathwhisper
- [ ] DoT damage handled separately

---

### Mirrored Soul (69023)
**Script:** `spell_gen_mirrored_soul`
**Why:** Tests Devourer of Souls damage sharing.

**Test Steps:**
```
.tele forgeofsouls
# Engage Devourer of Souls
```
- [ ] Damage to boss also damages linked player

---

## Known Unimplemented

- `spell_q13413_wyrmrest_skytalon_ride_periodic` - Quest vehicle

---

## Quick Reference: Glyph Item IDs

Use these `.additem` commands to quickly add glyphs for testing:

| Glyph Name               | Item ID | Class        |
|--------------------------|---------|--------------|
| Glyph of Starfire        | 40916   | Druid        |
| Glyph of Innervate       | 40908   | Druid        |
| Glyph of Rake            | 40903   | Druid        |
| Glyph of Rejuvenation    | 40913   | Druid        |
| Glyph of Shred           | 40901   | Druid        |
| Glyph of Death Grip      | 43541   | Death Knight |
| Glyph of Scourge Strike  | 43551   | Death Knight |
| Glyph of Unholy Blight   | 45803   | Death Knight |
| Glyph of Mend Pet        | 43350   | Hunter       |
| Glyph of Backstab        | 42956   | Rogue        |
| Glyph of Healing Wave    | 41534   | Shaman       |
| Glyph of Life Tap        | 45785   | Warlock      |
| Glyph of Blocking        | 43425   | Warrior      |

---

## Quick Reference: Tier Set Item IDs

### Death Knight PvP 4P (Relentless Gladiator's Dreadplate)
```
.additem 40791 40811 40830 40851
```
- 40791 - Chestpiece
- 40811 - Gauntlets
- 40830 - Helm
- 40851 - Legguards

### Druid T10 Restoration 4P (Sanctified Lasherweave)
```
.additem 51145 51143 51138 51136
```
- 51145 - Vestment (Chest)
- 51143 - Headguard (Head)
- 51138 - Gauntlets (Hands)
- 51136 - Legplates (Legs)

### Priest T10 Healer 2P (Sanctified Crimson Acolyte)
```
.additem 51178 51179
```
- 51178 - Hood (Head)
- 51179 - Gloves (Hands)

### Shaman T8 Elemental 4P (Conqueror's Worldbreaker)
```
.additem 46206 46207 46209 46211
```
- 46206 - Hauberk (Chest)
- 46207 - Gloves (Hands)
- 46209 - Helm (Head)
- 46211 - Shoulderpads (Shoulders)

### Warrior T10 DPS 4P (Sanctified Ymirjar Lord's)
```
.additem 51214 51212 51213 51210
```
- 51214 - Battleplate (Chest)
- 51212 - Helmet (Head)
- 51213 - Gauntlets (Hands)
- 51210 - Shoulderplates (Shoulders)

### Warrior T10 Protection 4P (Sanctified Ymirjar Lord's)
```
.additem 51219 51218 51217 51215
```
- 51219 - Breastplate (Chest)
- 51218 - Greathelm (Head)
- 51217 - Handguards (Hands)
- 51215 - Pauldrons (Shoulders)

---

## Quick Reference: Other Trinkets/Items

| Item Name                          | Item ID |
|------------------------------------|---------|
| Deathbringer's Will (Normal)       | 50362   |
| Deathbringer's Will (Heroic)       | 50363   |
| Tiny Abomination in a Jar          | 50351   |
| Scarab Brooch                      | 21625   |
| Alchemist's Stone (Original)       | 13503   |
| Mercurial Alchemist Stone          | 44322   |
| Indestructible Alchemist's Stone   | 44323   |
| Mighty Alchemist's Stone           | 44324   |
| Darkmoon Card: Madness             | 31859   |
| Black Bow of the Betrayer          | 32336   |

---

## GitHub Issues This PR Addresses

The QAston proc system port should fix or improve the following reported issues:

### Directly Fixed (High Confidence)

| Issue | Title | Test |
|-------|-------|------|
| [#5967](https://github.com/azerothcore/azerothcore-wotlk/issues/5967) | **Tiny Abomination in a Jar** - proc backfires and double-triggers | ✅ FIXED - `.additem 50351` - Attack with Rupture, verify no self-damage |
| [#16062](https://github.com/azerothcore/azerothcore-wotlk/issues/16062) | **Turn the Tables** - buff applies to nearby players | ✅ FIXED - `.learn 51629` - Dodge attack, only rogue gets buff |
| [#13330](https://github.com/azerothcore/azerothcore-wotlk/issues/13330) | **Triggered Spells put you into combat** - Ignite extends combat | ✅ FIXED - Mage with Ignite - leave combat after Living Bomb crit |
| [#21401](https://github.com/azerothcore/azerothcore-wotlk/issues/21401) | **Druid Shapeshifting procs Omen of Clarity** | ✅ FIXED - `.learn 16864` - Shapeshift should NOT proc Clearcasting |
| [#19709](https://github.com/azerothcore/azerothcore-wotlk/issues/19709) | **Blazing Speed triggers too often** | ✅ FIXED - `.learn 31642` - Get hit, verify ~10% proc rate |

### Likely Fixed (Proc System Related)

| Issue | Title | Test |
|-------|-------|------|
| [#11462](https://github.com/azerothcore/azerothcore-wotlk/issues/11462) | **$50 Bounty - Arcane Concentration/Blizzard** - each tick should proc | ✅ FIXED - `.learn 12536` `.cast 10` - Multiple Clearcasting procs possible |
| [#23326](https://github.com/azerothcore/azerothcore-wotlk/issues/23326) | **Thunderstorm crits don't grant Clearcasting** | ✅ FIXED - Elemental Shaman - Thunderstorm crit should proc Clearcasting |
| [#15915](https://github.com/azerothcore/azerothcore-wotlk/issues/15915) | **Resilience + crit-victim talents** (Blood Craze, Eye for an Eye) | PvP gear + talent - non-crits should have chance to proc |
| [#22279](https://github.com/azerothcore/azerothcore-wotlk/issues/22279) | **Righteous Weapon Coating** - doesn't proc on ranged | ✅ FIXED - `.additem 34539` - Hunter ranged attacks should proc |
| [#9400](https://github.com/azerothcore/azerothcore-wotlk/issues/9400) | **Engulfing Shadows** - Blade of Eternal Darkness proc doesn't crit | ✅ FIXED - `.additem 17780` - Shadow damage proc should be able to crit |
| [#19793](https://github.com/azerothcore/azerothcore-wotlk/issues/19793) | **Darkmoon Card: Crusade** - incorrect proc stacking for paladin | ✅ FIXED - `.additem 31856` - Judgment should give SP not AP |
| [#24146](https://github.com/azerothcore/azerothcore-wotlk/issues/24146) | **Seal of Command + Ravager's Bladestorm** | ✅ FIXED - `.additem 7717` `.cast 31801` - Bladestorm should proc seals |
| [#12115](https://github.com/azerothcore/azerothcore-wotlk/issues/12115) | **Replenishment aura generates threat** | ✅ FIXED - Paladin JotW - Replenishment shouldn't pull aggro |
| [#11410](https://github.com/azerothcore/azerothcore-wotlk/issues/11410) | **Invulnerable Mail proc** - doesn't block melee spells | `.additem 12641` - Proc should block Sinister Strike etc |
| [#4276](https://github.com/azerothcore/azerothcore-wotlk/issues/4276) | **Goregek's Endurance** - heals player on damage dealt | Proc should only heal when taking damage |
| [#12003](https://github.com/azerothcore/azerothcore-wotlk/issues/12003) | **Thunderfury proc** - incorrect threat values | `.additem 19019` - Verify threat matches retail values |
| [#24116](https://github.com/azerothcore/azerothcore-wotlk/issues/24116) | **Flametongue** - lower rank prevents higher rank proccing | ✅ FIXED - Shaman weapon imbue stacking |

### May Be Improved (Related to Proc Handling)

| Issue | Title | Notes |
|-------|-------|-------|
| [#22427](https://github.com/azerothcore/azerothcore-wotlk/issues/22427) | **Cleave + Sweeping Strikes interaction** | ✅ FIXED - Complex multi-target proc chain |
| [#17564](https://github.com/azerothcore/azerothcore-wotlk/issues/17564) | **T5 Crystalforge Raiment 4-set** | ✅ FIXED - Set bonus proc not working |
| [#18324](https://github.com/azerothcore/azerothcore-wotlk/issues/18324) | **Executioner enchant** - doesn't refresh duration | ❌ NOT FIXED - Proc refresh logic |
| [#10993](https://github.com/azerothcore/azerothcore-wotlk/issues/10993) | **Dislodged Foreign Object** - effect never triggers | ✅ FIXED - Trinket proc not firing |
| [#22068](https://github.com/azerothcore/azerothcore-wotlk/issues/22068) | **Rogue Combo Point Visual** - incorrect display after proc | Seal Fate + Relentless Strikes combo point display |
| [#19807](https://github.com/azerothcore/azerothcore-wotlk/issues/19807) | **Priest T5 DPS Set Bonus** - Sadist consumed on tick | ✅ FIXED - Mind Flay tick consumes buff instead of next cast |
| [#12678](https://github.com/azerothcore/azerothcore-wotlk/issues/12678) | **Buff instance removal** - removes all instances | Multiple HoTs/procs removed when canceling one |
| [#11311](https://github.com/azerothcore/azerothcore-wotlk/issues/11311) | **Retribution Aura** - has a chance to miss | ❌ NOT FIXED - Ret aura proc shouldn't miss against higher level mobs |

### Additional Issues to Investigate

| Issue | Title | Test |
|-------|-------|------|
| [#17825](https://github.com/azerothcore/azerothcore-wotlk/issues/17825) | **Entrapment** - only works when hunter near trap | `.learn 19184` - Trap should root even when hunter is far away |
| [#19936](https://github.com/azerothcore/azerothcore-wotlk/issues/19936) | **Replenishment** - mana doesn't replenish over time | Paladin JotW - mana should tick continuously, not just once |
| [#20521](https://github.com/azerothcore/azerothcore-wotlk/issues/20521) | **Vindication** - stacks with Demoralizing Shout | `.learn 26021` - Should NOT stack with Demo Shout (same debuff type) |

### Test Commands for Issue Verification

**#5967 - Tiny Abomination in a Jar:**
```
.additem 50351
# Equip trinket, build combo points on Rogue
.cast 48672                     -- Rupture
# Verify: No self-damage from Manifest Anger, stacks correctly
```

**#16062 - Turn the Tables:**
```
# Character A (Rogue):
.learn 51629                    -- Turn the Tables
# Character B (any class):
# Stand on the Rogue, pull mobs, get dodged/parried
# Verify: Only Rogue gets the damage buff, not Character B
```

**#11462 - Arcane Concentration + Blizzard:**
```
.learn 12536                    -- Force Clearcasting via talent
.go creature id 32666
.cast 10                        -- Blizzard (channeled)
# Watch for multiple Clearcasting procs during channel
# Old behavior: Only first tick could proc
# Fixed: Each tick has independent 10% chance
```

**#19709 - Blazing Speed:**
```
.learn 31642                    -- Blazing Speed (10% proc chance)
# Get hit repeatedly by enemy
# Count procs over 100 hits - should be ~10, not higher
```

**#21401 - Omen of Clarity + Shapeshift:**
```
.learn 16864                    -- Omen of Clarity
# Spam shapeshift in/out of forms
# Verify: Clearcasting does NOT proc from shapeshifting
```

**#13330 - Triggered Spells + Combat:**
```
.learn 12848                    -- Ignite talent
.learn 44457                    -- Living Bomb
.cast 44457                     -- Living Bomb on target
# Wait for LB to crit and apply Ignite
# Leave combat - should drop within normal time
# Old behavior: Ignite extended combat indefinitely
```

**#15915 - Resilience + Crit-Victim Talents:**
```
# On Warrior with resilience gear:
.learn 16492                    -- Blood Craze
# Get hit by non-crits
# With X% resilience, non-crits should have X% chance to proc Blood Craze
```

**#22068 - Rogue Combo Point Visual:**
```
# On Rogue with Seal Fate + Relentless Strikes:
.learn 14195                    -- Seal Fate
.learn 14179                    -- Relentless Strikes (5/5)
.learn 14177                    -- Cold Blood
# Build 4-5 combo points, use Cold Blood + Eviscerate
# Watch combo point display - should reset correctly after proc
```

**#19807 - Priest T5 DPS Set Bonus:**
```
.level 69
.learn all my spells
.learn all my talents
.additem set 666                -- T5 Shadow Priest set
.go creature id 32667           -- Spawn dummy
# Cast SW:Pain, then Mind Flay
# Sadist proc should NOT be consumed by Mind Flay tick
# It should wait for next spell CAST
```

**#11311 - Retribution Aura Proc:**
```
.learn 27150                    -- Retribution Aura
.tele orgrimmar                 -- Go to high-level guards
# Let guards hit you
# Ret aura should ALWAYS hit when triggered (not miss)
```

**#24116 - Flametongue Ranking:**
```
# On Enhancement Shaman:
.learn 58790                    -- Flametongue Weapon R10
.learn 58789                    -- Flametongue Weapon R9
# Apply R9 on MH, R10 on OH (or vice versa)
# Attack training dummy - BOTH should proc, not just lower rank
```

**#12678 - Buff Instance Removal:**
```
# Have two Druids cast Rejuvenation on yourself
# Right-click to remove ONE Rejuvenation buff
# Verify: Only ONE instance removed, not both
```

**#23326 - Thunderstorm Clearcasting:**
```
# On Elemental Shaman with Elemental Focus talent:
.learn 30675                    -- Elemental Focus (Clearcasting)
.learn 59159                    -- Thunderstorm
# Gather mobs, cast Thunderstorm
# If Thunderstorm crits, it should grant Clearcasting buff
```

**#22279 - Righteous Weapon Coating:**
```
.additem 34539                  -- Righteous Weapon Coating
# On Hunter, apply coating to ranged weapon
# Ranged auto attacks should proc the holy damage
# Currently only works on melee
```

**#9400 - Engulfing Shadows (Blade of Eternal Darkness):**
```
.additem 17780                  -- Blade of Eternal Darkness
# Cast direct damage spells repeatedly
# The 100 shadow damage proc SHOULD be able to crit for 200
# Currently never crits
```

**#19793 - Darkmoon Card: Crusade:**
```
.additem 31856                  -- Darkmoon Card: Crusade
# On Paladin, equip trinket
# Use Judgment (holy spell) - should give SPELL POWER stacks
# Currently gives Attack Power instead for some classes
```

**#24146 - Seal of Command + Ravager Bladestorm:**
```
.additem 7717                   -- Ravager axe
.learn 20375                    -- Seal of Command
.setskill 172 450 450           -- 2H Axe skill
# Trigger Ravager's Bladestorm proc (9632)
# Bladestorm hits should trigger Seal of Command
# Currently no on-hit effects during Bladestorm
```

**#12115 - Replenishment Threat:**
```
# On Paladin with Judgements of the Wise:
.learn 31878                    -- Judgements of the Wise
# Cast Judgment to proc Replenishment
# Replenishment mana restore should NOT generate threat
# Currently causes aggro issues
```

**#11410 - Invulnerable Mail Proc:**
```
.additem 12641                  -- Invulnerable Mail
# Equip, get hit until Self Invulnerability procs
# While proc active, melee SPELLS (Sinister Strike, etc) should be blocked
# Currently only blocks auto attacks
```

**#4276 - Goregek's Endurance:**
```
.additem 38619                  -- Goregek's Shackles
.go xyz 5338.44 4685.81 -137.43 571
# Summon Goregek pet
# When YOU deal damage, YOU should NOT be healed
# Only Goregek should heal when Goregek deals damage
```

**#12003 - Thunderfury Proc Threat:**
```
.additem 19019                  -- Thunderfury
# Attack mob with Thunderfury equipped
# The chain lightning proc should generate correct threat
# Verify threat values match retail (high threat proc)
```

**#22427 - Cleave + Sweeping Strikes:**
```
# On Arms Warrior:
.learn 12328                    -- Sweeping Strikes
# Target 2+ enemies
# Use Sweeping Strikes, then Cleave
# Should consume 2 SS charges (one per Cleave target)
# Secondary target's hit should sweep back to primary
```

**#17564 - T5 Crystalforge 4-Set (Paladin):**
```
.additem 30134 30135 30136 30137
# 30134 - Chestpiece, 30135 - Gauntlets, 30136 - Greathelm, 30137 - Leggings
# Cast Holy Light repeatedly
# 4-set bonus: Holy Light should have chance to make next Flash of Light instant
```

**#18324 - Executioner Enchant Refresh:**
```
.additem 38948                  -- Scroll of Enchant Weapon - Executioner
# Apply to weapon, attack training dummy
# When proc refreshes, duration should reset to full
# Currently duration doesn't refresh on re-proc
```

**#10993 - Dislodged Foreign Object:**
```
.additem 50353                  -- Dislodged Foreign Object (Normal)
# or .additem 50348             -- Dislodged Foreign Object (Heroic)
# Equip, cast spells
# Should proc spell power buff on spell cast
# Currently proc never triggers
```

---

## Coverage Gap Tests

These tests verify proc system permutations that aren't covered by other tests.

### BLOCK Procs (HitMask=0x40)

**Shield Block Damage Proc (12169):**
```
# On Protection Warrior:
.learn 12169                    -- Shield Block talent (if missing)
.learn 12164                    -- Damage Shield (assumed)
# Equip shield, face target
# Block incoming attacks
```
- [x] Shield Block increases block chance
- [x] Damage Shield procs on successful blocks
- [x] Block value affects proc damage

**Holy Shield (20925):**
```
# On Protection Paladin:
.learn 48952                    -- Holy Shield (max rank)
.additem 50729                  -- Icecrown Glacial Wall (shield)
# Equip shield, then CAST Holy Shield (not .aura - it's a cast spell!)
.cast 48952                     -- Holy Shield
# Get hit by melee attacks from hostile mob
```
- [x] Procs holy damage when blocking
- [x] 8 charges consumed on blocks
- [x] Damage scales with spell power

**Note:** Holy Shield is a CAST spell that applies a buff, not a passive aura.

**Shield Spike Items:**
```
.additem 23530                  -- Felsteel Shield Spike
.setskill 164 450 450           -- Max Blacksmithing to apply
# Apply to shield, block attacks
```
- [x] Deals damage to attacker on block
- [x] Different spike tiers have different damage

---

### Crit-Only Procs (HitMask=0x2)

**Blood Craze (16487-16492):**
```
# On Arms/Fury Warrior:
.learn 16492                    -- Blood Craze Rank 3
# Get hit by crits from a strong enemy
```
- [x] Only procs when taking critical hits
- [x] Does NOT proc on normal hits
- [x] Regenerates 1/2/3% health over 6 sec

**Focused Will (45234-45243):**
```
# On Discipline Priest:
.learn 45243                    -- Focused Will Rank 3
# Get hit by crits
```
- [x] Only procs on taking critical damage
- [x] Reduces damage taken by 2/3/4%
- [x] Increases healing received

---

### Resilience Crit-Victim Interaction

**Note:** With resilience, non-crits may have a chance to proc crit-only abilities.

```
# On class with crit-victim talent (Blood Craze, Eye for an Eye):
.learn 16492                    -- Blood Craze
# Equip PvP gear with resilience
# With X% resilience, non-crits have X% chance to "count as crit"
```
- [x] Resilience affects crit-victim proc chance
- [x] At 50% resilience, 50% of non-crits can proc

---

## Comprehensive Spell Proc Tests - Death Knight (Untested)

### Death Strike (45469)
**Proc Config:** `SpellFamilyMask0=0x10`, `ProcFlags=0x10` (DONE_SPELL_MELEE), `SpellPhaseMask=0x2` (HIT)
**Why:** Tests Death Strike's proc configuration for triggering other abilities.

**Test Steps:**
```
.go creature id 32666              -- Training Dummy
.cast 49998                        -- Death Strike
```
- [x] Death Strike hits target
- [x] Triggers any "on Death Strike hit" procs correctly
- [x] Procs Blood Rune refresh mechanics

---

### Chill of the Grave (49149)
**Proc Config:** `SpellFamilyMask0=0x6`, `SpellFamilyMask1=0x131076` (Frost Strike, Howling Blast, Icy Touch, Obliterate), `SpellPhaseMask=0x2`
**Why:** Tests Runic Power generation on Frost/Unholy ability hits.

**Test Steps:**
```
.learn 49149                       -- Chill of the Grave Rank 1 (5 RP)
.learn 50115                       -- Chill of the Grave Rank 2 (10 RP)
.go creature id 32666
# Note current Runic Power
.cast 45477                        -- Icy Touch
```
- [x] Generates 5/10 Runic Power on Icy Touch
- [x] Generates RP on Frost Strike
- [x] Generates RP on Howling Blast
- [x] Generates RP on Obliterate

---

### Reaping (49208)
**Proc Config:** `SpellFamilyMask0=0x400000`, `SpellFamilyMask1=0x10000` (Blood Strike, Pestilence), `SpellPhaseMask=0x2`, `Cooldown=100`
**Why:** Tests Blood Rune conversion to Death Rune on Blood Strike/Pestilence.

**Test Steps:**
```
.learn 49208                       -- Reaping Rank 1
.learn 56835                       -- Reaping Rank 2
.learn 56836                       -- Reaping Rank 3
.go creature id 32666
# Use Blood Strike
.cast 45902                        -- Blood Strike
```
- [x] Blood Rune converts to Death Rune on Blood Strike
- [x] Also procs on Pestilence
- [x] 33/66/100% chance per rank
- [x] 100ms internal cooldown prevents double-proc

---

### Dirge (49223)
**Proc Config:** `SpellFamilyMask0=0x11`, `SpellFamilyMask1=0x8020000` (Death Strike, Obliterate, Scourge Strike, Plague Strike), `SpellPhaseMask=0x2`
**Why:** Tests Runic Power generation from strike abilities.

**Test Steps:**
```
.learn 49223                       -- Dirge Rank 1 (5 RP)
.learn 49599                       -- Dirge Rank 2 (10 RP)
.go creature id 32666
.cast 49998                        -- Death Strike
.cast 49020                        -- Obliterate
.cast 55090                        -- Scourge Strike
.cast 45462                        -- Plague Strike
```
- [x] Grants 5/10 extra Runic Power on Death Strike
- [x] Grants RP on Obliterate
- [x] Grants RP on Scourge Strike
- [x] Grants RP on Plague Strike

---

### Deathchill (49796)
**Proc Config:** `SpellFamilyMask0=0x2`, `SpellFamilyMask1=0x20006` (Icy Touch, Howling Blast, Frost Strike, Obliterate), `SpellPhaseMask=0x4` (FINISH), `AttributesMask=0x8` (REQ_MANA_COST)
**Why:** Tests single-charge buff consumed on Frost ability cast.

**Test Steps:**
```
.aura 49796                        -- Apply Deathchill buff
.cast 45477                        -- Icy Touch (should consume)
```
- [ ] Guarantees next Icy Touch/Howling Blast/Frost Strike/Obliterate crits
- [ ] Buff consumed on ability FINISH (not on cast start)
- [ ] Only one ability benefits from the buff

---

### Icy Talons (50880)
**Proc Config:** `SpellFamilyMask1=0x4000000` (Frost Fever), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests melee haste buff proc when Frost Fever is applied.

**Test Steps:**
```
.learn 50880                       -- Icy Talons Rank 1 (4%)
.learn 50884                       -- Icy Talons Rank 2 (8%)
.learn 50885                       -- Icy Talons Rank 3 (12%)
.learn 50886                       -- Icy Talons Rank 4 (16%)
.learn 50887                       -- Icy Talons Rank 5 (20%)
.go creature id 32666
.cast 45477                        -- Icy Touch (applies Frost Fever)
```
- [ ] Icy Talons buff appears after applying Frost Fever
- [ ] 4/8/12/16/20% melee haste increase per rank
- [ ] TRIGGERED_CAN_PROC means triggered applications also proc it

---

### Cinderglacier (53386)
**Proc Config:** `SpellFamilyMask0=0x821000A7`, `SpellFamilyMask1=0x1BF`, `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests Runeforge enchant proc that boosts next 2 attacks.

**Test Steps:**
```
# Apply Cinderglacier runeforge to weapon (or use .aura 53386)
.aura 53386                        -- Cinderglacier buff
.go creature id 32666
.cast 49998                        -- Death Strike
.cast 49020                        -- Obliterate
```
- [ ] Boosts Shadow/Frost damage of next 2 strikes by 20%
- [ ] Consumed after 2 hits
- [ ] Procs from most DK damaging abilities

---

### Blood of the North (54639)
**Proc Config:** `SpellFamilyMask0=0x400000`, `SpellFamilyMask1=0x10000` (Blood Strike, Obliterate), `SpellPhaseMask=0x2`, `Cooldown=100`
**Why:** Tests Blood Rune → Death Rune conversion on Blood Strike and Obliterate.

**Test Steps:**
```
.learn 54639                       -- Blood of the North Rank 1 (30%)
.learn 54638                       -- Blood of the North Rank 2 (60%)
.learn 54637                       -- Blood of the North Rank 3 (100%)
.go creature id 32666
.cast 45902                        -- Blood Strike
```
- [ ] 30/60/100% chance to convert Blood Rune to Death Rune
- [ ] Procs on Blood Strike hit
- [ ] Procs on Obliterate hit
- [ ] 100ms ICD prevents double-proc issues

---

### Desecration (55666)
**Proc Config:** `SpellFamilyMask0=0x1`, `SpellFamilyMask1=0x8000000` (Plague Strike, Scourge Strike), `SpellPhaseMask=0x2`
**Why:** Tests ground effect slow zone proc from Plague Strike/Scourge Strike.

**Test Steps:**
```
.learn 55666                       -- Desecration Rank 1 (25% slow)
.learn 55667                       -- Desecration Rank 2 (50% slow)
.go creature id 32666
.cast 45462                        -- Plague Strike
.cast 55090                        -- Scourge Strike
```
- [ ] Desecrated Ground appears under target
- [ ] 25%/50% movement speed reduction per rank
- [ ] Procs from both Plague Strike and Scourge Strike
- [ ] Ground effect lasts 12 seconds

---

### Rune Strike Proc (56817)
**Proc Config:** `SpellFamilyMask1=0x20000000` (Rune Strike), `SpellPhaseMask=0x2`
**Why:** Tests internal Rune Strike proc configuration.

**Test Steps:**
```
# Rune Strike is only usable after dodging/parrying
.go creature id 32666
# Get attacked, dodge/parry an attack
.cast 56815                        -- Rune Strike
```
- [ ] Rune Strike proc configuration validates correctly
- [ ] Only usable after dodge/parry event

---

### Desolation (66799)
**Proc Config:** `SpellFamilyMask0=0x400000` (Blood Strike), `SpellPhaseMask=0x2`
**Why:** Tests damage buff proc from Blood Strike.

**Test Steps:**
```
.learn 66799                       -- Desolation Rank 1 (1% damage)
.learn 66800                       -- Desolation Rank 2 (2% damage)
.learn 66801                       -- Desolation Rank 3 (3% damage)
.learn 66802                       -- Desolation Rank 4 (4% damage)
.learn 66803                       -- Desolation Rank 5 (5% damage)
.go creature id 32666
.cast 45902                        -- Blood Strike
```
- [ ] Desolation buff appears after Blood Strike
- [ ] 1/2/3/4/5% damage increase per rank
- [ ] 20 second duration

---

### Glyph of Heart Strike (58616)
**Proc Config:** `SpellFamilyMask0=0x1000000` (Heart Strike), `SpellPhaseMask=0x2`
**Why:** Tests glyph adding snare to Heart Strike.

**Test Steps:**
```
.additem 43534                     -- Glyph of Heart Strike (apply glyph)
.learn 55050                       -- Heart Strike
.go creature id 32666
.cast 55050                        -- Heart Strike
```
- [ ] Applies 50% movement speed reduction
- [ ] Snare lasts 10 seconds
- [ ] Only applies to primary target

---

### Glyph of Chains of Ice (58620)
**Proc Config:** `SpellFamilyMask0=0x4` (Chains of Ice), `SpellPhaseMask=0x2`
**Why:** Tests glyph adding damage to Chains of Ice.

**Test Steps:**
```
.additem 43537                     -- Glyph of Chains of Ice (apply glyph)
.go creature id 32666
.cast 45524                        -- Chains of Ice
```
- [ ] Deals additional Frost damage
- [ ] Damage based on AP

---

### Glyph of Death's Embrace (58677)
**Proc Config:** `SpellFamilyMask0=0x2000` (Death Coil), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests glyph healing increase when healing self/allied undead.

**Test Steps:**
```
.additem 43539                     -- Glyph of Death's Embrace (apply glyph)
# Summon ghoul
.cast 46584                        -- Raise Dead
.cast 47541                        -- Death Coil on ghoul (heals it)
```
- [ ] Healing Death Coil on ghoul heals 20% more
- [ ] Also applies to healing self as Lichborne
- [ ] Only affects HEAL type, not damage

---

### Glyph of Rune Tap (59327)
**Proc Config:** `SpellFamilyMask0=0x8000000` (Rune Tap), `SpellPhaseMask=0x2`
**Why:** Tests glyph converting single-target heal to party heal.

**Test Steps:**
```
.additem 43825                     -- Glyph of Rune Tap (apply glyph)
.learn 48982                       -- Rune Tap
# Be in party with injured members
.cast 48982                        -- Rune Tap
```
- [ ] Heals party members in addition to self
- [ ] Party heals for 5% of their max HP
- [ ] 10 yard range

---

### Glyph of Howling Blast (63335)
**Proc Config:** `SpellFamilyMask1=0x2` (Howling Blast), `SpellPhaseMask=0x2`
**Why:** Tests glyph adding Frost Fever to Howling Blast targets.

**Test Steps:**
```
.additem 45806                     -- Glyph of Howling Blast (apply glyph)
.learn 49184                       -- Howling Blast
.go creature id 32666
.cast 49184                        -- Howling Blast
```
- [ ] Howling Blast now applies Frost Fever
- [ ] Applies to all targets hit
- [ ] No duration reduction on applied Frost Fever

---

### Oblit/Scourge Strike Runic Power Up (60132)
**Proc Config:** `SpellFamilyMask0=0x10`, `SpellFamilyMask1=0x8020000` (Obliterate, Scourge Strike, Death Strike), `SpellPhaseMask=0x2`
**Why:** Tests set bonus Runic Power increase on strike abilities.

**Test Steps:**
```
# Source: Unknown set bonus - investigate which set
.go creature id 32666
.cast 49020                        -- Obliterate
.cast 55090                        -- Scourge Strike
```
- [ ] Generates extra Runic Power on Obliterate
- [ ] Generates extra RP on Scourge Strike
- [ ] Identify which set bonus this is from

---

### Sigil of Haunted Dreams (60826)
**Proc Config:** `SpellFamilyMask0=0x1400000` (Blood Strike, Heart Strike), `SpellPhaseMask=0x2`, `Cooldown=45000`
**Why:** Tests sigil proc that grants Crit Rating on Blood Strike/Heart Strike.

**Test Steps:**
```
.additem 40715                     -- Sigil of Haunted Dreams
# Equip in relic slot
.go creature id 32666
.cast 45902                        -- Blood Strike
.cast 55050                        -- Heart Strike
```
- [ ] Grants 173 Crit Rating for 10 sec
- [ ] 45 second internal cooldown
- [ ] Procs from Blood Strike or Heart Strike

---

### Icy Touch Defense Increase (62147)
**Proc Config:** `SpellFamilyMask0=0x2` (Icy Touch), `SpellPhaseMask=0x2`
**Why:** Tests defense rating increase proc from Icy Touch.

**Test Steps:**
```
# Part of a tank set bonus or item - identify source
.go creature id 32666
.cast 45477                        -- Icy Touch
```
- [ ] Grants Defense Rating on Icy Touch hit
- [ ] Identify which item/set grants this bonus

---

### Chains of Ice Frost Rune Refresh (62459)
**Proc Config:** `SpellFamilyMask0=0x4` (Chains of Ice), `SpellPhaseMask=0x2`
**Why:** Tests Frost Rune refresh proc from Chains of Ice.

**Test Steps:**
```
# Part of a set bonus - identify source
.go creature id 32666
.cast 45524                        -- Chains of Ice
```
- [ ] Refreshes Frost Rune on Chains of Ice
- [ ] Identify which set/item grants this

---

### Sigil of Deflection - T8 Tank Relic (64964)
**Proc Config:** `SpellFamilyMask1=0x20000000` (Rune Strike), `SpellPhaseMask=0x2`
**Why:** Tests Sigil of Deflection Rune Strike proc.

**Test Steps:**
```
.additem 45144                     -- Sigil of Deflection
# Equip sigil
# Get attacked until you dodge/parry
.cast 56815                        -- Rune Strike
```
- [ ] Procs on Rune Strike hit
- [ ] Grants Dodge Rating (check tooltip for value)
- [ ] Verify proc duration and stacking

---

### T9 Melee 2P Bonus (67115)
**Proc Config:** `SpellFamilyMask0=0x1400000` (Blood Strike, Heart Strike), `SpellPhaseMask=0x2`, `Cooldown=45000`
**Why:** Tests T9 2-piece DPS set bonus proc.

**Test Steps:**
```
# Need 2 pieces of Thassarian's/Koltira's DPS set:
.additem 48483                     -- Thassarian's Helmet of Triumph
.additem 48481                     -- Thassarian's Battleplate of Triumph
# Equip both pieces
.go creature id 32666
.cast 45902                        -- Blood Strike
.cast 55050                        -- Heart Strike
```
- [ ] Procs on Blood Strike or Heart Strike
- [ ] 45 second internal cooldown
- [ ] Verify buff granted (likely damage/AP increase)

---

### Sigil of Insolence - T9 Tank Relic (67381)
**Proc Config:** `SpellFamilyMask1=0x20000000` (Rune Strike), `SpellPhaseMask=0x2`, `Cooldown=10000`
**Why:** Tests Sigil of Insolence Rune Strike proc.

**Test Steps:**
```
.additem 47672                     -- Sigil of Insolence
# Equip sigil
# Get attacked until dodge/parry
.cast 56815                        -- Rune Strike
```
- [ ] Procs on Rune Strike hit
- [ ] 10 second internal cooldown
- [ ] Grants Dodge Rating

---

### Sigil of Virulence - T9 Melee Relic (67384)
**Proc Config:** `SpellFamilyMask0=0x10`, `SpellFamilyMask1=0x8020000` (Obliterate, Scourge Strike, Death Strike, Plague Strike), `SpellPhaseMask=0x2`, `Chance=80`, `Cooldown=10000`
**Why:** Tests Sigil of Virulence strike ability proc.

**Test Steps:**
```
.additem 47673                     -- Sigil of Virulence
# Equip sigil
.go creature id 32666
.cast 49020                        -- Obliterate
.cast 55090                        -- Scourge Strike
```
- [ ] 80% chance to proc on Obliterate/Scourge Strike/Death Strike/Plague Strike
- [ ] 10 second internal cooldown
- [ ] Grants Strength buff

---

### T10 Tank 4P Bonus (70652)
**Proc Config:** `SpellFamilyMask0=0x8` (Death and Decay), `SpellPhaseMask=0x2`
**Why:** Tests T10 4-piece Tank set bonus proc.

**Test Steps:**
```
# Need 4 pieces of Scourgelord Tank set:
.additem 50857                     -- Scourgelord Chestguard
.additem 50856                     -- Scourgelord Handguards
.additem 50855                     -- Scourgelord Faceguard
.additem 50854                     -- Scourgelord Legguards
# Equip all 4
.go creature id 32666
.cast 43265                        -- Death and Decay
```
- [ ] Death and Decay grants bonus (damage reduction?)
- [ ] Verify what the 4P bonus actually does

---

### T10 Melee 4P Bonus (70656)
**Proc Config:** `SpellPhaseMask=0x1` (CAST)
**Why:** Tests T10 4-piece DPS set bonus proc.

**Test Steps:**
```
# Need 4 pieces of Scourgelord DPS set:
.additem 50094                     -- Scourgelord Battleplate
.additem 50095                     -- Scourgelord Gauntlets
.additem 50096                     -- Scourgelord Helmet
.additem 50097                     -- Scourgelord Legplates
# Equip all 4
# Use abilities
```
- [ ] Procs on CAST phase (immediate when spell starts)
- [ ] Verify what bonus is granted

---

### Sigil of the Hanged Man - T10 DPS Relic (71226)
**Proc Config:** `SpellFamilyMask0=0x10`, `SpellFamilyMask1=0x8020000` (Obliterate, Scourge Strike, Death Strike), `SpellPhaseMask=0x2`
**Why:** Tests T10 DPS Sigil proc.

**Test Steps:**
```
.additem 50459                     -- Sigil of the Hanged Man
# Equip sigil
.go creature id 32666
.cast 49020                        -- Obliterate
.cast 55090                        -- Scourge Strike
.cast 49998                        -- Death Strike
```
- [ ] Procs on Obliterate/Scourge Strike/Death Strike
- [ ] Grants Strength buff (check tooltip)
- [ ] Verify duration and stacking behavior

---

### Sigil of the Bone Gryphon - T10 Tank Relic (71228)
**Proc Config:** `SpellFamilyMask1=0x20000000` (Rune Strike), `SpellPhaseMask=0x2`
**Why:** Tests T10 Tank Sigil Rune Strike proc.

**Test Steps:**
```
.additem 50462                     -- Sigil of the Bone Gryphon
# Equip sigil
# Get attacked until dodge/parry
.cast 56815                        -- Rune Strike
```
- [ ] Procs on Rune Strike hit
- [ ] Grants Dodge Rating (check tooltip)
- [ ] Verify duration and stacking

---

## Comprehensive Spell Proc Tests - Druid (Untested)

### Clearcasting (16870)
**Proc Config:** `SpellFamilyMask0=0xE3FFFF`, `SpellFamilyMask1=0x78FCFD3`, `SpellFamilyMask2=0x40400`, `SpellPhaseMask=0x1` (CAST), `AttributesMask=0xC` (REQ_SPELLMOD|REQ_MANA_COST)
**Why:** Tests Omen of Clarity proc giving free cast of next ability.

**Test Steps:**
```
.learn 16864                       -- Omen of Clarity
.aura 16870                        -- Force Clearcasting buff
.go creature id 32666
.cast 5176                         -- Wrath (should be free)
```
- [ ] Clearcasting consumed on CAST phase (not hit)
- [ ] REQ_MANA_COST means only abilities with mana cost consume it
- [ ] Works with most Druid spells

---

### Nature's Grace (16880)
**Proc Config:** `SchoolMask=72` (Nature+Arcane), `SpellFamilyMask0=0x67`, `SpellFamilyMask1=0x3800002`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests spell haste buff proc on Nature/Arcane spell crits.

**Test Steps:**
```
.learn 16880                       -- Nature's Grace Rank 1
.learn 61345                       -- Nature's Grace Rank 2
.learn 61346                       -- Nature's Grace Rank 3
.go creature id 32666
.cast 2912                         -- Starfire (try to crit)
```
- [ ] Procs only on Nature/Arcane spell crits
- [ ] Grants 7/14/20% spell haste per rank
- [ ] Only procs from Starfire, Wrath, Moonfire, Insect Swarm

---

### Blood Frenzy (16952)
**Proc Config:** `SpellFamilyMask0=0x38F00`, `SpellFamilyMask1=0x400`, `SpellFamilyMask2=0x40000`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Cat Form crit proc generating extra combo points.

**Test Steps:**
```
.learn 16952                       -- Blood Frenzy Rank 1
.learn 16954                       -- Blood Frenzy Rank 2
.morph 8571                        -- Cat Form appearance
.go creature id 32666
.cast 1082                         -- Claw (crit)
```
- [ ] Grants 50/100% chance to gain 1 extra combo point on crit
- [ ] Works with: Claw, Rake, Mangle, Shred, Ravage
- [ ] Only in Cat Form

---

### Intensity (17106)
**Proc Config:** `SpellFamilyMask0=0x80000` (Enrage), `SpellPhaseMask=0x2`
**Why:** Tests Enrage proc allowing rage generation in Bear Form.

**Test Steps:**
```
.learn 17106                       -- Intensity Rank 1
.learn 17107                       -- Intensity Rank 2
.learn 17108                       -- Intensity Rank 3
.morph 29414                       -- Bear Form appearance
# Cast Enrage, take damage
```
- [ ] 17/33/50% of mana regeneration continues while casting
- [ ] Affects Bear Form Enrage rage generation

---

### Nature's Swiftness (17116)
**Proc Config:** `SpellFamilyMask0=0x10000061`, `SpellFamilyMask1=0x2000020`, `SpellFamilyMask2=0x8000`, `SpellTypeMask=0x7`, `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests single-charge instant cast buff consumed on Nature spell.

**Test Steps:**
```
.aura 17116                        -- Apply Nature's Swiftness
.cast 26978                        -- Healing Touch
```
- [ ] Makes next Nature spell instant
- [ ] Consumed on CAST phase
- [ ] Only one spell benefits

---

### Symbols of Unending Life (26107)
**Proc Config:** `SpellFamilyMask0=0x800000`, `SpellFamilyMask1=0x10000080`, `SpellPhaseMask=0x2`, `HitMask=0x74` (MISS|DODGE|PARRY|BLOCK)
**Why:** Tests finisher proc on hit avoidance (set bonus).

**Test Steps:**
```
# Need T6 set bonus - identify pieces
.go creature id 32666
.cast 22568                        -- Ferocious Bite
# Miss/Dodge/Parry should still proc bonus
```
- [ ] Procs even when finisher misses/dodged/parried/blocked
- [ ] Grants energy return or other bonus

---

### Rejuvenation (28716)
**Proc Config:** `SpellFamilyMask0=0x10`, `ProcFlags=0x40000` (DONE_PERIODIC), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Rejuvenation HoT tick proc for set bonuses.

**Test Steps:**
```
# T4/T5 set bonus - need set pieces
.cast 26982                        -- Rejuvenation
# Watch HoT ticks
```
- [ ] Procs on each Rejuvenation tick
- [ ] Used by tier set bonuses for proc effects

---

### Healing Touch (28719)
**Proc Config:** `SpellFamilyMask0=0x20`, `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Healing Touch crit proc for set bonuses.

**Test Steps:**
```
# Need healing set pieces
.cast 26978                        -- Healing Touch (crit)
```
- [ ] Procs on Healing Touch critical heal
- [ ] Used by tier set bonuses

---

### Regrowth (28744)
**Proc Config:** `SpellFamilyMask0=0x40`, `ProcFlags=0x44000` (DONE_PERIODIC|DONE_SPELL_MAGIC_POS), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Regrowth proc for set bonuses (both direct and HoT).

**Test Steps:**
```
# Need healing set pieces
.cast 26980                        -- Regrowth
```
- [ ] Procs on Regrowth direct heal
- [ ] Procs on Regrowth HoT ticks

---

### Healing Touch Refund (28847)
**Proc Config:** `SpellFamilyMask0=0x20`, `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Healing Touch proc that refunds mana.

**Test Steps:**
```
# Need set bonus with this effect
.cast 26978                        -- Healing Touch
```
- [ ] Chance to refund mana on Healing Touch
- [ ] Identify which set grants this bonus

---

### Mana Restore (37288)
**Proc Config:** `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests generic heal proc that restores mana.

**Test Steps:**
```
# Need set bonus or item with this proc
.cast 331                          -- Any healing spell
```
- [ ] Restores mana on heal
- [ ] Identify source item/set

---

### Mana Restore - Damage (37295)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests generic damage proc that restores mana.

**Test Steps:**
```
# Need set bonus or item with this proc
.cast 5176                         -- Wrath
```
- [ ] Restores mana on damage
- [ ] Identify source item/set

---

### Druid T6 Trinket (40442)
**Proc Config:** `SpellFamilyMask0=0x14`, `SpellFamilyMask1=0x440`, `SpellTypeMask=0x7`, `SpellPhaseMask=0x1`
**Why:** Tests T6 trinket proc on Rejuvenation/Lifebloom/Wild Growth.

**Test Steps:**
```
# Need T6 trinket - identify item
.cast 26982                        -- Rejuvenation
```
- [ ] Procs on Rejuvenation cast
- [ ] Procs on Lifebloom cast
- [ ] Procs on Wild Growth cast

---

### Primal Instinct (43737)
**Proc Config:** `SpellFamilyMask1=0x440` (Lifebloom, Wild Growth), `SpellPhaseMask=0x2`, `Cooldown=10000`
**Why:** Tests Idol proc on Lifebloom/Wild Growth ticks.

**Test Steps:**
```
# Need Idol with this proc
.cast 33763                        -- Lifebloom
```
- [ ] Procs from Lifebloom or Wild Growth
- [ ] 10 second internal cooldown

---

### Lunar Grace (43739)
**Proc Config:** `SpellFamilyMask0=0x2` (Moonfire), `SpellPhaseMask=0x2`
**Why:** Tests Idol proc on Moonfire.

**Test Steps:**
```
# Need Idol with this proc
.go creature id 32666
.cast 8921                         -- Moonfire
```
- [ ] Procs on Moonfire damage/application
- [ ] Identify which Idol grants this

---

### Moonkin Starfire Bonus (46832)
**Proc Config:** `SpellFamilyMask0=0x1` (Starfire), `SpellPhaseMask=0x2`, `Cooldown=15000`
**Why:** Tests Starfire proc with 15sec ICD.

**Test Steps:**
```
# Need set bonus with this effect
.go creature id 32666
.cast 2912                         -- Starfire
```
- [ ] Procs on Starfire hit
- [ ] 15 second internal cooldown

---

### Snap and Snarl (52020)
**Proc Config:** `SpellFamilyMask0=0x8000`, `SpellFamilyMask1=0x100000` (Shred, Lacerate), `SpellPhaseMask=0x2`, `Cooldown=10000`
**Why:** Tests Feral Idol proc on Shred/Lacerate.

**Test Steps:**
```
# Need Idol with this proc
.morph 8571                        -- Cat Form appearance
.go creature id 32666
.cast 48572                        -- Shred
```
- [ ] Procs on Shred hit
- [ ] Procs on Lacerate hit
- [ ] 10 second internal cooldown

---

### Glyph of Shred (54815)
**Proc Config:** `SpellFamilyMask0=0x8000` (Shred), `ProcFlags=0x10` (DONE_SPELL_MELEE), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests glyph extending Rip duration on Shred.

**Test Steps:**
```
.additem 40901                     -- Glyph of Shred (apply glyph)
.morph 8571                        -- Cat Form appearance
.go creature id 32666
# Apply Rip first, then Shred
.aura 49800                        -- Rip on target
.cast 48572                        -- Shred
```
- [ ] Each Shred extends Rip by 2 seconds
- [ ] Maximum extension of 6 seconds (3 Shreds)

---

### Glyph of Barkskin (63057)
**Proc Config:** `SpellFamilyMask1=0x40000` (Barkskin), `ProcFlags=0x4000` (DONE_SPELL_MAGIC_POS), `SpellPhaseMask=0x2`
**Why:** Tests glyph adding crit reduction to Barkskin.

**Test Steps:**
```
.additem 45623                     -- Glyph of Barkskin (apply glyph)
.cast 22812                        -- Barkskin
# Take damage from enemies
```
- [ ] Reduces chance to be crit by 25%
- [ ] Effect active during Barkskin duration

---

### Gladiator's Idol of Steadfastness Procs (60710-60726)
**Proc Config:** `SpellFamilyMask0=0x2` (Moonfire), `SpellPhaseMask=0x2`, various cooldowns
**Why:** Tests PvP Idol proc on Moonfire.

**Test Steps:**
```
.additem 42575                     -- Savage Gladiator's Idol of Steadfastness
# or other tier:
# 42582 - Hateful, 42583 - Deadly, 42584 - Furious, 42585 - Relentless
.go creature id 32666
.cast 8921                         -- Moonfire
```
- [ ] Procs Resilience/Spell Power buff on Moonfire
- [ ] Check cooldown per tier (varies)

---

### Item - Druid T8 Feral 2P Bonus (64752)
**Proc Config:** `SpellFamilyMask0=0x1000`, `SpellFamilyMask1=0x100`, `SpellFamilyMask2=0x200000` (Rake, Mangle, Savage Roar), `SpellPhaseMask=0x2`, `Cooldown=15000`
**Why:** Tests T8 Feral 2P bonus proc.

**Test Steps:**
```
# Need 2 pieces T8 Feral:
.additem 46158                     -- Valorous Nightsong Headguard
.additem 46161                     -- Valorous Nightsong Raiment
# Equip both
.morph 8571                        -- Cat Form
.go creature id 32666
.cast 48574                        -- Rake
```
- [ ] Procs on Rake/Mangle/Savage Roar
- [ ] 15 second internal cooldown
- [ ] Verify buff granted

---

### Elune's Wrath (64823)
**Proc Config:** `SpellFamilyMask0=0x4` (Starfire), `ProcFlags=0x10000` (DONE_SPELL_MAGIC_NEG), `SpellTypeMask=0x1`, `SpellPhaseMask=0x1`, `Charges=1`
**Why:** Tests Eclipse (Solar) proc giving instant Starfire.

**Test Steps:**
```
.aura 64823                        -- Apply Elune's Wrath buff
.go creature id 32666
.cast 2912                         -- Starfire (should be instant)
```
- [ ] One charge - consumed on Starfire cast
- [ ] Starfire is instant when buff active
- [ ] Part of Eclipse system

---

### Item - Druid T8 Balance 4P Bonus (64824)
**Proc Config:** `SpellFamilyMask0=0x200000` (Languish/Moonfire DoT), `SpellPhaseMask=0x2`
**Why:** Tests T8 Balance 4P proc on Languish.

**Test Steps:**
```
# Need 4 pieces T8 Balance:
.additem 46191                     -- Valorous Nightsong Cover (Helm)
.additem 46189                     -- Valorous Nightsong Robe (Chest)
.additem 46192                     -- Valorous Nightsong Mantle (Shoulders)
.additem 46186                     -- Valorous Nightsong Handguards (Gloves)
.go creature id 32666
# Cast Languish (T8 ability?)
```
- [ ] Procs on Languish hit
- [ ] Verify 4P bonus effect

---

### Item - Druid T8 Feral Relic (64952)
**Proc Config:** `SpellFamilyMask1=0x440` (Lifebloom, Wild Growth), `SpellPhaseMask=0x2`
**Why:** Tests T8 Feral Idol proc.

**Test Steps:**
```
.additem 45509                     -- Idol of the Corruptor
# Equip idol
.cast 33763                        -- Lifebloom
```
- [ ] Procs on Lifebloom or Wild Growth
- [ ] Check proc buff granted

---

### Item - Druid T9 Feral Relic (67353)
**Proc Config:** `SpellFamilyMask0=0x8000`, `SpellFamilyMask1=0x100280` (Lacerate, Swipe, Mangle, Shred), `SpellPhaseMask=0x2`, `Cooldown=8000`
**Why:** Tests T9 Feral Idol proc on feral abilities.

**Test Steps:**
```
.additem 47668                     -- Idol of Mutilation
# Equip idol
.morph 8571                        -- Cat Form
.go creature id 32666
.cast 48572                        -- Shred
```
- [ ] Procs on Shred, Mangle, Lacerate, or Swipe
- [ ] 8 second internal cooldown
- [ ] Grants Agility buff

---

### Item - Druid T9 Restoration Relic (67356)
**Proc Config:** `SchoolMask=8` (Nature), `SpellFamilyMask0=0x10` (Rejuvenation), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `Cooldown=5000`
**Why:** Tests T9 Restoration Idol proc on Rejuvenation.

**Test Steps:**
```
.additem 47671                     -- Idol of Flaring Growth
# Equip idol
.cast 26982                        -- Rejuvenation
```
- [ ] Procs on Rejuvenation ticks
- [ ] 5 second internal cooldown
- [ ] Only Nature school heals

---

### Item - Druid T9 Balance Relic (67361)
**Proc Config:** `SpellFamilyMask0=0x2` (Moonfire), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=6000`
**Why:** Tests T9 Balance Idol proc on Moonfire.

**Test Steps:**
```
.additem 47670                     -- Idol of Lunar Fury
# Equip idol
.go creature id 32666
.cast 8921                         -- Moonfire
```
- [ ] Procs on Moonfire damage
- [ ] 6 second internal cooldown
- [ ] Grants Spell Power buff

---

### Item - Druid T10 Restoration 4P Bonus (70664)
**Proc Config:** `SpellFamilyMask0=0x10` (Rejuvenation), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T10 Restoration 4P bonus proc on Rejuvenation.

**Test Steps:**
```
# Need 4 pieces T10 Resto (Lasherweave):
.additem 50106                     -- Lasherweave Helmet
.additem 50107                     -- Lasherweave Pauldrons
.additem 50108                     -- Lasherweave Raiment
.additem 50109                     -- Lasherweave Handgrips
# Equip all 4
.cast 26982                        -- Rejuvenation
```
- [ ] Procs on Rejuvenation ticks
- [ ] Verify 4P bonus effect

---

### Item - Druid T10 Balance 4P Bonus (70723)
**Proc Config:** `SpellFamilyMask0=0x5` (Starfire, Wrath), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests T10 Balance 4P bonus proc on crit.

**Test Steps:**
```
# Need 4 pieces T10 Balance (Lasherweave):
.additem 50819                     -- Sanctified Lasherweave Cover
.additem 50820                     -- Sanctified Lasherweave Mantle
.additem 50821                     -- Sanctified Lasherweave Vestment
.additem 50107                     -- Lasherweave Pauldrons
.go creature id 32666
.cast 2912                         -- Starfire (crit)
```
- [ ] Procs on Starfire or Wrath critical
- [ ] Grants Languish buff (DoT)

---

### Item - Druid T10 Feral Relic (71174)
**Proc Config:** `SchoolMask=1` (Physical), `SpellPhaseMask=0x2`
**Why:** Tests T10 Feral Idol proc on physical damage.

**Test Steps:**
```
.additem 50454                     -- Idol of the Black Willow
# Equip idol
.morph 8571                        -- Cat Form
.go creature id 32666
.cast 48574                        -- Rake
```
- [ ] Procs on physical damage (Rake, Lacerate)
- [ ] Grants Agility buff

---

### Item - Druid T10 Balance Relic (71176)
**Proc Config:** `SpellFamilyMask0=0x200002` (Moonfire, Insect Swarm), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`
**Why:** Tests T10 Balance Idol proc on DoT damage.

**Test Steps:**
```
.additem 50456                     -- Idol of the Lunar Eclipse
# Equip idol
.go creature id 32666
.cast 8921                         -- Moonfire
.cast 5570                         -- Insect Swarm
```
- [ ] Procs on Moonfire or Insect Swarm ticks
- [ ] Grants Spell Power buff

---

### Item - Druid T10 Restoration Relic (71178)
**Proc Config:** `SpellFamilyMask0=0x10` (Rejuvenation), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T10 Restoration Idol proc on Rejuvenation.

**Test Steps:**
```
.additem 50457                     -- Idol of the Crying Moon
# Equip idol
.cast 26982                        -- Rejuvenation
```
- [ ] Procs on Rejuvenation ticks
- [ ] Grants Spell Power buff

---

### Earth and Moon (48506)
**Proc Config:** `SpellFamilyMask0=0x5` (Starfire, Wrath), `SpellPhaseMask=0x2`
**Why:** Tests debuff application from Balance spells.

**Test Steps:**
```
.learn 48506                       -- Earth and Moon Rank 1
.learn 48510                       -- Earth and Moon Rank 2
.learn 48511                       -- Earth and Moon Rank 3
.go creature id 32666
.cast 5176                         -- Wrath
```
- [ ] Applies Earth and Moon debuff to target
- [ ] 4/9/13% spell damage increase on target
- [ ] Procs from Wrath and Starfire

---

### Living Seed (48496)
**Proc Config:** `SpellFamilyMask0=0x60`, `SpellFamilyMask1=0x2000002` (Heals), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests heal crit proc creating absorb seed.

**Test Steps:**
```
.learn 48496                       -- Living Seed Rank 1
.learn 48499                       -- Living Seed Rank 2
.learn 48500                       -- Living Seed Rank 3
# Heal a target critically
.cast 26978                        -- Healing Touch (crit)
```
- [ ] Creates Living Seed on heal crit
- [ ] Seed heals target when they take damage
- [ ] 30/60/100% of heal as seed value

---

### Infected Wounds (48483)
**Proc Config:** `SpellFamilyMask0=0x8800`, `SpellFamilyMask1=0x440` (Maul, Mangle, Shred, Maim), `SpellPhaseMask=0x2`
**Why:** Tests debuff proc from feral abilities.

**Test Steps:**
```
.learn 48483                       -- Infected Wounds Rank 1
.learn 48484                       -- Infected Wounds Rank 2
.learn 48485                       -- Infected Wounds Rank 3
.morph 29414                       -- Bear Form
.go creature id 32666
.cast 48564                        -- Mangle (Bear)
```
- [ ] Applies Infected Wounds debuff
- [ ] 10/20% movement speed reduction
- [ ] 6/12% attack speed reduction

---

## Comprehensive Spell Proc Tests - Hunter (Untested)

### Entrapment (19184)
**Proc Config:** `SpellFamilyMask0=0x10`, `SpellFamilyMask1=0x2000` (traps), `SpellPhaseMask=0x4` (FINISH), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests trap trigger proc that roots enemies.

**Test Steps:**
```
.learn 19184                       -- Entrapment Rank 1
.learn 19387                       -- Entrapment Rank 2
.learn 19388                       -- Entrapment Rank 3
.cast 13809                        -- Frost Trap
# Trigger trap with enemy
```
- [ ] Roots enemies in trap area
- [ ] 25/50/75% chance per rank
- [ ] Works with Frost Trap, Immolation Trap, Snake Trap

---

### Improved Mend Pet (19572)
**Proc Config:** `SpellFamilyMask0=0x800000` (Mend Pet), `ProcFlags=0x40000` (DONE_PERIODIC), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Mend Pet tick proc that dispels effects from pet.

**Test Steps:**
```
.learn 19572                       -- Improved Mend Pet Rank 1
.learn 19573                       -- Improved Mend Pet Rank 2
# Have pet with debuff
.cast 48990                        -- Mend Pet
```
- [ ] 25/50% chance per tick to dispel one harmful effect
- [ ] Works on curse, disease, magic, poison

---

### Arcane Infused (23721)
**Proc Config:** `SpellFamilyMask0=0x800` (Arcane Shot), `SpellPhaseMask=0x2`
**Why:** Tests Arcane Shot proc (set bonus).

**Test Steps:**
```
# Need Tier set with this bonus
.go creature id 32666
.cast 49045                        -- Arcane Shot
```
- [ ] Procs on Arcane Shot hit
- [ ] Identify which set grants this bonus

---

### Thrill of the Hunt (34497)
**Proc Config:** `SpellFamilyMask0=0x60800`, `SpellFamilyMask1=0x800001`, `SpellFamilyMask2=0x201`, `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests mana refund on shot crits.

**Test Steps:**
```
.learn 34497                       -- Thrill of the Hunt Rank 1
.learn 34498                       -- Thrill of the Hunt Rank 2
.learn 34499                       -- Thrill of the Hunt Rank 3
.go creature id 32666
.cast 49050                        -- Aimed Shot (crit)
```
- [ ] 33/66/100% chance on crit to refund 40% of base mana cost
- [ ] Works with: Arcane, Aimed, Multi, Steady, Explosive, Kill Shot, Chimera Shot

---

### Concussive Barrage (35100)
**Proc Config:** `SpellFamilyMask0=0x1000`, `SpellFamilyMask2=0x1` (Chimera Shot, Multi-Shot), `SpellPhaseMask=0x2`
**Why:** Tests Multi-Shot/Chimera proc that dazes targets.

**Test Steps:**
```
.learn 35100                       -- Concussive Barrage Rank 1
.learn 35102                       -- Concussive Barrage Rank 2
.go creature id 32666
.cast 49048                        -- Multi-Shot
```
- [ ] 50/100% chance to daze target
- [ ] Works with Multi-Shot and Chimera Shot
- [ ] Daze lasts 4 seconds

---

### Hunter T6 Trinket (40485)
**Proc Config:** `SpellFamilyMask1=0x1` (Steady Shot), `SpellPhaseMask=0x2`
**Why:** Tests T6 trinket proc on Steady Shot.

**Test Steps:**
```
# Need T6 trinket
.go creature id 32666
.cast 49052                        -- Steady Shot
```
- [ ] Procs on Steady Shot hit
- [ ] Identify trinket and bonus effect

---

### Savage Rend (50871)
**Proc Config:** `SpellFamilyMask1=0x40000000` (pet ability), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests pet crit proc for Savage Rend buff.

**Test Steps:**
```
# Have pet with Savage Rend ability
# Pet crits on target
```
- [ ] Pet crit grants Savage Rend buff
- [ ] Buff increases damage done

---

### Guard Dog (53178)
**Proc Config:** `SpellFamilyMask1=0x10000000` (Growl), `ProcFlags=0x10000` (DONE_SPELL_MAGIC_NEG), `SpellTypeMask=0x4`, `SpellPhaseMask=0x2`, `Chance=100`
**Why:** Tests pet Growl proc for extra threat.

**Test Steps:**
```
.learn 53178                       -- Guard Dog Rank 1
.learn 53179                       -- Guard Dog Rank 2
# Have pet use Growl
```
- [ ] Growl generates 10/20% more threat
- [ ] 100% chance to proc

---

### Wild Quiver (53215)
**Proc Config:** `SpellFamilyMask0=0x1` (Auto Shot), `SpellPhaseMask=0x2`
**Why:** Tests Auto Shot proc for extra shot.

**Test Steps:**
```
.learn 53215                       -- Wild Quiver Rank 1
.learn 53216                       -- Wild Quiver Rank 2
.learn 53217                       -- Wild Quiver Rank 3
.go creature id 32666
# Auto shot at target
```
- [ ] 4/8/12% chance for Auto Shot to fire extra Nature arrow
- [ ] Extra arrow deals 80% of normal damage

---

### Improved Steady Shot (53221)
**Proc Config:** `SpellFamilyMask1=0x1` (Steady Shot), `SpellPhaseMask=0x2`
**Why:** Tests Steady Shot proc for damage buff.

**Test Steps:**
```
.learn 53221                       -- Improved Steady Shot Rank 1
.learn 53222                       -- Improved Steady Shot Rank 2
.learn 53223                       -- Improved Steady Shot Rank 3
.go creature id 32666
.cast 49052                        -- Steady Shot
.cast 49052                        -- Steady Shot
```
- [ ] 5/10/15% chance on Steady Shot to buff next Arcane/Aimed/Chimera Shot
- [ ] Buff increases damage by 15%

---

### Rapid Recuperation (53228)
**Proc Config:** `SpellFamilyMask0=0x20`, `SpellFamilyMask1=0x1000000` (Rapid Fire, Rapid Killing), `SpellTypeMask=0x4`, `SpellPhaseMask=0x2`
**Why:** Tests mana regen during Rapid Fire.

**Test Steps:**
```
.learn 53228                       -- Rapid Recuperation Rank 1
.learn 53232                       -- Rapid Recuperation Rank 2
.cast 3045                         -- Rapid Fire
```
- [ ] 2/4% mana regen per 3 sec during Rapid Fire
- [ ] Also works with Rapid Killing buff

---

### Piercing Shots (53234)
**Proc Config:** `SpellFamilyMask0=0x20000`, `SpellFamilyMask1=0x1`, `SpellFamilyMask2=0x1` (Aimed, Steady, Chimera), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests DoT application on shot crits.

**Test Steps:**
```
.learn 53234                       -- Piercing Shots Rank 1
.learn 53237                       -- Piercing Shots Rank 2
.learn 53238                       -- Piercing Shots Rank 3
.go creature id 32666
.cast 49050                        -- Aimed Shot (crit)
```
- [ ] Applies bleed DoT on crit
- [ ] DoT = 10/20/30% of crit damage over 8 sec
- [ ] Works with Aimed Shot, Steady Shot, Chimera Shot

---

### Cobra Strikes (53256/53257)
**Proc Config:** `SpellFamilyMask0=0x800`, `SpellFamilyMask1=0x800001` (Arcane Shot, Kill Command, Steady Shot), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests hunter crit proc giving pet guaranteed crits.

**Test Steps:**
```
.learn 53256                       -- Cobra Strikes Rank 1
.learn 53259                       -- Cobra Strikes Rank 2
.learn 53260                       -- Cobra Strikes Rank 3
.go creature id 32666
.cast 49045                        -- Arcane Shot (crit)
```
- [ ] 5/10/15% chance on Arcane/Kill Command crit
- [ ] Pet's next 2 special abilities crit
- [ ] 53257 is the pet buff proc handler

---

### Hunting Party (53290)
**Proc Config:** `SpellFamilyMask0=0x800`, `SpellFamilyMask1=0x1`, `SpellFamilyMask2=0x200` (Arcane, Steady, Explosive Shot), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2`
**Why:** Tests mana/focus regen buff on crits.

**Test Steps:**
```
.learn 53290                       -- Hunting Party Rank 1
.learn 53291                       -- Hunting Party Rank 2
.learn 53292                       -- Hunting Party Rank 3
.go creature id 32666
.cast 49045                        -- Arcane Shot (crit)
```
- [ ] Procs on Arcane/Steady/Explosive crit
- [ ] Grants party 1/2/3% mana regen
- [ ] TRIGGERED_CAN_PROC flag set

---

### Lock and Load (56342)
**Proc Config:** `SpellFamilyMask0=0x18`, `SpellFamilyMask1=0x8000000`, `SpellFamilyMask2=0x24000` (traps, Black Arrow), `SpellPhaseMask=0x4` (FINISH), `AttributesMask=0x2`, `Cooldown=22000`
**Why:** Tests trap/Black Arrow proc for free Explosive Shots.

**Test Steps:**
```
.learn 56342                       -- Lock and Load Rank 1
.learn 56343                       -- Lock and Load Rank 2
.learn 56344                       -- Lock and Load Rank 3
.cast 13809                        -- Frost Trap
# Trigger trap
```
- [ ] Procs from trap triggers
- [ ] Procs from Black Arrow ticks
- [ ] Next 2 Explosive/Arcane Shots free and instant
- [ ] 22 second internal cooldown

---

### Glyph of Arcane Shot (56841)
**Proc Config:** `SpellFamilyMask0=0x800` (Arcane Shot), `ProcFlags=0x100` (TAKEN_RANGED_AUTO), `SpellPhaseMask=0x2`
**Why:** Tests glyph mana refund on Arcane Shot.

**Test Steps:**
```
.additem 42898                     -- Glyph of Arcane Shot (apply glyph)
.go creature id 32666
.cast 49045                        -- Arcane Shot
```
- [ ] Refunds 20% of mana cost on hit
- [ ] Only when target has Serpent Sting

---

### Glyph of Mend Pet (57870)
**Proc Config:** `SpellFamilyMask0=0x800000` (Mend Pet), `ProcFlags=0x40000` (DONE_PERIODIC), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests glyph happiness boost on Mend Pet.

**Test Steps:**
```
.additem 43350                     -- Glyph of Mend Pet (apply glyph)
.cast 48990                        -- Mend Pet
```
- [ ] Each Mend Pet tick increases pet happiness

---

### Silverback (62764)
**Proc Config:** `SpellFamilyMask1=0x10000000` (Growl), `ProcFlags=0x10000`, `SpellTypeMask=0x4`, `SpellPhaseMask=0x2`, `Chance=100`
**Why:** Tests pet Growl proc for health regen.

**Test Steps:**
```
.learn 62764                       -- Silverback Rank 1
.learn 62765                       -- Silverback Rank 2
# Have Gorilla pet use Growl
```
- [ ] Growl heals pet for 1/2% max health
- [ ] 100% proc chance

---

### Culling the Herd (61680-61681)
**Proc Config:** `SpellFamilyMask1=0x10000000` (pet specials), `SpellTypeMask=0x1`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests pet crit buff for hunter and pet.

**Test Steps:**
```
# Add pet spell directly to database (pet talents can't be learned via command):
# INSERT INTO pet_spell (guid, spell, active) VALUES (<pet_guid>, 61681, 193);
# Ensure GM invisibility is OFF (.gm visible on) or pet can't target hunter
# Have pet use Bite/Claw/Smack and crit target
```
- [x] Pet crit grants 1/2/3% damage buff
- [x] Buff applies to both hunter and pet
- [x] 10 second duration

---

### Glyph of Raptor Strike (63086)
**Proc Config:** `SpellFamilyMask2=0x10000` (Raptor Strike), `SpellPhaseMask=0x2`
**Why:** Tests glyph damage reduction on Raptor Strike.

**Test Steps:**
```
.additem 45735                     -- Glyph of Raptor Strike (apply glyph)
.go creature id 32666
.cast 48996                        -- Raptor Strike
```
- [ ] Reduces damage taken by 20% for 5 sec after Raptor Strike

---

### Item - Hunter T8 4P Bonus (64860)
**Proc Config:** `SpellFamilyMask1=0x1` (Steady Shot), `SpellPhaseMask=0x2`, `Cooldown=45000`
**Why:** Tests T8 4P Steady Shot proc.

**Test Steps:**
```
# Need 4 pieces T8 Hunter (Scourgestalker):
.additem 46143                     -- Scourgestalker Headpiece
.additem 46145                     -- Scourgestalker Spaulders
.additem 46141                     -- Scourgestalker Tunic
.additem 46144                     -- Scourgestalker Legguards
.go creature id 32666
.cast 49052                        -- Steady Shot
```
- [ ] Procs on Steady Shot
- [ ] 45 second internal cooldown
- [ ] Verify bonus granted

---

### Item - Hunter T10 2P Bonus (70727)
**Proc Config:** `SpellFamilyMask0=0x1` (Auto Shot), `SpellPhaseMask=0x2`
**Why:** Tests T10 2P Auto Shot proc.

**Test Steps:**
```
# Need 2 pieces T10 Hunter (Ahn'Kahar):
.additem 50388                     -- Ahn'Kahar Blood Hunter's Headpiece
.additem 50390                     -- Ahn'Kahar Blood Hunter's Tunic
.go creature id 32666
# Auto shot at target
```
- [ ] Procs on Auto Shot
- [ ] Verify 2P bonus effect

---

### Item - Hunter T10 4P Bonus (70730)
**Proc Config:** `SpellFamilyMask0=0x4000`, `SpellFamilyMask1=0x1000` (Serpent Sting, Wyvern Sting), `SpellPhaseMask=0x2`
**Why:** Tests T10 4P proc on stings.

**Test Steps:**
```
# Need 4 pieces T10 Hunter:
.additem 50388                     -- Ahn'Kahar Blood Hunter's Headpiece
.additem 50390                     -- Ahn'Kahar Blood Hunter's Tunic
.additem 50389                     -- Ahn'Kahar Blood Hunter's Spaulders
.additem 50386                     -- Ahn'Kahar Blood Hunter's Legguards
.go creature id 32666
.cast 49001                        -- Serpent Sting
```
- [ ] Procs on Serpent Sting or Wyvern Sting application
- [ ] Verify 4P bonus effect

---

## Mage Procs (SpellFamilyName = 3)

### Ignite (11119)
**Proc Config:** `SchoolMask=0x4` (Fire), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Ignite DoT application on Fire spell criticals.

**Test Steps:**
```
.learn 11119                       -- Ignite Rank 1 (8%)
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Ignite debuff applies on Fire spell critical
- [ ] DoT damage is 8/16/24/32/40% of crit damage over 4 sec per rank
- [ ] Does NOT proc on non-Fire damage
- [ ] Does NOT proc on non-critical hits

---

### Improved Scorch (11095)
**Proc Config:** `SpellFamilyMask0=0x10` (Scorch), `SpellPhaseMask=0x2`
**Why:** Tests Fire Vulnerability debuff application from Scorch.

**Test Steps:**
```
.learn 11095                       -- Improved Scorch Rank 1
.go creature id 32666
.cast 2948                         -- Scorch
```
- [ ] Fire Vulnerability debuff stacks on target after Scorch hits
- [ ] 33/66/100% chance per rank to apply stack
- [ ] Stacks up to 5 times for 15% increased Fire damage taken

---

### Winter's Chill (11180)
**Proc Config:** `SchoolMask=0x10` (Frost), `SpellPhaseMask=0x2`, `HitMask=0x3` (NORMAL|CRITICAL)
**Why:** Tests crit debuff application on Frost damage.

**Test Steps:**
```
.learn 11180                       -- Winter's Chill Rank 1
.go creature id 32666
.cast 116                          -- Frostbolt
```
- [ ] Winter's Chill debuff applies on Frost spell hit
- [ ] Increases chance to crit against target by 1/2/3/4/5% per rank
- [ ] Only procs on Frost school damage

---

### Improved Blizzard (11185)
**Proc Config:** `SpellFamilyMask0=0x80` (Blizzard), `ProcFlags=0x10000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests Chill effect application from Blizzard damage.

**Test Steps:**
```
.learn 11185                       -- Improved Blizzard Rank 1
.go creature id 32666
.cast 10                           -- Blizzard
```
- [ ] Chill effect applies on Blizzard damage ticks
- [ ] Movement speed reduced by proper percentage
- [ ] Triggered effect can proc other effects

---

### Arcane Concentration / Clearcasting (11213)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Clearcasting proc on damaging spells.

**Test Steps:**
```
.learn 11213                       -- Arcane Concentration Rank 1
.go creature id 32666
.cast 5143                         -- Arcane Missiles
```
- [ ] Clearcasting buff procs on spell damage
- [ ] 2/4/6/8/10% chance per rank
- [ ] Next spell is free (100% mana cost reduction)

---

### Improved Counterspell (11255)
**Proc Config:** `SpellFamilyMask0=0x4000` (Counterspell), `SpellPhaseMask=0x2`
**Why:** Tests silence effect on Counterspell.

**Test Steps:**
```
.learn 11255                       -- Improved Counterspell Rank 1
.go creature id 32666
# Find a casting enemy:
.go creature id 18317              -- Arcane Annihilator (casts spells)
.cast 2139                         -- Counterspell (interrupt their cast)
```
- [ ] Successful interrupt also silences target
- [ ] Silence duration is 2/4 seconds per rank
- [ ] Only silences school that was interrupted

---

### Mana Shield (1463)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x400` (ABSORB)
**Why:** Tests Mana Shield absorbing damage and draining mana.

**Test Steps:**
```
.learn 1463                        -- Mana Shield
.aura 1463                         -- Apply Mana Shield
.go creature id 32666
# Let enemy hit you
```
- [ ] Absorbs incoming damage
- [ ] Drains mana per point of damage absorbed
- [ ] Shield breaks when mana runs out or duration expires

---

### Master of Elements (29074)
**Proc Config:** `SchoolMask=0x14` (Fire|Frost), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `Cooldown=8`
**Why:** Tests mana return on Fire/Frost critical strikes.

**Test Steps:**
```
.learn 29074                       -- Master of Elements Rank 1
.go creature id 32666
.cast 133                          -- Fireball (critical)
```
- [ ] Returns 10/20/30% of base mana cost on Fire/Frost crit
- [ ] 8 second internal cooldown
- [ ] Works with both Fire and Frost spells

---

### Improved Blink (31569)
**Proc Config:** `SpellFamilyMask0=0x10000` (Blink), `SpellPhaseMask=0x2`
**Why:** Tests haste/movement bonus after Blink.

**Test Steps:**
```
.learn 31569                       -- Improved Blink Rank 1
.cast 1953                         -- Blink
```
- [ ] Movement speed increased after Blink
- [ ] 35/70% movement speed bonus per rank
- [ ] Duration is correct

---

### Arcane Potency (31571)
**Proc Config:** `SpellFamilyMask1=0x22` (Clearcasting/PoM triggers), `ProcFlags=0x4000`, `SpellTypeMask=0x7`, `SpellPhaseMask=0x4` (FINISH), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests crit chance increase after Clearcasting/Presence of Mind.

**Test Steps:**
```
.learn 31571                       -- Arcane Potency Rank 1
.learn 11213                       -- Arcane Concentration
.go creature id 32666
# Proc Clearcasting first, then cast
.cast 5143                         -- Arcane Missiles (to proc Clearcasting)
# When Clearcasting procs:
.cast 133                          -- Fireball (should have crit bonus)
```
- [ ] 15/30% crit bonus on next damaging spell after Clearcasting
- [ ] Consumed on next damaging spell
- [ ] Works with Presence of Mind as well

---

### Empowered Fire (31656)
**Proc Config:** `SchoolMask=0x4` (Fire), `SpellFamilyMask0=0x8000000` (Ignite), `SpellPhaseMask=0x2`
**Why:** Tests mana return when Ignite crits.

**Test Steps:**
```
.learn 31656                       -- Empowered Fire Rank 1
.learn 11119                       -- Ignite
.go creature id 32666
.cast 133                          -- Fireball (to proc Ignite)
```
- [ ] Returns mana when Ignite deals critical damage
- [ ] Returns 15/30/45% of Fireball/Frostfire Bolt base mana
- [ ] Requires Ignite to be active

---

### Missile Barrage (44404)
**Proc Config:** `SpellFamilyMask0=0x20000021`, `SpellFamilyMask1=0x9000` (Arcane Blast, Arcane Barrage, Fireball, Frostbolt), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Missile Barrage proc chance from various spells.

**Test Steps:**
```
.learn 44404                       -- Missile Barrage Rank 1
.go creature id 32666
.cast 30451                        -- Arcane Blast
```
- [ ] Missile Barrage buff procs on qualifying spell damage
- [ ] 4/8/12/16/20% chance per rank
- [ ] Next Arcane Missiles channels faster and is free

---

### Firestarter (44442)
**Proc Config:** `SpellFamilyMask0=0x800000`, `SpellFamilyMask1=0x40` (Blast Wave, Dragon's Breath), `SpellPhaseMask=0x2`, `Cooldown=1000`
**Why:** Tests instant Flamestrike proc after Blast Wave/Dragon's Breath.

**Test Steps:**
```
.learn 44442                       -- Firestarter Rank 1
.go creature id 32666
.cast 42945                        -- Blast Wave
# or
.cast 42950                        -- Dragon's Breath
```
- [ ] Firestarter buff procs allowing instant Flamestrike
- [ ] 50/100% chance per rank
- [ ] 1 second internal cooldown

---

### Hot Streak (44445)
**Proc Config:** `SpellFamilyMask0=0x13`, `SpellFamilyMask1=0x11000` (Fireball, Fire Blast, Scorch, Living Bomb, Frostfire Bolt), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Hot Streak instant Pyroblast proc.

**Test Steps:**
```
.learn 44445                       -- Hot Streak Rank 1
.go creature id 32666
# Need two consecutive Fire crits
.cast 133                          -- Fireball
.cast 133                          -- Fireball (if both crit, Hot Streak procs)
```
- [ ] Hot Streak buff procs after two consecutive Fire crits
- [ ] 33/66/100% chance per rank when condition met
- [ ] Makes next Pyroblast instant cast

---

### Burnout (44449)
**Proc Config:** `SpellFamilyMask0=0x20DED477`, `SpellFamilyMask1=0x19048` (Various Fire/Frost spells), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `Cooldown=8`
**Why:** Tests mana cost increase on spell crits for damage bonus.

**Test Steps:**
```
.learn 44449                       -- Burnout Rank 1
.go creature id 32666
.cast 133                          -- Fireball (critical)
```
- [ ] Spell crits cost additional mana (1% of base mana per rank)
- [ ] 8 second internal cooldown
- [ ] Works with Fire and Frost spells

---

### Brain Freeze (44546)
**Proc Config:** `SpellFamilyMask0=0x2E0`, `SpellFamilyMask1=0x1000` (Frost spells with Chill), `ProcFlags=0x11000`, `SpellPhaseMask=0x2`
**Why:** Tests free instant Fireball proc from Frost spells with Chill.

**Test Steps:**
```
.learn 44546                       -- Brain Freeze Rank 1
.go creature id 32666
.cast 116                          -- Frostbolt
```
- [ ] Brain Freeze buff procs on Frost spell cast with Chill effect
- [ ] 5/10/15% chance per rank
- [ ] Makes next Fireball instant and free

---

### Enduring Winter (44557)
**Proc Config:** `SpellFamilyMask0=0x20` (Frostbolt), `SpellPhaseMask=0x2`, `Cooldown=6000`
**Why:** Tests Replenishment proc from Frostbolt.

**Test Steps:**
```
.learn 44557                       -- Enduring Winter Rank 1
# Need party/raid members
.go creature id 32666
.cast 116                          -- Frostbolt
```
- [ ] Grants Replenishment to up to 10 party/raid members
- [ ] 33/66/100% chance per rank
- [ ] 6 second internal cooldown

---

### Combustion (11129)
**Proc Config:** `SchoolMask=0x4` (Fire), `SpellFamilyMask0=0x8BED217`, `SpellFamilyMask1=0x30F08` (Fire spells), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Combustion crit stacking mechanic.

**Test Steps:**
```
.learn 11129                       -- Combustion
.cast 11129                        -- Activate Combustion
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Each Fire crit adds a stack to Combustion counter
- [ ] Fire crit chance increases with each non-crit
- [ ] Buff consumed after 3 crits

---

### Presence of Mind (12043)
**Proc Config:** `SpellFamilyMask0=0x613204B5`, `SpellFamilyMask1=0x1000` (Mage spells), `SpellTypeMask=0x7`, `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8` (REQ_MANA_COST)
**Why:** Tests instant cast proc consumption.

**Test Steps:**
```
.learn 12043                       -- Presence of Mind
.cast 12043                        -- Activate Presence of Mind
.cast 133                          -- Fireball (should be instant)
```
- [ ] Next mage spell with cast time becomes instant
- [ ] Only works on spells with mana cost
- [ ] Consumed after one spell

---

### Clearcasting (12536)
**Proc Config:** `SpellFamilyMask0=0x20C5DE77`, `SpellFamilyMask1=0x29040` (Mage spells), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0xC` (REQ_SPELLMOD|REQ_MANA_COST)
**Why:** Tests Clearcasting buff consumption.

**Test Steps:**
```
.learn 11213                       -- Arcane Concentration (grants Clearcasting)
.go creature id 32666
.cast 5143                         -- Arcane Missiles (to proc)
# When Clearcasting procs:
.cast 133                          -- Fireball (should be free)
```
- [ ] Clearcasting makes next spell free
- [ ] Only consumed by spells with mana cost
- [ ] Works with spells that can be modified

---

### Netherwind Focus (22007)
**Proc Config:** `SpellFamilyMask0=0x200021` (Arcane Missiles, Fireball, Frostbolt), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests T3 set bonus proc.

**Test Steps:**
```
# Note: T3 Netherwind set
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Netherwind Focus buff can proc on spell damage
- [ ] Reduces cast time of next spell

---

### Netherwind Focus Consume (22008)
**Proc Config:** `SpellFamilyMask0=0x613204B5` (Mage spells), `ProcFlags=0x11000`, `SpellTypeMask=0x5`, `SpellPhaseMask=0x1` (CAST), `Charges=1`
**Why:** Tests T3 set bonus consumption.

**Test Steps:**
```
# Need Netherwind Focus buff active
.aura 22007                        -- Netherwind Focus
.cast 133                          -- Fireball (consumes buff)
```
- [ ] Consumes Netherwind Focus on next spell cast
- [ ] 1 charge (consumed after one spell)

---

### Arcane Blast (36032)
**Proc Config:** `SpellFamilyMask0=0x1000`, `SpellFamilyMask1=0x8000` (Arcane Blast), `SpellPhaseMask=0x1` (CAST)
**Why:** Tests Arcane Blast stacking debuff.

**Test Steps:**
```
.learn 30451                       -- Arcane Blast
.go creature id 32666
.cast 30451                        -- Arcane Blast
.cast 30451                        -- Arcane Blast (stacks)
```
- [ ] Arcane Blast debuff stacks on caster
- [ ] Each stack increases damage and mana cost
- [ ] Stacks up to 4 times

---

### Improved Mana Gems (37447)
**Proc Config:** `SpellFamilyMask1=0x100` (Mana Gem), `ProcFlags=0x4000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests mana restoration boost on Mana Gem use.

**Test Steps:**
```
.learn 37447                       -- Improved Mana Gems (if learnable)
.additem 22044                     -- Mana Gem
# Use Mana Gem
```
- [ ] Increased mana restored from Mana Gems
- [ ] Spell power buff on Mana Gem use

---

### Missile Barrage Consume (44401)
**Proc Config:** `ProcFlags=0x11000`, `SpellTypeMask=0x5`, `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8` (REQ_MANA_COST), `Charges=1`
**Why:** Tests Missile Barrage buff consumption.

**Test Steps:**
```
.aura 44401                        -- Missile Barrage (apply buff)
.go creature id 32666
.cast 5143                         -- Arcane Missiles (consumes buff)
```
- [ ] Arcane Missiles consumes Missile Barrage
- [ ] Channel is faster and mana cost reduced
- [ ] 1 charge consumption

---

### Fingers of Frost Rank 1 (44543)
**Proc Config:** `SpellFamilyMask0=0x100060`, `SpellFamilyMask1=0x1000` (Frost spells), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x2` (TRIGGERED_CAN_PROC), `Chance=7.0`
**Why:** Tests 7% Fingers of Frost proc chance (Rank 1).

**Test Steps:**
```
.learn 44543                       -- Fingers of Frost Rank 1
.go creature id 32666
.cast 116                          -- Frostbolt
```
- [ ] 7% chance to proc Fingers of Frost on Frost spell cast
- [ ] Treats target as frozen for Ice Lance/Deep Freeze
- [ ] 2 charges

---

### Fingers of Frost Rank 2 (44545)
**Proc Config:** `SpellFamilyMask0=0x100060`, `SpellFamilyMask1=0x1000` (Frost spells), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x2` (TRIGGERED_CAN_PROC), `Chance=15.0`
**Why:** Tests 15% Fingers of Frost proc chance (Rank 2).

**Test Steps:**
```
.learn 44545                       -- Fingers of Frost Rank 2
.go creature id 32666
.cast 116                          -- Frostbolt
```
- [ ] 15% chance to proc Fingers of Frost on Frost spell cast
- [ ] Same benefits as Rank 1 but higher proc rate

---

### Hot Streak Consume (48108)
**Proc Config:** `SpellFamilyMask0=0x400000` (Pyroblast), `ProcFlags=0x10000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8` (REQ_MANA_COST), `Charges=1`
**Why:** Tests Hot Streak buff consumption by Pyroblast.

**Test Steps:**
```
.aura 48108                        -- Hot Streak (apply buff)
.go creature id 32666
.cast 11366                        -- Pyroblast (consumes Hot Streak, instant)
```
- [ ] Pyroblast consumes Hot Streak buff
- [ ] Cast is instant
- [ ] 1 charge consumption

---

### Firestarter Consume (54741)
**Proc Config:** `SpellFamilyMask0=0x4` (Flamestrike), `ProcFlags=0x10000`, `SpellTypeMask=0x5`, `SpellPhaseMask=0x1` (CAST), `Charges=1`
**Why:** Tests Firestarter buff consumption by Flamestrike.

**Test Steps:**
```
.aura 54741                        -- Firestarter (apply buff)
.go creature id 32666
.cast 2120                         -- Flamestrike (consumes buff, instant)
```
- [ ] Flamestrike consumes Firestarter buff
- [ ] Cast is instant
- [ ] 1 charge consumption

---

### Glyph of Remove Curse (56364)
**Proc Config:** `SpellFamilyMask1=0x1000000` (Remove Curse), `SpellPhaseMask=0x2`
**Why:** Tests mana return on Remove Curse.

**Test Steps:**
```
.additem 42753                     -- Glyph of Remove Curse (apply glyph)
# Apply a curse to a friendly target first
.cast 475                          -- Remove Curse
```
- [ ] Returns mana when Remove Curse successfully removes a curse
- [ ] Glyph must be applied

---

### Glyph of Ice Block (56372)
**Proc Config:** `SpellFamilyMask1=0x80` (Ice Block), `ProcFlags=0x4000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Frost Nova cast when Ice Block expires.

**Test Steps:**
```
.additem 42744                     -- Glyph of Ice Block (apply glyph)
.cast 45438                        -- Ice Block
# Wait for Ice Block to expire or cancel
```
- [ ] Frost Nova casts automatically when Ice Block expires
- [ ] Frost Nova is centered on the mage

---

### Glyph of Icy Veins (56374)
**Proc Config:** `SpellFamilyMask1=0x4000` (Icy Veins), `ProcFlags=0x4000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests spell power boost from Icy Veins glyph.

**Test Steps:**
```
.additem 42746                     -- Glyph of Icy Veins (apply glyph)
.cast 12472                        -- Icy Veins
```
- [ ] Spell power increased while Icy Veins is active
- [ ] Glyph effect applies alongside normal Icy Veins benefits

---

### Glyph of Polymorph (56375)
**Proc Config:** `SpellFamilyMask0=0x1000000` (Polymorph), `ProcFlags=0x10000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`, `HitMask=0x801` (NORMAL|FULL_ABSORB)
**Why:** Tests healing proc when Polymorph lands.

**Test Steps:**
```
.additem 42752                     -- Glyph of Polymorph (apply glyph)
.go creature id 32666
.cast 118                          -- Polymorph
```
- [ ] Heals mage when Polymorph successfully lands
- [ ] Only procs on successful Polymorph (not immune targets)

---

### Arcane Potency Buff (57529)
**Proc Config:** `SpellPhaseMask=0x1` (CAST)
**Why:** Tests Arcane Potency buff tracking.

**Test Steps:**
```
.aura 57529                        -- Arcane Potency buff
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Buff consumed on spell cast
- [ ] Crit bonus applied to spell

---

### Arcane Potency Buff 2 (57531)
**Proc Config:** `SpellPhaseMask=0x1` (CAST)
**Why:** Tests second Arcane Potency buff variant.

**Test Steps:**
```
.aura 57531                        -- Arcane Potency buff variant
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Buff consumed on spell cast
- [ ] Crit bonus applied to spell

---

### Brain Freeze Fireball! (57761)
**Proc Config:** `SpellFamilyMask0=0x1`, `SpellFamilyMask1=0x1000` (Fireball, Frostfire Bolt), `ProcFlags=0x10000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8` (REQ_MANA_COST), `Charges=1`
**Why:** Tests Brain Freeze instant Fireball consumption.

**Test Steps:**
```
.aura 57761                        -- Brain Freeze (Fireball!)
.go creature id 32666
.cast 133                          -- Fireball (instant, consumes buff)
```
- [ ] Fireball (or Frostfire Bolt) consumes Brain Freeze buff
- [ ] Cast is instant
- [ ] No mana cost (free)

---

### Improved Mana Gems 2 (61062)
**Proc Config:** `SpellFamilyMask1=0x100` (Mana Gem), `ProcFlags=0x4000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests spell power buff from Mana Gem.

**Test Steps:**
```
.additem 42750                     -- Glyph of Mana Gem (if needed)
.additem 22044                     -- Mana Gem
# Use Mana Gem
```
- [ ] Spell power buff applied on Mana Gem use
- [ ] Buff duration and value correct

---

### Impact (64343)
**Proc Config:** `SpellFamilyMask0=0x2` (Fire Blast), `SpellPhaseMask=0x2`
**Why:** Tests Impact stun proc from Fire Blast.

**Test Steps:**
```
.learn 11103                       -- Impact (talent)
.go creature id 32666
.cast 2136                         -- Fire Blast
```
- [ ] Impact stuns target on Fire Blast hit
- [ ] 4/7/10% proc chance per rank
- [ ] 2 second stun duration

---

### Item - Mage T8 2P Bonus (64867)
**Proc Config:** `SpellFamilyMask0=0x20000021`, `SpellFamilyMask1=0x1000` (Arcane Blast, Fireball, Frostbolt, Frostfire Bolt), `SpellPhaseMask=0x2`, `Cooldown=45000`
**Why:** Tests T8 2P set bonus proc.

**Test Steps:**
```
# Need 2 pieces T8 Mage (Kirin Tor):
.additem 45365                     -- Valorous Kirin Tor Hood
.additem 45368                     -- Valorous Kirin Tor Tunic
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Set bonus procs on qualifying spell hit
- [ ] 45 second internal cooldown
- [ ] Verify bonus effect (spell power increase)

---

### Item - Mage T10 4P Bonus (70748)
**Proc Config:** `SpellFamilyMask1=0x200000` (Mirror Image), `ProcFlags=0x400` (SPELL_CAST), `SpellPhaseMask=0x2`
**Why:** Tests T10 4P proc on Mirror Image.

**Test Steps:**
```
# Need 4 pieces T10 Mage (Bloodmage):
.additem 50276                     -- Bloodmage Hood
.additem 50278                     -- Bloodmage Robe
.additem 50277                     -- Bloodmage Leggings
.additem 50279                     -- Bloodmage Shoulderpads
.cast 55342                        -- Mirror Image
```
- [ ] 4P bonus effect procs on Mirror Image cast
- [ ] Verify bonus damage increase

---

### Deep Freeze Immunity State (71761)
**Proc Config:** `SpellFamilyMask1=0x100000` (Deep Freeze), `SpellTypeMask=0x5`, `SpellPhaseMask=0x2`, `HitMask=0x100` (IMMUNE)
**Why:** Tests Deep Freeze damage on immune targets.

**Test Steps:**
```
.learn 44572                       -- Deep Freeze
.go creature id 32666
# Cast on a boss or immune target
.cast 44572                        -- Deep Freeze
```
- [ ] On immune targets, Deep Freeze deals damage instead of stun
- [ ] Damage is substantial on immune targets
- [ ] Procs when target would be immune to freeze

---

### Fingers of Frost (74396)
**Proc Config:** `SchoolMask=0x54` (Frost/Fire/Arcane), `SpellFamilyMask0=0x28DEC457`, `SpellFamilyMask1=0x119048` (Various spells), `ProcFlags=0x10000`, `SpellPhaseMask=0x1` (CAST)
**Why:** Tests Fingers of Frost charge consumption.

**Test Steps:**
```
.aura 44544                        -- Fingers of Frost buff
.go creature id 32666
.cast 30455                        -- Ice Lance (consumes charge)
```
- [ ] Ice Lance or Deep Freeze consumes Fingers of Frost charge
- [ ] Target treated as frozen for bonus damage
- [ ] Multiple charges can be consumed sequentially

---

## Paladin Procs (SpellFamilyName = 10)

### Illumination (20210)
**Proc Config:** `SpellFamilyMask0=0xC0000000`, `SpellFamilyMask1=0x10000` (Holy Light, Flash of Light, Holy Shock), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests mana return on Holy spell criticals.

**Test Steps:**
```
.learn 20210                       -- Illumination Rank 1
.go creature id 32666
# Cast a heal on yourself and crit:
.cast 19750                        -- Flash of Light
```
- [ ] Returns 30% of base mana cost on Holy heal crit
- [ ] Works with Holy Light, Flash of Light, Holy Shock
- [ ] Only procs on critical heals

---

### Improved Lay on Hands (20234)
**Proc Config:** `SpellFamilyMask0=0x8000` (Lay on Hands), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests armor bonus application after Lay on Hands.

**Test Steps:**
```
.learn 20234                       -- Improved Lay on Hands Rank 1
.cast 633                          -- Lay on Hands (on self)
```
- [ ] Armor bonus buff applied after Lay on Hands
- [ ] 25/50% armor increase per rank
- [ ] Correct duration

---

### Heart of the Crusader (20335)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `ProcFlags=0x10`, `SpellTypeMask=0x5`, `SpellPhaseMask=0x2`, `Chance=100.0`
**Why:** Tests crit debuff on Judgement.

**Test Steps:**
```
.learn 20335                       -- Heart of the Crusader Rank 1
# Apply a Seal first
.cast 20165                        -- Seal of Light
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Target gets crit debuff after Judgement
- [ ] 1/2/3% increased crit chance per rank
- [ ] 100% proc chance

---

### Judgements of the Wise (31876)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests mana regeneration and Replenishment from Judgement.

**Test Steps:**
```
.learn 31876                       -- Judgements of the Wise Rank 1
.cast 20154                        -- Seal of Righteousness
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Replenishment granted to party/raid on Judgement
- [ ] Mana returned to paladin (15% base mana)
- [ ] 33/66/100% chance per rank

---

### Divine Purpose (31871)
**Proc Config:** `SpellFamilyMask0=0x10` (Exorcism), `ProcFlags=0x4000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests stun/fear reduction and Hand of Freedom proc.

**Test Steps:**
```
.learn 31871                       -- Divine Purpose Rank 1
.go creature id 32666
.cast 879                          -- Exorcism
```
- [ ] Reduces stun/fear duration (passive effect)
- [ ] Procs Hand of Freedom on self

---

### Light's Grace (31833)
**Proc Config:** `SpellFamilyMask0=0x80000000` (Holy Light), `SpellPhaseMask=0x2`
**Why:** Tests Holy Light cast time reduction stacking.

**Test Steps:**
```
.learn 31833                       -- Light's Grace Rank 1
.cast 635                          -- Holy Light
```
- [ ] Light's Grace buff stacks on Holy Light cast
- [ ] Reduces next Holy Light cast time by 0.5 sec
- [ ] 100% uptime with constant casting

---

### Light's Grace Consume (31834)
**Proc Config:** `SpellFamilyMask0=0x80000000` (Holy Light), `ProcFlags=0x4000`, `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x1` (CAST), `Charges=1`
**Why:** Tests Light's Grace buff consumption.

**Test Steps:**
```
.aura 31834                        -- Light's Grace buff
.cast 635                          -- Holy Light (consumes buff)
```
- [ ] Buff consumed on Holy Light cast
- [ ] Cast time reduced
- [ ] 1 charge consumption

---

### Sacred Cleansing (53551)
**Proc Config:** `SpellFamilyMask0=0x1000` (Cleanse), `SpellPhaseMask=0x2`
**Why:** Tests Sacred Cleansing buff on successful dispel.

**Test Steps:**
```
.learn 53551                       -- Sacred Cleansing Rank 1
# Apply a debuff to friendly target, then:
.cast 4987                         -- Cleanse
```
- [ ] Sacred Cleansing buff procs on successful dispel
- [ ] 10/20/30% increased resistance per rank
- [ ] 10 second buff duration

---

### Infusion of Light (53569)
**Proc Config:** `SpellFamilyMask0=0x40200000`, `SpellFamilyMask1=0x10000` (Holy Shock, Flash of Light, Holy Light), `SpellTypeMask=0x3` (DAMAGE|HEAL), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests instant Flash of Light or faster Holy Light after Holy Shock crit.

**Test Steps:**
```
.learn 53569                       -- Infusion of Light Rank 1
.go creature id 32666
.cast 20473                        -- Holy Shock (damage, needs to crit)
```
- [ ] Flash of Light becomes instant on Holy Shock crit
- [ ] Holy Light cast time reduced by 0.75/1.5 sec
- [ ] Works with both healing and damage Holy Shock

---

### Righteous Vengeance (53380)
**Proc Config:** `SpellFamilyMask0=0x800000`, `SpellFamilyMask1=0x28000` (Judgement, Divine Storm, Crusader Strike), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests Righteous Vengeance DoT on melee crits.

**Test Steps:**
```
.learn 53380                       -- Righteous Vengeance Rank 1
.go creature id 32666
.cast 35395                        -- Crusader Strike (need crit)
```
- [ ] Righteous Vengeance DoT applied on crit
- [ ] DoT deals 10/20/30% of crit damage over 8 sec
- [ ] Works with Judgement, Divine Storm, Crusader Strike

---

### The Art of War (53486)
**Proc Config:** `SpellFamilyMask0=0x800000`, `SpellFamilyMask1=0x28000` (Judgement, Divine Storm, Crusader Strike), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests instant Exorcism/Flash of Light proc on melee crit.

**Test Steps:**
```
.learn 53486                       -- The Art of War Rank 1
.go creature id 32666
.cast 35395                        -- Crusader Strike (need crit)
```
- [ ] The Art of War buff procs on melee crit
- [ ] Exorcism or Flash of Light becomes instant
- [ ] 7/14% proc chance per rank

---

### Divine Guardian (53527)
**Proc Config:** `SchoolMask=0x1` (Physical), `SpellFamilyMask2=0x4` (Divine Sacrifice), `ProcFlags=0x400`, `SpellPhaseMask=0x2`, `HitMask=0x1` (NORMAL), `Chance=100.0`
**Why:** Tests party damage reduction on Divine Sacrifice.

**Test Steps:**
```
.learn 53527                       -- Divine Guardian Rank 1
.cast 64205                        -- Divine Sacrifice
# Party members should have damage reduction
```
- [ ] Divine Guardian buff applied to party
- [ ] 10/20% damage reduction per rank
- [ ] Lasts for Divine Sacrifice duration

---

### Judgements of the Pure (53671)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `SpellPhaseMask=0x2`
**Why:** Tests haste buff on Judgement.

**Test Steps:**
```
.learn 53671                       -- Judgements of the Pure Rank 1
.cast 20154                        -- Seal of Righteousness
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Haste buff applied after Judgement
- [ ] 3/6/9/12/15% haste per rank
- [ ] 60 second duration

---

### Judgements of the Just (53695)
**Proc Config:** `SpellFamilyMask0=0x800000`, `SpellFamilyMask2=0x8` (Judgement, Hammer of the Righteous), `ProcFlags=0x10`, `SpellTypeMask=0x5`, `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests attack speed reduction on Judgement.

**Test Steps:**
```
.learn 53695                       -- Judgements of the Just Rank 1
.cast 20154                        -- Seal of Righteousness
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Target's melee attack speed reduced by 10/20%
- [ ] Also triggers Seal of Justice stun chance
- [ ] Works with Judgement and Hammer of the Righteous

---

### Shield of the Templar (53709)
**Proc Config:** `SchoolMask=0x2` (Holy), `SpellFamilyMask0=0x4000` (Avenger's Shield), `SpellPhaseMask=0x2`
**Why:** Tests Shield of Righteousness damage bonus and silence on Avenger's Shield.

**Test Steps:**
```
.learn 53709                       -- Shield of the Templar Rank 1
.go creature id 32666
.cast 31935                        -- Avenger's Shield
```
- [ ] Avenger's Shield silences target for 3 sec
- [ ] Shield of Righteousness damage increased by 10/20/30%
- [ ] Only procs on Holy damage

---

### Seal of Command Judgement (23591)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `ProcFlags=0x10`, `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests Judgement of Command additional effects.

**Test Steps:**
```
.cast 20375                        -- Seal of Command
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Judgement of Command proc triggers
- [ ] Proper damage dealt
- [ ] Seal of Command effects apply

---

### Battlegear of Eternal Justice (26135)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `ProcFlags=0x10`, `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests T2.5 set bonus on Judgement.

**Test Steps:**
```
# Need Battlegear of Eternal Justice set pieces
.go creature id 32666
.cast 20154                        -- Seal of Righteousness
.cast 20271                        -- Judgement
```
- [ ] Set bonus proc on Judgement
- [ ] Verify bonus effect

---

### Holy Power (28789)
**Proc Config:** `SpellFamilyMask0=0xC0000000` (Holy Light, Flash of Light), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T3 set bonus on heals.

**Test Steps:**
```
# Need T3 set pieces
.cast 635                          -- Holy Light
```
- [ ] Holy Power buff procs on heal
- [ ] Bonus healing effect active

---

### Libram of Justice (34139)
**Proc Config:** `SpellFamilyMask0=0x40000000` (Flash of Light), `SpellPhaseMask=0x2`
**Why:** Tests Libram of Justice Flash of Light bonus.

**Test Steps:**
```
.additem 28296                     -- Libram of Justice
.cast 19750                        -- Flash of Light
```
- [ ] Bonus applied on Flash of Light
- [ ] Spell power increased for next heal

---

### Libram of Righteous Power (34258)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests Libram Judgement bonus.

**Test Steps:**
```
# Need Libram of Righteous Power
.cast 20154                        -- Seal of Righteousness
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Bonus procs on Judgement
- [ ] Attack power/spell power increased

---

### Reduced Holy Light Cast Time (37189)
**Proc Config:** `SpellFamilyMask0=0xC0000000` (Holy Light, Flash of Light), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `Cooldown=60000`
**Why:** Tests T5 set bonus on heal crit.

**Test Steps:**
```
# Need T5 set pieces
.cast 635                          -- Holy Light (need crit)
```
- [ ] Cast time reduction procs on crit
- [ ] 60 second internal cooldown

---

### Judgement Group Heal (37195)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests T5 set bonus group heal on Judgement.

**Test Steps:**
```
# Need T5 set pieces
.cast 20154                        -- Seal of Righteousness
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Group heal procs on Judgement
- [ ] Heals nearby party members

---

### Paladin Tier 6 Trinket (40470)
**Proc Config:** `SpellFamilyMask0=0xC0600000` (Holy heals), `SpellTypeMask=0x3` (DAMAGE|HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T6 trinket proc on heals.

**Test Steps:**
```
# Need T6 trinket
.cast 635                          -- Holy Light
```
- [ ] Trinket proc on heal
- [ ] Bonus effect applied

---

### Merciless Libram of Justice (42368)
**Proc Config:** `SpellFamilyMask0=0x40000000` (Flash of Light), `SpellPhaseMask=0x2`
**Why:** Tests Season 2 Libram Flash of Light bonus.

**Test Steps:**
```
.additem 29385                     -- Merciless Gladiator's Libram of Justice
.cast 19750                        -- Flash of Light
```
- [ ] Bonus applied on Flash of Light
- [ ] Proper buff value

---

### Vengeful Libram of Justice (43726)
**Proc Config:** `SpellFamilyMask0=0x40000000` (Flash of Light), `SpellPhaseMask=0x2`
**Why:** Tests Season 3 Libram Flash of Light bonus.

**Test Steps:**
```
.additem 33503                     -- Vengeful Gladiator's Libram of Justice
.cast 19750                        -- Flash of Light
```
- [ ] Bonus applied on Flash of Light
- [ ] Proper buff value

---

### Light's Grace T7 (43741)
**Proc Config:** `SpellFamilyMask0=0x80000000` (Holy Light), `SpellPhaseMask=0x2`
**Why:** Tests T7 set Light's Grace interaction.

**Test Steps:**
```
# Need T7 Holy set pieces
.cast 635                          -- Holy Light
```
- [ ] Light's Grace buff applied
- [ ] Bonus effect from T7 set

---

### Crusader's Command (43745)
**Proc Config:** `SpellFamilyMask1=0x200` (Crusader Strike), `SpellPhaseMask=0x2`
**Why:** Tests Crusader Strike proc effect.

**Test Steps:**
```
.go creature id 32666
.cast 35395                        -- Crusader Strike
```
- [ ] Crusader's Command buff procs
- [ ] Bonus effect applied

---

### Brutal Libram of Justice (46092)
**Proc Config:** `SpellFamilyMask0=0x40000000` (Flash of Light), `SpellPhaseMask=0x2`
**Why:** Tests Season 4 Libram Flash of Light bonus.

**Test Steps:**
```
.additem 35475                     -- Brutal Gladiator's Libram of Justice
.cast 19750                        -- Flash of Light
```
- [ ] Bonus applied on Flash of Light
- [ ] Proper buff value

---

### Justice (48835)
**Proc Config:** `SpellFamilyMask0=0x800000` (Judgement), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests Justice proc on Judgement.

**Test Steps:**
```
.cast 20154                        -- Seal of Righteousness
.go creature id 32666
.cast 20271                        -- Judgement
```
- [ ] Justice buff procs on Judgement
- [ ] Effect applied correctly

---

### Glyph of Seal of Command (54925)
**Proc Config:** `SchoolMask=0x2` (Holy), `SpellFamilyMask1=0x200` (Seal of Command proc), `SpellPhaseMask=0x2`
**Why:** Tests Seal of Command glyph mana refund.

**Test Steps:**
```
.additem 41094                     -- Glyph of Seal of Command (apply glyph)
.cast 20375                        -- Seal of Command
.go creature id 32666
# Melee attack
```
- [ ] Mana returned on Seal of Command proc
- [ ] Glyph effect active

---

### Glyph of Holy Light (54937)
**Proc Config:** `SpellFamilyMask0=0x80000000` (Holy Light), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests splash healing from Holy Light glyph.

**Test Steps:**
```
.additem 41106                     -- Glyph of Holy Light (apply glyph)
# Need multiple nearby friendly targets
.cast 635                          -- Holy Light (on target)
```
- [ ] Splash healing to nearby targets
- [ ] 10% of healing splashed within 8 yards

---

### Glyph of Divinity (54939)
**Proc Config:** `SpellFamilyMask0=0x8000` (Lay on Hands), `SpellPhaseMask=0x2`
**Why:** Tests mana restoration from Lay on Hands glyph.

**Test Steps:**
```
.additem 41108                     -- Glyph of Divinity (apply glyph)
.cast 633                          -- Lay on Hands (on self)
```
- [ ] Mana restored to paladin
- [ ] Returns mana equal to base mana

---

### Libram of Reciprocation (60818)
**Proc Config:** `SpellFamilyMask1=0x200` (Crusader Strike), `SpellPhaseMask=0x2`
**Why:** Tests Libram of Reciprocation proc.

**Test Steps:**
```
.additem 40191                     -- Libram of Reciprocation
.go creature id 32666
.cast 35395                        -- Crusader Strike
```
- [ ] Attack power buff procs on Crusader Strike
- [ ] Stacking effect

---

### Justice (61324)
**Proc Config:** `SpellFamilyMask1=0x20000` (Shield of Righteousness), `SpellPhaseMask=0x2`
**Why:** Tests Justice proc on Shield of Righteousness.

**Test Steps:**
```
.go creature id 32666
.cast 53600                        -- Shield of Righteousness
```
- [ ] Justice buff procs
- [ ] Correct bonus applied

---

### Item - Paladin T8 Protection 4P Bonus (64882)
**Proc Config:** `SpellFamilyMask1=0x100000` (Sacred Shield), `SpellPhaseMask=0x2`
**Why:** Tests T8 4P Protection bonus on Sacred Shield.

**Test Steps:**
```
# Need 4 pieces T8 Protection (Aegis):
.additem 45370                     -- Valorous Aegis Gloves
.additem 45371                     -- Valorous Aegis Greaves
.additem 45372                     -- Valorous Aegis Headpiece
.additem 45374                     -- Valorous Aegis Tunic
.cast 53601                        -- Sacred Shield
```
- [ ] 4P bonus procs on Sacred Shield application
- [ ] Bonus effect verified

---

### Item - Paladin T8 Holy 2P Bonus (64890)
**Proc Config:** `SpellFamilyMask1=0x10000` (Holy Shock), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests T8 2P Holy bonus on Holy Shock crit.

**Test Steps:**
```
# Need 2 pieces T8 Holy (Aegis):
.additem 45370                     -- Valorous Aegis Gloves
.additem 45372                     -- Valorous Aegis Headpiece
# Target friendly player
.cast 20473                        -- Holy Shock (heal, need crit)
```
- [ ] 2P bonus procs on Holy Shock healing crit
- [ ] HoT applied to target

---

### Item - Paladin T8 Protection Relic (64955)
**Proc Config:** `SpellFamilyMask1=0x40` (Divine Plea), `SpellPhaseMask=0x2`
**Why:** Tests T8 Protection relic proc.

**Test Steps:**
```
.additem 45436                     -- Libram of the Sacred Shield (T8 Relic)
.cast 54428                        -- Divine Plea
```
- [ ] Relic proc on Divine Plea
- [ ] Bonus shield effect

---

### Item - Paladin T9 Holy Relic - Judgement (67363)
**Proc Config:** `SpellFamilyMask0=0x80000000` (Holy Light), `SpellPhaseMask=0x2`, `Cooldown=8000`
**Why:** Tests T9 Holy relic proc on Holy Light.

**Test Steps:**
```
.additem 47662                     -- Libram of Veracity
.cast 635                          -- Holy Light
```
- [ ] Spell power buff procs on Holy Light
- [ ] 8 second internal cooldown

---

### Item - Paladin T9 Retribution Relic (67365)
**Proc Config:** `SpellFamilyMask1=0x800` (Seal of Vengeance/Corruption), `SpellPhaseMask=0x2`, `Cooldown=8000`
**Why:** Tests T9 Ret relic proc on Seal of Vengeance.

**Test Steps:**
```
.additem 47661                     -- Libram of Valiance
.cast 31801                        -- Seal of Vengeance
.go creature id 32666
# Melee attack to proc seal
```
- [ ] Strength buff procs on Seal proc
- [ ] 8 second internal cooldown

---

### Item - Paladin T9 Protection Relic (67379)
**Proc Config:** `SpellFamilyMask1=0x40000` (Hammer of the Righteous), `SpellPhaseMask=0x2`, `Cooldown=9000`
**Why:** Tests T9 Protection relic proc.

**Test Steps:**
```
.additem 47664                     -- Libram of Defiance
.go creature id 32666
.cast 53595                        -- Hammer of the Righteous
```
- [ ] Block value buff procs
- [ ] 9 second internal cooldown

---

### Item - Paladin T10 Holy 4P Bonus (70756)
**Proc Config:** `SpellFamilyMask1=0x10000` (Holy Shock), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T10 4P Holy bonus on Holy Shock.

**Test Steps:**
```
# Need 4 pieces T10 Holy (Lightsworn):
.additem 50867                     -- Lightsworn Headpiece
.additem 50865                     -- Lightsworn Spaulders
.additem 50866                     -- Lightsworn Greaves
.additem 50868                     -- Lightsworn Gloves
.cast 20473                        -- Holy Shock (heal)
```
- [ ] 4P bonus procs on Holy Shock heal
- [ ] Haste buff applied

---

### Item - Paladin T10 Protection 4P Bonus (70761)
**Proc Config:** `SpellFamilyMask2=0x1` (Hammer of the Righteous), `ProcFlags=0x400`, `SpellPhaseMask=0x2`
**Why:** Tests T10 4P Protection bonus on Hammer of the Righteous.

**Test Steps:**
```
# Need 4 pieces T10 Protection (Lightsworn):
.additem 50862                     -- Lightsworn Faceguard
.additem 50860                     -- Lightsworn Shoulderguards
.additem 50861                     -- Lightsworn Legguards
.additem 50863                     -- Lightsworn Handguards
.go creature id 32666
.cast 53595                        -- Hammer of the Righteous
```
- [ ] 4P bonus procs on Hammer of the Righteous
- [ ] Bonus damage verified

---

### Item - Paladin T10 Retribution Relic (71186)
**Proc Config:** `SpellFamilyMask1=0x8000` (Divine Storm), `SpellPhaseMask=0x2`
**Why:** Tests T10 Ret relic proc on Divine Storm.

**Test Steps:**
```
.additem 50455                     -- Libram of Three Truths
.go creature id 32666
.cast 53385                        -- Divine Storm
```
- [ ] Strength buff procs on Divine Storm
- [ ] Stacking effect

---

### Item - Paladin T10 Holy Relic (71191)
**Proc Config:** `SpellFamilyMask1=0x10000` (Holy Shock), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T10 Holy relic proc on Holy Shock.

**Test Steps:**
```
.additem 50460                     -- Libram of Blinding Light
.cast 20473                        -- Holy Shock (heal)
```
- [ ] Spell power buff procs on Holy Shock heal
- [ ] Correct buff value

---

### Item - Paladin T10 Protection Relic (71194)
**Proc Config:** `SpellFamilyMask1=0x100000` (Shield of Righteousness), `SpellPhaseMask=0x2`
**Why:** Tests T10 Protection relic proc.

**Test Steps:**
```
.additem 50461                     -- Libram of the Eternal Tower
.go creature id 32666
.cast 53600                        -- Shield of Righteousness
```
- [ ] Dodge rating buff procs
- [ ] Stacking effect

---

## Priest Procs (SpellFamilyName = 6)

### Inspiration (14892)
**Proc Config:** `SpellFamilyMask0=0x10005000`, `SpellFamilyMask1=0x10004` (Flash Heal, Greater Heal, Penance, etc.), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests armor buff on healing crits.

**Test Steps:**
```
.learn 14892                       -- Inspiration Rank 1
# Target friendly player
.cast 2061                         -- Flash Heal (need crit)
```
- [ ] Target gains armor buff on critical heal
- [ ] 25/50/75/100% armor increase per rank
- [ ] Works with Flash Heal, Greater Heal, Penance, etc.

---

### Improved Spirit Tap (15337)
**Proc Config:** `SpellFamilyMask0=0x802000`, `SpellFamilyMask1=0x2` (Mind Blast, Shadow Word: Death), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests mana regen proc on Shadow damage crits.

**Test Steps:**
```
.learn 15337                       -- Improved Spirit Tap Rank 1
.go creature id 32666
.cast 8092                         -- Mind Blast (need crit)
```
- [ ] Spirit Tap buff procs on Mind Blast or SW:D crit
- [ ] 50/100% mana regen increase per rank
- [ ] Also provides spell power bonus

---

### Vampiric Embrace (15286)
**Proc Config:** `SchoolMask=0x20` (Shadow), `SpellFamilyMask0=0x2810010`, `SpellFamilyMask1=0x2402`, `SpellFamilyMask2=0x8` (Shadow spells), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests healing return on Shadow damage.

**Test Steps:**
```
.aura 15286                        -- Vampiric Embrace
.go creature id 32666
.cast 589                          -- Shadow Word: Pain
```
- [ ] Heals priest on Shadow damage
- [ ] 5% of damage returned as healing
- [ ] Party/raid members receive 3% healing

---

### Misery (33191)
**Proc Config:** `SpellFamilyMask0=0x8000`, `SpellFamilyMask1=0x400`, `SpellFamilyMask2=0x40` (Shadow spells), `SpellPhaseMask=0x2`
**Why:** Tests hit debuff application on Shadow spells.

**Test Steps:**
```
.learn 33191                       -- Misery Rank 1
.go creature id 32666
.cast 589                          -- Shadow Word: Pain
```
- [ ] Misery debuff applied to target
- [ ] Increases spell hit chance against target by 1/2/3%
- [ ] Works with Mind Blast, Mind Flay, SW:P

---

### Vampiric Touch (34914)
**Proc Config:** `SpellFamilyMask0=0x2000` (Mind Blast), `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Replenishment proc from Vampiric Touch + Mind Blast.

**Test Steps:**
```
.learn 34914                       -- Vampiric Touch
.go creature id 32666
.cast 34914                        -- Vampiric Touch (apply)
.cast 8092                         -- Mind Blast
```
- [ ] Replenishment granted on Mind Blast with VT active
- [ ] Mana returned to party/raid members
- [ ] Only procs with VT on target

---

### Holy Concentration (34753)
**Proc Config:** `SpellFamilyMask0=0x1800`, `SpellFamilyMask1=0x4`, `SpellFamilyMask2=0x1000` (Flash Heal, Greater Heal, Binding Heal), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2` (TRIGGERED_CAN_PROC), `Cooldown=1`
**Why:** Tests Clearcasting proc on heal crits.

**Test Steps:**
```
.learn 34753                       -- Holy Concentration Rank 1
.cast 2061                         -- Flash Heal (need crit)
```
- [ ] Clearcasting buff procs on heal crit
- [ ] 50/100% mana cost reduction on next spell
- [ ] 1ms internal cooldown

---

### Grace (47516)
**Proc Config:** `SpellFamilyMask0=0x1800`, `SpellFamilyMask1=0x10000` (Flash Heal, Greater Heal, Penance), `SpellPhaseMask=0x2`, `AttributesMask=0x2` (TRIGGERED_CAN_PROC)
**Why:** Tests Grace buff stacking on target.

**Test Steps:**
```
.learn 47516                       -- Grace Rank 1
# Target friendly player
.cast 2061                         -- Flash Heal
.cast 2061                         -- Flash Heal (stacks)
```
- [ ] Grace debuff stacks on target
- [ ] Increases healing received from you by 2% per stack
- [ ] Stacks up to 3 times

---

### Improved Shadowform (47569)
**Proc Config:** `SpellFamilyMask0=0x4000` (Shadowform), `ProcFlags=0x4000`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Fade/Speed bonus while in Shadowform.

**Test Steps:**
```
.learn 47569                       -- Improved Shadowform Rank 1
.cast 15473                        -- Shadowform
.cast 586                          -- Fade
```
- [ ] Removes movement impairing effects when Shadowform breaks
- [ ] Fade cooldown reduced
- [ ] Only procs while in Shadowform

---

### Pain and Suffering (47580)
**Proc Config:** `SpellFamilyMask2=0x40` (Mind Flay), `SpellPhaseMask=0x2`
**Why:** Tests SW:P refresh on Mind Flay.

**Test Steps:**
```
.learn 47580                       -- Pain and Suffering Rank 1
.go creature id 32666
.cast 589                          -- Shadow Word: Pain (apply)
.cast 15407                        -- Mind Flay
```
- [ ] Shadow Word: Pain refreshed on Mind Flay damage
- [ ] 33/66/100% chance per rank
- [ ] SW:P must already be on target

---

### Borrowed Time (52795)
**Proc Config:** `SpellFamilyMask0=0x1` (Power Word: Shield), `SpellPhaseMask=0x2`
**Why:** Tests haste buff on PW:S cast.

**Test Steps:**
```
.learn 52795                       -- Borrowed Time Rank 1
.cast 17                           -- Power Word: Shield
```
- [ ] Haste buff applied after PW:S
- [ ] 5/10/15/20/25% haste per rank
- [ ] Buff lasts until next spell cast

---

### Renewed Hope (57470)
**Proc Config:** `SpellFamilyMask0=0x1` (Power Word: Shield), `SpellPhaseMask=0x2`, `Cooldown=15000`
**Why:** Tests crit bonus buff on PW:S.

**Test Steps:**
```
.learn 57470                       -- Renewed Hope Rank 1
.cast 17                           -- Power Word: Shield
```
- [ ] Renewed Hope buff applied to target
- [ ] 2/4% increased crit on target per rank
- [ ] 15 second internal cooldown

---

### Serendipity (63730)
**Proc Config:** `SpellFamilyMask0=0x800`, `SpellFamilyMask1=0x4` (Flash Heal, Binding Heal), `SpellPhaseMask=0x2`, `Cooldown=100`
**Why:** Tests Greater Heal/Prayer of Healing cast time reduction stacking.

**Test Steps:**
```
.learn 63730                       -- Serendipity Rank 1
.cast 2061                         -- Flash Heal
.cast 2061                         -- Flash Heal (stacks)
```
- [ ] Serendipity buff stacks on Flash Heal/Binding Heal
- [ ] Reduces Greater Heal/PoH cast time by 4/8/12% per stack
- [ ] Stacks up to 3 times

---

### Body and Soul (64127)
**Proc Config:** `SpellFamilyMask0=0x1`, `SpellFamilyMask1=0x1` (Power Word: Shield, Abolish Disease), `SpellTypeMask=0x6` (HEAL|NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests movement speed buff on PW:S.

**Test Steps:**
```
.learn 64127                       -- Body and Soul Rank 1
.cast 17                           -- Power Word: Shield
```
- [ ] Target gains movement speed buff
- [ ] 30/60% movement speed increase per rank
- [ ] 4 second duration

---

### Oracle Healing Bonus (26169)
**Proc Config:** `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T2.5 set bonus on heals.

**Test Steps:**
```
# Need Oracle set pieces
.cast 2061                         -- Flash Heal
```
- [ ] Bonus healing procs on heal
- [ ] Verify bonus effect

---

### Greater Heal T3 (28809)
**Proc Config:** `SpellFamilyMask0=0x1000` (Greater Heal), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests T3 set bonus on Greater Heal crit.

**Test Steps:**
```
# Need T3 set pieces
.cast 2060                         -- Greater Heal (need crit)
```
- [ ] Bonus procs on Greater Heal crit
- [ ] Mana returned or bonus heal

---

### Greater Heal Discount (37568)
**Proc Config:** `SpellFamilyMask0=0x800` (Flash Heal), `SpellPhaseMask=0x2`
**Why:** Tests Greater Heal cost reduction on Flash Heal.

**Test Steps:**
```
# Need set piece with this bonus
.cast 2061                         -- Flash Heal
```
- [ ] Greater Heal cost reduced after Flash Heal
- [ ] Buff stacks or applies

---

### Greater Heal Refund (37594)
**Proc Config:** `SpellFamilyMask0=0x1000` (Greater Heal), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests mana refund on Greater Heal.

**Test Steps:**
```
# Need set piece with this bonus
.cast 2060                         -- Greater Heal
```
- [ ] Mana refunded on Greater Heal
- [ ] Verify refund amount

---

### Shadow Word Pain Damage (37603)
**Proc Config:** `SpellFamilyMask0=0x8000` (Shadow Word: Pain), `SpellPhaseMask=0x2`
**Why:** Tests SW:P damage bonus.

**Test Steps:**
```
# Need set piece with this bonus
.go creature id 32666
.cast 589                          -- Shadow Word: Pain
```
- [ ] SW:P damage increased
- [ ] Verify bonus damage

---

### Sadist (37604)
**Proc Config:** `SpellPhaseMask=0x2`
**Why:** Tests generic proc effect.

**Test Steps:**
```
# Trigger condition
```
- [ ] Effect procs
- [ ] Verify behavior

---

### Priest Tier 6 Trinket (40438)
**Proc Config:** `SpellFamilyMask0=0x8040` (Prayer of Mending, SW:P), `SpellTypeMask=0x3` (DAMAGE|HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T6 trinket proc on heals/damage.

**Test Steps:**
```
# Need T6 trinket
.cast 33076                        -- Prayer of Mending
```
- [ ] Trinket procs on qualifying spell
- [ ] Bonus effect applied

---

### Blackout (46025)
**Proc Config:** `SchoolMask=0x20` (Shadow), `SpellPhaseMask=0x2`
**Why:** Tests stun chance on Shadow damage.

**Test Steps:**
```
.learn 15268                       -- Blackout (talent)
.go creature id 32666
.cast 8092                         -- Mind Blast
```
- [ ] Target stunned on Shadow damage
- [ ] 2/4/6/8/10% proc chance per rank
- [ ] 3 second stun duration

---

### Glyph of Dispel Magic (55677)
**Proc Config:** `SpellFamilyMask1=0x1` (Dispel Magic), `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests healing on successful dispel.

**Test Steps:**
```
.additem 42397                     -- Glyph of Dispel Magic (apply glyph)
# Dispel a buff from enemy or debuff from friendly
.cast 527                          -- Dispel Magic
```
- [ ] Heals target on successful dispel
- [ ] 3% of max health healed
- [ ] Only heals on dispel of debuff from friendly

---

### Glyph of Prayer of Healing (55680)
**Proc Config:** `SpellFamilyMask0=0x200` (Prayer of Healing), `SpellPhaseMask=0x2`
**Why:** Tests HoT application from Prayer of Healing glyph.

**Test Steps:**
```
.additem 42409                     -- Glyph of Prayer of Healing (apply glyph)
# Target party member
.cast 596                          -- Prayer of Healing
```
- [ ] HoT applied to healed targets
- [ ] 20% of heal over 6 seconds
- [ ] Glyph effect active

---

### Glyph of Shadow Word: Pain (55681)
**Proc Config:** `SpellFamilyMask0=0x8000` (Shadow Word: Pain), `SpellPhaseMask=0x2`
**Why:** Tests bonus damage from SW:P glyph.

**Test Steps:**
```
.additem 42406                     -- Glyph of Shadow Word: Pain (apply glyph)
.go creature id 32666
.cast 589                          -- Shadow Word: Pain
```
- [ ] SW:P damage increased by 10%
- [ ] Glyph effect active

---

### Item - Priest T8 Shadow 4P Bonus (64908)
**Proc Config:** `SpellFamilyMask0=0x2000` (Mind Blast), `SpellPhaseMask=0x2`
**Why:** Tests T8 4P Shadow bonus on Mind Blast.

**Test Steps:**
```
# Need 4 pieces T8 Shadow (Conqueror's Sanctification):
.additem 45386                     -- Valorous Cowl of Sanctification
.additem 45387                     -- Valorous Gloves of Sanctification
.additem 45388                     -- Valorous Leggings of Sanctification
.additem 45389                     -- Valorous Robe of Sanctification
.go creature id 32666
.cast 8092                         -- Mind Blast
```
- [ ] 4P bonus procs on Mind Blast
- [ ] Bonus damage verified

---

### Item - Priest T8 Healer 4P Bonus (64912)
**Proc Config:** `SpellFamilyMask0=0x1` (Power Word: Shield), `SpellPhaseMask=0x2`
**Why:** Tests T8 4P Healer bonus on PW:S.

**Test Steps:**
```
# Need 4 pieces T8 Healer (Valorous Sanctification):
.additem 45386                     -- Valorous Cowl of Sanctification
.additem 45387                     -- Valorous Gloves of Sanctification
.additem 45388                     -- Valorous Leggings of Sanctification
.additem 45389                     -- Valorous Robe of Sanctification
.cast 17                           -- Power Word: Shield
```
- [ ] 4P bonus procs on PW:S
- [ ] Bonus effect verified

---

### Item - Priest T10 Healer 2P Bonus (70770)
**Proc Config:** `SpellFamilyMask0=0x800` (Flash Heal), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T10 2P Healer bonus on Flash Heal.

**Test Steps:**
```
# Need 2 pieces T10 Healer (Crimson Acolyte):
.additem 50765                     -- Crimson Acolyte Hood
.additem 50766                     -- Crimson Acolyte Gloves
.cast 2061                         -- Flash Heal
```
- [ ] 2P bonus procs on Flash Heal
- [ ] HoT applied to target

---

### Corruption T10 Shadow (70904)
**Proc Config:** `SpellFamilyMask2=0x800` (Mind Flay), `ProcFlags=0x800`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `Cooldown=1000`
**Why:** Tests T10 4P Shadow bonus on Mind Flay.

**Test Steps:**
```
# Need 4 pieces T10 Shadow (Crimson Acolyte):
.additem 50391                     -- Crimson Acolyte Handwraps
.additem 50392                     -- Crimson Acolyte Cowl
.additem 50393                     -- Crimson Acolyte Pants
.additem 50394                     -- Crimson Acolyte Raiments
.go creature id 32666
.cast 15407                        -- Mind Flay
```
- [ ] 4P bonus procs on Mind Flay
- [ ] Damage increase verified
- [ ] 1 second internal cooldown

---

## Rogue Proc Tests (SpellFamilyName = 8)

### Waylay (-51692 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x204` (Ambush/Backstab), `SpellPhaseMask=0x2` (HIT)
**Why:** Tests Waylay debuff application from Ambush/Backstab. Reduces target movement/attack speed.

**Test Steps:**
```
.learn 51692                       -- Waylay Rank 1 (50% slow)
.learn 51696                       -- Waylay Rank 2 (100% slow)
.additem 39714                     -- Dagger for Backstab
.go creature id 32666
.cast 53                           -- Backstab (from behind)
```
- [ ] Waylay debuff applies on Backstab hit
- [ ] Movement speed reduced by 50%/100%
- [ ] Attack speed reduced
- [ ] Works with Ambush as well

---

### Savage Combat (-51682 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x80000` (Deadly Poison), `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests Savage Combat debuff when applying poisons. Increases target physical damage taken.

**Test Steps:**
```
.learn 51682                       -- Savage Combat Rank 1 (2% damage increase)
.learn 51685                       -- Savage Combat Rank 2 (4% damage increase)
.learn 2823                        -- Deadly Poison
.additem 39714                     -- Dagger
.go creature id 32666
# Auto-attack until Deadly Poison applies
```
- [ ] Target takes 2%/4% more physical damage when poisoned
- [ ] Procs only on poison application (NO_DMG_HEAL)
- [ ] Works with any poison type

---

### Cut to the Chase (-51664 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x20000` (Eviscerate), `SpellFamilyMask1=0x8` (Envenom), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Cut to the Chase refreshing Slice and Dice on finishing moves.

**Test Steps:**
```
.learn 51664                       -- Cut to the Chase Rank 1 (20% chance)
.learn 51667                       -- Cut to the Chase Rank 5 (100% chance)
.learn 5171                        -- Slice and Dice
.additem 39714                     -- Dagger
.go creature id 32666
.cast 5171                         -- Slice and Dice (to have it active)
# Build combo points then:
.cast 2098                         -- Eviscerate
```
- [ ] Slice and Dice refreshed to 5 combo point duration
- [ ] Works with Eviscerate
- [ ] Works with Envenom
- [ ] Chance matches talent rank (20/40/60/80/100%)

---

### Deadly Brew (-51625 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x10008000` (Instant/Wound Poison), `SpellTypeMask=0x5` (DAMAGE+NO_DMG_HEAL), `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests Deadly Brew applying Crippling Poison when other poisons proc.

**Test Steps:**
```
.learn 51625                       -- Deadly Brew Rank 1 (50% chance)
.learn 51626                       -- Deadly Brew Rank 2 (100% chance)
.learn 6510                        -- Instant Poison
.learn 3408                        -- Crippling Poison
.additem 39714                     -- Dagger
.go creature id 32666
# Auto-attack until Instant Poison procs
```
- [ ] Crippling Poison applied when other poison procs
- [ ] Chance matches talent rank (50%/100%)
- [ ] Works with Instant, Wound, and Mind-numbing Poison

---

### Quick Recovery (-31244 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x39F800` (Finishers), `SpellFamilyMask1=0x9` (Envenom+), `SpellTypeMask=0x5`, `SpellPhaseMask=0x2`, `HitMask=0x2BC4`
**Why:** Tests energy refund when finishing moves are dodged/parried/blocked/miss.

**Test Steps:**
```
.learn 31244                       -- Quick Recovery Rank 1 (40% refund)
.learn 31245                       -- Quick Recovery Rank 2 (80% refund)
.additem 39714                     -- Dagger
.go creature id 32541              -- Higher level target to force misses
# Build combo points then use Eviscerate
```
- [ ] Energy refunded when finisher is dodged
- [ ] Energy refunded when finisher is parried
- [ ] Energy refunded when finisher misses
- [ ] Refund amount is 40%/80% of cost

---

### Master Poisoner (-31226 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x80000` (Deadly Poison), `SpellTypeMask=0x5`, `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests Master Poisoner increasing spell critical chance against poisoned targets.

**Test Steps:**
```
.learn 31226                       -- Master Poisoner Rank 1 (1% crit)
.learn 31227                       -- Master Poisoner Rank 2 (2% crit)
.learn 31228                       -- Master Poisoner Rank 3 (3% crit)
.learn 2823                        -- Deadly Poison
.additem 39714                     -- Dagger
.go creature id 32666
# Apply Deadly Poison via auto-attack
```
- [ ] Target takes increased spell crit chance
- [ ] Debuff applies on poison application
- [ ] Crit bonus matches talent rank (1%/2%/3%)

---

### Seal Fate (-14186 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x41F90000` + `SpellFamilyMask1=0x2`, `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `AttributesMask=0x2`, `Cooldown=500`
**Why:** Tests Seal Fate granting extra combo points on critical hits.

**Test Steps:**
```
.learn 14186                       -- Seal Fate Rank 1 (20% chance)
.learn 14190                       -- Seal Fate Rank 5 (100% chance)
.additem 39714                     -- High crit dagger
.go creature id 32666
.cast 1752                         -- Sinister Strike
```
- [ ] Extra combo point on critical Sinister Strike
- [ ] Extra combo point on critical Backstab
- [ ] Chance matches talent rank (20/40/60/80/100%)
- [ ] 0.5 second internal cooldown prevents double procs

---

### Ruthlessness (-14156 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x3E0C00` (Finishers), `SpellFamilyMask1=0x9`, `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests Ruthlessness granting combo point after finishing moves.

**Test Steps:**
```
.learn 14156                       -- Ruthlessness Rank 1 (20% chance)
.learn 14160                       -- Ruthlessness Rank 3 (60% chance)
.additem 39714                     -- Dagger
.go creature id 32666
# Build 5 combo points then:
.cast 2098                         -- Eviscerate
```
- [ ] Chance to gain combo point after finisher
- [ ] Works with Eviscerate
- [ ] Works with Rupture, Kidney Shot, Slice and Dice
- [ ] Chance matches talent rank (20%/40%/60%)

---

### Remorseless (-14143 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x47000006` + `SpellFamilyMask1=0x200000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `AttributesMask=0x8`
**Why:** Tests Remorseless giving crit bonus after killing enemies.

**Test Steps:**
```
.learn 14143                       -- Remorseless Rank 1 (20% crit bonus)
.learn 14149                       -- Remorseless Rank 3 (40% crit bonus)
# Kill a target, then immediately attack another
```
- [ ] Remorseless Attacks buff applied after kill
- [ ] Next ability has 20%/40% crit bonus
- [ ] Buff consumed on next ability use
- [ ] Only procs on kills that yield XP/honor (AttributesMask=0x8)

---

### Improved Kick (-13754 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x10` (Kick), `SpellPhaseMask=0x2`
**Why:** Tests Improved Kick silence effect when interrupting.

**Test Steps:**
```
.learn 13754                       -- Improved Kick Rank 1 (50% chance 1s silence)
.learn 13867                       -- Improved Kick Rank 2 (100% chance 2s silence)
.go creature id 32666
# Wait for target to cast, then:
.cast 1766                         -- Kick
```
- [ ] Kick interrupts spell successfully
- [ ] Silence applied for 1s/2s based on rank
- [ ] Chance is 50%/100% based on rank

---

### Throwing Specialization (-5952 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x1` (Deadly Throw), `SpellPhaseMask=0x2`
**Why:** Tests Throwing Specialization bonus effects on Deadly Throw.

**Test Steps:**
```
.learn 5952                        -- Throwing Specialization Rank 1
.learn 5953                        -- Throwing Specialization Rank 2
.learn 26679                       -- Deadly Throw
.additem 28504                     -- Throwing weapon
.go creature id 32666
# Build combo points then:
.cast 26679                        -- Deadly Throw
```
- [ ] Deadly Throw interrupts casting (with 3+ combo points)
- [ ] Fan of Knives damage increased
- [ ] Chance/effect matches talent rank

---

### Head Rush (28812)
**Proc Config:** `SpellFamilyMask0=0x2000006` (Sinister Strike/Backstab), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Bonescythe 4P set bonus Head Rush proc.

**Test Steps:**
```
# Need 4 pieces Bonescythe (Naxx 40):
.additem 22476                     -- Bonescythe Breastplate
.additem 22477                     -- Bonescythe Legplates
.additem 22478                     -- Bonescythe Helmet
.additem 22479                     -- Bonescythe Pauldrons
.additem 39714                     -- Dagger
.go creature id 32666
.cast 1752                         -- Sinister Strike
```
- [ ] Head Rush proc on critical Sinister Strike/Backstab
- [ ] Provides haste/speed bonus
- [ ] Only procs on criticals

---

### Deadly Throw Interrupt (32748)
**Proc Config:** `SpellFamilyMask1=0x1` (Deadly Throw), `ProcFlags=0x140` (RANGED), `SpellPhaseMask=0x2`
**Why:** Tests Deadly Throw interrupt with 3+ combo points.

**Test Steps:**
```
.learn 26679                       -- Deadly Throw
.additem 28504                     -- Throwing weapon
.go creature id 32666
# Build 3+ combo points, wait for target to cast:
.cast 26679                        -- Deadly Throw
```
- [ ] Deadly Throw interrupts with 3+ combo points
- [ ] Does NOT interrupt with 1-2 combo points
- [ ] Works on ranged cast

---

### Haste - Netherblade 2P (37165)
**Proc Config:** `SpellFamilyMask0=0x200400` (Slice and Dice), `SpellPhaseMask=0x2`
**Why:** Tests Netherblade 2P bonus on Slice and Dice.

**Test Steps:**
```
# Need 2 pieces Netherblade (T4):
# Search for Netherblade items with .lookup
.learn 5171                        -- Slice and Dice
.additem 39714                     -- Dagger
.go creature id 32666
.cast 5171                         -- Slice and Dice
```
- [ ] 2P bonus procs on Slice and Dice
- [ ] Haste buff applied
- [ ] Effect duration verified

---

### Finisher Combo - T4 4P (37168)
**Proc Config:** `SpellFamilyMask0=0x3E0C00` (Finishers), `SpellFamilyMask1=0x9`, `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests T4 4P bonus granting combo point on finishers.

**Test Steps:**
```
# Need 4 pieces T4 Netherblade set
.additem 39714                     -- Dagger
.go creature id 32666
# Build 5 combo points then:
.cast 2098                         -- Eviscerate
```
- [ ] Chance to gain combo point after finisher
- [ ] Stacks with Ruthlessness talent
- [ ] Works with all finishing moves

---

### Armor Penetration - T5 4P (37173)
**Proc Config:** `SpellFamilyMask0=0x2CC00008` (various attacks), `SpellFamilyMask1=0x106`, `SpellPhaseMask=0x2`, `Cooldown=30000`
**Why:** Tests T5 4P armor penetration proc.

**Test Steps:**
```
# Need 4 pieces T5 Deathmantle set
.additem 39714                     -- Dagger
.go creature id 32666
.cast 1752                         -- Sinister Strike
```
- [ ] Armor penetration buff procs
- [ ] 30 second internal cooldown
- [ ] Works with multiple attack types

---

### Glyph of Backstab (56800)
**Proc Config:** `SpellFamilyMask0=0x4` (Backstab), `ProcFlags=0x10` (MELEE), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Backstab extending Rupture duration.

**Test Steps:**
```
.additem 42956                     -- Glyph of Backstab (apply glyph)
.learn 1943                        -- Rupture
.additem 39714                     -- Dagger
.go creature id 32666
# Apply Rupture first:
.cast 1943                         -- Rupture
# Then from behind:
.cast 53                           -- Backstab
```
- [ ] Rupture duration extended by 2 seconds per Backstab
- [ ] Maximum extension is 6 seconds (3 Backstabs)
- [ ] Glyph effect active

---

### Glyph of Sinister Strike (56821)
**Proc Config:** `SpellFamilyMask0=0x2` (Sinister Strike), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `Cooldown=500`
**Why:** Tests Glyph of Sinister Strike granting extra combo point on crit.

**Test Steps:**
```
.additem 42972                     -- Glyph of Sinister Strike (apply glyph)
.additem 39714                     -- Dagger
.go creature id 32666
.cast 1752                         -- Sinister Strike (crit for bonus CP)
```
- [ ] Extra combo point on critical Sinister Strike
- [ ] 50% chance to proc
- [ ] 0.5 second internal cooldown
- [ ] Stacks with Seal Fate

---

### Item - Rogue T8 2P Bonus (64914)
**Proc Config:** `SpellFamilyMask0=0x10000` (Rupture), `SpellPhaseMask=0x2`
**Why:** Tests T8 2P bonus on Rupture.

**Test Steps:**
```
# Need 2 pieces T8 Terrorblade:
.additem 45396                     -- Valorous Terrorblade Breastplate
.additem 45397                     -- Valorous Terrorblade Gauntlets
.learn 1943                        -- Rupture
.additem 39714                     -- Dagger
.go creature id 32666
# Build combo points then:
.cast 1943                         -- Rupture
```
- [ ] 2P bonus procs on Rupture
- [ ] Increased damage/duration verified
- [ ] Effect active with 2+ set pieces

---

### Item - Rogue T9 2P Bonus - Rupture (67209)
**Proc Config:** `SchoolMask=0x1` (Physical), `SpellFamilyMask0=0x100000` (Rupture), `SpellPhaseMask=0x2`, `Cooldown=15000`
**Why:** Tests T9 2P bonus on Rupture dealing bonus damage.

**Test Steps:**
```
# Need 2 pieces T9 VanCleef/Garona:
.additem 48223                     -- VanCleef's Breastplate of Triumph
.additem 48224                     -- VanCleef's Gauntlets of Triumph
.learn 1943                        -- Rupture
.additem 39714                     -- Dagger
.go creature id 32666
.cast 1943                         -- Rupture
```
- [ ] 2P bonus procs additional damage
- [ ] 15 second internal cooldown
- [ ] Physical damage only (SchoolMask=0x1)

---

### Item - Rogue T10 4P Bonus (70803)
**Proc Config:** `SpellFamilyMask0=0x3E0C00` (Finishers), `SpellFamilyMask1=0x8` (Envenom), `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests T10 4P bonus on finishing moves.

**Test Steps:**
```
# Need 4 pieces T10 Shadowblade:
.additem 50087                     -- Shadowblade Breastplate
.additem 50088                     -- Shadowblade Gauntlets
.additem 50089                     -- Shadowblade Helmet
.additem 50090                     -- Shadowblade Legplates
.additem 39714                     -- Dagger
.go creature id 32666
# Build 5 combo points then:
.cast 2098                         -- Eviscerate
```
- [ ] 4P bonus procs on finishers
- [ ] Energy regeneration bonus verified
- [ ] Works with Eviscerate, Envenom, Rupture

---

### Item - Rogue T10 2P Bonus (70805)
**Proc Config:** `SpellFamilyMask1=0x20000` (Tricks of the Trade), `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T10 2P bonus on Tricks of the Trade.

**Test Steps:**
```
# Need 2 pieces T10 Shadowblade:
.additem 50087                     -- Shadowblade Breastplate
.additem 50088                     -- Shadowblade Gauntlets
.learn 57934                       -- Tricks of the Trade
# Target a party member:
.cast 57934                        -- Tricks of the Trade
```
- [ ] 2P bonus procs on Tricks of the Trade
- [ ] Bonus damage/threat transfer
- [ ] Triggers on cast, not damage (SpellTypeMask=0x4)

---

## Shaman Proc Tests (SpellFamilyName = 11)

### Frozen Power (-63373 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x80000000` (Frost Shock), `ProcFlags=0x10000` (TAKEN_SPELL_HIT), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Frozen Power root effect on Frost Shock hits.

**Test Steps:**
```
.learn 63373                       -- Frozen Power Rank 1 (50% chance)
.learn 63374                       -- Frozen Power Rank 2 (100% chance)
.learn 8042                        -- Earth Shock (for comparison)
.learn 8056                        -- Frost Shock
.go creature id 32666
.cast 8056                         -- Frost Shock
```
- [ ] Target rooted on Frost Shock hit
- [ ] Root chance matches talent rank (50%/100%)
- [ ] Does NOT proc from Earth Shock

---

### Tidal Waves (-51562 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x100` (Chain Heal), `SpellFamilyMask2=0x10` (Riptide), `SpellPhaseMask=0x2`
**Why:** Tests Tidal Waves haste buff on Chain Heal or Riptide.

**Test Steps:**
```
.learn 51562                       -- Tidal Waves Rank 1 (10% haste)
.learn 51566                       -- Tidal Waves Rank 5 (30% haste)
.learn 1064                        -- Chain Heal
.learn 61295                       -- Riptide
# Target a friendly player:
.cast 1064                         -- Chain Heal
```
- [ ] Tidal Waves buff applied after Chain Heal
- [ ] Tidal Waves buff applied after Riptide
- [ ] Buff provides haste to next Lesser Healing Wave/Healing Wave
- [ ] 2 charges consumed on use

---

### Ancestral Awakening (-51556 → all ranks)
**Proc Config:** `SpellFamilyMask0=0xC0` (Healing Wave/Lesser Healing Wave), `SpellFamilyMask2=0x10` (Riptide), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Ancestral Awakening heal on critical heals.

**Test Steps:**
```
.learn 51556                       -- Ancestral Awakening Rank 1 (10% heal)
.learn 51560                       -- Ancestral Awakening Rank 3 (30% heal)
.learn 331                         -- Healing Wave
# Target a friendly player, get a critical heal:
.cast 331                          -- Healing Wave
```
- [ ] Smart heal targets lowest health ally on crit
- [ ] Heal amount is 10%/20%/30% of original heal per rank
- [ ] Only procs on critical heals

---

### Static Shock (-51525 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Static Shock proc chance when Lightning Shield is active.

**Test Steps:**
```
.learn 51525                       -- Static Shock Rank 1 (2% chance)
.learn 51528                       -- Static Shock Rank 3 (6% chance)
.learn 324                         -- Lightning Shield
.additem 33185                     -- Weapon
.go creature id 32666
.cast 324                          -- Lightning Shield
# Attack with melee
```
- [ ] Lightning Shield charge consumed on hit
- [ ] Proc chance matches talent rank (2%/4%/6%)
- [ ] Works with melee attacks

---

### Earthen Power (-51523 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x1` (Stoneclaw Totem), `ProcFlags=0x10000` (TAKEN_HIT), `SpellPhaseMask=0x2`, `Chance=50`
**Why:** Tests Earthen Power snare removal from Earthbind Totem.

**Test Steps:**
```
.learn 51523                       -- Earthen Power Rank 1 (50% chance)
.learn 51524                       -- Earthen Power Rank 2 (100% chance)
.learn 2484                        -- Earthbind Totem
.go creature id 32666
.cast 2484                         -- Earthbind Totem
```
- [ ] Snares removed from nearby allies
- [ ] Proc chance matches talent rank
- [ ] Works with Earthbind Totem pulse

---

### Improved Stormstrike (-51521 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x1000000` (Stormstrike), `SpellPhaseMask=0x1` (CAST)
**Why:** Tests Improved Stormstrike mana return.

**Test Steps:**
```
.learn 51521                       -- Improved Stormstrike Rank 1
.learn 51522                       -- Improved Stormstrike Rank 2
.learn 17364                       -- Stormstrike
.additem 33185                     -- Weapon
.go creature id 32666
.cast 17364                        -- Stormstrike
```
- [ ] Mana refunded on Stormstrike cast
- [ ] Refund amount scales with talent rank

---

### Lightning Overload (-30675 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x3` (Lightning Bolt/Chain Lightning), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Lightning Overload extra cast proc.

**Test Steps:**
```
.learn 30675                       -- Lightning Overload Rank 1 (4% chance)
.learn 30679                       -- Lightning Overload Rank 5 (20% chance)
.learn 403                         -- Lightning Bolt
.learn 421                         -- Chain Lightning
.go creature id 32666
.cast 403                          -- Lightning Bolt
```
- [ ] Extra Lightning Bolt cast procs (50% damage, no threat)
- [ ] Proc chance matches talent rank (4%/8%/12%/16%/20%)
- [ ] Works with Chain Lightning

---

### Improved Water Shield (-16180 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x1C0` (Healing Wave/LHW/Chain Heal), `SpellFamilyMask2=0x10` (Riptide), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Improved Water Shield mana restoration on heal crits.

**Test Steps:**
```
.learn 16180                       -- Improved Water Shield Rank 1 (33% chance)
.learn 16196                       -- Improved Water Shield Rank 3 (100% chance)
.learn 52127                       -- Water Shield
.learn 331                         -- Healing Wave
.cast 52127                        -- Water Shield
# Get a critical heal:
.cast 331                          -- Healing Wave
```
- [ ] Water Shield charge consumed on heal crit
- [ ] Mana restored from orb
- [ ] Chance matches talent rank

---

### Ancestral Healing (-16176 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x1C0` (Healing Wave/LHW/Chain Heal), `SpellFamilyMask2=0x10` (Riptide), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Ancestral Healing armor buff on heal crits.

**Test Steps:**
```
.learn 16176                       -- Ancestral Healing Rank 1 (25% armor)
.learn 16235                       -- Ancestral Healing Rank 3 (25% armor)
.learn 331                         -- Healing Wave
# Target a friendly player, get a critical heal:
.cast 331                          -- Healing Wave
```
- [ ] Ancestral Fortitude buff applied on heal crit
- [ ] Target gains 25% armor for 15 sec
- [ ] Only procs on critical heals

---

### Elemental Mastery (16166)
**Proc Config:** `SpellFamilyMask0=0x3` (Lightning spells), `SpellFamilyMask1=0x1000` (Lava Burst), `SpellTypeMask=0x7` (ALL), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests Elemental Mastery consumption on Nature/Fire spell cast.

**Test Steps:**
```
.learn 16166                       -- Elemental Mastery
.learn 403                         -- Lightning Bolt
.cast 16166                        -- Activate Elemental Mastery
.cast 403                          -- Lightning Bolt
```
- [ ] Next spell is instant cast and guaranteed crit
- [ ] Buff consumed on spell cast
- [ ] Only consumes on spells with mana cost (AttributesMask=0x8)

---

### Clearcasting (16246)
**Proc Config:** `SpellFamilyMask0=0x98121E23` (most Shaman spells), `SpellFamilyMask1=0x1400`, `SpellFamilyMask2=0x10`, `SpellPhaseMask=0x1` (CAST), `AttributesMask=0xC`
**Why:** Tests Elemental Focus Clearcasting proc on spell crits.

**Test Steps:**
```
.learn 16164                       -- Elemental Focus (grants Clearcasting aura)
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt (crit to proc)
```
- [ ] Clearcasting buff grants 40% reduced mana cost
- [ ] 2 charges available
- [ ] Procs on spell criticals

---

### Lightning Shield - T2 8P (23551)
**Proc Config:** `SpellFamilyMask0=0xC0` (Healing spells), `SpellPhaseMask=0x2`
**Why:** Tests T2 8P bonus on healing spells.

**Test Steps:**
```
# Need 8 pieces Ten Storms (T2) set
.learn 331                         -- Healing Wave
.learn 324                         -- Lightning Shield
.cast 324                          -- Lightning Shield
.cast 331                          -- Healing Wave
```
- [ ] Lightning Shield charge proc on heal
- [ ] Effect triggers from healing spells

---

### Mana Surge - T3 8P (23572)
**Proc Config:** `SpellFamilyMask0=0xC0` (Healing spells), `SpellPhaseMask=0x2`, `Cooldown=1000`
**Why:** Tests T3 8P mana return on healing spells.

**Test Steps:**
```
# Need 8 pieces Earthshatter (T3) set
.learn 331                         -- Healing Wave
.cast 331                          -- Healing Wave
```
- [ ] Mana returned on heal cast
- [ ] 1 second internal cooldown

---

### Totemic Power - Naxx 4P (28823)
**Proc Config:** `SpellFamilyMask0=0xC0` (Healing spells), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Naxx 4P bonus on healing spells.

**Test Steps:**
```
# Need 4 pieces Earthshatter set
.learn 331                         -- Healing Wave
.cast 331                          -- Healing Wave
```
- [ ] Bonus effect procs on heal
- [ ] Healing increased

---

### Lesser Healing Wave - T2 3P (28849)
**Proc Config:** `SpellFamilyMask0=0x80` (Lesser Healing Wave), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T2 3P bonus on Lesser Healing Wave.

**Test Steps:**
```
# Need 3 pieces Ten Storms (T2) set
.learn 8004                        -- Lesser Healing Wave
.cast 8004                         -- Lesser Healing Wave
```
- [ ] Bonus effect procs on LHW
- [ ] Healing or mana effect verified

---

### Totem of the Third Wind (34138)
**Proc Config:** `SpellFamilyMask0=0x80` (Lesser Healing Wave), `SpellPhaseMask=0x2`
**Why:** Tests Totem of the Third Wind proc on LHW.

**Test Steps:**
```
.additem 25645                     -- Totem of the Third Wind
.learn 8004                        -- Lesser Healing Wave
.cast 8004                         -- Lesser Healing Wave
```
- [ ] Totem proc on LHW cast
- [ ] Healing bonus verified

---

### Improved Healing Wave - T5 4P (37227)
**Proc Config:** `SpellFamilyMask0=0x1C0` (Healing spells), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `Cooldown=60000`
**Why:** Tests T5 4P bonus on healing crit.

**Test Steps:**
```
# Need 4 pieces Cataclysm set (T5)
.learn 331                         -- Healing Wave
.cast 331                          -- Healing Wave (crit)
```
- [ ] Bonus effect procs on heal crit
- [ ] 60 second internal cooldown

---

### Lightning Bolt Discount - T5 2P (37237)
**Proc Config:** `SpellFamilyMask0=0x1` (Lightning Bolt), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests T5 2P bonus on Lightning Bolt crit.

**Test Steps:**
```
# Need 2 pieces Cataclysm set (T5)
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt (crit)
```
- [ ] Next spell mana cost reduced
- [ ] Only procs on criticals

---

### Shaman Tier 6 Trinket (40463)
**Proc Config:** `SpellFamilyMask0=0x81` (LB/LHW), `SpellFamilyMask1=0x10` (Earth Shock), `SpellTypeMask=0x3` (DAMAGE+HEAL), `SpellPhaseMask=0x2`
**Why:** Tests T6 trinket proc on damage/heal spells.

**Test Steps:**
```
# Need T6 trinket (Skyshatter set)
.learn 403                         -- Lightning Bolt
.learn 8004                        -- Lesser Healing Wave
.go creature id 32666
.cast 403                          -- Lightning Bolt
```
- [ ] Trinket effect procs on LB or LHW
- [ ] Bonus damage/healing verified

---

### Merciless Totem of Third Wind (42370)
**Proc Config:** `SpellFamilyMask0=0x80` (Lesser Healing Wave), `SpellPhaseMask=0x2`
**Why:** Tests S2 arena totem on LHW.

**Test Steps:**
```
.additem 33507                     -- Merciless Totem of Third Wind
.learn 8004                        -- Lesser Healing Wave
.cast 8004                         -- Lesser Healing Wave
```
- [ ] Totem effect procs on LHW
- [ ] Healing bonus verified

---

### Vengeful Totem of Third Wind (43728)
**Proc Config:** `SpellFamilyMask0=0x80` (Lesser Healing Wave), `SpellPhaseMask=0x2`
**Why:** Tests S3 arena totem on LHW.

**Test Steps:**
```
.additem 33939                     -- Vengeful Totem of Third Wind
.learn 8004                        -- Lesser Healing Wave
.cast 8004                         -- Lesser Healing Wave
```
- [ ] Totem effect procs on LHW
- [ ] Healing bonus verified

---

### Elemental Strength (43748)
**Proc Config:** `SpellFamilyMask0=0x90000000` (Shocks), `SpellPhaseMask=0x2`, `Cooldown=10000`
**Why:** Tests Elemental Strength proc on shock spells.

**Test Steps:**
```
# Need S4 Enhancement relic
.learn 8042                        -- Earth Shock
.go creature id 32666
.cast 8042                         -- Earth Shock
```
- [ ] Strength buff procs on shock
- [ ] 10 second internal cooldown

---

### Energized (43750)
**Proc Config:** `SpellFamilyMask0=0x1` (Lightning Bolt), `SpellPhaseMask=0x2`, `Cooldown=30000`
**Why:** Tests Energized haste proc on Lightning Bolt.

**Test Steps:**
```
# Need specific relic
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt
```
- [ ] Haste buff procs on LB
- [ ] 30 second internal cooldown

---

### Brutal Totem of Third Wind (46098)
**Proc Config:** `SpellFamilyMask0=0x80` (Lesser Healing Wave), `SpellPhaseMask=0x2`
**Why:** Tests S4 arena totem on LHW.

**Test Steps:**
```
.additem 35112                     -- Brutal Totem of Third Wind
.learn 8004                        -- Lesser Healing Wave
.cast 8004                         -- Lesser Healing Wave
```
- [ ] Totem effect procs on LHW
- [ ] Healing bonus verified

---

### Elemental Tenacity (48837)
**Proc Config:** `SpellFamilyMask0=0x90000000` (Shocks), `SpellPhaseMask=0x2`, `Cooldown=10000`
**Why:** Tests Elemental Tenacity proc on shocks.

**Test Steps:**
```
# Need specific relic
.learn 8042                        -- Earth Shock
.go creature id 32666
.cast 8042                         -- Earth Shock
```
- [ ] Bonus effect procs
- [ ] 10 second internal cooldown

---

### Maelstrom Weapon (53817)
**Proc Config:** `SpellFamilyMask0=0x1C3` (Lightning/Healing spells), `SpellFamilyMask1=0x8000` (Hex), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests Maelstrom Weapon stack consumption on instant cast.

**Test Steps:**
```
.learn 51530                       -- Maelstrom Weapon
.additem 33185                     -- Weapon
.go creature id 32666
# Attack until 5 stacks
.cast 403                          -- Lightning Bolt (instant at 5 stacks)
```
- [ ] Lightning Bolt cast is instant at 5 stacks
- [ ] Stacks consumed on cast
- [ ] Works with Healing Wave, Chain Lightning, etc.

---

### Tidal Force (55198)
**Proc Config:** `SpellFamilyMask0=0x1C0` (Healing spells), `ProcFlags=0x4000`, `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Tidal Force consuming charge on heal crit.

**Test Steps:**
```
.learn 55198                       -- Tidal Force
.learn 331                         -- Healing Wave
.cast 55198                        -- Activate Tidal Force
.cast 331                          -- Healing Wave (crit)
```
- [ ] Tidal Force charge consumed on heal crit
- [ ] Provides 60% crit bonus
- [ ] 3 charges available

---

### Glyph of Healing Wave (55440)
**Proc Config:** `SpellFamilyMask0=0x40` (Healing Wave), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Healing Wave self-heal on target heal.

**Test Steps:**
```
.additem 41534                     -- Glyph of Healing Wave (apply glyph)
.learn 331                         -- Healing Wave
# Target another player:
.cast 331                          -- Healing Wave
```
- [ ] Self heals for 20% of Healing Wave amount
- [ ] Only works when healing others
- [ ] Glyph effect active

---

### Gladiator's Totem of Survival (60564-60575)
**Proc Config:** `SpellFamilyMask0=0x90000000` (Shocks), `SpellPhaseMask=0x2`
**Why:** Tests Gladiator totem proc on shock spells.

**Test Steps:**
```
# Need Gladiator's Totem of Survival (any season)
.learn 8042                        -- Earth Shock
.go creature id 32666
.cast 8042                         -- Earth Shock
```
- [ ] Totem effect procs on shock
- [ ] Survivability bonus verified

---

### Totem of the Elemental Plane (60770)
**Proc Config:** `SpellFamilyMask0=0x1` (Lightning Bolt), `SpellPhaseMask=0x2`, `Cooldown=30000`
**Why:** Tests Totem of the Elemental Plane on Lightning Bolt.

**Test Steps:**
```
.additem 44535                     -- Totem of the Elemental Plane
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt
```
- [ ] Totem effect procs on LB
- [ ] 30 second internal cooldown

---

### Glyph of Earth Shield (63279)
**Proc Config:** `SpellFamilyMask1=0x400` (Earth Shield), `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Earth Shield increasing charges.

**Test Steps:**
```
.additem 45775                     -- Glyph of Earth Shield (apply glyph)
.learn 974                         -- Earth Shield
# Target a friendly player:
.cast 974                          -- Earth Shield
```
- [ ] Earth Shield has 2 additional charges
- [ ] Total of 8 charges with glyph
- [ ] Glyph effect active

---

### Glyph of Totem of Wrath (63280)
**Proc Config:** `SpellFamilyMask0=0x20000000` (Totem of Wrath), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x2`
**Why:** Tests Glyph of Totem of Wrath spell power bonus.

**Test Steps:**
```
.additem 45776                     -- Glyph of Totem of Wrath (apply glyph)
.learn 30706                       -- Totem of Wrath
.cast 30706                        -- Totem of Wrath
```
- [ ] 30% of totem's spell power added to caster
- [ ] Buff lasts while totem is active
- [ ] Glyph effect active

---

### Item - Shaman T8 Elemental 4P Bonus (64928)
**Proc Config:** `SpellFamilyMask0=0x1` (Lightning Bolt), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests T8 4P Elemental bonus on Lightning Bolt crit.

**Test Steps:**
```
# Need 4 pieces T8 Worldbreaker (Elemental):
.additem 45401                     -- Valorous Worldbreaker Handguards
.additem 45402                     -- Valorous Worldbreaker Headpiece
.additem 45403                     -- Valorous Worldbreaker Legguards
.additem 45404                     -- Valorous Worldbreaker Spaulders
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt (crit)
```
- [ ] 4P bonus procs on LB crit
- [ ] Bonus damage effect verified

---

### Item - Shaman T9 Elemental 4P Bonus - Lava Burst (67228)
**Proc Config:** `SpellFamilyMask1=0x1000` (Lava Burst), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests T9 4P Elemental bonus on Lava Burst.

**Test Steps:**
```
# Need 4 pieces T9 Thrall's/Nobundo's:
# Use .lookup for specific T9 pieces
.learn 51505                       -- Lava Burst
.learn 8050                        -- Flame Shock (for guaranteed crit)
.go creature id 32666
.cast 8050                         -- Flame Shock
.cast 51505                        -- Lava Burst
```
- [ ] 4P bonus procs on Lava Burst
- [ ] Bonus damage/effect verified

---

### Item - Shaman T9 Elemental Relic - Lightning Bolt (67386)
**Proc Config:** `SpellFamilyMask0=0x1` (Lightning Bolt), `ProcFlags=0x10000`, `SpellPhaseMask=0x1` (CAST), `Cooldown=6000`
**Why:** Tests T9 Elemental relic on Lightning Bolt.

**Test Steps:**
```
# Need T9 Elemental relic
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt
```
- [ ] Relic effect procs on LB cast
- [ ] 6 second internal cooldown

---

### Item - Shaman T9 Restoration Relic - Chain Heal (67389)
**Proc Config:** `SpellFamilyMask0=0x100` (Chain Heal), `ProcFlags=0x4000`, `SpellPhaseMask=0x1` (CAST), `Cooldown=8000`
**Why:** Tests T9 Restoration relic on Chain Heal.

**Test Steps:**
```
# Need T9 Restoration relic
.learn 1064                        -- Chain Heal
.cast 1064                         -- Chain Heal
```
- [ ] Relic effect procs on Chain Heal
- [ ] 8 second internal cooldown

---

### Item - Shaman T9 Enhancement Relic - Lava Lash (67392)
**Proc Config:** `SpellFamilyMask2=0x4` (Lava Lash), `ProcFlags=0x10` (MELEE), `SpellPhaseMask=0x2`, `Cooldown=9000`
**Why:** Tests T9 Enhancement relic on Lava Lash.

**Test Steps:**
```
# Need T9 Enhancement relic
.learn 60103                       -- Lava Lash
.additem 33185                     -- Main hand weapon
.additem 33186                     -- Off hand weapon (for Lava Lash)
.go creature id 32666
.cast 60103                        -- Lava Lash
```
- [ ] Relic effect procs on Lava Lash
- [ ] 9 second internal cooldown

---

### Item - Shaman T10 Restoration 2P Bonus (70807)
**Proc Config:** `SpellFamilyMask2=0x10` (Riptide), `SpellPhaseMask=0x2`
**Why:** Tests T10 2P Restoration bonus on Riptide.

**Test Steps:**
```
# Need 2 pieces T10 Frost Witch (Restoration):
.additem 50841                     -- Frost Witch's Hauberk
.additem 50842                     -- Frost Witch's Gloves
.learn 61295                       -- Riptide
.cast 61295                        -- Riptide
```
- [ ] 2P bonus procs on Riptide
- [ ] Bonus healing effect verified

---

### Item - Shaman T10 Restoration 4P Bonus (70808)
**Proc Config:** `SpellFamilyMask0=0x100` (Chain Heal), `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests T10 4P Restoration bonus on Chain Heal crit.

**Test Steps:**
```
# Need 4 pieces T10 Frost Witch (Restoration):
.additem 50841                     -- Frost Witch's Hauberk
.additem 50842                     -- Frost Witch's Gloves
.additem 50843                     -- Frost Witch's Helm
.additem 50844                     -- Frost Witch's Kilt
.learn 1064                        -- Chain Heal
.cast 1064                         -- Chain Heal (crit)
```
- [ ] 4P bonus procs on Chain Heal crit
- [ ] Bonus healing/HoT effect verified

---

### Item - Shaman T10 Elemental 2P Bonus (70811)
**Proc Config:** `SpellFamilyMask0=0x3` (Lightning spells), `SpellPhaseMask=0x1` (CAST)
**Why:** Tests T10 2P Elemental bonus on Lightning Bolt/Chain Lightning.

**Test Steps:**
```
# Need 2 pieces T10 Frost Witch (Elemental):
.additem 50835                     -- Frost Witch's Tunic
.additem 50836                     -- Frost Witch's Handguards
.learn 403                         -- Lightning Bolt
.go creature id 32666
.cast 403                          -- Lightning Bolt
```
- [ ] 2P bonus procs on LB/CL cast
- [ ] Bonus damage effect verified

---

### Item - Shaman T10 Elemental 4P Bonus (70817)
**Proc Config:** `SpellFamilyMask1=0x1000` (Lava Burst), `ProcFlags=0x10000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests T10 4P Elemental bonus on Lava Burst.

**Test Steps:**
```
# Need 4 pieces T10 Frost Witch (Elemental):
.additem 50835                     -- Frost Witch's Tunic
.additem 50836                     -- Frost Witch's Handguards
.additem 50837                     -- Frost Witch's Headpiece
.additem 50838                     -- Frost Witch's Legguards
.learn 51505                       -- Lava Burst
.learn 8050                        -- Flame Shock
.go creature id 32666
.cast 8050                         -- Flame Shock
.cast 51505                        -- Lava Burst
```
- [ ] 4P bonus procs on Lava Burst
- [ ] Flame Shock DoT extended

---

### Item - Shaman T10 Enhancement 2P Bonus (70830)
**Proc Config:** `SpellFamilyMask1=0x20000` (Spirit Wolves), `SpellPhaseMask=0x2`
**Why:** Tests T10 2P Enhancement bonus on Spirit Wolves.

**Test Steps:**
```
# Need 2 pieces T10 Frost Witch (Enhancement):
.additem 50830                     -- Frost Witch's Chestguard
.additem 50831                     -- Frost Witch's Grips
.learn 51533                       -- Feral Spirit (Spirit Wolves)
.cast 51533                        -- Feral Spirit
```
- [ ] 2P bonus procs on Feral Spirit cast
- [ ] Bonus effect on wolves verified

---

### Item - Shaman T10 Elemental Relic - Shocks (71198)
**Proc Config:** `SchoolMask=0x4` (Fire), `SpellFamilyMask0=0x10000000` (Flame Shock), `SpellPhaseMask=0x2`
**Why:** Tests T10 Elemental relic on Fire shock spells.

**Test Steps:**
```
# Need T10 Elemental relic
.learn 8050                        -- Flame Shock
.go creature id 32666
.cast 8050                         -- Flame Shock
```
- [ ] Relic effect procs on Flame Shock
- [ ] Fire spell bonus verified

---

### Item - Shaman T10 Enhancement Relic - Stormstrike (71214)
**Proc Config:** `SpellFamilyMask1=0x10` (Stormstrike), `ProcFlags=0x10` (MELEE), `SpellPhaseMask=0x2`
**Why:** Tests T10 Enhancement relic on Stormstrike.

**Test Steps:**
```
# Need T10 Enhancement relic
.learn 17364                       -- Stormstrike
.additem 33185                     -- Weapon
.go creature id 32666
.cast 17364                        -- Stormstrike
```
- [ ] Relic effect procs on Stormstrike
- [ ] Attack power/damage bonus verified

---

### Item - Shaman T10 Restoration Relic - Riptide (71217)
**Proc Config:** `SpellFamilyMask2=0x10` (Riptide), `SpellPhaseMask=0x2`
**Why:** Tests T10 Restoration relic on Riptide.

**Test Steps:**
```
# Need T10 Restoration relic
.learn 61295                       -- Riptide
.cast 61295                        -- Riptide
```
- [ ] Relic effect procs on Riptide
- [ ] Healing bonus verified

---

## Warlock Proc Tests (SpellFamilyName = 5)

### Decimation (-63156 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x1` (Shadow Bolt), `SpellFamilyMask1=0xC0` (Incinerate/Soulfire), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Decimation proc when target is at low health.

**Test Steps:**
```
.learn 63156                       -- Decimation Rank 1 (2% chance)
.learn 63158                       -- Decimation Rank 2 (4% chance)
.learn 686                         -- Shadow Bolt
.learn 17962                       -- Incinerate
.go creature id 32666
# Damage target below 35% health, then:
.cast 686                          -- Shadow Bolt
```
- [ ] Soul Fire becomes instant when target below 35% health
- [ ] Proc chance matches talent rank
- [ ] Works with Shadow Bolt and Incinerate

---

### Torture (-47263 → all ranks)
**Proc Config:** `SchoolMask=0x20` (Shadow), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL), `Cooldown=20000`
**Why:** Tests Torture proc on Shadow spell crits.

**Test Steps:**
```
.learn 47263                       -- Torture Rank 1
.learn 47264                       -- Torture Rank 2
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 686                          -- Shadow Bolt (crit)
```
- [ ] Bonus effect procs on Shadow crit
- [ ] 20 second internal cooldown

---

### Backdraft (-47258 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x800000` (Conflagrate), `SpellPhaseMask=0x2`
**Why:** Tests Backdraft cast speed buff on Conflagrate.

**Test Steps:**
```
.learn 47258                       -- Backdraft Rank 1 (10% haste)
.learn 47260                       -- Backdraft Rank 3 (30% haste)
.learn 17962                       -- Conflagrate
.learn 348                         -- Immolate
.go creature id 32666
.cast 348                          -- Immolate (apply first)
.cast 17962                        -- Conflagrate
```
- [ ] Backdraft buff applied after Conflagrate
- [ ] 3 charges of 10%/20%/30% haste based on rank
- [ ] Consumed by next 3 Shadow Bolt/Incinerate casts

---

### Molten Core (-47245 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x2` (Corruption), `ProcFlags=0x40000` (DoT tick), `SpellPhaseMask=0x2`
**Why:** Tests Molten Core proc on Corruption damage.

**Test Steps:**
```
.learn 47245                       -- Molten Core Rank 1 (4% chance)
.learn 47247                       -- Molten Core Rank 3 (12% chance)
.learn 172                         -- Corruption
.learn 29722                       -- Incinerate
.go creature id 32666
.cast 172                          -- Corruption
# Wait for DoT ticks
```
- [ ] Molten Core procs on Corruption ticks
- [ ] Increases Incinerate/Soulfire damage by 6%/12%/18%
- [ ] Grants 3 charges

---

### Everlasting Affliction (-47201 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x4009` (SB/Drain Life/Haunt), `SpellFamilyMask1=0x40000` (Haunt), `SpellPhaseMask=0x2`
**Why:** Tests Everlasting Affliction refreshing Corruption.

**Test Steps:**
```
.learn 47201                       -- Everlasting Affliction Rank 1
.learn 47205                       -- Everlasting Affliction Rank 5
.learn 172                         -- Corruption
.learn 686                         -- Shadow Bolt
.learn 689                         -- Drain Life
.go creature id 32666
.cast 172                          -- Corruption
.cast 686                          -- Shadow Bolt
```
- [ ] Corruption refreshed by Shadow Bolt
- [ ] Corruption refreshed by Drain Life
- [ ] Corruption refreshed by Haunt

---

### Eradication (-47195 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x2` (Corruption), `SpellPhaseMask=0x2`
**Why:** Tests Eradication haste buff on Corruption damage.

**Test Steps:**
```
.learn 47195                       -- Eradication Rank 1 (4% chance, 6% haste)
.learn 47197                       -- Eradication Rank 3 (6% chance, 20% haste)
.learn 172                         -- Corruption
.go creature id 32666
.cast 172                          -- Corruption
# Wait for DoT ticks
```
- [ ] Eradication buff grants casting haste
- [ ] Proc chance matches talent rank (4%/5%/6%)
- [ ] Haste amount scales with rank (6%/12%/20%)

---

### Shadow Embrace (-32385 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x1` (Shadow Bolt), `SpellFamilyMask1=0x40000` (Haunt), `SpellPhaseMask=0x2`
**Why:** Tests Shadow Embrace debuff stacking from Shadow Bolt/Haunt.

**Test Steps:**
```
.learn 32385                       -- Shadow Embrace Rank 1 (1% debuff)
.learn 32394                       -- Shadow Embrace Rank 5 (5% debuff)
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 686                          -- Shadow Bolt
.cast 686                          -- Shadow Bolt (2nd stack)
.cast 686                          -- Shadow Bolt (3rd stack)
```
- [ ] Shadow Embrace debuff applied
- [ ] Stacks up to 3 times
- [ ] Increases periodic Shadow damage by 1%/2%/3%/4%/5% per stack

---

### Soul Leech (-30293 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x181` (various damage), `SpellFamilyMask1=0x821040` (various damage), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Soul Leech self-heal on damage.

**Test Steps:**
```
.learn 30293                       -- Soul Leech Rank 1 (10% heal)
.learn 30296                       -- Soul Leech Rank 3 (30% heal)
.learn 686                         -- Shadow Bolt
.learn 17962                       -- Conflagrate
.go creature id 32666
.cast 686                          -- Shadow Bolt
```
- [ ] Heals for 10%/20%/30% of damage dealt
- [ ] Works with Shadow Bolt, Shadowburn, Conflagrate
- [ ] Works with Soulfire, Chaos Bolt, Incinerate

---

### Improved Drain Soul (-18213 → all ranks)
**Proc Config:** `SchoolMask=0x20` (Shadow), `SpellFamilyMask0=0x4000` (Drain Soul), `ProcFlags=0x2` (KILL)
**Why:** Tests Improved Drain Soul mana regen on kill.

**Test Steps:**
```
.learn 18213                       -- Improved Drain Soul Rank 1
.learn 18372                       -- Improved Drain Soul Rank 2
.learn 1120                        -- Drain Soul
.go creature id 32541              -- Low HP target
.cast 1120                         -- Drain Soul (kill target)
```
- [ ] Mana restored on kill with Drain Soul
- [ ] Mana regen buff applied for 10 sec
- [ ] Soul shard generated

---

### Aftermath (-18119 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x800000` (Conflagrate), `SpellPhaseMask=0x2`
**Why:** Tests Aftermath stun proc on Conflagrate.

**Test Steps:**
```
.learn 18119                       -- Aftermath Rank 1 (50% chance)
.learn 18120                       -- Aftermath Rank 2 (100% chance)
.learn 17962                       -- Conflagrate
.learn 348                         -- Immolate
.go creature id 32666
.cast 348                          -- Immolate
.cast 17962                        -- Conflagrate
```
- [ ] Target stunned for 2 sec
- [ ] Chance matches talent rank (50%/100%)
- [ ] Stun effect confirmed

---

### Pyroclasm (-18096 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x100` (Rain of Fire), `SpellFamilyMask1=0x800000` (Conflagrate), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Pyroclasm stun on Rain of Fire/Conflagrate crit.

**Test Steps:**
```
.learn 18096                       -- Pyroclasm Rank 1 (13% chance)
.learn 18073                       -- Pyroclasm Rank 3 (26% chance)
.learn 5740                        -- Rain of Fire
.go creature id 32666
.cast 5740                         -- Rain of Fire (crit)
```
- [ ] Target stunned on Rain of Fire crit
- [ ] Target stunned on Conflagrate crit
- [ ] Chance matches talent rank

---

### Nightfall (-18094 → all ranks)
**Proc Config:** `SpellFamilyMask0=0xA` (Corruption/Drain Life), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=6000`
**Why:** Tests Nightfall (Shadow Trance) proc on DoT damage.

**Test Steps:**
```
.learn 18094                       -- Nightfall Rank 1 (2% chance)
.learn 18095                       -- Nightfall Rank 2 (4% chance)
.learn 172                         -- Corruption
.learn 689                         -- Drain Life
.go creature id 32666
.cast 172                          -- Corruption
# Wait for DoT ticks
```
- [ ] Shadow Trance proc makes Shadow Bolt instant
- [ ] Proc chance matches talent rank (2%/4%)
- [ ] 6 second internal cooldown

---

### Improved Shadow Bolt (-17793 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x1` (Shadow Bolt), `SpellPhaseMask=0x2`
**Why:** Tests Improved Shadow Bolt debuff application.

**Test Steps:**
```
.learn 17793                       -- Improved Shadow Bolt Rank 1 (4% crit bonus)
.learn 17800                       -- Improved Shadow Bolt Rank 5 (20% crit bonus)
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 686                          -- Shadow Bolt
```
- [ ] Shadow Mastery debuff applied on target
- [ ] Target takes 4%/8%/12%/16%/20% more Shadow damage
- [ ] Debuff has 4 charges (refreshed per bolt)

---

### Shadow Trance (17941)
**Proc Config:** `SpellFamilyMask0=0x1` (Shadow Bolt), `ProcFlags=0x10000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests Shadow Trance consumption when casting Shadow Bolt.

**Test Steps:**
```
# Get Shadow Trance proc from Nightfall
.learn 18094                       -- Nightfall
.learn 172                         -- Corruption
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 172                          -- Corruption (wait for Nightfall proc)
.cast 686                          -- Shadow Bolt (instant with proc)
```
- [ ] Shadow Bolt is instant cast with Shadow Trance
- [ ] Buff consumed on cast
- [ ] Only consumes on spells with mana cost

---

### Fel Domination (18708)
**Proc Config:** `SpellFamilyMask0=0x20000000` (Summon Demon), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests Fel Domination consumption on demon summon.

**Test Steps:**
```
.learn 18708                       -- Fel Domination
.learn 688                         -- Summon Imp
.cast 18708                        -- Activate Fel Domination
.cast 688                          -- Summon Imp
```
- [ ] Summon is instant and costs 50% less mana
- [ ] Buff consumed on summon
- [ ] Works with all demon summons

---

### Backlash (34936)
**Proc Config:** `SpellFamilyMask0=0x1` (Shadow Bolt), `SpellFamilyMask1=0x40` (Incinerate), `ProcFlags=0x10000`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests Backlash instant Shadow Bolt/Incinerate proc.

**Test Steps:**
```
.learn 34936                       -- Backlash (from talent)
.learn 686                         -- Shadow Bolt
.learn 29722                       -- Incinerate
.go creature id 32666
# Get hit by physical attack to proc Backlash
.cast 686                          -- Shadow Bolt (instant with proc)
```
- [ ] Shadow Bolt/Incinerate is instant with proc
- [ ] Procs when struck by physical attack
- [ ] Buff consumed on cast

---

### Shadowflame - T5 4P (37377)
**Proc Config:** `SchoolMask=0x20` (Shadow), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests T5 4P bonus on Shadow spell damage.

**Test Steps:**
```
# Need 4 pieces T5 Corruptor set
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 686                          -- Shadow Bolt
```
- [ ] Bonus fire damage procs on Shadow spells
- [ ] Bonus damage verified

---

### Flameshadow - T5 4P (37379)
**Proc Config:** `SchoolMask=0x20` (Shadow), `SpellPhaseMask=0x2`
**Why:** Tests T5 4P alternate bonus.

**Test Steps:**
```
# Need 4 pieces T5 Corruptor set
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 686                          -- Shadow Bolt
```
- [ ] Bonus effect procs on Shadow spells

---

### Improved Corruption and Immolate - T5 2P (37384)
**Proc Config:** `SpellFamilyMask0=0x1` (Shadow Bolt), `SpellFamilyMask1=0x40` (Incinerate), `SpellPhaseMask=0x2`
**Why:** Tests T5 2P bonus on Shadow Bolt/Incinerate.

**Test Steps:**
```
# Need 2 pieces T5 Corruptor set
.learn 686                         -- Shadow Bolt
.learn 29722                       -- Incinerate
.go creature id 32666
.cast 686                          -- Shadow Bolt
```
- [ ] DoT duration increased
- [ ] Works with Shadow Bolt and Incinerate

---

### DoT Heals - T4 4P (38394)
**Proc Config:** `SpellFamilyMask0=0x6` (Corruption/Immolate), `SpellPhaseMask=0x2`
**Why:** Tests T4 4P healing on DoT damage.

**Test Steps:**
```
# Need 4 pieces T4 Voidheart set
.learn 172                         -- Corruption
.learn 348                         -- Immolate
.go creature id 32666
.cast 172                          -- Corruption
```
- [ ] Heals for portion of DoT damage
- [ ] Works with Corruption and Immolate

---

### Shadowflame Hellfire and RoF - T6 (39437)
**Proc Config:** `SchoolMask=0x4` (Fire), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests T6 bonus on Hellfire/Rain of Fire.

**Test Steps:**
```
# Need T6 Malefic set
.learn 1949                        -- Hellfire
.learn 5740                        -- Rain of Fire
.go creature id 32666
.cast 5740                         -- Rain of Fire
```
- [ ] Bonus effect procs on AoE damage
- [ ] Shadow damage bonus verified

---

### Warlock Tier 6 Trinket (40478)
**Proc Config:** `SpellFamilyMask0=0x2` (Corruption), `SpellPhaseMask=0x2`
**Why:** Tests T6 trinket on Corruption.

**Test Steps:**
```
# Need T6 trinket
.learn 172                         -- Corruption
.go creature id 32666
.cast 172                          -- Corruption
```
- [ ] Trinket effect procs on Corruption
- [ ] Bonus verified

---

### Molten Core - T7 4P (47383)
**Proc Config:** `SpellFamilyMask1=0xC0` (Incinerate/Soulfire), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests T7 4P bonus consuming Molten Core stacks.

**Test Steps:**
```
# Need 4 pieces T7 Plagueheart set
.learn 47245                       -- Molten Core
.learn 29722                       -- Incinerate
.learn 6353                        -- Soul Fire
.go creature id 32666
# Get Molten Core proc, then:
.cast 29722                        -- Incinerate
```
- [ ] Molten Core stack consumed
- [ ] Bonus damage verified

---

### Backdraft Rank 1 (54274)
**Proc Config:** `SpellFamilyMask0=0x165` (various), `SpellFamilyMask1=0x20080` (various), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests Backdraft buff consumption.

**Test Steps:**
```
.learn 47258                       -- Backdraft Rank 1
.learn 17962                       -- Conflagrate
.learn 686                         -- Shadow Bolt
.learn 348                         -- Immolate
.go creature id 32666
.cast 348                          -- Immolate
.cast 17962                        -- Conflagrate (procs Backdraft)
.cast 686                          -- Shadow Bolt (consumes charge)
```
- [ ] Backdraft charge consumed on Shadow Bolt/Incinerate
- [ ] 3 charges available
- [ ] Cast speed bonus verified

---

### Glyph of Corruption (56218)
**Proc Config:** `SpellFamilyMask0=0x2` (Corruption), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=6000`
**Why:** Tests Glyph of Corruption instant cast Shadow Bolt proc.

**Test Steps:**
```
.additem 42455                     -- Glyph of Corruption (apply glyph)
.learn 172                         -- Corruption
.learn 686                         -- Shadow Bolt
.go creature id 32666
.cast 172                          -- Corruption
# Wait for DoT ticks
```
- [ ] Shadow Bolt becomes instant on Corruption ticks
- [ ] 4% proc chance
- [ ] 6 second internal cooldown

---

### Glyph of Felhunter (56249)
**Proc Config:** `SpellFamilyMask2=0x400` (Felhunter abilities), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Felhunter bonus effects.

**Test Steps:**
```
.additem 42460                     -- Glyph of Felhunter (apply glyph)
.learn 691                         -- Summon Felhunter
.cast 691                          -- Summon Felhunter
```
- [ ] Felhunter bonus effect verified
- [ ] Glyph effect active

---

### Corruption Triggers Crit (60170)
**Proc Config:** `SpellFamilyMask0=0x6` (Corruption/Immolate), `SpellPhaseMask=0x2`
**Why:** Tests T7 2P bonus crit buff on DoT damage.

**Test Steps:**
```
# Need 2 pieces T7 Plagueheart set
.learn 172                         -- Corruption
.learn 348                         -- Immolate
.go creature id 32666
.cast 172                          -- Corruption
```
- [ ] Crit buff procs on DoT damage
- [ ] Works with Corruption and Immolate

---

### Life Tap Bonus Spirit (60172)
**Proc Config:** `SpellFamilyMask0=0x40000` (Life Tap), `SpellPhaseMask=0x2`
**Why:** Tests T7 4P bonus Spirit buff on Life Tap.

**Test Steps:**
```
# Need 4 pieces T7 Plagueheart set
.learn 1454                        -- Life Tap
.cast 1454                         -- Life Tap
```
- [ ] Spirit buff procs on Life Tap
- [ ] Bonus duration verified

---

### Chaotic Mind (61188)
**Proc Config:** `SpellFamilyMask0=0x4` (Drain Life), `SpellPhaseMask=0x2`
**Why:** Tests bonus effect on Drain Life.

**Test Steps:**
```
.learn 689                         -- Drain Life
.go creature id 32666
.cast 689                          -- Drain Life
```
- [ ] Bonus effect procs on Drain Life
- [ ] Effect verified

---

### Siphon Life (63108)
**Proc Config:** `SpellFamilyMask0=0x2` (Corruption), `SpellPhaseMask=0x2`
**Why:** Tests Siphon Life healing on Corruption damage.

**Test Steps:**
```
.learn 63108                       -- Siphon Life (passive from Corruption)
.learn 172                         -- Corruption
.go creature id 32666
.cast 172                          -- Corruption
# Wait for DoT ticks
```
- [ ] Healing procs on Corruption ticks
- [ ] Heal amount is 40% of damage dealt

---

### Glyph of Shadowflame (63310)
**Proc Config:** `SpellFamilyMask1=0x10000` (Shadowflame), `ProcFlags=0x10000`, `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Shadowflame slow effect.

**Test Steps:**
```
.additem 45783                     -- Glyph of Shadowflame (apply glyph)
.learn 47897                       -- Shadowflame
.go creature id 32666
.cast 47897                        -- Shadowflame
```
- [ ] Target slowed by 70%
- [ ] Slow lasts 5 seconds
- [ ] Glyph effect active

---

### Glyph of Life Tap (63320)
**Proc Config:** `SpellFamilyMask0=0x80040000` (Life Tap), `SpellFamilyMask2=0x8000`, `ProcFlags=0x400`, `SpellTypeMask=0x7` (ALL), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Life Tap Spirit buff.

**Test Steps:**
```
.additem 45785                     -- Glyph of Life Tap (apply glyph)
.learn 1454                        -- Life Tap
.cast 1454                         -- Life Tap
```
- [ ] Spirit buff applied for 40 seconds
- [ ] 20% of Spirit added to spell power
- [ ] Glyph effect active

---

### Item - Warlock T10 4P Bonus (70841)
**Proc Config:** `SpellFamilyMask0=0x4` (Drain Life/Drain Soul), `SpellFamilyMask1=0x100` (Haunt), `SpellPhaseMask=0x2`
**Why:** Tests T10 4P bonus on Drain Life or Haunt.

**Test Steps:**
```
# Need 4 pieces T10 Dark Coven:
.additem 50240                     -- Dark Coven Gloves
.additem 50241                     -- Dark Coven Hood
.additem 50242                     -- Dark Coven Leggings
.additem 50243                     -- Dark Coven Robe
.learn 689                         -- Drain Life
.learn 48181                       -- Haunt
.go creature id 32666
.cast 689                          -- Drain Life
```
- [ ] 4P bonus procs on Drain Life/Soul/Haunt
- [ ] Increases Drain/Haunt damage
- [ ] Damage increase verified

---

### Molten Core - T10 Rank 2/3 (71162/71165)
**Proc Config:** `SpellFamilyMask1=0xC0` (Incinerate/Soulfire), `SpellPhaseMask=0x1` (CAST), `AttributesMask=0x8`
**Why:** Tests T10 version of Molten Core consumption.

**Test Steps:**
```
# Need 2 pieces T10 Dark Coven:
.additem 50240                     -- Dark Coven Gloves
.additem 50241                     -- Dark Coven Hood
.learn 47245                       -- Molten Core
.learn 29722                       -- Incinerate
.go creature id 32666
# Get Molten Core proc:
.cast 29722                        -- Incinerate
```
- [ ] Enhanced Molten Core effect
- [ ] Set bonus verified

---

## Warrior Proc Tests (SpellFamilyName = 4)

### Improved Spell Reflection (-59088 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x2` (Spell Reflection), `ProcFlags=0x400`, `SpellTypeMask=0x4` (NO_DMG_HEAL), `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests Improved Spell Reflection party effect.

**Test Steps:**
```
.learn 59088                       -- Improved Spell Reflection Rank 1
.learn 59089                       -- Improved Spell Reflection Rank 2
.learn 23920                       -- Spell Reflection
.cast 23920                        -- Spell Reflection
```
- [ ] Party members also gain Spell Reflection
- [ ] Effect extends to 2/4 nearby party members
- [ ] Duration matches rank

---

### Taste for Blood (-56636 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x20` (Rend), `SpellPhaseMask=0x2`, `Cooldown=5800`
**Why:** Tests Taste for Blood proc enabling Overpower.

**Test Steps:**
```
.learn 56636                       -- Taste for Blood Rank 1 (33% chance)
.learn 56638                       -- Taste for Blood Rank 3 (100% chance)
.learn 772                         -- Rend
.learn 7384                        -- Overpower
.additem 33185                     -- 2H Weapon
.go creature id 32666
.cast 772                          -- Rend
# Wait for Rend ticks
```
- [ ] Overpower becomes available on Rend tick
- [ ] Proc chance matches talent rank (33%/66%/100%)
- [ ] 5.8 second internal cooldown

---

### Sword and Board (-46951 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x400` (Devastate), `SpellFamilyMask1=0x40` (Revenge), `SpellPhaseMask=0x2`
**Why:** Tests Sword and Board refreshing Shield Slam.

**Test Steps:**
```
.learn 46951                       -- Sword and Board Rank 1 (10% chance)
.learn 46953                       -- Sword and Board Rank 3 (30% chance)
.learn 20243                       -- Devastate
.learn 23922                       -- Shield Slam
.additem 33185                     -- 1H Weapon
.additem 33188                     -- Shield
.go creature id 32666
.cast 20243                        -- Devastate
```
- [ ] Shield Slam cooldown reset
- [ ] Shield Slam becomes free
- [ ] Proc chance matches talent rank (10%/20%/30%)

---

### Safeguard (-46945 → all ranks)
**Proc Config:** `SpellFamilyMask1=0x10000` (Intervene), `SpellPhaseMask=0x2`
**Why:** Tests Safeguard damage reduction on Intervene target.

**Test Steps:**
```
.learn 46945                       -- Safeguard Rank 1 (15% reduction)
.learn 46949                       -- Safeguard Rank 2 (30% reduction)
.learn 3411                        -- Intervene
# Target a party member:
.cast 3411                         -- Intervene
```
- [ ] Target takes 15%/30% less damage
- [ ] Duration is 6 seconds
- [ ] Works with Intervene

---

### Bloodsurge (-46913 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x40` (Heroic Strike), `SpellFamilyMask1=0x404` (Whirlwind/Bloodthirst), `SpellPhaseMask=0x2`
**Why:** Tests Bloodsurge enabling instant Slam.

**Test Steps:**
```
.learn 46913                       -- Bloodsurge Rank 1 (7% chance)
.learn 46915                       -- Bloodsurge Rank 3 (20% chance)
.learn 23881                       -- Bloodthirst
.learn 1464                        -- Slam
.additem 33185                     -- 2H Weapon
.go creature id 32666
.cast 23881                        -- Bloodthirst
```
- [ ] Slam becomes instant and free
- [ ] Proc chance matches talent rank (7%/13%/20%)
- [ ] Works with Heroic Strike, Bloodthirst, Whirlwind

---

### Sudden Death (-29723 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Sudden Death enabling Execute at any health.

**Test Steps:**
```
.learn 29723                       -- Sudden Death Rank 1 (3% chance)
.learn 29725                       -- Sudden Death Rank 3 (9% chance)
.learn 5308                        -- Execute
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Auto-attack until proc
```
- [ ] Execute becomes usable at any health
- [ ] Execute costs no rage
- [ ] Proc chance matches talent rank

---

### Improved Berserker Rage (-20500 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x10000000` (Berserker Rage), `SpellPhaseMask=0x2`
**Why:** Tests Improved Berserker Rage rage generation.

**Test Steps:**
```
.learn 20500                       -- Improved Berserker Rage Rank 1 (5 rage)
.learn 20501                       -- Improved Berserker Rage Rank 2 (10 rage)
.learn 18499                       -- Berserker Rage
.cast 18499                        -- Berserker Rage
```
- [ ] Generates 5/10 rage on use
- [ ] Works in addition to normal Berserker Rage effect

---

### Gag Order (-12311 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x800` (Shield Bash), `SpellFamilyMask1=0x1` (Heroic Throw), `SpellPhaseMask=0x2`
**Why:** Tests Gag Order silence effect.

**Test Steps:**
```
.learn 12311                       -- Gag Order Rank 1 (50% chance)
.learn 12799                       -- Gag Order Rank 2 (100% chance)
.learn 72                          -- Shield Bash
.learn 57755                       -- Heroic Throw
.additem 33185                     -- 1H Weapon
.additem 33188                     -- Shield
.go creature id 32666
# Wait for target to cast, then:
.cast 72                           -- Shield Bash
```
- [ ] Target silenced for 3 seconds
- [ ] Works with Shield Bash
- [ ] Works with Heroic Throw
- [ ] Chance matches talent rank (50%/100%)

---

### Improved Hamstring (-12289 → all ranks)
**Proc Config:** `SpellFamilyMask0=0x2` (Hamstring), `SpellPhaseMask=0x2`
**Why:** Tests Improved Hamstring root effect.

**Test Steps:**
```
.learn 12289                       -- Improved Hamstring Rank 1 (5% chance)
.learn 12668                       -- Improved Hamstring Rank 3 (15% chance)
.learn 1715                        -- Hamstring
.additem 33185                     -- Weapon
.go creature id 32666
.cast 1715                         -- Hamstring
```
- [ ] Target immobilized for 5 seconds
- [ ] Proc chance matches talent rank (5%/10%/15%)

---

### Recklessness (1719)
**Proc Config:** `SpellFamilyMask0=0x2E69B844` (various attacks), `SpellFamilyMask1=0x404B45`, `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `AttributesMask=0x8`
**Why:** Tests Recklessness buff consumption on abilities.

**Test Steps:**
```
.learn 1719                        -- Recklessness
.learn 78                          -- Heroic Strike
.additem 33185                     -- 2H Weapon
.go creature id 32666
.cast 1719                         -- Activate Recklessness
.cast 78                           -- Heroic Strike
```
- [ ] 100% crit chance on abilities
- [ ] Buff grants 3 charges
- [ ] Charges consumed on ability use

---

### Sweeping Strikes (12328)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests Sweeping Strikes charge consumption.

**Test Steps:**
```
.learn 12328                       -- Sweeping Strikes
.learn 78                          -- Heroic Strike
.additem 33185                     -- 2H Weapon
# Need 2 targets nearby:
.cast 12328                        -- Activate Sweeping Strikes
.cast 78                           -- Heroic Strike
```
- [ ] Damage duplicated to nearby target
- [ ] 10 charges available
- [ ] Charges consumed on each attack

---

### Warrior's Wrath - T2 6P (21890)
**Proc Config:** `SpellFamilyMask0=0x2A79F5EF` (various attacks), `SpellFamilyMask1=0x36C`, `SpellPhaseMask=0x2`
**Why:** Tests T2 6P bonus on Warrior abilities.

**Test Steps:**
```
# Need 6 pieces T2 Wrath set
.learn 78                          -- Heroic Strike
.additem 33185                     -- Weapon
.go creature id 32666
.cast 78                           -- Heroic Strike
```
- [ ] Bonus effect procs on abilities
- [ ] Effect verified

---

### Victorious (32216)
**Proc Config:** `SpellFamilyMask1=0x100` (Victory Rush), `ProcFlags=0x10` (MELEE), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests Victorious buff consumption.

**Test Steps:**
```
.learn 34428                       -- Victory Rush
.additem 33185                     -- Weapon
.go creature id 32541              -- Low HP target
# Kill target to get Victorious buff
.cast 34428                        -- Victory Rush
```
- [ ] Victory Rush enabled after kill
- [ ] Buff consumed on Victory Rush
- [ ] Victory Rush heals for 30% of max health

---

### Revenge Bonus - T4 2P (37516)
**Proc Config:** `SpellFamilyMask0=0x400` (Devastate), `SpellPhaseMask=0x2`
**Why:** Tests T4 2P bonus on Devastate.

**Test Steps:**
```
# Need 2 pieces T4 Warbringer set
.learn 20243                       -- Devastate
.additem 33185                     -- 1H Weapon
.additem 33188                     -- Shield
.go creature id 32666
.cast 20243                        -- Devastate
```
- [ ] Bonus effect procs on Devastate
- [ ] Revenge-related bonus verified

---

### Overpower Bonus - T4 4P (37528)
**Proc Config:** `SpellFamilyMask0=0x4` (Overpower), `SpellPhaseMask=0x2`
**Why:** Tests T4 4P bonus on Overpower.

**Test Steps:**
```
# Need 4 pieces T4 Warbringer set
.learn 7384                        -- Overpower
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Wait for dodge, then:
.cast 7384                         -- Overpower
```
- [ ] Bonus effect procs on Overpower
- [ ] Bonus damage verified

---

### Improved Battle Shout - T5 4P (37536)
**Proc Config:** `SpellFamilyMask0=0x10000` (Battle Shout), `SpellPhaseMask=0x2`
**Why:** Tests T5 4P bonus on Battle Shout.

**Test Steps:**
```
# Need 4 pieces T5 Destroyer set
.learn 6673                        -- Battle Shout
.cast 6673                         -- Battle Shout
```
- [ ] Bonus effect procs on Battle Shout
- [ ] Increased duration/effect verified

---

### Warrior Tier 6 Trinket (40458)
**Proc Config:** `SpellFamilyMask0=0x2000000` (Bloodthirst), `SpellFamilyMask1=0x601` (various), `SpellPhaseMask=0x2`
**Why:** Tests T6 trinket proc on Bloodthirst/abilities.

**Test Steps:**
```
# Need T6 trinket (Onslaught set)
.learn 23881                       -- Bloodthirst
.additem 33185                     -- 2H Weapon
.go creature id 32666
.cast 23881                        -- Bloodthirst
```
- [ ] Trinket effect procs on abilities
- [ ] Bonus damage/effect verified

---

### Slam! (46916)
**Proc Config:** `SpellFamilyMask0=0x200000` (Slam), `SpellPhaseMask=0x4` (FINISH), `AttributesMask=0x2`
**Why:** Tests Bloodsurge Slam! buff consumption.

**Test Steps:**
```
.learn 46913                       -- Bloodsurge (grants Slam!)
.learn 1464                        -- Slam
.learn 23881                       -- Bloodthirst
.additem 33185                     -- 2H Weapon
.go creature id 32666
.cast 23881                        -- Bloodthirst (proc Bloodsurge)
# With Slam! buff active:
.cast 1464                         -- Slam
```
- [ ] Slam is instant with buff
- [ ] Buff consumed on Slam cast

---

### Sudden Death Execute (52437)
**Proc Config:** `SchoolMask=0x1` (Physical), `SpellFamilyMask0=0x20000000` (Execute), `ProcFlags=0x10` (MELEE), `SpellPhaseMask=0x4` (FINISH)
**Why:** Tests Sudden Death free Execute proc.

**Test Steps:**
```
.learn 29723                       -- Sudden Death
.learn 5308                        -- Execute
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Auto-attack until Sudden Death procs:
.cast 5308                         -- Execute
```
- [ ] Execute usable at any health
- [ ] Execute costs no rage
- [ ] Buff consumed on Execute

---

### Glyph of Heroic Strike (58357)
**Proc Config:** `SpellFamilyMask0=0x40` (Heroic Strike), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests Glyph of Heroic Strike rage refund on crit.

**Test Steps:**
```
.additem 43418                     -- Glyph of Heroic Strike (apply glyph)
.learn 78                          -- Heroic Strike
.additem 33185                     -- Weapon
.go creature id 32666
.cast 78                           -- Heroic Strike (crit)
```
- [ ] 10 rage refunded on crit
- [ ] Only procs on critical hits
- [ ] Glyph effect active

---

### Glyph of Revenge (58364)
**Proc Config:** `SpellFamilyMask0=0x400` (Revenge), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Revenge free Heroic Strike.

**Test Steps:**
```
.additem 43424                     -- Glyph of Revenge (apply glyph)
.learn 6572                        -- Revenge
.learn 78                          -- Heroic Strike
.additem 33185                     -- 1H Weapon
.additem 33188                     -- Shield
.go creature id 32666
# Block/parry to enable Revenge, then:
.cast 6572                         -- Revenge
```
- [ ] Next Heroic Strike is free after Revenge
- [ ] Glyph effect active

---

### Glyph of Hamstring (58372)
**Proc Config:** `SpellFamilyMask0=0x2` (Hamstring), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Hamstring bonus damage.

**Test Steps:**
```
.additem 43417                     -- Glyph of Hamstring (apply glyph)
.learn 1715                        -- Hamstring
.additem 33185                     -- Weapon
.go creature id 32666
.cast 1715                         -- Hamstring
```
- [ ] Bonus damage on Hamstring
- [ ] Glyph effect active

---

### Glyph of Blocking (58375)
**Proc Config:** `SpellFamilyMask1=0x200` (Shield Block), `ProcFlags=0x10` (MELEE), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Glyph of Blocking Shield Slam damage bonus.

**Test Steps:**
```
.additem 43425                     -- Glyph of Blocking (apply glyph)
.learn 2565                        -- Shield Block
.learn 23922                       -- Shield Slam
.additem 33185                     -- 1H Weapon
.additem 33188                     -- Shield
.go creature id 32666
.cast 2565                         -- Shield Block
.cast 23922                        -- Shield Slam
```
- [ ] Shield Slam damage increased while Shield Block active
- [ ] 10% bonus damage
- [ ] Glyph effect active

---

### Bleed Cost Reduction - T7 2P (60176)
**Proc Config:** `SpellFamilyMask0=0x20` (Rend), `SpellFamilyMask1=0x10` (Deep Wounds), `ProcFlags=0x40000` (DoT tick), `SpellPhaseMask=0x2`
**Why:** Tests T7 2P bonus rage cost reduction on bleeds.

**Test Steps:**
```
# Need 2 pieces T7 Dreadnaught set
.learn 772                         -- Rend
.additem 33185                     -- Weapon
.go creature id 32666
.cast 772                          -- Rend
```
- [ ] Rend costs less rage
- [ ] Deep Wounds bonus verified

---

### Taste for Blood proc (60503)
**Proc Config:** `SchoolMask=0x1` (Physical), `SpellFamilyMask0=0x4` (Overpower), `SpellPhaseMask=0x2`
**Why:** Tests Taste for Blood Overpower consumption.

**Test Steps:**
```
.learn 56636                       -- Taste for Blood
.learn 772                         -- Rend
.learn 7384                        -- Overpower
.additem 33185                     -- 2H Weapon
.go creature id 32666
.cast 772                          -- Rend (wait for proc)
.cast 7384                         -- Overpower
```
- [ ] Overpower enabled by Rend ticks
- [ ] Buff consumed on Overpower

---

### Item - Warrior T8 Melee 2P Bonus (64938)
**Proc Config:** `SpellFamilyMask0=0x200040` (Heroic Strike/Slam), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRITICAL)
**Why:** Tests T8 2P melee bonus on ability crits.

**Test Steps:**
```
# Need 2 pieces T8 Siegebreaker (Melee):
.additem 45429                     -- Valorous Siegebreaker Battleplate
.additem 45430                     -- Valorous Siegebreaker Gauntlets
.learn 78                          -- Heroic Strike
.additem 33185                     -- Weapon
.go creature id 32666
.cast 78                           -- Heroic Strike (crit)
```
- [ ] 2P bonus procs on Heroic Strike/Slam crit
- [ ] Bonus effect verified

---

### Juggernaut (64976)
**Proc Config:** `SpellFamilyMask0=0x1` (Charge), `SpellPhaseMask=0x2`
**Why:** Tests Juggernaut crit buff after Charge.

**Test Steps:**
```
.learn 64976                       -- Juggernaut (from talent)
.learn 100                         -- Charge
.learn 6343                        -- Thunder Clap
.additem 33185                     -- Weapon
.go creature id 32666
.cast 100                          -- Charge
```
- [ ] Next ability has 25% bonus crit
- [ ] Buff consumed on next ability

---

### Overpower Ready! (68051)
**Proc Config:** `SchoolMask=0x1` (Physical), `SpellFamilyMask0=0x4` (Overpower), `SpellPhaseMask=0x2`
**Why:** Tests Overpower Ready! buff consumption.

**Test Steps:**
```
.learn 7384                        -- Overpower
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Wait for target dodge:
.cast 7384                         -- Overpower
```
- [ ] Overpower enabled by target dodge
- [ ] Buff consumed on use

---

### Item - Warrior T10 Protection 4P Bonus (70844)
**Proc Config:** `SpellFamilyMask0=0x100` (Concussion Blow), `SpellPhaseMask=0x2`
**Why:** Tests T10 4P Protection bonus on Concussion Blow.

**Test Steps:**
```
# Need 4 pieces T10 Ymirjar Lord (Protection):
.additem 50850                     -- Ymirjar Lord's Breastplate
.additem 50849                     -- Ymirjar Lord's Handguards
.additem 50848                     -- Ymirjar Lord's Greathelm
.additem 50847                     -- Ymirjar Lord's Legguards
.learn 12809                       -- Concussion Blow
.additem 33185                     -- 1H Weapon
.additem 33188                     -- Shield
.go creature id 32666
.cast 12809                        -- Concussion Blow
```
- [ ] 4P bonus procs on Concussion Blow
- [ ] Enraged Regeneration effect triggered
- [ ] Effect duration verified

---

### Item - Warrior T10 Melee 2P Bonus (70854)
**Proc Config:** `SpellFamilyMask1=0x10` (Deep Wounds), `SpellPhaseMask=0x2`
**Why:** Tests T10 2P melee bonus on Deep Wounds.

**Test Steps:**
```
# Need 2 pieces T10 Ymirjar Lord (Melee):
.additem 50078                     -- Ymirjar Lord's Battleplate
.additem 50079                     -- Ymirjar Lord's Gauntlets
.learn 12834                       -- Deep Wounds (from talent)
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Crit to apply Deep Wounds
```
- [ ] 2P bonus procs on Deep Wounds
- [ ] Bonus damage effect verified

---

## Generic/Item Procs (SpellFamilyName = 0)

This section contains Generic procs - class mechanics implemented with SpellFamilyName=0, item procs, trinkets, enchants, and miscellaneous proc effects.

### Aspect of the Dragonhawk (-61846 → all ranks)
**Proc Config:** `ProcFlags=0x40` (Taken melee hit), `SpellPhaseMask=0x2`
**Why:** Tests Aspect of the Dragonhawk proc to reset swing timer.

**Test Steps:**
```
.learn 61846                       -- Aspect of the Dragonhawk Rank 1
.learn 61847                       -- Aspect of the Dragonhawk Rank 2
.go creature id 32666
# Get hit in melee
```
- [ ] Aspect aura applied
- [ ] Proc triggers on melee hit taken
- [ ] Effect matches aspect rank

---

### Borrowed Time (-59887 → all ranks)
**Proc Config:** `SpellPhaseMask=0x1` (On cast)
**Why:** Tests Borrowed Time haste buff proc on Power Word: Shield cast.

**Test Steps:**
```
.learn 59887                       -- Borrowed Time Rank 1
.learn 59888                       -- Borrowed Time Rank 2
.learn 17                          -- Power Word: Shield
.cast 17                           -- Power Word: Shield
```
- [ ] Borrowed Time haste buff applied
- [ ] Buff duration correct
- [ ] Haste amount matches rank

---

### Damage Shield (-58872 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2043`
**Why:** Tests Damage Shield reflection proc.

**Test Steps:**
```
.learn 58872                       -- Damage Shield Rank 1
.learn 58874                       -- Damage Shield Rank 2
.additem 33188                     -- Shield
.go creature id 32666
# Block attack
```
- [ ] Damage reflected on block
- [ ] Reflection amount matches rank

---

### Natural Reaction (-57878 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x10` (DODGE)
**Why:** Tests Natural Reaction rage gain on dodge.

**Test Steps:**
```
.learn 57878                       -- Natural Reaction Rank 1
.learn 57880                       -- Natural Reaction Rank 2
.learn 57881                       -- Natural Reaction Rank 3
.learn 5487                        -- Bear Form
.cast 5487                         -- Bear Form
.go creature id 32666
# Dodge attack in bear form
```
- [ ] Rage gained on dodge
- [ ] Rage amount matches rank

---

### Burning Determination (-54747 → all ranks)
**Proc Config:** No special config
**Why:** Tests Burning Determination interrupt/silence immunity.

**Test Steps:**
```
.learn 54747                       -- Burning Determination Rank 1
.learn 54749                       -- Burning Determination Rank 2
# Have another player interrupt/silence you
```
- [ ] Immunity buff granted after interrupt
- [ ] Duration matches rank

---

### Guarded by the Light (-53583 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Guarded by the Light Divine Plea refresh.

**Test Steps:**
```
.learn 53583                       -- Guarded by the Light Rank 1
.learn 53585                       -- Guarded by the Light Rank 2
.learn 54428                       -- Divine Plea
.additem 33185                     -- Weapon
.cast 54428                        -- Divine Plea
.go creature id 32666
# Deal melee damage
```
- [ ] Divine Plea duration refreshed on hit
- [ ] Effect matches rank

---

### Sheath of Light (-53501 → all ranks)
**Proc Config:** `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Sheath of Light HoT proc on crit heal.

**Test Steps:**
```
.learn 53501                       -- Sheath of Light Rank 1
.learn 53502                       -- Sheath of Light Rank 2
.learn 53503                       -- Sheath of Light Rank 3
.learn 635                         -- Holy Light
# Crit heal to proc HoT
```
- [ ] HoT applied on crit heal
- [ ] HoT amount based on heal

---

### Water Shield (-52127 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`, `Cooldown=3500`
**Why:** Tests Water Shield mana restore proc.

**Test Steps:**
```
.learn 52127                       -- Water Shield Rank 1
.learn 52134                       -- Water Shield Rank 6
.cast 52127                        -- Water Shield
.go creature id 32666
# Take damage
```
- [ ] Mana restored on hit taken
- [ ] Charge consumed
- [ ] 3.5s ICD enforced
- [ ] Amount matches rank

---

### Earthliving Weapon (-51940 → all ranks)
**Proc Config:** `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`
**Why:** Tests Earthliving Weapon HoT proc on heal.

**Test Steps:**
```
.learn 51940                       -- Earthliving Weapon Rank 1
.learn 51945                       -- Earthliving Weapon Rank 6
.learn 8004                        -- Lesser Healing Wave
.cast 51940                        -- Apply Earthliving
.cast 8004                         -- Lesser Healing Wave
```
- [ ] Earthliving HoT procs on heal
- [ ] HoT amount matches rank

---

### Unfair Advantage (-51672 → all ranks)
**Proc Config:** `HitMask=0x10` (DODGE), `Cooldown=1000`
**Why:** Tests Unfair Advantage strike on dodge.

**Test Steps:**
```
.learn 51672                       -- Unfair Advantage Rank 1
.learn 51674                       -- Unfair Advantage Rank 2
.additem 33185                     -- Weapon
.go creature id 32666
# Dodge attack
```
- [ ] Extra strike on dodge
- [ ] 1s ICD enforced
- [ ] Damage matches rank

---

### Focused Attacks (-51634 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT), `AttributesMask=0x2`
**Why:** Tests Focused Attacks energy gain on crit.

**Test Steps:**
```
.learn 51634                       -- Focused Attacks Rank 1
.learn 51636                       -- Focused Attacks Rank 3
.additem 33185                     -- Weapon (MH)
.additem 33185                     -- Weapon (OH)
.go creature id 32666
# Crit with melee
```
- [ ] Energy gained on melee crit
- [ ] Amount matches rank (2/3/3)

---

### Turn the Tables (-51627 → all ranks)
**Proc Config:** `HitMask=0x70` (DODGE|PARRY|BLOCK)
**Why:** Tests Turn the Tables damage buff on avoid.

**Test Steps:**
```
.learn 51627                       -- Turn the Tables Rank 1
.learn 51629                       -- Turn the Tables Rank 3
.additem 33185                     -- Weapon
.go creature id 32666
# Dodge, parry, or deflect
```
- [ ] Damage buff applied on avoid
- [ ] Buff duration correct
- [ ] Bonus matches rank

---

### Astral Shift (-51474 → all ranks)
**Proc Config:** No special config
**Why:** Tests Astral Shift damage reduction on stun/fear/silence.

**Test Steps:**
```
.learn 51474                       -- Astral Shift Rank 1
.learn 51478                       -- Astral Shift Rank 3
# Have another player stun/fear/silence you
```
- [ ] Damage reduction buff applied
- [ ] Duration correct
- [ ] Reduction matches rank

---

### Necrosis (-51459 → all ranks)
**Proc Config:** `ProcFlags=0x4` (Kill)
**Why:** Tests Necrosis shadow damage on melee.

**Test Steps:**
```
.learn 51459                       -- Necrosis Rank 1
.learn 51464                       -- Necrosis Rank 5
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] Shadow damage added to melee
- [ ] Damage matches rank %

---

### Blood-Caked Blade (-49219 → all ranks)
**Proc Config:** `ProcFlags=0x4` (Melee hit)
**Why:** Tests Blood-Caked Blade proc chance.

**Test Steps:**
```
.learn 49219                       -- Blood-Caked Blade Rank 1
.learn 49627                       -- Blood-Caked Blade Rank 3
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] Extra strike procs on melee hit
- [ ] Proc chance matches rank (10%/20%/30%)

---

### Acclimation (-49200 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`
**Why:** Tests Acclimation resistance buff on magic damage.

**Test Steps:**
```
.learn 49200                       -- Acclimation Rank 1
.learn 50152                       -- Acclimation Rank 3
# Take magic damage from different schools
```
- [ ] Resistance buff applied
- [ ] Stacks up to 3
- [ ] Resistance matches school taken

---

### Bloodworms (-49027 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=20000`
**Why:** Tests Bloodworms spawn proc on melee.

**Test Steps:**
```
.learn 49027                       -- Bloodworms Rank 1
.learn 49542                       -- Bloodworms Rank 3
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] Bloodworms spawned on melee hit
- [ ] 20s ICD enforced
- [ ] Number matches rank

---

### Vendetta (-49015 → all ranks)
**Proc Config:** `AttributesMask=0x1` (REQ_EXP_OR_HONOR)
**Why:** Tests Vendetta heal on killing blow.

**Test Steps:**
```
.learn 49015                       -- Vendetta Rank 1
.learn 50677                       -- Vendetta Rank 3
.go creature id 32666
# Kill target
```
- [ ] Health restored on kill
- [ ] Energy restored
- [ ] Requires exp/honor target

---

### Scent of Blood (-49004 → all ranks)
**Proc Config:** `HitMask=0x33` (NORMAL|CRIT|DODGE|PARRY)
**Why:** Tests Scent of Blood runic power gain.

**Test Steps:**
```
.learn 49004                       -- Scent of Blood Rank 1
.learn 49508                       -- Scent of Blood Rank 3
.go creature id 32666
# Take melee hits
```
- [ ] Runic power gained on hit taken
- [ ] Amount matches rank

---

### Bloody Vengeance (-48988 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Bloody Vengeance damage buff on crit.

**Test Steps:**
```
.learn 48988                       -- Bloody Vengeance Rank 1
.learn 49503                       -- Bloody Vengeance Rank 3
.additem 33185                     -- Weapon
.go creature id 32666
# Crit with melee
```
- [ ] Damage buff applied on crit
- [ ] Stacks up to 3
- [ ] Bonus matches rank

---

### Butchery (-48979 → all ranks)
**Proc Config:** `AttributesMask=0x1` (REQ_EXP_OR_HONOR)
**Why:** Tests Butchery runic power gain on kill.

**Test Steps:**
```
.learn 48979                       -- Butchery Rank 1
.learn 49483                       -- Butchery Rank 2
.go creature id 32666
# Kill target
```
- [ ] Runic power gained on kill
- [ ] Amount matches rank (10/20)
- [ ] Requires exp/honor target

---

### Divine Aegis (-47509 → all ranks)
**Proc Config:** `SpellTypeMask=0x2` (HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Divine Aegis shield proc on crit heal.

**Test Steps:**
```
.learn 47509                       -- Divine Aegis Rank 1
.learn 47516                       -- Divine Aegis Rank 3
.learn 2050                        -- Lesser Heal
# Crit heal
```
- [ ] Shield applied on crit heal
- [ ] Shield amount based on heal
- [ ] Duration correct

---

### Fel Synergy (-47230 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `AttributesMask=0x2`
**Why:** Tests Fel Synergy pet healing on damage.

**Test Steps:**
```
.learn 47230                       -- Fel Synergy Rank 1
.learn 47231                       -- Fel Synergy Rank 2
# Summon demon pet
# Deal damage
```
- [ ] Pet healed for % of damage dealt
- [ ] Amount matches rank

---

### Wrecking Crew (-46867 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Wrecking Crew damage buff on melee crit.

**Test Steps:**
```
.learn 46867                       -- Wrecking Crew Rank 1
.learn 56927                       -- Wrecking Crew Rank 5
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Melee crit
```
- [ ] Damage buff applied on crit
- [ ] Duration correct
- [ ] Bonus matches rank

---

### Trauma (-46854 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Trauma bleed debuff on melee crit.

**Test Steps:**
```
.learn 46854                       -- Trauma Rank 1
.learn 46855                       -- Trauma Rank 2
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Melee crit
```
- [ ] Bleed debuff applied on crit
- [ ] Debuff increases bleed damage taken
- [ ] Bonus matches rank

---

### Focused Will (-45234 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Focused Will damage reduction on crit taken.

**Test Steps:**
```
.learn 45234                       -- Focused Will Rank 1
.learn 45244                       -- Focused Will Rank 3
.go creature id 32666
# Take critical hit
```
- [ ] Damage reduction buff applied
- [ ] Stacks up to 3
- [ ] Reduction matches rank

---

### Prayer of Mending (-41635 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`
**Why:** Tests Prayer of Mending bounce on damage taken.

**Test Steps:**
```
.learn 33076                       -- Prayer of Mending Rank 1
.learn 48113                       -- Prayer of Mending Rank 7
.cast 33076                        -- Prayer of Mending
.go creature id 32666
# Take damage
```
- [ ] Heal triggered on damage
- [ ] Bounce to nearby ally
- [ ] Bounce count decremented

---

### Combat Potency (-35541 → all ranks)
**Proc Config:** `ProcFlags=0x800000` (Off-hand hit)
**Why:** Tests Combat Potency energy gain on off-hand hit.

**Test Steps:**
```
.learn 35541                       -- Combat Potency Rank 1
.learn 35553                       -- Combat Potency Rank 5
.additem 33185                     -- Weapon (MH)
.additem 33185                     -- Weapon (OH)
.go creature id 32666
# Attack with dual wield
```
- [ ] Energy gained on off-hand hit
- [ ] Proc chance matches rank (20% per rank)
- [ ] 15 energy per proc

---

### Go for the Throat (-34950 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Go for the Throat pet focus on ranged crit.

**Test Steps:**
```
.learn 34950                       -- Go for the Throat Rank 1
.learn 34954                       -- Go for the Throat Rank 2
# Summon pet
.additem 32336                     -- Black Bow of the Betrayer
.go creature id 32666
# Crit with ranged
```
- [ ] Pet gains focus on crit
- [ ] Amount matches rank (25/50)

---

### Backlash (-34935 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x403` (NORMAL|CRIT|BLOCK), `Cooldown=8000`
**Why:** Tests Backlash instant Shadow Bolt proc.

**Test Steps:**
```
.learn 34935                       -- Backlash Rank 1
.learn 34939                       -- Backlash Rank 3
.learn 686                         -- Shadow Bolt
.go creature id 32666
# Take physical damage
```
- [ ] Instant cast Shadow Bolt available
- [ ] 8s ICD enforced
- [ ] Proc chance matches rank

---

### Expose Weakness (-34500 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Expose Weakness AP debuff on ranged crit.

**Test Steps:**
```
.learn 34500                       -- Expose Weakness Rank 1
.learn 34503                       -- Expose Weakness Rank 3
.additem 32336                     -- Black Bow of the Betrayer
.go creature id 32666
# Crit with ranged
```
- [ ] AP debuff applied to target
- [ ] Amount based on Agility
- [ ] Duration correct

---

### Natural Perfection (-33881 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Natural Perfection crit reduction on crit taken.

**Test Steps:**
```
.learn 33881                       -- Natural Perfection Rank 1
.learn 33886                       -- Natural Perfection Rank 3
.go creature id 32666
# Take critical hit
```
- [ ] Crit chance reduction buff applied
- [ ] Stacks up to 3
- [ ] Reduction matches rank

---

### Surge of Light (-33150 → all ranks)
**Proc Config:** `SpellTypeMask=0x3` (DAMAGE|HEAL), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT), `AttributesMask=0x2`, `Cooldown=6000`
**Why:** Tests Surge of Light instant Smite/Flash Heal proc.

**Test Steps:**
```
.learn 33150                       -- Surge of Light Rank 1
.learn 33154                       -- Surge of Light Rank 2
.learn 585                         -- Smite
.learn 2061                        -- Flash Heal
# Crit with spell
```
- [ ] Instant cast Smite/Flash Heal available
- [ ] 6s ICD enforced
- [ ] Proc chance matches rank

---

### Blessed Resilience (-33142 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Blessed Resilience healing increase on crit taken.

**Test Steps:**
```
.learn 33142                       -- Blessed Resilience Rank 1
.learn 33158                       -- Blessed Resilience Rank 3
.go creature id 32666
# Take critical hit
```
- [ ] Healing received increase buff
- [ ] Duration correct
- [ ] Bonus matches rank

---

### Prayer of Mending (33076)
**Proc Config:** `ProcFlags=0xA2228` (Many damage flags), `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Prayer of Mending base proc behavior.

**Test Steps:**
```
.learn 33076                       -- Prayer of Mending
# See -41635 test above
```
- [ ] Same as -41635 test

---

### Spiritual Attunement (-31785 → all ranks)
**Proc Config:** `SpellTypeMask=0x2` (HEAL)
**Why:** Tests Spiritual Attunement mana restore on heal received.

**Test Steps:**
```
.learn 31785                       -- Spiritual Attunement Rank 1
.learn 33776                       -- Spiritual Attunement Rank 2
# Have another player heal you
```
- [ ] Mana restored on heal received
- [ ] Amount based on heal received
- [ ] Matches rank %

---

### Blazing Speed (-31641 → all ranks)
**Proc Config:** `ProcFlags=0x2A8` (Melee/ranged hit taken)
**Why:** Tests Blazing Speed movement speed on hit.

**Test Steps:**
```
.learn 31641                       -- Blazing Speed Rank 1
.learn 31642                       -- Blazing Speed Rank 2
.go creature id 32666
# Take hit
```
- [ ] Movement speed buff applied
- [ ] Fire trail effect
- [ ] Proc chance matches rank

---

### Blade Twisting (-31124 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Blade Twisting daze on Sinister Strike/Backstab.

**Test Steps:**
```
.learn 31124                       -- Blade Twisting Rank 1
.learn 31126                       -- Blade Twisting Rank 2
.learn 1752                        -- Sinister Strike
.additem 33185                     -- Weapon
.go creature id 32666
.cast 1752                         -- Sinister Strike
```
- [ ] Target dazed on hit
- [ ] Duration correct
- [ ] Proc chance matches rank

---

### Nature's Guardian (-30881 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `Cooldown=30000`
**Why:** Tests Nature's Guardian heal on low health.

**Test Steps:**
```
.learn 30881                       -- Nature's Guardian Rank 1
.learn 30884                       -- Nature's Guardian Rank 5
.damage 90                         -- Take 90% damage
# Take more damage below 30% health
```
- [ ] Heal triggered at low health
- [ ] 30s ICD enforced
- [ ] Heal amount matches rank

---

### Elemental Absorption (30701)
**Proc Config:** `ProcFlags=0xA2228` (Many damage flags), `SpellTypeMask=0x1` (DAMAGE), `Chance=100`
**Why:** Tests Elemental Absorption (scripted handler).

**Test Steps:**
```
.aura 30701                        -- Elemental Absorption
# Take fire/frost/nature damage
```
- [ ] Absorbs elemental damage
- [ ] Effect as documented

---

### Molten Armor (-30482 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x403` (NORMAL|CRIT|BLOCK), `AttributesMask=0x2`
**Why:** Tests Molten Armor fire damage on melee hit taken.

**Test Steps:**
```
.learn 30482                       -- Molten Armor Rank 1
.learn 43046                       -- Molten Armor Rank 3
.cast 30482                        -- Molten Armor
.go creature id 32666
# Take melee hit
```
- [ ] Fire damage dealt to attacker
- [ ] Amount matches rank/spell power

---

### Nether Protection (-30299 → all ranks)
**Proc Config:** No special config
**Why:** Tests Nether Protection school immunity proc.

**Test Steps:**
```
.learn 30299                       -- Nether Protection Rank 1
.learn 30302                       -- Nether Protection Rank 3
# Take arcane/fire/frost/shadow/nature spell damage
```
- [ ] Immunity to school for 4 seconds
- [ ] Proc chance matches rank

---

### Elemental Devastation (-30160 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT), `Cooldown=500`
**Why:** Tests Elemental Devastation melee crit buff on spell crit.

**Test Steps:**
```
.learn 30160                       -- Elemental Devastation Rank 1
.learn 30163                       -- Elemental Devastation Rank 3
.learn 403                         -- Lightning Bolt
.go creature id 32666
# Crit with spell
```
- [ ] Melee crit chance buff applied
- [ ] Duration correct
- [ ] Bonus matches rank

---

### Second Wind (-29834 → all ranks)
**Proc Config:** `SpellTypeMask=0x5` (DAMAGE|NO_DMG_HEAL)
**Why:** Tests Second Wind health/rage on stun/immobilize.

**Test Steps:**
```
.learn 29834                       -- Second Wind Rank 1
.learn 29838                       -- Second Wind Rank 2
# Have another player stun you
```
- [ ] Health regeneration triggered
- [ ] Rage generated
- [ ] Amount matches rank

---

### Improved Defensive Stance (-29593 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x70` (DODGE|PARRY|BLOCK)
**Why:** Tests Improved Defensive Stance damage reduction.

**Test Steps:**
```
.learn 29593                       -- Improved Defensive Stance Rank 1
.learn 29594                       -- Improved Defensive Stance Rank 2
.learn 71                          -- Defensive Stance
.cast 71                           -- Defensive Stance
.go creature id 32666
# Block/parry/dodge attack
```
- [ ] Damage reduction buff applied
- [ ] Duration correct
- [ ] Reduction matches rank

---

### Magic Absorption (-29441 → all ranks)
**Proc Config:** `SpellTypeMask=0x7` (ALL), `HitMask=0x8` (RESIST), `Cooldown=1000`
**Why:** Tests Magic Absorption mana restore on resist.

**Test Steps:**
```
.learn 29441                       -- Magic Absorption Rank 1
.learn 29444                       -- Magic Absorption Rank 5
# Resist spell
```
- [ ] Mana restored on resist
- [ ] 1s ICD enforced
- [ ] Amount matches rank

---

### Blessed Recovery (-27811 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Blessed Recovery HoT on crit taken.

**Test Steps:**
```
.learn 27811                       -- Blessed Recovery Rank 1
.learn 27818                       -- Blessed Recovery Rank 3
.go creature id 32666
# Take critical hit
```
- [ ] HoT applied on crit taken
- [ ] Heal amount based on damage
- [ ] Duration correct

---

### Seed of Corruption (-27243 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Seed of Corruption explosion proc.

**Test Steps:**
```
.learn 27243                       -- Seed of Corruption Rank 1
.go creature id 32666
.cast 27243                        -- Seed of Corruption
# Deal damage to target
```
- [ ] Explodes after damage threshold
- [ ] AoE damage dealt
- [ ] Only one seed per target

---

### Holy Shield (-20925 → all ranks)
**Proc Config:** `HitMask=0x40` (BLOCK)
**Why:** Tests Holy Shield damage on block.

**Test Steps:**
```
.learn 20925                       -- Holy Shield Rank 1
.learn 48952                       -- Holy Shield Rank 6
.additem 33188                     -- Shield
.cast 20925                        -- Holy Shield
.go creature id 32666
# Block attack
```
- [ ] Holy damage dealt on block
- [ ] Charge consumed
- [ ] Damage matches rank

---

### Reckoning (-20177 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Reckoning extra attacks on damage taken.

**Test Steps:**
```
.learn 20177                       -- Reckoning Rank 1
.learn 20182                       -- Reckoning Rank 5
.additem 33185                     -- Weapon
.go creature id 32666
# Take damage then attack
```
- [ ] Extra attacks on next swing
- [ ] Effect consumed on attack
- [ ] Proc chance matches rank

---

### Vengeance (-20049 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Vengeance holy damage bonus on crit.

**Test Steps:**
```
.learn 20049                       -- Vengeance Rank 1
.learn 20056                       -- Vengeance Rank 5
.additem 33185                     -- Weapon
.go creature id 32666
# Crit with melee
```
- [ ] Holy damage bonus buff applied
- [ ] Stacks up to 3
- [ ] Bonus matches rank

---

### Primal Fury (-16958 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Primal Fury combo point gain on crit.

**Test Steps:**
```
.learn 16958                       -- Primal Fury Rank 1
.learn 16961                       -- Primal Fury Rank 2
.learn 5225                        -- Cat Form
.cast 5225                         -- Cat Form
.go creature id 32666
# Crit with melee in cat form
```
- [ ] Extra combo point gained on crit
- [ ] Amount matches rank (1/2)

---

### Nature's Grasp (-16689 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `Cooldown=1000`
**Why:** Tests Nature's Grasp root on melee hit.

**Test Steps:**
```
.learn 16689                       -- Nature's Grasp Rank 1
.learn 53312                       -- Nature's Grasp Rank 8
.cast 16689                        -- Nature's Grasp
.go creature id 32666
# Get hit in melee
```
- [ ] Attacker rooted on melee hit
- [ ] Charge consumed
- [ ] 1s ICD enforced

---

### Blood Craze (-16487 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Blood Craze regen on crit taken.

**Test Steps:**
```
.learn 16487                       -- Blood Craze Rank 1
.learn 16491                       -- Blood Craze Rank 3
.go creature id 32666
# Take critical hit
```
- [ ] Health regeneration buff applied
- [ ] Amount based on max health
- [ ] Duration correct

---

### Flurry (-16257 → all ranks)
**Proc Config:** `Cooldown=500`
**Why:** Tests Flurry attack speed buff on crit (Shaman).

**Test Steps:**
```
.learn 16257                       -- Flurry Rank 1
.learn 16277                       -- Flurry Rank 5
.additem 33185                     -- Weapon
.go creature id 32666
# Crit with melee
```
- [ ] Attack speed buff applied
- [ ] Charges consumed on attack
- [ ] Speed bonus matches rank

---

### Flurry (-16256 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Flurry attack speed buff on crit (alternate version).

**Test Steps:**
```
# Same as -16257 test
```
- [ ] Same behavior as -16257

---

### Martyrdom (-14531 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Martyrdom focus buff on crit taken.

**Test Steps:**
```
.learn 14531                       -- Martyrdom Rank 1
.learn 14774                       -- Martyrdom Rank 2
.go creature id 32666
# Take critical hit
```
- [ ] Focus buff applied (resist pushback)
- [ ] Duration correct
- [ ] Effect matches rank

---

### Setup (-13983 → all ranks)
**Proc Config:** `HitMask=0x18` (MISS|DODGE)
**Why:** Tests Setup combo point on dodge.

**Test Steps:**
```
.learn 13983                       -- Setup Rank 1
.learn 14070                       -- Setup Rank 3
.additem 33185                     -- Weapon
.go creature id 32666
# Dodge attack
```
- [ ] Combo point gained on dodge
- [ ] Proc chance matches rank

---

### Aspect of the Hawk (-13165 → all ranks)
**Proc Config:** `ProcFlags=0x40` (Taken melee hit), `SpellPhaseMask=0x2`
**Why:** Tests Aspect of the Hawk proc trigger.

**Test Steps:**
```
.learn 13165                       -- Aspect of the Hawk Rank 1
.learn 27044                       -- Aspect of the Hawk Rank 8
.cast 13165                        -- Aspect of the Hawk
.go creature id 32666
# Get hit in melee
```
- [ ] Aspect aura active
- [ ] Proc triggers correctly

---

### Flurry (-12966 → all ranks)
**Proc Config:** No special config
**Why:** Tests Flurry (Warrior version).

**Test Steps:**
```
.learn 12966                       -- Flurry Rank 1
.learn 12974                       -- Flurry Rank 5
.additem 33185                     -- 2H Weapon
.go creature id 32666
# Crit with melee
```
- [ ] Attack speed buff applied
- [ ] Charges consumed
- [ ] Speed bonus matches rank

---

### Deep Wounds (-12834 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Deep Wounds bleed on crit.

**Test Steps:**
```
.learn 12834                       -- Deep Wounds Rank 1
.learn 12867                       -- Deep Wounds Rank 3
.additem 33185                     -- Weapon
.go creature id 32666
# Crit with melee
```
- [ ] Bleed applied on crit
- [ ] Damage based on weapon damage
- [ ] Duration correct

---

### Flurry (-12319 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT)
**Why:** Tests Flurry alternate version.

**Test Steps:**
```
# Same as -12966 test
```
- [ ] Same behavior as -12966

---

### Enrage (-12317 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Enrage damage buff on damage taken.

**Test Steps:**
```
.learn 12317                       -- Enrage Rank 1
.learn 13048                       -- Enrage Rank 5
.go creature id 32666
# Take damage
```
- [ ] Damage buff applied
- [ ] Duration correct
- [ ] Bonus matches rank

---

### Shield Specialization (-12298 → all ranks)
**Proc Config:** `HitMask=0x70` (DODGE|PARRY|BLOCK)
**Why:** Tests Shield Specialization rage on block.

**Test Steps:**
```
.learn 12298                       -- Shield Specialization Rank 1
.learn 12724                       -- Shield Specialization Rank 5
.additem 33188                     -- Shield
.go creature id 32666
# Block attack
```
- [ ] Rage gained on block
- [ ] Amount matches rank

---

### Sword Specialization (-12281 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=6000`
**Why:** Tests Sword Specialization extra attack on hit.

**Test Steps:**
```
.learn 12281                       -- Sword Specialization Rank 1
.learn 12289                       -- Sword Specialization Rank 5
.additem 33185                     -- Sword
.go creature id 32666
# Auto attack
```
- [ ] Extra attack procs on hit
- [ ] 6s ICD enforced
- [ ] Proc chance matches rank

---

### Impact (-11103 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Impact stun on Fire spell hit.

**Test Steps:**
```
.learn 11103                       -- Impact Rank 1
.learn 12358                       -- Impact Rank 3
.learn 133                         -- Fireball
.go creature id 32666
.cast 133                          -- Fireball
```
- [ ] Target stunned on Fire spell hit
- [ ] Proc chance matches rank

---

### Flametongue Weapon (-10400 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=8`
**Why:** Tests Flametongue Weapon fire damage proc.

**Test Steps:**
```
.learn 10400                       -- Flametongue Weapon Rank 1
.learn 58790                       -- Flametongue Weapon Rank 10
.additem 33185                     -- Weapon
# Apply Flametongue
.go creature id 32666
# Auto attack
```
- [ ] Fire damage procs on melee hit
- [ ] Damage matches rank
- [ ] 8ms ICD (very short)

---

### Eye for an Eye (-9799 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x2` (CRIT)
**Why:** Tests Eye for an Eye reflect on spell crit taken.

**Test Steps:**
```
.learn 9799                        -- Eye for an Eye Rank 1
.learn 25988                       -- Eye for an Eye Rank 2
# Have another player crit you with a spell
```
- [ ] Holy damage reflected to attacker
- [ ] Amount based on damage taken
- [ ] Matches rank %

---

### Vindication (-9452 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Vindication AP reduction debuff.

**Test Steps:**
```
.learn 9452                        -- Vindication Rank 1
.learn 26016                       -- Vindication Rank 2
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] AP reduction debuff applied to target
- [ ] Amount matches rank

---

### Ice Armor (-7302 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x403` (NORMAL|CRIT|BLOCK), `AttributesMask=0x2`
**Why:** Tests Ice Armor chill effect on melee attackers.

**Test Steps:**
```
.learn 7302                        -- Ice Armor Rank 1
.learn 43008                       -- Ice Armor Rank 6
.cast 7302                         -- Ice Armor
.go creature id 32666
# Get hit in melee
```
- [ ] Chill effect applied to attacker
- [ ] Duration correct

---

### Lightwell Renew (-7001 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`
**Why:** Tests Lightwell Renew activation.

**Test Steps:**
```
.learn 724                         -- Lightwell Rank 1
.learn 48087                       -- Lightwell Rank 6
.cast 724                          -- Lightwell
# Click lightwell
```
- [ ] Lightwell Renew HoT applied
- [ ] Charges consumed
- [ ] HoT amount matches rank

---

### Drain Soul (-1120 → all ranks)
**Proc Config:** `AttributesMask=0x1` (REQ_EXP_OR_HONOR)
**Why:** Tests Drain Soul soul shard generation.

**Test Steps:**
```
.learn 1120                        -- Drain Soul Rank 1
.learn 47855                       -- Drain Soul Rank 6
.go creature id 32666
.cast 1120                         -- Drain Soul (kill target)
```
- [ ] Soul Shard generated on kill
- [ ] Requires exp/honor target

---

### Earth Shield (-974 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`, `Cooldown=3500`
**Why:** Tests Earth Shield heal proc.

**Test Steps:**
```
.learn 974                         -- Earth Shield Rank 1
.learn 49284                       -- Earth Shield Rank 5
.cast 974                          -- Earth Shield
.go creature id 32666
# Take damage
```
- [ ] Heal procs on damage taken
- [ ] Charge consumed
- [ ] 3.5s ICD enforced
- [ ] Heal amount matches rank

---

### Inner Fire (-588 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Inner Fire charge consumption.

**Test Steps:**
```
.learn 588                         -- Inner Fire Rank 1
.learn 48168                       -- Inner Fire Rank 9
.cast 588                          -- Inner Fire
.go creature id 32666
# Take melee hits
```
- [ ] Charge consumed on melee hit
- [ ] Armor buff remains until all charges gone
- [ ] Spell power bonus matches rank

---

### Lightning Shield (-324 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`, `Cooldown=3500`
**Why:** Tests Lightning Shield damage proc.

**Test Steps:**
```
.learn 324                         -- Lightning Shield Rank 1
.learn 49281                       -- Lightning Shield Rank 11
.cast 324                          -- Lightning Shield
.go creature id 32666
# Get hit in melee
```
- [ ] Nature damage dealt to attacker
- [ ] Charge consumed
- [ ] 3.5s ICD enforced
- [ ] Damage matches rank

---

### Frost Armor (-168 → all ranks)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x403` (NORMAL|CRIT|BLOCK), `AttributesMask=0x2`
**Why:** Tests Frost Armor chill effect on melee attackers.

**Test Steps:**
```
.learn 168                         -- Frost Armor Rank 1
.learn 7301                        -- Frost Armor Rank 3
.cast 168                          -- Frost Armor
.go creature id 32666
# Get hit in melee
```
- [ ] Chill effect applied to attacker
- [ ] Duration correct

---

## Item Proc Tests

### Explodo-Rockets Left (4341)
**Proc Config:** `ProcFlags=0x1000` (Range attack), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x1` (CAST)
**Why:** Tests engineering item proc.

**Test Steps:**
```
.aura 4341                         -- Explodo-Rockets Left
# Use ranged attack
```
- [ ] Rocket proc triggers on ranged attack
- [ ] Effect as documented

---

### Demonic Immolation (4524)
**Proc Config:** `ProcFlags=0x100000` (On death)
**Why:** Tests demon death proc.

**Test Steps:**
```
.aura 4524                         -- Demonic Immolation
# Die
```
- [ ] AoE fire damage on death
- [ ] Effect as documented

---

### Aspect of the Cheetah (5118)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`
**Why:** Tests Aspect of the Cheetah daze on damage.

**Test Steps:**
```
.learn 5118                        -- Aspect of the Cheetah
.cast 5118                         -- Aspect of the Cheetah
.go creature id 32666
# Take damage
```
- [ ] Dazed on taking damage
- [ ] Effect as documented

---

### Fear Ward (6346)
**Proc Config:** `HitMask=0x100` (FEAR)
**Why:** Tests Fear Ward fear immunity consumption.

**Test Steps:**
```
.learn 6346                        -- Fear Ward
.cast 6346                         -- Fear Ward on self
# Have another player cast fear on you
```
- [ ] Fear immunity consumed
- [ ] Fear effect prevented

---

### Water Bubble (7383)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x100`
**Why:** Tests Water Bubble proc.

**Test Steps:**
```
.aura 7383                         -- Water Bubble
# Take damage
```
- [ ] Effect as documented

---

### Fate Rune of Unsurpassed Vigor (7434)
**Proc Config:** `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT), `Cooldown=6000`
**Why:** Tests Fate Rune inscription proc.

**Test Steps:**
```
.aura 7434                         -- Fate Rune of Unsurpassed Vigor
.go creature id 32666
# Crit
```
- [ ] Effect procs on crit
- [ ] 6s ICD enforced

---

### Grounding Totem Effect (8178)
**Proc Config:** No special config
**Why:** Tests Grounding Totem spell absorption.

**Test Steps:**
```
.learn 8177                        -- Grounding Totem
.cast 8177                         -- Grounding Totem
# Have another player cast harmful spell
```
- [ ] Spell redirected to totem
- [ ] Totem destroyed after absorbing

---

### Mithril Shield Spike (9782)
**Proc Config:** `HitMask=0x40` (BLOCK)
**Why:** Tests Mithril Shield Spike damage on block.

**Test Steps:**
```
.additem 6042                      -- Mithril Shield Spike
.additem 33188                     -- Shield
# Apply shield spike to shield
# Equip shield
.go creature id 32666
# Block attack
```
- [ ] Damage dealt to attacker on block
- [ ] Amount as documented

---

### Iron Shield Spike (9784)
**Proc Config:** `HitMask=0x40` (BLOCK)
**Why:** Tests Iron Shield Spike damage on block.

**Test Steps:**
```
.additem 6043                      -- Iron Shield Spike
.additem 33188                     -- Shield
# Apply to shield, equip
.go creature id 32666
# Block attack
```
- [ ] Damage dealt on block
- [ ] Amount as documented

---

### Shield Block (12169)
**Proc Config:** `HitMask=0x40` (BLOCK)
**Why:** Tests Shield Block charge consumption.

**Test Steps:**
```
.learn 2565                        -- Shield Block
.additem 33188                     -- Shield
.cast 2565                         -- Shield Block
.go creature id 32666
# Block attacks
```
- [x] Charges consumed on block
- [x] Block value bonus active

---

### Unbridled Wrath (12322, 12999, 13000, 13001, 13002)
**Proc Config:** No special config
**Why:** Tests Unbridled Wrath rage generation.

**Test Steps:**
```
.learn 12322                       -- Unbridled Wrath Rank 1
.learn 13002                       -- Unbridled Wrath Rank 5
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] Rage generated on melee hit
- [ ] Proc chance matches rank

---

### Aspect of the Pack (13159)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `AttributesMask=0x2`
**Why:** Tests Aspect of the Pack daze on damage.

**Test Steps:**
```
.learn 13159                       -- Aspect of the Pack
.cast 13159                        -- Aspect of the Pack
.go creature id 32666
# Take damage
```
- [ ] Dazed on taking damage
- [ ] Effect applies to party

---

### Aspect of the Monkey (13163)
**Proc Config:** `HitMask=0x10` (DODGE), `Cooldown=20000`
**Why:** Tests Aspect of the Monkey proc.

**Test Steps:**
```
.learn 13163                       -- Aspect of the Monkey
.cast 13163                        -- Aspect of the Monkey
.go creature id 32666
# Dodge attack
```
- [ ] Proc on dodge
- [ ] 20s ICD enforced

---

### Harm Prevention Belt (13234)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `HitMask=0x403`, `AttributesMask=0x2`
**Why:** Tests engineering belt proc.

**Test Steps:**
```
.aura 13234                        -- Harm Prevention Belt
.go creature id 32666
# Take damage
```
- [ ] Absorb shield procs
- [ ] Effect as documented

---

### Flurry (15088)
**Proc Config:** `HitMask=0x2` (CRIT), `Cooldown=5000`
**Why:** Tests NPC Flurry variant.

**Test Steps:**
```
.aura 15088                        -- Flurry
# Crit with melee
```
- [ ] Attack speed buff applied
- [ ] 5s ICD enforced

---

### Mark of Flames (15128)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE)
**Why:** Tests Mark of Flames proc.

**Test Steps:**
```
.aura 15128                        -- Mark of Flames
.go creature id 32666
# Deal fire damage
```
- [ ] Effect as documented

---

### Seal of Reckoning (15277, 15346)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`
**Why:** Tests Seal of Reckoning variant.

**Test Steps:**
```
.aura 15277                        -- Seal of Reckoning
.go creature id 32666
# Melee attack
```
- [ ] Holy damage proc

---

### Hand of Justice (15600)
**Proc Config:** `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `Cooldown=2000`, `Chance=2.0`
**Why:** Tests Hand of Justice trinket proc.

**Test Steps:**
```
.additem 11815                     -- Hand of Justice
# Equip
.go creature id 32666
# Auto attack
```
- [ ] Extra attack procs (2% chance)
- [ ] 2s ICD enforced

---

### Elemental Focus (16164)
**Proc Config:** `ProcFlags=0x10000` (Spell cast), `SpellTypeMask=0x1` (DAMAGE), `SpellPhaseMask=0x2`, `HitMask=0x2` (CRIT), `Cooldown=500`
**Why:** Tests Elemental Focus clearcasting proc.

**Test Steps:**
```
.learn 16164                       -- Elemental Focus
.learn 403                         -- Lightning Bolt
.go creature id 32666
# Crit with spell
```
- [ ] Clearcasting buff applied
- [ ] Next spell costs no mana
- [ ] 500ms ICD enforced

---

### Omen of Clarity (16864)
**Proc Config:** No special config
**Why:** Tests Omen of Clarity clearcasting proc.

**Test Steps:**
```
.learn 16864                       -- Omen of Clarity
.go creature id 32666
# Auto attack or cast
```
- [ ] Clearcasting buff procs
- [ ] Next ability free

---

### Stormstrike (17364)
**Proc Config:** No special config
**Why:** Tests Stormstrike nature damage debuff.

**Test Steps:**
```
.learn 17364                       -- Stormstrike
.additem 33185                     -- Weapon (MH)
.additem 33185                     -- Weapon (OH)
.go creature id 32666
.cast 17364                        -- Stormstrike
```
- [ ] Nature damage debuff applied
- [ ] Debuff consumed by nature spells

---

### Seal of Justice (20164)
**Proc Config:** No special config
**Why:** Tests Seal of Justice stun proc.

**Test Steps:**
```
.learn 20164                       -- Seal of Justice
.additem 33185                     -- Weapon
.cast 20164                        -- Seal of Justice
.go creature id 32666
# Auto attack
```
- [ ] Stun procs on melee hit
- [ ] Duration correct

---

### Seal of Light (20165)
**Proc Config:** No special config
**Why:** Tests Seal of Light heal proc.

**Test Steps:**
```
.learn 20165                       -- Seal of Light
.additem 33185                     -- Weapon
.cast 20165                        -- Seal of Light
.go creature id 32666
# Auto attack
```
- [ ] Heal procs on melee hit
- [ ] Heal amount as documented

---

### Seal of Wisdom (20166)
**Proc Config:** No special config
**Why:** Tests Seal of Wisdom mana proc.

**Test Steps:**
```
.learn 20166                       -- Seal of Wisdom
.additem 33185                     -- Weapon
.cast 20166                        -- Seal of Wisdom
.go creature id 32666
# Auto attack
```
- [ ] Mana restored on melee hit
- [ ] Amount as documented

---

### Seal of Command (20375)
**Proc Config:** No special config
**Why:** Tests Seal of Command holy damage proc.

**Test Steps:**
```
.learn 20375                       -- Seal of Command
.additem 33185                     -- Weapon
.cast 20375                        -- Seal of Command
.go creature id 32666
# Auto attack
```
- [ ] Holy damage procs on melee hit
- [ ] Proc chance as documented (7 PPM)

---

### Redoubt (20128)
**Proc Config:** No special config
**Why:** Tests Redoubt block value increase on crit taken.

**Test Steps:**
```
.learn 20128                       -- Redoubt Rank 1
.additem 33188                     -- Shield
.go creature id 32666
# Take critical hit
```
- [ ] Block value increased
- [ ] Charges consumed on block

---

### Blessing of Sanctuary (20911)
**Proc Config:** No special config
**Why:** Tests Blessing of Sanctuary rage/mana on block.

**Test Steps:**
```
.learn 20911                       -- Blessing of Sanctuary
.additem 33188                     -- Shield
.cast 20911                        -- Blessing of Sanctuary
.go creature id 32666
# Block attack
```
- [ ] Rage/mana gained on block
- [ ] Damage reduction active

---

### Seal of Righteousness (21084)
**Proc Config:** No special config
**Why:** Tests Seal of Righteousness holy damage.

**Test Steps:**
```
.learn 21084                       -- Seal of Righteousness
.additem 33185                     -- Weapon
.cast 21084                        -- Seal of Righteousness
.go creature id 32666
# Auto attack
```
- [ ] Holy damage on every melee hit
- [ ] Amount scales with weapon speed

---

### Spell Reflection (23920)
**Proc Config:** No special config
**Why:** Tests Spell Reflection spell redirect.

**Test Steps:**
```
.learn 23920                       -- Spell Reflection
.additem 33188                     -- Shield
.cast 23920                        -- Spell Reflection
# Have another player cast spell on you
```
- [ ] Spell reflected back to caster
- [ ] Buff consumed

---

### Leader of the Pack (24932)
**Proc Config:** No special config
**Why:** Tests Leader of the Pack crit aura.

**Test Steps:**
```
.learn 17007                       -- Leader of the Pack
.learn 5487                        -- Bear Form
.cast 5487                         -- Bear Form
```
- [ ] Melee/ranged crit aura active
- [ ] Party benefits from aura

---

### Badge of the Swarmguard (26480)
**Proc Config:** No special config
**Why:** Tests Badge of the Swarmguard armor reduction.

**Test Steps:**
```
.additem 21670                     -- Badge of the Swarmguard
# Equip
# Use trinket
.go creature id 32666
# Auto attack
```
- [ ] Armor reduction stacks on hit
- [ ] Max stacks reached
- [ ] Duration correct

---

### Seal of Vengeance (31801)
**Proc Config:** No special config
**Why:** Tests Seal of Vengeance DoT stacking.

**Test Steps:**
```
.learn 31801                       -- Seal of Vengeance
.additem 33185                     -- Weapon
.cast 31801                        -- Seal of Vengeance
.go creature id 32666
# Auto attack
```
- [ ] DoT stacks applied
- [ ] Max 5 stacks
- [ ] Bonus damage at 5 stacks

---

### Seal of Corruption (53736)
**Proc Config:** No special config
**Why:** Tests Seal of Corruption (Horde Seal of Vengeance).

**Test Steps:**
```
.learn 53736                       -- Seal of Corruption
.additem 33185                     -- Weapon
.cast 53736                        -- Seal of Corruption
.go creature id 32666
# Auto attack
```
- [ ] DoT stacks applied (same as Seal of Vengeance)
- [ ] Max 5 stacks

---

### Shamanistic Rage (30823)
**Proc Config:** No special config
**Why:** Tests Shamanistic Rage mana restore.

**Test Steps:**
```
.learn 30823                       -- Shamanistic Rage
.additem 33185                     -- Weapon
.cast 30823                        -- Shamanistic Rage
.go creature id 32666
# Auto attack
```
- [ ] Mana restored on melee hit
- [ ] Damage reduction active

---

### Aspect of the Viper (34074)
**Proc Config:** No special config
**Why:** Tests Aspect of the Viper mana restore.

**Test Steps:**
```
.learn 34074                       -- Aspect of the Viper
.cast 34074                        -- Aspect of the Viper
.additem 32336                     -- Bow
.go creature id 32666
# Attack
```
- [ ] Mana restored on hit
- [ ] Damage reduction active

---

### Misdirection (34477)
**Proc Config:** No special config
**Why:** Tests Misdirection threat transfer.

**Test Steps:**
```
.learn 34477                       -- Misdirection
# Target party member
.cast 34477                        -- Misdirection
.go creature id 32666
# Attack
```
- [ ] Threat transferred to target
- [ ] 3 charges consumed

---

### Windfury Weapon (33757)
**Proc Config:** No special config
**Why:** Tests Windfury Weapon extra attacks.

**Test Steps:**
```
.learn 33757                       -- Windfury Weapon
.additem 33185                     -- Weapon
# Apply Windfury
.go creature id 32666
# Auto attack
```
- [ ] Extra attacks proc
- [ ] Attack power bonus on extra attacks

---

### Living Seed (48504)
**Proc Config:** No special config
**Why:** Tests Living Seed absorb proc.

**Test Steps:**
```
.learn 48496                       -- Living Seed Rank 1
.learn 5185                        -- Healing Touch
# Crit heal party member
```
- [ ] Living Seed applied on crit heal
- [ ] Absorb triggers on damage taken

---

### Mark of Blood (49005)
**Proc Config:** No special config
**Why:** Tests Mark of Blood heal debuff.

**Test Steps:**
```
.learn 49005                       -- Mark of Blood
.go creature id 32666
.cast 49005                        -- Mark of Blood
# Attack marked target
```
- [ ] Heal procs on attacker hit
- [ ] Charges consumed

---

### Dancing Rune Weapon (49028)
**Proc Config:** No special config
**Why:** Tests Dancing Rune Weapon clone.

**Test Steps:**
```
.learn 49028                       -- Dancing Rune Weapon
.additem 33185                     -- Weapon
.cast 49028                        -- Dancing Rune Weapon
.go creature id 32666
# Attack
```
- [ ] Rune weapon copies abilities
- [ ] Parry bonus active

---

### Bone Shield (49222)
**Proc Config:** No special config
**Why:** Tests Bone Shield charge consumption.

**Test Steps:**
```
.learn 49222                       -- Bone Shield
.cast 49222                        -- Bone Shield
.go creature id 32666
# Take damage
```
- [ ] Charges consumed on damage
- [ ] Damage reduction active
- [ ] Damage bonus active

---

### Maelstrom Weapon (51528)
**Proc Config:** No special config
**Why:** Tests Maelstrom Weapon instant cast stacks.

**Test Steps:**
```
.learn 51528                       -- Maelstrom Weapon Rank 1
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] Stacks on melee hit
- [ ] Max 5 stacks
- [ ] Instant cast at 5 stacks

---

### Honor Among Thieves (51698)
**Proc Config:** No special config
**Why:** Tests Honor Among Thieves combo point from party crits.

**Test Steps:**
```
.learn 51698                       -- Honor Among Thieves Rank 1
# Have party member crit
```
- [ ] Combo point gained on party crit
- [ ] ICD enforced

---

### Killing Machine (51123)
**Proc Config:** No special config
**Why:** Tests Killing Machine auto-crit proc.

**Test Steps:**
```
.learn 51123                       -- Killing Machine Rank 1
.additem 33185                     -- Weapon
.go creature id 32666
# Auto attack
```
- [ ] Buff procs on melee attack
- [ ] Next Frost Strike/Icy Touch auto-crits

---

### Sacred Shield (53601)
**Proc Config:** No special config
**Why:** Tests Sacred Shield absorb proc.

**Test Steps:**
```
.learn 53601                       -- Sacred Shield
.cast 53601                        -- Sacred Shield on self
.go creature id 32666
# Take damage
```
- [ ] Absorb shield procs on damage
- [ ] 6s ICD enforced

---

### Light's Beacon (53651)
**Proc Config:** No special config
**Why:** Tests Beacon of Light heal transfer.

**Test Steps:**
```
.learn 53563                       -- Beacon of Light
# Target party member
.cast 53563                        -- Beacon of Light
# Heal another party member
```
- [ ] Heal transferred to beacon target
- [ ] Transfer amount correct

---

### Focus Magic (54646)
**Proc Config:** No special config
**Why:** Tests Focus Magic crit buff return.

**Test Steps:**
```
.learn 54646                       -- Focus Magic
# Target party member
.cast 54646                        -- Focus Magic
# Have target crit
```
- [ ] Crit buff returns to caster on target crit
- [ ] Duration correct

---

### Savage Defense (62600)
**Proc Config:** No special config
**Why:** Tests Savage Defense absorb proc.

**Test Steps:**
```
.learn 62600                       -- Savage Defense
.learn 5487                        -- Bear Form
.cast 5487                         -- Bear Form
.go creature id 32666
# Crit with melee
```
- [ ] Absorb shield procs on crit
- [ ] Amount based on AP

---

## WotLK Trinket Procs

### Darkmoon Card: Greatness (57345)
**Proc Config:** No special config
**Why:** Tests Darkmoon Card: Greatness stat proc.

**Test Steps:**
```
.additem 44253                     -- Darkmoon Card: Greatness (Str)
# Equip
.go creature id 32666
# Attack
```
- [ ] Stat proc triggers
- [ ] Procs highest stat

---

### Darkmoon Card: Death (57352)
**Proc Config:** No special config
**Why:** Tests Darkmoon Card: Death damage proc.

**Test Steps:**
```
.additem 42990                     -- Darkmoon Card: Death
# Equip
.go creature id 32666
# Cast damage spells
```
- [ ] Shadow damage procs
- [ ] ICD enforced

---

### Grim Toll (60436)
**Proc Config:** No special config
**Why:** Tests Grim Toll armor penetration proc.

**Test Steps:**
```
.additem 40256                     -- Grim Toll
# Equip
.go creature id 32666
# Auto attack
```
- [ ] Armor penetration buff procs
- [ ] ICD enforced

---

### Dying Curse (60493)
**Proc Config:** No special config
**Why:** Tests Dying Curse spell power proc.

**Test Steps:**
```
.additem 40255                     -- Dying Curse
# Equip
.go creature id 32666
# Cast spells
```
- [ ] Spell power buff procs
- [ ] ICD enforced

---

### Embrace of the Spider (60490)
**Proc Config:** No special config
**Why:** Tests Embrace of the Spider haste proc.

**Test Steps:**
```
.additem 39229                     -- Embrace of the Spider
# Equip
.go creature id 32666
# Cast spells
```
- [ ] Haste buff procs
- [ ] ICD enforced

---

### Blood of the Old God (64792)
**Proc Config:** No special config
**Why:** Tests Blood of the Old God crit proc.

**Test Steps:**
```
.additem 45522                     -- Blood of the Old God
# Equip
.go creature id 32666
# Melee attack
```
- [ ] Crit rating buff procs
- [ ] ICD enforced

---

### Deathbringer's Will (71519)
**Proc Config:** No special config
**Why:** Tests Deathbringer's Will proc.

**Test Steps:**
```
.additem 50362                     -- Deathbringer's Will
# Equip
.go creature id 32666
# Auto attack
```
- [ ] Random stat proc
- [ ] ICD enforced

---

### Shadowmourne (71903)
**Proc Config:** No special config
**Why:** Tests Shadowmourne soul fragment proc.

**Test Steps:**
```
.additem 49623                     -- Shadowmourne
# Equip
.go creature id 32666
# Melee attack
```
- [ ] Soul fragments stack
- [ ] Chaos Bane at 10 stacks

---

## Pet Procs (SpellFamilyName = 13)

### Alchemist's Stone (17619)
**Proc Config:** `ProcFlags=0x8800`, `SpellTypeMask=0x7`
**Why:** Tests Alchemist's Stone potion bonus.

**Test Steps:**
```
.additem 13503                     -- Alchemist's Stone
# Equip
# Use healing/mana potion
```
- [ ] Potion effect increased by 40%
- [ ] Effect as documented

---

