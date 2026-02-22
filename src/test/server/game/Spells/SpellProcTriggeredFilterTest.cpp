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

/**
 * @file SpellProcTriggeredFilterTest.cpp
 * @brief Unit tests for triggered spell filtering in proc system
 *
 * Tests the logic from SpellAuras.cpp:2191-2209:
 * - Self-loop prevention (spell triggered by same aura)
 * - Triggered spell blocking (default behavior)
 * - SPELL_ATTR3_CAN_PROC_FROM_PROCS exception
 * - PROC_ATTR_TRIGGERED_CAN_PROC exception
 * - SPELL_ATTR3_NOT_A_PROC exception
 * - AUTO_ATTACK_PROC_FLAG_MASK exception
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcTriggeredFilterTest : public ::testing::Test
{
protected:
    void SetUp() override {}

    // Helper to create default proc entry
    SpellProcEntry CreateBasicProcEntry()
    {
        return SpellProcEntryBuilder()
            .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
            .WithChance(100.0f)
            .Build();
    }
};

// =============================================================================
// Self-Loop Prevention Tests - SpellAuras.cpp:2191-2192
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, SelfLoop_BlocksWhenTriggeredBySameAura)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.triggeredByAuraSpellId = 12345;  // Same as proc aura
    config.procAuraSpellId = 12345;

    auto procEntry = CreateBasicProcEntry();

    // Self-loop should be blocked
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Self-loop should block proc";
}

TEST_F(SpellProcTriggeredFilterTest, SelfLoop_AllowsWhenTriggeredByDifferentAura)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.triggeredByAuraSpellId = 12345;  // Different from proc aura
    config.procAuraSpellId = 67890;
    config.auraHasCanProcFromProcs = true;  // Allow triggered spells

    auto procEntry = CreateBasicProcEntry();

    // Different aura should be allowed
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Different aura trigger should allow proc";
}

TEST_F(SpellProcTriggeredFilterTest, SelfLoop_AllowsWhenNotTriggered)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = false;  // Not a triggered spell
    config.triggeredByAuraSpellId = 0;
    config.procAuraSpellId = 12345;

    auto procEntry = CreateBasicProcEntry();

    // Non-triggered spell should be allowed
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Non-triggered spell should allow proc";
}

// =============================================================================
// Triggered Spell Blocking - Default Behavior
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, TriggeredSpell_BlockedByDefault)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    // No TRIGGERED_CAN_PROC attribute
    auto procEntry = CreateBasicProcEntry();

    // Should be blocked - no exceptions apply
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Triggered spell should be blocked by default";
}

TEST_F(SpellProcTriggeredFilterTest, NonTriggeredSpell_AllowedByDefault)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = false;  // Not triggered
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    auto procEntry = CreateBasicProcEntry();

    // Should be allowed
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Non-triggered spell should be allowed";
}

// =============================================================================
// SPELL_ATTR3_CAN_PROC_FROM_PROCS Exception
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, CanProcFromProcs_AllowsTriggeredSpells)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = true;  // Exception: aura has SPELL_ATTR3_CAN_PROC_FROM_PROCS
    config.spellHasNotAProc = false;

    auto procEntry = CreateBasicProcEntry();

    // Should be allowed due to aura attribute
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "SPELL_ATTR3_CAN_PROC_FROM_PROCS should allow triggered spells";
}

// =============================================================================
// PROC_ATTR_TRIGGERED_CAN_PROC Exception
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, TriggeredCanProcAttribute_AllowsTriggeredSpells)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    // Set TRIGGERED_CAN_PROC attribute
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)
        .WithChance(100.0f)
        .Build();

    // Should be allowed due to proc entry attribute
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "PROC_ATTR_TRIGGERED_CAN_PROC should allow triggered spells";
}

// =============================================================================
// SPELL_ATTR3_NOT_A_PROC Exception
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, NotAProc_AllowsTriggeredSpell)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = true;  // Exception: spell has SPELL_ATTR3_NOT_A_PROC

    auto procEntry = CreateBasicProcEntry();

    // Should be allowed due to spell attribute
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "SPELL_ATTR3_NOT_A_PROC should allow triggered spell";
}

// =============================================================================
// AUTO_ATTACK_PROC_FLAG_MASK Exception
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, AutoAttackMelee_AllowsTriggeredSpells)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    auto procEntry = CreateBasicProcEntry();

    // Event mask includes auto-attack - exception applies
    uint32 autoAttackEvent = PROC_FLAG_DONE_MELEE_AUTO_ATTACK;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, autoAttackEvent))
        << "AUTO_ATTACK_PROC_FLAG_MASK (melee) should allow triggered spells";
}

TEST_F(SpellProcTriggeredFilterTest, AutoAttackRanged_AllowsTriggeredSpells)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    auto procEntry = CreateBasicProcEntry();

    // Hunter auto-shot or wand (ranged auto-attack)
    uint32 rangedAutoEvent = PROC_FLAG_DONE_RANGED_AUTO_ATTACK;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, rangedAutoEvent))
        << "AUTO_ATTACK_PROC_FLAG_MASK (ranged) should allow triggered spells";
}

TEST_F(SpellProcTriggeredFilterTest, TakenAutoAttack_AllowsTriggeredSpells)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    auto procEntry = CreateBasicProcEntry();

    // Taken melee auto-attack
    uint32 takenMeleeEvent = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, takenMeleeEvent))
        << "TAKEN_MELEE_AUTO_ATTACK should allow triggered spells";
}

// =============================================================================
// Combined Scenarios
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, Combined_SelfLoopTakesPrecedence)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.triggeredByAuraSpellId = 12345;
    config.procAuraSpellId = 12345;  // Self-loop
    config.auraHasCanProcFromProcs = true;  // Would normally allow

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)
        .WithChance(100.0f)
        .Build();

    // Self-loop should still block even with exceptions
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Self-loop should block even when TRIGGERED_CAN_PROC is set";
}

TEST_F(SpellProcTriggeredFilterTest, Combined_MultipleExceptions)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = true;  // Exception 1
    config.spellHasNotAProc = true;         // Exception 2

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)  // Exception 3
        .WithChance(100.0f)
        .Build();

    // Should be allowed (multiple exceptions all pass)
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Multiple exceptions should still allow proc";
}

// =============================================================================
// Real Spell Scenarios
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, Scenario_HotStreak_TriggeredPyroblast)
{
    // Hot Streak (48108) allows triggered Pyroblast to not proc it again
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;                 // Pyroblast was triggered by Hot Streak
    config.triggeredByAuraSpellId = 48108;     // Hot Streak
    config.procAuraSpellId = 48108;            // Hot Streak is checking if it should proc

    auto procEntry = CreateBasicProcEntry();

    // Self-loop: Hot Streak can't proc from spell it triggered
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Hot Streak triggered Pyroblast should not proc Hot Streak";
}

TEST_F(SpellProcTriggeredFilterTest, Scenario_SwordSpec_ChainProcs)
{
    // Sword Specialization with TRIGGERED_CAN_PROC
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.triggeredByAuraSpellId = 12345;  // Some other proc
    config.procAuraSpellId = 16459;         // Sword Specialization

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)
        .WithChance(5.0f)
        .Build();

    // TRIGGERED_CAN_PROC allows chain procs (but not self-loops)
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_MELEE_AUTO_ATTACK))
        << "Sword Spec with TRIGGERED_CAN_PROC should allow chain procs";
}

TEST_F(SpellProcTriggeredFilterTest, Scenario_WindfuryWeapon_AutoAttack)
{
    // Windfury Weapon procs from auto-attacks, which are allowed for triggered spells
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;  // Windfury extra attacks are triggered
    config.auraHasCanProcFromProcs = false;

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithProcsPerMinute(2.0f)
        .Build();

    // Auto-attack exception allows triggered Windfury attacks
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_MELEE_AUTO_ATTACK))
        << "Windfury triggered attacks should be allowed (auto-attack exception)";
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(SpellProcTriggeredFilterTest, EdgeCase_ZeroEventMask)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;

    auto procEntry = CreateBasicProcEntry();

    // Zero event mask means no auto-attack exception
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, 0))
        << "Zero event mask should not grant auto-attack exception";
}

TEST_F(SpellProcTriggeredFilterTest, EdgeCase_AllExceptionsDisabled)
{
    ProcChanceTestHelper::TriggeredSpellConfig config;
    config.isTriggered = true;
    config.auraHasCanProcFromProcs = false;
    config.spellHasNotAProc = false;

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithAttributesMask(0)  // No TRIGGERED_CAN_PROC
        .WithChance(100.0f)
        .Build();

    // No exceptions - should block
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        config, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "No exceptions should block triggered spell";
}
