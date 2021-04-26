/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _GROUPMGR_H
#define _GROUPMGR_H

#include "Group.h"

class GroupMgr
{
private:
    GroupMgr();
    ~GroupMgr();

public:
    static GroupMgr* instance();

    typedef std::map<uint32, Group*> GroupContainer;

    Group* GetGroupByGUID(ObjectGuid::LowType guid) const;

    void InitGroupIds();
    void RegisterGroupId(ObjectGuid::LowType groupId);
    ObjectGuid::LowType GenerateGroupId();

    void LoadGroups();
    void AddGroup(Group* group);
    void RemoveGroup(Group* group);

protected:
    typedef std::vector<bool> GroupIds;
    GroupIds            _groupIds;
    ObjectGuid::LowType _nextGroupId;
    GroupContainer      GroupStore;
};

#define sGroupMgr GroupMgr::instance()

#endif
