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

#include "MovementHandlerScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnPlayerMove(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    CALL_ENABLED_HOOKS(MovementHandlerScript, MOVEMENTHOOK_ON_PLAYER_MOVE, script->OnPlayerMove(player, movementInfo, opcode));
}

// Custom Script
bool ScriptMgr::OnPlayerMoveCheck(Player* player, ObjectGuid guid, MovementInfo movementInfo) const
{
    CALL_ENABLED_BOOLEAN_HOOKS(MovementHandlerScript, MOVEMENTHOOK_ON_PLAYER_MOVE_CHECK, !script->OnPlayerMoveCheck(player, guid, movementInfo));
}

// Custom Script
void ScriptMgr::OnPlayerMoveKnockBackAck(Player* player, ObjectGuid guid, MovementInfo movementInfo) const
{
    CALL_ENABLED_HOOKS(MovementHandlerScript, MOVEMENTHOOK_ON_PLAYER_MOVE_KNOCK_BACK_ACK, script->OnPlayerMoveKnockBackAck(player, guid, movementInfo));
}

MovementHandlerScript::MovementHandlerScript(const char* name, std::vector<uint16> enabledHooks) :
    ScriptObject(name, MOVEMENTHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < MOVEMENTHOOK_END; i++)
            enabledHooks.emplace_back(i);

    ScriptRegistry<MovementHandlerScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<MovementHandlerScript>;
