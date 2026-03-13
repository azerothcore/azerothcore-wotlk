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

#include "BattlefieldScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnBattlefieldPlayerEnterZone(Battlefield* bf, Player* player)
{
    CALL_ENABLED_HOOKS(BattlefieldScript, BATTLEFIELDHOOK_ON_PLAYER_ENTER_ZONE, script->OnBattlefieldPlayerEnterZone(bf, player));
}

void ScriptMgr::OnBattlefieldPlayerLeaveZone(Battlefield* bf, Player* player)
{
    CALL_ENABLED_HOOKS(BattlefieldScript, BATTLEFIELDHOOK_ON_PLAYER_LEAVE_ZONE, script->OnBattlefieldPlayerLeaveZone(bf, player));
}

void ScriptMgr::OnBattlefieldPlayerJoinWar(Battlefield* bf, Player* player)
{
    CALL_ENABLED_HOOKS(BattlefieldScript, BATTLEFIELDHOOK_ON_PLAYER_JOIN_WAR, script->OnBattlefieldPlayerJoinWar(bf, player));
}

void ScriptMgr::OnBattlefieldPlayerLeaveWar(Battlefield* bf, Player* player)
{
    CALL_ENABLED_HOOKS(BattlefieldScript, BATTLEFIELDHOOK_ON_PLAYER_LEAVE_WAR, script->OnBattlefieldPlayerLeaveWar(bf, player));
}

void ScriptMgr::OnBattlefieldBeforeInvitePlayerToWar(Battlefield* bf, Player* player)
{
    CALL_ENABLED_HOOKS(BattlefieldScript, BATTLEFIELDHOOK_BEFORE_INVITE_PLAYER_TO_WAR, script->OnBattlefieldBeforeInvitePlayerToWar(bf, player));
}

BattlefieldScript::BattlefieldScript(char const* name, std::vector<uint16> enabledHooks) :
    ScriptObject(name, BATTLEFIELDHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < BATTLEFIELDHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<BattlefieldScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<BattlefieldScript>;
