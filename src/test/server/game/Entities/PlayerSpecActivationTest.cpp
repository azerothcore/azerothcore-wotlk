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

#include "IntegrationTestFixture.h"
#include <utility>

class PlayerSpecActivationTest : public IntegrationTestFixture,
    public ::testing::WithParamInterface<std::pair<uint8, uint8>>
{
};

TEST_P(PlayerSpecActivationTest, InvalidSpecPreservesActiveSpecAndMana)
{
    auto const [specCount, requestedSpec] = GetParam();
    TestPlayer* player = CreateTestPlayer(1, "SpecTest", SEC_PLAYER);
    player->SetSpecsCount(specCount);
    player->SetActiveSpec(0);
    player->SetMaxPower(POWER_MANA, 1000);
    player->SetPower(POWER_MANA, 1000);

    // Exercise the real activation path: reject the request before changing
    // spells, saving actions, or draining mana, even without client-side checks.
    player->ActivateSpec(requestedSpec);

    EXPECT_EQ(player->GetActiveSpec(), 0);
    EXPECT_EQ(player->GetSpecsCount(), specCount);
    EXPECT_EQ(player->GetPower(POWER_MANA), 1000);
}

INSTANTIATE_TEST_SUITE_P(InvalidSlots, PlayerSpecActivationTest, ::testing::Values(
    std::pair<uint8, uint8>{1, 1},
    std::pair<uint8, uint8>{2, 2},
    std::pair<uint8, uint8>{2, 255}));
