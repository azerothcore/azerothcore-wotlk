/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AuraScriptTestFramework.h"
#include "SpellMgr.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace testing;

/**
 * @brief Integration tests for the proc system
 *
 * These tests verify that the proc system correctly integrates:
 * - SpellProcEntry configuration
 * - CanSpellTriggerProcOnEvent logic
 * - Proc flag combinations
 * - Spell family matching
 * - Hit mask filtering
 */
class SpellProcIntegrationTest : public AuraScriptProcTestFixture
{
protected:
    void SetUp() override
    {
        AuraScriptProcTestFixture::SetUp();
    }
};

// =============================================================================
// Melee Attack Proc Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, MeleeAutoAttackProc_NormalHit)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL | PROC_HIT_CRITICAL)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithNormalHit();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, MeleeAutoAttackProc_CritOnly)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    // Normal hit should NOT trigger crit-only proc
    auto normalScenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithNormalHit();
    EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, normalScenario);

    // Critical hit should trigger
    auto critScenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithCrit();
    EXPECT_PROC_TRIGGERS(procEntry, critScenario);
}

TEST_F(SpellProcIntegrationTest, MeleeAutoAttackProc_Miss)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_MISS)
        .Build();

    auto missScenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithMiss();

    EXPECT_PROC_TRIGGERS(procEntry, missScenario);
}

// =============================================================================
// Spell Damage Proc Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, SpellDamageProc_OnHit)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnSpellDamage()
        .OnHit()
        .WithNormalHit();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, SpellDamageProc_OnCast)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    // Should trigger on cast phase
    auto castScenario = ProcScenarioBuilder()
        .OnSpellDamage()
        .OnCast();
    EXPECT_PROC_TRIGGERS(procEntry, castScenario);

    // Should NOT trigger on hit phase when configured for cast only
    auto hitScenario = ProcScenarioBuilder()
        .OnSpellDamage()
        .OnHit();
    EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, hitScenario);
}

// =============================================================================
// Heal Proc Tests
// =============================================================================

// Heal proc tests - require SpellPhaseMask to be set
TEST_F(SpellProcIntegrationTest, HealProc_OnHeal)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnHeal()
        .OnHit();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, HealProc_CritHeal)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithHitMask(PROC_HIT_CRITICAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    // Normal heal should NOT trigger crit-only proc
    auto normalScenario = ProcScenarioBuilder()
        .OnHeal()
        .WithNormalHit();
    EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, normalScenario);

    // Crit heal should trigger
    auto critScenario = ProcScenarioBuilder()
        .OnHeal()
        .WithCrit();
    EXPECT_PROC_TRIGGERS(procEntry, critScenario);
}

// =============================================================================
// Periodic Effect Proc Tests
// =============================================================================

// Periodic proc tests - spell procs that require SpellPhaseMask to be set
TEST_F(SpellProcIntegrationTest, PeriodicDamageProc)
{
    // Note: PROC_FLAG_DONE_PERIODIC is in REQ_SPELL_PHASE_PROC_FLAG_MASK,
    // so SpellPhaseMask must be set (can't be 0)
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnPeriodicDamage()
        .WithNormalHit();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, PeriodicHealProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnPeriodicHeal()
        .WithNormalHit();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

// =============================================================================
// Kill/Death Proc Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, KillProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_KILL)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnKill();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, DeathProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DEATH)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnDeath();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

// =============================================================================
// Defensive Proc Tests (Dodge/Parry/Block)
// =============================================================================

TEST_F(SpellProcIntegrationTest, DodgeProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_DODGE)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnTakenMeleeAutoAttack()
        .WithDodge();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, ParryProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_PARRY)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnTakenMeleeAutoAttack()
        .WithParry();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, BlockProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_BLOCK)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnTakenMeleeAutoAttack()
        .WithBlock();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(SpellProcIntegrationTest, FullBlockProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_FULL_BLOCK)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnTakenMeleeAutoAttack()
        .WithFullBlock();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

// =============================================================================
// Absorb Proc Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, AbsorbProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithHitMask(PROC_HIT_ABSORB)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnTakenSpellDamage()
        .WithAbsorb();

    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

// Note: PROC_HIT_ABSORB covers both partial and full absorb
// There is no separate PROC_HIT_FULL_ABSORB flag in AzerothCore

// =============================================================================
// Spell Family Filtering Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, SpellFamilyMatch_SameFamily)
{
    // Create a Mage spell (family 3)
    auto* triggerSpell = CreateSpellInfo(133, 3, 0x00000001); // Fireball

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellFamilyName(3) // SPELLFAMILY_MAGE
        .WithSpellFamilyMask(flag96(0x00000001, 0, 0))
        .Build();

    // Test family match logic
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, triggerSpell));
}

TEST_F(SpellProcIntegrationTest, SpellFamilyMatch_DifferentFamily)
{
    // Create a Warrior spell (family 4)
    auto* triggerSpell = CreateSpellInfo(6343, 4, 0x00000001); // Thunder Clap

    auto procEntry = SpellProcEntryBuilder()
        .WithSpellFamilyName(3) // SPELLFAMILY_MAGE - should NOT match
        .WithSpellFamilyMask(flag96(0x00000001, 0, 0))
        .Build();

    EXPECT_FALSE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, triggerSpell));
}

TEST_F(SpellProcIntegrationTest, SpellFamilyMatch_NoFamilyFilter)
{
    // Create any spell
    auto* triggerSpell = CreateSpellInfo(133, 3, 0x00000001);

    // Proc with no family filter should match any spell
    auto procEntry = SpellProcEntryBuilder()
        .WithSpellFamilyName(0) // No family filter
        .Build();

    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, triggerSpell));
}

TEST_F(SpellProcIntegrationTest, SpellFamilyMatch_FlagMismatch)
{
    // Create a Mage spell with specific flags
    auto* triggerSpell = CreateSpellInfo(133, 3, 0x00000001); // Fireball flag

    auto procEntry = SpellProcEntryBuilder()
        .WithSpellFamilyName(3) // SPELLFAMILY_MAGE
        .WithSpellFamilyMask(flag96(0x00000002, 0, 0)) // Different flag
        .Build();

    EXPECT_FALSE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, triggerSpell));
}

// =============================================================================
// Combined Flag Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, MultipleProcFlags_MeleeOrSpell)
{
    // Proc on melee OR spell damage
    // Note: Spell procs require SpellPhaseMask to be set, otherwise the check
    // (eventInfo.SpellPhaseMask & procEntry.SpellPhaseMask) fails when procEntry = 0
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    // Melee test
    auto meleeEventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, meleeEventInfo));

    // Spell test - needs matching SpellPhaseMask AND SpellInfo
    auto* spellInfo = CreateSpellInfo(100);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);
    auto spellEventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithDamageInfo(&damageInfo)
        .Build();
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, spellEventInfo));
}

TEST_F(SpellProcIntegrationTest, MultipleHitMasks_CritOrNormal)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL | PROC_HIT_CRITICAL)
        .Build();

    auto normalScenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithNormalHit();
    EXPECT_PROC_TRIGGERS(procEntry, normalScenario);

    auto critScenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithCrit();
    EXPECT_PROC_TRIGGERS(procEntry, critScenario);

    auto missScenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithMiss();
    EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, missScenario);
}

// =============================================================================
// School Mask Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, SchoolMaskFilter_FireOnly_FireDamage)
{
    // Proc entry requires fire school damage
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FIRE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    // Create fire spell and fire damage info
    auto* fireSpell = CreateSpellInfo(133, 3, 0); // Fireball
    DamageInfo fireDamageInfo(nullptr, nullptr, 100, fireSpell, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithDamageInfo(&fireDamageInfo)
        .Build();

    // Fire damage should trigger fire-only proc
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcIntegrationTest, SchoolMaskFilter_FireOnly_FrostDamage)
{
    // Proc entry requires fire school damage
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FIRE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    // Create frost spell and frost damage info
    auto* frostSpell = CreateSpellInfo(116, 3, 0); // Frostbolt
    DamageInfo frostDamageInfo(nullptr, nullptr, 100, frostSpell, SPELL_SCHOOL_MASK_FROST, SPELL_DIRECT_DAMAGE);

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithDamageInfo(&frostDamageInfo)
        .Build();

    // Frost damage should NOT trigger fire-only proc
    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcIntegrationTest, SchoolMaskFilter_NoSchoolMask_AnySchoolTriggers)
{
    // Proc entry with no school mask filter (accepts all schools)
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSchoolMask(0) // No filter
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    // Test with shadow damage
    auto* shadowSpell = CreateSpellInfo(686, 5, 0); // Shadow Bolt
    DamageInfo shadowDamageInfo(nullptr, nullptr, 100, shadowSpell, SPELL_SCHOOL_MASK_SHADOW, SPELL_DIRECT_DAMAGE);

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithDamageInfo(&shadowDamageInfo)
        .Build();

    // Any school should trigger when no school mask filter is set
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// Edge Case Tests
// =============================================================================

TEST_F(SpellProcIntegrationTest, EmptyProcFlags_NeverTriggers)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_NONE) // No flags set
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnMeleeAutoAttack()
        .WithNormalHit();

    // Without PROC_FLAG_NONE special handling, this might still match
    // The actual behavior depends on implementation
    auto eventInfo = scenario.Build();

    // Event has flags but proc entry has none - should not trigger
    if (procEntry.ProcFlags == 0 && scenario.GetTypeMask() != 0)
    {
        EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
    }
}

TEST_F(SpellProcIntegrationTest, AllHitMasks_TriggersOnAny)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_MASK_ALL)
        .Build();

    // Should trigger on any hit type
    std::vector<uint32_t> hitTypes = {
        PROC_HIT_NORMAL, PROC_HIT_CRITICAL, PROC_HIT_MISS,
        PROC_HIT_DODGE, PROC_HIT_PARRY, PROC_HIT_BLOCK
    };

    for (uint32_t hitType : hitTypes)
    {
        auto eventInfo = ProcEventInfoBuilder()
            .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
            .WithHitMask(hitType)
            .Build();

        EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo))
            << "Failed for hit type: " << hitType;
    }
}
