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
#include "SpellMgr.h"
#include "SharedDefines.h"
#include "gtest/gtest.h"

/**
 * @brief Tests for IsBinarySpell, the binary spell classification used by
 *        SpellMgr::LoadSpellInfoCustomAttributes.
 *
 * A spell is binary, all-or-nothing instead of partially resisted, when it has an effect with a value that
 * shares its implicit targets with one of its damage effects. A spell without damage effects is binary as
 * soon as one effect has a value, which is the polymorph, fear and root case.
 *
 * An effect has a value when CalcValue() is non-zero, or when the spell is an interrupt or breaks stealth
 * and does not have NO_IMMUNITIES. Dummy, script, heal, force-cast, knockback and trigger effects never make
 * a spell binary, and neither do SPELL_ATTR3_ALWAYS_HIT or SPELL_ATTR0_CU_IGNORE_BINARY.
 */

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

    EXPECT_TRUE(IsBinarySpell(*spell));
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

    EXPECT_FALSE(IsBinarySpell(*spell));
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

    EXPECT_TRUE(IsBinarySpell(*spell));
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

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// Fear-like spell: APPLY_AURA MOD_FEAR with BasePoints=-1, DieSides=1
// CalcValue = -1 + 1 = 0, but the second effect has one
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

    EXPECT_TRUE(IsBinarySpell(*spell));
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

    EXPECT_TRUE(IsBinarySpell(*spell));
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

    EXPECT_TRUE(IsBinarySpell(*spell));
}

// Damage and a slow on the same unit target
TEST_F(BinarySpellDetectionTest, DamageAndSlowOnSameTarget_IsBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithEffect(1, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_DECREASE_SPEED)
        .WithEffectBasePoints(1, 0)
        .WithEffectDieSides(1, 1)
        .WithEffectImplicitTargets(1, TARGET_UNIT_TARGET_ENEMY)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_TRUE(IsBinarySpell(*spell));
}

// The same pair, but the slow lands on another target: a self buff next to a nuke is not binary
TEST_F(BinarySpellDetectionTest, DamageAndSlowOnDifferentTarget_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithEffect(1, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_DECREASE_SPEED)
        .WithEffectBasePoints(1, 0)
        .WithEffectDieSides(1, 1)
        .WithEffectImplicitTargets(1, TARGET_UNIT_CASTER_AREA_PARTY)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// A knockback is not resistable, so it must not turn an otherwise plain nuke binary
TEST_F(BinarySpellDetectionTest, DamageAndKnockBack_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_CONE_ENEMY_24)
        .WithEffect(1, SPELL_EFFECT_KNOCK_BACK)
        .WithEffectBasePoints(1, 0)
        .WithEffectDieSides(1, 1)
        .WithEffectImplicitTargets(1, TARGET_UNIT_CONE_ENEMY_24)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// Dummy effects are script hooks and never make a spell binary, even with a value
TEST_F(BinarySpellDetectionTest, DamageAndDummyEffect_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithEffect(1, SPELL_EFFECT_DUMMY)
        .WithEffectBasePoints(1, 10)
        .WithEffectDieSides(1, 1)
        .WithEffectImplicitTargets(1, TARGET_UNIT_TARGET_ENEMY)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// A trigger spell with a value is not a resistable effect on its own
TEST_F(BinarySpellDetectionTest, TriggerSpellEffectOnly_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_TRIGGER_SPELL_WITH_VALUE)
        .WithEffectBasePoints(0, 10)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// SPELL_ATTR0_CU_IGNORE_BINARY wins over the classification
TEST_F(BinarySpellDetectionTest, IgnoreBinaryOverride_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithEffect(1, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_DECREASE_SPEED)
        .WithEffectBasePoints(1, 0)
        .WithEffectDieSides(1, 1)
        .WithEffectImplicitTargets(1, TARGET_UNIT_TARGET_ENEMY)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    spell->AttributesCu |= SPELL_ATTR0_CU_IGNORE_BINARY;

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// SPELL_ATTR3_ALWAYS_HIT spells cannot be resisted at all, so they are never binary
TEST_F(BinarySpellDetectionTest, AlwaysHit_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithEffect(1, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_DECREASE_SPEED)
        .WithEffectBasePoints(1, 0)
        .WithEffectDieSides(1, 1)
        .WithEffectImplicitTargets(1, TARGET_UNIT_TARGET_ENEMY)
        .WithAttributesEx3(SPELL_ATTR3_ALWAYS_HIT)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_FALSE(IsBinarySpell(*spell));
}

// Pure damage takes graded resists, it is not binary
TEST_F(BinarySpellDetectionTest, PureDamage_NotBinary)
{
    auto spell = SpellInfoBuilder()
        .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectBasePoints(0, 0)
        .WithEffectDieSides(0, 1)
        .WithEffectImplicitTargets(0, TARGET_UNIT_TARGET_ENEMY)
        .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
        .BuildUnique();

    EXPECT_FALSE(IsBinarySpell(*spell));
}
