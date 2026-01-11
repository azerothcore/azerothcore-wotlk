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
 * @file SpellProcPPMTest.cpp
 * @brief Unit tests for PPM (Procs Per Minute) calculation
 *
 * Tests the formula: chance = (WeaponSpeed * PPM) / 600.0f
 */

#include "ProcChanceTestHelper.h"
#include "UnitStub.h"
#include "gtest/gtest.h"

using namespace testing;

// =============================================================================
// PPM Formula Tests
// =============================================================================

class SpellProcPPMTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _unit = std::make_unique<UnitStub>();
    }

    std::unique_ptr<UnitStub> _unit;
};

TEST_F(SpellProcPPMTest, PPMFormula_BasicCalculation)
{
    // Formula: (WeaponSpeed * PPM) / 600.0f
    // 2500ms * 6 PPM / 600 = 25%
    float result = ProcChanceTestHelper::CalculatePPMChance(2500, 6.0f);
    EXPECT_NEAR(result, 25.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, PPMFormula_FastWeapon_HigherChancePerSwing)
{
    // Fast dagger (1.4 sec = 1400ms), 6 PPM
    // 1400 * 6 / 600 = 14%
    float result = ProcChanceTestHelper::CalculatePPMChance(1400, 6.0f);
    EXPECT_NEAR(result, 14.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, PPMFormula_SlowWeapon_LowerChancePerSwing)
{
    // Slow 2H (3.3 sec = 3300ms), 6 PPM
    // 3300 * 6 / 600 = 33%
    float result = ProcChanceTestHelper::CalculatePPMChance(3300, 6.0f);
    EXPECT_NEAR(result, 33.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, PPMFormula_VerySlowWeapon)
{
    // Very slow weapon (3.8 sec = 3800ms), 6 PPM
    // 3800 * 6 / 600 = 38%
    float result = ProcChanceTestHelper::CalculatePPMChance(3800, 6.0f);
    EXPECT_NEAR(result, 38.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, PPMFormula_ZeroPPM_ReturnsZero)
{
    float result = ProcChanceTestHelper::CalculatePPMChance(2500, 0.0f);
    EXPECT_FLOAT_EQ(result, 0.0f);
}

TEST_F(SpellProcPPMTest, PPMFormula_NegativePPM_ReturnsZero)
{
    float result = ProcChanceTestHelper::CalculatePPMChance(2500, -1.0f);
    EXPECT_FLOAT_EQ(result, 0.0f);
}

TEST_F(SpellProcPPMTest, PPMFormula_WithPositiveModifier)
{
    // 2500ms, 6 PPM + 2 PPM modifier = 8 effective PPM
    // 2500 * 8 / 600 = 33.33%
    float result = ProcChanceTestHelper::CalculatePPMChance(2500, 6.0f, 2.0f);
    EXPECT_NEAR(result, 33.33f, 0.01f);
}

TEST_F(SpellProcPPMTest, PPMFormula_WithNegativeModifier)
{
    // 2500ms, 6 PPM - 2 PPM modifier = 4 effective PPM
    // 2500 * 4 / 600 = 16.67%
    float result = ProcChanceTestHelper::CalculatePPMChance(2500, 6.0f, -2.0f);
    EXPECT_NEAR(result, 16.67f, 0.01f);
}

// =============================================================================
// UnitStub PPM Tests
// =============================================================================

TEST_F(SpellProcPPMTest, UnitStub_GetPPMProcChance_DefaultWeaponSpeed)
{
    // Default weapon speed is 2000ms
    float result = _unit->GetPPMProcChance(2000, 6.0f);
    EXPECT_NEAR(result, 20.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, UnitStub_GetPPMProcChance_CustomWeaponSpeed)
{
    _unit->SetAttackTime(0, 2500); // BASE_ATTACK
    float result = _unit->GetPPMProcChance(_unit->GetAttackTime(0), 6.0f);
    EXPECT_NEAR(result, 25.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, UnitStub_GetPPMProcChance_WithPPMModifier)
{
    _unit->SetPPMModifier(12345, 2.0f); // Spell ID 12345 has +2 PPM modifier
    float result = _unit->GetPPMProcChance(2500, 6.0f, 12345);
    // 2500 * (6 + 2) / 600 = 33.33%
    EXPECT_NEAR(result, 33.33f, 0.01f);
}

TEST_F(SpellProcPPMTest, UnitStub_GetPPMProcChance_ModifierNotAppliedWithoutSpellId)
{
    _unit->SetPPMModifier(12345, 2.0f);
    // Without spell ID, modifier is not applied
    float result = _unit->GetPPMProcChance(2500, 6.0f, 0);
    EXPECT_NEAR(result, 25.0f, 0.01f);
}

// =============================================================================
// Real-World PPM Spell Examples
// =============================================================================

TEST_F(SpellProcPPMTest, OmenOfClarity_PPM6_VariousWeaponSpeeds)
{
    // Omen of Clarity: 6 PPM
    constexpr float OOC_PPM = 6.0f;

    // Fast dagger
    float daggerChance = ProcChanceTestHelper::CalculatePPMChance(1400, OOC_PPM);
    EXPECT_NEAR(daggerChance, 14.0f, 0.01f);

    // Normal 1H sword
    float swordChance = ProcChanceTestHelper::CalculatePPMChance(2500, OOC_PPM);
    EXPECT_NEAR(swordChance, 25.0f, 0.01f);

    // Staff
    float staffChance = ProcChanceTestHelper::CalculatePPMChance(3000, OOC_PPM);
    EXPECT_NEAR(staffChance, 30.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, JudgementOfLight_PPM15_VariousWeaponSpeeds)
{
    // Judgement of Light: 15 PPM
    constexpr float JOL_PPM = 15.0f;

    // Fast dagger
    float daggerChance = ProcChanceTestHelper::CalculatePPMChance(1400, JOL_PPM);
    EXPECT_NEAR(daggerChance, 35.0f, 0.01f);

    // Normal 1H sword
    float swordChance = ProcChanceTestHelper::CalculatePPMChance(2500, JOL_PPM);
    EXPECT_NEAR(swordChance, 62.5f, 0.01f);

    // Slow 2H weapon
    float twoHanderChance = ProcChanceTestHelper::CalculatePPMChance(3300, JOL_PPM);
    EXPECT_NEAR(twoHanderChance, 82.5f, 0.01f);
}

TEST_F(SpellProcPPMTest, WindfuryWeapon_PPM2_VariousWeaponSpeeds)
{
    // Windfury Weapon: 2 PPM (low PPM for testing)
    constexpr float WF_PPM = 2.0f;

    // Fast dagger
    float daggerChance = ProcChanceTestHelper::CalculatePPMChance(1400, WF_PPM);
    EXPECT_NEAR(daggerChance, 4.67f, 0.01f);

    // Slow 2H weapon
    float twoHanderChance = ProcChanceTestHelper::CalculatePPMChance(3300, WF_PPM);
    EXPECT_NEAR(twoHanderChance, 11.0f, 0.01f);
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(SpellProcPPMTest, EdgeCase_VeryFastWeapon)
{
    // Very fast (theoretical) weapon - 1.0 sec = 1000ms
    float result = ProcChanceTestHelper::CalculatePPMChance(1000, 6.0f);
    EXPECT_NEAR(result, 10.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, EdgeCase_ExtremelySlow)
{
    // Extremely slow weapon - 5.0 sec = 5000ms
    float result = ProcChanceTestHelper::CalculatePPMChance(5000, 6.0f);
    EXPECT_NEAR(result, 50.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, EdgeCase_HighPPM)
{
    // High PPM value (30)
    float result = ProcChanceTestHelper::CalculatePPMChance(2500, 30.0f);
    // 2500 * 30 / 600 = 125% (can exceed 100%)
    EXPECT_NEAR(result, 125.0f, 0.01f);
}

TEST_F(SpellProcPPMTest, EdgeCase_FractionalPPM)
{
    // Fractional PPM value (2.5)
    float result = ProcChanceTestHelper::CalculatePPMChance(2400, 2.5f);
    // 2400 * 2.5 / 600 = 10%
    EXPECT_NEAR(result, 10.0f, 0.01f);
}
