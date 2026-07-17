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

#include "Player.h"
#include "gtest/gtest.h"

TEST(SpellModifierTest, SmallerCriticalChanceBonusStacksAfterGuaranteedCrit)
{
    SpellModifier juggernaut;
    juggernaut.op = SPELLMOD_CRITICAL_CHANCE;
    juggernaut.value = 25;

    EXPECT_FALSE(juggernaut.ShouldSkipGuaranteedCriticalChanceMod(100));
}

TEST(SpellModifierTest, SecondGuaranteedCriticalChanceModifierIsSkipped)
{
    SpellModifier guaranteedCrit;
    guaranteedCrit.op = SPELLMOD_CRITICAL_CHANCE;
    guaranteedCrit.value = 100;

    EXPECT_TRUE(guaranteedCrit.ShouldSkipGuaranteedCriticalChanceMod(100));
}

TEST(SpellModifierTest, GuaranteedCriticalChanceModifierAppliesBelowThreshold)
{
    SpellModifier guaranteedCrit;
    guaranteedCrit.op = SPELLMOD_CRITICAL_CHANCE;
    guaranteedCrit.value = 100;

    EXPECT_FALSE(guaranteedCrit.ShouldSkipGuaranteedCriticalChanceMod(99));
}

TEST(SpellModifierTest, NonCriticalChanceModifierIsNeverSkipped)
{
    SpellModifier damageModifier;
    damageModifier.op = SPELLMOD_DAMAGE;
    damageModifier.value = 100;

    EXPECT_FALSE(damageModifier.ShouldSkipGuaranteedCriticalChanceMod(100));
}
