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

#include "ObjectMgr.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

/**
 * Quest RequiredSkillPoints up to the 3.3.5a maximum (450) are valid data no
 * matter how low MaxPlayerLevel is; the player's real skill still decides
 * whether the quest can be taken. Only values no player could ever reach are
 * rejected.
 */
class QuestRequiredSkillPointsTest : public ::testing::Test
{
protected:
    // GetConfigMaxSkillValue() for a MaxPlayerLevel, as World computes it
    static constexpr uint16 MaxSkillForCap(uint32 level)
    {
        return level > 60 ? 300 + ((level - 60) * 75) / 10 : level * 5;
    }

    void SetUp() override
    {
        _previousWorld = std::move(sWorld);
        _worldMock = new ::testing::NiceMock<WorldMock>();
        sWorld.reset(_worldMock);
    }

    void TearDown() override
    {
        sWorld = std::move(_previousWorld);
    }

    uint32 LimitForCap(uint32 level)
    {
        ON_CALL(*_worldMock, GetConfigMaxSkillValue()).WillByDefault(::testing::Return(MaxSkillForCap(level)));
        return ObjectMgr::GetMaxQuestRequiredSkillPoints();
    }

    std::unique_ptr<IWorld> _previousWorld;
    ::testing::NiceMock<WorldMock>* _worldMock = nullptr;
};

TEST_F(QuestRequiredSkillPointsTest, LimitIsTheWotlkMaximumAtCaps60To80)
{
    for (uint32 cap : { 60u, 70u, 80u })
        EXPECT_EQ(LimitForCap(cap), 450u) << "cap " << cap;
}

TEST_F(QuestRequiredSkillPointsTest, QuestValuesFromWorldDataFitAtCap60)
{
    // Values used by world database quests above the level 60 skill limit of 300
    uint32 const limit = LimitForCap(60);
    for (uint32 value : { 325u, 350u, 375u, 400u, 450u })
        EXPECT_LE(value, limit) << "value " << value;
}

TEST_F(QuestRequiredSkillPointsTest, ValuesAboveTheMaximumStayInvalid)
{
    for (uint32 cap : { 60u, 70u, 80u })
        EXPECT_GT(451u, LimitForCap(cap)) << "cap " << cap;
}

TEST_F(QuestRequiredSkillPointsTest, CapAbove80StillRaisesTheLimit)
{
    EXPECT_EQ(LimitForCap(100), MaxSkillForCap(100));
    EXPECT_GT(LimitForCap(100), 450u);
}
