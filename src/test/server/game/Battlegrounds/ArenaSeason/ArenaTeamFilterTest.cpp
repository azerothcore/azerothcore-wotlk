/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Define.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "ArenaTeamFilter.h"
#include "ArenaTeamMgr.h"
#include "ArenaTeam.h"
#include <memory>

// Used to expose Type property.
class ArenaTeamTest : public ArenaTeam
{
public:
    void SetType(uint8 type)
    {
        Type = type;
    }
};

ArenaTeam* ArenaTeamWithType(uint8 type)
{
    ArenaTeamTest* team = new ArenaTeamTest();
    team->SetType(type);
    return team;
}

// Fixture for ArenaTeamFilter tests
class ArenaTeamFilterTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        team1 = ArenaTeamWithType(2); // 2v2
        team2 = ArenaTeamWithType(3); // 3v3
        team3 = ArenaTeamWithType(5); // 5v5

        arenaTeams[1] = team1;
        arenaTeams[2] = team2;
        arenaTeams[3] = team3;
    }

    void TearDown() override
    {
        delete team1;
        delete team2;
        delete team3;
    }

    ArenaTeamMgr::ArenaTeamContainer arenaTeams;
    ArenaTeam* team1;
    ArenaTeam* team2;
    ArenaTeam* team3;
};

// Test for ArenaTeamFilterAllTeams: it should return all teams without filtering
TEST_F(ArenaTeamFilterTest, AllTeamsFilter)
{
    ArenaTeamFilterAllTeams filter;
    ArenaTeamMgr::ArenaTeamContainer result = filter.Filter(arenaTeams);

    EXPECT_EQ(result.size(), arenaTeams.size());
    EXPECT_EQ(result[1], team1);
    EXPECT_EQ(result[2], team2);
    EXPECT_EQ(result[3], team3);
}

// Test for ArenaTeamFilterByTypes: should filter only teams matching the provided types
TEST_F(ArenaTeamFilterTest, FilterBySpecificTypes)
{
    std::vector<uint8> validTypes = {2, 3}; // Filtering for 2v2 and 3v3
    ArenaTeamFilterByTypes filter(validTypes);

    ArenaTeamMgr::ArenaTeamContainer result = filter.Filter(arenaTeams);

    EXPECT_EQ(result.size(), 2);           // Only 2v2 and 3v3 should pass
    EXPECT_EQ(result[1], team1);           // team1 is 2v2
    EXPECT_EQ(result[2], team2);           // team2 is 3v3
    EXPECT_EQ(result.find(3), result.end()); // team3 (5v5) should be filtered out
}

// Test for ArenaTeamFilterFactoryByUserInput: should create the correct filter based on input
TEST_F(ArenaTeamFilterTest, FabricCreatesFilterByInput)
{
    ArenaTeamFilterFactoryByUserInput fabric;

    // Test for "all" input
    auto allTeamsFilter = fabric.CreateFilterByUserInput("all");
    ArenaTeamMgr::ArenaTeamContainer allTeamsResult = allTeamsFilter->Filter(arenaTeams);
    EXPECT_EQ(allTeamsResult.size(), arenaTeams.size()); // All teams should pass

    // Test for "2,3" input
    auto specificTypesFilter = fabric.CreateFilterByUserInput("2,3");
    ArenaTeamMgr::ArenaTeamContainer filteredResult = specificTypesFilter->Filter(arenaTeams);
    EXPECT_EQ(filteredResult.size(), 2);  // Only 2v2 and 3v3 teams should pass
    EXPECT_EQ(filteredResult[1], team1);  // 2v2
    EXPECT_EQ(filteredResult[2], team2);  // 3v3
}
