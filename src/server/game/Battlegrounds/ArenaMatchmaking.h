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

#ifndef ACORE_ARENA_MATCHMAKING_H
#define ACORE_ARENA_MATCHMAKING_H

#include "Define.h"
#include "Duration.h"
#include <chrono>
#include <optional>
#include <span>
#include <vector>

/**
 * Rated arena pairing.
 *
 * Free of game types, pointers, singletons and the clock, so the rules can be
 * stated and tested on their own. The caller narrows its queue to the teams that
 * may play, projects them into QueuedTeam values, and applies the result.
 */
namespace ArenaMatchmaking
{
    // Milliseconds at the width of the queue clock the wait is measured from
    using WaitTime = std::chrono::duration<uint32, std::milli>;

    // A team waiting to be paired
    struct QueuedTeam
    {
        uint32   teamId{};
        uint32   matchmakerRating{};
        WaitTime waited{};
        uint32   previousOpponentsTeamId{};     // 0 when the team has not played yet
    };

    struct Rules
    {
        // Largest rating gap two teams may face each other across.
        // Absent leaves the gap unconstrained.
        std::optional<uint32> maxRatingDifference;

        // Once either team has waited this long, the rating gap no longer applies to
        // the pair. Absent never waives the gap, zero waives it at once.
        std::optional<Milliseconds> ratingDiscardTimer;

        // Two teams that just played each other are not paired again until both have
        // waited this long. Zero allows the rematch at once.
        Milliseconds previousOpponentsDiscardTimer{};
    };

    struct Match
    {
        uint32 firstTeamId{};
        uint32 secondTeamId{};

        [[nodiscard]] friend bool operator==(Match const&, Match const&) = default;
    };

    /// Return whether @p lhs and @p rhs may be started against each other under @p rules. A team
    /// never faces itself.
    [[nodiscard]] bool CanFaceEachOther(QueuedTeam const& lhs, QueuedTeam const& rhs, Rules const& rules);

    /**
     * @brief Return every match that can be formed out of the specified @p teams under the
     *        specified @p rules, longest wait first.
     *
     * Each match pairs the longest waiting team still unpaired with its closest rated
     * admissible opponent. A team nobody can play is passed over rather than left blocking
     * the teams behind it. Faction is not a criterion, and position in @p teams only breaks
     * equal waits, which keep the order they were given in, so the same queue always yields
     * the same matches.
     *
     * @param teams The teams to pair, each of which the caller is willing to start a match
     *              for, and each carrying a distinct @c teamId.
     * @param rules The configured pairing constraints.
     * @return The matches to start, in the order they were formed. Every @c firstTeamId is
     *         the longer waiting side of its pair.
     */
    [[nodiscard]] std::vector<Match> SelectMatches(std::span<QueuedTeam const> teams, Rules const& rules);
}

#endif // ACORE_ARENA_MATCHMAKING_H
