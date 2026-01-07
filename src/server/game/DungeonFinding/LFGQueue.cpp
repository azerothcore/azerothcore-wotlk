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

#include "LFGQueue.h"
#include "Containers.h"
#include "DBCStores.h"
#include "GameTime.h"
#include "Group.h"
#include "InstanceScript.h"
#include "LFGMgr.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "World.h"

namespace lfg
{
    LfgQueueData::LfgQueueData() :
        joinTime(time_t(GameTime::GetGameTime().count())), lastRefreshTime(joinTime), tanks(LFG_TANKS_NEEDED),
        healers(LFG_HEALERS_NEEDED), dps(LFG_DPS_NEEDED) { }

    void LFGQueue::AddToQueue(ObjectGuid guid, bool failedProposal)
    {
        LOG_DEBUG("lfg", "ADD AddToQueue: {}, failed proposal: {}", guid.ToString(), failedProposal ? 1 : 0);
        LfgQueueDataContainer::iterator itQueue = QueueDataStore.find(guid);
        if (itQueue == QueueDataStore.end())
        {
            LOG_ERROR("lfg", "LFGQueue::AddToQueue: Queue data not found for [{}]", guid.ToString());
            return;
        }
        LOG_DEBUG("lfg", "AddToQueue success: {}", guid.ToString());
        AddToNewQueue(guid, failedProposal);
    }

    void LFGQueue::RemoveFromQueue(ObjectGuid guid, bool partial)
    {
        LOG_DEBUG("lfg", "REMOVE RemoveFromQueue: {}, partial: {}", guid.ToString(), partial ? 1 : 0);
        RemoveFromNewQueue(guid);
        RemoveFromCompatibles(guid);

        LfgQueueDataContainer::iterator itDelete = QueueDataStore.end();
        for (LfgQueueDataContainer::iterator itr = QueueDataStore.begin(); itr != QueueDataStore.end(); ++itr)
        {
            if (itr->first != guid)
            {
                if (itr->second.bestCompatible.hasGuid(guid))
                {
                    LOG_DEBUG("lfg", "CLEAR bestCompatible: {}, because of: {}", itr->second.bestCompatible.toString(), guid.ToString());
                    itr->second.bestCompatible.clear();
                }
            }
            else
            {
                LOG_DEBUG("lfg", "CLEAR bestCompatible SELF: {}, because of: {}", itr->second.bestCompatible.toString(), guid.ToString());
                //itr->second.bestCompatible.clear(); // don't clear here, because UpdateQueueTimers will try to find with every diff update
                itDelete = itr;
            }
        }

        // xinef: partial
        if (!partial && itDelete != QueueDataStore.end())
        {
            LOG_DEBUG("lfg", "ERASE QueueDataStore for: {}", guid.ToString());
            LOG_DEBUG("lfg", "ERASE QueueDataStore for: {}, itDelete: {},{},{}", guid.ToString(), itDelete->second.dps, itDelete->second.healers, itDelete->second.tanks);
            QueueDataStore.erase(itDelete);
            LOG_DEBUG("lfg", "ERASE QueueDataStore for: {} SUCCESS", guid.ToString());
        }
    }

    void LFGQueue::AddToNewQueue(ObjectGuid guid, bool front)
    {
        if (front)
        {
            LOG_DEBUG("lfg", "ADD AddToNewQueue at FRONT: {}", guid.ToString());
            restoredAfterProposal.push_back(guid);
            newToQueueStore.push_front(guid);
        }
        else
        {
            LOG_DEBUG("lfg", "ADD AddToNewQueue at the END: {}", guid.ToString());
            newToQueueStore.push_back(guid);
        }
    }

    void LFGQueue::RemoveFromNewQueue(ObjectGuid guid)
    {
        LOG_DEBUG("lfg", "REMOVE RemoveFromNewQueue: {}", guid.ToString());
        newToQueueStore.remove(guid);
        restoredAfterProposal.remove(guid);
    }

    void LFGQueue::AddQueueData(ObjectGuid guid, time_t joinTime, LfgDungeonSet const& dungeons, LfgRolesMap const& rolesMap)
    {
        LOG_DEBUG("lfg", "JOINED AddQueueData: {}", guid.ToString());
        QueueDataStore[guid] = LfgQueueData(joinTime, dungeons, rolesMap);
        AddToQueue(guid);
    }

    void LFGQueue::RemoveQueueData(ObjectGuid guid)
    {
        LOG_DEBUG("lfg", "LEFT RemoveQueueData: {}", guid.ToString());
        LfgQueueDataContainer::iterator it = QueueDataStore.find(guid);
        if (it != QueueDataStore.end())
            QueueDataStore.erase(it);
    }

    void LFGQueue::UpdateWaitTimeAvg(int32 waitTime, uint32 dungeonId)
    {
        LfgWaitTime& wt = waitTimesAvgStore[dungeonId];
        uint32 old_number = wt.number++;
        wt.time = int32((wt.time * old_number + waitTime) / wt.number);
    }

    void LFGQueue::UpdateWaitTimeTank(int32 waitTime, uint32 dungeonId)
    {
        LfgWaitTime& wt = waitTimesTankStore[dungeonId];
        uint32 old_number = wt.number++;
        wt.time = int32((wt.time * old_number + waitTime) / wt.number);
    }

    void LFGQueue::UpdateWaitTimeHealer(int32 waitTime, uint32 dungeonId)
    {
        LfgWaitTime& wt = waitTimesHealerStore[dungeonId];
        uint32 old_number = wt.number++;
        wt.time = int32((wt.time * old_number + waitTime) / wt.number);
    }

    void LFGQueue::UpdateWaitTimeDps(int32 waitTime, uint32 dungeonId)
    {
        LfgWaitTime& wt = waitTimesDpsStore[dungeonId];
        uint32 old_number = wt.number++;
        wt.time = int32((wt.time * old_number + waitTime) / wt.number);
    }

    void LFGQueue::RemoveFromCompatibles(ObjectGuid guid)
    {
        LOG_DEBUG("lfg", "COMPATIBLES REMOVE for: {}", guid.ToString());
        for (LfgCompatibleContainer::iterator it = CompatibleList.begin(); it != CompatibleList.end(); ++it)
            if (it->hasGuid(guid))
            {
                LOG_DEBUG("lfg", "Removed Compatible: {}, because of: {}", it->toString(), guid.ToString());
                it->clear(); // set to 0, this will be removed while iterating in FindNewGroups
            }
        for (LfgCompatibleContainer::iterator itr = CompatibleTempList.begin(); itr != CompatibleTempList.end(); )
        {
            LfgCompatibleContainer::iterator it = itr++;
            if (it->hasGuid(guid))
            {
                LOG_DEBUG("lfg", "Erased Temp Compatible: {}, because of: {}", it->toString(), guid.ToString());
                CompatibleTempList.erase(it);
            }
        }
    }

    void LFGQueue::AddToCompatibles(Lfg5Guids const& key)
    {
        LOG_DEBUG("lfg", "COMPATIBLES ADD: {}", key.toString());
        CompatibleTempList.push_back(key);
    }

    uint8 LFGQueue::FindGroups()
    {
        LOG_DEBUG("lfg", "FIND GROUPS!");
        uint8 newGroupsProcessed = 0;
        if (!newToQueueStore.empty())
        {
            ++newGroupsProcessed;
            ObjectGuid newGuid = newToQueueStore.front();
            bool pushCompatiblesToFront = (std::find(restoredAfterProposal.begin(), restoredAfterProposal.end(), newGuid) != restoredAfterProposal.end());
            LOG_DEBUG("lfg", "newToQueueStore: {}, front: {}", newGuid.ToString(), pushCompatiblesToFront ? 1 : 0);
            RemoveFromNewQueue(newGuid);

            FindNewGroups(newGuid);

            CompatibleList.splice((pushCompatiblesToFront ? CompatibleList.begin() : CompatibleList.end()), CompatibleTempList);
            CompatibleTempList.clear();

            return newGroupsProcessed; // pussywizard: only one per update, shouldn't be a problem
        }
        return newGroupsProcessed;
    }

    LfgCompatibility LFGQueue::FindNewGroups(const ObjectGuid& newGuid)
    {
        // each combination of dps+heal+tank (tank*8 + heal+4 + dps) has a value assigned 0..15
        // first 16 bits of the mask are for marking if such combination was found once, second 16 bits for marking second occurence of that combination, etc
        uint64 foundMask = 0;
        uint32 foundCount = 0;

        LOG_DEBUG("lfg", "FIND NEW GROUPS for: {}", newGuid.ToString());

        // we have to take into account that FindNewGroups is called every X minutes if number of compatibles is low!
        // build set of already present compatibles for this guid
        std::set<Lfg5Guids> currentCompatibles;
        for (Lfg5GuidsList::iterator it = CompatibleList.begin(); it != CompatibleList.end(); ++it)
            if (it->hasGuid(newGuid))
            {
                // unset roles here so they are not copied, restore after insertion
                LfgRolesMap* r = it->roles;
                it->roles = nullptr;
                currentCompatibles.insert(*it);
                it->roles = r;
            }

        LfgCompatibility selfCompatibility = LFG_COMPATIBILITY_PENDING;
        if (currentCompatibles.empty())
        {
            selfCompatibility = CheckCompatibility(Lfg5Guids(), newGuid, foundMask, foundCount, currentCompatibles);
            if (selfCompatibility != LFG_COMPATIBLES_WITH_LESS_PLAYERS) // group is already compatible (a party of 5 players)
                return selfCompatibility;
        }

        for (Lfg5GuidsList::iterator it = CompatibleList.begin(); it != CompatibleList.end(); )
        {
            Lfg5GuidsList::iterator itr = it++;
            if (itr->empty())
            {
                LOG_DEBUG("lfg", "ERASE from CompatibleList");
                CompatibleList.erase(itr);
                continue;
            }
            LfgCompatibility compatibility = CheckCompatibility(*itr, newGuid, foundMask, foundCount, currentCompatibles);
            if (compatibility == LFG_COMPATIBLES_MATCH)
                return LFG_COMPATIBLES_MATCH;
            if ((foundMask & 0x3FFF3FFF3FFF3FFF) == 0x3FFF3FFF3FFF3FFF) // each combination of dps+heal+tank already found 4 times
                break;
        }

        return selfCompatibility;
    }

    LfgCompatibility LFGQueue::CheckCompatibility(Lfg5Guids const& checkWith, const ObjectGuid& newGuid, uint64& foundMask, uint32& foundCount, const std::set<Lfg5Guids>& currentCompatibles)
    {
        LOG_DEBUG("lfg", "CHECK CheckCompatibility: {}, new guid: {}", checkWith.toString(), newGuid.ToString());
        Lfg5Guids check(checkWith, false); // here newGuid is at front
        Lfg5Guids strGuids(checkWith, false); // here guids are sorted
        check.force_insert_front(newGuid);
        strGuids.insert(newGuid);

        if (!currentCompatibles.empty() && currentCompatibles.find(strGuids) != currentCompatibles.end())
            return LFG_INCOMPATIBLES_TOO_MUCH_PLAYERS;

        LfgProposal proposal;
        LfgDungeonSet proposalDungeons;
        LfgGroupsMap proposalGroups;
        LfgRolesMap proposalRoles;

        // Check if more than one LFG group and number of players joining
        uint8 numPlayers = 0;
        uint8 numLfgGroups = 0;
        ObjectGuid guid;
        uint64 addToFoundMask = 0;

        for (uint8 i = 0; i < 5 && !(guid = check.guids[i]).IsEmpty() && numLfgGroups < 2 && numPlayers <= MAXGROUPSIZE; ++i)
        {
            LfgQueueDataContainer::iterator itQueue = QueueDataStore.find(guid);
            if (itQueue == QueueDataStore.end())
            {
                LOG_ERROR("lfg", "LFGQueue::CheckCompatibility: [{}] is not queued but listed as queued!", guid.ToString());
                RemoveFromQueue(guid);
                return LFG_COMPATIBILITY_PENDING;
            }

            // Store group so we don't need to call Mgr to get it later (if it's player group will be 0 otherwise would have joined as group)
            for (LfgRolesMap::const_iterator it2 = itQueue->second.roles.begin(); it2 != itQueue->second.roles.end(); ++it2)
                proposalGroups[it2->first] = itQueue->first.IsGroup() ? itQueue->first : ObjectGuid::Empty;

            numPlayers += itQueue->second.roles.size();

            if (sLFGMgr->IsLfgGroup(guid))
            {
                if (!numLfgGroups)
                    proposal.group = guid;
                ++numLfgGroups;
            }
        }

        if (numLfgGroups > 1)
            return LFG_INCOMPATIBLES_MULTIPLE_LFG_GROUPS;

        // Group with less that MAXGROUPSIZE members always compatible
        if (!sLFGMgr->IsTesting() && check.size() == 1 && numPlayers < MAXGROUPSIZE)
        {
            LfgQueueDataContainer::iterator itQueue = QueueDataStore.find(check.front());
            LfgRolesMap roles = itQueue->second.roles;
            uint8 roleCheckResult = LFGMgr::CheckGroupRoles(roles);
            strGuids.addRoles(roles);
            itQueue->second.bestCompatible.clear(); // this may be left after a failed proposal (not cleared, because UpdateQueueTimers would try to generate it with every update)
            //UpdateBestCompatibleInQueue(itQueue, strGuids);
            AddToCompatibles(strGuids);
            if (roleCheckResult && roleCheckResult <= 15)
                foundMask |= ( (((uint64)1) << (roleCheckResult - 1)) | (((uint64)1) << (16 + roleCheckResult - 1)) | (((uint64)1) << (32 + roleCheckResult - 1)) | (((uint64)1) << (48 + roleCheckResult - 1)));
            return LFG_COMPATIBLES_WITH_LESS_PLAYERS;
        }

        if (numPlayers > MAXGROUPSIZE)
            return LFG_INCOMPATIBLES_TOO_MUCH_PLAYERS;

        // If it's single group no need to check for duplicate players, ignores, bad roles or bad dungeons as it's been checked before joining
        if (check.size() > 1)
        {
            for (uint8 i = 0; i < 5 && check.guids[i]; ++i)
            {
                const LfgRolesMap& roles = QueueDataStore[check.guids[i]].roles;
                for (LfgRolesMap::const_iterator itRoles = roles.begin(); itRoles != roles.end(); ++itRoles)
                {
                    LfgRolesMap::const_iterator itPlayer;
                    for (itPlayer = proposalRoles.begin(); itPlayer != proposalRoles.end(); ++itPlayer)
                    {
                        if (itRoles->first == itPlayer->first)
                        {
                            // pussywizard: LFG this means that this player was in two different LfgQueueData (in QueueDataStore), and at least one of them is a group guid, because we do checks so there aren't 2 same guids in current CHECK
                            //LOG_ERROR("lfg", "LFGQueue::CheckCompatibility: ERROR! Player multiple times in queue! [{}]", itRoles->first.ToString());
                            break;
                        }
                        else if (sLFGMgr->HasIgnore(itRoles->first, itPlayer->first))
                            break;
                    }
                    if (itPlayer == proposalRoles.end())
                        proposalRoles[itRoles->first] = itRoles->second;
                    else
                        break;
                }
            }

            if (numPlayers != proposalRoles.size())
                return LFG_INCOMPATIBLES_HAS_IGNORES;

            uint8 roleCheckResult = LFGMgr::CheckGroupRoles(proposalRoles);
            if (!roleCheckResult || roleCheckResult > 0xF)
                return LFG_INCOMPATIBLES_NO_ROLES;

            // now, every combination can occur only 4 times (explained in FindNewGroups)
            if (foundMask & (((uint64)1) << (roleCheckResult - 1)))
            {
                if (foundMask & (((uint64)1) << (16 + roleCheckResult - 1)))
                {
                    if (foundMask & (((uint64)1) << (32 + roleCheckResult - 1)))
                    {
                        if (foundMask & (((uint64)1) << (48 + roleCheckResult - 1)))
                        {
                            if (foundCount >= 10) // but only after finding at least 10 compatibles (this helps when there are few groups)
                                return LFG_INCOMPATIBLES_NO_ROLES;
                        }
                        else
                            addToFoundMask |= (((uint64)1) << (48 + roleCheckResult - 1));
                    }
                    else
                        addToFoundMask |= (((uint64)1) << (32 + roleCheckResult - 1));
                }
                else
                    addToFoundMask |= (((uint64)1) << (16 + roleCheckResult - 1));
            }
            else
                addToFoundMask |= (((uint64)1) << (roleCheckResult - 1));

            proposalDungeons = QueueDataStore[check.front()].dungeons;
            for (uint8 i = 1; i < 5 && check.guids[i]; ++i)
            {
                LfgDungeonSet temporal;
                LfgDungeonSet& dungeons = QueueDataStore[check.guids[i]].dungeons;
                std::set_intersection(proposalDungeons.begin(), proposalDungeons.end(), dungeons.begin(), dungeons.end(), std::inserter(temporal, temporal.begin()));
                proposalDungeons = temporal;
            }

            if (proposalDungeons.empty())
                return LFG_INCOMPATIBLES_NO_DUNGEONS;
        }
        else
        {
            ObjectGuid gguid = check.front();
            const LfgQueueData& queue = QueueDataStore[gguid];
            proposalDungeons = queue.dungeons;
            proposalRoles = queue.roles;
            LFGMgr::CheckGroupRoles(proposalRoles);          // assing new roles
        }

        // Enough players?
        if (!sLFGMgr->IsTesting() && numPlayers != MAXGROUPSIZE)
        {
            strGuids.addRoles(proposalRoles);
            for (uint8 i = 0; i < 5 && check.guids[i]; ++i)
            {
                LfgQueueDataContainer::iterator itr = QueueDataStore.find(check.guids[i]);
                if (!itr->second.bestCompatible.empty()) // update if groups don't have it empty (for empty it will be generated in UpdateQueueTimers)
                    UpdateBestCompatibleInQueue(itr, strGuids);
            }
            AddToCompatibles(strGuids);
            foundMask |= addToFoundMask;
            ++foundCount;
            return LFG_COMPATIBLES_WITH_LESS_PLAYERS;
        }

        proposal.queues = strGuids;
        proposal.isNew = numLfgGroups != 1;

        if (!sLFGMgr->AllQueued(check)) // can't create proposal
            return LFG_COMPATIBILITY_PENDING;

        // Create a new proposal
        proposal.cancelTime = GameTime::GetGameTime().count() + LFG_TIME_PROPOSAL;
        proposal.state = LFG_PROPOSAL_INITIATING;
        proposal.leader.Clear();
        proposal.dungeonId = Acore::Containers::SelectRandomContainerElement(proposalDungeons);

        uint32 completedEncounters = 0;
        bool leader = false;
        for (LfgRolesMap::const_iterator itRoles = proposalRoles.begin(); itRoles != proposalRoles.end(); ++itRoles)
        {
            // Assing new leader
            if (itRoles->second & PLAYER_ROLE_LEADER)
            {
                if (!leader || !proposal.leader || urand(0, 1))
                    proposal.leader = itRoles->first;
                leader = true;
            }
            else if (!leader && (!proposal.leader || urand(0, 1)))
                proposal.leader = itRoles->first;

            // Assing player data and roles
            LfgProposalPlayer& data = proposal.players[itRoles->first];
            data.role = itRoles->second;
            data.group = proposalGroups.find(itRoles->first)->second;
            if (!proposal.isNew && data.group && data.group == proposal.group) // Player from existing group, autoaccept
                data.accept = LFG_ANSWER_AGREE;

            if (!completedEncounters && !proposal.isNew)
            {
                if (LFGDungeonEntry const* dungeon = sLFGDungeonStore.LookupEntry(proposal.dungeonId))
                {
                    if (Player* player = ObjectAccessor::FindConnectedPlayer(itRoles->first))
                    {
                        if (player->GetMapId() == static_cast<uint32>(dungeon->MapID))
                        {
                            if (InstanceScript* instance = player->GetInstanceScript())
                            {
                                completedEncounters = instance->GetCompletedEncounterMask();
                            }
                        }
                    }
                }
            }
        }

        proposal.encounters = completedEncounters;

        for (uint8 i = 0; i < 5 && proposal.queues.guids[i]; ++i)
            RemoveFromQueue(proposal.queues.guids[i], true);

        sLFGMgr->AddProposal(proposal);

        return LFG_COMPATIBLES_MATCH;
    }

    void LFGQueue::UpdateQueueTimers(uint32 diff)
    {
        time_t currTime = GameTime::GetGameTime().count();
        bool sendQueueStatus = false;

        if (m_QueueStatusTimer > LFG_QUEUEUPDATE_INTERVAL)
        {
            m_QueueStatusTimer = 0;
            sendQueueStatus = true;
        }
        else
            m_QueueStatusTimer += diff;

        LOG_DEBUG("lfg", "UPDATE UpdateQueueTimers");
        for (Lfg5GuidsList::iterator it = CompatibleList.begin(); it != CompatibleList.end(); )
        {
            Lfg5GuidsList::iterator itr = it++;
            if (itr->empty())
            {
                LOG_DEBUG("lfg", "UpdateQueueTimers ERASE compatible");
                CompatibleList.erase(itr);
            }
        }

        if (!sendQueueStatus)
        {
            for (LfgQueueDataContainer::iterator itQueue = QueueDataStore.begin(); itQueue != QueueDataStore.end(); )
            {
                if (currTime - itQueue->second.joinTime > 2 * HOUR)
                {
                    ObjectGuid guid = itQueue->first;
                    QueueDataStore.erase(itQueue++);
                    sLFGMgr->LeaveAllLfgQueues(guid, true);
                    continue;
                }
                if (itQueue->second.bestCompatible.empty())
                {
                    uint32 numOfCompatibles = FindBestCompatibleInQueue(itQueue);
                    if (numOfCompatibles /*must be positive, because proposals don't delete QueueQueueData*/ && currTime - itQueue->second.lastRefreshTime >= 60 && numOfCompatibles < (5 - itQueue->second.bestCompatible.roles->size()) * 25)
                    {
                        itQueue->second.lastRefreshTime = currTime;
                        AddToQueue(itQueue->first, false);
                    }
                }
                ++itQueue;
            }
            return;
        }

        // LOG_TRACE("lfg", "Updating queue timers...");
        for (LfgQueueDataContainer::iterator itQueue = QueueDataStore.begin(); itQueue != QueueDataStore.end(); ++itQueue)
        {
            LfgQueueData& queueinfo = itQueue->second;
            uint32 dungeonId = (*queueinfo.dungeons.begin());
            uint32 queuedTime = uint32(currTime - queueinfo.joinTime);
            uint8 role = PLAYER_ROLE_NONE;
            int32 waitTime = -1;
            int32 wtTank = waitTimesTankStore[dungeonId].time;
            int32 wtHealer = waitTimesHealerStore[dungeonId].time;
            int32 wtDps = waitTimesDpsStore[dungeonId].time;
            int32 wtAvg = waitTimesAvgStore[dungeonId].time;

            for (LfgRolesMap::const_iterator itPlayer = queueinfo.roles.begin(); itPlayer != queueinfo.roles.end(); ++itPlayer)
                role |= itPlayer->second;
            role &= ~PLAYER_ROLE_LEADER;

            switch (role)
            {
                case PLAYER_ROLE_NONE:                                // Should not happen - just in case
                    waitTime = -1;
                    break;
                case PLAYER_ROLE_TANK:
                    waitTime = wtTank;
                    break;
                case PLAYER_ROLE_HEALER:
                    waitTime = wtHealer;
                    break;
                case PLAYER_ROLE_DAMAGE:
                    waitTime = wtDps;
                    break;
                default:
                    waitTime = wtAvg;
                    break;
            }

            if (queueinfo.bestCompatible.empty())
            {
                LOG_DEBUG("lfg", "found empty bestCompatible");
                FindBestCompatibleInQueue(itQueue);
            }

            LfgQueueStatusData queueData(dungeonId, waitTime, wtAvg, wtTank, wtHealer, wtDps, queuedTime, queueinfo.tanks, queueinfo.healers, queueinfo.dps);
            for (LfgRolesMap::const_iterator itPlayer = queueinfo.roles.begin(); itPlayer != queueinfo.roles.end(); ++itPlayer)
            {
                ObjectGuid pguid = itPlayer->first;
                LFGMgr::SendLfgQueueStatus(pguid, queueData);
            }
        }
    }

    time_t LFGQueue::GetJoinTime(ObjectGuid guid)
    {
        return QueueDataStore[guid].joinTime;
    }

    uint32 LFGQueue::FindBestCompatibleInQueue(LfgQueueDataContainer::iterator itrQueue)
    {
        uint32 numOfCompatibles = 0;
        for (LfgCompatibleContainer::const_iterator itr = CompatibleList.begin(); itr != CompatibleList.end(); ++itr)
            if (itr->hasGuid(itrQueue->first))
            {
                ++numOfCompatibles;
                UpdateBestCompatibleInQueue(itrQueue, *itr);
            }
        return numOfCompatibles;
    }

    void LFGQueue::UpdateBestCompatibleInQueue(LfgQueueDataContainer::iterator itrQueue, Lfg5Guids const& key)
    {
        LOG_DEBUG("lfg", "UpdateBestCompatibleInQueue: {}", key.toString());
        LfgQueueData& queueData = itrQueue->second;

        uint8 storedSize = queueData.bestCompatible.size();
        uint8 size = key.size();

        if (size <= storedSize)
            return;

        queueData.bestCompatible = key;
        queueData.tanks = LFG_TANKS_NEEDED;
        queueData.healers = LFG_HEALERS_NEEDED;
        queueData.dps = LFG_DPS_NEEDED;
        for (LfgRolesMap::const_iterator it = key.roles->begin(); it != key.roles->end(); ++it)
        {
            uint8 role = it->second;
            if (role & PLAYER_ROLE_TANK)
                --queueData.tanks;
            else if (role & PLAYER_ROLE_HEALER)
                --queueData.healers;
            else
                --queueData.dps;
        }
    }

} // namespace lfg
