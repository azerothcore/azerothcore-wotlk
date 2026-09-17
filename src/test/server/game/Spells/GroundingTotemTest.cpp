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
#include "gtest/gtest.h"

TEST(GroundingTotemTest, SingleTargetSpellCanBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectImplicitTargets(EFFECT_0, TARGET_UNIT_TARGET_ENEMY)
        .BuildUnique();

    EXPECT_TRUE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, AreaTargetingSpellCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .WithEffectImplicitTargets(EFFECT_0, TARGET_UNIT_CASTER, TARGET_UNIT_SRC_AREA_ENEMY)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, PersistentAreaAuraCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithEffect(EFFECT_0, SPELL_EFFECT_PERSISTENT_AREA_AURA)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, AbilityCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithAttributes(SPELL_ATTR0_IS_ABILITY)
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, SpellWithNoRedirectionAttributeCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithAttributesEx(SPELL_ATTR1_NO_REDIRECTION)
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}

TEST(GroundingTotemTest, SpellIgnoringImmunitiesCannotBeRedirected)
{
    auto spellInfo = SpellInfoBuilder()
        .WithAttributes(SPELL_ATTR0_NO_IMMUNITIES)
        .WithEffect(EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->CanBeRedirectedBySpellMagnet());
}
