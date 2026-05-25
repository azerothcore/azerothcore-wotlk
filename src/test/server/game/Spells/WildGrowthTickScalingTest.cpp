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
 * @file WildGrowthTickScalingTest.cpp
 * @brief Tests for Wild Growth tick scaling formula
 *
 * Wild Growth heals with a front-loaded pattern: first tick heals most,
 * each subsequent tick heals less. The formula (from spell_dru_wild_growth_aura):
 *
 *   bonus = 6.0 - baseReduction * (tickNumber - 1)
 *   amount = baseTick + baseTick * bonus / 100
 *
 * Where baseTick MUST include caster spell power bonuses (set via
 * DoEffectCalcAmount, which runs after SpellHealingBonusDone in
 * CalculateAmount). See TrinityCore issue #21281.
 *
 * baseReduction defaults to 2.0, reduced by T10 Restoration 2P Bonus.
 * Wild Growth has 7 ticks (7s duration, 1s amplitude).
 */

#include "gtest/gtest.h"

#include <cmath>
#include <cstdint>
#include <numeric>
#include <vector>

namespace
{
    constexpr int32_t TOTAL_TICKS = 7;
    constexpr float DEFAULT_REDUCTION = 2.0f;

    /// Mirrors CalculatePct from Define.h: base * pct / 100
    template <typename T>
    T CalcPct(T base, float pct)
    {
        return static_cast<T>(base * pct / 100.0f);
    }

    /// Mirrors spell_dru_wild_growth_aura::HandleTickUpdate
    int32_t CalcWildGrowthTickAmount(int32_t baseTick, uint32_t tickNumber, float baseReduction)
    {
        float reduction = baseReduction * static_cast<float>(tickNumber - 1);
        float bonus = 6.0f - reduction;
        return static_cast<int32_t>(baseTick + CalcPct(baseTick, bonus));
    }

    /// Calculate all tick amounts for a Wild Growth cast
    std::vector<int32_t> CalcAllTicks(int32_t baseTick, float baseReduction = DEFAULT_REDUCTION)
    {
        std::vector<int32_t> ticks;
        ticks.reserve(TOTAL_TICKS);
        for (uint32_t i = 1; i <= TOTAL_TICKS; ++i)
            ticks.push_back(CalcWildGrowthTickAmount(baseTick, i, baseReduction));
        return ticks;
    }
}

class WildGrowthTickScalingTest : public ::testing::Test {};

// =============================================================================
// Formula correctness with spell power included in baseTick
// =============================================================================

TEST_F(WildGrowthTickScalingTest, FirstTickIsHighest)
{
    // baseTick=600 simulates a spell-power-inclusive value
    auto ticks = CalcAllTicks(600);

    for (int i = 1; i < TOTAL_TICKS; ++i)
        EXPECT_GT(ticks[0], ticks[i]) << "Tick 1 should be highest, but tick " << (i + 1) << " is higher";
}

TEST_F(WildGrowthTickScalingTest, LastTickIsLowest)
{
    auto ticks = CalcAllTicks(600);

    for (int i = 0; i < TOTAL_TICKS - 1; ++i)
        EXPECT_LT(ticks[TOTAL_TICKS - 1], ticks[i]) << "Tick 7 should be lowest, but tick " << (i + 1) << " is lower";
}

TEST_F(WildGrowthTickScalingTest, TicksAreMonotonicallyDecreasing)
{
    auto ticks = CalcAllTicks(600);

    for (int i = 1; i < TOTAL_TICKS; ++i)
        EXPECT_LE(ticks[i], ticks[i - 1]) << "Tick " << (i + 1) << " should be <= tick " << i;
}

TEST_F(WildGrowthTickScalingTest, TotalHealingPreserved)
{
    // Sum of all ticks should equal 7 * baseTick (scaling is symmetric)
    int32_t const baseTick = 600;
    auto ticks = CalcAllTicks(baseTick);

    int32_t totalHealing = std::accumulate(ticks.begin(), ticks.end(), 0);
    int32_t expectedTotal = baseTick * TOTAL_TICKS;

    // Allow +-1 per tick for integer truncation
    EXPECT_NEAR(totalHealing, expectedTotal, TOTAL_TICKS);
}

TEST_F(WildGrowthTickScalingTest, MiddleTickEqualsBase)
{
    // Tick 4 (middle) has 0% bonus, so it equals baseTick exactly
    int32_t const baseTick = 600;
    int32_t tick4 = CalcWildGrowthTickAmount(baseTick, 4, DEFAULT_REDUCTION);

    EXPECT_EQ(tick4, baseTick);
}

// =============================================================================
// Specific tick values with spell power
// =============================================================================

TEST_F(WildGrowthTickScalingTest, TickValues_WithSpellPower)
{
    // baseTick = 600 (raw base ~206 + spell power ~394)
    int32_t const baseTick = 600;
    auto ticks = CalcAllTicks(baseTick);

    // Tick 1: 600 + 6% = 636
    EXPECT_EQ(ticks[0], 636);
    // Tick 2: 600 + 4% = 624
    EXPECT_EQ(ticks[1], 624);
    // Tick 3: 600 + 2% = 612
    EXPECT_EQ(ticks[2], 612);
    // Tick 4: 600 + 0% = 600
    EXPECT_EQ(ticks[3], 600);
    // Tick 5: 600 - 2% = 588
    EXPECT_EQ(ticks[4], 588);
    // Tick 6: 600 - 4% = 576
    EXPECT_EQ(ticks[5], 576);
    // Tick 7: 600 - 6% = 564
    EXPECT_EQ(ticks[6], 564);
}

TEST_F(WildGrowthTickScalingTest, TickValues_RawBaseOnly_WouldBeBroken)
{
    // If baseTick were only the raw base (206) without spell power,
    // ticks would be far too low. This documents the bug from
    // TrinityCore #21281 / AC's CallScriptEffectCalcAmountHandlers
    // ordering issue.
    int32_t const rawBase = 206;
    auto ticks = CalcAllTicks(rawBase);

    // Tick 1 without spell power: 206 + 6% = 218
    EXPECT_EQ(ticks[0], 218);
    // This is ~1/3 of the correct value (636), matching the player report
    EXPECT_LT(ticks[0], 636 / 2) << "Raw base ticks are less than half the SP-inclusive value";
}

// =============================================================================
// T10 Restoration 2P Bonus (reduces tick drop-off rate)
// =============================================================================

TEST_F(WildGrowthTickScalingTest, T10_2P_ReducesReduction)
{
    // T10 2P reduces the drop rate. If bonus amount is 30%,
    // baseReduction = 2.0 - 2.0 * 30/100 = 1.4
    float baseReduction = DEFAULT_REDUCTION;
    float t10BonusAmount = 30.0f;
    baseReduction -= baseReduction * t10BonusAmount / 100.0f;
    EXPECT_FLOAT_EQ(baseReduction, 1.4f);

    auto ticks = CalcAllTicks(600, baseReduction);

    // With reduced drop-off, ticks are more uniform
    // First tick: 600 + 6% = 636 (unchanged, bonus starts at 6%)
    EXPECT_EQ(ticks[0], 636);
    // Last tick: 600 + (6 - 1.4*6)% = 600 + (-2.4)% = 600 - 14.4 -> 586
    EXPECT_EQ(ticks[TOTAL_TICKS - 1], 586);

    // Range is smaller with T10 2P
    int32_t rangeWithT10 = ticks[0] - ticks[TOTAL_TICKS - 1];
    auto normalTicks = CalcAllTicks(600);
    int32_t rangeNormal = normalTicks[0] - normalTicks[TOTAL_TICKS - 1];

    EXPECT_LT(rangeWithT10, rangeNormal) << "T10 2P should reduce tick-to-tick variance";
}

TEST_F(WildGrowthTickScalingTest, T10_2P_TotalHealingPreserved)
{
    float baseReduction = DEFAULT_REDUCTION;
    baseReduction -= baseReduction * 30.0f / 100.0f;

    int32_t const baseTick = 600;
    auto ticks = CalcAllTicks(baseTick, baseReduction);

    int32_t totalHealing = std::accumulate(ticks.begin(), ticks.end(), 0);
    int32_t expectedTotal = baseTick * TOTAL_TICKS;

    // With T10 2P the scaling is asymmetric (bonus starts at +6% but
    // only drops by 1.4% per tick instead of 2%), so total healing is
    // slightly higher than 7 * baseTick. This is expected and matches TC.
    EXPECT_GT(totalHealing, expectedTotal);
    // Should not exceed ~2% above baseline
    EXPECT_LT(totalHealing, expectedTotal * 102 / 100);
}
