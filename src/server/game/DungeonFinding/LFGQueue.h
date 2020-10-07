/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

/// Stores player or group queue info
struct LfgQueueData
{
    LfgQueueData(): joinTime(time_t(time(nullptr))), lastRefreshTime(joinTime), tanks(LFG_TANKS_NEEDED),
        healers(LFG_HEALERS_NEEDED), dps(LFG_DPS_NEEDED)
        { }

    LfgQueueData(time_t _joinTime, LfgDungeonSet const& _dungeons, LfgRolesMap const& _roles):
        joinTime(_joinTime), lastRefreshTime(_joinTime), tanks(LFG_TANKS_NEEDED), healers(LFG_HEALERS_NEEDED),
        dps(LFG_DPS_NEEDED), dungeons(_dungeons), roles(_roles)
        { }

    time_t joinTime;                                       ///< Player queue join time (to calculate wait times)
    time_t lastRefreshTime;                                ///< pussywizard
    uint8 tanks;                                           ///< Tanks needed
    uint8 healers;                                         ///< Healers needed
    uint8 dps;                                             ///< Dps needed
    LfgDungeonSet dungeons;                                ///< Selected Player/Group Dungeon/s
    LfgRolesMap roles;                                     ///< Selected Player Role/s
    Lfg5Guids bestCompatible;                              ///< Best compatible combination of people queued
};

struct LfgWaitTime
{
    LfgWaitTime(): time(-1), number(0) {}
    int32 time;                                            ///< Wait time
    uint32 number;                                         ///< Number of people used to get that wait time
};

typedef std::map<uint32, LfgWaitTime> LfgWaitTimesContainer;
typedef std::map<uint64, LfgQueueData> LfgQueueDataContainer;
typedef std::list<Lfg5Guids> LfgCompatibleContainer;

/**
    Stores all data related to queue
*/
class LFGQueue
{
    public:

        // Add/Remove from queue
        void AddToQueue(uint64 guid, bool failedProposal = false);
        void RemoveFromQueue(uint64 guid, bool partial = false); // xinef: partial remove, dont delete data from list!
        void AddQueueData(uint64 guid, time_t joinTime, LfgDungeonSet const& dungeons, LfgRolesMap const& rolesMap);
        void RemoveQueueData(uint64 guid);

        // Update Timers (when proposal success)
        void UpdateWaitTimeAvg(int32 waitTime, uint32 dungeonId);
        void UpdateWaitTimeTank(int32 waitTime, uint32 dungeonId);
        void UpdateWaitTimeHealer(int32 waitTime, uint32 dungeonId);
        void UpdateWaitTimeDps(int32 waitTime, uint32 dungeonId);

        // Update Queue timers
        void UpdateQueueTimers(uint32 diff);
        time_t GetJoinTime(uint64 guid);

        // Find new group
        uint8 FindGroups();

    private:
        void SetQueueUpdateData(std::string const& strGuids, LfgRolesMap const& proposalRoles);

        void AddToNewQueue(uint64 guid, bool front);
        void RemoveFromNewQueue(uint64 guid);

        void RemoveFromCompatibles(uint64 guid);
        void AddToCompatibles(Lfg5Guids const& key);

        uint32 FindBestCompatibleInQueue(LfgQueueDataContainer::iterator itrQueue);
        void UpdateBestCompatibleInQueue(LfgQueueDataContainer::iterator itrQueue, Lfg5Guids const& key);

        LfgCompatibility FindNewGroups(const uint64& newGuid);
        LfgCompatibility CheckCompatibility(Lfg5Guids const& checkWith, const uint64& newGuid, uint64& foundMask, uint32& foundCount, const std::set<Lfg5Guids>& currentCompatibles);

        // Queue
        uint32 m_QueueStatusTimer;                         ///< used to check interval of sending queue status
        LfgQueueDataContainer QueueDataStore;              ///< Queued groups
        LfgCompatibleContainer CompatibleList;             ///< Compatible dungeons
        LfgCompatibleContainer CompatibleTempList;         ///< new compatibles are added to this container while main one is being iterated

        LfgWaitTimesContainer waitTimesAvgStore;           ///< Average wait time to find a group queuing as multiple roles
        LfgWaitTimesContainer waitTimesTankStore;          ///< Average wait time to find a group queuing as tank
        LfgWaitTimesContainer waitTimesHealerStore;        ///< Average wait time to find a group queuing as healer
        LfgWaitTimesContainer waitTimesDpsStore;           ///< Average wait time to find a group queuing as dps
        LfgGuidList newToQueueStore;                       ///< New groups to add to queue
        LfgGuidList restoredAfterProposal;
};

} // namespace lfg

#endif
