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

#include "ArenaScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::CanAddMember(ArenaTeam* team, ObjectGuid PlayerGuid)
{
    CALL_ENABLED_BOOLEAN_HOOKS(ArenaScript, ARENAHOOK_CAN_ADD_MEMBER, !script->CanAddMember(team, PlayerGuid));
}

void ScriptMgr::OnGetPoints(ArenaTeam* team, uint32 memberRating, float& points)
{
    CALL_ENABLED_HOOKS(ArenaScript, ARENAHOOK_ON_GET_POINTS, script->OnGetPoints(team, memberRating, points));
}

bool ScriptMgr::CanSaveToDB(ArenaTeam* team)
{
    CALL_ENABLED_BOOLEAN_HOOKS(ArenaScript, ARENAHOOK_CAN_SAVE_TO_DB, !script->CanSaveToDB(team));
}

ArenaScript::ArenaScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, ARENAHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ARENAHOOK_END; i++)
            enabledHooks.emplace_back(i);

    ScriptRegistry<ArenaScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<ArenaScript>;
