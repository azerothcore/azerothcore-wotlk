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

#include "Group.h"
#include "IntegrationTestFixture.h"
#include "gtest/gtest.h"

namespace
{

class PlayerCharmAIIntegrationTest : public IntegrationTestFixture
{
protected:
    void PreparePlayer(TestPlayer* player, uint32 faction)
    {
        static constexpr uint32 TestDisplayId = 90003;
        static constexpr uint32 TestModelId = 90003;
        static bool modelInitialized = false;
        if (!modelInitialized)
        {
            auto* displayInfo = new CreatureDisplayInfoEntry{};
            displayInfo->Displayid = TestDisplayId;
            displayInfo->ModelId = TestModelId;
            displayInfo->scale = 1.0f;
            sCreatureDisplayInfoStore.SetEntry(TestDisplayId, displayInfo);

            auto* modelData = new CreatureModelDataEntry{};
            modelData->Id = TestModelId;
            modelData->Scale = 1.0f;
            modelData->CollisionWidth = 1.0f;
            modelData->CollisionHeight = 2.0f;
            sCreatureModelDataStore.SetEntry(TestModelId, modelData);
            modelInitialized = true;
        }

        player->SetFaction(faction);
        player->SetNativeDisplayId(TestDisplayId);
        player->SetDisplayId(TestDisplayId);
        player->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
        player->SetMaxHealth(1000);
        player->SetHealth(1000);
        player->Relocate(0.0f, 0.0f, 0.0f, 0.0f);
    }
};

// cppcheck-suppress syntaxError
TEST_F(PlayerCharmAIIntegrationTest, CreatureControlledPlayerSelectsHostileGroupMember)
{
    Group group;
    TestPlayer* charmedPlayer = CreateTestPlayer(1, "CharmedPlayer");
    TestPlayer* groupMember = CreateTestPlayer(2, "GroupMember");

    PreparePlayer(charmedPlayer, TEST_FACTION_HOSTILE_TO_ALL);
    PreparePlayer(groupMember, TEST_FACTION_HOSTILE_TO_MONSTERS);
    charmedPlayer->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    charmedPlayer->SetGroup(&group, 0);
    groupMember->SetGroup(&group, 0);

    ASSERT_TRUE(charmedPlayer->IsHostileTo(groupMember));
    ASSERT_TRUE(charmedPlayer->IsValidAttackTarget(groupMember));
    EXPECT_EQ(charmedPlayer->TestSelectCharmedAIGroupTarget(100.0f), groupMember);
}

// cppcheck-suppress syntaxError
TEST_F(PlayerCharmAIIntegrationTest, CreatureControlledPlayerSelectsClosestHostileGroupMember)
{
    Group group;
    TestPlayer* charmedPlayer = CreateTestPlayer(1, "CharmedPlayer");
    TestPlayer* nearbyMember = CreateTestPlayer(2, "NearbyMember");
    TestPlayer* distantMember = CreateTestPlayer(3, "DistantMember");

    PreparePlayer(charmedPlayer, TEST_FACTION_HOSTILE_TO_ALL);
    PreparePlayer(nearbyMember, TEST_FACTION_HOSTILE_TO_MONSTERS);
    PreparePlayer(distantMember, TEST_FACTION_HOSTILE_TO_MONSTERS);
    charmedPlayer->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    nearbyMember->Relocate(5.0f, 0.0f, 0.0f, 0.0f);
    distantMember->Relocate(20.0f, 0.0f, 0.0f, 0.0f);
    charmedPlayer->SetGroup(&group, 0);
    nearbyMember->SetGroup(&group, 0);
    distantMember->SetGroup(&group, 0);

    ASSERT_EQ(group.GetFirstMember()->GetSource(), distantMember);
    EXPECT_EQ(charmedPlayer->TestSelectCharmedAIGroupTarget(100.0f), nearbyMember);
}

// cppcheck-suppress syntaxError
TEST_F(PlayerCharmAIIntegrationTest, CreatureControlledPlayerRejectsInvalidGroupMembers)
{
    Group group;
    TestPlayer* charmedPlayer = CreateTestPlayer(1, "CharmedPlayer");
    TestPlayer* friendlyMember = CreateTestPlayer(2, "FriendlyMember");
    TestPlayer* distantMember = CreateTestPlayer(3, "DistantMember");

    PreparePlayer(charmedPlayer, TEST_FACTION_HOSTILE_TO_ALL);
    PreparePlayer(friendlyMember, TEST_FACTION_HOSTILE_TO_ALL);
    PreparePlayer(distantMember, TEST_FACTION_HOSTILE_TO_MONSTERS);
    charmedPlayer->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    distantMember->Relocate(150.0f, 0.0f, 0.0f, 0.0f);
    charmedPlayer->SetGroup(&group, 0);
    friendlyMember->SetGroup(&group, 0);
    distantMember->SetGroup(&group, 0);

    EXPECT_EQ(charmedPlayer->TestSelectCharmedAIGroupTarget(100.0f), nullptr);
}

} // namespace
