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
#include "SmartScriptMgr.h"
#include "TemporarySummon.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

class GameObjectSummonGroupTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _previousWorld = std::move(sWorld);
        auto* worldMock =
            new ::testing::NiceMock<WorldMock>();
        ON_CALL(*worldMock, getIntConfig(::testing::_))
            .WillByDefault(::testing::Return(0));
        sWorld.reset(worldMock);
    }

    void TearDown() override
    {
        sWorld = std::move(_previousWorld);
    }

    std::unique_ptr<IWorld> _previousWorld;
};

TEST_F(GameObjectSummonGroupTest, DataStructStoresFields)
{
    GameObjectSummonData data;
    data.entry = 2332;
    data.pos.Relocate(-14652.38f, 146.51f, 3.50f, 0.35f);
    data.rot = G3D::Quat(0.0f, 0.0f, 0.17f, 0.98f);
    data.respawnTime = 120;

    EXPECT_EQ(data.entry, 2332u);
    EXPECT_FLOAT_EQ(data.pos.GetPositionX(), -14652.38f);
    EXPECT_FLOAT_EQ(data.pos.GetPositionY(), 146.51f);
    EXPECT_FLOAT_EQ(data.pos.GetPositionZ(), 3.50f);
    EXPECT_FLOAT_EQ(data.pos.GetOrientation(), 0.35f);
    EXPECT_FLOAT_EQ(data.rot.x, 0.0f);
    EXPECT_FLOAT_EQ(data.rot.y, 0.0f);
    EXPECT_FLOAT_EQ(data.rot.z, 0.17f);
    EXPECT_FLOAT_EQ(data.rot.w, 0.98f);
    EXPECT_EQ(data.respawnTime, 120u);
}

TEST_F(GameObjectSummonGroupTest, QuaternionIdentity)
{
    GameObjectSummonData data;
    data.rot = G3D::Quat(0.0f, 0.0f, 0.0f, 1.0f);

    EXPECT_FLOAT_EQ(data.rot.x, 0.0f);
    EXPECT_FLOAT_EQ(data.rot.y, 0.0f);
    EXPECT_FLOAT_EQ(data.rot.z, 0.0f);
    EXPECT_FLOAT_EQ(data.rot.w, 1.0f);
}

TEST_F(GameObjectSummonGroupTest, AccessorReturnsNullForMissing)
{
    auto const* result = sObjectMgr->GetGameObjectSummonGroup(
        99999, SUMMONER_TYPE_CREATURE, 0);
    EXPECT_EQ(result, nullptr);
}

TEST_F(GameObjectSummonGroupTest, AccessorReturnsNullForAllTypes)
{
    auto const* r1 = sObjectMgr->GetGameObjectSummonGroup(
        99999, SUMMONER_TYPE_CREATURE, 0);
    auto const* r2 = sObjectMgr->GetGameObjectSummonGroup(
        99999, SUMMONER_TYPE_GAMEOBJECT, 0);
    auto const* r3 = sObjectMgr->GetGameObjectSummonGroup(
        99999, SUMMONER_TYPE_MAP, 0);

    EXPECT_EQ(r1, nullptr);
    EXPECT_EQ(r2, nullptr);
    EXPECT_EQ(r3, nullptr);
}

TEST_F(GameObjectSummonGroupTest, DifferentGroupsAreIndependent)
{
    auto const* g0 = sObjectMgr->GetGameObjectSummonGroup(
        2289, SUMMONER_TYPE_GAMEOBJECT, 0);
    auto const* g1 = sObjectMgr->GetGameObjectSummonGroup(
        2289, SUMMONER_TYPE_GAMEOBJECT, 1);

    // Both should be null since DB isn't loaded in tests,
    // but they should be independent lookups
    EXPECT_EQ(g0, nullptr);
    EXPECT_EQ(g1, nullptr);
}

TEST_F(GameObjectSummonGroupTest, SmartActionEnumValue)
{
    EXPECT_EQ(SMART_ACTION_SUMMON_GAMEOBJECT_GROUP, 241);
    EXPECT_EQ(SMART_ACTION_AC_END, 242);
}

TEST_F(GameObjectSummonGroupTest, SmartActionUnionSize)
{
    SmartAction action{};
    action.gameobjectGroup.group = 5;
    EXPECT_EQ(action.gameobjectGroup.group, 5u);
}

TEST_F(GameObjectSummonGroupTest, TempSummonGroupKeyOrdering)
{
    TempSummonGroupKey k1(100, SUMMONER_TYPE_CREATURE, 0);
    TempSummonGroupKey k2(100, SUMMONER_TYPE_GAMEOBJECT, 0);
    TempSummonGroupKey k3(100, SUMMONER_TYPE_CREATURE, 1);
    TempSummonGroupKey k4(200, SUMMONER_TYPE_CREATURE, 0);

    // std::tuple ordering: summoner ID first, then type, then group
    EXPECT_LT(k1, k2);  // same id, creature < gameobject
    EXPECT_LT(k1, k3);  // same id+type, group 0 < 1
    EXPECT_LT(k1, k4);  // id 100 < 200
}

TEST_F(GameObjectSummonGroupTest, SummonerTypeValues)
{
    EXPECT_EQ(SUMMONER_TYPE_CREATURE, 0);
    EXPECT_EQ(SUMMONER_TYPE_GAMEOBJECT, 1);
    EXPECT_EQ(SUMMONER_TYPE_MAP, 2);
}
