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

#ifndef ACORE_GAMEEVENT_MGR_H
#define ACORE_GAMEEVENT_MGR_H

#include "Common.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"
#include <map>
#include <unordered_map>

#define max_ge_check_delay DAY          // 1 day in seconds

enum GameEventState
{
    GAMEEVENT_NORMAL            = 0,    // standard game events
    GAMEEVENT_WORLD_INACTIVE    = 1,    // not yet started
    GAMEEVENT_WORLD_CONDITIONS  = 2,    // condition matching phase
    GAMEEVENT_WORLD_NEXTPHASE   = 3,    // conditions are met, now 'length' timer to start next event
    GAMEEVENT_WORLD_FINISHED    = 4,    // next events are started, unapply this one
    GAMEEVENT_INTERNAL          = 5,    // never handled in update
};

struct GameEventFinishCondition
{
    float ReqNum;  // required number // use float, since some events use percent
    float Done;    // done number
    uint32 MaxWorldState;  // max resource count world state update id
    uint32 DoneWorldState; // done resource count world state update id
};

struct GameEventQuestToEventConditionNum
{
    uint16 EventId;
    uint32 Condition;
    float Num;
};

typedef std::map<uint32 /*condition id*/, GameEventFinishCondition> GameEventConditionMap;

struct GameEventData
{
    GameEventData()  = default;
    uint32 EventId;
    time_t Start{1};           // occurs after this time
    time_t End{0};             // occurs before this time
    time_t NextStart{0};       // after this time the follow-up events count this phase completed
    uint32 Occurence{0};       // time between end and start
    uint32 Length{0};          // length of the event (minutes) after finishing all conditions
    HolidayIds HolidayId{HOLIDAY_NONE};
    uint8 HolidayStage;
    GameEventState State{GAMEEVENT_NORMAL};   // state of the game event, these are saved into the game_event table on change!
    GameEventConditionMap Conditions;  // conditions to finish
    std::set<uint16 /*gameevent id*/> PrerequisiteEvents;  // events that must be completed before starting this event
    std::string Description;
    uint8 Announce;         // if 0 dont announce, if 1 announce, if 2 take config value

    [[nodiscard]] bool isValid() const { return Length > 0 || State > GAMEEVENT_NORMAL; }
};

struct ModelEquip
{
    uint32 ModelId;
    uint32 ModelIdPrev;
    uint8 EquipmentId;
    uint8 EquipementIdPrev;
};

struct NPCVendorEntry
{
    uint32 Entry;                       // creature entry
    uint32 Item;                        // item id
    int32  MaxCount;                    // 0 for infinite
    uint32 Incrtime;                    // time for restore items amount if maxcount != 0
    uint32 ExtendedCost;
};

class Player;
class Creature;
class Quest;

class GameEventMgr
{
private:
    GameEventMgr();
    ~GameEventMgr() = default;

public:
    static GameEventMgr* instance();

    typedef std::set<uint16> ActiveEvents;
    typedef std::vector<GameEventData> GameEventDataMap;
    [[nodiscard]] ActiveEvents const& GetActiveEventList() const { return _activeEvents; }
    [[nodiscard]] GameEventDataMap const& GetEventMap() const { return _gameEvent; }
    [[nodiscard]] bool CheckOneGameEvent(uint16 entry) const;
    [[nodiscard]] uint32 NextCheck(uint16 entry) const;
    void LoadFromDB();
    void LoadHolidayDates();
    uint32 Update();
    bool IsActiveEvent(uint16 eventId) { return (_activeEvents.find(eventId) != _activeEvents.end()); }
    uint32 StartSystem();
    void Initialize();
    void StartInternalEvent(uint16 event_id);
    bool StartEvent(uint16 event_id, bool overwrite = false);
    void StopEvent(uint16 event_id, bool overwrite = false);
    void HandleQuestComplete(uint32 quest_id);  // called on world event type quest completions
    uint32 GetNPCFlag(Creature* cr);
    // Load the game event npc vendor table from the DB
    void LoadEventVendors();
    [[nodiscard]] uint32 GetHolidayEventId(uint32 holidayId) const;
private:
    void LoadEvents();
    void LoadEventSaveData();
    void LoadEventPrerequisiteData();
    void LoadEventCreatureData();
    void LoadEventGameObjectData();
    void LoadEventModelEquipmentChangeData();
    void LoadEventQuestData();
    void LoadEventGameObjectQuestData();
    void LoadEventQuestConditionData();
    void LoadEventConditionData();
    void LoadEventConditionSaveData();
    void LoadEventNPCFlags();
    void LoadEventSeasonalQuestRelations();
    void LoadEventBattlegroundData();
    void LoadEventPoolData();

    void SendWorldStateUpdate(Player* player, uint16 eventId);
    void AddActiveEvent(uint16 eventId) { _activeEvents.insert(eventId); }
    void RemoveActiveEvent(uint16 eventId) { _activeEvents.erase(eventId); }
    void ApplyNewEvent(uint16 eventId);
    void UnApplyEvent(uint16 eventId);
    void GameEventSpawn(int16 eventId);
    void GameEventUnspawn(int16 eventId);
    void ChangeEquipOrModel(int16 eventId, bool activate);
    void UpdateEventQuests(uint16 eventId, bool activate);
    void UpdateWorldStates(uint16 eventId, bool Activate);
    void UpdateEventNPCFlags(uint16 eventId);
    void UpdateEventNPCVendor(uint16 eventId, bool activate);
    void UpdateBattlegroundSettings();
    void RunSmartAIScripts(uint16 eventId, bool activate);    //! Runs SMART_EVENT_GAME_EVENT_START/_END SAI
    bool CheckOneGameEventConditions(uint16 eventId);
    void SaveWorldEventStateToDB(uint16 eventId);
    bool HasCreatureQuestActiveEventExcept(uint32 quest_id, uint16 eventId);
    bool HasGameObjectQuestActiveEventExcept(uint32 quest_id, uint16 eventId);
    bool HasCreatureActiveEventExcept(ObjectGuid::LowType creature_guid, uint16 eventId);
    bool HasGameObjectActiveEventExcept(ObjectGuid::LowType go_guid, uint16 eventId);
    void SetHolidayEventTime(GameEventData& event);

    typedef std::list<ObjectGuid::LowType> GuidLowList;
    typedef std::list<uint32> IdList;
    typedef std::vector<GuidLowList> GameEventGuidMap;
    typedef std::vector<IdList> GameEventIdMap;
    typedef std::pair<ObjectGuid::LowType, ModelEquip> ModelEquipPair;
    typedef std::list<ModelEquipPair> ModelEquipList;
    typedef std::vector<ModelEquipList> GameEventModelEquipMap;
    typedef std::pair<uint32, uint32> QuestRelation;
    typedef std::list<QuestRelation> QuestRelList;
    typedef std::vector<QuestRelList> GameEventQuestMap;
    typedef std::list<NPCVendorEntry> NPCVendorList;
    typedef std::vector<NPCVendorList> GameEventNPCVendorMap;
    typedef std::map<uint32 /*quest id*/, GameEventQuestToEventConditionNum> QuestIdToEventConditionMap;
    typedef std::pair<ObjectGuid::LowType /*guid*/, uint32 /*npcflag*/> GuidNPCFlagPair;
    typedef std::list<GuidNPCFlagPair> NPCFlagList;
    typedef std::vector<NPCFlagList> GameEventNPCFlagMap;
    typedef std::vector<uint32> GameEventBitmask;
    typedef std::unordered_map<uint32, std::vector<uint32>> GameEventSeasonalQuestsMap;
    GameEventQuestMap _gameEventCreatureQuests;
    GameEventQuestMap _gameEventGameObjectQuests;
    GameEventNPCVendorMap _gameEventVendors;
    GameEventModelEquipMap _gameEventModelEquip;
    GameEventIdMap    _gameEventPoolIds;
    GameEventDataMap  _gameEvent;
    GameEventBitmask  _gameEventBattlegroundHolidays;
    QuestIdToEventConditionMap _questToEventConditions;
    GameEventNPCFlagMap _gameEventNPCFlags;
    ActiveEvents _activeEvents;
    bool _isSystemInit;
    GameEventSeasonalQuestsMap _gameEventSeasonalQuestsMap;
public:
    GameEventGuidMap  GameEventCreatureGuids;
    GameEventGuidMap  GameEventGameobjectGuids;
    std::vector<uint32> ModifiedHolidays;
};

#define sGameEventMgr GameEventMgr::instance()

bool IsHolidayActive(HolidayIds id);
bool IsEventActive(uint16 eventId);

#endif
