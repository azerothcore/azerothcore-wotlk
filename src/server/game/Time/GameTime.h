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

#ifndef __GAMETIME_H
#define __GAMETIME_H

#include "Define.h"
#include "Duration.h"

namespace GameTime
{
    // Server start time
    AC_GAME_API Seconds GetStartTime();

    // Current server time (unix)
    AC_GAME_API Seconds GetGameTime();

    // Milliseconds since server start
    AC_GAME_API Milliseconds GetGameTimeMS();

    /// Current chrono system_clock time point
    AC_GAME_API SystemTimePoint GetSystemTime();

    /// Current chrono steady_clock time point
    AC_GAME_API TimePoint Now();

    /// Uptime
    AC_GAME_API Seconds GetUptime();

    /// Update all timers
    void UpdateGameTimers();
}

#endif
