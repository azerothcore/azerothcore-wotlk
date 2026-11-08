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

#include "Unit.h"
#include "gtest/gtest.h"

namespace
{
class MoveSpeedRatesTest : public ::testing::Test
{
protected:
    void TearDown() override { ApplyMoveSpeedRates(1.0f, 1.0f); }
};
}

// World::LoadConfigSettings() applies Rate.MoveSpeed.NPC/Player on every
// config load, including `.reload config`. Applying the same rates again
// must give the same speeds, not compound them (#26057).
TEST_F(MoveSpeedRatesTest, ReapplyingRatesDoesNotCompound)
{
    ApplyMoveSpeedRates(2.0f, 3.0f);
    ApplyMoveSpeedRates(2.0f, 3.0f);

    EXPECT_FLOAT_EQ(baseMoveSpeed[MOVE_RUN], 14.0f);
    EXPECT_FLOAT_EQ(playerBaseMoveSpeed[MOVE_RUN], 21.0f);
    EXPECT_FLOAT_EQ(baseMoveSpeed[MOVE_WALK], 5.0f);
    EXPECT_FLOAT_EQ(playerBaseMoveSpeed[MOVE_WALK], 7.5f);
}

// The NPC rate must not leak into player speeds, or the other way round.
TEST_F(MoveSpeedRatesTest, RatesAreIndependent)
{
    ApplyMoveSpeedRates(2.0f, 1.0f);

    EXPECT_FLOAT_EQ(baseMoveSpeed[MOVE_RUN], 14.0f);
    EXPECT_FLOAT_EQ(playerBaseMoveSpeed[MOVE_RUN], 7.0f);

    ApplyMoveSpeedRates(1.0f, 2.0f);

    EXPECT_FLOAT_EQ(baseMoveSpeed[MOVE_RUN], 7.0f);
    EXPECT_FLOAT_EQ(playerBaseMoveSpeed[MOVE_RUN], 14.0f);
}
