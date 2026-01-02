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
 * @file SpellProcPPMModifierTest.cpp
 * @brief Unit tests for SPELLMOD_PROC_PER_MINUTE modifier application
 *
 * Tests the logic from Unit.cpp:10378-10390:
 * - Base PPM calculation without modifiers
 * - Flat PPM modifier application
 * - Percent PPM modifier application
 * - GetSpellModOwner() null handling
 * - SpellProto null handling
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcPPMModifierTest : public ::testing::Test
{
protected:
    void SetUp() override {}

    // Standard weapon speeds for testing
    static constexpr uint32 DAGGER_SPEED = 1400;      // 1.4 sec
    static constexpr uint32 SWORD_SPEED = 2500;       // 2.5 sec
    static constexpr uint32 TWO_HANDED_SPEED = 3300;  // 3.3 sec
};

// =============================================================================
// Base PPM Calculation (No Modifiers)
// =============================================================================

TEST_F(SpellProcPPMModifierTest, BasePPM_NoModifiers)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    // Default config: no modifiers, has spell mod owner and spell proto

    float basePPM = 6.0f;

    // With 2500ms weapon: (2500 * 6) / 600 = 25%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 25.0f, 0.01f)
        << "Base PPM 6.0 with 2.5s weapon should give 25% chance";
}

TEST_F(SpellProcPPMModifierTest, BasePPM_DifferentWeaponSpeeds)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    float basePPM = 6.0f;

    // Fast dagger: (1400 * 6) / 600 = 14%
    float daggerChance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        DAGGER_SPEED, basePPM, config);
    EXPECT_NEAR(daggerChance, 14.0f, 0.01f);

    // Slow 2H: (3300 * 6) / 600 = 33%
    float twoHandChance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        TWO_HANDED_SPEED, basePPM, config);
    EXPECT_NEAR(twoHandChance, 33.0f, 0.01f);
}

TEST_F(SpellProcPPMModifierTest, BasePPM_ZeroPPM)
{
    ProcChanceTestHelper::PPMModifierConfig config;

    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, 0.0f, config);

    EXPECT_EQ(chance, 0.0f)
        << "Zero PPM should return 0% chance";
}

TEST_F(SpellProcPPMModifierTest, BasePPM_NegativePPM)
{
    ProcChanceTestHelper::PPMModifierConfig config;

    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, -5.0f, config);

    EXPECT_EQ(chance, 0.0f)
        << "Negative PPM should return 0% chance";
}

// =============================================================================
// Flat Modifier Tests - SPELLMOD_FLAT for SPELLMOD_PROC_PER_MINUTE
// =============================================================================

TEST_F(SpellProcPPMModifierTest, FlatModifier_IncreasesPPM)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.flatModifier = 2.0f;  // +2 PPM

    float basePPM = 6.0f;
    // Modified PPM: 6 + 2 = 8
    // Chance: (2500 * 8) / 600 = 33.33%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 33.33f, 0.1f)
        << "Flat +2 PPM modifier should increase chance from 25% to 33.33%";
}

TEST_F(SpellProcPPMModifierTest, FlatModifier_DecreasesPPM)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.flatModifier = -3.0f;  // -3 PPM

    float basePPM = 6.0f;
    // Modified PPM: 6 - 3 = 3
    // Chance: (2500 * 3) / 600 = 12.5%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 12.5f, 0.1f)
        << "Flat -3 PPM modifier should decrease chance from 25% to 12.5%";
}

TEST_F(SpellProcPPMModifierTest, FlatModifier_ReducesToZero)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.flatModifier = -10.0f;  // Would reduce to -4 PPM

    float basePPM = 6.0f;
    // Modified PPM: 6 - 10 = -4 (negative)
    // Formula still applies: (2500 * -4) / 600 = negative
    // But the check at start for PPM <= 0 happens before modifiers
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    // Note: In the real code, negative results are possible after modifiers
    // The helper doesn't clamp the final result
    EXPECT_LT(chance, 0.0f)
        << "Extreme negative modifier can produce negative chance";
}

// =============================================================================
// Percent Modifier Tests - SPELLMOD_PCT for SPELLMOD_PROC_PER_MINUTE
// =============================================================================

TEST_F(SpellProcPPMModifierTest, PercentModifier_50PercentIncrease)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.pctModifier = 1.5f;  // 150% = 50% increase

    float basePPM = 6.0f;
    // Modified PPM: 6 * 1.5 = 9
    // Chance: (2500 * 9) / 600 = 37.5%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 37.5f, 0.1f)
        << "50% PPM increase should raise chance from 25% to 37.5%";
}

TEST_F(SpellProcPPMModifierTest, PercentModifier_50PercentDecrease)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.pctModifier = 0.5f;  // 50% = 50% decrease

    float basePPM = 6.0f;
    // Modified PPM: 6 * 0.5 = 3
    // Chance: (2500 * 3) / 600 = 12.5%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 12.5f, 0.1f)
        << "50% PPM decrease should lower chance from 25% to 12.5%";
}

TEST_F(SpellProcPPMModifierTest, PercentModifier_DoublesPPM)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.pctModifier = 2.0f;  // 200%

    float basePPM = 6.0f;
    // Modified PPM: 6 * 2 = 12
    // Chance: (2500 * 12) / 600 = 50%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 50.0f, 0.1f)
        << "100% PPM increase should double chance to 50%";
}

// =============================================================================
// Combined Modifiers Tests
// =============================================================================

TEST_F(SpellProcPPMModifierTest, CombinedModifiers_FlatThenPercent)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.flatModifier = 2.0f;   // +2 PPM first
    config.pctModifier = 1.5f;    // Then 50% increase

    float basePPM = 6.0f;
    // Flat first: 6 + 2 = 8
    // Percent: 8 * 1.5 = 12
    // Chance: (2500 * 12) / 600 = 50%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 50.0f, 0.1f)
        << "Flat +2 then 50% increase should result in 50% chance";
}

TEST_F(SpellProcPPMModifierTest, CombinedModifiers_BothIncrease)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.flatModifier = 4.0f;   // +4 PPM
    config.pctModifier = 1.25f;   // 25% increase

    float basePPM = 6.0f;
    // Flat first: 6 + 4 = 10
    // Percent: 10 * 1.25 = 12.5
    // Chance: (2500 * 12.5) / 600 = 52.08%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 52.08f, 0.1f);
}

// =============================================================================
// No SpellModOwner Tests - GetSpellModOwner() returns null
// =============================================================================

TEST_F(SpellProcPPMModifierTest, NoSpellModOwner_ModifiersIgnored)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.hasSpellModOwner = false;  // GetSpellModOwner() returns null
    config.flatModifier = 10.0f;      // Would significantly change result
    config.pctModifier = 2.0f;

    float basePPM = 6.0f;
    // Without spell mod owner, modifiers are NOT applied
    // Chance: (2500 * 6) / 600 = 25%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 25.0f, 0.1f)
        << "Without spell mod owner, modifiers should be ignored";
}

// =============================================================================
// No SpellProto Tests - spellProto is null
// =============================================================================

TEST_F(SpellProcPPMModifierTest, NoSpellProto_ModifiersIgnored)
{
    ProcChanceTestHelper::PPMModifierConfig config;
    config.hasSpellProto = false;  // spellProto is null
    config.flatModifier = 10.0f;
    config.pctModifier = 2.0f;

    float basePPM = 6.0f;
    // Without spell proto, modifiers are NOT applied
    // Chance: (2500 * 6) / 600 = 25%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, basePPM, config);

    EXPECT_NEAR(chance, 25.0f, 0.1f)
        << "Without spell proto, modifiers should be ignored";
}

// =============================================================================
// Real Spell Scenarios
// =============================================================================

TEST_F(SpellProcPPMModifierTest, Scenario_OmenOfClarity_BasePPM)
{
    // Omen of Clarity: 6 PPM
    ProcChanceTestHelper::PPMModifierConfig config;

    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, 6.0f, config);

    EXPECT_NEAR(chance, 25.0f, 0.1f)
        << "Omen of Clarity base chance with 2.5s weapon";
}

TEST_F(SpellProcPPMModifierTest, Scenario_OmenOfClarity_WithTalent)
{
    // Hypothetical talent that increases Omen of Clarity PPM by 2
    ProcChanceTestHelper::PPMModifierConfig config;
    config.flatModifier = 2.0f;

    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, 6.0f, config);

    EXPECT_NEAR(chance, 33.33f, 0.1f)
        << "Omen of Clarity with +2 PPM talent";
}

TEST_F(SpellProcPPMModifierTest, Scenario_WindfuryWeapon_FastWeapon)
{
    // Windfury Weapon: 2 PPM with fast weapon
    ProcChanceTestHelper::PPMModifierConfig config;

    // Fast 1.5s weapon: (1500 * 2) / 600 = 5%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        1500, 2.0f, config);

    EXPECT_NEAR(chance, 5.0f, 0.1f)
        << "Windfury with 1.5s weapon";
}

TEST_F(SpellProcPPMModifierTest, Scenario_WindfuryWeapon_SlowWeapon)
{
    // Windfury Weapon: 2 PPM with slow weapon
    ProcChanceTestHelper::PPMModifierConfig config;

    // Slow 3.6s weapon: (3600 * 2) / 600 = 12%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        3600, 2.0f, config);

    EXPECT_NEAR(chance, 12.0f, 0.1f)
        << "Windfury with 3.6s weapon";
}

TEST_F(SpellProcPPMModifierTest, Scenario_JudgementOfLight_HighPPM)
{
    // Judgement of Light: 15 PPM (very high)
    ProcChanceTestHelper::PPMModifierConfig config;

    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, 15.0f, config);

    // (2500 * 15) / 600 = 62.5%
    EXPECT_NEAR(chance, 62.5f, 0.1f)
        << "Judgement of Light with 2.5s weapon";
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(SpellProcPPMModifierTest, EdgeCase_VeryFastWeapon)
{
    ProcChanceTestHelper::PPMModifierConfig config;

    // 1.0s weapon (very fast): (1000 * 6) / 600 = 10%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        1000, 6.0f, config);

    EXPECT_NEAR(chance, 10.0f, 0.1f);
}

TEST_F(SpellProcPPMModifierTest, EdgeCase_VerySlowWeapon)
{
    ProcChanceTestHelper::PPMModifierConfig config;

    // 4.0s weapon (very slow): (4000 * 6) / 600 = 40%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        4000, 6.0f, config);

    EXPECT_NEAR(chance, 40.0f, 0.1f);
}

TEST_F(SpellProcPPMModifierTest, EdgeCase_VeryHighPPM)
{
    ProcChanceTestHelper::PPMModifierConfig config;

    // 60 PPM: (2500 * 60) / 600 = 250% (over 100%, can happen)
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        SWORD_SPEED, 60.0f, config);

    EXPECT_NEAR(chance, 250.0f, 0.1f)
        << "Very high PPM can exceed 100% chance";
}

TEST_F(SpellProcPPMModifierTest, EdgeCase_ZeroWeaponSpeed)
{
    ProcChanceTestHelper::PPMModifierConfig config;

    // Zero weapon speed should result in 0%
    float chance = ProcChanceTestHelper::CalculatePPMChanceWithModifiers(
        0, 6.0f, config);

    EXPECT_EQ(chance, 0.0f);
}
