/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "DBCStores.h"
#include "DBCStructure.h"
#include "GameGraveyard.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

inline void ApplySpellFix(std::initializer_list<uint32> spellIds, void(*fix)(SpellInfo*))
{
    for (uint32 spellId : spellIds)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "Spell info correction specified for non-existing spell {}", spellId);
            continue;
        }

        fix(const_cast<SpellInfo*>(spellInfo));
    }
}

void SpellMgr::LoadSpellInfoCorrections()
{
    uint32 oldMSTime = getMSTime();

    ApplySpellFix({
        467,    // Thorns (Rank 1)
        782,    // Thorns (Rank 2)
        1075,   // Thorns (Rank 3)
        8914,   // Thorns (Rank 4)
        9756,   // Thorns (Rank 5)
        9910,   // Thorns (Rank 6)
        26992,  // Thorns (Rank 7)
        53307,  // Thorns (Rank 8)
        53352,  // Explosive Shot (trigger)
        50783,  // Slam (Triggered spell)
        20647   // Execute (Triggered spell)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Scarlet Raven Priest Image
    ApplySpellFix({ 48763, 48761 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags &= ~AURA_INTERRUPT_FLAG_SPELL_ATTACK;
    });

    // Has Brewfest Mug
    ApplySpellFix({ 42533 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(347); // 15 min
    });

    // Elixir of Minor Fortitude
    ApplySpellFix({ 2378 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ManaCost = 0;
        spellInfo->ManaPerSecond = 0;
    });

    // Elixir of Detect Undead
    ApplySpellFix({ 11389 }, [](SpellInfo* spellInfo)
    {
        spellInfo->PowerType = POWER_MANA;
        spellInfo->ManaCost = 0;
        spellInfo->ManaPerSecond = 0;
    });

    // Evergrove Druid Transform Crow
    ApplySpellFix({ 38776 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(4); // 120 seconds
    });

    ApplySpellFix({
        63026, // Force Cast (HACK: Target shouldn't be changed)
        63137  // Force Cast (HACK: Target shouldn't be changed; summon position should be untied from spell destination)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DB);
    });

    ApplySpellFix({
        53096,  // Quetz'lun's Judgment
        70743,  // AoD Special
        70614   // AoD Special - Vegard
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Summon Skeletons
    ApplySpellFix({ 52611, 52612 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 64;
    });

    ApplySpellFix({
        40244,  // Simon Game Visual
        40245,  // Simon Game Visual
        40246,  // Simon Game Visual
        40247,  // Simon Game Visual
        42835   // Spout, remove damage effect, only anim is needed
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
    });

    ApplySpellFix({
        63665,  // Charge (Argent Tournament emote on riders)
        31298,  // Sleep (needs target selection script)
        2895,   // Wrath of Air Totem rank 1 (Aura)
        68933,  // Wrath of Air Totem rank 2 (Aura)
        29200   // Purify Helboar Meat
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(0);
    });

    // Howl of Azgalor
    ApplySpellFix({ 31344 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yards instead of 50000?!
    });

    ApplySpellFix({
        42818,  // Headless Horseman - Wisp Flight Port
        42821   // Headless Horseman - Wisp Flight Missile
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6); // 100 yards
    });

    // Spirit of Kirith
    ApplySpellFix({ 10853 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(3); // 1min
    });

    // Headless Horseman - Start Fire
    ApplySpellFix({ 42132 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6); // 100 yards
    });

    //They Must Burn Bomb Aura (self)
    ApplySpellFix({ 36350 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 36325; // They Must Burn Bomb Drop (DND)
    });

    // Mana Shield (rank 2)
    ApplySpellFix({ 8494 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcChance = 0; // because of bug in dbc
    });

    ApplySpellFix({
        63320,  // Glyph of Life Tap
        20335,  // Heart of the Crusader
        20336,  // Heart of the Crusader
        20337,  // Heart of the Crusader
        53228,  // Rapid Killing (Rank 1)
        53232,  // Rapid Killing (Rank 2)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_CAN_PROC_FROM_PROCS; // Entries were not updated after spell effect change, we have to do that manually
    });

    ApplySpellFix({
        31347,  // Doom
        41635,  // Prayer of Mending
        39365,  // Thundering Storm
        52124,  // Sky Darkener Assault
        42442,  // Vengeance Landing Cannonfire
        45863,  // Cosmetic - Incinerate to Random Target
        25425,  // Shoot
        45761,  // Shoot
        42611,  // Shoot
        61588,  // Blazing Harpoon
        36327   // Shoot Arcane Explosion Arrow
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Skartax Purple Beam
    ApplySpellFix({ 36384 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 2;
    });

    ApplySpellFix({
        37790,  // Spread Shot
        54172,  // Divine Storm (heal)
        66588  // Flaming Spear
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
    });

    // Divine Storm
    ApplySpellFix({ 54171 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Divine Storm (Damage)
    ApplySpellFix({ 53385 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 4;
    });

    ApplySpellFix({
        20424,  // Seal of Command
        42463,  // Seal of Vengeance
        53739   // Seal of Corruption
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Spitfire Totem
    ApplySpellFix({ 38296 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 5;
    });

    ApplySpellFix({
        40827,  // Sinful Beam
        40859,  // Sinister Beam
        40860,  // Vile Beam
        40861   // Wicked Beam
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 10;
    });

    // Unholy Frenzy
    ApplySpellFix({ 50312 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 15;
    });

    ApplySpellFix({
        17941,  // Shadow Trance
        22008,  // Netherwind Focus
        31834,  // Light's Grace
        34754,  // Clearcasting
        34936,  // Backlash
        48108,  // Hot Streak
        51124,  // Killing Machine
        54741,  // Firestarter
        64823,  // Item - Druid T8 Balance 4P Bonus
        34477,  // Misdirection
        44401,  // Missile Barrage
        18820   // Insight
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 1;
    });

    // Fireball
    ApplySpellFix({ 57761 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 1;
        spellInfo->SpellPriority = 50;
    });

    // Tidal Wave
    ApplySpellFix({ 53390 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 2;
    });

    // Oscillation Field
    ApplySpellFix({ 37408 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Ascendance (Talisman of Ascendance trinket)
    ApplySpellFix({ 28200 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 6;
    });

    // The Eye of Acherus (no spawn in phase 2 in db)
    ApplySpellFix({ 51852 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValue |= 1;
    });

    // Crafty's Ultra-Advanced Proto-Typical Shortening Blaster
    ApplySpellFix({ 51912 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Amplitude = 3000;
    });

    // Desecration Arm - 36 instead of 37 - typo?
    ApplySpellFix({ 29809 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_7_YARDS);
    });

    // Sic'em
    ApplySpellFix({ 42767 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_NEARBY_ENTRY);
    });

    // Master Shapeshifter: missing stance data for forms other than bear - bear version has correct data
    // To prevent aura staying on target after talent unlearned
    ApplySpellFix({ 48420 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Stances = 1 << (FORM_CAT - 1);
    });

    ApplySpellFix({ 48421 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Stances = 1 << (FORM_MOONKIN - 1);
    });

    ApplySpellFix({ 48422 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Stances = 1 << (FORM_TREE - 1);
    });

    // Elemental Oath
    ApplySpellFix({ 51466, 51470 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_ADD_FLAT_MODIFIER;
        spellInfo->Effects[EFFECT_1].MiscValue = SPELLMOD_EFFECT2;
        spellInfo->Effects[EFFECT_1].SpellClassMask = flag96(0x00000000, 0x00004000, 0x00000000);
    });

    // Improved Shadowform (Rank 1)
    ApplySpellFix({ 47569 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NOT_SHAPESHIFTED;   // with this spell atrribute aura can be stacked several times
    });

    // Natural shapeshifter
    ApplySpellFix({ 16834, 16835 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(21);
    });

    // Ebon Plague
    ApplySpellFix({ 51735, 51734, 51726 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyFlags[2] = 0x10;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Parasitic Shadowfiend Passive
    ApplySpellFix({ 41013 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_DUMMY;   // proc debuff, and summon infinite fiends
    });

    ApplySpellFix({
        27892,  // To Anchor 1
        27928,  // To Anchor 1
        27935,  // To Anchor 1
        27915,  // Anchor to Skulls
        27931,  // Anchor to Skulls
        27937   // Anchor to Skulls
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13);
    });

    // Wrath of the Plaguebringer
    ApplySpellFix({ 29214, 54836 }, [](SpellInfo* spellInfo)
    {
        // target allys instead of enemies, target A is src_caster, spells with effect like that have ally target
        // this is the only known exception, probably just wrong data
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
    });

    // Wind Shear
    ApplySpellFix({ 57994 }, [](SpellInfo* spellInfo)
    {
        // improper data for EFFECT_1 in 3.3.5 DBC, but is correct in 4.x
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_MODIFY_THREAT_PERCENT;
        spellInfo->Effects[EFFECT_1].BasePoints = -6; // -5%
    });

    // Improved Devouring Plague
    ApplySpellFix({ 63675 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BonusMultiplier = 0;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    ApplySpellFix({
        8145,   // Tremor Totem (instant pulse)
        6474    // Earthbind Totem (instant pulse)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_EXTRA_INITIAL_PERIOD;
    });

    // Marked for Death
    ApplySpellFix({ 53241, 53243, 53244, 53245, 53246 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(399361, 276955137, 1);
    });

    ApplySpellFix({
        70728,  // Exploit Weakness
        70840   // Devious Minds
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_PET);
    });

    // Culling The Herd
    ApplySpellFix({ 70893 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_MASTER);
    });

    // Sigil of the Frozen Conscience
    ApplySpellFix({ 54800 }, [](SpellInfo* spellInfo)
    {
        // change class mask to custom extended flags of Icy Touch
        // this is done because another spell also uses the same SpellFamilyFlags as Icy Touch
        // SpellFamilyFlags[0] & 0x00000040 in SPELLFAMILY_DEATHKNIGHT is currently unused (3.3.5a)
        // this needs research on modifier applying rules, does not seem to be in Attributes fields
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(0x00000040, 0x00000000, 0x00000000);
    });

    // Idol of the Flourishing Life
    ApplySpellFix({ 64949 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(0x00000000, 0x02000000, 0x00000000);
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_ADD_FLAT_MODIFIER;
    });

    ApplySpellFix({
        34231,  // Libram of the Lightbringer
        60792,  // Libram of Tolerance
        64956   // Libram of the Resolute
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(0x80000000, 0x00000000, 0x00000000);
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_ADD_FLAT_MODIFIER;
    });

    ApplySpellFix({
        28851,  // Libram of Light
        28853,  // Libram of Divinity
        32403   // Blessed Book of Nagrand
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(0x40000000, 0x00000000, 0x00000000);
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_ADD_FLAT_MODIFIER;
    });

    // Ride Carpet
    ApplySpellFix({ 45602 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 0; // force seat 0, vehicle doesn't have the required seat flags for "no seat specified (-1)"
    });

    ApplySpellFix({
        64745,  // Item - Death Knight T8 Tank 4P Bonus
        64936   // Item - Warrior T8 Protection 4P Bonus
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 100; // 100% chance of procc'ing, not -10% (chance calculated in PrepareTriggersExecutedOnHit)
    });

    // Easter Lay Noblegarden Egg Aura
    ApplySpellFix({ 61719 }, [](SpellInfo* spellInfo)
    {
        // Interrupt flags copied from aura which this aura is linked with
        spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE;
    });

    // Bleh, need to change FamilyFlags :/ (have the same as original aura - bad!)
    ApplySpellFix({ 63510 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyFlags[EFFECT_0] = 0;
        spellInfo->SpellFamilyFlags[EFFECT_2] = 0x4000000;
    });

    ApplySpellFix({ 63514 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyFlags[EFFECT_0] = 0;
        spellInfo->SpellFamilyFlags[EFFECT_2] = 0x2000000;
    });

    ApplySpellFix({ 63531 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyFlags[EFFECT_0] = 0;
        spellInfo->SpellFamilyFlags[EFFECT_2] = 0x8000000;
    });

    // And affecting spells
    ApplySpellFix({
        20138,  // Improved Devotion Aura
        20139,
        20140
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].SpellClassMask[0] = 0;
        spellInfo->Effects[EFFECT_1].SpellClassMask[2] = 0x2000000;
    });

    ApplySpellFix({
        20254,  // Improved concentration aura
        20255,
        20256
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].SpellClassMask[0] = 0;
        spellInfo->Effects[EFFECT_1].SpellClassMask[2] = 0x4000000;
        spellInfo->Effects[EFFECT_2].SpellClassMask[0] = 0;
        spellInfo->Effects[EFFECT_2].SpellClassMask[2] = 0x4000000;
    });

    ApplySpellFix({
        53379,  // Swift Retribution
        53484,
        53648
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] = 0;
        spellInfo->Effects[EFFECT_0].SpellClassMask[2] = 0x8000000;
    });

    // Sanctified Retribution
    ApplySpellFix({ 31869 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] = 0;
        spellInfo->Effects[EFFECT_0].SpellClassMask[2] = 0x8000000;
    });

    // Seal of Light trigger
    ApplySpellFix({ 20167 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellLevel = 0;
        spellInfo->BaseLevel = 0;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Hand of Reckoning
    ApplySpellFix({ 62124 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;
    });

    // Redemption
    ApplySpellFix({ 7328, 10322, 10324, 20772, 20773, 48949, 48950 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_PALADIN;
    });

    ApplySpellFix({
        20184,  // Judgement of Justice
        20185,  // Judgement of Light
        20186,  // Judgement of Wisdom
        68055   // Judgements of the Just
        }, [](SpellInfo* spellInfo)
    {
        // hack for seal of light and few spells, judgement consists of few single casts and each of them can proc
        // some spell, base one has disabled proc flag but those dont have this flag
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Blessing of sanctuary stats
    ApplySpellFix({ 67480 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValue = -1;
        spellInfo->SpellFamilyName = SPELLFAMILY_UNK1; // allows stacking
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_DUMMY; // just a marker
    });

    ApplySpellFix({
        6940, // Hand of Sacrifice
        64205 // Divine Sacrifice
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx7 |= SPELL_ATTR7_DONT_CAUSE_SPELL_PUSHBACK;
    });

    // Seal of Command trigger
    ApplySpellFix({ 20424 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    ApplySpellFix({
        54968,  // Glyph of Holy Light, Damage Class should be magic
        53652,  // Beacon of Light heal, Damage Class should be magic
        53654
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Wild Hunt
    ApplySpellFix({ 62758, 62762 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_DUMMY;
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_DUMMY;
    });

    // Intervene
    ApplySpellFix({ 3411 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Roar of Sacrifice
    ApplySpellFix({ 53480 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_SPLIT_DAMAGE_PCT;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ALLY);
        spellInfo->Effects[EFFECT_1].DieSides = 1;
        spellInfo->Effects[EFFECT_1].BasePoints = 19;
        spellInfo->Effects[EFFECT_1].BasePoints = 127; // all schools
    });

    // Silencing Shot
    ApplySpellFix({ 34490, 41084, 42671 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Monstrous Bite
    ApplySpellFix({ 54680, 55495, 55496, 55497, 55498, 55499 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Hunter's Mark
    ApplySpellFix({ 1130, 14323, 14324, 14325, 53338 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Cobra Strikes
    ApplySpellFix({ 53257 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 2;
        spellInfo->StackAmount = 0;
    });

    // Kill Command
    // Kill Command, Overpower
    ApplySpellFix({ 34027, 37529 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 0;
    });

    // Kindred Spirits, damage aura
    ApplySpellFix({ 57458 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_ENETRING_ARENA;
    });

    // Chimera Shot - Serpent trigger
    ApplySpellFix({ 53353 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Entrapment trigger
    ApplySpellFix({ 19185, 64803, 64804 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT;
    });

    // Improved Stings (Rank 2)
    ApplySpellFix({ 19465 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Heart of the Phoenix (triggered)
    ApplySpellFix({ 54114 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_DISMISS_PET_FIRST;
        spellInfo->RecoveryTime = 8 * 60 * IN_MILLISECONDS; // prev 600000
    });

    // Master of Subtlety
    ApplySpellFix({ 31221, 31222, 31223 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_ROGUE;
    });

    ApplySpellFix({
        31666,  // Master of Subtlety triggers
        58428   // Overkill
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_SCRIPT_EFFECT;
    });

    // Honor Among Thieves
    ApplySpellFix({ 51698, 51700, 51701 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 51699;
    });

    ApplySpellFix({
        5171,   // Slice and Dice
        6774    // Slice and Dice
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Envenom
    ApplySpellFix({ 32645, 32684, 57992, 57993 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
    });

    ApplySpellFix({
        64014,  // Expedition Base Camp Teleport
        64032,  // Formation Grounds Teleport
        64028,  // Colossal Forge Teleport
        64031,  // Scrapyard Teleport
        64030,  // Antechamber Teleport
        64029,  // Shattered Walkway Teleport
        64024,  // Conservatory Teleport
        64025,  // Halls of Invention Teleport
        65042   // Prison of Yogg-Saron Teleport
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_DEST_DB);
    });

    // Killing Spree (teleport)
    ApplySpellFix({ 57840 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6); // 100 yards
    });

    // Killing Spree
    ApplySpellFix({ 51690 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_ALLOW_WHILE_STEALTHED;
    });

    // Blood Tap visual cd reset
    ApplySpellFix({ 47804 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = 0;
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->RuneCostID = 442;
    });

    // Chains of Ice
    ApplySpellFix({ 45524 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Impurity
    ApplySpellFix({ 49220, 49633, 49635, 49636, 49638 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->SpellFamilyName = SPELLFAMILY_DEATHKNIGHT;
    });

    // Deadly Aggression (Deadly Gladiator's Death Knight Relic, item: 42620)
    ApplySpellFix({ 60549 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Magic Suppression
    ApplySpellFix({ 49224, 49610, 49611 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 0;
    });

    // Wandering Plague
    ApplySpellFix({ 50526 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Dancing Rune Weapon
    ApplySpellFix({ 49028 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = 0;
        spellInfo->ProcFlags |= PROC_FLAG_DONE_MELEE_AUTO_ATTACK;
    });

    // Death and Decay
    ApplySpellFix({ 52212 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
    });

    // T9 blood plague crit bonus
    ApplySpellFix({ 67118 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Pestilence
    ApplySpellFix({ 50842 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TargetA = TARGET_DEST_TARGET_ENEMY;
    });

    // Horn of Winter, stacking issues
    ApplySpellFix({ 57330, 57623 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetA = 0;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Scourge Strike trigger
    ApplySpellFix({ 70890 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Blood-caked Blade - Blood-caked Strike trigger
    ApplySpellFix({ 50463 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Blood Gorged
    ApplySpellFix({ 61274, 61275, 61276, 61277,61278 }, [](SpellInfo* spellInfo)
    {
        // ARP affect Death Strike and Rune Strike
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(0x1400011, 0x20000000, 0x0);
    });

    // Death Grip
    ApplySpellFix({ 49576, 49560 }, [](SpellInfo* spellInfo)
    {
        // remove main grip mechanic, leave only effect one
        //  should fix taunt on bosses and not break the pull protection at the same time (no aura provides immunity to grip mechanic)
        spellInfo->Mechanic = 0;
    });

    // Death Grip Jump Dest
    ApplySpellFix({ 57604 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Death Pact
    ApplySpellFix({ 48743 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_EXCLUDE_CASTER;
    });

    // Raise Ally (trigger)
    ApplySpellFix({ 46619 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NO_AURA_CANCEL;
    });

    // Frost Strike
    ApplySpellFix({ 49143, 51416, 51417, 51418, 51419, 55268 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_COMPLETELY_BLOCKED;
    });

    // Death Knight T10 Tank 2p Bonus
    ApplySpellFix({ 70650 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_ADD_PCT_MODIFIER;
    });

    ApplySpellFix({ 45297, 45284 }, [](SpellInfo* spellInfo)
    {
        spellInfo->CategoryRecoveryTime = 0;
        spellInfo->RecoveryTime = 0;
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS;
    });

    // Improved Earth Shield
    ApplySpellFix({ 51560, 51561 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].MiscValue = SPELLMOD_DAMAGE;
    });

    // Tidal Force
    ApplySpellFix({ 55166, 55198 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(18);
        spellInfo->ProcCharges = 0;
    });

    // Healing Stream Totem
    ApplySpellFix({ 52042 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellLevel = 0;
        spellInfo->BaseLevel = 0;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(5); // 40yd
    });

    // Earth Shield
    ApplySpellFix({ 379 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellLevel = 0;
        spellInfo->BaseLevel = 0;
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Stormstrike
    ApplySpellFix({ 17364 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Strength of Earth totem effect
    ApplySpellFix({ 8076, 8162, 8163, 10441, 25362, 25527, 57621, 58646 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].RadiusEntry = spellInfo->Effects[EFFECT_0].RadiusEntry;
        spellInfo->Effects[EFFECT_2].RadiusEntry = spellInfo->Effects[EFFECT_0].RadiusEntry;
    });

    // Flametongue Totem effect
    ApplySpellFix({ 52109, 52110, 52111, 52112, 52113, 58651, 58654, 58655 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TargetB = spellInfo->Effects[EFFECT_1].TargetB = spellInfo->Effects[EFFECT_0].TargetB = 0;
        spellInfo->Effects[EFFECT_2].TargetA = spellInfo->Effects[EFFECT_1].TargetA = spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Sentry Totem
    ApplySpellFix({ 6495 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(0);
    });

    // Bind Sight (PT)
    ApplySpellFix({ 6277 }, [](SpellInfo* spellInfo)
    {
        // because it is passive, needs this to be properly removed at death in RemoveAllAurasOnDeath()
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_CHANNELED;
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
        spellInfo->AttributesEx7 |= SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD;
    });

    // Ancestral Awakening Heal
    ApplySpellFix({ 52752 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Heroism
    ApplySpellFix({ 32182 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 57723; // Exhaustion
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Bloodlust
    ApplySpellFix({ 2825 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 57724; // Sated
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Improved Succubus
    ApplySpellFix({ 18754, 18755, 18756 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Unstable Affliction
    ApplySpellFix({ 31117 }, [](SpellInfo* spellInfo)
    {
        spellInfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    });

    // Shadowflame - trigger
    ApplySpellFix({
        47960,  // r1
        61291   // r2
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;
    });

    // Curse of Doom
    ApplySpellFix({ 18662 }, [](SpellInfo* spellInfo)
    {
        // summoned doomguard duration fix
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(6);
    });

    // Everlasting Affliction
    ApplySpellFix({ 47201, 47202, 47203, 47204, 47205 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].SpellClassMask[0] |= 2; // add corruption to affected spells
    });

    // Death's Embrace
    ApplySpellFix({ 47198, 47199, 47200 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].SpellClassMask[0] |= 0x4000; // include Drain Soul
    });

    // Improved Demonic Tactics
    ApplySpellFix({ 54347, 54348, 54349 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = spellInfo->Effects[EFFECT_0].Effect;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = spellInfo->Effects[EFFECT_0].ApplyAuraName;
        spellInfo->Effects[EFFECT_1].TargetA = spellInfo->Effects[EFFECT_0].TargetA;
        spellInfo->Effects[EFFECT_0].MiscValue = SPELLMOD_EFFECT1;
        spellInfo->Effects[EFFECT_1].MiscValue = SPELLMOD_EFFECT2;
    });

    // Rain of Fire (Doomguard)
    ApplySpellFix({ 42227 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Ritual Enslavement
    ApplySpellFix({ 22987 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_MOD_CHARM;
    });

    // Combustion, make this passive
    ApplySpellFix({ 11129 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
    });

    // Magic Absorption
    ApplySpellFix({ 29441, 29444 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellLevel = 0;
    });

    // Living Bomb
    ApplySpellFix({ 44461, 55361, 55362 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_REACTIVE_DAMAGE_PROC;
    });

    // Evocation
    ApplySpellFix({ 12051 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // MI Fireblast, WE Frostbolt, MI Frostbolt
    ApplySpellFix({ 59637, 31707, 72898 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    });

    // Blazing Speed
    ApplySpellFix({ 31641, 31642 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 31643;
    });

    // Summon Water Elemental (permanent)
    ApplySpellFix({ 70908 }, [](SpellInfo* spellInfo)
    {
        // treat it as pet
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_SUMMON_PET;
    });

    // // Burnout, trigger
    ApplySpellFix({ 44450 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_POWER_BURN;
    });

    // Mirror Image - Summon Spells
    ApplySpellFix({ 58831, 58833, 58834, 65047 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_CASTER);
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(0);
    });

    // Initialize Images (Mirror Image)
    ApplySpellFix({ 58836 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Arcane Blast, can't be dispelled
    ApplySpellFix({ 36032 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Chilled (frost armor, ice armor proc)
    ApplySpellFix({ 6136, 7321 }, [](SpellInfo* spellInfo)
    {
        spellInfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    });

    // Mirror Image Frostbolt
    ApplySpellFix({ 59638 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellFamilyName = SPELLFAMILY_MAGE;
        spellInfo->SpellFamilyFlags = flag96(0x20, 0x0, 0x0);
    });

    // Fingers of Frost
    ApplySpellFix({ 44544 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
        spellInfo->AttributesEx4 |= SPELL_ATTR4_CANNOT_BE_STOLEN;
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(685904631, 1151040, 32);
    });

    // Fingers of Frost visual buff
    ApplySpellFix({ 74396 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcCharges = 2;
        spellInfo->StackAmount = 0;
    });

    // Glyph of blocking
    ApplySpellFix({ 58375 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 58374;
    });

    // Sweeping Strikes stance change
    ApplySpellFix({ 12328 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NOT_SHAPESHIFTED;
    });

    // Damage Shield
    ApplySpellFix({ 59653 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
    });

    ApplySpellFix({
        20230,  // Retaliation
        871,    // Shield Wall
        1719    // Recklessness
        }, [](SpellInfo* spellInfo)
    {
        // Strange shared cooldown
        spellInfo->AttributesEx6 |= SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS;
    });

    // Vigilance
    ApplySpellFix({ 50720 }, [](SpellInfo* spellInfo)
    {
        // fixes bug with empowered renew, single target aura
        spellInfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    });

    // Sunder Armor - Old Ranks
    ApplySpellFix({ 7405, 8380, 11596, 11597, 25225, 47467 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 11971;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE;
    });

    // Improved Spell Reflection
    ApplySpellFix({ 59725 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER_AREA_PARTY);
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Hymn of Hope
    ApplySpellFix({ 64904 }, [](SpellInfo* spellInfo)
    {
        // rewrite part of aura system or swap effects...
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT;
        spellInfo->Effects[EFFECT_2].Effect = spellInfo->Effects[EFFECT_0].Effect;
        spellInfo->Effects[EFFECT_0].Effect = 0;
        spellInfo->Effects[EFFECT_2].DieSides = spellInfo->Effects[EFFECT_0].DieSides;
        spellInfo->Effects[EFFECT_2].TargetA = spellInfo->Effects[EFFECT_0].TargetB;
        spellInfo->Effects[EFFECT_2].RadiusEntry = spellInfo->Effects[EFFECT_0].RadiusEntry;
        spellInfo->Effects[EFFECT_2].BasePoints = spellInfo->Effects[EFFECT_0].BasePoints;
    });

    // Divine Hymn
    ApplySpellFix({ 64844 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
    });

    ApplySpellFix({
        14898,  // Spiritual Healing affects prayer of mending
        15349,
        15354,
        15355,
        15356,
        47562,  // Divine Providence affects prayer of mending
        47564,
        47565,
        47566,
        47567,
        47586,  // Twin Disciplines affects prayer of mending
        47587,
        47588,
        52802,
        52803
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask[1] |= 0x20; // prayer of mending
    });

    // Power Infusion
    ApplySpellFix({ 10060 }, [](SpellInfo* spellInfo)
    {
        // hack to fix stacking with arcane power
        spellInfo->Effects[EFFECT_2].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_2].ApplyAuraName = SPELL_AURA_ADD_PCT_MODIFIER;
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ALLY);
    });

    // Lifebloom final bloom
    ApplySpellFix({ 33778 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
        spellInfo->SpellFamilyFlags = flag96(0, 0x10, 0);
    });

    // Owlkin Frenzy
    ApplySpellFix({ 48391 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NOT_SHAPESHIFTED;
    });

    // Item T10 Restoration 4P Bonus
    ApplySpellFix({ 70691 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    ApplySpellFix({
        770,    // Faerie Fire
        16857   // Faerie Fire (Feral)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS;
    });

    ApplySpellFix({ 49376 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_3_YARDS); // 3yd
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Feral Charge - Cat
    ApplySpellFix({ 61138, 61132, 50259 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Glyph of Barkskin
    ApplySpellFix({ 63058 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE;
    });

    // Resurrection Sickness
    ApplySpellFix({ 15007 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_GENERIC;
    });

    // Luck of the Draw
    ApplySpellFix({ 72221 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Bind
    ApplySpellFix({ 3286 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets = 0; // neutral innkeepers not friendly?
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    // Playback Speech
    ApplySpellFix({ 74209 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(1);
    });

    ApplySpellFix({
        2641, // Dismiss Pet
        23356 // Taming Lesson
        }, [](SpellInfo* spellInfo)
    {
        // remove creaturetargettype
        spellInfo->TargetCreatureType = 0;
    });

    // Aspect of the Viper
    ApplySpellFix({ 34074 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(1);
        spellInfo->Effects[EFFECT_2].ApplyAuraName = SPELL_AURA_DUMMY;
    });

    // Strength of Wrynn
    ApplySpellFix({ 60509 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].BasePoints = 1500;
        spellInfo->Effects[EFFECT_1].BasePoints = 150;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_PERIODIC_HEAL;
    });

    // Winterfin First Responder
    ApplySpellFix({ 48739 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 1;
        spellInfo->Effects[EFFECT_0].RealPointsPerLevel = 0;
        spellInfo->Effects[EFFECT_0].DieSides = 0;
        spellInfo->Effects[EFFECT_0].DamageMultiplier = 0;
        spellInfo->Effects[EFFECT_0].BonusMultiplier = 0;
    });

    // Army of the Dead (trigger npc aura)
    ApplySpellFix({ 49099 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Amplitude = 15000;
    });

    // Frightening Shout
    ApplySpellFix({ 19134 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_DUMMY;
    });

    // Isle of Conquest
    ApplySpellFix({ 66551 }, [](SpellInfo* spellInfo)
    {
        // Teleport in, missing range
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13); // 50000yd
    });

    // A'dal's Song of Battle
    ApplySpellFix({ 39953 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(367); // 2 Hours
    });

    ApplySpellFix({
        57607,  // WintergraspCatapult - Spell Plague Barrel - EffectRadiusIndex
        57619,  // WintergraspDemolisher - Spell Hourl Boulder - EffectRadiusIndex
        57610   // Cannon (Siege Turret)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_25_YARDS); // SPELL_EFFECT_WMO_DAMAGE
    });

    // WintergraspCannon - Spell Fire Cannon - EffectRadiusIndex
    ApplySpellFix({ 51422 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // SPELL_EFFECT_SCHOOL_DAMAGE
    });

    // WintergraspDemolisher - Spell Ram -  EffectRadiusIndex
    ApplySpellFix({ 54107 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_3_YARDS); // SPELL_EFFECT_KNOCK_BACK
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_3_YARDS); // SPELL_EFFECT_SCHOOL_DAMAGE
        spellInfo->Effects[EFFECT_2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_3_YARDS); // SPELL_EFFECT_WEAPON_DAMAGE
    });

    // WintergraspSiegeEngine - Spell Ram - EffectRadiusIndex
    ApplySpellFix({ 51678 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // SPELL_EFFECT_KNOCK_BACK
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // SPELL_EFFECT_SCHOOL_DAMAGE
        spellInfo->Effects[EFFECT_2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS); // SPELL_EFFECT_WEAPON_DAMAGE
    });

    // WintergraspCatapult - Spell Plague Barrell - Range
    ApplySpellFix({ 57606 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(164); // "Catapult Range"
    });

    // Boulder (Demolisher)
    ApplySpellFix({ 50999 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // 10yd
    });

    // Flame Breath (Catapult)
    ApplySpellFix({ 50990 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_18_YARDS); // 18yd
    });

    // Jormungar Bite
    ApplySpellFix({ 56103 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Throw Proximity Bomb
    ApplySpellFix({ 34095 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    ApplySpellFix({
        53348,  // DEATH KNIGHT SCARLET FIRE ARROW
        53117   // BALISTA
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 5000;
        spellInfo->CategoryRecoveryTime = 5000;
    });

    // Teleport To Molten Core
    ApplySpellFix({ 25139 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    // Landen Stilwell Transform
    ApplySpellFix({ 31310 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
    });

    // Shadowstalker Stealth
    ApplySpellFix({ 5916 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RealPointsPerLevel = 5.0f;
    });

    // Sneak
    ApplySpellFix({ 22766 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RealPointsPerLevel = 5.0f;
    });

    // Murmur's Touch
    ApplySpellFix({ 38794, 33711 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 33760;
    });

    // Negaton Field
    ApplySpellFix({
        36729,  // Normal
        38834   // Heroic
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Curse of the Doomsayer NORMAL
    ApplySpellFix({ 36173 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 36174; // Currently triggers heroic version...
    });

    // Crystal Channel
    ApplySpellFix({ 34156 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(35); // 35yd;
        spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
    });

    // Debris - Debris Visual
    ApplySpellFix({ 36449, 30632 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_AURA_IS_DEBUFF;
    });

    // Soul Channel
    ApplySpellFix({ 30531 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Activate Sunblade Protecto
    ApplySpellFix({ 46475, 46476 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(14); // 60yd
    });

    // Break Ice
    ApplySpellFix({ 46638 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_ONLY_ON_PLAYER; // Obvious fail, it targets gameobject...
    });

    // Sinister Reflection Clone
    ApplySpellFix({ 45785 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Armageddon
    ApplySpellFix({ 45909 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 8.0f;
    });

    // Spell Absorption
    ApplySpellFix({ 41034 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_2].ApplyAuraName = SPELL_AURA_SCHOOL_ABSORB;
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_2].MiscValue = SPELL_SCHOOL_MASK_MAGIC;
    });

    // Shared Bonds
    ApplySpellFix({ 41363 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_CHANNELED;
    });

    ApplySpellFix({
        41485,  // Deadly Poison
        41487   // Envenom
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
    });

    // Parasitic Shadowfiend
    ApplySpellFix({ 41914 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_AURA_IS_DEBUFF;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Teleport Maiev
    ApplySpellFix({ 41221 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13); // 0-50000yd
    });

    // Watery Grave Explosion
    ApplySpellFix({ 37852 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    });

    // Amplify Damage
    ApplySpellFix({ 39095 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Energy Feedback
    ApplySpellFix({ 44335 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    ApplySpellFix({
        31984,  // Finger of Death
        35354   // Hand of Death
        }, [](SpellInfo* spellInfo)
    {
        // Spell doesn't need to ignore invulnerabilities
        spellInfo->Attributes = SPELL_ATTR0_IS_ABILITY;
    });

    // Finger of Death
    ApplySpellFix({ 32111 }, [](SpellInfo* spellInfo)
    {
        spellInfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(0); // We only need the animation, no damage
    });

    // Flame Breath, catapult spell
    ApplySpellFix({ 50989 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL;
    });

    // Koralon, Flaming Cinder
    ApplySpellFix({ 66690 }, [](SpellInfo* spellInfo)
    {
        // missing radius index
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
        spellInfo->MaxAffectedTargets = 1;
    });

    // Acid Volley
    ApplySpellFix({ 54714, 29325 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Summon Plagued Warrior
    ApplySpellFix({ 29237 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_DUMMY;
        spellInfo->Effects[EFFECT_1].Effect = spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Icebolt
    ApplySpellFix({ 28526 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    // Infected Wound
    ApplySpellFix({ 29306 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Hopeless
    ApplySpellFix({ 29125 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
    });

    // Jagged Knife
    ApplySpellFix({ 55550 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_USES_RANGED_SLOT;
    });

    // Moorabi - Transformation
    ApplySpellFix({ 55098 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    ApplySpellFix({
        55521,  // Poisoned Spear (Normal)
        58967,  // Poisoned Spear (Heroic)
        55348,  // Throw (Normal)
        58966   // Throw (Heroic)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_USES_RANGED_SLOT;
    });

    // Charged Chaotic rift aura, trigger
    ApplySpellFix({ 47737 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(37); // 50yd
    });

    // Vanish
    ApplySpellFix({ 55964 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Trollgore - Summon Drakkari Invader
    ApplySpellFix({ 49456, 49457, 49458 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DB);
    });

    ApplySpellFix({
        48278,  // Paralyse
        47669   // Awaken subboss
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[0].TargetB = SpellImplicitTargetInfo();
    });

    // Flame Breath
    ApplySpellFix({ 47592 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Amplitude = 200;
    });

    // Skarvald, Charge
    ApplySpellFix({ 43651 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13); // 0-50000yd
    });

    // Ingvar the Plunderer, Woe Strike
    ApplySpellFix({ 42730 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TriggerSpell = 42739;
    });

    ApplySpellFix({ 59735 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TriggerSpell = 59736;
    });

    // Ingvar the Plunderer, Ingvar transform
    ApplySpellFix({ 42796 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    ApplySpellFix({
        42772,  // Hurl Dagger (Normal)
        59685   // Hurl Dagger (Heroic)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_USES_RANGED_SLOT;
    });

    // Control Crystal Activation
    ApplySpellFix({ 57804 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(1);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Destroy Door Seal
    ApplySpellFix({ 58040 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ChannelInterruptFlags &= ~(AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE);
    });

    // Ichoron, Water Blast
    ApplySpellFix({ 54237, 59520 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Krik'thir - Mind Flay
    ApplySpellFix({ 52586, 59367 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
    });

    // Glare of the Tribunal
    ApplySpellFix({ 50988, 59870 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Static Charge
    ApplySpellFix({ 50835, 59847 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
    });

    // Lava Strike damage
    ApplySpellFix({ 57697 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Lava Strike trigger
    ApplySpellFix({ 57578 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Gift of Twilight Shadow/Fire
    ApplySpellFix({ 57835, 58766 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_CHANNELED;
    });

    // Pyrobuffet
    ApplySpellFix({ 57557 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 56911;
    });

    // Arcane Barrage
    ApplySpellFix({ 56397 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo();
    });

    ApplySpellFix({
        55849,  // Power Spark (ground +50% dmg aura)
        56438,  // Arcane Overload (-50% dmg taken) - this is to prevent apply -> unapply -> apply ... dunno whether it's correct
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Vortex (Control Vehicle)
    ApplySpellFix({ 56263 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Haste (Nexus Lord, increase run Speed of the disk)
    ApplySpellFix({ 57060 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_VEHICLE);
    });

    // Arcane Overload
    ApplySpellFix({ 56430 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 56429;
    });

    // Summon Arcane Bomb
    ApplySpellFix({ 56429 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo();
    });

    // Destroy Platform Event
    ApplySpellFix({ 59099 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(22);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(15);
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(22);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo(15);
    });

    // Surge of Power (Phase 3)
    ApplySpellFix({
        57407,  // N
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->InterruptFlags = 0;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS);
        spellInfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Surge of Power (Phase 3)
    ApplySpellFix({
        60936   // H
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
        spellInfo->InterruptFlags = 0;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS);
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Wyrmrest Drake - Life Burst
    ApplySpellFix({ 57143 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
        spellInfo->Effects[EFFECT_1].PointsPerComboPoint = 2500;
        spellInfo->Effects[EFFECT_1].BasePoints = 2499;
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(1);
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    //Alexstrasza - Gift
    ApplySpellFix({ 61028 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Vortex (freeze anim)
    ApplySpellFix({ 55883 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Hurl Pyrite
    ApplySpellFix({ 62490 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Ulduar, Mimiron, Magnetic Core (summon)
    ApplySpellFix({ 64444 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_CASTER);
    });

    // Ulduar, Mimiron, bomb bot explosion
    ApplySpellFix({ 63801 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].MiscValue = 17286;
    });

    // Ulduar, Mimiron, Summon Flames Initial
    ApplySpellFix({ 64563 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Ulduar, Mimiron, Flames (damage)
    ApplySpellFix({ 64566 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Ulduar, Hodir, Starlight
    ApplySpellFix({ 62807 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_1_YARD); // 1yd
    });

    // Hodir Shatter Cache
    ApplySpellFix({ 62502 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
    });

    // Ulduar, General Vezax, Mark of the Faceless
    ApplySpellFix({ 63278 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
    });

    // Boom (XT-002)
    ApplySpellFix({ 62834 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Supercharge
    ApplySpellFix({ 61920 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Lightning Whirl
    ApplySpellFix({ 61916 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 3;
    });

    ApplySpellFix({ 63482 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 8;
    });

    // Stone Grip, remove absorb aura
    ApplySpellFix({ 62056, 63985 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Sentinel Blast
    ApplySpellFix({ 64389, 64678 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Dispel = DISPEL_MAGIC;
    });

    // Potent Pheromones
    ApplySpellFix({ 62619 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_IMMUNITY_PURGES_EFFECT;
    });

    // Healthy spore summon periodic
    ApplySpellFix({ 62566 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Amplitude = 2000;
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
    });

    // Brightleaf Essence trigger
    ApplySpellFix({ 62968 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0; // duplicate
    });

    // Potent Pheromones
    ApplySpellFix({ 64321 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
        spellInfo->AttributesEx |= SPELL_ATTR1_IMMUNITY_PURGES_EFFECT;
    });

    // Lightning Orb Charged
    ApplySpellFix({ 62186 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Amplitude = 5000; // Duration 5 secs, amplitude 8 secs...
    });

    // Lightning Pillar
    ApplySpellFix({ 62976 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6);
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(28); // 5 seconds, wrong DBC data?
    });

    // Sif's Blizzard
    ApplySpellFix({ 62576, 62602 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_8_YARDS); // 8yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_8_YARDS); // 8yd
    });

    // Protective Gaze
    ApplySpellFix({ 64175 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 25000;
    });

    // Shadow Beacon
    ApplySpellFix({ 64465 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 64467; // why do they need two script effects :/ (this one has visual effect)
    });

    // Sanity
    ApplySpellFix({ 63050 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
    });

    // Shadow Nova
    ApplySpellFix({ 62714, 65209 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Cosmic Smash (Algalon the Observer)
    ApplySpellFix({ 62293 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_DEST_CASTER);
    });

    // Cosmic Smash (Algalon the Observer)
    ApplySpellFix({ 62311, 64596 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13);  // 50000yd
    });

    // Constellation Phase Effect
    ApplySpellFix({ 65509 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Black Hole
    ApplySpellFix({ 62168, 65250, 62169 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_AURA_IS_DEBUFF;
    });

    // Ground Slam
    ApplySpellFix({ 62625 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // Onyxia's Lair, Onyxia, Flame Breath (TriggerSpell = 0 and spamming errors in console)
    ApplySpellFix({ 18435 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Onyxia's Lair, Onyxia, Create Onyxia Spawner
    ApplySpellFix({ 17647 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(37);
    });

    ApplySpellFix({
        17646,  // Onyxia's Lair, Onyxia, Summon Onyxia Whelp
        68968   // Onyxia's Lair, Onyxia, Summon Lair Guard
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13); // 50000yd
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(5);
    });

    // Onyxia's Lair, Onyxia, Eruption
    ApplySpellFix({ 17731, 69294 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_DUMMY;
        spellInfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(3);
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_18_YARDS); // 18yd instead of 13yd to make sure all cracks erupt
    });

    // Onyxia's Lair, Onyxia, Breath
    ApplySpellFix({
        18576, 18578, 18579, 18580, 18581, 18582, 18583, 18609, 18611, 18612, 18613, 18614, 18615, 18616, 18584,
        18585, 18586, 18587, 18588, 18589, 18590, 18591, 18592, 18593, 18594, 18595, 18564, 18565, 18566, 18567,
        18568, 18569, 18570, 18571, 18572, 18573, 18574, 18575, 18596, 18597, 18598, 18599, 18600, 18601, 18602,
        18603, 18604, 18605, 18606, 18607, 18617, 18619, 18620, 18621, 18622, 18623, 18624, 18625, 18626, 18627,
        18628, 18618, 18351, 18352, 18353, 18354, 18355, 18356, 18357, 18358, 18359, 18360, 18361, 17086, 17087,
        17088, 17089, 17090, 17091, 17092, 17093, 17094, 17095, 17097, 22267, 22268, 21132, 21133, 21135, 21136,
        21137, 21138, 21139
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(328); // 250ms
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(1);
        if (spellInfo->Effects[EFFECT_1].Effect)
        {
            spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
            spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
            spellInfo->Effects[EFFECT_1].Amplitude = ((spellInfo->CastTimeEntry == sSpellCastTimesStore.LookupEntry(170)) ? 50 : 215);
        }
    });

    ApplySpellFix({
        48760,  // Oculus, Teleport to Coldarra DND
        49305   // Oculus, Teleport to Boss 1 DND
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(25);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(17);
    });

    // Oculus, Drake spell Stop Time
    ApplySpellFix({ 49838 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
        spellInfo->ExcludeTargetAuraSpell = 51162; // exclude planar shift
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_150_YARDS);
    });

    // Oculus, Varos Cloudstrider, Energize Cores
    ApplySpellFix({ 61407, 62136, 56251, 54069 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CONE_ENTRY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Halls of Lightning, Arc Weld
    ApplySpellFix({ 59086 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(1);
    });

    // Halls of Lightning, Arcing Burn
    ApplySpellFix({ 52671, 59834 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Trial of the Champion, Death's Respite
    ApplySpellFix({ 68306 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(25);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(25);
    });

    // Trial of the Champion, Eadric Achievement (The Faceroller)
    ApplySpellFix({ 68197 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
        spellInfo->Attributes |= SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD;
    });

    // Trial of the Champion, Earth Shield
    ApplySpellFix({ 67530 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_PROC_TRIGGER_SPELL; // will trigger 67537
    });

    // Trial of the Champion, Hammer of the Righteous
    ApplySpellFix({ 66867 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_DUMMY;
    });

    // Trial of the Champion, Summon Risen Jaeren/Arelas
    ApplySpellFix({ 67705, 67715 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    });

    // Trial of the Champion, Ghoul Explode
    ApplySpellFix({ 67751 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS);
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
        spellInfo->Effects[EFFECT_2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS);
    });

    // Trial of the Champion, Desecration
    ApplySpellFix({ 67778, 67877 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 68766;
    });

    // Killing Spree (Off hand damage)
    ApplySpellFix({ 57842 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(2); // Melee Range
    });

    // Trial of the Crusader, Jaraxxus Intro spell
    ApplySpellFix({ 67888 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Trial of the Crusader, Lich King Intro spell
    ApplySpellFix({ 68193 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
    });

    // Trial of the Crusader, Gormok, player vehicle spell, CUSTOM! (default jump to hand, not used)
    ApplySpellFix({ 66342 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_SET_VEHICLE_ID;
        spellInfo->Effects[EFFECT_0].MiscValue = 496;
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(21);
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13);
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(25);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Trial of the Crusader, Gormok, Fire Bomb
    ApplySpellFix({ 66313 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ANY);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ANY);
        spellInfo->Effects[EFFECT_1].Effect  = 0;
    });

    ApplySpellFix({ 66317 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    ApplySpellFix({ 66318 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Speed = 14.0f;
        spellInfo->Attributes |= SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT;
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    ApplySpellFix({ 66320, 67472, 67473, 67475 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_2_YARDS);
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_2_YARDS);
    });

    // Trial of the Crusader, Acidmaw & Dreadscale, Emerge
    ApplySpellFix({ 66947 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    });

    // Trial of the Crusader, Jaraxxus, Curse of the Nether
    ApplySpellFix({ 66211 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 66209; // exclude Touch of Jaraxxus
    });

    // Trial of the Crusader, Jaraxxus, Summon Volcano
    ApplySpellFix({ 66258, 67901 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(85); // summon for 18 seconds, 15 not enough
    });

    // Trial of the Crusader, Jaraxxus, Spinning Pain Spike
    ApplySpellFix({ 66281 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_4_YARDS);
    });

    ApplySpellFix({ 66287 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_TAUNT;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_NEARBY_ENTRY);
        spellInfo->Effects[EFFECT_2].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_2].ApplyAuraName = SPELL_AURA_MOD_STUN;
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(35); // 4 secs
    });

    // Trial of the Crusader, Jaraxxus, Fel Fireball
    ApplySpellFix({ 66532, 66963, 66964, 66965 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // tempfix, make Nether Power not stealable
    ApplySpellFix({ 66228, 67106, 67107, 67108 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_CANNOT_BE_STOLEN;
    });

    // Trial of the Crusader, Faction Champions, Druid - Tranquality
    ApplySpellFix({ 66086, 67974, 67975, 67976 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AREA_AURA_FRIEND;
    });

    // Trial of the Crusader, Faction Champions, Shaman - Earth Shield
    ApplySpellFix({ 66063 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_PROC_TRIGGER_SPELL;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 66064;
    });

    // Trial of the Crusader, Faction Champions, Priest - Mana Burn
    ApplySpellFix({ 66100 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 5;
        spellInfo->Effects[EFFECT_0].DieSides = 0;
    });

    ApplySpellFix({ 68026 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 8;
        spellInfo->Effects[EFFECT_0].DieSides = 0;
    });

    ApplySpellFix({ 68027 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 6;
        spellInfo->Effects[EFFECT_0].DieSides = 0;
    });

    ApplySpellFix({ 68028 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 10;
        spellInfo->Effects[EFFECT_0].DieSides = 0;
    });

    // Trial of the Crusader, Twin Valkyr, Touch of Light/Darkness, Light/Dark Surge
    ApplySpellFix({
        65950   // light 0
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->EffectApplyAuraName[0] = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        65767   // light surge 0
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 65686;
    });

    ApplySpellFix({
        67296   // light 1
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        67274   // light surge 1
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67222;
    });

    ApplySpellFix({
        67297   // light 2
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        67275   // light surge 2
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67223;
    });

    ApplySpellFix({
        67298   // light 3
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        67276   // light surge 3
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67224;
    });

    ApplySpellFix({
        66001   // dark 0
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        65769   // dark surge 0
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 65684;
    });

    ApplySpellFix({
        67281   // dark 1
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        67265   // dark surge 1
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67176;
    });

    ApplySpellFix({
        67282   // dark 2
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        67266   // dark surge 2
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67177;
    });

    ApplySpellFix({
        67283   // dark 3
        }, [](SpellInfo* spellInfo)
    {
        //spellInfo->Effects[EFFECT_0].ApplyAuraNames = SPELL_AURA_PERIODIC_DUMMY;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    ApplySpellFix({
        67267   // dark surge 3
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 67178;
    });

    // Trial of the Crusader, Twin Valkyr, Twin's Pact
    ApplySpellFix({ 65875, 67303, 67304, 67305, 65876, 67306, 67307, 67308 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Trial of the Crusader, Anub'arak, Emerge
    ApplySpellFix({ 65982 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    });

    // Trial of the Crusader, Anub'arak, Penetrating Cold
    ApplySpellFix({ 66013, 67700, 68509, 68510 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
    });

    // Trial of the Crusader, Anub'arak, Shadow Strike
    ApplySpellFix({ 66134 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
        spellInfo->Effects[EFFECT_0].Effect = 0;
    });

    // Trial of the Crusader, Anub'arak, Pursuing Spikes
    ApplySpellFix({ 65920, 65922, 65923 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_PERIODIC_DUMMY;
        //spellInfo->EffectTriggerSpell[0] = 0;
    });

    // Trial of the Crusader, Anub'arak, Summon Scarab
    ApplySpellFix({ 66339 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(35);
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(25);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Trial of the Crusader, Anub'arak, Achievements: The Traitor King
    ApplySpellFix({
        68186,  // Anub'arak Scarab Achievement 10
        68515   // Anub'arak Scarab Achievement 25
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
        spellInfo->Attributes |= SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD;
    });

    // Trial of the Crusader, Anub'arak, Spider Frenzy
    ApplySpellFix({ 66129 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Soul Sickness
    ApplySpellFix({ 69131 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_PERIODIC_TRIGGER_SPELL;
        spellInfo->Effects[EFFECT_0].Amplitude = 8000;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 69133;
    });

    // Phantom Blast
    ApplySpellFix({ 68982, 70322 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags |= SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // Empowered Blizzard
    ApplySpellFix({ 70131 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Ice Lance Volley
    ApplySpellFix({ 70464 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_70_YARDS);
    });

    ApplySpellFix({
        70513,   // Multi-Shot
        59514    // Shriek of the Highborne
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CONE_ENTRY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Icicle
    ApplySpellFix({ 69428, 69426 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags = 0;
        spellInfo->AuraInterruptFlags = 0;
        spellInfo->ChannelInterruptFlags = 0;
    });

    ApplySpellFix({ 70525, 70639 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
        spellInfo->Effects[EFFECT_2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_500_YARDS); // 500yd
    });

    // Frost Nova
    ApplySpellFix({ 68198 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13);
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
    });

    // Blight
    ApplySpellFix({ 69604, 70286 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->AttributesEx3 |= (SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_ONLY_ON_PLAYER);
    });

    // Chilling Wave
    ApplySpellFix({ 68778, 70333 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    ApplySpellFix({ 68786, 70336 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= (SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_ONLY_ON_PLAYER);
        spellInfo->Effects[EFFECT_2].Effect = SPELL_EFFECT_DUMMY;
    });

    // Pursuit
    ApplySpellFix({ 68987 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo();
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6); // 100yd
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    ApplySpellFix({ 69029, 70850 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Explosive Barrage
    ApplySpellFix({ 69263 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_MOD_STUN;
    });

    // Overlord's Brand
    ApplySpellFix({ 69172 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcFlags = DONE_HIT_PROC_FLAG_MASK & ~PROC_FLAG_DONE_PERIODIC;
        spellInfo->ProcChance = 100;
    });

    // Icy Blast
    ApplySpellFix({ 69232 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TriggerSpell = 69238;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    ApplySpellFix({ 69233, 69646 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    ApplySpellFix({ 69238, 69628 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_DEST_DYNOBJ_NONE);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_DEST_DYNOBJ_NONE);
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Hoarfrost
    ApplySpellFix({ 69246, 69245, 69645 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Devour Humanoid
    ApplySpellFix({ 69503 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ChannelInterruptFlags |= 0;
        spellInfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING;
    });

    // Falric: Defiling Horror
    ApplySpellFix({ 72435, 72452 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS);
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS);
    });

    // Frostsworn General - Throw Shield
    ApplySpellFix({ 69222, 73076 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    });

    // Halls of Reflection Clone
    ApplySpellFix({ 69828 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Summon Ice Wall
    ApplySpellFix({ 69768 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL;
    });

    ApplySpellFix({ 69767 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ANY);
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    // Essence of the Captured
    ApplySpellFix({ 73035, 70719 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13);
    });

    // Achievement Check
    ApplySpellFix({ 72830 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS);
    });

    ApplySpellFix({
        70781,  // Light's Hammer Teleport
        70856,  // Oratory of the Damned Teleport
        70857,  // Rampart of Skulls Teleport
        70858,  // Deathbringer's Rise Teleport
        70859,  // Upper Spire Teleport
        70860,  // Frozen Throne Teleport
        70861   // Sindragosa's Lair Teleport
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DB); // this target is for SPELL_EFFECT_TELEPORT_UNITS
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_2].TargetB = SpellImplicitTargetInfo();
    });

    ApplySpellFix({
        70960,  // Bone Flurry
        71258   // Adrenaline Rush (Ymirjar Battle-Maiden)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx &= ~SPELL_ATTR1_IS_SELF_CHANNELED;
    });

    // Saber Lash (Lord Marrowgar)
    ApplySpellFix({ 69055, 70814 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_5_YARDS); // 5yd
    });

    // Impaled (Lord Marrowgar)
    ApplySpellFix({ 69065 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;   // remove stun so Dispersion can be used
    });

    // Cold Flame (Lord Marrowgar)
    ApplySpellFix({ 72701, 72702, 72703, 72704 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo();
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(9);   // 30 secs instead of 12, need him for longer, but will stop his actions after 12 secs
    });

    ApplySpellFix({ 69138 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(9);   // 30 secs instead of 12, need him for longer, but will stop his actions after 12 secs
    });

    ApplySpellFix({ 69146, 70823, 70824, 70825 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_3_YARDS); // 3yd instead of 5yd
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Dark Martyrdom (Lady Deathwhisper)
    ApplySpellFix({ 70897 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    });

    ApplySpellFix({
        69075,  // Bone Storm (Lord Marrowgar)
        70834,  // Bone Storm (Lord Marrowgar)
        70835,  // Bone Storm (Lord Marrowgar)
        70836,  // Bone Storm (Lord Marrowgar)
        72378,  // Blood Nova (Deathbringer Saurfang)
        73058,  // Blood Nova (Deathbringer Saurfang)
        72769,  // Scent of Blood (Deathbringer Saurfang)
        72385,  // Boiling Blood (Deathbringer Saurfang)
        72441,  // Boiling Blood (Deathbringer Saurfang)
        72442,  // Boiling Blood (Deathbringer Saurfang)
        72443,  // Boiling Blood (Deathbringer Saurfang)
        71160,  // Plague Stench (Stinky)
        71161,  // Plague Stench (Stinky)
        71123,  // Decimate (Stinky & Precious)
        71464   // Divine Surge (Sister Svalna)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS);   // 100yd
    });

    // Shadow's Fate
    ApplySpellFix({ 71169 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Lock Players and Tap Chest
    ApplySpellFix({ 72347 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Award Reputation - Boss Kill
    ApplySpellFix({ 73843, 73844, 73845, 73846 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS);
    });

    // Death Plague (Rotting Frost Giant)
    ApplySpellFix({ 72864 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 0;
    });

    // Gunship Battle, spell Below Zero
    ApplySpellFix({ 69705 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Resistant Skin (Deathbringer Saurfang adds)
    ApplySpellFix({ 72723 }, [](SpellInfo* spellInfo)
    {
        // this spell initially granted Shadow damage immunity, however it was removed but the data was left in client
        spellInfo->Effects[EFFECT_2].Effect = 0;
    });

    // Mark of the Fallen Champion (Deathbringer Saurfang)
    ApplySpellFix({ 72255, 72444, 72445, 72446 }, [](SpellInfo* spellInfo)
    {
        // Patch 3.3.2 (2010-01-02): Deathbringer Saurfang will no longer gain blood power from Mark of the Fallen Champion.
        // prevented in script, effect needed for Prayer of Mending
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Coldflame Jets (Traps after Saurfang)
    ApplySpellFix({ 70460 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(1); // 10 seconds
    });

    ApplySpellFix({
        70461,  // Coldflame Jets (Traps after Saurfang)
        71289   // Dominate Mind (Lady Deathwhisper)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Severed Essence (Val'kyr Herald)
    ApplySpellFix({ 71906, 71942 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    ApplySpellFix({
        71159,  // Awaken Plagued Zombies (Precious)
        71302   // Awaken Ymirjar Fallen (Ymirjar Deathbringer)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(21);
    });

    // Blood Prince Council, Invocation of Blood
    ApplySpellFix({ 70981, 70982, 70952 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0; // clear share health aura
    });

    // Ymirjar Frostbinder, Frozen Orb
    ApplySpellFix({ 71274 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(6);
    });

    // Ooze Flood (Rotface)
    ApplySpellFix({ 69783, 69797, 69799, 69802 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_EXCLUDE_CASTER;
    });

    // Volatile Ooze Beam Protection
    ApplySpellFix({ 70530 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AURA; // blizzard typo, 65 instead of 6, aura itself is defined (dummy)
    });

    // Professor Putricide, Gaseous Bloat (Orange Ooze Channel)
    ApplySpellFix({ 70672, 72455, 72832, 72833 }, [](SpellInfo* spellInfo)
    {
        // copied attributes from Green Ooze Channel
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    ApplySpellFix({
        71412,  // Green Ooze Summon (Professor Putricide)
        71415   // Orange Ooze Summon (Professor Putricide)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    ApplySpellFix({
        71621,  // Create Concoction (Professor Putricide)
        72850,
        72851,
        72852,
        71893,  // Guzzle Potions (Professor Putricide)
        73120,
        73121,
        73122
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(15); // 4 sec
    });

    // Mutated Plague (Professor Putricide)
    ApplySpellFix({ 72454, 72464, 72506, 72507 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    // Unbound Plague (Professor Putricide) (needs target selection script)
    ApplySpellFix({ 70911, 72854, 72855, 72856 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    });

    // Mutated Transformation (Professor Putricide)
    ApplySpellFix({ 70402, 72511, 72512, 72513 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    });

    // Empowered Flare (Blood Prince Council)
    ApplySpellFix({ 71708, 72785, 72786, 72787 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    ApplySpellFix({
        71518,  // Unholy Infusion Quest Credit (Professor Putricide)
        72934,  // Blood Infusion Quest Credit (Blood-Queen Lana'thel)
        72289   // Frost Infusion Quest Credit (Sindragosa)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS);   // another missing radius
    });

    // Swarming Shadows
    ApplySpellFix({ 71266, 72890 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AreaGroupId = 0; // originally, these require area 4522, which is... outside of Icecrown Citadel
    });

    ApplySpellFix({
        71301,  // Summon Dream Portal (Valithria Dreamwalker)
        71977   // Summon Nightmare Portal (Valithria Dreamwalker)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Column of Frost (visual marker)
    ApplySpellFix({ 70715 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(32); // 6 seconds (missing)
    });

    // Mana Void (periodic aura)
    ApplySpellFix({ 71085 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(9); // 30 seconds (missing)
    });

    // Summon Suppressor (needs target selection script)
    ApplySpellFix({ 70936 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Corruption
    ApplySpellFix({ 70602 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    ApplySpellFix({
        72706,  // Achievement Check (Valithria Dreamwalker)
        71357   // Order Whelp
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS);   // 200yd
    });

    // Sindragosa's Fury
    ApplySpellFix({ 70598 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Tail Smash (Sindragosa)
    ApplySpellFix({ 71077 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_CASTER_BACK);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_DEST_CASTER_BACK);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
    });

    // Frost Bomb
    ApplySpellFix({ 69846 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 0.0f;    // This spell's summon happens instantly
    });

    // Mystic Buffet (Sindragosa)
    ApplySpellFix({ 70127, 72528, 72529, 72530 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0; // remove obsolete spell effect with no targets
    });

    // Sindragosa, Frost Aura
    ApplySpellFix({ 70084, 71050, 71051, 71052 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Ice Lock
    ApplySpellFix({ 71614 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Mechanic = MECHANIC_STUN;
    });

    // Lich King, Infest
    ApplySpellFix({ 70541, 73779, 73780, 73781 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Lich King, Necrotic Plague
    ApplySpellFix({ 70337, 73912, 73913, 73914, 70338, 73785, 73786, 73787 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    ApplySpellFix({
        69099,  // Ice Pulse 10n
        73776,  // Ice Pulse 25n
        73777,  // Ice Pulse 10h
        73778   // Ice Pulse 25h
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Fury of Frostmourne
    ApplySpellFix({ 72350 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    ApplySpellFix({
        72351,  // Fury of Frostmourne
        72431,  // Jump (removes Fury of Frostmourne debuff)
        72429,  // Mass Resurrection
        73159   // Play Movie
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    // Raise Dead
    ApplySpellFix({ 72376 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 4;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    // Jump
    ApplySpellFix({ 71809 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(5); // 40yd
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // 10yd
        spellInfo->Effects[EFFECT_0].MiscValue = 190;
    });

    // Broken Frostmourne
    ApplySpellFix({ 72405 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
    });

    // Summon Shadow Trap
    ApplySpellFix({ 73540 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(3); // 60 seconds
    });

    // Shadow Trap (visual)
    ApplySpellFix({ 73530 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(28); // 5 seconds
    });

    // Shadow Trap
    ApplySpellFix({ 73529 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // 10yd
    });

    // Shadow Trap (searcher)
    ApplySpellFix({ 74282 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_3_YARDS); // 3yd
    });

    // Raging Spirit Visual
    ApplySpellFix({ 69198 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13); // 50000yd
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Defile
    ApplySpellFix({ 72762 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(559); // 53 seconds
        spellInfo->ExcludeCasterAuraSpell = 0;
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
        spellInfo->AttributesEx6 |= (SPELL_ATTR6_IGNORE_PHASE_SHIFT | SPELL_ATTR6_CAN_TARGET_UNTARGETABLE);
    });

    // Defile
    ApplySpellFix({ 72743 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(22); // 45 seconds
    });

    ApplySpellFix({ 72754, 73708, 73709, 73710 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
    });

    // Val'kyr Target Search
    ApplySpellFix({ 69030 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Harvest Souls
    ApplySpellFix({ 73654, 74295, 74296, 74297 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
        spellInfo->Effects[EFFECT_2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    // Restore Soul
    ApplySpellFix({ 72595, 73650 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
    });

    // Kill Frostmourne Players
    ApplySpellFix({ 75127 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    // Harvest Soul
    ApplySpellFix({ 73655 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    });

    // Destroy Soul
    ApplySpellFix({ 74086 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
    });

    // Summon Spirit Bomb
    ApplySpellFix({ 74302, 74342 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
        spellInfo->MaxAffectedTargets = 1;
    });

    // Summon Spirit Bomb
    ApplySpellFix({ 74341, 74343 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_200_YARDS); // 200yd
        spellInfo->MaxAffectedTargets = 3;
    });

    // Summon Spirit Bomb
    ApplySpellFix({ 73579 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_25_YARDS); // 25yd
    });

    // Trigger Vile Spirit (Inside, Heroic)
    ApplySpellFix({ 73582 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS); // 50000yd
    });

    // Scale Aura (used during Dominate Mind from Lady Deathwhisper)
    ApplySpellFix({ 73261 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Leap to a Random Location
    ApplySpellFix({ 70485 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6); // 100yd
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS);
        spellInfo->Effects[EFFECT_0].MiscValue = 100;
    });

    // Empowered Blood
    ApplySpellFix({ 70227, 70232 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AreaGroupId = 2452; // Whole icc instead of Crimson Halls only, remove when area calculation is fixed
    });

    ApplySpellFix({ 74509 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS); // 20yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS); // 20yd
    });

    // Rallying Shout
    ApplySpellFix({ 75414 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS); // 20yd
    });

    // Barrier Channel
    ApplySpellFix({ 76221 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ChannelInterruptFlags &= ~(AURA_INTERRUPT_FLAG_TURNING | AURA_INTERRUPT_FLAG_MOVE);
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_NEARBY_ENTRY);
    });

    // Intimidating Roar
    ApplySpellFix({ 74384 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
    });

    ApplySpellFix({
        74562,  // Fiery Combustion
        74792   // Soul Consumption
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION;
    });

    // Combustion
    ApplySpellFix({ 75883, 75884 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_6_YARDS); // 6yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_6_YARDS); // 6yd
    });

    // Consumption
    ApplySpellFix({ 75875, 75876 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_6_YARDS); // 6yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_6_YARDS); // 6yd
        spellInfo->Effects[EFFECT_0].Mechanic = MECHANIC_NONE;
        spellInfo->Effects[EFFECT_1].Mechanic = MECHANIC_SNARE;
    });

    // Soul Consumption
    ApplySpellFix({ 74799 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_12_YARDS); // 12yd
    });

    // Twilight Cutter
    ApplySpellFix({ 74769, 77844, 77845, 77846 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
    });

    // Twilight Mending
    ApplySpellFix({ 75509 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
        spellInfo->Effects[EFFECT_1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_100_YARDS); // 100yd
    });

    // Meteor Strike
    ApplySpellFix({ 74637 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 0;
    });

    //Blazing Aura
    ApplySpellFix({ 75885, 75886 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    ApplySpellFix({
        75952,  //Meteor Strike
        74629   //Combustion Periodic
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 &= ~SPELL_ATTR4_NO_CAST_LOG;
    });

    // Going Bearback
    ApplySpellFix({ 54897 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_DUMMY;
        spellInfo->Effects[EFFECT_1].RadiusEntry = spellInfo->Effects[EFFECT_0].RadiusEntry;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENTRY);
    });

    // Still At It
    ApplySpellFix({ 51931, 51932, 51933 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(38);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Rallying the Troops
    ApplySpellFix({ 47394 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 47394;
    });

    // A Tangled Skein
    ApplySpellFix({ 51165, 51173 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    ApplySpellFix({
        69563,  // A Cloudlet of Classy Cologne
        69445,  // A Perfect Puff of Perfume
        69489   // Bonbon Blitz
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Control
    ApplySpellFix({ 30790 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].MiscValue = 0;
    });

    // Reclusive Runemaster
    ApplySpellFix({ 48028 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
    });

    // Mastery of
    ApplySpellFix({ 65147 }, [](SpellInfo* spellInfo)
    {
        spellInfo->CategoryEntry = sSpellCategoryStore.LookupEntry(1244);
        spellInfo->CategoryRecoveryTime = 1500;
    });

    // Weakness to Lightning
    ApplySpellFix({ 46432 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    // Wrangle Some Aether Rays!
    ApplySpellFix({ 40856 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(27); // 3000ms
    });

    // The Black Knight's Orders
    ApplySpellFix({ 63163 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 52390;
    });

    // The Warp Rifts
    ApplySpellFix({ 34888 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(5); // 300 secs
    });

    // The Smallest Creatures
    ApplySpellFix({ 38544 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 427;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(1);
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Ridding the red rocket
    ApplySpellFix({ 49177 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 1; // corrects seat id (points - 1 = seatId)
    });

    // Jormungar Strike
    ApplySpellFix({ 56513 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 2000;
    });

    ApplySpellFix({
        37851, // Tag Greater Felfire Diemetradon
        37918  // Arcano-pince
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 3000;
    });

    ApplySpellFix({
        54997, // Cast Net (tooltip says 10s but sniffs say 6s)
        56524  // Acid Breath
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 6000;
    });

    ApplySpellFix({
        47911, // EMP
        48620, // Wing Buffet
        51752  // Stampy's Stompy-Stomp
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 10000;
    });

    ApplySpellFix({
        37727, // Touch of Darkness
        54996  // Ice Slick (tooltip says 20s but sniffs say 12s)
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 12000;
    });

    // Signal Helmet to Attack
    ApplySpellFix({ 51748 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 15000;
    });

    ApplySpellFix({
        51756, // Charge
        37919, //Arcano-dismantle
        37917  //Arcano-Cloak
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->RecoveryTime = 20000;
    });

    // Kaw the Mammoth Destroyer
    ApplySpellFix({ 46260 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // That's Abominable
    ApplySpellFix({ 59565 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 1721; // controlable guardian
    });

    // Investigate the Blue Recluse (1920)
    // Investigate the Alchemist Shop (1960)
    ApplySpellFix({ 9095 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_DUMMY;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // 10yd
    });

    // Dragonmaw Race: All parts
    ApplySpellFix({
        40890   // Oldie's Rotten Pumpkin
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 40905;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Trope's Slime Cannon
    ApplySpellFix({ 40909 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 40905;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Corlok's Skull Barrage
    ApplySpellFix({ 40894 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 40900;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Ichman's Blazing Fireball
    ApplySpellFix({ 40928 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 40929;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Mulverick's Great Balls of Lightning
    ApplySpellFix({ 40930 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 40931;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Sky Shatter
    ApplySpellFix({ 40945 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Targets |= TARGET_FLAG_DEST_LOCATION;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 41064;
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_TRIGGER_MISSILE;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    });

    // Gauging the Resonant Frequency (10594)
    ApplySpellFix({ 37390 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 181;
    });

    // Where in the World is Hemet Nesingwary? (12521)
    ApplySpellFix({ 50860 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 50860;
    });

    ApplySpellFix({ 50861 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 0;
    });

    // Riding Jokkum
    ApplySpellFix({ 56606 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 1;
    });

    // Blightbeasts be Damned! (12072)
    ApplySpellFix({ 47424 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags &= ~AURA_INTERRUPT_FLAG_NOT_ABOVEWATER;
    });

    // Dark Horizon (12664), Reunited (12663)
    ApplySpellFix({ 52190 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 52391 - 1;
    });

    // The Sum is Greater than the Parts (13043) - Chained Grip
    ApplySpellFix({ 60540 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValue = 300;
    });

    // Not a Bug (13342)
    ApplySpellFix({ 60531 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    });

    // Frankly,  It Makes No Sense... (10672)
    ApplySpellFix({ 37851 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Honor Challenge (12939)
    ApplySpellFix({ 21855 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Convocation at Zol'Heb (12730)
    ApplySpellFix({ 52956 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENTRY);
    });

    // Mangletooth
    ApplySpellFix({
        7764,   // Wisdom of Agamaggan
        10767,  // Rising Spirit
        16610,  // Razorhide
        16612,  // Agamaggan's Strength
        16618,  // Spirit of the Wind
        17013   // Agamaggan's Agility
        }, [](SpellInfo* spellInfo)

    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT;
    });

    //Crushing the Crown
    ApplySpellFix({ 71024 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DYNOBJ_NONE);
    });

    // Battle for the Undercity
    ApplySpellFix({
        59892   // Cyclone fall
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AREA_AURA_FRIEND;
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS); // 10yd
        spellInfo->AttributesEx &= ~SPELL_ATTR0_NO_AURA_CANCEL;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
    });

    // enchant Lightweave Embroidery
    ApplySpellFix({ 55637 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].MiscValue = 126;
    });

    ApplySpellFix({
        47977, // Magic Broom
        65917  // Magic Rooster
        }, [](SpellInfo* spellInfo)
    {
        // First two effects apply auras, which shouldn't be there
        // due to NO_TARGET applying aura on current caster (core bug)
        // Just wipe effect data, to mimic blizz-behavior
        spellInfo->Effects[EFFECT_0].Effect = 0;
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Titanium Seal of Dalaran, Toss your luck
    ApplySpellFix({ 60476 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Mind Amplification Dish, change charm aura
    ApplySpellFix({ 26740 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_MOD_CHARM;
    });

    // Persistent Shield
    ApplySpellFix({ 26467 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE;
        spellInfo->Effects[EFFECT_0].TriggerSpell = 26470;
    });

    // Deadly Swiftness
    ApplySpellFix({ 31255 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 22588;
    });

    // Black Magic enchant
    ApplySpellFix({ 59630 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
    });

    // Precious's Ribbon
    ApplySpellFix({ 72968 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    ApplySpellFix({
        71646,  // Item - Bauble of True Blood 10m
        71607,  // Item - Bauble of True Blood 25m
        71610,  // Item - Althor's Abacus trigger 10m
        71641   // Item - Althor's Abacus trigger 25m
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
        spellInfo->SpellLevel = 0;
    });

    ApplySpellFix({
        6789,  // Warlock - Death Coil (Rank 1)
        17925, // Warlock - Death Coil (Rank 2)
        17926, // Warlock - Death Coil (Rank 3)
        27223, // Warlock - Death Coil (Rank 4)
        47859, // Warlock - Death Coil (Rank 5)
        71838, // Drain Life - Bryntroll Normal
        71839  // Drain Life - Bryntroll Heroic
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    });

    // Alchemist's Stone
    ApplySpellFix({ 17619 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD;
    });

    // Stormchops
    ApplySpellFix({ 43730 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(1);
        spellInfo->Effects[EFFECT_1].TargetB = SpellImplicitTargetInfo();
    });

    // Savory Deviate Delight (transformations), allow to mount while transformed
    ApplySpellFix({ 8219, 8220, 8221, 8222 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes &= ~SPELL_ATTR0_NO_IMMUNITIES;
    });

    // Clamlette Magnifique
    ApplySpellFix({ 72623 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = spellInfo->Effects[EFFECT_1].BasePoints;
    });

    // Compact Harvest Reaper
    ApplySpellFix({ 4078 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(6); // 10 minutes
    });

    // Dragon Kite, Tuskarr Kite - Kite String
    ApplySpellFix({ 45192 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(6); // 100yd
    });

    // Frigid Frostling, Infrigidate
    ApplySpellFix({ 74960 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS); // 20yd
    });

    // Apple Trap
    ApplySpellFix({ 43450 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_DUMMY;
    });

    // Dark Iron Attack - spawn mole machine
    ApplySpellFix({ 43563 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].Effect = 0; // summon GO's manually
    });

    // Throw Mug visual
    ApplySpellFix({ 42300 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    // Dark Iron knockback Aura
    ApplySpellFix({ 42299 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_DUMMY;
        spellInfo->Effects[EFFECT_0].MiscValue = 100;
        spellInfo->Effects[EFFECT_0].BasePoints = 79;
    });

    // Chug and Chuck!
    ApplySpellFix({ 42436 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENTRY);
        spellInfo->MaxAffectedTargets = 0;
        spellInfo->ExcludeCasterAuraSpell = 42299;
    });

    // Brewfest quests
    ApplySpellFix({ 47134, 51798 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
    });

    // The Heart of The Storms (12998)
    ApplySpellFix({ 43528 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(18);
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(25);
    });

    // Water splash
    ApplySpellFix({ 42348 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = 0;
    });

    // Summon Lantersn
    ApplySpellFix({ 44255, 44231 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Throw Head Back
    ApplySpellFix({ 42401 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_NEARBY_ENTRY);
    });

    // Food
    ApplySpellFix({ 65418 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TriggerSpell = 65410;
    });

    ApplySpellFix({ 65422 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TriggerSpell = 65414;
    });

    ApplySpellFix({ 65419 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TriggerSpell = 65416;
    });

    ApplySpellFix({ 65420 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TriggerSpell = 65412;
    });

    ApplySpellFix({ 65421 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_2].TriggerSpell = 65415;
    });

    // Stamp Out Bonfire
    ApplySpellFix({ 45437 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_DUMMY;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_NEARBY_ENTRY);
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Light Bonfire (DND)
    ApplySpellFix({ 29831 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Infernal
    ApplySpellFix({ 33240 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    ApplySpellFix({
        47476,  // Deathknight - Strangulate
        15487,  // Priest - Silence
        5211,   // Druid - Bash  - R1
        6798,   // Druid - Bash  - R2
        8983    // Druid - Bash  - R3
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx7 |= SPELL_ATTR7_CAN_CAUSE_INTERRUPT;
    });

    // Ritual of Summoning
    ApplySpellFix({ 61994 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ManaCostPercentage = 0; // Clicking on Warlock Summoning portal should not require mana
    });

    // Shadowmeld
    ApplySpellFix({ 58984 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
    });

    // Flare activation speed
    ApplySpellFix({ 1543 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 0.0f;
    });

    // Light's Beacon
    ApplySpellFix({ 53651 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

    // Shadow Hunter Vosh'gajin - Hex
    ApplySpellFix({ 16097 }, [](SpellInfo* spellInfo)
    {
        spellInfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(16);
    });

    // Sacred Cleansing
    ApplySpellFix({ 53659 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(5); // 40yd
    });

    // Silithyst
    ApplySpellFix({ 29519 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ApplyAuraName = SPELL_AURA_MOD_DECREASE_SPEED;
        spellInfo->Effects[EFFECT_0].BasePoints = -25;
    });

    // Focused Eyebeam Summon Trigger
    ApplySpellFix({ 63342 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Luffa
    ApplySpellFix({ 23595 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 1; // Remove only 1 bleed effect
    });

    // Eye of Kilrogg Passive (DND)
    ApplySpellFix({ 2585 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_HITBYSPELL | AURA_INTERRUPT_FLAG_TAKE_DAMAGE;
    });

    // Nefarius Corruption
    ApplySpellFix({ 23642 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->Effects[EFFECT_0].TargetB = SpellImplicitTargetInfo();
    });

    // Conflagration, Horseman's Cleave
    ApplySpellFix({ 42380, 42587 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Serverside - Summon Arcane Disruptor
    ApplySpellFix({ 49591 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcChance = 101;
        spellInfo->Effects[EFFECT_1].Effect = 24;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(25);
        spellInfo->Effects[EFFECT_1].ItemType = 37888;
    });

    // Serverside - Create Rocket Pack
    ApplySpellFix({ 70055 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcChance = 101;
        spellInfo->Effects[EFFECT_1].Effect = 24;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(25);
        spellInfo->Effects[EFFECT_1].ItemType = 49278;
    });

    // Ashenvale Outrunner Sneak
    // Stealth
    ApplySpellFix({ 20540, 32199 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= (AURA_INTERRUPT_FLAG_MELEE_ATTACK | AURA_INTERRUPT_FLAG_CAST);
    });

     // Arcane Bolt
    ApplySpellFix({ 15979 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(3); // 20y
    });

    // Mortal Shots
    ApplySpellFix({ 19485, 19487, 19488, 19489, 19490 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] |= 0x00004000;
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Item - Death Knight T9 Melee 4P Bonus
    // Item - Hunter T9 2P Bonus
    // Item - Paladin T9 Retribution 2P Bonus (Righteous Vengeance)
    ApplySpellFix({ 67118, 67150, 67188 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Green Beam
    ApplySpellFix({31628, 31630, 31631}, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
        spellInfo->MaxAffectedTargets = 1;
    });

    ApplySpellFix({
        20271, 57774,  // Judgement of Light
        20425,         // Judgement of Command
        32220,         // Judgement of Blood
        53407,         // Judgement of Justice
        53408,         // Judgement of Wisdom
        53725          // Judgement of the Martyr
        }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 &= ~SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

     // Chaos Bolt Passive
    ApplySpellFix({ 58284 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_ABILITY_IGNORE_TARGET_RESIST;
        spellInfo->Effects[EFFECT_1].BasePoints = 100;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_1].MiscValue = 127;
        spellInfo->Effects[EFFECT_1].SpellClassMask[1] = 0x00020000;
    });

    // Nefarian: Shadowbolt, Shadow Command
    ApplySpellFix({ 22667, 22677 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(152); // 150 yards
    });

    // Manastorm
    ApplySpellFix({ 21097 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags &= ~SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // Arcane Vacuum
    ApplySpellFix({ 21147 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(4); // 30 yards
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ONLY_ON_PLAYER;
    });

    // Reflection
    ApplySpellFix({ 22067 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
    });

    // Focused Assault
    // Brutal Assault
    ApplySpellFix({ 46392, 46393 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });

    // Improved Blessing Protection (Nefarian Class Call)
    ApplySpellFix({ 23415 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_TARGET_ENEMY);
    });

    // Bestial Wrath
    ApplySpellFix({ 19574 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_AURA_EXPIRES_OFFLINE;
    });

    // Shadowflame
    ApplySpellFix({ 22539 }, [](SpellInfo* spellInfo)
    {
        spellInfo->InterruptFlags &= ~SPELL_INTERRUPT_FLAG_INTERRUPT;
    });

    // PX-238 Winter Wondervolt
    ApplySpellFix({ 26157, 26272, 26273, 26274 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Mechanic = 0;
    });

    // Calm Dragonkin
    ApplySpellFix({ 19872 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_EXCLUDE_CASTER;
    });

    // Cosmetic - Lightning Beam Channel
    ApplySpellFix({ 45537 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Burning Adrenaline
    ApplySpellFix({ 23478 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].BasePoints = 4374;
        spellInfo->Effects[EFFECT_0].DieSides = 1250;
    });

    // Explosion - Razorgore
    ApplySpellFix({ 20038 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_50000_YARDS);
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Brood Power : Bronze
    ApplySpellFix({ 22311 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Rapture
    ApplySpellFix({ 63652, 63653, 63654, 63655 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Everlasting Affliction
    ApplySpellFix({ 47422 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW;
    });

    // Flametongue Weapon (Passive) (Rank 6)
    ApplySpellFix({ 16312 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(21);
    });

    // Mana Tide Totem
    // Cleansing Totem Effect
    ApplySpellFix({ 39609, 52025 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(5); // 40yd
    });

    // Increased Totem Radius
    ApplySpellFix({ 21895 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[0].SpellClassMask = flag96(0x0603E000, 0x00200100);
    });

    // Jokkum Summon
    ApplySpellFix({ 56541 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 844;
    });

    // Hakkar Cause Insanity
    ApplySpellFix({ 24327 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Dispel = DISPEL_NONE;
    });

    // Summon Nightmare Illusions
    ApplySpellFix({ 24681, 24728, 24729 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 64;
    });

    // Blood Siphon
    ApplySpellFix({ 24322, 24323 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_MOD_STUN;
        spellInfo->Effects[EFFECT_2].Effect = 0;
        spellInfo->Attributes |= SPELL_ATTR0_NO_AURA_CANCEL;
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL;
        spellInfo->ChannelInterruptFlags &= ~AURA_INTERRUPT_FLAG_MOVE;
    });

    // Place Fake Fur
    ApplySpellFix({ 46085 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValue = 8;
    });

    // Smash Mammoth Trap
    ApplySpellFix({ 46201 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValue = 8;
    });

    // Elemental Mastery
    ApplySpellFix({ 16166 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask = flag96(0x00000003, 0x00001000);
    });

    // Elemental Vulnerability
    ApplySpellFix({ 28772 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Speed = 1;
    });

    // Find the Ancient Hero: Kill Credit
    ApplySpellFix({ 25729 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = TARGET_UNIT_SUMMONER;
    });

    // Artorius Demonic Doom
    ApplySpellFix({ 23298 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS;
        spellInfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS;
    });

    // Lash
    ApplySpellFix({ 25852 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // Explosion
    ApplySpellFix({ 5255 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Death's Respite
    ApplySpellFix({ 67731, 68305 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Wyvern Sting DoT
    ApplySpellFix({ 24131, 24134, 24135 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    });

     // Feed Pet
    ApplySpellFix({ 1539, 51284 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_ALLOW_WHILE_SITTING;
    });

    // Judgement (Paladin T2 8P Bonus)
    // Battlegear of Eternal Justice
    ApplySpellFix({ 23591, 26135 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcFlags = PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS;
    });

    // Gift of Arthas
    ApplySpellFix({ 11371 }, [](SpellInfo* spellInfo)
    {
        spellInfo->SpellFamilyName = SPELLFAMILY_POTION;
    });

    // Refocus (Renataki's charm of beasts)
    ApplySpellFix({ 24531 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    });

    // Collect Rookery Egg
    ApplySpellFix({ 15958 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = 0;
    });

    // WotLK Prologue Frozen Shade Visual, temp used to restore visual after Dispersion
    ApplySpellFix({ 53444 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(27);
    });

    // Rental Racing Ram
    ApplySpellFix({ 43883 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags &= ~AURA_INTERRUPT_FLAG_NOT_ABOVEWATER;
    });

    // Summon Worm
    ApplySpellFix({ 518, 25831, 25832 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].MiscValueB = 64;
    });

    // Uppercut
    ApplySpellFix({ 26007 }, [](SpellInfo* spellInfo)
    {
            spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_CASTER_PROCS;
    });

    // Digestive Acid (Temporary)
    ApplySpellFix({ 26476 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    });

    // Drums of War/Battle/Speed/Restoration
    ApplySpellFix({ 35475, 35476, 35477, 35478 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ExcludeTargetAuraSpell = 51120;
    });

    // Slap!
    ApplySpellFix({ 6754 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
        spellInfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    });

    // Summon Cauldron Stuff
    ApplySpellFix({ 36549 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(28); // 5 seconds
        spellInfo->Effects[EFFECT_0].TargetB = TARGET_DEST_CASTER;
    });

    // Hunter's Mark
    ApplySpellFix({ 31615 }, [](SpellInfo* spellInfo)
    {
        for (uint8 index = EFFECT_0; index <= EFFECT_1; ++index)
        {
            spellInfo->Effects[index].TargetA = TARGET_UNIT_TARGET_ENEMY;
            spellInfo->Effects[index].TargetB = 0;
        }
    });

    // Self Visual - Sleep Until Cancelled(DND)
    ApplySpellFix({ 6606, 14915, 16093 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags &= ~AURA_INTERRUPT_FLAG_NOT_SEATED;
    });

     // Cleansing Totem, Healing Stream Totem, Mana Tide Totem
    ApplySpellFix({ 8171,52025, 52041, 52042, 52046, 52047, 52048, 52049, 52050, 58759, 58760, 58761, 39610, 39609 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });
    // Game In Session
    ApplySpellFix({ 39331 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Attributes |= SPELL_ATTR0_NO_AURA_CANCEL;
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_CHANGE_MAP;
    });
    // Death Ray Warning Visual, Death Ray Damage Visual
    ApplySpellFix({ 63882, 63886 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_ACTION_DURING_CHANNEL;
    });

    // Buffeting Winds of Susurrus
    ApplySpellFix({ 32474 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(556); // 28 seconds
    });

    // Quest - Healing Salve
    ApplySpellFix({ 29314 }, [](SpellInfo* spellInfo)
    {
        spellInfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); // 0s
    });

    // Seed of Corruption
    ApplySpellFix({ 27285, 47833, 47834 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION;
    });

    // Turn the Tables
    ApplySpellFix({ 51627, 51628, 51629 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx3 |= SPELL_ATTR3_DOT_STACKING_RULE;
    });

     // Silence
    ApplySpellFix({ 18278 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx4 |= SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND;
    });

    // Absorb Life
    ApplySpellFix({ 34239 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].ValueMultiplier = 1;
    });

    // Summon a Warp Rift in Void Ridge
    ApplySpellFix({ 35036 }, [](SpellInfo* spellInfo)
    {
        spellInfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); // 0s
    });

    // Hit Rating (Dungeon T3 - 2P Bonus - Wastewalker, Doomplate)
    ApplySpellFix({ 37608, 37610 }, [](SpellInfo* spellInfo)
    {
        spellInfo->DurationEntry = sSpellDurationStore.LookupEntry(0);
        spellInfo->Effects[EFFECT_0].MiscValue = 224;
    });

    // Target Fissures
    ApplySpellFix({ 30745 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Acid Spit
    ApplySpellFix({ 34290 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Mulgore Hatchling (periodic)
    ApplySpellFix({ 62586 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TriggerSpell = 62585; // Mulgore Hatchling (fear)
    });

    // Poultryized!
    ApplySpellFix({ 30504 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= AURA_INTERRUPT_FLAG_TAKE_DAMAGE;
    });

    // Torment of the Worgen
    ApplySpellFix({ 30567 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcChance = 3;
    });

    // Summon Water Elementals
    ApplySpellFix({ 29962, 37051, 37052, 37053 }, [](SpellInfo* spellInfo)
    {
        spellInfo->RangeEntry = sSpellRangeStore.LookupEntry(13); // 50000yd
    });

    // Instill Lord Valthalak's Spirit DND
    ApplySpellFix({ 27360 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ChannelInterruptFlags |= AURA_INTERRUPT_FLAG_MOVE;
    });

    // Holiday - Midsummer, Ribbon Pole Periodic Visual
    ApplySpellFix({ 45406 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AuraInterruptFlags |= ( AURA_INTERRUPT_FLAG_MOUNT | AURA_INTERRUPT_FLAG_CAST );
    });

    // Improved Mind Flay and Smite
    ApplySpellFix({ 37571 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].SpellClassMask[0] = 8388736;
    });

    // Improved Corruption and Immolate (Updated)
    ApplySpellFix({ 61992 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_1].Effect = SPELL_EFFECT_APPLY_AURA;
        spellInfo->Effects[EFFECT_1].ApplyAuraName = SPELL_AURA_ADD_PCT_MODIFIER;
        spellInfo->Effects[EFFECT_1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
        spellInfo->Effects[EFFECT_1].BasePoints = 4;
        spellInfo->Effects[EFFECT_1].DieSides = 1;
        spellInfo->Effects[EFFECT_1].MiscValue = 22;
        spellInfo->Effects[EFFECT_1].SpellClassMask[0] = 6;
    });

    // 46747 Fling torch
    ApplySpellFix({ 46747 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_CASTER);
    });

    // Chains of Naberius
    ApplySpellFix({ 36146 }, [](SpellInfo* spellInfo)
    {
        spellInfo->MaxAffectedTargets = 1;
    });

    // Force of Neltharaku
    ApplySpellFix({ 38762 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Effects[EFFECT_0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    });

    // Spotlight
    ApplySpellFix({ 29683, 32214 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx5 |= SPELL_ATTR5_DO_NOT_DISPLAY_DURATION;
    });

    // Haunted
    ApplySpellFix({ 53768 }, [](SpellInfo* spellInfo)
    {
        spellInfo->Attributes |= SPELL_ATTR0_NO_AURA_CANCEL;
    });

    // Tidal Wave
    ApplySpellFix({ 37730 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Magic Disruption (KT dagger)
    ApplySpellFix({ 36478 }, [](SpellInfo* spellInfo)
    {
        spellInfo->ProcChance = 100;
    });

    // Commanding Shout
    ApplySpellFix({ 469, 47439, 47440 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Battle Shout
    ApplySpellFix({ 2048, 5242, 6192, 6673, 11549, 11550, 11551, 25289, 47436 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Plague Effect
    ApplySpellFix({ 19594, 26557 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Prayer of Fortitude
    ApplySpellFix({ 21562, 21564, 25392, 48162 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Gift of the Wild
    ApplySpellFix({ 21849, 21850, 26991, 48470, 69381 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Arcane Brilliance
    ApplySpellFix({ 23028, 27127, 43002 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Prayer of Spirit
    ApplySpellFix({ 27681, 32999, 48074 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Prayer of Shadow Protection
    ApplySpellFix({ 27683, 39374, 48170 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Nagrand Fort Buff Reward Raid
    ApplySpellFix({ 33006 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Demonic Pact
    ApplySpellFix({ 48090 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Ancestral Awakening
    ApplySpellFix({ 52759 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Turn the Tables
    ApplySpellFix({ 52910, 52914, 52915 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Judgements of the Wise
    ApplySpellFix({ 54180 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Replenishment
    ApplySpellFix({ 57669 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Dalaran Brilliance
    ApplySpellFix({ 61316 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // [DND] Dalaran Brilliance
    ApplySpellFix({ 61332 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Infinite Replenishment + Wisdom
    ApplySpellFix({ 61782 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Renewed Hope
    ApplySpellFix({ 63944 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Fortitude
    ApplySpellFix({ 69377 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Blessing of Forgotten Kings
    ApplySpellFix({ 69378 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Lucky Charm
    ApplySpellFix({ 69511 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Shiny Shard of the Scale Heal Targeter
    ApplySpellFix({ 69749 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Purified Shard of the Scale Heal Targeter
    ApplySpellFix({ 69754 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    // Brilliance
    ApplySpellFix({ 69994 }, [](SpellInfo* spellInfo)
    {
        spellInfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    });

    for (uint32 i = 0; i < GetSpellInfoStoreSize(); ++i)
    {
        SpellInfo* spellInfo = mSpellInfoMap[i];
        if (!spellInfo)
        {
            continue;
        }

        for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            switch (spellInfo->Effects[j].Effect)
            {
                case SPELL_EFFECT_CHARGE:
                case SPELL_EFFECT_CHARGE_DEST:
                case SPELL_EFFECT_JUMP:
                case SPELL_EFFECT_JUMP_DEST:
                case SPELL_EFFECT_LEAP_BACK:
                    if (!spellInfo->Speed && !spellInfo->SpellFamilyName)
                    {
                        spellInfo->Speed = SPEED_CHARGE;
                    }
                    break;
            }

            // Xinef: i hope this will fix the problem with not working resurrection
            if (spellInfo->Effects[j].Effect == SPELL_EFFECT_SELF_RESURRECT)
            {
                spellInfo->Effects[j].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
            }
        }

        // Fix range for trajectory triggered spell
        for (SpellEffectInfo const& spellEffectInfo : spellInfo->GetEffects())
        {
            if (spellEffectInfo.IsEffect() && (spellEffectInfo.TargetA.GetTarget() == TARGET_DEST_TRAJ || spellEffectInfo.TargetB.GetTarget() == TARGET_DEST_TRAJ))
            {
                // Get triggered spell if any
                if (SpellInfo* spellInfoTrigger = const_cast<SpellInfo*>(GetSpellInfo(spellEffectInfo.TriggerSpell)))
                {
                    float maxRangeMain = spellInfo->RangeEntry ? spellInfo->RangeEntry->RangeMax[0] : 0.0f;
                    float maxRangeTrigger = spellInfoTrigger->RangeEntry ? spellInfoTrigger->RangeEntry->RangeMax[0] : 0.0f;

                    // check if triggered spell has enough max range to cover trajectory
                    if (maxRangeTrigger < maxRangeMain)
                        spellInfoTrigger->RangeEntry = spellInfo->RangeEntry;
                }
            }
        }

        if (spellInfo->ActiveIconID == 2158)  // flight
        {
            spellInfo->Attributes |= SPELL_ATTR0_PASSIVE;
        }

        switch (spellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_PALADIN:
                // Seals of the Pure should affect Seal of Righteousness
                if (spellInfo->SpellIconID == 25 && (spellInfo->Attributes & SPELL_ATTR0_PASSIVE))
                    spellInfo->Effects[EFFECT_0].SpellClassMask[1] |= 0x20000000;
                break;
            case SPELLFAMILY_DEATHKNIGHT:
                // Icy Touch - extend FamilyFlags (unused value) for Sigil of the Frozen Conscience to use
                if (spellInfo->SpellIconID == 2721 && spellInfo->SpellFamilyFlags[0] & 0x2)
                    spellInfo->SpellFamilyFlags[0] |= 0x40;
                break;
            case SPELLFAMILY_HUNTER:
                // Aimed Shot not affected by category cooldown modifiers
                if (spellInfo->SpellFamilyFlags[0] & 0x00020000)
                {
                    spellInfo->AttributesEx6 |= SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS;
                    spellInfo->RecoveryTime = 10 * IN_MILLISECONDS;
                }
                break;
        }

        // Recklessness/Shield Wall/Retaliation
        if (spellInfo->CategoryEntry == sSpellCategoryStore.LookupEntry(132) && spellInfo->SpellFamilyName == SPELLFAMILY_WARRIOR)
        {
            spellInfo->AttributesEx6 |= SPELL_ATTR6_NO_CATEGORY_COOLDOWN_MODS;
        }
    }

    // Xinef: The Veiled Sea area in outlands (Draenei zone), client blocks casting flying mounts
    for (uint32 i = 0; i < sAreaTableStore.GetNumRows(); ++i)
        if (AreaTableEntry* areaEntry = const_cast<AreaTableEntry*>(sAreaTableStore.LookupEntry(i)))
        {
            if (areaEntry->ID == 3479)
                areaEntry->flags |= AREA_FLAG_NO_FLY_ZONE;
            // Xinef: Dun Morogh, Kharanos tavern, missing resting flag
            else if (areaEntry->ID == 2102)
                areaEntry->flags |= AREA_FLAG_REST_ZONE_ALLIANCE;
        }

    // Xinef: fix for something?
    SummonPropertiesEntry* properties = const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(121));
    properties->Type = SUMMON_TYPE_TOTEM;
    properties = const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(647)); // 52893
    properties->Type = SUMMON_TYPE_TOTEM;
    if ((properties = const_cast<SummonPropertiesEntry*>(sSummonPropertiesStore.LookupEntry(628)))) // Hungry Plaguehound
    {
        properties->Category = SUMMON_CATEGORY_PET;
        properties->Type = SUMMON_TYPE_PET;
    }

    // Correct Pet Size
    CreatureDisplayInfoEntry* displayEntry = const_cast<CreatureDisplayInfoEntry*>(sCreatureDisplayInfoStore.LookupEntry(17028)); // Kurken
    displayEntry->scale = 2.5f;

    // Oracles and Frenzyheart faction
    FactionEntry* factionEntry = const_cast<FactionEntry*>(sFactionStore.LookupEntry(1104));
    factionEntry->ReputationFlags[0] = 0;
    factionEntry = const_cast<FactionEntry*>(sFactionStore.LookupEntry(1105));
    factionEntry->ReputationFlags[0] = 0;

    // Various factions, added 14, 16 to hostile mask
    FactionTemplateEntry* factionTemplateEntry = const_cast<FactionTemplateEntry*>(sFactionTemplateStore.LookupEntry(1978)); // Warsong Offensive
    factionTemplateEntry->hostileMask |= 8;
    factionTemplateEntry = const_cast<FactionTemplateEntry*>(sFactionTemplateStore.LookupEntry(1921)); // The Taunka
    factionTemplateEntry->hostileMask |= 8;

    // Remove vehicles attr, making accessories selectable
    VehicleSeatEntry* vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(4689)); // Siege Engine, Accessory
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(4692)); // Siege Engine, Accessory
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(4693)); // Siege Engine, Accessory
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_PASSENGER_NOT_SELECTABLE;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3011)); // Salvaged Demolisher, Ulduar - not allow to change seats
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_CAN_SWITCH;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3077)); // Salvaged Demolisher Seat, Ulduar - not allow to change seats
    vse->m_flags &= ~VEHICLE_SEAT_FLAG_CAN_SWITCH;

    // pussywizard: fix z offset for some vehicles:
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(6206)); // Marrowgar - Bone Spike
    vse->m_attachmentOffsetZ = 4.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3806)); // Mimiron - seat on VX-001 for ACU during last phase
    vse->m_attachmentOffsetZ = 15.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3566)); // Mimiron - Working seat
    vse->m_attachmentOffsetX = -3.5f;
    vse->m_attachmentOffsetY = 0.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(3567)); // Mimiron - Working seat
    vse->m_attachmentOffsetX = 2.3f;
    vse->m_attachmentOffsetY = -2.3f;

    // Pilgrim's Bounty offsets
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2841));
    vse->m_attachmentOffsetX += 1.65f;
    vse->m_attachmentOffsetY += 0.75f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2842));
    vse->m_attachmentOffsetX += 1.6f;
    vse->m_attachmentOffsetY += -1.0f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2843));
    vse->m_attachmentOffsetX += -1.2f;
    vse->m_attachmentOffsetY += 0.2f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2844));
    vse->m_attachmentOffsetX += -0.1f;
    vse->m_attachmentOffsetY += -1.6f;
    vse = const_cast<VehicleSeatEntry*>(sVehicleSeatStore.LookupEntry(2845));
    vse->m_attachmentOffsetX += 0.0f;
    vse->m_attachmentOffsetY += 1.6f;

    // Once Bitten, Twice Shy (10 player) - Icecrown Citadel
    AchievementEntry* achievement = const_cast<AchievementEntry*>(sAchievementStore.LookupEntry(4539));
    achievement->mapID = 631;    // Correct map requirement (currently has Ulduar)

    // Ring of Valor starting Locations
    GraveyardStruct const* entry = sGraveyard->GetGraveyard(1364);
    const_cast<GraveyardStruct*>(entry)->z += 6.0f;
    entry = sGraveyard->GetGraveyard(1365);
    const_cast<GraveyardStruct*>(entry)->z += 6.0f;

    LockEntry* key = const_cast<LockEntry*>(sLockStore.LookupEntry(36)); // 3366 Opening, allows to open without proper key
    key->Type[2] = LOCK_KEY_NONE;

    LOG_INFO("server.loading", ">> Loading spell dbc data corrections  in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}
