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

#ifndef __ACORE_ACHIEVEMENTMGR_H
#define __ACORE_ACHIEVEMENTMGR_H

#include "Common.h"
#include "DBCEnums.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "ObjectGuid.h"
#include <chrono>
#include <map>
#include <string>

typedef std::list<AchievementCriteriaEntry const*> AchievementCriteriaEntryList;
typedef std::list<AchievementEntry const*>         AchievementEntryList;

typedef std::unordered_map<uint32, AchievementCriteriaEntryList> AchievementCriteriaListByAchievement;
typedef std::map<uint32, AchievementEntryList>         AchievementListByReferencedId;

enum AchievementOfflinePlayerUpdateType
{
    ACHIEVEMENT_OFFLINE_PLAYER_UPDATE_TYPE_COMPLETE_ACHIEVEMENT = 1,
    ACHIEVEMENT_OFFLINE_PLAYER_UPDATE_TYPE_UPDATE_CRITERIA      = 2
};

struct AchievementOfflinePlayerUpdate
{
    AchievementOfflinePlayerUpdateType updateType;
    uint32 arg1;
    uint32 arg2;
    uint32 arg3;
};

struct CriteriaProgress
{
    uint32 counter;
    time_t date;                                            // latest update time.
    bool changed;
};

enum AchievementCriteriaDataType
{
    // value1         value2        comment
    ACHIEVEMENT_CRITERIA_DATA_TYPE_NONE                 = 0, // 0              0
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_CREATURE           = 1, // creature_id    0
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_CLASS_RACE  = 2, // class_id       race_id
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_LESS_HEALTH = 3, // health_percent 0
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_DEAD        = 4, // own_team       0             not corpse (not released body), own_team == false if enemy team expected
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA               = 5, // spell_id       effect_idx
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AREA               = 6, // area id        0
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA               = 7, // spell_id       effect_idx
    ACHIEVEMENT_CRITERIA_DATA_TYPE_VALUE                = 8, // minvalue                     value provided with achievement update must be not less that limit
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_LEVEL              = 9, // minlevel                     minlevel of target
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_GENDER             = 10, // gender                       0=male; 1=female
    ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT               = 11, // scripted requirement
    ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_DIFFICULTY       = 12, // difficulty                   normal/heroic difficulty for current event map
    ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_PLAYER_COUNT     = 13, // count                        "with less than %u people in the zone"
    ACHIEVEMENT_CRITERIA_DATA_TYPE_T_TEAM               = 14, // team                         HORDE(67), ALLIANCE(469)
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_DRUNK              = 15, // drunken_state  0             (enum DrunkenState) of player
    ACHIEVEMENT_CRITERIA_DATA_TYPE_HOLIDAY              = 16, // holiday_id     0             event in holiday time
    ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_LOSS_TEAM_SCORE   = 17, // min_score      max_score     player's team win bg and opposition team have team score in range
    ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT      = 18, // 0              0             maker instance script call for check current criteria requirements fit
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_EQUIPPED_ITEM      = 19, // item_level     item_quality  for equipped item in slot to check item level and quality
    ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_ID               = 20, // map_id         0             player must be on map with id in map_id
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE  = 21, // class_id       race_id
    ACHIEVEMENT_CRITERIA_DATA_TYPE_NTH_BIRTHDAY         = 22, // N                            login on day of N-th Birthday
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_KNOWN_TITLE        = 23, // title_id                     known (pvp) title, values from dbc
    ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_TEAMS_SCORES      = 24, // winner_score   loser score   player's team win bg and their teams have exact scores
    ACHIEVEMENT_CRITERIA_DATA_TYPE_S_ITEM_QUALITY       = 25  // item_quality
};
#define MAX_ACHIEVEMENT_CRITERIA_DATA_TYPE               26 // maximum value in AchievementCriteriaDataType enum

enum AchievementCommonCategories
{
    ACHIEVEMENT_CATEOGRY_GENERAL                        = -1,
    ACHIEVEMENT_CATEGORY_STATISTICS                     =  1
};

class Player;
class Unit;

struct AchievementCriteriaData
{
    AchievementCriteriaDataType dataType{ACHIEVEMENT_CRITERIA_DATA_TYPE_NONE};
    union
    {
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_NONE                  = 0 (no data)
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_CREATURE            = 1
        struct
        {
            uint32 id;
        } creature;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_CLASS_RACE   = 2
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_S_PLAYER_CLASS_RACE   = 21
        struct
        {
            uint32 class_id;
            uint32 race_id;
        } classRace;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_LESS_HEALTH  = 3
        struct
        {
            uint32 percent;
        } health;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_PLAYER_DEAD         = 4
        struct
        {
            uint32 own_team_flag;
        } player_dead;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AURA                = 5
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_AURA                = 7
        struct
        {
            uint32 spell_id;
            uint32 effect_idx;
        } aura;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_S_AREA                = 6
        struct
        {
            uint32 id;
        } area;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_VALUE                 = 8
        struct
        {
            uint32 value;
            uint32 compType;
        } value;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_LEVEL               = 9
        struct
        {
            uint32 minlevel;
        } level;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_GENDER              = 10
        struct
        {
            uint32 gender;
        } gender;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_SCRIPT                = 11 (no data)
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_DIFFICULTY        = 12
        struct
        {
            uint32 difficulty;
        } difficulty;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_PLAYER_COUNT      = 13
        struct
        {
            uint32 maxcount;
        } map_players;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_T_TEAM                = 14
        struct
        {
            uint32 team;
        } team;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_S_DRUNK               = 15
        struct
        {
            uint32 state;
        } drunk;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_HOLIDAY               = 16
        struct
        {
            uint32 id;
        } holiday;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_LOSS_TEAM_SCORE    = 17
        struct
        {
            uint32 min_score;
            uint32 max_score;
        } bg_loss_team_score;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_INSTANCE_SCRIPT       = 18 (no data)
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_S_EQUIPPED_ITEM       = 19
        struct
        {
            uint32 item_level;
            uint32 item_quality;
        } equipped_item;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_MAP_ID                = 20
        struct
        {
            uint32 mapId;
        } map_id;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_NTH_BIRTHDAY          = 22
        struct
        {
            uint32 nth_birthday;
        } birthday_login;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_KNOWN_TITLE           = 23
        struct
        {
            uint32 title_id;
        } known_title;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_BG_TEAMS_SCORES       = 24
        struct
        {
            uint32 winner_score;
            uint32 loser_score;
        } teams_scores;
        // ACHIEVEMENT_CRITERIA_DATA_TYPE_S_ITEM_QUALITY        = 25
        struct
        {
            uint32 item_quality;
        } item;
        // ...
        struct
        {
            uint32 value1;
            uint32 value2;
        } raw;
    };
    uint32 ScriptId;

    AchievementCriteriaData()
    {
        raw.value1 = 0;
        raw.value2 = 0;
        ScriptId = 0;
    }

    AchievementCriteriaData(uint32 _dataType, uint32 _value1, uint32 _value2, uint32 _scriptId) : dataType(AchievementCriteriaDataType(_dataType))
    {
        raw.value1 = _value1;
        raw.value2 = _value2;
        ScriptId = _scriptId;
    }

    bool IsValid(AchievementCriteriaEntry const* criteria);
    bool Meets(uint32 criteria_id, Player const* source, Unit const* target, uint32 miscvalue1 = 0) const;
};

struct AchievementCriteriaDataSet
{
    AchievementCriteriaDataSet()  = default;
    typedef std::vector<AchievementCriteriaData> Storage;
    void Add(AchievementCriteriaData const& data) { _storage.push_back(data); }
    bool Meets(Player const* source, Unit const* target, uint32 miscvalue = 0) const;
    void SetCriteriaId(uint32 id) {_criteria_id = id;}
private:
    uint32 _criteria_id{0};
    Storage _storage;
};

typedef std::map<uint32, AchievementCriteriaDataSet> AchievementCriteriaDataMap;

struct AchievementReward
{
    uint32 titleId[2];
    uint32 itemId;
    uint32 sender;
    std::string subject;
    std::string text;
    uint32 mailTemplate;
};

typedef std::map<uint32, AchievementReward> AchievementRewards;

struct AchievementRewardLocale
{
    std::vector<std::string> Subject;
    std::vector<std::string> Text;
};

typedef std::map<uint32, AchievementRewardLocale> AchievementRewardLocales;

struct CompletedAchievementData
{
    time_t date;
    bool changed;
};

typedef std::unordered_map<uint32, CriteriaProgress> CriteriaProgressMap;
typedef std::unordered_map<uint32, CompletedAchievementData> CompletedAchievementMap;

class Unit;
class Player;
class WorldPacket;

class AchievementMgr
{
public:
    AchievementMgr(Player* player);
    ~AchievementMgr();

    void Reset();
    static void DeleteFromDB(ObjectGuid::LowType lowguid);
    void LoadFromDB(PreparedQueryResult achievementResult, PreparedQueryResult criteriaResult, PreparedQueryResult offlineUpdatesResult);
    void SaveToDB(CharacterDatabaseTransaction trans);
    void ResetAchievementCriteria(AchievementCriteriaCondition condition, uint32 value, bool evenIfCriteriaComplete = false);
    void UpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 = 0, uint32 miscValue2 = 0, Unit* unit = nullptr);
    void CompletedAchievement(AchievementEntry const* entry);
    void CheckAllAchievementCriteria();
    void SendAllAchievementData() const;
    void SendRespondInspectAchievements(Player* player) const;
    [[nodiscard]] bool HasAchieved(uint32 achievementId) const;
    [[nodiscard]] Player* GetPlayer() const { return _player; }

    void Update(uint32 timeDiff);
    void StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry, uint32 timeLost = 0);
    void RemoveTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);   // used for quest and scripted timed achievements

    void RemoveCriteriaProgress(AchievementCriteriaEntry const* entry);
    CriteriaProgress* GetCriteriaProgress(AchievementCriteriaEntry const* entry);
    CompletedAchievementMap const& GetCompletedAchievements();

private:
    enum ProgressType { PROGRESS_SET, PROGRESS_ACCUMULATE, PROGRESS_HIGHEST, PROGRESS_RESET };
    void SendAchievementEarned(AchievementEntry const* achievement) const;
    void SendCriteriaUpdate(AchievementCriteriaEntry const* entry, CriteriaProgress const* progress, uint32 timeElapsed, bool timedCompleted) const;
    void SetCriteriaProgress(AchievementCriteriaEntry const* entry, uint32 changeValue, ProgressType ptype = PROGRESS_SET);
    void CompletedCriteriaFor(AchievementEntry const* achievement);
    bool IsCompletedCriteria(AchievementCriteriaEntry const* achievementCriteria, AchievementEntry const* achievement);
    bool IsCompletedAchievement(AchievementEntry const* entry);
    bool CanUpdateCriteria(AchievementCriteriaEntry const* criteria, AchievementEntry const* achievement);
    void BuildAllDataPacket(WorldPacket* data) const;

    void UpdateTimedAchievements(uint32 timeDiff);

    // Handles updates when character was offline.
    void ProcessOfflineUpdate(AchievementOfflinePlayerUpdate const& update);
    void ProcessOfflineUpdatesQueue();

    Player* _player;
    CriteriaProgressMap _criteriaProgress;
    CompletedAchievementMap _completedAchievements;
    typedef std::map<uint32, uint32> TimedAchievementMap;
    TimedAchievementMap _timedAchievements;      // Criteria id/time left in MS

    // Offline updates cannot be processed while players are loading,
    // as the player will not be notified of the changes.
    // To ensure proper notification, introduce a delay before processing.
    uint32 _offlineUpdatesDelayTimer;
    std::vector<AchievementOfflinePlayerUpdate> _offlineUpdatesQueue;
};

class AchievementGlobalMgr
{
    AchievementGlobalMgr() = default;
    ~AchievementGlobalMgr() = default;

public:
    static AchievementGlobalMgr* instance();

    bool IsStatisticCriteria(AchievementCriteriaEntry const* achievementCriteria) const;
    bool IsStatisticAchievement(AchievementEntry const* achievement) const;
    bool IsAverageCriteria(AchievementCriteriaEntry const* criteria) const;

    [[nodiscard]] AchievementCriteriaEntryList const* GetAchievementCriteriaByType(AchievementCriteriaTypes type) const
    {
        return &_achievementCriteriasByType[type];
    }

    AchievementCriteriaEntryList const* GetSpecialAchievementCriteriaByType(AchievementCriteriaTypes type, uint32 val)
    {
        if (_specialList[type].find(val) != _specialList[type].end())
            return &_specialList[type][val];
        return nullptr;
    }

    AchievementCriteriaEntryList const* GetAchievementCriteriaByCondition(AchievementCriteriaCondition condition, uint32 val)
    {
        if (_achievementCriteriasByCondition[condition].find(val) != _achievementCriteriasByCondition[condition].end())
            return &_achievementCriteriasByCondition[condition][val];
        return nullptr;
    }

    [[nodiscard]] AchievementCriteriaEntryList const& GetTimedAchievementCriteriaByType(AchievementCriteriaTimedTypes type) const
    {
        return _achievementCriteriasByTimedType[type];
    }

    [[nodiscard]] AchievementCriteriaEntryList const* GetAchievementCriteriaByAchievement(uint32 id) const
    {
        AchievementCriteriaListByAchievement::const_iterator itr = _achievementCriteriaListByAchievement.find(id);
        return itr != _achievementCriteriaListByAchievement.end() ? &itr->second : nullptr;
    }

    [[nodiscard]] AchievementEntryList const* GetAchievementByReferencedId(uint32 id) const
    {
        AchievementListByReferencedId::const_iterator itr = _achievementListByReferencedId.find(id);
        return itr != _achievementListByReferencedId.end() ? &itr->second : nullptr;
    }

    AchievementReward const* GetAchievementReward(AchievementEntry const* achievement) const
    {
        AchievementRewards::const_iterator iter = _achievementRewards.find(achievement->ID);
        return iter != _achievementRewards.end() ? &iter->second : nullptr;
    }

    AchievementRewardLocale const* GetAchievementRewardLocale(AchievementEntry const* achievement) const
    {
        AchievementRewardLocales::const_iterator iter = _achievementRewardLocales.find(achievement->ID);
        return iter != _achievementRewardLocales.end() ? &iter->second : nullptr;
    }

    AchievementCriteriaDataSet const* GetCriteriaDataSet(AchievementCriteriaEntry const* achievementCriteria) const
    {
        AchievementCriteriaDataMap::const_iterator iter = _criteriaDataMap.find(achievementCriteria->ID);
        return iter != _criteriaDataMap.end() ? &iter->second : nullptr;
    }

    bool IsRealmCompleted(AchievementEntry const* achievement) const;
    void SetRealmCompleted(AchievementEntry const* achievement);

    void LoadAchievementCriteriaList();
    void LoadAchievementCriteriaData();
    void LoadAchievementReferenceList();
    void LoadCompletedAchievements();
    void LoadRewards();
    void LoadRewardLocales();

    [[nodiscard]] AchievementEntry const* GetAchievement(uint32 achievementId) const;

    void CompletedAchievementForOfflinePlayer(ObjectGuid::LowType playerLowGuid, AchievementEntry const* entry);
    void UpdateAchievementCriteriaForOfflinePlayer(ObjectGuid::LowType playerLowGuid, AchievementCriteriaTypes type, uint32 miscValue1 = 0, uint32 miscValue2 = 0);
private:
    AchievementCriteriaDataMap _criteriaDataMap;

    // store achievement criterias by type to speed up lookup
    AchievementCriteriaEntryList _achievementCriteriasByType[ACHIEVEMENT_CRITERIA_TYPE_TOTAL];
    AchievementCriteriaEntryList _achievementCriteriasByTimedType[ACHIEVEMENT_TIMED_TYPE_MAX];
    // store achievement criterias by achievement to speed up lookup
    AchievementCriteriaListByAchievement _achievementCriteriaListByAchievement;
    // store achievements by referenced achievement id to speed up lookup
    AchievementListByReferencedId _achievementListByReferencedId;

    typedef std::unordered_map<uint32 /*achievementId*/, SystemTimePoint /*completionTime*/> AllCompletedAchievements;
    AllCompletedAchievements _allCompletedAchievements;

    AchievementRewards _achievementRewards;
    AchievementRewardLocales _achievementRewardLocales;

    // pussywizard:
    std::map<uint32, AchievementCriteriaEntryList> _specialList[ACHIEVEMENT_CRITERIA_TYPE_TOTAL];
    std::map<uint32, AchievementCriteriaEntryList> _achievementCriteriasByCondition[ACHIEVEMENT_CRITERIA_CONDITION_TOTAL];
};

#define sAchievementMgr AchievementGlobalMgr::instance()

#endif
