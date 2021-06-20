/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_WAYPOINTMANAGER_H
#define ACORE_WAYPOINTMANAGER_H

#include "Common.h"
#include <vector>
#include <unordered_map>

enum WaypointMoveType
{
    WAYPOINT_MOVE_TYPE_WALK,
    WAYPOINT_MOVE_TYPE_RUN,
    WAYPOINT_MOVE_TYPE_LAND,
    WAYPOINT_MOVE_TYPE_TAKEOFF,

    WAYPOINT_MOVE_TYPE_MAX
};

struct WaypointData
{
    uint32 id;
    float x, y, z, orientation;
    uint32 delay;
    uint32 event_id;
    uint32 move_type;
    uint8 event_chance;
};

typedef std::vector<WaypointData*> WaypointPath;
typedef std::unordered_map<uint32, WaypointPath> WaypointPathContainer;

class WaypointMgr
{
    public:
        static WaypointMgr* instance();

        // Attempts to reload a single path from database
        void ReloadPath(uint32 id);

        // Loads all paths from database, should only run on startup
        void Load();

        // Returns the path from a given id
        WaypointPath const* GetPath(uint32 id) const
        {
            WaypointPathContainer::const_iterator itr = _waypointStore.find(id);
            if (itr != _waypointStore.end())
                return &itr->second;

            return nullptr;
        }

    private:
        WaypointMgr();
        ~WaypointMgr();

        WaypointPathContainer _waypointStore;
};

#define sWaypointMgr WaypointMgr::instance()

#endif
