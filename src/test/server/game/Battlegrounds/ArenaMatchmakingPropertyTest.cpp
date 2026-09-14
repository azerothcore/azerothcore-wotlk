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

#include "ArenaMatchmaking.h"
#include "ArenaMatchmakingPrinters.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include <algorithm>
#include <iostream>
#include <random>
#include <set>
#include <span>
#include <string>
#include <vector>

using ::testing::ContainerEq;
using ::testing::PrintToString;

/**
 * Randomised properties of rated arena pairing.
 *
 * The example tests pin what admissible means. This generates queues and checks what the
 * pass does with admissibility: every started pair passes the unit's own check, nobody plays
 * twice, the longer waiter is listed first, nothing admissible is left over, and the input
 * order does not matter.
 *
 * The generator is seeded from gtest's own seed, so a failure replays with
 * --gtest_random_seed=N, and N is printed with every run.
 */
namespace
{
    using ArenaMatchmaking::CanFaceEachOther;
    using ArenaMatchmaking::Match;
    using ArenaMatchmaking::QueuedTeam;
    using ArenaMatchmaking::Rules;

    struct Generated
    {
        std::vector<QueuedTeam> teams;
        Rules rules;
    };

    Generated GenerateQueue(std::mt19937& rng)
    {
        Generated out;

        // Ratings are drawn from a narrow band so that admissible pairs are common. A wide
        // band would mostly generate queues where nothing can play anything.
        std::uniform_int_distribution teamCount(0, 12);
        std::uniform_int_distribution<uint32> rating(1000, 2600);
        std::uniform_int_distribution waitedSeconds(0, 1500);
        std::uniform_int_distribution gapRoll(0, 3);
        std::uniform_int_distribution timerRoll(0, 3);

        if (gapRoll(rng) == 0)
            out.rules.maxRatingDifference.reset();
        else
            out.rules.maxRatingDifference = std::uniform_int_distribution<uint32>(0, 400)(rng);

        if (timerRoll(rng) == 0)
            out.rules.ratingDiscardTimer.reset();
        else
            out.rules.ratingDiscardTimer = Milliseconds{ std::uniform_int_distribution(0, 900)(rng) * 1000 };

        out.rules.previousOpponentsDiscardTimer =
            Milliseconds{ std::uniform_int_distribution(0, 300)(rng) * 1000 };

        int const count = teamCount(rng);
        out.teams.reserve(count);

        for (int i = 0; i < count; ++i)
        {
            QueuedTeam team;
            team.teamId = static_cast<uint32>(i) + 1;               // distinct, as the caller guarantees
            team.matchmakerRating = rating(rng);
            team.waited = Milliseconds{ waitedSeconds(rng) * 1000 };
            out.teams.push_back(team);
        }

        // Some teams remember a previous opponent, usually one that is also queued.
        std::uniform_int_distribution rematchRoll(0, 2);
        for (QueuedTeam& team : out.teams)
        {
            if (rematchRoll(rng) != 0 || out.teams.size() < 2)
                continue;

            std::uniform_int_distribution<std::size_t> pick(0, out.teams.size() - 1);
            uint32 const other = out.teams[pick(rng)].teamId;
            if (other != team.teamId)
                team.previousOpponentsTeamId = other;
        }

        return out;
    }
}

class ArenaMatchmakingPropertyTest : public ::testing::Test
{
protected:
    static constexpr int Iterations = 2000;

    void SetUp() override
    {
        // Time based unless --gtest_random_seed pins it
        _seed = ::testing::UnitTest::GetInstance()->random_seed();
        RecordProperty("random_seed", _seed);
        std::cout << "[          ] replay with --gtest_random_seed=" << _seed << '\n';
        _rng.seed(_seed);
    }

    std::string Context(int iteration, Generated const& input) const
    {
        return "--gtest_random_seed=" + std::to_string(_seed) + " iteration " + std::to_string(iteration)
            + "\nteams " + PrintToString(input.teams) + "\nrules " + PrintToString(input.rules);
    }

    std::mt19937 _rng;

private:
    int _seed = 0;
};

TEST_F(ArenaMatchmakingPropertyTest, RandomQueuesObeyThePairingContract)
{
    for (int iteration = 0; iteration < Iterations; ++iteration)
    {
        auto const input = GenerateQueue(_rng);
        SCOPED_TRACE(Context(iteration, input));

        std::span const teams = input.teams;
        auto const matches = ArenaMatchmaking::SelectMatches(teams, input.rules);

        std::set<uint32> paired;
        for (Match const& match : matches)
        {
            auto const first = std::ranges::find(teams, match.firstTeamId, &QueuedTeam::teamId);
            auto const second = std::ranges::find(teams, match.secondTeamId, &QueuedTeam::teamId);
            ASSERT_TRUE(first != teams.end() && second != teams.end()) << "a match names a team that was never queued";

            ASSERT_TRUE(paired.insert(first->teamId).second) << "team " << first->teamId << " was placed in two matches";
            ASSERT_TRUE(paired.insert(second->teamId).second) << "team " << second->teamId << " was placed in two matches";

            ASSERT_TRUE(CanFaceEachOther(*first, *second, input.rules))
                << "started an inadmissible pair " << first->teamId << " vs " << second->teamId;

            ASSERT_GE(first->waited.count(), second->waited.count())
                << "the shorter waiter " << first->teamId << " was listed first";
        }

        // Maximal: nothing left over could have played anything else left over, otherwise the
        // pass gave up early and those teams wait for no reason.
        for (QueuedTeam const& lhs : teams)
        {
            if (paired.contains(lhs.teamId))
                continue;

            for (QueuedTeam const& rhs : teams)
            {
                if (rhs.teamId == lhs.teamId || paired.contains(rhs.teamId))
                    continue;

                ASSERT_FALSE(CanFaceEachOther(lhs, rhs, input.rules))
                    << "left " << lhs.teamId << " and " << rhs.teamId << " queued although they could have played each other";
            }
        }
    }
}

// The same queue must yield the same matches however the caller happened to order it,
// otherwise the outcome depends on list order rather than on the rules. Equal waits keep
// input order by contract, so they are made distinct first.
TEST_F(ArenaMatchmakingPropertyTest, ResultDoesNotDependOnInputOrder)
{
    for (int iteration = 0; iteration < Iterations; ++iteration)
    {
        auto input = GenerateQueue(_rng);
        for (std::size_t i = 0; i < input.teams.size(); ++i)
            input.teams[i].waited += Milliseconds{ i };

        SCOPED_TRACE(Context(iteration, input));

        auto const expected = ArenaMatchmaking::SelectMatches(input.teams, input.rules);

        auto shuffled = input.teams;
        std::ranges::shuffle(shuffled, _rng);

        ASSERT_THAT(ArenaMatchmaking::SelectMatches(shuffled, input.rules), ContainerEq(expected));
    }
}
