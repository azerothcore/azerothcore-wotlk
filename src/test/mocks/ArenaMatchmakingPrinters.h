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

#ifndef AZEROTHCORE_ARENA_MATCHMAKING_PRINTERS_H
#define AZEROTHCORE_ARENA_MATCHMAKING_PRINTERS_H

#include "ArenaMatchmaking.h"
#include <ostream>

// gtest finds these through ADL, so a failing assertion shows values rather than bytes.
namespace ArenaMatchmaking
{
    inline void PrintTo(Match const& match, std::ostream* os)
    {
        *os << "{" << match.firstTeamId << ", " << match.secondTeamId << "}";
    }

    inline void PrintTo(QueuedTeam const& team, std::ostream* os)
    {
        *os << "{id=" << team.teamId << " mmr=" << team.matchmakerRating << " waited=" << team.waited.count()
            << "ms prev=" << team.previousOpponentsTeamId << "}";
    }

    inline void PrintTo(Rules const& rules, std::ostream* os)
    {
        *os << "{gap=";
        if (rules.maxRatingDifference)
            *os << *rules.maxRatingDifference;
        else
            *os << "none";

        *os << " discard=";
        if (rules.ratingDiscardTimer)
            *os << rules.ratingDiscardTimer->count();
        else
            *os << "none";

        *os << " rematch=" << rules.previousOpponentsDiscardTimer.count() << "}";
    }
}

#endif // AZEROTHCORE_ARENA_MATCHMAKING_PRINTERS_H
