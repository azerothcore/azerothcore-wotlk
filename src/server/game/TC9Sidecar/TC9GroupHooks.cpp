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

#include "TC9GroupHooks.h"
#include "CharacterCache.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Log.h"

void ToCloud9GroupHooks::OnGroupCreated(EventObjectGroup *group)
{
    LOG_INFO("server", "Group created. ID: {}; Leader: {}.", group->guid, group->leader);

    // Idempotent under sidecar event redelivery: a replayed create must not leak a second Group.
    if (sGroupMgr->GetGroupByGUID(group->guid))
        return;

    Group* g = new Group();
    g->m_guid = ObjectGuid(HighGuid::Group, group->guid);
    g->m_leaderGuid = ObjectGuid(group->leader);
    sCharacterCache->GetCharacterNameByGuid(g->m_leaderGuid, g->m_leaderName);
    g->m_dungeonDifficulty = Difficulty(group->difficulty);
    g->m_raidDifficulty = Difficulty(group->raidDifficulty);
    g->m_lootMethod = LootMethod(group->lootMethod);
    g->m_lootThreshold = ItemQualities(group->lootThreshold);
    g->m_looterGuid = ObjectGuid(group->looterGuid);
    g->m_masterLooterGuid = ObjectGuid(group->masterLooterGuid);
    g->m_groupType = GroupType(group->groupType);

    // Must precede member insertion: it zeroes the subgroup counters that AddMemberWithGuid increments.
    if (g->m_groupType & GROUPTYPE_RAID)
        g->_initRaidSubGroupsCounter();

    for (int i = 0; i < group->membersSize; i++)
        g->AddMemberWithGuid(ObjectGuid(group->members[i]));

    sGroupMgr->AddGroup(g);
}

void ToCloud9GroupHooks::OnGroupDisbanded(uint32 group)
{
    LOG_INFO("server", "Group disbanded. ID: {}.", group);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
        g->ForcedDisband(true);
}

void ToCloud9GroupHooks::OnGroupMemberAdded(uint32 group, uint64 member)
{
    LOG_INFO("server", "Group member added. ID: {}; Member: {}.", group, member);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
        g->AddMemberWithGuid(ObjectGuid(member));
}

void ToCloud9GroupHooks::OnGroupMemberRemoved(uint32 group, uint64 member, uint64 newLeader)
{
    LOG_INFO("server", "Group member removed. ID: {}; Member: {}; NewLeader: {}.", group, member, newLeader);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
        g->RemoveMember(ObjectGuid(member));
}

void ToCloud9GroupHooks::OnGroupLootTypeChanged(uint32 group, uint8 lootType, uint64 looter, uint8 lootThreshold)
{
    LOG_INFO("server", "Group loot type changed. ID: {}; LootType: {}; Looter: {}; LootThreshold: {}.",
             group, lootType, looter, lootThreshold);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
    {
        g->SetLootMethod((LootMethod)lootType);
        g->SetMasterLooterGuid(ObjectGuid(looter));
        g->SetLootThreshold((ItemQualities)lootThreshold);
    }
}

void ToCloud9GroupHooks::OnGroupConvertedToRaid(uint32 group)
{
    LOG_INFO("server", "Group converted to raid. ID: {}.", group);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
        g->ConvertToRaid();
}

void ToCloud9GroupHooks::OnGroupRaidDifficultyChanged(uint32 group, uint8 difficulty)
{
    LOG_INFO("server", "Raid difficulty changed. ID: {}; Difficulty: {}.", group, difficulty);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
        g->SetRaidDifficulty((Difficulty)difficulty);
}

void ToCloud9GroupHooks::OnGroupDungeonDifficultyChanged(uint32 group, uint8 difficulty)
{
    LOG_INFO("server", "Dungeon difficulty changed. ID: {}; Difficulty: {}.", group, difficulty);

    if (Group* g = sGroupMgr->GetGroupByGUID(group))
        g->SetDungeonDifficulty((Difficulty)difficulty);
}
