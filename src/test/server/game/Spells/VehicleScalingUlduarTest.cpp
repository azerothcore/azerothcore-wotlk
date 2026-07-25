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
 * @file VehicleScalingUlduarTest.cpp
 * @brief Tests for Ulduar vehicle gear scaling formula
 *
 * Formula (from spell_gen_vehicle_scaling_aura in spell_generic.cpp):
 *
 *   result = (totalAdjustedILvl - 2500) / 500
 *   amount = int32(max(0.1f, result))
 *
 * Where:
 *   totalAdjustedILvl = sum of GetItemLevelIncludingQuality across 15 equipped slots
 *                       (excludes offhand, ranged, shirt, tabard)
 *   GetItemLevelIncludingQuality bakes in quality penalty: -26 for uncommon/below,
 *   -13 for rare; heirloom items use pLevel * 2.33f instead of base ItemLevel.
 *   floor: 0.1 when totalAdjustedILvl < 2500
 *
 * Source data: Google Sheets "Ulduar Vehicle Scaling"
 * Vehicle: Salvaged Demolisher (entry 33109)
 */

#include "gtest/gtest.h"

#include <algorithm>
#include <cmath>
#include <cstdint>

namespace
{
    /// Mirrors the Ulduar vehicle scaling formula from spell_gen_vehicle_scaling_aura::CalculateAmount.
    /// totalAdjustedILvl is the sum of GetItemLevelIncludingQuality across equipped slots
    /// (quality penalty is already baked into each item's value).
    /// Computes the raw float result before int32 truncation.
    float CalcUlduarVehicleScale(float totalAdjustedILvl)
    {
        float const baseILvl = 2500.0f;
        float result = (totalAdjustedILvl - baseILvl) / 5.0f / 100.0f;
        return std::max(0.1f, result);
    }

    /// Mirrors the final int32 amount stored on the aura effect.
    int32_t CalcUlduarVehicleScaleAmount(float totalAdjustedILvl)
    {
        return static_cast<int32_t>(CalcUlduarVehicleScale(totalAdjustedILvl));
    }
}

// =============================================================================
// Formula structure: result = (totalAdjustedILvl - 2500) / 500
// =============================================================================

class UlduarVehicleScaleTest : public ::testing::Test {};

TEST_F(UlduarVehicleScaleTest, BaselineNoGear)
{
    // totalILvl = 2500 (e.g. 15 items at avg 166.67)
    // Formula gives 0. Floor at 0.1 -> 0.1, int32 truncates to 0
    float result = CalcUlduarVehicleScale(2500.0f);
    EXPECT_FLOAT_EQ(result, 0.1f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2500.0f), 0);
}

TEST_F(UlduarVehicleScaleTest, MinimumScalingThreshold)
{
    // totalILvl = 2550 -> (2550-2500)/500 = 0.1
    // At this threshold, floor matches formula
    float result = CalcUlduarVehicleScale(2550.0f);
    EXPECT_FLOAT_EQ(result, 0.1f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2550.0f), 0);
}

TEST_F(UlduarVehicleScaleTest, NaxxramasEntryGear)
{
    // totalILvl = 2805 (avg 187 * 15 items, typical Naxx entry)
    // (2805 - 2500) / 500 = 0.61
    float result = CalcUlduarVehicleScale(2805.0f);
    EXPECT_FLOAT_EQ(result, 0.61f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2805.0f), 0);
}

TEST_F(UlduarVehicleScaleTest, NaxxramasBiSGear)
{
    // totalILvl = 3000 (avg 200 * 15 items, Naxx BiS / Ulduar entry)
    // (3000 - 2500) / 500 = 1.0
    float result = CalcUlduarVehicleScale(3000.0f);
    EXPECT_FLOAT_EQ(result, 1.0f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(3000.0f), 1);
}

TEST_F(UlduarVehicleScaleTest, Ulduar10Gear)
{
    // totalILvl = 3195 (avg 213 * 15 items, Ulduar 10)
    // (3195 - 2500) / 500 = 1.39
    float result = CalcUlduarVehicleScale(3195.0f);
    EXPECT_FLOAT_EQ(result, 1.39f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(3195.0f), 1);
}

TEST_F(UlduarVehicleScaleTest, Ulduar25Gear)
{
    // totalILvl = 3390 (avg 226 * 15 items, Ulduar 25)
    // (3390 - 2500) / 500 = 1.78
    float result = CalcUlduarVehicleScale(3390.0f);
    EXPECT_FLOAT_EQ(result, 1.78f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(3390.0f), 1);
}

TEST_F(UlduarVehicleScaleTest, UlduarBiSGear)
{
    // totalILvl = 3780 (avg 252 * 15 items, Ulduar BiS)
    // (3780 - 2500) / 500 = 2.56
    float result = CalcUlduarVehicleScale(3780.0f);
    EXPECT_FLOAT_EQ(result, 2.56f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(3780.0f), 2);
}

TEST_F(UlduarVehicleScaleTest, ToCBiSGear)
{
    // totalILvl = 3884 (avg 258.9 * 15 items, ToGC BiS)
    // (3884 - 2500) / 500 = 2.768
    float result = CalcUlduarVehicleScale(3884.0f);
    EXPECT_FLOAT_EQ(result, 2.768f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(3884.0f), 2);
}

TEST_F(UlduarVehicleScaleTest, ICCBiSGear)
{
    // totalILvl = 4162 (avg 277.5 * 15 items, ICC BiS)
    // (4162 - 2500) / 500 = 3.324
    float result = CalcUlduarVehicleScale(4162.0f);
    EXPECT_FLOAT_EQ(result, 3.324f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(4162.0f), 3);
}

TEST_F(UlduarVehicleScaleTest, RSBiSGear)
{
    // totalILvl = 4204 (avg 280.3 * 15 items, RS BiS)
    // (4204 - 2500) / 500 = 3.408
    float result = CalcUlduarVehicleScale(4204.0f);
    EXPECT_FLOAT_EQ(result, 3.408f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(4204.0f), 3);
}

// =============================================================================
// Quality penalty tests
// =============================================================================

TEST_F(UlduarVehicleScaleTest, AllEpicNoPenalty)
{
    // 15 epic items at avg 200: totalAdjustedILvl = 15 * 200 = 3000
    // (3000 - 2500) / 500 = 1.0
    float result = CalcUlduarVehicleScale(3000.0f);
    EXPECT_FLOAT_EQ(result, 1.0f);
}

TEST_F(UlduarVehicleScaleTest, OneRareItemPenalty)
{
    // 14 epic (200) + 1 rare (200 - 13 = 187): totalAdjustedILvl = 14*200 + 187 = 2987
    // (2987 - 2500) / 500 = 487/500 = 0.974
    float result = CalcUlduarVehicleScale(2987.0f);
    EXPECT_FLOAT_EQ(result, 0.974f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2987.0f), 0);
}

TEST_F(UlduarVehicleScaleTest, OneUncommonItemPenalty)
{
    // 14 epic (200) + 1 uncommon (200 - 26 = 174): totalAdjustedILvl = 14*200 + 174 = 2974
    // (2974 - 2500) / 500 = 474/500 = 0.948
    float result = CalcUlduarVehicleScale(2974.0f);
    EXPECT_FLOAT_EQ(result, 0.948f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2974.0f), 0);
}

TEST_F(UlduarVehicleScaleTest, MixedQualityPenalty)
{
    // 10 epic (200) + 3 rare (187) + 2 uncommon (174):
    // totalAdjustedILvl = 10*200 + 3*187 + 2*174 = 2000 + 561 + 348 = 2909
    // (2909 - 2500) / 500 = 409/500 = 0.818
    float result = CalcUlduarVehicleScale(2909.0f);
    EXPECT_FLOAT_EQ(result, 0.818f);
}

// =============================================================================
// Floor behavior
// =============================================================================

TEST_F(UlduarVehicleScaleTest, FloorAtLowItemLevel)
{
    // totalILvl < 2500 → result would be negative, floor to 0.1
    float result = CalcUlduarVehicleScale(2400.0f);
    EXPECT_FLOAT_EQ(result, 0.1f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2400.0f), 0);
}

TEST_F(UlduarVehicleScaleTest, FloorWithQualityPenalty)
{
    // totalAdjustedILvl = 2400 (e.g. sum of quality-adjusted iLvl below 2500)
    // (2400 - 2500) / 500 = -0.2 → floor to 0.1
    float result = CalcUlduarVehicleScale(2400.0f);
    EXPECT_FLOAT_EQ(result, 0.1f);
    EXPECT_EQ(CalcUlduarVehicleScaleAmount(2400.0f), 0);
}

// =============================================================================
// Monotonicity: scaling must never decrease as totalILvl increases
// =============================================================================

TEST_F(UlduarVehicleScaleTest, MonotonicWithSameQuality)
{
    float prev = CalcUlduarVehicleScale(2500.0f);
    for (float totalILvl = 2510.0f; totalILvl <= 4000.0f; totalILvl += 10.0f)
    {
        float curr = CalcUlduarVehicleScale(totalILvl);
        EXPECT_GE(curr, prev) << "Scaling dropped at totalILvl=" << totalILvl;
        prev = curr;
    }
}

TEST_F(UlduarVehicleScaleTest, MonotonicAmountWithSameQuality)
{
    int32_t prev = CalcUlduarVehicleScaleAmount(2500.0f);
    for (float totalILvl = 2510.0f; totalILvl <= 4000.0f; totalILvl += 10.0f)
    {
        int32_t curr = CalcUlduarVehicleScaleAmount(totalILvl);
        EXPECT_GE(curr, prev) << "Amount dropped at totalILvl=" << totalILvl;
        prev = curr;
    }
}
