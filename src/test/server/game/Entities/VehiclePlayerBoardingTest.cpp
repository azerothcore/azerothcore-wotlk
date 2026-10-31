/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "DBCStores.h"
#include "IntegrationTestFixture.h"
#include "Vehicle.h"
#include "gtest/gtest.h"

namespace
{

class VehiclePlayerBoardingTest : public IntegrationTestFixture
{
protected:
    static constexpr uint32 TestVehicleId = 90010;
    static constexpr uint32 TestSeatId = 90011;

    TestPlayer* CreatePlayerWithVehicleKit()
    {
        static bool vehicleInitialized = false;
        if (!vehicleInitialized)
        {
            auto* seat = new VehicleSeatEntry{};
            seat->m_ID = TestSeatId;
            seat->m_flags = VEHICLE_SEAT_FLAG_CAN_ENTER_OR_EXIT;
            sVehicleSeatStore.SetEntry(TestSeatId, seat);

            auto* vehicle = new VehicleEntry{};
            vehicle->m_ID = TestVehicleId;
            vehicle->m_seatID[0] = TestSeatId;
            sVehicleStore.SetEntry(TestVehicleId, vehicle);
            vehicleInitialized = true;
        }

        TestPlayer* player = CreateTestPlayer();
        EXPECT_TRUE(player->CreateVehicleKit(TestVehicleId, 0));
        return player;
    }
};

// cppcheck-suppress syntaxError
TEST_F(VehiclePlayerBoardingTest, NewKitWithFreeSeatIsBoardable)
{
    TestPlayer* player = CreatePlayerWithVehicleKit();
    ASSERT_NE(player->GetVehicleKit(), nullptr);

    EXPECT_TRUE(player->GetVehicleKit()->IsBoardableByPlayers());
    EXPECT_TRUE(player->HasNpcFlag(UNIT_NPC_FLAG_PLAYER_VEHICLE));

    player->RemoveVehicleKit();
}

TEST_F(VehiclePlayerBoardingTest, DisablingBoardingRemovesPlayerVehicleFlag)
{
    TestPlayer* player = CreatePlayerWithVehicleKit();
    ASSERT_NE(player->GetVehicleKit(), nullptr);

    player->GetVehicleKit()->SetBoardableByPlayers(false);

    EXPECT_FALSE(player->GetVehicleKit()->IsBoardableByPlayers());
    EXPECT_FALSE(player->HasNpcFlag(UNIT_NPC_FLAG_PLAYER_VEHICLE));

    player->RemoveVehicleKit();
}

TEST_F(VehiclePlayerBoardingTest, ReenablingBoardingRestoresPlayerVehicleFlag)
{
    TestPlayer* player = CreatePlayerWithVehicleKit();
    ASSERT_NE(player->GetVehicleKit(), nullptr);

    player->GetVehicleKit()->SetBoardableByPlayers(false);
    player->GetVehicleKit()->SetBoardableByPlayers(true);

    EXPECT_TRUE(player->GetVehicleKit()->IsBoardableByPlayers());
    EXPECT_TRUE(player->HasNpcFlag(UNIT_NPC_FLAG_PLAYER_VEHICLE));

    player->RemoveVehicleKit();
}

TEST_F(VehiclePlayerBoardingTest, RemovingDisabledKitLeavesFlagCleared)
{
    TestPlayer* player = CreatePlayerWithVehicleKit();
    ASSERT_NE(player->GetVehicleKit(), nullptr);

    player->GetVehicleKit()->SetBoardableByPlayers(false);
    player->RemoveVehicleKit();

    EXPECT_EQ(player->GetVehicleKit(), nullptr);
    EXPECT_FALSE(player->HasNpcFlag(UNIT_NPC_FLAG_PLAYER_VEHICLE));
}

} // namespace
