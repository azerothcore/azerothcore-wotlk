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

#ifndef SCRIPT_OBJECT_GROUP_SCRIPT_H_
#define SCRIPT_OBJECT_GROUP_SCRIPT_H_

#include "ObjectGuid.h"
#include "ScriptObject.h"
#include <vector>

enum GroupHook
{
    GROUPHOOK_ON_ADD_MEMBER,
    GROUPHOOK_ON_INVITE_MEMBER,
    GROUPHOOK_ON_REMOVE_MEMBER,
    GROUPHOOK_ON_CHANGE_LEADER,
    GROUPHOOK_ON_DISBAND,
    GROUPHOOK_CAN_GROUP_JOIN_BATTLEGROUND_QUEUE,
    GROUPHOOK_ON_CREATE,
    GROUPHOOK_END
};

enum RemoveMethod : uint8;

class GroupScript : public ScriptObject
{
protected:
    GroupScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    // Called when a member is added to a group.
    virtual void OnAddMember(Group* /*group*/, ObjectGuid /*guid*/) { }

    // Called when a member is invited to join a group.
    virtual void OnInviteMember(Group* /*group*/, ObjectGuid /*guid*/) { }

    // Called when a member is removed from a group.
    virtual void OnRemoveMember(Group* /*group*/, ObjectGuid /*guid*/, RemoveMethod /*method*/, ObjectGuid /*kicker*/, const char* /*reason*/) { }

    // Called when the leader of a group is changed.
    virtual void OnChangeLeader(Group* /*group*/, ObjectGuid /*newLeaderGuid*/, ObjectGuid /*oldLeaderGuid*/) { }

    // Called when a group is disbanded.
    virtual void OnDisband(Group* /*group*/) { }

    [[nodiscard]] virtual bool CanGroupJoinBattlegroundQueue(Group const* /*group*/, Player* /*member*/, Battleground const* /*bgTemplate*/, uint32 /*MinPlayerCount*/, bool /*isRated*/, uint32 /*arenaSlot*/) { return true; }

    virtual void OnCreate(Group* /*group*/, Player* /*leader*/) { }
};

#endif
