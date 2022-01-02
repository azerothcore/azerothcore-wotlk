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

#ifndef _INSTANCESAVEMGR_H
#define _INSTANCESAVEMGR_H

#include "DBCEnums.h"
#include "DatabaseEnv.h"
#include "Define.h"
#include "ObjectDefines.h"
#include "ObjectGuid.h"
#include <list>
#include <map>
#include <mutex>
#include <unordered_map>

struct InstanceTemplate;
struct MapEntry;
class Player;
class Group;
class InstanceSaveMgr;
class InstanceSave;

struct InstancePlayerBind
{
    InstanceSave* save{nullptr};
    bool perm : 1;
    bool extended : 1;
    InstancePlayerBind() :  perm(false), extended(false) {}
};

typedef std::unordered_map<uint32 /*mapId*/, InstancePlayerBind > BoundInstancesMap;

struct BoundInstancesMapWrapper
{
    BoundInstancesMap m[MAX_DIFFICULTY];
};

typedef std::unordered_map<ObjectGuid /*guid*/, BoundInstancesMapWrapper* > PlayerBindStorage;

class InstanceSave
{
    friend class InstanceSaveMgr;
public:
    InstanceSave(uint16 MapId, uint32 InstanceId, Difficulty difficulty, time_t resetTime, time_t extendedResetTime);
    ~InstanceSave();
    [[nodiscard]] auto GetInstanceId() const -> uint32 { return m_instanceid; }
    [[nodiscard]] auto GetMapId() const -> uint32 { return m_mapid; }
    [[nodiscard]] auto GetDifficulty() const -> Difficulty { return m_difficulty; }

    /* Saved when the instance is generated for the first time */
    void InsertToDB();
    // pussywizard: deleting is done internally when there are no binds left

    [[nodiscard]] auto GetInstanceData() const -> std::string { return m_instanceData; }
    void SetInstanceData(std::string str) { m_instanceData = str; }
    [[nodiscard]] auto GetCompletedEncounterMask() const -> uint32 { return m_completedEncounterMask; }
    void SetCompletedEncounterMask(uint32 mask) { m_completedEncounterMask = mask; }

    // pussywizard: for normal instances this corresponds to 0, for raid/heroic instances this caches the global reset time for the map
    [[nodiscard]] auto GetResetTime() const -> time_t { return m_resetTime; }
    [[nodiscard]] auto GetExtendedResetTime() const -> time_t { return m_extendedResetTime; }
    auto GetResetTimeForDB() -> time_t;
    void SetResetTime(time_t resetTime) { m_resetTime = resetTime; }
    void SetExtendedResetTime(time_t extendedResetTime) { m_extendedResetTime = extendedResetTime; }

    [[nodiscard]] auto CanReset() const -> bool { return m_canReset; }
    void SetCanReset(bool canReset) { m_canReset = canReset; }

    auto GetTemplate() -> InstanceTemplate const*;
    auto GetMapEntry() -> MapEntry const*;

    void AddPlayer(ObjectGuid guid);
    auto RemovePlayer(ObjectGuid guid, InstanceSaveMgr* ism) -> bool;

private:
    GuidList m_playerList;
    time_t m_resetTime;
    time_t m_extendedResetTime;
    uint32 m_instanceid;
    uint32 m_mapid;
    Difficulty m_difficulty;
    bool m_canReset;
    std::string m_instanceData;
    uint32 m_completedEncounterMask;

    std::mutex _lock;
};

typedef std::unordered_map<uint32 /*PAIR32(map, difficulty)*/, time_t /*resetTime*/> ResetTimeByMapDifficultyMap;

class InstanceSaveMgr
{
    friend class InstanceSave;

private:
    InstanceSaveMgr()  = default;;
    ~InstanceSaveMgr();

public:
    static auto instance() -> InstanceSaveMgr*;

    typedef std::unordered_map<uint32 /*InstanceId*/, InstanceSave*> InstanceSaveHashMap;

    struct InstResetEvent
    {
        uint8 type{0}; // 0 - unused, 1-4 warnings about pending reset, 5 - reset
        Difficulty difficulty: 8;
        uint16 mapid{0};

        InstResetEvent() :  difficulty(DUNGEON_DIFFICULTY_NORMAL) {}
        InstResetEvent(uint8 t, uint32 _mapid, Difficulty d)
            : type(t), difficulty(d), mapid(_mapid) {}
    };
    typedef std::multimap<time_t /*resetTime*/, InstResetEvent> ResetTimeQueue;

    void LoadInstances();
    void LoadResetTimes();
    void LoadInstanceSaves();
    void LoadCharacterBinds();

    [[nodiscard]] auto GetResetTimeFor(uint32 mapid, Difficulty d) const -> time_t
    {
        ResetTimeByMapDifficultyMap::const_iterator itr  = m_resetTimeByMapDifficulty.find(MAKE_PAIR32(mapid, d));
        return itr != m_resetTimeByMapDifficulty.end() ? itr->second : 0;
    }

    [[nodiscard]] auto GetExtendedResetTimeFor(uint32 mapid, Difficulty d) const -> time_t
    {
        ResetTimeByMapDifficultyMap::const_iterator itr  = m_resetExtendedTimeByMapDifficulty.find(MAKE_PAIR32(mapid, d));
        return itr != m_resetExtendedTimeByMapDifficulty.end() ? itr->second : 0;
    }

    void SetResetTimeFor(uint32 mapid, Difficulty d, time_t t)
    {
        m_resetTimeByMapDifficulty[MAKE_PAIR32(mapid, d)] = t;
    }

    void SetExtendedResetTimeFor(uint32 mapid, Difficulty d, time_t t)
    {
        m_resetExtendedTimeByMapDifficulty[MAKE_PAIR32(mapid, d)] = t;
    }

    [[nodiscard]] auto GetResetTimeMap() const -> ResetTimeByMapDifficultyMap const&
    {
        return m_resetTimeByMapDifficulty;
    }

    void ScheduleReset(time_t time, InstResetEvent event);

    void Update();

    auto AddInstanceSave(uint32 mapId, uint32 instanceId, Difficulty difficulty, bool startup = false) -> InstanceSave*;
    auto DeleteInstanceSaveIfNeeded(uint32 InstanceId, bool skipMapCheck) -> bool;
    auto DeleteInstanceSaveIfNeeded(InstanceSave* save, bool skipMapCheck) -> bool;

    auto GetInstanceSave(uint32 InstanceId) -> InstanceSave*;

    auto PlayerBindToInstance(ObjectGuid guid, InstanceSave* save, bool permanent, Player* player = nullptr) -> InstancePlayerBind*;
    void PlayerUnbindInstance(ObjectGuid guid, uint32 mapid, Difficulty difficulty, bool deleteFromDB, Player* player = nullptr);
    void PlayerUnbindInstanceNotExtended(ObjectGuid guid, uint32 mapid, Difficulty difficulty, Player* player = nullptr);
    auto PlayerGetBoundInstance(ObjectGuid guid, uint32 mapid, Difficulty difficulty) -> InstancePlayerBind*;
    auto PlayerIsPermBoundToInstance(ObjectGuid guid, uint32 mapid, Difficulty difficulty) -> bool;
    auto PlayerGetBoundInstances(ObjectGuid guid, Difficulty difficulty) -> BoundInstancesMap const&;
    void PlayerCreateBoundInstancesMaps(ObjectGuid guid);
    auto PlayerGetInstanceSave(ObjectGuid guid, uint32 mapid, Difficulty difficulty) -> InstanceSave*;
    auto PlayerGetDestinationInstanceId(Player* player, uint32 mapid, Difficulty difficulty) -> uint32;
    void CopyBinds(ObjectGuid from, ObjectGuid to, Player* toPlr = nullptr);
    void UnbindAllFor(InstanceSave* save);

protected:
    static uint16 ResetTimeDelay[];
    static PlayerBindStorage playerBindStorage;
    static BoundInstancesMap emptyBoundInstancesMap;

private:
    void _ResetOrWarnAll(uint32 mapid, Difficulty difficulty, bool warn, time_t resetTime);
    void _ResetSave(InstanceSaveHashMap::iterator& itr);
    bool lock_instLists{false};
    InstanceSaveHashMap m_instanceSaveById;
    ResetTimeByMapDifficultyMap m_resetTimeByMapDifficulty;
    ResetTimeByMapDifficultyMap m_resetExtendedTimeByMapDifficulty;
    ResetTimeQueue m_resetTimeQueue;
};

#define sInstanceSaveMgr InstanceSaveMgr::instance()

#endif
