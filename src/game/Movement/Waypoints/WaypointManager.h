/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRINITY_WAYPOINTMANAGER_H
#define TRINITY_WAYPOINTMANAGER_H

#include <ace/Singleton.h>
#include <ace/Null_Mutex.h>
#include <vector>

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
typedef UNORDERED_MAP<uint32, WaypointPath> WaypointPathContainer;

class WaypointMgr
{
        friend class ACE_Singleton<WaypointMgr, ACE_Null_Mutex>;

    public:
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

            return NULL;
        }

    private:
        // Only allow instantiation from ACE_Singleton
        WaypointMgr();
        ~WaypointMgr();

        WaypointPathContainer _waypointStore;
};

#define sWaypointMgr ACE_Singleton<WaypointMgr, ACE_Null_Mutex>::instance()

#endif
