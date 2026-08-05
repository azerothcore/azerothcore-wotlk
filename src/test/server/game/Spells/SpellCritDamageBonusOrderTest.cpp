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

#include "Util.h"
#include "gtest/gtest.h"

/**
 * @brief Tests for melee/ranged spell crit damage ordering (issue #24976)
 *
 * The inline melee/ranged spell crit code in CalculateSpellDamageTaken applied
 * SPELLMOD_CRIT_DAMAGE_BONUS BEFORE aura percentage modifiers, causing aura
 * modifiers to amplify the already-talent-modified bonus. The correct order
 * (matching SpellCriticalDamageBonus) is:
 *
 *   1. Double damage (100% crit bonus for melee/ranged)
 *   2. Apply aura % modifiers to the full crit value
 *   3. Extract the bonus portion
 *   4. Apply SPELLMOD_CRIT_DAMAGE_BONUS to the bonus
 *   5. Recombine
 *
 * From the issue's expected blizzlike calculation:
 *   200% * 1.03 = 206%          (aura % first)
 *   206% - 100% = 106%          (extract bonus)
 *   106% * 140% = 148.4%        (talent mod on bonus)
 *   100% + 148.4% = 248.4%      (recombine)
 */

namespace
{

/**
 * Replicates the FIXED inline crit code (correct ordering,
 * matches SpellCriticalDamageBonus) for melee/ranged spells.
 *
 * @param damage      Base spell damage before crit
 * @param auraCritMod Aura crit % modifier (e.g. 3 for meta gem +3%)
 * @param spellModPct SPELLMOD_CRIT_DAMAGE_BONUS % (e.g. 40 for Mortal Shots)
 */
int32 CorrectCritOrder(int32 damage, float auraCritMod, float spellModPct)
{
    // Step 1: crit_bonus = 2x damage (100% bonus for melee/ranged)
    int32 crit_bonus = damage;
    crit_bonus += damage;

    // Step 2: Apply aura % modifiers FIRST
    if (crit_bonus != 0 && auraCritMod != 0.0f)
        AddPct(crit_bonus, auraCritMod);

    // Step 3: Extract bonus
    crit_bonus -= damage;

    // Step 4: Apply talent mod to the bonus
    AddPct(crit_bonus, spellModPct);

    // Step 5: Recombine
    return crit_bonus + damage;
}

/**
 * Replicates the OLD inline crit code (wrong ordering):
 * SPELLMOD_CRIT_DAMAGE_BONUS applied BEFORE aura % modifiers.
 */
int32 OldWrongCritOrder(int32 damage, float auraCritMod, float spellModPct)
{
    // OLD Step 1: talent mod on base bonus FIRST (wrong)
    uint32 crit_bonus = damage;
    AddPct(crit_bonus, spellModPct);
    int32 totalDamage = damage + static_cast<int32>(crit_bonus);

    // OLD Step 2: aura % on full total SECOND
    if (auraCritMod != 0.0f)
        AddPct(totalDamage, auraCritMod);

    return totalDamage;
}

} // namespace

class SpellCritDamageBonusOrderTest : public ::testing::Test {};

// No modifiers: both orderings produce 2x damage
TEST_F(SpellCritDamageBonusOrderTest, NoModifiers)
{
    EXPECT_EQ(CorrectCritOrder(1000, 0.0f, 0.0f), 2000);
    EXPECT_EQ(OldWrongCritOrder(1000, 0.0f, 0.0f), 2000);
}

// Only aura mod, no talent mod: both orderings match
TEST_F(SpellCritDamageBonusOrderTest, OnlyAuraMod)
{
    EXPECT_EQ(CorrectCritOrder(1000, 30.0f, 0.0f), 2600);
    EXPECT_EQ(OldWrongCritOrder(1000, 30.0f, 0.0f), 2600);
}

// Only talent mod, no aura mod: both orderings match
TEST_F(SpellCritDamageBonusOrderTest, OnlyTalentMod)
{
    // Correct: bonus = 2000-1000 = 1000, *1.03 = 1030, +1000 = 2030
    // Old: crit_bonus = 1000*1.03 = 1030, total = 2030
    EXPECT_EQ(CorrectCritOrder(1000, 0.0f, 3.0f), 2030);
    EXPECT_EQ(OldWrongCritOrder(1000, 0.0f, 3.0f), 2030);
}

// Issue #24976 exact scenario: Hunter Steady Shot with Fine Light Crossbow
//
//   damage = 320, meta gem = 3% aura, Mortal Shots etc = 40% SPELLMOD
//
//   Expected (blizzlike):
//     200% * 1.03 = 206%  →  640 * 1.03 = 659
//     206% - 100% = 106%  →  659 - 320  = 339
//     106% * 140% = 148.4% → 339 * 1.40 = 474
//     100% + 148.4%        → 320 + 474  = 794
//     (issue reports 795 from float math; integer truncation gives 794)
//
//   Old (wrong):
//     crit_bonus = 320 * 1.40 = 448
//     damage = 320 + 448 = 768
//     768 * 1.03 = 791
TEST_F(SpellCritDamageBonusOrderTest, Issue24976_HunterSteadyShot)
{
    int32 damage = 320;
    float auraMod = 3.0f;    // meta gem: +3% crit damage
    float talentMod = 40.0f; // Mortal Shots etc: +40% SPELLMOD_CRIT_DAMAGE_BONUS

    EXPECT_EQ(OldWrongCritOrder(damage, auraMod, talentMod), 791);
    EXPECT_EQ(CorrectCritOrder(damage, auraMod, talentMod), 794);
    EXPECT_GT(CorrectCritOrder(damage, auraMod, talentMod),
              OldWrongCritOrder(damage, auraMod, talentMod));
}

// Both modifiers with larger values: difference becomes more pronounced
TEST_F(SpellCritDamageBonusOrderTest, BothMods_LargerValues)
{
    int32 damage = 1000;
    float auraMod = 3.0f;
    float talentMod = 40.0f;

    // Correct: 2000*1.03=2060, bonus=1060, *1.40=1484, +1000=2484
    EXPECT_EQ(CorrectCritOrder(damage, auraMod, talentMod), 2484);

    // Wrong: 1000*1.40=1400, total=2400, *1.03=2472
    EXPECT_EQ(OldWrongCritOrder(damage, auraMod, talentMod), 2472);

    EXPECT_GT(CorrectCritOrder(damage, auraMod, talentMod),
              OldWrongCritOrder(damage, auraMod, talentMod));
}
