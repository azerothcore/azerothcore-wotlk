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

#include "ConditionMgr.h"
#include "DBCStores.h"
#include "IntegrationTestFixture.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

/**
 * Skill conditions (CONDITION_SKILL) must survive a lowered MaxPlayerLevel.
 * Dropping one at load time removes the restriction it describes (loot,
 * gossip options, spells), so values up to the 3.3.5a maximum stay valid
 * while the player's real skill still decides at evaluation time.
 */
namespace
{
    constexpr uint32 SKILL_ENGINEERING_ID = 202;
    constexpr uint32 SKILL_UNKNOWN_ID = 65000;

    // GetConfigMaxSkillValue() for the given MaxPlayerLevel, as World computes it
    constexpr uint16 MaxSkillForCap(uint32 level)
    {
        return level > 60 ? 300 + ((level - 60) * 75) / 10 : level * 5;
    }

    void EnsureSkillLine(uint32 skillId)
    {
        if (sSkillLineStore.LookupEntry(skillId))
            return;

        auto* entry = new SkillLineEntry{};
        entry->id = skillId;
        sSkillLineStore.SetEntry(skillId, entry);
    }

    Condition MakeSkillCondition(uint32 skillId, uint32 value)
    {
        Condition cond;
        cond.SourceType = CONDITION_SOURCE_TYPE_SPELL;
        cond.ConditionType = CONDITION_SKILL;
        cond.ConditionValue1 = skillId;
        cond.ConditionValue2 = value;
        return cond;
    }
}

class SkillConditionValidationTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        EnsureSkillLine(SKILL_ENGINEERING_ID);

        _previousWorld = std::move(sWorld);
        _worldMock = new ::testing::NiceMock<WorldMock>();
        sWorld.reset(_worldMock);
        SetLevelCap(60);
    }

    void TearDown() override
    {
        sWorld = std::move(_previousWorld);
    }

    void SetLevelCap(uint32 level)
    {
        ON_CALL(*_worldMock, GetConfigMaxSkillValue()).WillByDefault(::testing::Return(MaxSkillForCap(level)));
    }

    static bool IsValid(uint32 skillId, uint32 value)
    {
        Condition cond = MakeSkillCondition(skillId, value);
        return sConditionMgr->isConditionTypeValid(&cond);
    }

    std::unique_ptr<IWorld> _previousWorld;
    ::testing::NiceMock<WorldMock>* _worldMock = nullptr;
};

TEST_F(SkillConditionValidationTest, WotlkValuesStayValidAtLevelCap60)
{
    // Skill values used by world database conditions, plus both ends of the range
    for (uint32 value : { 300u, 350u, 375u, 380u, 390u, 400u, 405u, 420u, 425u, 450u })
        EXPECT_TRUE(IsValid(SKILL_ENGINEERING_ID, value)) << "value " << value;
}

TEST_F(SkillConditionValidationTest, WotlkValuesStayValidAtLevelCap70And80)
{
    for (uint32 cap : { 70u, 80u })
    {
        SetLevelCap(cap);
        EXPECT_TRUE(IsValid(SKILL_ENGINEERING_ID, 425)) << "cap " << cap;
        EXPECT_TRUE(IsValid(SKILL_ENGINEERING_ID, 450)) << "cap " << cap;
        EXPECT_FALSE(IsValid(SKILL_ENGINEERING_ID, 451)) << "cap " << cap;
    }
}

TEST_F(SkillConditionValidationTest, ValuesAboveClientMaximumStayInvalid)
{
    EXPECT_FALSE(IsValid(SKILL_ENGINEERING_ID, 451));
    EXPECT_FALSE(IsValid(SKILL_ENGINEERING_ID, 1000));
}

TEST_F(SkillConditionValidationTest, LevelCapAbove80StillRaisesTheLimit)
{
    SetLevelCap(100);
    EXPECT_TRUE(IsValid(SKILL_ENGINEERING_ID, MaxSkillForCap(100)));
    EXPECT_FALSE(IsValid(SKILL_ENGINEERING_ID, MaxSkillForCap(100) + 1));
}

TEST_F(SkillConditionValidationTest, ZeroValueAndUnknownSkillStayInvalid)
{
    EXPECT_FALSE(IsValid(SKILL_ENGINEERING_ID, 0));
    EXPECT_FALSE(IsValid(SKILL_UNKNOWN_ID, 350));
}

class SkillConditionEvaluationTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();
        EnsureSkillLine(SKILL_ENGINEERING_ID);
        ON_CALL(*GetWorldMock(), GetConfigMaxSkillValue()).WillByDefault(::testing::Return(MaxSkillForCap(60)));
    }

    static bool Meets(Player* player, Condition& cond)
    {
        ConditionSourceInfo info(player);
        return cond.Meets(info);
    }
};

TEST_F(SkillConditionEvaluationTest, KeptConditionBlocksUntilSkillIsReached)
{
    TestPlayer* player = CreateTestPlayer();
    Condition cond = MakeSkillCondition(SKILL_ENGINEERING_ID, 350);
    ASSERT_TRUE(sConditionMgr->isConditionTypeValid(&cond));

    EXPECT_FALSE(Meets(player, cond)) << "player without the skill";

    player->SetSkill(SKILL_ENGINEERING_ID, 0, 300, 300);
    ASSERT_EQ(player->GetBaseSkillValue(SKILL_ENGINEERING_ID), 300);
    EXPECT_FALSE(Meets(player, cond)) << "skill at the level 60 maximum";

    player->SetSkill(SKILL_ENGINEERING_ID, 0, 350, 375);
    EXPECT_TRUE(Meets(player, cond)) << "skill reached";
}
