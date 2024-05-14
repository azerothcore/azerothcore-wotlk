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

#include "GroupMgr.h"
#include "Common.h"
#include "DBCStores.h"
#include "InstanceSaveMgr.h"
#include "Log.h"
#include "World.h"

GroupMgr::GroupMgr()
{
    _nextGroupId = 0;
}

GroupMgr::~GroupMgr()
{
    for (GroupContainer::iterator itr = GroupStore.begin(); itr != GroupStore.end(); ++itr)
        delete itr->second;
}

GroupMgr* GroupMgr::instance()
{
    static GroupMgr instance;
    return &instance;
}

void GroupMgr::InitGroupIds()
{
    _nextGroupId = 1;

    QueryResult result = CharacterDatabase.Query("SELECT MAX(guid) FROM `groups`");
    if (result)
    {
        uint32 maxId = (*result)[0].Get<uint32>();
        _groupIds.resize(maxId + 1);
    }
}

void GroupMgr::RegisterGroupId(uint32 groupId)
{
    // Allocation was done in InitGroupIds()
    _groupIds[groupId] = true;

    // Groups are pulled in ascending order from db and _nextGroupId is initialized with 1,
    // so if the instance id is used, increment
    if (_nextGroupId == groupId)
        ++_nextGroupId;
}

ObjectGuid::LowType GroupMgr::GenerateGroupId()
{
    ObjectGuid::LowType newGroupId = _nextGroupId;

    // find the lowest available id starting from the current _nextGroupId
    while (_nextGroupId < 0xFFFFFFFF && ++_nextGroupId < _groupIds.size() && _groupIds[_nextGroupId]);

    if (_nextGroupId == 0xFFFFFFFF)
    {
        LOG_ERROR("server.worldserver", "Group ID overflow!! Can't continue, shutting down server.");
        World::StopNow(ERROR_EXIT_CODE);
    }

    return newGroupId;
}

Group* GroupMgr::GetGroupByGUID(ObjectGuid::LowType groupId) const
{
    GroupContainer::const_iterator itr = GroupStore.find(groupId);
    if (itr != GroupStore.end())
        return itr->second;

    return nullptr;
}

void GroupMgr::AddGroup(Group* group)
{
    GroupStore[group->GetGUID().GetCounter()] = group;
}

void GroupMgr::RemoveGroup(Group* group)
{
    GroupStore.erase(group->GetGUID().GetCounter());
}

void GroupMgr::LoadGroups()
{
    {
        uint32 oldMSTime = getMSTime();

        // Delete all groups whose leader does not exist
        CharacterDatabase.DirectExecute("DELETE FROM `groups` WHERE leaderGuid NOT IN (SELECT guid FROM characters)");

        // Delete all groups with less than 2 members
        //npcbot: adjust this
        /*
        //end npcbot
        CharacterDatabase.DirectExecute("DELETE FROM `groups` WHERE guid NOT IN (SELECT guid FROM group_member GROUP BY guid HAVING COUNT(guid) > 1)");
        //npcbot
        */
        CharacterDatabase.DirectExecute("DELETE FROM `groups` WHERE guid NOT IN (SELECT guid from group_member GROUP BY guid HAVING (SELECT (SELECT COUNT(guid) FROM group_member) + (SELECT COUNT(guid) FROM characters_npcbot_group_member)) > 1)");
        //end npcbot

        // Delete invalid lfg_data
        CharacterDatabase.DirectExecute("DELETE lfg_data FROM lfg_data LEFT JOIN `groups` ON lfg_data.guid = groups.guid WHERE groups.guid IS NULL OR groups.groupType <> 12");
        // CharacterDatabase.DirectExecute("DELETE `groups` FROM `groups` LEFT JOIN lfg_data ON groups.guid = lfg_data.guid WHERE groups.groupType=12 AND lfg_data.guid IS NULL"); // group should be left so binds are cleared when disbanded

        InitGroupIds();

        //                                                        0              1           2             3                 4      5          6      7         8       9
        QueryResult result = CharacterDatabase.Query("SELECT g.leaderGuid, g.lootMethod, g.looterGuid, g.lootThreshold, g.icon1, g.icon2, g.icon3, g.icon4, g.icon5, g.icon6"
                             //  10         11          12         13              14                  15            16        17          18
                             ", g.icon7, g.icon8, g.groupType, g.difficulty, g.raidDifficulty, g.masterLooterGuid, g.guid, lfg.dungeon, lfg.state FROM `groups` g LEFT JOIN lfg_data lfg ON lfg.guid = g.guid ORDER BY g.guid ASC");

        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 group definitions. DB table `groups` is empty!");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                Group* group = new Group;
                if (!group->LoadGroupFromDB(fields))
                {
                    delete group;
                    continue;
                }
                AddGroup(group);

                RegisterGroupId(group->GetGUID().GetCounter());

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} group definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }

    LOG_INFO("server.loading", "Loading Group Members...");
    {
        uint32 oldMSTime = getMSTime();

        // Delete all rows from group_member with no group
        CharacterDatabase.DirectExecute("DELETE FROM group_member WHERE guid NOT IN (SELECT guid FROM `groups`)");
        // Delete all members that does not exist
        CharacterDatabase.DirectExecute("DELETE FROM group_member WHERE memberGuid NOT IN (SELECT guid FROM characters)");

        //                                                    0        1           2            3       4
        QueryResult result = CharacterDatabase.Query("SELECT guid, memberGuid, memberFlags, subgroup, roles FROM group_member ORDER BY guid");
        if (!result)
        {
            LOG_WARN("server.loading", ">> Loaded 0 group members. DB table `group_member` is empty!");
            LOG_INFO("server.loading", " ");
        }
        else
        {
            uint32 count = 0;
            do
            {
                Field* fields = result->Fetch();
                Group* group = GetGroupByGUID(fields[0].Get<uint32>());

                if (group)
                    group->LoadMemberFromDB(fields[1].Get<uint32>(), fields[2].Get<uint8>(), fields[3].Get<uint8>(), fields[4].Get<uint8>());

                ++count;
            } while (result->NextRow());

            LOG_INFO("server.loading", ">> Loaded {} group members in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
            LOG_INFO("server.loading", " ");
        }
    }
}
