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

#include "WandCombatTestFixture.h"

namespace
{
class WandCombatTest : public WandCombatTestFixture
{
};

TEST_F(WandCombatTest, PredicateRequiresWeaponWandAndAutoRepeat)
{
    EXPECT_TRUE(_shoot->IsWandAutoAttack());
    _shoot->AttributesEx2 = 0;
    EXPECT_FALSE(_shoot->IsWandAutoAttack());
    _shoot->AttributesEx2 = SPELL_ATTR2_AUTO_REPEAT;
    _shoot->EquippedItemClass = ITEM_CLASS_ARMOR;
    EXPECT_FALSE(_shoot->IsWandAutoAttack());
    _shoot->EquippedItemClass = ITEM_CLASS_WEAPON;
    _shoot->EquippedItemSubClassMask = 1 << ITEM_SUBCLASS_WEAPON_BOW;
    EXPECT_FALSE(_shoot->IsWandAutoAttack());
    _shoot->EquippedItemSubClassMask |= 1 << ITEM_SUBCLASS_WEAPON_WAND;
    EXPECT_TRUE(_shoot->IsWandAutoAttack());
}

TEST_F(WandCombatTest, Level80SkillOneReachesSixtyPercentMissCap)
{
    EXPECT_FLOAT_EQ(MissChance(), 60.0f);
}

TEST_F(WandCombatTest, CappedSkillAgainstLevel83HasEightPercentMiss)
{
    SetWeaponSkill(400, 83);
    EXPECT_FLOAT_EQ(MissChance(), 8.0f);
}

TEST_F(WandCombatTest, OriginalLevelOneReproductionHasFivePointFourPercentMiss)
{
    _player->SetLevel(1);
    _player->SetSkill(SKILL_WANDS, 0, 1, 5);
    _victim->SetLevel(1);
    EXPECT_FLOAT_EQ(MissChance(), 5.4f);
}

TEST_F(WandCombatTest, SpellHitDoesNotChangeWandAccuracyButRangedHitDoes)
{
    SetWeaponSkill(400, 83);
    _player->m_modSpellHitChance = 20.0f;
    EXPECT_FLOAT_EQ(MissChance(), 8.0f);
    _player->m_modRangedHitChance = 3.0f;
    EXPECT_FLOAT_EQ(MissChance(), 5.0f);
    _player->m_modRangedHitChance = 20.0f;
    EXPECT_FLOAT_EQ(MissChance(), 0.0f);
}

TEST_F(WandCombatTest, ShootUsesRangedProcFlagsAndFireSchoolFromEquippedWand)
{
    WandTestSpell shot(_player, _shoot.get(), TRIGGERED_FULL_MASK);
    shot.prepareDataForTriggerSystem(nullptr);
    EXPECT_EQ(shot.m_attackType, RANGED_ATTACK);
    EXPECT_EQ(shot.GetSpellSchoolMask(), SPELL_SCHOOL_MASK_FIRE);
    EXPECT_EQ(shot.m_procAttacker, uint32(PROC_FLAG_DONE_RANGED_AUTO_ATTACK));
    EXPECT_EQ(shot.m_procVictim, uint32(PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK));
}

TEST_F(WandCombatTest, WandCritStillUsesSpellCrit)
{
    _player->SetFloatValue(uint16(PLAYER_SPELL_CRIT_PERCENTAGE1) + SPELL_SCHOOL_FIRE, 23.0f);
    _player->SetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE, 71.0f);
    EXPECT_FLOAT_EQ(_player->SpellDoneCritChance(_victim, _shoot.get(),
        SPELL_SCHOOL_MASK_FIRE, RANGED_ATTACK, false), 23.0f);
}

TEST_F(WandCombatTest, AutoShotAndThrowKeepTheirProcClassification)
{
    auto autoShot = MakeRangedSpell(75, ITEM_SUBCLASS_WEAPON_BOW, SPELL_DAMAGE_CLASS_RANGED, true);
    auto throwSpell = MakeRangedSpell(2764, ITEM_SUBCLASS_WEAPON_THROWN, SPELL_DAMAGE_CLASS_RANGED, false);
    EXPECT_FALSE(autoShot->IsWandAutoAttack());
    EXPECT_FALSE(throwSpell->IsWandAutoAttack());
    WandTestSpell shot(_player, autoShot.get(), TRIGGERED_FULL_MASK);
    shot.prepareDataForTriggerSystem(nullptr);
    EXPECT_EQ(shot.m_attackType, RANGED_ATTACK);
    EXPECT_EQ(shot.m_procAttacker, uint32(PROC_FLAG_DONE_RANGED_AUTO_ATTACK));
    WandTestSpell thrown(_player, throwSpell.get(), TRIGGERED_NONE);
    thrown.prepareDataForTriggerSystem(nullptr);
    EXPECT_EQ(thrown.m_attackType, RANGED_ATTACK);
    EXPECT_EQ(thrown.m_procAttacker, uint32(PROC_FLAG_DONE_SPELL_RANGED_DMG_CLASS));
}
}
