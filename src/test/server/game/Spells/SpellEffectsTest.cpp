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

#include "Mocks/WorldMock.h"
#include "Player.h"
#include "Spell.h"
#include "gtest/gtest.h"

TEST(SpellEffectsTest, DistractDoesNotStopMovement)
{
    WorldMock world;
    Player* player = new Player(nullptr);
    player->Create(sObjectMgr->GenerateLowGuid<HighGuid::Player>(), nullptr);

    Unit* target = new Unit(false);
    target->Create(sObjectMgr->GenerateLowGuid<HighGuid::Unit>(), nullptr, 0, 0);

    target->GetMotionMaster()->MovePoint(1, 10.0f, 10.0f, 10.0f);

    // Verify that the target is moving and the stack size is 1
    ASSERT_EQ(target->GetMotionMaster()->size(), 1);

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(1725); // Distract
    Spell* spell = new Spell(player, spellInfo, TriggerCastFlags(TRIGGERED_NONE));
    spell->m_targets.SetUnitTarget(target);

    spell->EffectDistract(EFFECT_0);

    // Verify that the movement stack size is now 2, meaning the original movement was not cleared
    EXPECT_EQ(target->GetMotionMaster()->size(), 2);
}
