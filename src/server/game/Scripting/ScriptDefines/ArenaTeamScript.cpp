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

#include "ArenaTeamScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnGetSlotByType(const uint32 type, uint8& slot)
{
    CALL_ENABLED_HOOKS(ArenaTeamScript, ARENATEAMHOOK_ON_GET_SLOT_BY_TYPE, script->OnGetSlotByType(type, slot));
}

void ScriptMgr::OnGetArenaPoints(ArenaTeam* at, float& points)
{
    CALL_ENABLED_HOOKS(ArenaTeamScript, ARENATEAMHOOK_ON_GET_ARENA_POINTS, script->OnGetArenaPoints(at, points));
}

void ScriptMgr::OnArenaTypeIDToQueueID(const BattlegroundTypeId bgTypeId, const uint8 arenaType, uint32& queueTypeID)
{
    CALL_ENABLED_HOOKS(ArenaTeamScript, ARENATEAMHOOK_ON_TYPEID_TO_QUEUEID, script->OnTypeIDToQueueID(bgTypeId, arenaType, queueTypeID));
}

void ScriptMgr::OnArenaQueueIdToArenaType(const BattlegroundQueueTypeId bgQueueTypeId, uint8& ArenaType)
{
    CALL_ENABLED_HOOKS(ArenaTeamScript, ARENATEAMHOOK_ON_QUEUEID_TO_ARENA_TYPE, script->OnQueueIdToArenaType(bgQueueTypeId, ArenaType));
}

void ScriptMgr::OnSetArenaMaxPlayersPerTeam(const uint8 arenaType, uint32& maxPlayerPerTeam)
{
    CALL_ENABLED_HOOKS(ArenaTeamScript, ARENATEAMHOOK_ON_SET_ARENA_MAX_PLAYERS_PER_TEAM, script->OnSetArenaMaxPlayersPerTeam(arenaType, maxPlayerPerTeam));
}

ArenaTeamScript::ArenaTeamScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, ARENATEAMHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ARENATEAMHOOK_END; i++)
            enabledHooks.emplace_back(i);

    ScriptRegistry<ArenaTeamScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<ArenaTeamScript>;
