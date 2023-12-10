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
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnGetSlotByType(type, slot);
    });
}

void ScriptMgr::OnGetArenaPoints(ArenaTeam* at, float& points)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnGetArenaPoints(at, points);
    });
}

void ScriptMgr::OnArenaTypeIDToQueueID(const BattlegroundTypeId bgTypeId, const uint8 arenaType, uint32& queueTypeID)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnTypeIDToQueueID(bgTypeId, arenaType, queueTypeID);
    });
}

void ScriptMgr::OnArenaQueueIdToArenaType(const BattlegroundQueueTypeId bgQueueTypeId, uint8& ArenaType)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnQueueIdToArenaType(bgQueueTypeId, ArenaType);
    });
}

void ScriptMgr::OnSetArenaMaxPlayersPerTeam(const uint8 arenaType, uint32& maxPlayerPerTeam)
{
    ExecuteScript<ArenaTeamScript>([&](ArenaTeamScript* script)
    {
        script->OnSetArenaMaxPlayersPerTeam(arenaType, maxPlayerPerTeam);
    });
}

ArenaTeamScript::ArenaTeamScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<ArenaTeamScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<ArenaTeamScript>;
