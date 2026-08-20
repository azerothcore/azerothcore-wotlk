/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CharmInfo.h"
#include "ReputationMgr.h"
#include "IntegrationTestFixture.h"
#include "PassiveAI.h"
#include "gtest/gtest.h"

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

namespace
{

class UnitReactionIntegrationTest : public IntegrationTestFixture
{
protected:
    void SetPlayerController(TestPlayer* driver, TestCreature* controlled)
    {
        controlled->AIM_Initialize(new NullCreatureAI(controlled));
        controlled->InitCharmInfo()->InitEmptyActionBar();
        // The reaction logic only needs the common player-control state. Convert avoids
        // pet action-bar and follow movement setup that the lightweight TestMap cannot provide.
        ASSERT_TRUE(controlled->SetCharmedBy(driver, CHARM_TYPE_CONVERT));
    }

    void ClearPlayerController(TestPlayer* driver, TestCreature* controlled)
    {
        controlled->RemoveCharmedBy(driver);
    }
};

TEST_F(UnitReactionIntegrationTest, NeutralDriverKeepsExplicitlyFriendlyVehicleReaction)
{
    TestPlayer* driver = CreateTestPlayer();
    driver->SetFaction(TEST_FACTION_HOSTILE_TO_MONSTERS);

    TestCreature* soldier = CreateTestCreature(100, 99001, TEST_FACTION_WITH_REPUTATION);
    TestCreature* vehicle = CreateTestCreature(101, 99002, TEST_FACTION_FRIENDLY_VEHICLE);
    vehicle->SetVehicleForTest(true);
    SetPlayerController(driver, vehicle);

    ASSERT_EQ(vehicle->GetOldFactionId(), TEST_FACTION_FRIENDLY_VEHICLE);
    ASSERT_EQ(vehicle->GetFaction(), driver->GetFaction());
    ASSERT_EQ(driver->GetReputationRank(TEST_FACTION_WITH_REPUTATION), REP_NEUTRAL);
    EXPECT_EQ(soldier->GetReactionTo(vehicle), REP_FRIENDLY);
    EXPECT_TRUE(soldier->IsFriendlyTo(vehicle));

    ClearPlayerController(driver, vehicle);
}

TEST_F(UnitReactionIntegrationTest, NeutralDriverStillControlsNonVehicleReaction)
{
    TestPlayer* driver = CreateTestPlayer();
    driver->SetFaction(TEST_FACTION_HOSTILE_TO_MONSTERS);

    TestCreature* soldier = CreateTestCreature(100, 99001, TEST_FACTION_WITH_REPUTATION);
    TestCreature* charmedCreature = CreateTestCreature(101, 99002, TEST_FACTION_FRIENDLY_VEHICLE);
    SetPlayerController(driver, charmedCreature);

    EXPECT_EQ(soldier->GetReactionTo(charmedCreature), REP_NEUTRAL);
    EXPECT_FALSE(soldier->IsFriendlyTo(charmedCreature));

    ClearPlayerController(driver, charmedCreature);
}

TEST_F(UnitReactionIntegrationTest, NeutralDriverDoesNotMakeUnrelatedVehicleFriendly)
{
    TestPlayer* driver = CreateTestPlayer();
    driver->SetFaction(TEST_FACTION_HOSTILE_TO_MONSTERS);

    TestCreature* soldier = CreateTestCreature(100, 99001, TEST_FACTION_WITH_REPUTATION);
    TestCreature* vehicle = CreateTestCreature(101, 99002, TEST_FACTION_HOSTILE_TO_MONSTERS);
    vehicle->SetVehicleForTest(true);
    SetPlayerController(driver, vehicle);

    EXPECT_EQ(soldier->GetReactionTo(vehicle), REP_NEUTRAL);
    EXPECT_FALSE(soldier->IsFriendlyTo(vehicle));

    ClearPlayerController(driver, vehicle);
}

TEST_F(UnitReactionIntegrationTest, AtWarDriverDoesNotGainFriendlyVehicleReaction)
{
    TestPlayer* driver = CreateTestPlayer();
    driver->SetFaction(TEST_FACTION_HOSTILE_TO_MONSTERS);
    driver->GetReputationMgr().LoadFromDB(nullptr);
    driver->GetReputationMgr().SetAtWar(TEST_REPUTATION_LIST_ID, true);

    TestCreature* soldier = CreateTestCreature(100, 99001, TEST_FACTION_WITH_REPUTATION);
    TestCreature* vehicle = CreateTestCreature(101, 99002, TEST_FACTION_FRIENDLY_VEHICLE);
    vehicle->SetVehicleForTest(true);
    SetPlayerController(driver, vehicle);

    ASSERT_TRUE(driver->GetReputationMgr().IsAtWar(TEST_FACTION_WITH_REPUTATION));
    EXPECT_EQ(soldier->GetReactionTo(vehicle), REP_NEUTRAL);
    EXPECT_FALSE(soldier->IsFriendlyTo(vehicle));

    ClearPlayerController(driver, vehicle);
}

TEST_F(UnitReactionIntegrationTest, ForcedHostilityOverridesFriendlyVehicleFaction)
{
    TestPlayer* driver = CreateTestPlayer();
    driver->SetFaction(TEST_FACTION_HOSTILE_TO_MONSTERS);
    driver->GetReputationMgr().ApplyForceReaction(TEST_FACTION_WITH_REPUTATION, REP_HOSTILE, true);

    TestCreature* soldier = CreateTestCreature(100, 99001, TEST_FACTION_WITH_REPUTATION);
    TestCreature* vehicle = CreateTestCreature(101, 99002, TEST_FACTION_FRIENDLY_VEHICLE);
    vehicle->SetVehicleForTest(true);
    SetPlayerController(driver, vehicle);

    EXPECT_EQ(soldier->GetReactionTo(vehicle), REP_HOSTILE);
    EXPECT_TRUE(soldier->IsHostileTo(vehicle));

    ClearPlayerController(driver, vehicle);
}

} // namespace
