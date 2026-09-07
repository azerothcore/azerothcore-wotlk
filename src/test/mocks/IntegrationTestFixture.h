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

#ifndef AZEROTHCORE_INTEGRATION_TEST_FIXTURE_H
#define AZEROTHCORE_INTEGRATION_TEST_FIXTURE_H

#include "Common.h"
#include "TestCreature.h"
#include "TestMap.h"
#include "TestPlayer.h"
#include "WorldMock.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <string>
#include <vector>

// Faction template IDs for test creatures
static constexpr uint32 TEST_FACTION_HOSTILE_TO_MONSTERS = 90001;
static constexpr uint32 TEST_FACTION_HOSTILE_TO_ALL      = 90002;

class IntegrationTestFixture : public ::testing::Test
{
protected:
    void SetUp() override;
    void TearDown() override;

    TestPlayer* CreateTestPlayer(ObjectGuid::LowType guidLow = 1, std::string const& name = "TestPlayer",
        AccountTypes security = SEC_PLAYER);
    TestCreature* CreateTestCreature(ObjectGuid::LowType guidLow, uint32 entry, uint32 factionId);

    ::testing::NiceMock<WorldMock>* GetWorldMock() { return _worldMock; }
    TestMap* GetTestMap() { return _testMap; }

private:
    static void EnsureFactionTemplates();

    IWorld* _originalWorld = nullptr;
    ::testing::NiceMock<WorldMock>* _worldMock = nullptr;
    TestMap* _testMap = nullptr;
    std::vector<TestPlayer*> _trackedPlayers;
    std::vector<TestCreature*> _trackedCreatures;
    std::vector<CreatureTemplate*> _ownedCreatureTemplates;
};

#endif //AZEROTHCORE_INTEGRATION_TEST_FIXTURE_H
