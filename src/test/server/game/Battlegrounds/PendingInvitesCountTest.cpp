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

#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "BattlegroundQueue.h"
#include "ObjectGuid.h"
#include "ScriptMgr.h"
#include "ScriptDefines/AllBattlegroundScript.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

/**
 * Tests BattlegroundQueue::GetPendingInvitesCount: only unanswered invites
 * to instances of the queried bracket that have not started yet count.
 */
class PendingInvitesCountTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        // AddBattleground and ~Battleground fire BG hooks, the registry must be sized first
        ScriptRegistry<BGScript>::InitEnabledHooksIfNeeded(ALLBATTLEGROUNDHOOK_END);

        previousWorld_ = std::move(sWorld);
        worldMock_ = new ::testing::NiceMock<WorldMock>();
        ON_CALL(*worldMock_, getIntConfig(::testing::_))
            .WillByDefault(::testing::Return(0));
        sWorld.reset(worldMock_);
    }

    void TearDown() override
    {
        sWorld = std::move(previousWorld_);
    }

    // ~Battleground deregisters the instance
    static void RegisterInstance(Battleground& bg, uint32 instanceId, BattlegroundTypeId typeId,
        BattlegroundStatus status)
    {
        bg.SetBgTypeID(typeId);
        bg.SetInstanceID(instanceId);
        bg.SetStatus(status);
        sBattlegroundMgr->AddBattleground(&bg);
    }

    // the queue destructor deletes the group
    void AddQueuedGroup(BattlegroundQueue& queue, BattlegroundBracketId bracket, BattlegroundQueueGroupTypes list,
        uint32 invitedInstanceId, BattlegroundTypeId bgTypeId, uint32 playerCount)
    {
        auto* ginfo = new GroupQueueInfo();
        ginfo->IsInvitedToBGInstanceGUID = invitedInstanceId;
        ginfo->BgTypeId = bgTypeId;
        ginfo->BracketId = bracket;
        ginfo->GroupType = list;

        for (uint32 i = 0; i < playerCount; ++i)
            ginfo->Players.emplace(ObjectGuid::Create<HighGuid::Player>(nextGuid_++));

        queue.m_QueuedGroups[bracket][list].push_back(ginfo);
    }

    ::testing::NiceMock<WorldMock>* worldMock_ = nullptr;
    std::unique_ptr<IWorld> previousWorld_;
    uint32 nextGuid_ = 1;
};

TEST_F(PendingInvitesCountTest, EmptyBracketReturnsZero)
{
    BattlegroundQueue queue;

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
}

TEST_F(PendingInvitesCountTest, UninvitedGroupsDoNotCount)
{
    BattlegroundQueue queue;
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_NORMAL_ALLIANCE, 0, BATTLEGROUND_WS, 2);
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 0, BATTLEGROUND_WS, 3);

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
}

TEST_F(PendingInvitesCountTest, InvitesToLiveInstanceCountRemainingMembers)
{
    Battleground bg;
    RegisterInstance(bg, 900001, BATTLEGROUND_WS, STATUS_WAIT_JOIN);

    BattlegroundQueue queue;
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_NORMAL_ALLIANCE, 900001, BATTLEGROUND_WS, 2);
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 900001, BATTLEGROUND_WS, 1);
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 0, BATTLEGROUND_WS, 4);

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 3u);
}

TEST_F(PendingInvitesCountTest, InvitesToInProgressInstanceDoNotCount)
{
    Battleground bg;
    RegisterInstance(bg, 900002, BATTLEGROUND_WS, STATUS_IN_PROGRESS);

    BattlegroundQueue queue;
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 900002, BATTLEGROUND_WS, 1);

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
}

TEST_F(PendingInvitesCountTest, InvitesToEndingInstanceDoNotCount)
{
    Battleground bg;
    RegisterInstance(bg, 900003, BATTLEGROUND_WS, STATUS_WAIT_LEAVE);

    BattlegroundQueue queue;
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 900003, BATTLEGROUND_WS, 2);

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
}

TEST_F(PendingInvitesCountTest, InvitesToUnknownInstanceDoNotCount)
{
    BattlegroundQueue queue;
    AddQueuedGroup(queue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 900004, BATTLEGROUND_WS, 2);

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
}

TEST_F(PendingInvitesCountTest, LookupUsesGroupBgTypeId)
{
    Battleground bg;
    RegisterInstance(bg, 900005, BATTLEGROUND_RB, STATUS_WAIT_JOIN);

    BattlegroundQueue rbQueue;
    AddQueuedGroup(rbQueue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 900005, BATTLEGROUND_RB, 1);
    EXPECT_EQ(rbQueue.GetPendingInvitesCount(BattlegroundBracketId(0)), 1u);

    BattlegroundQueue wsQueue;
    AddQueuedGroup(wsQueue, BattlegroundBracketId(0), BG_QUEUE_CFBG, 900005, BATTLEGROUND_WS, 1);
    EXPECT_EQ(wsQueue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
}

TEST_F(PendingInvitesCountTest, OtherBracketInvitesDoNotCount)
{
    Battleground bg;
    RegisterInstance(bg, 900006, BATTLEGROUND_WS, STATUS_WAIT_JOIN);

    BattlegroundQueue queue;
    AddQueuedGroup(queue, BattlegroundBracketId(1), BG_QUEUE_CFBG, 900006, BATTLEGROUND_WS, 2);

    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(0)), 0u);
    EXPECT_EQ(queue.GetPendingInvitesCount(BattlegroundBracketId(1)), 2u);
}
