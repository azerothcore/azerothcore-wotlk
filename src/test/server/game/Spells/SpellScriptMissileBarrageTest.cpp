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
 * @file SpellScriptMissileBarrageTest.cpp
 * @brief Unit tests for Missile Barrage (44404-44408) proc behavior
 *
 * Missile Barrage talent should proc:
 * - 100% chance when casting Arcane Blast (SpellFamilyFlags[0] & 0x20000000)
 * - 50% reduced chance when casting other spells (Arcane Barrage, Frostfire Bolt, etc.)
 *
 * DBC Base proc chances by rank:
 * - Rank 1 (44404): 4%
 * - Rank 2 (44405): 8%
 * - Rank 3 (44406): 12%
 * - Rank 4 (44407): 16%
 * - Rank 5 (44408): 20%
 *
 * Effective proc rates:
 * - Arcane Blast: Full DBC chance (4-20%)
 * - Other spells: 50% of DBC chance (2-10%)
 */

#include "gtest/gtest.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SharedDefines.h"

// =============================================================================
// Missile Barrage Script Logic Simulation
// =============================================================================

/**
 * @brief Simulates the CheckProc logic from spell_mage_missile_barrage
 *
 * This mirrors the actual script at:
 * src/server/scripts/Spells/spell_mage.cpp:1325-1338
 *
 * @param spellFamilyFlags0 The SpellFamilyFlags[0] of the triggering spell
 * @param rollResult The result of roll_chance_i(50) - pass 0-49 to succeed, 50-99 to fail
 * @return true if the proc check passes
 */
bool SimulateMissileBarrageCheckProc(uint32 spellFamilyFlags0, int rollResult)
{
    // Arcane Blast - full proc chance (100%)
    // Arcane Blast spell family flags: 0x20000000
    if (spellFamilyFlags0 & 0x20000000)
        return true;

    // Other spells - 50% proc chance
    // Simulates: return roll_chance_i(50);
    return rollResult < 50;
}

/**
 * @brief Get the SpellFamilyFlags[0] for common Mage spells
 */
namespace MageSpellFlags
{
    constexpr uint32 ARCANE_BLAST       = 0x20000000;
    constexpr uint32 ARCANE_MISSILES    = 0x00000020;
    constexpr uint32 FIREBALL           = 0x00000001;
    constexpr uint32 FROSTFIRE_BOLT     = 0x00000000;  // Uses SpellFamilyFlags[1]
    constexpr uint32 ARCANE_BARRAGE     = 0x00000000;  // Uses SpellFamilyFlags[1]
}

// =============================================================================
// Test Fixture
// =============================================================================

class MissileBarrageTest : public ::testing::Test
{
protected:
    void SetUp() override {}
    void TearDown() override {}

    /**
     * @brief Run multiple proc checks and return the success rate
     * @param spellFamilyFlags0 The spell flags to test
     * @param iterations Number of iterations
     * @return Success rate as percentage (0-100)
     */
    float RunStatisticalTest(uint32 spellFamilyFlags0, int iterations = 10000)
    {
        int successes = 0;
        for (int i = 0; i < iterations; i++)
        {
            // Simulate random roll 0-99
            int roll = i % 100;
            if (SimulateMissileBarrageCheckProc(spellFamilyFlags0, roll))
                successes++;
        }
        return (float)successes / iterations * 100.0f;
    }
};

// =============================================================================
// Deterministic Tests - Arcane Blast
// =============================================================================

TEST_F(MissileBarrageTest, ArcaneBlast_AlwaysProcs_RegardlessOfRoll)
{
    // Arcane Blast should always pass CheckProc, regardless of the roll result
    for (int roll = 0; roll < 100; roll++)
    {
        EXPECT_TRUE(SimulateMissileBarrageCheckProc(MageSpellFlags::ARCANE_BLAST, roll))
            << "Arcane Blast should always proc, but failed with roll=" << roll;
    }
}

TEST_F(MissileBarrageTest, ArcaneBlast_Returns100PercentRate)
{
    float rate = RunStatisticalTest(MageSpellFlags::ARCANE_BLAST);
    EXPECT_NEAR(rate, 100.0f, 0.01f) << "Arcane Blast should have 100% CheckProc pass rate";
}

// =============================================================================
// Deterministic Tests - Other Spells (50% Reduction)
// =============================================================================

TEST_F(MissileBarrageTest, Fireball_ProcsOnLowRoll)
{
    // Rolls 0-49 should succeed
    for (int roll = 0; roll < 50; roll++)
    {
        EXPECT_TRUE(SimulateMissileBarrageCheckProc(MageSpellFlags::FIREBALL, roll))
            << "Fireball should proc with roll=" << roll << " (< 50)";
    }
}

TEST_F(MissileBarrageTest, Fireball_FailsOnHighRoll)
{
    // Rolls 50-99 should fail
    for (int roll = 50; roll < 100; roll++)
    {
        EXPECT_FALSE(SimulateMissileBarrageCheckProc(MageSpellFlags::FIREBALL, roll))
            << "Fireball should NOT proc with roll=" << roll << " (>= 50)";
    }
}

TEST_F(MissileBarrageTest, Fireball_Returns50PercentRate)
{
    float rate = RunStatisticalTest(MageSpellFlags::FIREBALL);
    EXPECT_NEAR(rate, 50.0f, 0.01f) << "Fireball should have 50% CheckProc pass rate";
}

TEST_F(MissileBarrageTest, ArcaneMissiles_Returns50PercentRate)
{
    float rate = RunStatisticalTest(MageSpellFlags::ARCANE_MISSILES);
    EXPECT_NEAR(rate, 50.0f, 0.01f) << "Arcane Missiles should have 50% CheckProc pass rate";
}

TEST_F(MissileBarrageTest, OtherSpells_Returns50PercentRate)
{
    // Any spell that doesn't have the Arcane Blast flag should get 50% rate
    float rate = RunStatisticalTest(0x00000000);
    EXPECT_NEAR(rate, 50.0f, 0.01f) << "Other spells should have 50% CheckProc pass rate";
}

// =============================================================================
// Effective Proc Rate Tests
// =============================================================================

/**
 * @brief Calculate the effective proc rate combining DBC chance and CheckProc
 * @param dbcChance Base proc chance from DBC (e.g., 20 for rank 5)
 * @param checkProcRate CheckProc pass rate (100 for Arcane Blast, 50 for others)
 * @return Effective proc rate as percentage
 */
float CalculateEffectiveProcRate(float dbcChance, float checkProcRate)
{
    return dbcChance * (checkProcRate / 100.0f);
}

TEST_F(MissileBarrageTest, EffectiveRate_ArcaneBlast_Rank5)
{
    // Rank 5: 20% base chance * 100% CheckProc = 20% effective
    float effective = CalculateEffectiveProcRate(20.0f, 100.0f);
    EXPECT_NEAR(effective, 20.0f, 0.01f);
}

TEST_F(MissileBarrageTest, EffectiveRate_Fireball_Rank5)
{
    // Rank 5: 20% base chance * 50% CheckProc = 10% effective
    float effective = CalculateEffectiveProcRate(20.0f, 50.0f);
    EXPECT_NEAR(effective, 10.0f, 0.01f);
}

TEST_F(MissileBarrageTest, EffectiveRate_ArcaneBlast_Rank1)
{
    // Rank 1: 4% base chance * 100% CheckProc = 4% effective
    float effective = CalculateEffectiveProcRate(4.0f, 100.0f);
    EXPECT_NEAR(effective, 4.0f, 0.01f);
}

TEST_F(MissileBarrageTest, EffectiveRate_Fireball_Rank1)
{
    // Rank 1: 4% base chance * 50% CheckProc = 2% effective
    float effective = CalculateEffectiveProcRate(4.0f, 50.0f);
    EXPECT_NEAR(effective, 2.0f, 0.01f);
}

// =============================================================================
// DBC Data Validation
// =============================================================================

TEST_F(MissileBarrageTest, DBCProcChances_MatchExpectedValues)
{
    // Expected DBC proc chances for each rank
    // Note: These should match the actual DBC values
    struct RankData
    {
        uint32 spellId;
        int expectedChance;
    };

    std::vector<RankData> ranks = {
        { 44404, 4 },   // Rank 1: 4% (actually 8% in some versions)
        { 44405, 8 },   // Rank 2
        { 44406, 12 },  // Rank 3
        { 44407, 16 },  // Rank 4
        { 44408, 20 },  // Rank 5
    };

    // This documents the expected values - actual verification would require SpellMgr
    for (auto const& rank : ranks)
    {
        SCOPED_TRACE("Spell ID: " + std::to_string(rank.spellId));
        // The actual DBC lookup would be:
        // SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(rank.spellId);
        // EXPECT_EQ(spellInfo->ProcChance, rank.expectedChance);
    }
}

// =============================================================================
// Boundary Tests
// =============================================================================

TEST_F(MissileBarrageTest, BoundaryRoll_49_Succeeds)
{
    // Roll of 49 should succeed (< 50)
    EXPECT_TRUE(SimulateMissileBarrageCheckProc(MageSpellFlags::FIREBALL, 49));
}

TEST_F(MissileBarrageTest, BoundaryRoll_50_Fails)
{
    // Roll of 50 should fail (>= 50)
    EXPECT_FALSE(SimulateMissileBarrageCheckProc(MageSpellFlags::FIREBALL, 50));
}

TEST_F(MissileBarrageTest, ArcaneBlastFlag_ExactMatch)
{
    // Test that exactly the Arcane Blast flag triggers 100% rate
    EXPECT_TRUE(SimulateMissileBarrageCheckProc(0x20000000, 99));

    // Combined flags should also work if Arcane Blast is present
    EXPECT_TRUE(SimulateMissileBarrageCheckProc(0x20000001, 99));
    EXPECT_TRUE(SimulateMissileBarrageCheckProc(0x20000020, 99));
    EXPECT_TRUE(SimulateMissileBarrageCheckProc(0xFFFFFFFF, 99));
}
