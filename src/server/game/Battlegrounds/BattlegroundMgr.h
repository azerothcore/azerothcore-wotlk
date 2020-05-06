/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __BATTLEGROUNDMGR_H
#define __BATTLEGROUNDMGR_H

#include "Common.h"
#include "DBCEnums.h"
#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "CreatureAIImpl.h"
#include <unordered_map>

typedef std::map<uint32, Battleground*> BattlegroundContainer;
typedef std::unordered_map<uint32, BattlegroundTypeId> BattleMastersMap;
typedef Battleground*(*bgRef)(Battleground*);

typedef void(*bgMapRef)(WorldPacket*, Battleground::BattlegroundScoreMap::const_iterator);
typedef void(*bgTypeRef)(WorldPacket*, Battleground::BattlegroundScoreMap::const_iterator, Battleground*);

#define BATTLEGROUND_ARENA_POINT_DISTRIBUTION_DAY 86400 // how many seconds in day

struct CreateBattlegroundData
{
    BattlegroundTypeId bgTypeId;
    bool IsArena;
    uint32 MinPlayersPerTeam;
    uint32 MaxPlayersPerTeam;
    uint32 LevelMin;
    uint32 LevelMax;
    char* BattlegroundName;
    uint32 MapID;
    float Team1StartLocX;
    float Team1StartLocY;
    float Team1StartLocZ;
    float Team1StartLocO;
    float Team2StartLocX;
    float Team2StartLocY;
    float Team2StartLocZ;
    float Team2StartLocO;
    float StartMaxDist;
    uint32 scriptId;
    uint8 Weight;
};

struct GroupQueueInfo;

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
        void BuildPlayerLeftBattlegroundPacket(WorldPacket* data, uint64 guid);
        void BuildBattlegroundListPacket(WorldPacket* data, uint64 guid, Player* player, BattlegroundTypeId bgTypeId, uint8 fromWhere);
        void BuildGroupJoinedBattlegroundPacket(WorldPacket* data, GroupJoinBattlegroundResult result);
        void BuildUpdateWorldStatePacket(WorldPacket* data, uint32 field, uint32 value);
        void BuildPvpLogDataPacket(WorldPacket* data, Battleground* bg);
        void BuildBattlegroundStatusPacket(WorldPacket* data, Battleground* bg, uint8 queueSlot, uint8 statusId, uint32 time1, uint32 time2, uint8 arenaType, TeamId teamId, bool isRated = false, BattlegroundTypeId forceBgTypeId = BATTLEGROUND_TYPE_NONE);
        void BuildPlaySoundPacket(WorldPacket* data, uint32 soundid);
        void SendAreaSpiritHealerQueryOpcode(Player* player, Battleground* bg, uint64 guid);

        /* Battlegrounds */
        Battleground* GetBattleground(uint32 InstanceID);
        Battleground* GetBattlegroundTemplate(BattlegroundTypeId bgTypeId);
        Battleground* CreateNewBattleground(BattlegroundTypeId bgTypeId, uint32 minLevel, uint32 maxLevel, uint8 arenaType, bool isRated);

        void AddBattleground(Battleground* bg);
        void RemoveBattleground(BattlegroundTypeId bgTypeId, uint32 instanceId);

        void CreateInitialBattlegrounds();
        void DeleteAllBattlegrounds();

        void SendToBattleground(Player* player, uint32 InstanceID, BattlegroundTypeId bgTypeId);

        /* Battleground queues */
        BattlegroundQueue& GetBattlegroundQueue(BattlegroundQueueTypeId bgQueueTypeId) { return m_BattlegroundQueues[bgQueueTypeId]; }
        void ScheduleArenaQueueUpdate(uint32 arenaRatedTeamId, BattlegroundQueueTypeId bgQueueTypeId, BattlegroundBracketId bracket_id);
        uint32 GetPrematureFinishTime() const;

        static void InviteGroupToBG(GroupQueueInfo* ginfo, Battleground* bg, TeamId teamId);

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

        uint32 GetRatingDiscardTimer()  const;
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

        const BattlegroundContainer& GetBattlegroundList() { return m_Battlegrounds; } // pussywizard

        static std::unordered_map<int, BattlegroundQueueTypeId> bgToQueue;      // BattlegroundTypeId -> BattlegroundQueueTypeId
        static std::unordered_map<int, BattlegroundTypeId> queueToBg;           // BattlegroundQueueTypeId -> BattlegroundTypeId
        static std::unordered_map<int, Battleground*> bgtypeToBattleground;     // BattlegroundTypeId -> Battleground*
        static std::unordered_map<int, bgRef> bgTypeToTemplate;                 // BattlegroundTypeId -> bgRef
        static std::unordered_map<int, bgMapRef> getBgFromMap;                  // BattlegroundMapID -> bgMapRef
        static std::unordered_map<int, bgTypeRef> getBgFromTypeID;              // BattlegroundTypeID -> bgTypeRef

    private:
        bool CreateBattleground(CreateBattlegroundData& data);
        uint32 GetNextClientVisibleInstanceId();
        BattlegroundTypeId GetRandomBG(BattlegroundTypeId id);

        typedef std::map<BattlegroundTypeId, Battleground*> BattlegroundTemplateContainer;
        BattlegroundTemplateContainer m_BattlegroundTemplates;
        BattlegroundContainer m_Battlegrounds;

        BattlegroundQueue m_BattlegroundQueues[MAX_BATTLEGROUND_QUEUE_TYPES];

        std::vector<uint64> m_ArenaQueueUpdateScheduler;
        bool   m_ArenaTesting;
        bool   m_Testing;
        uint32 m_lastClientVisibleInstanceId;
        time_t m_NextAutoDistributionTime;
        uint32 m_AutoDistributionTimeChecker;
        uint32 m_NextPeriodicQueueUpdateTime;
        BattleMastersMap mBattleMastersMap;

        CreateBattlegroundData const* GetBattlegroundTemplateByTypeId(BattlegroundTypeId id)
        {
            BattlegroundTemplateMap::const_iterator itr = _battlegroundTemplates.find(id);
            if (itr != _battlegroundTemplates.end())
                return &itr->second;
            return nullptr;
        }

        CreateBattlegroundData const* GetBattlegroundTemplateByMapId(uint32 mapId)
        {
            BattlegroundMapTemplateContainer::const_iterator itr = _battlegroundMapTemplates.find(mapId);
            if (itr != _battlegroundMapTemplates.end())
                return itr->second;
            return nullptr;
        }

        typedef std::map<BattlegroundTypeId, uint8 /*weight*/> BattlegroundSelectionWeightMap;

        typedef std::map<BattlegroundTypeId, CreateBattlegroundData> BattlegroundTemplateMap;
        typedef std::map<uint32 /*mapId*/, CreateBattlegroundData*> BattlegroundMapTemplateContainer;
        BattlegroundTemplateMap _battlegroundTemplates;
        BattlegroundMapTemplateContainer _battlegroundMapTemplates;
};

#define sBattlegroundMgr BattlegroundMgr::instance()

#endif
