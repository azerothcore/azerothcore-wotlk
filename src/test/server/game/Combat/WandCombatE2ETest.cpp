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

#include <cmath>

namespace
{
// Endpoints are Spell::prepare and the resulting health/skill changes, in process.
// This deliberately does not claim coverage of sockets, authentication or client packets.
class WandCombatE2ETest : public WandCombatTestFixture
{
protected:
    struct ShotResult
    {
        SpellMissInfo miss;
        uint32 damage;
        uint32 skillBefore;
        uint32 skillAfter;
    };

    ShotResult Fire()
    {
        _victim->SetHealth(_victim->GetMaxHealth());
        uint32 healthBefore = _victim->GetHealth();
        uint32 skillBefore = _player->GetBaseSkillValue(_weapon->GetSkill());
        SpellCastTargets targets;
        targets.SetUnitTarget(_victim);
        // This is the same per-shot entry point used by Unit::_UpdateAutoRepeatSpell.
        // Do not use skipCheck: it also forces every hit roll to succeed.
        auto* spell = new Spell(_player, _shoot.get(), TRIGGERED_FULL_MASK);
        // prepare() tolerates failed checks for auto-repeat controllers. Require a valid
        // individual shot here, including the equipped weapon and ammunition checks.
        spell->InitExplicitTargets(targets);
        SpellCastResult check = spell->CheckCast(true);
        if (check != SPELL_CAST_OK)
        {
            ADD_FAILURE() << "Shot failed cast checks: " << check;
            delete spell;
            return { SPELL_MISS_EVADE, 0, skillBefore, skillBefore };
        }
        EXPECT_EQ(spell->prepare(&targets), SPELL_CAST_OK);
        auto const& targetInfo = *spell->GetUniqueTargetInfo();
        if (targetInfo.size() != 1)
        {
            ADD_FAILURE() << "Expected exactly one resolved shot target, got " << targetInfo.size();
            _player->m_Events.Update(1);
            return { SPELL_MISS_EVADE, 0, skillBefore, skillBefore };
        }
        EXPECT_TRUE(targetInfo.front().processed);
        ShotResult result{ targetInfo.front().missCondition, healthBefore - _victim->GetHealth(),
            skillBefore, _player->GetBaseSkillValue(_weapon->GetSkill()) };
        _player->m_Events.Update(1);
        return result;
    }

    void ExpectMissRate(double expectedPercent)
    {
        // Disable gains only for rate sampling. Skill progression has its own test.
        ON_CALL(*GetWorldMock(), getIntConfig(CONFIG_SKILL_GAIN_WEAPON)).WillByDefault(Return(0));
        constexpr uint32 shots = 20000;
        uint32 misses = 0;
        uint32 hits = 0;
        for (uint32 i = 0; i < shots; ++i)
        {
            ShotResult result = Fire();
            ASSERT_FALSE(HasFailure()) << "Shot " << i;
            ASSERT_EQ(result.skillBefore, result.skillAfter);
            if (result.miss == SPELL_MISS_MISS)
            {
                ++misses;
                ASSERT_EQ(result.damage, 0u);
            }
            else
            {
                ASSERT_EQ(result.miss, SPELL_MISS_NONE) << "Unexpected combat outcome on shot " << i;
                ++hits;
                ASSERT_GT(result.damage, 0u) << "A successful cast is not sufficient evidence of a hit";
            }
        }
        double percent = 100.0 * misses / shots;
        // Six standard deviations, with allowance for the inclusive 0..10000 roll.
        double tolerance = 6.0 * std::sqrt(expectedPercent * (100.0 - expectedPercent) / shots) + 0.02;
        EXPECT_NEAR(percent, expectedPercent, tolerance);
        RecordProperty("shots", shots);
        RecordProperty("misses", misses);
        RecordProperty("hits", hits);
        RecordProperty("miss_percent", std::to_string(percent));
    }
};

TEST_F(WandCombatE2ETest, SkillOneAgainstLevel80MissesSixtyPercent)
{
    ExpectMissRate(60.0);
}

TEST_F(WandCombatE2ETest, Skill400AgainstLevel83MissesEightPercent)
{
    SetWeaponSkill(400, 83);
    ExpectMissRate(8.0);
}

TEST_F(WandCombatE2ETest, MissesAtTheCapStillIncreaseWandSkill)
{
    uint32 missesWithGain = 0;
    uint32 hitsWithGain = 0;
    for (uint32 i = 0; i < 100; ++i)
    {
        // Restore the exact low-skill condition for each trial, avoiding drift off the cap.
        SetWeaponSkill(1);
        ASSERT_FLOAT_EQ(MissChance(), 60.0f);
        ShotResult result = Fire();
        ASSERT_FALSE(HasFailure());
        ASSERT_EQ(result.skillBefore, 1u);
        // At this level/skill difference the production skill-up chance exceeds 100%.
        ASSERT_EQ(result.skillAfter, 2u);
        if (result.miss == SPELL_MISS_MISS)
        {
            ASSERT_EQ(result.damage, 0u);
            ++missesWithGain;
        }
        else
        {
            ASSERT_EQ(result.miss, SPELL_MISS_NONE);
            ASSERT_GT(result.damage, 0u);
            ++hitsWithGain;
        }
    }
    EXPECT_GT(missesWithGain, 0u);
    EXPECT_GT(hitsWithGain, 0u);
    RecordProperty("misses_with_skill_gain", missesWithGain);
    RecordProperty("hits_with_skill_gain", hitsWithGain);
}

TEST_F(WandCombatE2ETest, SpellOnlyHitBonusDoesNotImproveWandAccuracy)
{
    SetWeaponSkill(400, 83);
    ApplyHitItem(ITEM_MOD_HIT_SPELL_RATING, 20);
    ASSERT_GT(_player->m_modSpellHitChance, 0.0f);
    ASSERT_FLOAT_EQ(_player->m_modRangedHitChance, 0.0f);
    ExpectMissRate(8.0);
}

TEST_F(WandCombatE2ETest, AutoRepeatFiresAgainAndStopsWhenInterrupted)
{
    SpellCastTargets targets;
    targets.SetUnitTarget(_victim);
    auto* autoRepeat = new Spell(_player, _shoot.get(), TRIGGERED_NONE);
    ASSERT_EQ(autoRepeat->prepare(&targets), SPELL_CAST_OK);
    ASSERT_EQ(_player->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL), autoRepeat);
    ASSERT_EQ(_player->GetBaseSkillValue(SKILL_WANDS), 1u);

    // The first update starts the wand's 500 ms initial delay.
    _player->setAttackTimer(RANGED_ATTACK, 0);
    _player->_UpdateAutoRepeatSpell();
    EXPECT_EQ(_player->getAttackTimer(RANGED_ATTACK), 500u);
    EXPECT_EQ(_player->GetBaseSkillValue(SKILL_WANDS), 1u);

    for (uint32 i = 0; i < 20; ++i)
    {
        // Advance to the next swing without sleeping or running unrelated map updates.
        _player->setAttackTimer(RANGED_ATTACK, 0);
        _player->_UpdateAutoRepeatSpell();
        ASSERT_EQ(_player->GetBaseSkillValue(SKILL_WANDS), i + 2);
        ASSERT_GT(_player->getAttackTimer(RANGED_ATTACK), 0u);
        ASSERT_EQ(_player->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL), autoRepeat);
        _player->m_Events.Update(1);
    }

    _player->InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
    ASSERT_EQ(_player->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL), nullptr);
    _player->setAttackTimer(RANGED_ATTACK, 0);
    _player->_UpdateAutoRepeatSpell();
    EXPECT_EQ(_player->GetBaseSkillValue(SKILL_WANDS), 21u);
}

TEST_F(WandCombatE2ETest, GenericHitRatingGearStillImprovesWandAccuracy)
{
    SetWeaponSkill(400, 83);
    ApplyHitItem(ITEM_MOD_HIT_RATING, 3);
    ASSERT_GT(_player->m_modSpellHitChance, 0.0f);
    ASSERT_GT(_player->m_modRangedHitChance, 0.0f);
    // Fixture DBC omits rating conversions, giving the core's default multiplier of one.
    ASSERT_FLOAT_EQ(_player->m_modRangedHitChance, 3.0f);
    ExpectMissRate(5.0);
}

TEST_F(WandCombatE2ETest, RangedHitBonusStillImprovesWandAccuracy)
{
    SetWeaponSkill(400, 83);
    _player->m_modRangedHitChance = 3.0f;
    ExpectMissRate(5.0);
}

TEST_F(WandCombatE2ETest, HunterAutoShotKeepsRangedAccuracy)
{
    _player->SetByteValue(UNIT_FIELD_BYTES_0, 1, CLASS_HUNTER);
    _weaponTemplate.SubClass = ITEM_SUBCLASS_WEAPON_BOW;
    _weaponTemplate.Damage[0].DamageType = SPELL_SCHOOL_NORMAL;
    _shoot = MakeRangedSpell(75, ITEM_SUBCLASS_WEAPON_BOW, SPELL_DAMAGE_CLASS_RANGED, true);
    _shoot->RangeEntry = &_range;
    SetWeaponSkill(400, 83);
    _player->m_modSpellHitChance = 20.0f;
    ExpectMissRate(8.0);
}

TEST_F(WandCombatE2ETest, ThrowKeepsRangedAccuracy)
{
    _player->SetByteValue(UNIT_FIELD_BYTES_0, 1, CLASS_HUNTER);
    _weaponTemplate.SubClass = ITEM_SUBCLASS_WEAPON_THROWN;
    _weaponTemplate.InventoryType = INVTYPE_THROWN;
    _weaponTemplate.Damage[0].DamageType = SPELL_SCHOOL_NORMAL;
    _shoot = MakeRangedSpell(2764, ITEM_SUBCLASS_WEAPON_THROWN, SPELL_DAMAGE_CLASS_RANGED, false);
    _shoot->RangeEntry = &_range;
    SetWeaponSkill(400, 83);
    _player->m_modSpellHitChance = 20.0f;
    ExpectMissRate(8.0);
}

TEST_F(WandCombatE2ETest, SpellInfoOverloadAlsoUsesWandSkill)
{
    // Spell::AddUnitTarget uses the Spell overload. Cover the other public entry separately.
    uint32 misses = 0;
    constexpr uint32 shots = 20000;
    for (uint32 i = 0; i < shots; ++i)
    {
        SpellMissInfo miss = _player->SpellHitResult(_victim, _shoot.get());
        ASSERT_TRUE(miss == SPELL_MISS_NONE || miss == SPELL_MISS_MISS);
        misses += miss == SPELL_MISS_MISS;
    }
    EXPECT_NEAR(100.0 * misses / shots, 60.0, 2.1);
}
}
