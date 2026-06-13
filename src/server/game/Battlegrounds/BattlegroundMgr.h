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

#ifndef __BATTLEGROUNDMGR_H
#define __BATTLEGROUNDMGR_H

#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "CreatureAIImpl.h"
#include "DBCEnums.h"
#include <unordered_map>

typedef std::map<uint32, Battleground*> BattlegroundContainer;
typedef std::set<uint32> BattlegroundClientIdsContainer;
typedef std::unordered_map<uint32, BattlegroundTypeId> BattleMastersMap;
typedef Battleground* (*bgRef)(Battleground*);

typedef void(*bgMapRef)(WorldPacket*, Battleground::BattlegroundScoreMap::const_iterator);
typedef void(*bgTypeRef)(WorldPacket*, Battleground::BattlegroundScoreMap::const_iterator, Battleground*);

// this container can't be deque, because deque doesn't like removing the last element - if you remove it, it invalidates next iterator and crash appears
using BGFreeSlotQueueContainer = std::list<Battleground*>;

struct BattlegroundData
{
    BattlegroundContainer _Battlegrounds;
    std::array<BattlegroundClientIdsContainer, MAX_BATTLEGROUND_BRACKETS> _ClientBattlegroundIds;
    BGFreeSlotQueueContainer BGFreeSlotQueue;
};

struct BattlegroundTemplate
{
    BattlegroundTypeId Id;
    uint16 MinPlayersPerTeam;
    uint16 MaxPlayersPerTeam;
    uint8 MinLevel;
    uint8 MaxLevel;
    std::array<Position, PVP_TEAMS_COUNT> StartLocation;
    float MaxStartDistSq;
    uint8 Weight;
    uint32 ScriptId;
    BattlemasterListEntry const* BattlemasterEntry;

    bool IsArena() const;
};

class BattlegroundMgr
{
private:
    BattlegroundMgr();
    ~BattlegroundMgr();

public:
    static BattlegroundMgr* instance();

    void Update(uint32 diff);

    /* Packet Building */
    void BuildPlayerJoinedBattlegroundPacket(WorldPacket* data, Player* player);
    void BuildPlayerLeftBattlegroundPacket(WorldPacket* data, ObjectGuid guid);
    void BuildBattlegroundListPacket(WorldPacket* data, ObjectGuid guid, Player* player, BattlegroundTypeId bgTypeId, uint8 fromWhere);
    void BuildGroupJoinedBattlegroundPacket(WorldPacket* data, GroupJoinBattlegroundResult result);
    void BuildBattlegroundStatusPacket(WorldPacket* data, Battleground* bg, uint8 queueSlot, uint8 statusId, uint32 time1, uint32 time2, uint8 arenaType, TeamId teamId, bool isRated = false, BattlegroundTypeId forceBgTypeId = BATTLEGROUND_TYPE_NONE);
    void SendAreaSpiritHealerQueryOpcode(Player* player, Battleground* bg, ObjectGuid guid);

    /* Battlegrounds */
    Battleground* GetBattlegroundThroughClientInstance(uint32 instanceId, BattlegroundTypeId bgTypeId);
    Battleground* GetBattleground(uint32 instanceID, BattlegroundTypeId bgTypeId);
    Battleground* GetBattlegroundTemplate(BattlegroundTypeId bgTypeId);
    Battleground* CreateNewBattleground(BattlegroundTypeId bgTypeId, PvPDifficultyEntry const* bracketEntry, uint8 arenaType, bool isRated);
    std::vector<Battleground const*> GetActiveBattlegrounds();

    void AddBattleground(Battleground* bg);
    void RemoveBattleground(BattlegroundTypeId bgTypeId, uint32 instanceId);
    void AddToBGFreeSlotQueue(BattlegroundTypeId bgTypeId, Battleground* bg);
    void RemoveFromBGFreeSlotQueue(BattlegroundTypeId bgTypeId, uint32 instanceId);
    BGFreeSlotQueueContainer& GetBGFreeSlotQueueStore(BattlegroundTypeId bgTypeId);

    void LoadBattlegroundTemplates();
    void DeleteAllBattlegrounds();

    void SendToBattleground(Player* player, uint32 InstanceID, BattlegroundTypeId bgTypeId);

    /* Battleground queues */
    BattlegroundQueue& GetBattlegroundQueue(BattlegroundQueueTypeId bgQueueTypeId) { return m_BattlegroundQueues[bgQueueTypeId]; }
    void ScheduleQueueUpdate(uint32 arenaMatchmakerRating, uint8 arenaType, BattlegroundQueueTypeId bgQueueTypeId, BattlegroundTypeId bgTypeId, BattlegroundBracketId bracket_id);
    uint32 GetPrematureFinishTime() const;

    void ToggleArenaTesting();
    void ToggleTesting();

    void SetHolidayWeekends(uint32 mask);

    bool isArenaTesting() const { return m_ArenaTesting; }
    bool isTesting() const { return m_Testing; }

    static BattlegroundQueueTypeId BGQueueTypeId(BattlegroundTypeId bgTypeId, uint8 arenaType);
    static BattlegroundTypeId BGTemplateId(BattlegroundQueueTypeId bgQueueTypeId);
    static bool IsArenaType(BattlegroundTypeId bgTypeId);
    static uint8 BGArenaType(BattlegroundQueueTypeId bgQueueTypeId);

    static HolidayIds BGTypeToWeekendHolidayId(BattlegroundTypeId bgTypeId);
    static BattlegroundTypeId WeekendHolidayIdToBGType(HolidayIds holiday);
    static bool IsBGWeekend(BattlegroundTypeId bgTypeId);

    uint32 GetMaxRatingDifference() const;
    uint32 GetRatingDiscardTimer() const;
    void InitAutomaticArenaPointDistribution();
    void LoadBattleMastersEntry();
    void CheckBattleMasters();

    BattlegroundTypeId GetBattleMasterBG(uint32 entry) const
    {
        BattleMastersMap::const_iterator itr = mBattleMastersMap.find(entry);
        if (itr != mBattleMastersMap.end())
            return itr->second;
        return BATTLEGROUND_TYPE_NONE;
    }

    static std::unordered_map<int, BattlegroundQueueTypeId> bgToQueue;      // BattlegroundTypeId -> BattlegroundQueueTypeId
    static std::unordered_map<int, BattlegroundTypeId> queueToBg;           // BattlegroundQueueTypeId -> BattlegroundTypeId
    static std::unordered_map<int, Battleground*> bgtypeToBattleground;     // BattlegroundTypeId -> Battleground*
    static std::unordered_map<int, bgRef> bgTypeToTemplate;                 // BattlegroundTypeId -> bgRef
    static std::unordered_map<int, bgMapRef> getBgFromMap;                  // BattlegroundMapID -> bgMapRef
    static std::unordered_map<int, bgTypeRef> getBgFromTypeID;              // BattlegroundTypeID -> bgTypeRef
    static std::unordered_map<uint32, BattlegroundQueueTypeId> ArenaTypeToQueue;    // ArenaType -> BattlegroundQueueTypeId
    static std::unordered_map<uint32, ArenaType> QueueToArenaType;                  // BattlegroundQueueTypeId -> ArenaType

private:
    bool CreateBattleground(BattlegroundTemplate const* bgTemplate);
    uint32 CreateClientVisibleInstanceId(BattlegroundTypeId bgTypeId, BattlegroundBracketId bracket_id);
    BattlegroundTypeId GetRandomBG(BattlegroundTypeId id, uint32 minLevel);

    typedef std::map<BattlegroundTypeId, BattlegroundData> BattlegroundDataContainer;
    BattlegroundDataContainer bgDataStore;

    BattlegroundQueue m_BattlegroundQueues[MAX_BATTLEGROUND_QUEUE_TYPES];

    std::vector<uint64> m_QueueUpdateScheduler;
    bool   m_ArenaTesting;
    bool   m_Testing;
    Seconds m_NextAutoDistributionTime;
    uint32 m_AutoDistributionTimeChecker;
    uint32 m_NextPeriodicQueueUpdateTime;
    BattleMastersMap mBattleMastersMap;

    BattlegroundTemplate const* GetBattlegroundTemplateByTypeId(BattlegroundTypeId id)
    {
        auto const& itr = _battlegroundTemplates.find(id);
        if (itr != _battlegroundTemplates.end())
            return &itr->second;

        return nullptr;
    }

    BattlegroundTemplate const* GetBattlegroundTemplateByMapId(uint32 mapId)
    {
        auto const& itr = _battlegroundMapTemplates.find(mapId);
        if (itr != _battlegroundMapTemplates.end())
            return itr->second;

        return nullptr;
    }

    typedef std::map<BattlegroundTypeId, uint8 /*weight*/> BattlegroundSelectionWeightMap;

    typedef std::map<BattlegroundTypeId, BattlegroundTemplate> BattlegroundTemplateMap;
    typedef std::map<uint32 /*mapId*/, BattlegroundTemplate*> BattlegroundMapTemplateContainer;
    BattlegroundTemplateMap _battlegroundTemplates;
    BattlegroundMapTemplateContainer _battlegroundMapTemplates;
};

#define sBattlegroundMgr BattlegroundMgr::instance()

#endif
