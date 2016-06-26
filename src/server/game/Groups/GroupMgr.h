/*
 * Copyright (C) 
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _GROUPMGR_H
#define _GROUPMGR_H

#include "Group.h"

class GroupMgr
{
    friend class ACE_Singleton<GroupMgr, ACE_Null_Mutex>;
private:
    GroupMgr();
    ~GroupMgr();

public:
    typedef std::map<uint32, Group*> GroupContainer;

    Group* GetGroupByGUID(uint32 guid) const;

    void InitGroupIds();
    void RegisterGroupId(uint32 groupId);
    uint32 GenerateGroupId();

    void LoadGroups();
    void AddGroup(Group* group);
    void RemoveGroup(Group* group);


protected:
    typedef std::vector<bool> GroupIds;
    GroupIds         _groupIds;
    uint32           _nextGroupId;
    GroupContainer   GroupStore;
};

#define sGroupMgr ACE_Singleton<GroupMgr, ACE_Null_Mutex>::instance()

#endif
