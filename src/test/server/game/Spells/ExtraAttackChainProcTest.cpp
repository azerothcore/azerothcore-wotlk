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
 * @file ExtraAttackChainProcTest.cpp
 * @brief Unit tests for extra attack chain-proc prevention
 *
 * Tests the logic from SpellAuraEffects.cpp:1245-1261 (CheckEffectProc):
 * - Self-chain prevention (same extra attack spell can't proc itself)
 * - Cross-chain prevention (Sword Specialization / Hack and Slash block all extra attack procs)
 * - Non-blacklisted extra attack spells allow cross-proccing
 * - Non-extra-attack procs are unaffected by the guard
 */

#include "ProcChanceTestHelper.h"
#include "gtest/gtest.h"

using namespace testing;

// Use existing enum from Unit.h: SPELL_SWORD_SPECIALIZATIONIALIZATION (16459), SPELL_HACK_AND_SLASH (66923)
constexpr uint32 SPELL_RECKONING       = 32746; // Reckoning (Paladin)
constexpr uint32 SPELL_HAND_OF_JUSTICE = 15601; // Hand of Justice extra attack

class ExtraAttackChainProcTest : public ::testing::Test
{
protected:
    ProcChanceTestHelper::ExtraAttackProcConfig MakeConfig(
        bool hasExtraAttacks, uint32 triggerSpellId, uint32 lastExtraAttack)
    {
        ProcChanceTestHelper::ExtraAttackProcConfig config;
        config.triggeredSpellHasExtraAttacks = hasExtraAttacks;
        config.triggerSpellId = triggerSpellId;
        config.lastExtraAttackSpell = lastExtraAttack;
        return config;
    }
};

// =============================================================================
// Normal proc (no extra attack in progress)
// =============================================================================

TEST_F(ExtraAttackChainProcTest, NormalProc_AllowedWhenNoExtraAttackInProgress)
{
    // lastExtraAttackSpell == 0 means no extra attack is executing
    auto config = MakeConfig(true, SPELL_SWORD_SPECIALIZATION, 0);

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Extra attack proc should be allowed when no extra attack is in progress";
}

// =============================================================================
// Self-chain prevention
// =============================================================================

TEST_F(ExtraAttackChainProcTest, SelfChain_BlockedWhenSameSpell)
{
    // Sword Spec trying to proc during its own extra attack
    auto config = MakeConfig(true, SPELL_SWORD_SPECIALIZATION, SPELL_SWORD_SPECIALIZATION);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Extra attack spell should not chain-proc itself";
}

// =============================================================================
// Cross-chain prevention (blacklisted spells)
// =============================================================================

TEST_F(ExtraAttackChainProcTest, CrossChain_BlockedBySwordSpecialization)
{
    // Reckoning trying to proc during Sword Spec extra attack
    auto config = MakeConfig(true, SPELL_RECKONING, SPELL_SWORD_SPECIALIZATION);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Sword Specialization extra attack should block all other extra attack procs";
}

TEST_F(ExtraAttackChainProcTest, CrossChain_BlockedByHackAndSlash)
{
    // Reckoning trying to proc during Hack and Slash extra attack
    auto config = MakeConfig(true, SPELL_RECKONING, SPELL_HACK_AND_SLASH);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Hack and Slash extra attack should block all other extra attack procs";
}

// =============================================================================
// Non-blacklisted extra attacks allow cross-proccing
// =============================================================================

TEST_F(ExtraAttackChainProcTest, DifferentExtraAttack_AllowedWhenNotBlacklisted)
{
    // Sword Spec trying to proc during Hand of Justice extra attack
    // Hand of Justice (15601) is not blacklisted, so cross-proc is allowed
    auto config = MakeConfig(true, SPELL_SWORD_SPECIALIZATION, SPELL_HAND_OF_JUSTICE);

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Non-blacklisted extra attack spells should allow cross-proccing";
}

// =============================================================================
// Non-extra-attack procs unaffected
// =============================================================================

TEST_F(ExtraAttackChainProcTest, NonExtraAttackProc_UnaffectedByExtraAttackState)
{
    // A proc that does NOT grant extra attacks should never be blocked,
    // even during Sword Spec extra attack
    auto config = MakeConfig(false, 12345, SPELL_SWORD_SPECIALIZATION);

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Non-extra-attack procs should be unaffected by extra attack state";
}

// =============================================================================
// Real spell scenarios
// =============================================================================

TEST_F(ExtraAttackChainProcTest, Reckoning_SelfChainBlocked)
{
    // Reckoning (32746) trying to proc during its own extra attack
    auto config = MakeConfig(true, SPELL_RECKONING, SPELL_RECKONING);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Reckoning should not chain-proc itself";
}

TEST_F(ExtraAttackChainProcTest, Reckoning_AllowedDuringHandOfJustice)
{
    // Reckoning trying to proc during Hand of Justice extra attack
    // Hand of Justice is not blacklisted, so Reckoning is allowed
    auto config = MakeConfig(true, SPELL_RECKONING, SPELL_HAND_OF_JUSTICE);

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockExtraAttackChainProc(config))
        << "Reckoning should be allowed during Hand of Justice extra attack";
}
