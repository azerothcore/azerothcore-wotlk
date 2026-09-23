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

#include "IntegrationTestFixture.h"
#include "gtest/gtest.h"

// A SetCanFly change made while the player is feared/confused never reaches its own client,
// so it must be replayed through the client-controlled path once control returns.
class PlayerCanFlyControlLossTest : public IntegrationTestFixture
{
protected:
    TestPlayer* CreateControlledPlayer()
    {
        TestPlayer* player = CreateTestPlayer(1, "CanFlyTest", SEC_PLAYER);
        player->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);

        // keep the order counter away from 0 so pending flight change checks are meaningful
        for (uint8 i = 0; i < 3; ++i)
            player->GetSession()->IncrementOrderCounter();

        return player;
    }

    void ExpectRevokeReplayedAfter(UnitFlags ccFlag)
    {
        TestPlayer* player = CreateControlledPlayer();
        WorldSession* session = player->GetSession();
        player->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
        player->SetUnitFlag(ccFlag);

        uint32 const counter = session->GetOrderCounter();
        player->SetCanFly(false);

        EXPECT_FALSE(player->HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY));
        EXPECT_EQ(session->GetOrderCounter(), counter); // nothing sent to the own client
        ASSERT_TRUE(player->GetPendingCanFlyResync().has_value());
        EXPECT_FALSE(*player->GetPendingCanFlyResync());

        player->RemoveUnitFlag(ccFlag);
        player->ResyncCanFlyToClient();

        EXPECT_EQ(session->GetOrderCounter(), counter + 1);
        EXPECT_EQ(player->GetPendingFlightChange(), counter);
        EXPECT_FALSE(player->GetPendingCanFlyResync().has_value());

        player->ResyncCanFlyToClient();
        EXPECT_EQ(session->GetOrderCounter(), counter + 1); // replayed only once
    }
};

TEST_F(PlayerCanFlyControlLossTest, RevokeDuringFearIsReplayed)
{
    ExpectRevokeReplayedAfter(UNIT_FLAG_FLEEING);
}

TEST_F(PlayerCanFlyControlLossTest, RevokeDuringConfuseIsReplayed)
{
    ExpectRevokeReplayedAfter(UNIT_FLAG_CONFUSED);
}

TEST_F(PlayerCanFlyControlLossTest, GrantDuringFearIsReplayed)
{
    TestPlayer* player = CreateControlledPlayer();
    WorldSession* session = player->GetSession();
    player->SetUnitFlag(UNIT_FLAG_FLEEING);

    uint32 const counter = session->GetOrderCounter();
    player->SetCanFly(true);

    ASSERT_TRUE(player->GetPendingCanFlyResync().has_value());
    EXPECT_TRUE(*player->GetPendingCanFlyResync());
    EXPECT_EQ(session->GetOrderCounter(), counter);

    player->RemoveUnitFlag(UNIT_FLAG_FLEEING);
    player->ResyncCanFlyToClient();

    EXPECT_EQ(session->GetOrderCounter(), counter + 1);
    EXPECT_EQ(player->GetPendingFlightChange(), counter);
    EXPECT_FALSE(player->GetPendingCanFlyResync().has_value());
}

TEST_F(PlayerCanFlyControlLossTest, NoReplayWhileStillOutOfControl)
{
    TestPlayer* player = CreateControlledPlayer();
    WorldSession* session = player->GetSession();
    player->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
    player->SetUnitFlag(UNIT_FLAG_FLEEING);

    uint32 const counter = session->GetOrderCounter();
    player->SetCanFly(false);

    // fear ends, but a confuse still holds control
    player->RemoveUnitFlag(UNIT_FLAG_FLEEING);
    player->SetUnitFlag(UNIT_FLAG_CONFUSED);
    player->ResyncCanFlyToClient();

    EXPECT_EQ(session->GetOrderCounter(), counter);
    EXPECT_TRUE(player->GetPendingCanFlyResync().has_value());

    player->RemoveUnitFlag(UNIT_FLAG_CONFUSED);
    player->ResyncCanFlyToClient();

    EXPECT_EQ(session->GetOrderCounter(), counter + 1);
    EXPECT_EQ(player->GetPendingFlightChange(), counter);
    EXPECT_FALSE(player->GetPendingCanFlyResync().has_value());
}

TEST_F(PlayerCanFlyControlLossTest, NoReplayWhileFearIsQueuedBehindConfuse)
{
    TestPlayer* player = CreateControlledPlayer();
    WorldSession* session = player->GetSession();
    player->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
    player->SetUnitFlag(UNIT_FLAG_CONFUSED);
    player->AddUnitState(UNIT_STATE_FLEEING);

    uint32 const counter = session->GetOrderCounter();
    player->SetCanFly(false);

    // confuse ends, the queued fear takes over next
    player->RemoveUnitFlag(UNIT_FLAG_CONFUSED);
    player->ResyncCanFlyToClient();

    EXPECT_EQ(session->GetOrderCounter(), counter);
    EXPECT_TRUE(player->GetPendingCanFlyResync().has_value());

    player->ClearUnitState(UNIT_STATE_FLEEING);
    player->ResyncCanFlyToClient();

    EXPECT_EQ(session->GetOrderCounter(), counter + 1);
    EXPECT_EQ(player->GetPendingFlightChange(), counter);
    EXPECT_FALSE(player->GetPendingCanFlyResync().has_value());
}

TEST_F(PlayerCanFlyControlLossTest, DirectChangeSupersedesPendingReplay)
{
    TestPlayer* player = CreateControlledPlayer();
    WorldSession* session = player->GetSession();
    player->AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
    player->SetUnitFlag(UNIT_FLAG_FLEEING);
    player->SetCanFly(false);
    player->RemoveUnitFlag(UNIT_FLAG_FLEEING);

    uint32 const counter = session->GetOrderCounter();
    player->SetCanFly(true);

    EXPECT_EQ(session->GetOrderCounter(), counter + 1);
    EXPECT_FALSE(player->GetPendingCanFlyResync().has_value());

    player->ResyncCanFlyToClient();
    EXPECT_EQ(session->GetOrderCounter(), counter + 1);
}

TEST_F(PlayerCanFlyControlLossTest, NothingRecordedWhileInControl)
{
    TestPlayer* player = CreateControlledPlayer();
    WorldSession* session = player->GetSession();

    uint32 const counter = session->GetOrderCounter();
    player->SetCanFly(false);

    EXPECT_EQ(session->GetOrderCounter(), counter + 1);
    EXPECT_EQ(player->GetPendingFlightChange(), counter);
    EXPECT_FALSE(player->GetPendingCanFlyResync().has_value());
}
