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

#include "SpellInfoTestHelper.h"
#include "SpellInfo.h"
#include "SharedDefines.h"
#include "gtest/gtest.h"

/**
 * @brief Tests for the binary spell detection condition used in
 *        SpellMgr::LoadSpellInfoCustomAttributes.
 *
 * The condition determines whether a non-damage aura effect should mark
 * a spell as binary (fully resistable via spell resistance).
 *
 * Correct logic: CalcValue() || ((INTERRUPT_CAST || DONT_BREAK_STEALTH) && !NO_IMMUNITIES)
 *
 * A spell should be marked binary if:
 * - Its effect has a non-zero CalcValue (e.g. Fear, Polymorph, Frost Nova), OR
 * - It is an interrupt/stealth spell without the NO_IMMUNITIES attribute
 */

namespace
{
    // Replicates the binary detection condition from SpellMgr.cpp
    // Returns true if the effect should mark the spell as binary
    bool ShouldMarkBinary(SpellInfo const* spellInfo, uint8 effIndex)
    {
        return spellInfo->Effects[effIndex].CalcValue() ||
            ((spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_INTERRUPT_CAST ||
              spellInfo->HasAttribute(SPELL_ATTR0_CU_DONT_BREAK_STEALTH)) &&
             !spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES));
    }
}

class BinarySpellDetectionTest : public ::testing::Test
{
protected:
    void SetUp() override {}
};

// CC aura with non-zero CalcValue should be binary (e.g. Fear, Polymorph)
TEST_F(BinarySpellDetectionTest, AuraWithCalcValue_IsBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_FEAR)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1) // CalcValue = 0 + 1 = 1
        .WithSchoolMask(SPELL_SCHOOL_MASK_SHADOW)
        .BuildUnique();

    EXPECT_TRUE(ShouldMarkBinary(spell.get(), 0));
}

// Aura with zero CalcValue and no special attributes should NOT be binary
TEST_F(BinarySpellDetectionTest, AuraWithZeroCalcValue_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_FEAR)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 0) // CalcValue = 0
        .WithSchoolMask(SPELL_SCHOOL_MASK_SHADOW)
        .BuildUnique();

    EXPECT_FALSE(ShouldMarkBinary(spell.get(), 0));
}

// INTERRUPT_CAST effect without NO_IMMUNITIES should be binary
TEST_F(BinarySpellDetectionTest, InterruptCast_IsBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_INTERRUPT_CAST)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 0) // CalcValue = 0
        .WithSchoolMask(SPELL_SCHOOL_MASK_SHADOW)
        .BuildUnique();

    EXPECT_TRUE(ShouldMarkBinary(spell.get(), 0));
}

// INTERRUPT_CAST with NO_IMMUNITIES should NOT be binary
TEST_F(BinarySpellDetectionTest, InterruptCastWithNoImmunities_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_INTERRUPT_CAST)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 0)
        .WithAttributes(SPELL_ATTR0_NO_IMMUNITIES)
        .WithSchoolMask(SPELL_SCHOOL_MASK_SHADOW)
        .BuildUnique();

    EXPECT_FALSE(ShouldMarkBinary(spell.get(), 0));
}

// Fear-like spell: APPLY_AURA MOD_FEAR with BasePoints=-1, DieSides=1
// CalcValue = -1 + 1 = 0, but second effect has value
TEST_F(BinarySpellDetectionTest, FearLikeSpell_SecondEffectHasValue_IsBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_FEAR)
        .WithEffectBasePoints(0, -1)
        .WithEffectDieSides(0, 1) // CalcValue = -1 + 1 = 0
        .WithEffect(1, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_INCREASE_SPEED)
        .WithEffectBasePoints(1, 24)
        .WithEffectDieSides(1, 1) // CalcValue = 24 + 1 = 25
        .WithSchoolMask(SPELL_SCHOOL_MASK_SHADOW)
        .BuildUnique();

    // Effect 0 has CalcValue 0, should not mark binary
    EXPECT_FALSE(ShouldMarkBinary(spell.get(), 0));
    // Effect 1 has CalcValue 25, should mark binary
    EXPECT_TRUE(ShouldMarkBinary(spell.get(), 1));
}

// Polymorph-like: APPLY_AURA MOD_CONFUSE with positive BasePoints
TEST_F(BinarySpellDetectionTest, PolymorphLikeSpell_IsBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_CONFUSE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1) // CalcValue = 1
        .WithSchoolMask(SPELL_SCHOOL_MASK_ARCANE)
        .BuildUnique();

    EXPECT_TRUE(ShouldMarkBinary(spell.get(), 0));
}

// Frost Nova-like: APPLY_AURA MOD_ROOT with positive BasePoints
TEST_F(BinarySpellDetectionTest, FrostNovaLikeSpell_IsBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_ROOT)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1) // CalcValue = 1
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_TRUE(ShouldMarkBinary(spell.get(), 0));
}
