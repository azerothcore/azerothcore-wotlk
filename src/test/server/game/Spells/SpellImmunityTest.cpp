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
 * @file SpellImmunityTest.cpp
 * @brief Tests for spell immunity mechanics
 */

#include "gtest/gtest.h"

#include <algorithm>
#include <array>
#include <cstdint>
#include "Unit.h"  // needed for SpellSchoolMask and mask helper

namespace
{
    enum EffectType : uint8_t
    {
        EFFECT_NONE,
        EFFECT_SCHOOL_DAMAGE,
        EFFECT_HEALTH_LEECH,
        EFFECT_POWER_DRAIN,
        EFFECT_POWER_BURN,
        EFFECT_NORMALIZED_WEAPON_DMG,
        EFFECT_WEAPON_PERCENT_DAMAGE,
        EFFECT_APPLY_AURA,
        EFFECT_DUMMY
    };

    enum AuraType : uint8_t
    {
        AURA_NONE,
        AURA_MOD_DECREASE_SPEED,
        AURA_PERIODIC_DAMAGE,
        AURA_TRANSFORM,
        AURA_MOD_STUN
    };

    struct EffectDesc
    {
        EffectType effect = EFFECT_NONE;
        AuraType aura = AURA_NONE;
    };

    struct SpellDesc
    {
        std::array<EffectDesc, 3> effects{};
    };

    bool IsDamageEffect(EffectType effect)
    {
        switch (effect)
        {
            case EFFECT_SCHOOL_DAMAGE:
            case EFFECT_HEALTH_LEECH:
            case EFFECT_POWER_DRAIN:
            case EFFECT_POWER_BURN:
            case EFFECT_NORMALIZED_WEAPON_DMG:
            case EFFECT_WEAPON_PERCENT_DAMAGE:
                return true;
            default:
                return false;
        }
    }

    bool HasOnlyDamageEffects(SpellDesc const& spell)
    {
        bool hasAny = std::ranges::any_of(spell.effects, [](EffectDesc const& effect)
        {
            return effect.effect != EFFECT_NONE;
        });

        return hasAny && std::ranges::all_of(spell.effects, [](EffectDesc const& effect)
        {
            return effect.effect == EFFECT_NONE || IsDamageEffect(effect.effect);
        });
    }

    // Helper to classify spells which apply a stun aura
    bool IsStunSpell(SpellDesc const& spell)
    {
        return std::ranges::any_of(spell.effects, [](EffectDesc const& effect)
        {
            return effect.effect == EFFECT_APPLY_AURA && effect.aura == AURA_MOD_STUN;
        });
    }

    bool IsEffectBlockedByStunImmunity(EffectDesc const& effect, bool immuneToStun)
    {
        if (!immuneToStun)
            return false;

        return effect.effect == EFFECT_APPLY_AURA && effect.aura == AURA_MOD_STUN;
    }

    bool IsFullyImmunedByStunImmunity(SpellDesc const& spell, bool immuneToStun)
    {
        bool hasAnyEffect = false;

        for (EffectDesc const& effect : spell.effects)
        {
            if (effect.effect == EFFECT_NONE)
                continue;

            hasAnyEffect = true;
            if (!IsEffectBlockedByStunImmunity(effect, immuneToStun))
                return false;
        }

        return hasAnyEffect;
    }

    bool IsBlockedBySchoolImmunity(bool casterFriendly, bool immunityAppliesToFriendly)
    {
        return !casterFriendly || immunityAppliesToFriendly;
    }

    // The last parameter defaults to false to avoid updating existing tests
    // that don't care about mechanic immunities.  Bladestorm grants a
    // specific mechanic immunity (including stun) that should block
    // a spell like Lethargy.
    SpellMissInfo ComputeSpellHitResult(bool isImmunedToSpell, bool isImmunedToDamage,
                                       SpellDesc const& spell, bool immuneToStun = false)
    {
        // Mirrors current core ordering:
        // 1) full spell immunity check
        // 2) full immunity from mechanic immunity (all effects blocked)
        // 3) damage immunity only for damage-only spells
        if (isImmunedToSpell)
            return SPELL_MISS_IMMUNE;

        if (IsFullyImmunedByStunImmunity(spell, immuneToStun))
            return SPELL_MISS_IMMUNE;

        if (HasOnlyDamageEffects(spell) && isImmunedToDamage)
            return SPELL_MISS_IMMUNE;

        return SPELL_MISS_NONE;
    }

    struct EffectApplyResult
    {
        bool damageApplied = false;
        bool slowApplied = false;
    };

    EffectApplyResult ApplyEffectsWithMovementImmunity(SpellDesc const& spell, bool immuneToMovementImpairing)
    {
        EffectApplyResult result;

        for (EffectDesc const& e : spell.effects)
        {
            if (e.effect == EFFECT_NONE)
                continue;

            if (IsDamageEffect(e.effect))
                result.damageApplied = true;

            if (e.effect == EFFECT_APPLY_AURA && e.aura == AURA_MOD_DECREASE_SPEED)
            {
                if (!immuneToMovementImpairing)
                    result.slowApplied = true;
            }
        }

        return result;
    }

    SpellDesc MakeDamageOnlySpell()
    {
        SpellDesc spell;
        spell.effects[0] = { EFFECT_SCHOOL_DAMAGE, AURA_NONE };
        return spell;
    }

    SpellDesc MakeFrostboltLikeSpell()
    {
        SpellDesc spell;
        spell.effects[0] = { EFFECT_SCHOOL_DAMAGE, AURA_NONE };
        spell.effects[1] = { EFFECT_APPLY_AURA, AURA_MOD_DECREASE_SPEED };
        return spell;
    }

    SpellDesc MakeCycloneLikeSpell()
    {
        SpellDesc spell;
        spell.effects[0] = { EFFECT_APPLY_AURA, AURA_TRANSFORM };
        return spell;
    }

    SpellDesc MakeSlowOnlySpell()
    {
        // represents effects such as Frost Trap or Desecration, which only slow
        SpellDesc spell;
        spell.effects[0] = { EFFECT_APPLY_AURA, AURA_MOD_DECREASE_SPEED };
        return spell;
    }
}

TEST(SpellImmunityTest, HasOnlyDamageEffects_TrueForPureDamage)
{
    SpellDesc spell = MakeDamageOnlySpell();
    EXPECT_TRUE(HasOnlyDamageEffects(spell));
}

TEST(SpellImmunityTest, HasOnlyDamageEffects_FalseForDamagePlusAura)
{
    SpellDesc spell = MakeFrostboltLikeSpell();
    EXPECT_FALSE(HasOnlyDamageEffects(spell));
}

TEST(SpellImmunityTest, SpellImmunity_BlocksAllSpells)
{
    SpellDesc damageOnly = MakeDamageOnlySpell();
    SpellDesc cycloneLike = MakeCycloneLikeSpell();

    EXPECT_EQ(ComputeSpellHitResult(true, false, damageOnly), SPELL_MISS_IMMUNE);
    EXPECT_EQ(ComputeSpellHitResult(true, false, cycloneLike), SPELL_MISS_IMMUNE);
}

TEST(SpellImmunityTest, DamageImmunity_BlocksDamageOnlySpell)
{
    SpellDesc damageOnly = MakeDamageOnlySpell();

    EXPECT_EQ(ComputeSpellHitResult(false, true, damageOnly), SPELL_MISS_IMMUNE);
}

// Specific case for spell ID 16621 "Self Invulnerability".
// This aura grants immunity to melee/physical damage only.  A rogue
// using Sinister Strike (a physical melee attack) should be completely
// blocked by the effect.  The test uses the same simplified damage-only
// spell description as above but documents the physical context.
TEST(SpellImmunityTest, SelfInvulnerability_BlocksMeleeDamage)
{
    SpellDesc meleeAttack = MakeDamageOnlySpell();
    // simulate physical damage coming from a rogue melee ability

    EXPECT_EQ(ComputeSpellHitResult(false, true, meleeAttack), SPELL_MISS_IMMUNE);
}

TEST(SpellImmunityTest, DamageImmunity_DoesNotMissMixedSpell)
{
    // This is the key fix: damage immunity must not force SPELL_MISS_IMMUNE
    // for mixed spells that include non-damage effects.
    SpellDesc frostboltLike = MakeFrostboltLikeSpell();

    EXPECT_EQ(ComputeSpellHitResult(false, true, frostboltLike), SPELL_MISS_NONE);
}

TEST(SpellImmunityTest, HandOfFreedomStyle_MovementImmunity_AllowsDamageBlocksSlow)
{
    SpellDesc frostboltLike = MakeFrostboltLikeSpell();

    EffectApplyResult result = ApplyEffectsWithMovementImmunity(frostboltLike, true);

    EXPECT_TRUE(result.damageApplied);
    EXPECT_FALSE(result.slowApplied);
}

TEST(SpellImmunityTest, NoMovementImmunity_FrostboltStyle_AppliesDamageAndSlow)
{
    SpellDesc frostboltLike = MakeFrostboltLikeSpell();

    EffectApplyResult result = ApplyEffectsWithMovementImmunity(frostboltLike, false);

    EXPECT_TRUE(result.damageApplied);
    EXPECT_TRUE(result.slowApplied);
}

TEST(SpellImmunityTest, CycloneLikeSpell_DivineShieldStyle_Immune)
{
    SpellDesc cycloneLike = MakeCycloneLikeSpell();

    EXPECT_EQ(ComputeSpellHitResult(true, false, cycloneLike), SPELL_MISS_IMMUNE);
}

// Regression test for issue #10671:
// Divine Shield (full spell immunity) should block purely slowing spells
// such as Hunter Frost Trap or DK Desecration.  Previously the effect was
// applied because the core only checked damage-only spells when deciding
// immunity based on damage or spell state.
TEST(SpellImmunityTest, SpellImmunity_BlocksSlowOnlySpell)
{
    SpellDesc slowOnly = MakeSlowOnlySpell();
    EXPECT_EQ(ComputeSpellHitResult(true, false, slowOnly), SPELL_MISS_IMMUNE);
}

// Ensure that damage-only immunity (e.g. from Hand of Protection) does not
// accidentally prevent slow-only spells.  This covers the regression when
// Divine Shield was incorrectly modelled as damage immunity only.
TEST(SpellImmunityTest, DamageImmunity_DoesNotBlockSlowOnlySpell)
{
    SpellDesc slowOnly = MakeSlowOnlySpell();
    EXPECT_EQ(ComputeSpellHitResult(false, true, slowOnly), SPELL_MISS_NONE);
}

// New coverage for school-mask logic.  These exercises the helper used by
// Unit::IsImmunedToDamage to ensure broad masks are handled correctly.
TEST(SpellImmunityTest, ImmunityMask_PartialOverlapDoesNotCount)
{
    SpellSchoolMask immune = SPELL_SCHOOL_MASK_FROST;
    SpellSchoolMask checkAll = SPELL_SCHOOL_MASK_ALL;

    // a frost-only immunity should *not* make you immune to all damage
    EXPECT_FALSE(Unit::IsImmuneMaskFully(immune, checkAll));
}

TEST(SpellImmunityTest, ImmunityMask_FullCoverageAccepted)
{
    SpellSchoolMask immune = SPELL_SCHOOL_MASK_MAGIC; // holy+spell
    SpellSchoolMask checkMagic = SPELL_SCHOOL_MASK_MAGIC;
    SpellSchoolMask checkSpell = SPELL_SCHOOL_MASK_SPELL;

    EXPECT_TRUE(Unit::IsImmuneMaskFully(immune, checkMagic));
    EXPECT_TRUE(Unit::IsImmuneMaskFully(immune, checkSpell));
}

TEST(SpellImmunityTest, ImmunityMask_SupersetMatches)
{
    SpellSchoolMask immune = SPELL_SCHOOL_MASK_ALL;
    SpellSchoolMask checkMagic = SPELL_SCHOOL_MASK_MAGIC;

    EXPECT_TRUE(Unit::IsImmuneMaskFully(immune, checkMagic));
}

// Bladestorm grants a mechanic immunity mask which includes stuns (e.g.
// Lethargy 69133).  The following test mirrors that behaviour by
// modelling a simple spell that applies a stun aura and exercising the
// new `immuneToStun` flag in ComputeSpellHitResult.
TEST(SpellImmunityTest, Bladestorm_ImmuneToStun)
{
    SpellDesc stunSpell;
    stunSpell.effects[0] = {EFFECT_APPLY_AURA, AURA_MOD_STUN};

    // without any special immunity the stun should land
    EXPECT_EQ(ComputeSpellHitResult(false, false, stunSpell), SPELL_MISS_NONE);

    // with a bladestorm‑style stun immunity it is blocked
    EXPECT_EQ(ComputeSpellHitResult(false, false, stunSpell, true), SPELL_MISS_IMMUNE);
}

TEST(SpellImmunityTest, StunImmunity_DoesNotFullyBlockMixedSpell)
{
    SpellDesc mixedSpell;
    mixedSpell.effects[0] = { EFFECT_SCHOOL_DAMAGE, AURA_NONE };
    mixedSpell.effects[1] = { EFFECT_APPLY_AURA, AURA_MOD_STUN };

    // This models partial immunity: stun effect is blocked, damage still hits.
    EXPECT_TRUE(IsStunSpell(mixedSpell));
    EXPECT_EQ(ComputeSpellHitResult(false, false, mixedSpell, true), SPELL_MISS_NONE);
}

TEST(SpellImmunityTest, SchoolImmunity_TemplateStyle_AllowsFriendlySpell)
{
    EXPECT_FALSE(IsBlockedBySchoolImmunity(true, false));
}

TEST(SpellImmunityTest, SchoolImmunity_ExplicitFriendlyBlockStillApplies)
{
    EXPECT_TRUE(IsBlockedBySchoolImmunity(true, true));
}

TEST(SpellImmunityTest, SchoolImmunity_BlocksHostileSpell)
{
    EXPECT_TRUE(IsBlockedBySchoolImmunity(false, false));
}
