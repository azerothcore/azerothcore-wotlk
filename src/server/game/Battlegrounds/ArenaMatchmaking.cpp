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

#include <algorithm>
#include <iterator>
#include <list>
#include <ranges>

namespace
{
    using ArenaMatchmaking::QueuedTeam;
    using ArenaMatchmaking::Rules;

    uint32 RatingGap(QueuedTeam const& lhs, QueuedTeam const& rhs)
    {
        return std::max(lhs.matchmakerRating, rhs.matchmakerRating)
            - std::min(lhs.matchmakerRating, rhs.matchmakerRating);
    }

    bool IsRematch(QueuedTeam const& lhs, QueuedTeam const& rhs)
    {
        return lhs.previousOpponentsTeamId == rhs.teamId || rhs.previousOpponentsTeamId == lhs.teamId;
    }

    bool WaitedLonger(QueuedTeam const* lhs, QueuedTeam const* rhs)
    {
        return lhs->waited > rhs->waited;
    }
}

bool ArenaMatchmaking::CanFaceEachOther(QueuedTeam const& lhs, QueuedTeam const& rhs, Rules const& rules)
{
    if (lhs.teamId == rhs.teamId)
        return false;

    // Both sides must have sat out the rematch timer
    if (IsRematch(lhs, rhs) && std::min(lhs.waited, rhs.waited) < rules.previousOpponentsDiscardTimer)
        return false;

    if (!rules.maxRatingDifference)
        return true;

    // Either side having waited is enough, the gap is a property of the pair
    if (rules.ratingDiscardTimer && std::max(lhs.waited, rhs.waited) >= *rules.ratingDiscardTimer)
        return true;

    return RatingGap(lhs, rhs) <= *rules.maxRatingDifference;
}

std::vector<ArenaMatchmaking::Match> ArenaMatchmaking::SelectMatches(std::span<QueuedTeam const> teams,
    Rules const& rules)
{
    std::list<QueuedTeam const*> pending;

    for (QueuedTeam const& team : teams)
        pending.push_back(&team);

    // std::list::sort is stable
    pending.sort(WaitedLonger);

    std::vector<Match> matches;

    for (auto anchor = pending.begin(); anchor != pending.end(); )
    {
        auto admissible = std::ranges::subrange(std::next(anchor), pending.end())
            | std::views::filter([&](QueuedTeam const* team) { return CanFaceEachOther(**anchor, *team, rules); });

        auto const opponent = std::ranges::min_element(admissible, {},
            [&](QueuedTeam const* team) { return RatingGap(**anchor, *team); });

        // A team nobody can play stays queued, but must not hold up the teams behind it
        if (opponent == std::ranges::end(admissible))
        {
            ++anchor;
            continue;
        }

        matches.push_back({ .firstTeamId = (*anchor)->teamId, .secondTeamId = (*opponent)->teamId });

        pending.erase(opponent.base());
        anchor = pending.erase(anchor);
    }

    return matches;
}
