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

void ScriptMgr::OnGroupAddMember(Group* group, ObjectGuid guid)
{
    ASSERT(group);

    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnAddMember(group, guid);
    });
}

void ScriptMgr::OnGroupInviteMember(Group* group, ObjectGuid guid)
{
    ASSERT(group);

    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnInviteMember(group, guid);
    });
}

void ScriptMgr::OnGroupRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, const char* reason)
{
    ASSERT(group);

    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnRemoveMember(group, guid, method, kicker, reason);
    });
}

void ScriptMgr::OnGroupChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid)
{
    ASSERT(group);

    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnChangeLeader(group, newLeaderGuid, oldLeaderGuid);
    });
}

void ScriptMgr::OnGroupDisband(Group* group)
{
    ASSERT(group);

    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnDisband(group);
    });
}

bool ScriptMgr::CanGroupJoinBattlegroundQueue(Group const* group, Player* member, Battleground const* bgTemplate, uint32 MinPlayerCount, bool isRated, uint32 arenaSlot)
{
    auto ret = IsValidBoolScript<GroupScript>([&](GroupScript* script)
    {
        return !script->CanGroupJoinBattlegroundQueue(group, member, bgTemplate, MinPlayerCount, isRated, arenaSlot);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnCreate(Group* group, Player* leader)
{
    ExecuteScript<GroupScript>([&](GroupScript* script)
    {
        script->OnCreate(group, leader);
    });
}
