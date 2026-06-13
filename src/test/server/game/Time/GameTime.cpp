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

#include "GameTime.h"
#include "gtest/gtest.h"

#include <thread>

TEST(GameTimeTest, Elapsed)
{
    GameTime::UpdateGameTimers();
    auto start = GameTime::Now();
    std::this_thread::sleep_for(50ms);
    GameTime::UpdateGameTimers();
    auto elapsed = GameTime::Elapsed(start);
    EXPECT_GE(elapsed, 50ms);
}

TEST(GameTimeTest, HasElapsedTrue)
{
    GameTime::UpdateGameTimers();
    auto start = GameTime::Now();
    std::this_thread::sleep_for(50ms);
    GameTime::UpdateGameTimers();
    EXPECT_TRUE(GameTime::HasElapsed(start, 25ms));
}

TEST(GameTimeTest, HasElapsedFalse)
{
    GameTime::UpdateGameTimers();
    auto start = GameTime::Now();
    EXPECT_FALSE(GameTime::HasElapsed(start, 10s));
}

TEST(GameTimeTest, HasElapsedWithSeconds)
{
    GameTime::UpdateGameTimers();
    auto start = GameTime::Now();
    EXPECT_FALSE(GameTime::HasElapsed(start, 1s));
}

TEST(GameTimeTest, HasElapsedWithMicroseconds)
{
    GameTime::UpdateGameTimers();
    auto start = GameTime::Now();
    std::this_thread::sleep_for(100us);
    GameTime::UpdateGameTimers();
    EXPECT_TRUE(GameTime::HasElapsed(start, Microseconds(1)));
}
