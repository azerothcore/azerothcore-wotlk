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
 * @file SpellProcChanceTest.cpp
 * @brief Unit tests for proc chance calculations
 *
 * Tests CalcProcChance() behavior including:
 * - Base chance from SpellProcEntry
 * - PPM override when DamageInfo is present
 * - Chance modifiers (SPELLMOD_CHANCE_OF_SUCCESS)
 * - Level 60+ reduction (PROC_ATTR_REDUCE_PROC_60)
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

// =============================================================================
// Base Chance Tests
// =============================================================================

class SpellProcChanceTest : public ::testing::Test
{
protected:
    void SetUp() override {}
};

TEST_F(SpellProcChanceTest, BaseChance_UsedWhenNoPPM)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(25.0f)
        .WithProcsPerMinute(0.0f)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(procEntry);
    EXPECT_NEAR(result, 25.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, BaseChance_100Percent)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(procEntry);
    EXPECT_NEAR(result, 100.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, BaseChance_Zero)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(0.0f)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(procEntry);
    EXPECT_NEAR(result, 0.0f, 0.01f);
}

// =============================================================================
// PPM Override Tests
// =============================================================================

TEST_F(SpellProcChanceTest, PPM_OverridesBaseChance_WithDamageInfo)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(50.0f)  // This should be ignored
        .WithProcsPerMinute(6.0f)
        .Build();

    // With DamageInfo, PPM takes precedence
    // 2500ms * 6 PPM / 600 = 25%
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 0.0f, 0.0f, true);
    EXPECT_NEAR(result, 25.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, PPM_NotApplied_WithoutDamageOrHealInfo)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(50.0f)
        .WithProcsPerMinute(6.0f)
        .Build();

    // Without DamageInfo or HealInfo, base chance is used
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 0.0f, 0.0f, false, false);
    EXPECT_NEAR(result, 50.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, PPM_Applied_WithHealInfo)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(0.0f)
        .WithProcsPerMinute(3.5f)
        .Build();

    // With HealInfo (no DamageInfo), PPM should still calculate
    // 3000ms cast time * 3.5 PPM / 600 = 17.5%
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 3000, 0.0f, 0.0f, false, true);
    EXPECT_NEAR(result, 17.5f, 0.01f);
}

TEST_F(SpellProcChanceTest, PPM_HealInfo_ZeroBaseChance_WouldBeZeroWithoutFix)
{
    // Reproduces the Omen of Clarity healing bug:
    // PPM=3.5, Chance=0, and only HealInfo present (no DamageInfo)
    // Without the fix, chance would be 0% because PPM branch was skipped
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(0.0f)
        .WithProcsPerMinute(3.5f)
        .Build();

    // Instant cast uses 1500ms minimum
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 1500, 0.0f, 0.0f, false, true);
    EXPECT_NEAR(result, 8.75f, 0.01f);
    EXPECT_GT(result, 0.0f) << "PPM with HealInfo must produce non-zero chance";
}

TEST_F(SpellProcChanceTest, PPM_WithWeaponSpeedVariation)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcsPerMinute(6.0f)
        .Build();

    // Fast weapon: 1400ms
    float fastResult = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 1400, 0.0f, 0.0f, true);
    EXPECT_NEAR(fastResult, 14.0f, 0.01f);

    // Slow weapon: 3300ms
    float slowResult = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 3300, 0.0f, 0.0f, true);
    EXPECT_NEAR(slowResult, 33.0f, 0.01f);
}

// =============================================================================
// Chance Modifier Tests
// =============================================================================

TEST_F(SpellProcChanceTest, ChanceModifier_PositiveModifier)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(20.0f)
        .Build();

    // +10% modifier
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 10.0f, 0.0f, false);
    EXPECT_NEAR(result, 30.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, ChanceModifier_NegativeModifier)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .Build();

    // -10% modifier
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, -10.0f, 0.0f, false);
    EXPECT_NEAR(result, 20.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, ChanceModifier_AppliedAfterPPM)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcsPerMinute(6.0f)
        .Build();

    // PPM gives 25%, +5% modifier = 30%
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 5.0f, 0.0f, true);
    EXPECT_NEAR(result, 30.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, PPMModifier_IncreasesEffectivePPM)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcsPerMinute(6.0f)
        .Build();

    // 6 PPM + 2 PPM modifier = 8 effective PPM
    // 2500 * 8 / 600 = 33.33%
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 0.0f, 2.0f, true);
    EXPECT_NEAR(result, 33.33f, 0.01f);
}

// =============================================================================
// Level 60+ Reduction Tests (PROC_ATTR_REDUCE_PROC_60)
// =============================================================================

TEST_F(SpellProcChanceTest, Level60Reduction_NoReductionAtLevel60)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 60, 2500, 0.0f, 0.0f, false);
    EXPECT_NEAR(result, 30.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, Level60Reduction_NoReductionBelowLevel60)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 50, 2500, 0.0f, 0.0f, false);
    EXPECT_NEAR(result, 30.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, Level60Reduction_ReductionAtLevel70)
{
    // Level 70 = 10 levels above 60
    // Reduction = 10/30 = 33.33%
    // 30% * (1 - 0.333) = 20%
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 70, 2500, 0.0f, 0.0f, false);
    EXPECT_NEAR(result, 20.0f, 0.5f);
}

TEST_F(SpellProcChanceTest, Level60Reduction_ReductionAtLevel80)
{
    // Level 80 = 20 levels above 60
    // Reduction = 20/30 = 66.67%
    // 30% * (1 - 0.667) = 10%
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 0.0f, 0.0f, false);
    EXPECT_NEAR(result, 10.0f, 0.5f);
}

TEST_F(SpellProcChanceTest, Level60Reduction_MinimumAtLevel90)
{
    // Level 90 = 30 levels above 60
    // Reduction = 30/30 = 100%
    // 30% * (1 - 1.0) = 0%
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 90, 2500, 0.0f, 0.0f, false);
    EXPECT_NEAR(result, 0.0f, 0.1f);
}

TEST_F(SpellProcChanceTest, Level60Reduction_NotAppliedWithoutAttribute)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(0) // No PROC_ATTR_REDUCE_PROC_60
        .Build();

    // At level 80, without the attribute, no reduction should occur
    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 0.0f, 0.0f, false);
    EXPECT_NEAR(result, 30.0f, 0.01f);
}

TEST_F(SpellProcChanceTest, Level60Reduction_AppliedAfterPPM)
{
    // PPM calculation gives 25%, then level reduction applied
    // Level 80 = 20 levels above 60, reduction = 66.67%
    // 25% * (1 - 0.667) = 8.33%
    auto procEntry = SpellProcEntryBuilder()
        .WithProcsPerMinute(6.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 80, 2500, 0.0f, 0.0f, true);
    EXPECT_NEAR(result, 8.33f, 0.5f);
}

// =============================================================================
// Helper Function Tests
// =============================================================================

TEST_F(SpellProcChanceTest, ApplyLevel60Reduction_DirectTest)
{
    // Level 60: no reduction
    EXPECT_NEAR(ProcChanceTestHelper::ApplyLevel60Reduction(30.0f, 60), 30.0f, 0.01f);

    // Level 70: 33.33% reduction
    EXPECT_NEAR(ProcChanceTestHelper::ApplyLevel60Reduction(30.0f, 70), 20.0f, 0.5f);

    // Level 80: 66.67% reduction
    EXPECT_NEAR(ProcChanceTestHelper::ApplyLevel60Reduction(30.0f, 80), 10.0f, 0.5f);

    // Level 90: 100% reduction
    EXPECT_NEAR(ProcChanceTestHelper::ApplyLevel60Reduction(30.0f, 90), 0.0f, 0.1f);

    // Level 100: capped at 0% (no negative chance)
    EXPECT_GE(ProcChanceTestHelper::ApplyLevel60Reduction(30.0f, 100), 0.0f);
}

// =============================================================================
// Combined Tests
// =============================================================================

TEST_F(SpellProcChanceTest, Combined_PPM_ChanceModifier_LevelReduction)
{
    // PPM: 6 at 2500ms = 25%
    // Chance modifier: +5% = 30%
    // Level 70 reduction: 30% * (1 - 0.333) = 20%
    auto procEntry = SpellProcEntryBuilder()
        .WithProcsPerMinute(6.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float result = ProcChanceTestHelper::SimulateCalcProcChance(
        procEntry, 70, 2500, 5.0f, 0.0f, true);
    EXPECT_NEAR(result, 20.0f, 1.0f);
}
