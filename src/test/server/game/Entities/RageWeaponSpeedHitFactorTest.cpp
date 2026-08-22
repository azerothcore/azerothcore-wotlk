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
#include "gtest/gtest.h"

// Haste must shorten the swing interval but never the per-swing rage reward.
TEST_F(IntegrationTestFixture, HasteChangesIntervalNotRage)
{
    TestPlayer* player = CreateTestPlayer(1, "RageTest", SEC_PLAYER);
    player->SetUInt32Value(UNIT_FIELD_LEVEL, 80);
    player->SetMaxPower(POWER_RAGE, 10000);
    player->SetAttackTime(BASE_ATTACK, 2000);

    uint32 const before = player->GetPower(POWER_RAGE);
    player->RewardRage(1000, player->GetRageWeaponSpeedHitFactor(BASE_ATTACK), true);
    uint32 const rageNoHaste = player->GetPower(POWER_RAGE) - before;
    EXPECT_GT(rageNoHaste, 0u); // rage was granted

    player->ApplyAttackTimePercentMod(BASE_ATTACK, 50.0f, true); // 50% haste

    EXPECT_EQ(player->GetRageWeaponSpeedHitFactor(BASE_ATTACK), 7u); // 2000/1000 * 3.5

    uint32 const beforeHasted = player->GetPower(POWER_RAGE);
    player->RewardRage(1000, player->GetRageWeaponSpeedHitFactor(BASE_ATTACK), true);
    uint32 const rageHasted = player->GetPower(POWER_RAGE) - beforeHasted;

    EXPECT_EQ(rageHasted, rageNoHaste); // per-swing rage unaffected by haste

    player->resetAttackTimer(BASE_ATTACK);
    EXPECT_EQ(player->getAttackTimer(BASE_ATTACK), 1333); // 2000 / 1.5 (50% haste)
}
