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
#include <vector>

using ::testing::ElementsAre;
using ::testing::IsEmpty;

/**
 * Rated arena pairing. No world, no managers, no clock, no database.
 */
class ArenaMatchmakingTest : public ::testing::Test
{
protected:
    using QueuedTeam = ArenaMatchmaking::QueuedTeam;
    using Match = ArenaMatchmaking::Match;
    using Rules = ArenaMatchmaking::Rules;

    static constexpr uint32 MaxRatingDifference = 150;
    static constexpr Milliseconds RatingDiscardTimer = 10min;
    static constexpr Milliseconds PrevOpponentsDiscardTimer = 2min;

    static Rules DefaultRules()
    {
        return { .maxRatingDifference = MaxRatingDifference,
            .ratingDiscardTimer = RatingDiscardTimer,
            .previousOpponentsDiscardTimer = PrevOpponentsDiscardTimer };
    }

    static QueuedTeam Team(uint32 teamId, uint32 matchmakerRating, Milliseconds waited = 0s,
        uint32 previousOpponentsTeamId = 0)
    {
        return { .teamId = teamId, .matchmakerRating = matchmakerRating, .waited = waited,
            .previousOpponentsTeamId = previousOpponentsTeamId };
    }

    static std::vector<Match> Select(std::vector<QueuedTeam> const& teams, Rules const& rules = DefaultRules())
    {
        return ArenaMatchmaking::SelectMatches(teams, rules);
    }
};

TEST_F(ArenaMatchmakingTest, MatchesTwoTeamsInsideTheGap)
{
    EXPECT_THAT(Select({ Team(1, 1500), Team(2, 1600) }), ElementsAre(Match{ 1, 2 }));
}

TEST_F(ArenaMatchmakingTest, AnEmptyQueueYieldsNothing)
{
    EXPECT_THAT(Select({}), IsEmpty());
    EXPECT_THAT(Select({ Team(1, 1500) }), IsEmpty());
}

TEST_F(ArenaMatchmakingTest, TeamsOutsideTheGapAreNotMatched)
{
    EXPECT_THAT(Select({ Team(1, 1500), Team(2, 1900) }), IsEmpty());
}

TEST_F(ArenaMatchmakingTest, ATeamNeverFacesItself)
{
    EXPECT_THAT(Select({ Team(1, 1500), Team(1, 1500) }), IsEmpty());
}

// The gap belongs to the pair. Measuring both teams against a third one instead lets two teams
// up to twice the gap apart end up against each other.
TEST_F(ArenaMatchmakingTest, TeamsAreComparedToEachOtherNotToAThirdTeam)
{
    EXPECT_THAT(Select({ Team(1, 1850, 30s), Team(2, 2150, 20s) }), IsEmpty());
}

TEST_F(ArenaMatchmakingTest, LongestWaiterTakesItsClosestOpponent)
{
    EXPECT_THAT(Select({ Team(1, 2000, 30s), Team(2, 1850, 20s), Team(3, 2150, 10s) }),
        ElementsAre(Match{ 1, 2 }));
}

// Priority is wait, not closeness: a newcomer closer to someone else still goes to the longest
// waiter it can face.
TEST_F(ArenaMatchmakingTest, LongestWaiterOutranksACloserPair)
{
    EXPECT_THAT(Select({ Team(1, 1500, 60s), Team(2, 1700, 30s), Team(3, 1650) }), ElementsAre(Match{ 1, 3 }));
}

// A team nobody can play must not hold up the teams behind it.
TEST_F(ArenaMatchmakingTest, UnmatchableLongestWaiterDoesNotStallTheQueue)
{
    EXPECT_THAT(Select({ Team(1, 3000, 60s), Team(2, 1500, 30s), Team(3, 1550, 20s) }),
        ElementsAre(Match{ 2, 3 }));
}

TEST_F(ArenaMatchmakingTest, EveryFormableMatchIsFormedAtOnce)
{
    EXPECT_THAT(Select({ Team(1, 1500, 40s), Team(2, 1500, 30s), Team(3, 1500, 20s), Team(4, 1500, 10s) }),
        ElementsAre(Match{ 1, 2 }, Match{ 3, 4 }));
}

TEST_F(ArenaMatchmakingTest, OddTeamOutIsLeftQueued)
{
    EXPECT_THAT(Select({ Team(1, 1500, 40s), Team(2, 1500, 30s), Team(3, 1500, 20s) }),
        ElementsAre(Match{ 1, 2 }));
}

// Waiting out the discard timer waives the gap, but the waiting team still takes the closest
// opponent it can rather than whichever one is looked at first.
TEST_F(ArenaMatchmakingTest, StaleTeamStillTakesItsClosestOpponent)
{
    EXPECT_THAT(Select({ Team(1, 1000, RatingDiscardTimer), Team(2, 2000, 10s), Team(3, 3000, 5s) }),
        ElementsAre(Match{ 1, 2 }));
}

TEST_F(ArenaMatchmakingTest, RematchNeedsBothTeamsToHaveWaitedOutTheTimer)
{
    EXPECT_THAT(Select({ Team(1, 1500, PrevOpponentsDiscardTimer, 2), Team(2, 1500, 10s) }), IsEmpty());

    EXPECT_THAT(Select({ Team(1, 1500, PrevOpponentsDiscardTimer, 2), Team(2, 1500, PrevOpponentsDiscardTimer) }),
        ElementsAre(Match{ 1, 2 }));
}

TEST_F(ArenaMatchmakingTest, RematchIsBlockedWhicheverSideRecordsIt)
{
    EXPECT_THAT(Select({ Team(1, 1500, 10s), Team(2, 1500, 10s, 1) }), IsEmpty());
}

// Waiting waives the rating gap, never the rematch timer.
TEST_F(ArenaMatchmakingTest, StaleTeamStillRespectsTheRematchTimer)
{
    EXPECT_THAT(Select({ Team(1, 1500, RatingDiscardTimer, 2), Team(2, 1500, 10s) }), IsEmpty());
}

TEST_F(ArenaMatchmakingTest, ResultDoesNotDependOnTheOrderTeamsAreGivenIn)
{
    EXPECT_THAT(Select({ Team(1, 2000, 30s), Team(2, 1850, 20s), Team(3, 2150, 10s) }), ElementsAre(Match{ 1, 2 }));
    EXPECT_THAT(Select({ Team(3, 2150, 10s), Team(2, 1850, 20s), Team(1, 2000, 30s) }), ElementsAre(Match{ 1, 2 }));
    EXPECT_THAT(Select({ Team(2, 1850, 20s), Team(3, 2150, 10s), Team(1, 2000, 30s) }), ElementsAre(Match{ 1, 2 }));
}

// Teams that joined in the same tick share a wait, and the order they were given in is the
// order they joined.
TEST_F(ArenaMatchmakingTest, EqualWaitsKeepTheCallersOrder)
{
    EXPECT_THAT(Select({ Team(7, 1500, 20s), Team(3, 1500, 20s), Team(5, 1500, 20s) }), ElementsAre(Match{ 7, 3 }));
}

// Arena.RatingDiscardTimer is documented as disabled at 0. Disabled means the gap always
// applies, not that every team is instantly stale.
TEST_F(ArenaMatchmakingTest, AbsentRatingDiscardTimerNeverWaivesTheGap)
{
    Rules rules = DefaultRules();
    rules.ratingDiscardTimer.reset();

    EXPECT_THAT(Select({ Team(1, 1000, 60min), Team(2, 3000, 60min) }, rules), IsEmpty());
}

TEST_F(ArenaMatchmakingTest, ZeroRematchTimerAllowsAnImmediateRematch)
{
    Rules rules = DefaultRules();
    rules.previousOpponentsDiscardTimer = 0s;

    EXPECT_THAT(Select({ Team(1, 1500, 0s, 2), Team(2, 1500) }, rules), ElementsAre(Match{ 1, 2 }));
}

TEST_F(ArenaMatchmakingTest, AbsentMaxRatingDifferenceLeavesTheGapUnconstrained)
{
    Rules rules = DefaultRules();
    rules.maxRatingDifference.reset();

    EXPECT_THAT(Select({ Team(1, 500), Team(2, 3000) }, rules), ElementsAre(Match{ 1, 2 }));
}

TEST_F(ArenaMatchmakingTest, ZeroMaxRatingDifferenceDemandsAnExactMatch)
{
    Rules rules = DefaultRules();
    rules.maxRatingDifference = 0;

    EXPECT_THAT(Select({ Team(1, 1500, 20s), Team(2, 1500, 10s), Team(3, 1501, 5s) }, rules),
        ElementsAre(Match{ 1, 2 }));
}
