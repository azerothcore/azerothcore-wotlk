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

#ifndef _LFGQUEUE_H
#define _LFGQUEUE_H

#include "LFG.h"

namespace lfg
{
    enum LfgCompatibility
    {
        LFG_COMPATIBILITY_PENDING,
        LFG_INCOMPATIBLES_WRONG_GROUP_SIZE,
        LFG_INCOMPATIBLES_TOO_MUCH_PLAYERS,
        LFG_INCOMPATIBLES_MULTIPLE_LFG_GROUPS,
        LFG_INCOMPATIBLES_HAS_IGNORES,
        LFG_INCOMPATIBLES_NO_ROLES,
        LFG_INCOMPATIBLES_NO_DUNGEONS,
        LFG_COMPATIBLES_WITH_LESS_PLAYERS,                     // Values under this = not compatible (do not modify order)
        LFG_COMPATIBLES_MATCH                                  // Must be the last one
    };

    // Stores player or group queue info
    struct LfgQueueData
    {
        LfgQueueData();

        LfgQueueData(time_t _joinTime, LfgDungeonSet  _dungeons, LfgRolesMap  _roles):
            joinTime(_joinTime), lastRefreshTime(_joinTime), tanks(LFG_TANKS_NEEDED), healers(LFG_HEALERS_NEEDED),
            dps(LFG_DPS_NEEDED), dungeons(std::move(_dungeons)), roles(std::move(_roles))
        { }

        time_t joinTime;                                       // Player queue join time (to calculate wait times)
        time_t lastRefreshTime;                                // pussywizard
        uint8 tanks{LFG_TANKS_NEEDED};                         // Tanks needed
        uint8 healers{LFG_HEALERS_NEEDED};                     // Healers needed
        uint8 dps{LFG_DPS_NEEDED};                             // Dps needed
        LfgDungeonSet dungeons;                                // Selected Player/Group Dungeon/s
        LfgRolesMap roles;                                     // Selected Player Role/s
        Lfg5Guids bestCompatible;                              // Best compatible combination of people queued
    };

    struct LfgWaitTime
    {
        LfgWaitTime() = default;
        int32 time{-1};                                        // Wait time
        uint32 number{0};                                      // Number of people used to get that wait time
    };

    typedef std::map<uint32, LfgWaitTime> LfgWaitTimesContainer;
    typedef std::map<ObjectGuid, LfgQueueData> LfgQueueDataContainer;
    typedef std::list<Lfg5Guids> LfgCompatibleContainer;

    /**
        Stores all data related to queue
    */
    class LFGQueue
    {
    public:
        // Add/Remove from queue
        void AddToQueue(ObjectGuid guid, bool failedProposal = false);
        void RemoveFromQueue(ObjectGuid guid, bool partial = false); // xinef: partial remove, dont delete data from list!
        void AddQueueData(ObjectGuid guid, time_t joinTime, LfgDungeonSet const& dungeons, LfgRolesMap const& rolesMap);
        void RemoveQueueData(ObjectGuid guid);

        // Update Timers (when proposal success)
        void UpdateWaitTimeAvg(int32 waitTime, uint32 dungeonId);
        void UpdateWaitTimeTank(int32 waitTime, uint32 dungeonId);
        void UpdateWaitTimeHealer(int32 waitTime, uint32 dungeonId);
        void UpdateWaitTimeDps(int32 waitTime, uint32 dungeonId);

        // Update Queue timers
        void UpdateQueueTimers(uint32 diff);
        time_t GetJoinTime(ObjectGuid guid);

        // Find new group
        uint8 FindGroups();

    private:
        void SetQueueUpdateData(std::string const& strGuids, LfgRolesMap const& proposalRoles);

        void AddToNewQueue(ObjectGuid guid, bool front);
        void RemoveFromNewQueue(ObjectGuid guid);

        void RemoveFromCompatibles(ObjectGuid guid);
        void AddToCompatibles(Lfg5Guids const& key);

        uint32 FindBestCompatibleInQueue(LfgQueueDataContainer::iterator itrQueue);
        void UpdateBestCompatibleInQueue(LfgQueueDataContainer::iterator itrQueue, Lfg5Guids const& key);

        LfgCompatibility FindNewGroups(const ObjectGuid& newGuid);
        LfgCompatibility CheckCompatibility(Lfg5Guids const& checkWith, const ObjectGuid& newGuid, uint64& foundMask, uint32& foundCount, const std::set<Lfg5Guids>& currentCompatibles);

        // Queue
        uint32 m_QueueStatusTimer;                         // used to check interval of sending queue status
        LfgQueueDataContainer QueueDataStore;              // Queued groups
        LfgCompatibleContainer CompatibleList;             // Compatible dungeons
        LfgCompatibleContainer CompatibleTempList;         // new compatibles are added to this container while main one is being iterated

        LfgWaitTimesContainer waitTimesAvgStore;           // Average wait time to find a group queuing as multiple roles
        LfgWaitTimesContainer waitTimesTankStore;          // Average wait time to find a group queuing as tank
        LfgWaitTimesContainer waitTimesHealerStore;        // Average wait time to find a group queuing as healer
        LfgWaitTimesContainer waitTimesDpsStore;           // Average wait time to find a group queuing as dps
        LfgGuidList newToQueueStore;                       // New groups to add to queue
        LfgGuidList restoredAfterProposal;
    };
}

#endif
