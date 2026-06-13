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

#include "GroupScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnGroupAddMember(Group* group, ObjectGuid guid)
{
    ASSERT(group);

    CALL_ENABLED_HOOKS(GroupScript, GROUPHOOK_ON_ADD_MEMBER, script->OnAddMember(group, guid));
}

void ScriptMgr::OnGroupInviteMember(Group* group, ObjectGuid guid)
{
    ASSERT(group);

    CALL_ENABLED_HOOKS(GroupScript, GROUPHOOK_ON_INVITE_MEMBER, script->OnInviteMember(group, guid));
}

void ScriptMgr::OnGroupRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, const char* reason)
{
    ASSERT(group);

    CALL_ENABLED_HOOKS(GroupScript, GROUPHOOK_ON_REMOVE_MEMBER, script->OnRemoveMember(group, guid, method, kicker, reason));
}

void ScriptMgr::OnGroupChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid)
{
    ASSERT(group);

    CALL_ENABLED_HOOKS(GroupScript, GROUPHOOK_ON_CHANGE_LEADER, script->OnChangeLeader(group, newLeaderGuid, oldLeaderGuid));
}

void ScriptMgr::OnGroupDisband(Group* group)
{
    ASSERT(group);

    CALL_ENABLED_HOOKS(GroupScript, GROUPHOOK_ON_DISBAND, script->OnDisband(group));
}

bool ScriptMgr::CanGroupJoinBattlegroundQueue(Group const* group, Player* member, Battleground const* bgTemplate, uint32 MinPlayerCount, bool isRated, uint32 arenaSlot)
{
    CALL_ENABLED_BOOLEAN_HOOKS(GroupScript, GROUPHOOK_CAN_GROUP_JOIN_BATTLEGROUND_QUEUE, !script->CanGroupJoinBattlegroundQueue(group, member, bgTemplate, MinPlayerCount, isRated, arenaSlot));
}

void ScriptMgr::OnCreate(Group* group, Player* leader)
{
    CALL_ENABLED_HOOKS(GroupScript, GROUPHOOK_ON_CREATE, script->OnCreate(group, leader));
}

GroupScript::GroupScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, GROUPHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < GROUPHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<GroupScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<GroupScript>;
