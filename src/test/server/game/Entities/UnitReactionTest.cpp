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

#include "UnitReactionUtils.h"

#include <gtest/gtest.h>

using Acore::UnitReactionUtils::ShouldCheckOriginalVehicleFaction;

TEST(UnitReactionTest, NeutralDriverChecksExplicitlyFriendlyVehicleFaction)
{
    EXPECT_TRUE(ShouldCheckOriginalVehicleFaction(false, REP_NEUTRAL, true, true, true));
}

TEST(UnitReactionTest, NeutralDriverDoesNotCheckNonVehicleFaction)
{
    EXPECT_FALSE(ShouldCheckOriginalVehicleFaction(false, REP_NEUTRAL, false, true, true));
}

TEST(UnitReactionTest, UncontrolledVehicleDoesNotUseOriginalFaction)
{
    EXPECT_FALSE(ShouldCheckOriginalVehicleFaction(false, REP_NEUTRAL, true, false, true));
}

TEST(UnitReactionTest, NonPlayerCharmerDoesNotUseOriginalFaction)
{
    EXPECT_FALSE(ShouldCheckOriginalVehicleFaction(false, REP_NEUTRAL, true, true, false));
}

TEST(UnitReactionTest, AtWarDriverDoesNotUseOriginalVehicleFaction)
{
    EXPECT_FALSE(ShouldCheckOriginalVehicleFaction(true, REP_NEUTRAL, true, true, true));
}

TEST(UnitReactionTest, HostileReactionDoesNotUseOriginalVehicleFaction)
{
    EXPECT_FALSE(ShouldCheckOriginalVehicleFaction(false, REP_HOSTILE, true, true, true));
}
