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
 * @file SpellProcDisableEffectsTest.cpp
 * @brief Unit tests for DisableEffectsMask filtering in proc system
 *
 * Tests the logic from SpellAuras.cpp:2244-2258:
 * - Bitmask filtering for effect indices 0, 1, 2
 * - Combined filtering with multiple disabled effects
 * - Proc blocking when all effects are disabled
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcDisableEffectsTest : public ::testing::Test
{
protected:
    void SetUp() override {}

    // Default initial mask with all 3 effects enabled
    static constexpr uint8 ALL_EFFECTS_MASK = 0x07;  // 0b111
};

// =============================================================================
// Single Effect Disable Tests
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, DisableEffect0_BlocksOnlyEffect0)
{
    uint32 disableMask = 0x01;  // Disable effect 0

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x06)  // 0b110 - effects 1 and 2 remain
        << "DisableEffectsMask=0x01 should only disable effect 0";
}

TEST_F(SpellProcDisableEffectsTest, DisableEffect1_BlocksOnlyEffect1)
{
    uint32 disableMask = 0x02;  // Disable effect 1

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x05)  // 0b101 - effects 0 and 2 remain
        << "DisableEffectsMask=0x02 should only disable effect 1";
}

TEST_F(SpellProcDisableEffectsTest, DisableEffect2_BlocksOnlyEffect2)
{
    uint32 disableMask = 0x04;  // Disable effect 2

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x03)  // 0b011 - effects 0 and 1 remain
        << "DisableEffectsMask=0x04 should only disable effect 2";
}

// =============================================================================
// Multiple Effects Disable Tests
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, DisableEffects0And1_LeavesEffect2)
{
    uint32 disableMask = 0x03;  // Disable effects 0 and 1

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x04)  // 0b100 - only effect 2 remains
        << "DisableEffectsMask=0x03 should leave only effect 2";
}

TEST_F(SpellProcDisableEffectsTest, DisableEffects0And2_LeavesEffect1)
{
    uint32 disableMask = 0x05;  // Disable effects 0 and 2

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x02)  // 0b010 - only effect 1 remains
        << "DisableEffectsMask=0x05 should leave only effect 1";
}

TEST_F(SpellProcDisableEffectsTest, DisableEffects1And2_LeavesEffect0)
{
    uint32 disableMask = 0x06;  // Disable effects 1 and 2

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x01)  // 0b001 - only effect 0 remains
        << "DisableEffectsMask=0x06 should leave only effect 0";
}

// =============================================================================
// All Effects Disabled - Proc Blocked
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, DisableAllEffects_BlocksProc)
{
    uint32 disableMask = 0x07;  // Disable all 3 effects

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x00)
        << "DisableEffectsMask=0x07 should disable all effects";

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(ALL_EFFECTS_MASK, disableMask))
        << "Proc should be blocked when all effects are disabled";
}

TEST_F(SpellProcDisableEffectsTest, NotAllDisabled_ProcAllowed)
{
    // Only effect 0 disabled
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(ALL_EFFECTS_MASK, 0x01))
        << "Proc should be allowed when some effects remain";

    // Only effects 0 and 1 disabled
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(ALL_EFFECTS_MASK, 0x03))
        << "Proc should be allowed when effect 2 remains";

    // No effects disabled
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(ALL_EFFECTS_MASK, 0x00))
        << "Proc should be allowed when no effects are disabled";
}

// =============================================================================
// Partial Initial Mask Tests
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, PartialInitialMask_Effect0Only)
{
    uint8 initialMask = 0x01;  // Only effect 0 enabled

    // Disabling effect 0 should result in 0
    EXPECT_EQ(ProcChanceTestHelper::ApplyDisableEffectsMask(initialMask, 0x01), 0x00);
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(initialMask, 0x01));

    // Disabling effect 1 should have no impact
    EXPECT_EQ(ProcChanceTestHelper::ApplyDisableEffectsMask(initialMask, 0x02), 0x01);
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(initialMask, 0x02));
}

TEST_F(SpellProcDisableEffectsTest, PartialInitialMask_Effects0And1)
{
    uint8 initialMask = 0x03;  // Effects 0 and 1 enabled

    // Disabling both should result in 0
    EXPECT_EQ(ProcChanceTestHelper::ApplyDisableEffectsMask(initialMask, 0x03), 0x00);
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(initialMask, 0x03));

    // Disabling only effect 0 should leave effect 1
    EXPECT_EQ(ProcChanceTestHelper::ApplyDisableEffectsMask(initialMask, 0x01), 0x02);
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(initialMask, 0x01));
}

// =============================================================================
// Zero Disable Mask Tests
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, ZeroDisableMask_NoEffectDisabled)
{
    uint32 disableMask = 0x00;  // Nothing disabled

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, ALL_EFFECTS_MASK)
        << "Zero DisableEffectsMask should leave all effects enabled";

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(ALL_EFFECTS_MASK, disableMask))
        << "Proc should be allowed when nothing is disabled";
}

// =============================================================================
// Higher Bits Ignored Tests
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, HigherBits_IgnoredForEffects)
{
    // Bits beyond 0x07 should be ignored (only 3 effects exist)
    uint32 disableMask = 0xFF;  // All bits set

    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, disableMask);

    EXPECT_EQ(result, 0x00)
        << "Only lower 3 bits should affect the result";

    // Only lower bits matter
    uint32 highBitsOnly = 0xF8;  // High bits only
    result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, highBitsOnly);

    EXPECT_EQ(result, ALL_EFFECTS_MASK)
        << "High bits (0xF8) should not affect lower 3 effects";
}

// =============================================================================
// Integration with SpellProcEntry Tests
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, SpellProcEntry_WithDisableEffectsMask)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithDisableEffectsMask(0x05)  // Disable effects 0 and 2
        .WithChance(100.0f)
        .Build();

    // Verify the mask was set correctly
    EXPECT_EQ(procEntry.DisableEffectsMask, 0x05u);

    // Apply to initial mask
    uint8 result = ProcChanceTestHelper::ApplyDisableEffectsMask(ALL_EFFECTS_MASK, procEntry.DisableEffectsMask);

    EXPECT_EQ(result, 0x02)  // Only effect 1 remains
        << "SpellProcEntry DisableEffectsMask should filter correctly";
}

TEST_F(SpellProcDisableEffectsTest, SpellProcEntry_AllDisabled)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithDisableEffectsMask(0x07)  // Disable all effects
        .WithChance(100.0f)
        .Build();

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(ALL_EFFECTS_MASK, procEntry.DisableEffectsMask))
        << "Proc should be blocked when all effects disabled in SpellProcEntry";
}

// =============================================================================
// Real Spell Scenarios
// =============================================================================

TEST_F(SpellProcDisableEffectsTest, Scenario_SingleEffectAura)
{
    // Many procs only have a single effect that matters
    uint8 singleEffectMask = 0x01;  // Only effect 0

    // Disabling effect 0 blocks the proc
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(singleEffectMask, 0x01));

    // Disabling other effects has no impact
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(singleEffectMask, 0x02));
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(singleEffectMask, 0x04));
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(singleEffectMask, 0x06));
}

TEST_F(SpellProcDisableEffectsTest, Scenario_DualEffectAura)
{
    // Aura with effects 0 and 1 (healing + damage proc for example)
    uint8 dualEffectMask = 0x03;

    // Disabling one effect leaves the other
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(dualEffectMask, 0x01));
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(dualEffectMask, 0x02));

    // Disabling both blocks the proc
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToDisabledEffects(dualEffectMask, 0x03));
}
