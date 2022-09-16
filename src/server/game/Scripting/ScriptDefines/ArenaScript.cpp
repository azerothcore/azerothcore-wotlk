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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::CanAddMember(ArenaTeam* team, ObjectGuid PlayerGuid)
{
    auto ret = IsValidBoolScript<ArenaScript>([&](ArenaScript* script)
    {
        return !script->CanAddMember(team, PlayerGuid);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetPoints(ArenaTeam* team, uint32 memberRating, float& points)
{
    ExecuteScript<ArenaScript>([&](ArenaScript* script)
    {
        script->OnGetPoints(team, memberRating, points);
    });
}

bool ScriptMgr::CanSaveToDB(ArenaTeam* team)
{
    auto ret = IsValidBoolScript<ArenaScript>([&](ArenaScript* script)
    {
        return !script->CanSaveToDB(team);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}
