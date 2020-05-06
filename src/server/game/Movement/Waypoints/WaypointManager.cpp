/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DatabaseEnv.h"
#include "GridDefines.h"
#include "WaypointManager.h"
#include "MapManager.h"
#include "Log.h"

WaypointMgr::WaypointMgr()
{
}

WaypointMgr::~WaypointMgr()
{
    for (WaypointPathContainer::iterator itr = _waypointStore.begin(); itr != _waypointStore.end(); ++itr)
    {
        for (WaypointPath::const_iterator it = itr->second.begin(); it != itr->second.end(); ++it)
            delete *it;

        itr->second.clear();
    }

    _waypointStore.clear();
}

WaypointMgr* WaypointMgr::instance()
{
    static WaypointMgr instance;
    return &instance;
}

void WaypointMgr::Load()
{
    uint32 oldMSTime = getMSTime();

    //                                                0    1         2           3          4            5           6        7      8           9
    QueryResult result = WorldDatabase.Query("SELECT id, point, position_x, position_y, position_z, orientation, move_type, delay, action, action_chance FROM waypoint_data ORDER BY id, point");

    if (!result)
    {
        sLog->outErrorDb(">> Loaded 0 waypoints. DB table `waypoint_data` is empty!");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        WaypointData* wp = new WaypointData();

        uint32 pathId = fields[0].GetUInt32();
        WaypointPath& path = _waypointStore[pathId];

        float x = fields[2].GetFloat();
        float y = fields[3].GetFloat();
        float z = fields[4].GetFloat();
        float o = fields[5].GetFloat();

        acore::NormalizeMapCoord(x);
        acore::NormalizeMapCoord(y);

        wp->id = fields[1].GetUInt32();
        wp->x = x;
        wp->y = y;
        wp->z = z;
        wp->orientation = o;
        wp->move_type = fields[6].GetUInt32();

        if (wp->move_type >= WAYPOINT_MOVE_TYPE_MAX)
        {
            //TC_LOG_ERROR("sql.sql", "Waypoint %u in waypoint_data has invalid move_type, ignoring", wp->id);
            delete wp;
            continue;
        }

        wp->delay = fields[7].GetUInt32();
        wp->event_id = fields[8].GetUInt32();
        wp->event_chance = fields[9].GetInt16();

        path.push_back(wp);
        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u waypoints in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void WaypointMgr::ReloadPath(uint32 id)
{
    WaypointPathContainer::iterator itr = _waypointStore.find(id);
    if (itr != _waypointStore.end())
    {
        for (WaypointPath::const_iterator it = itr->second.begin(); it != itr->second.end(); ++it)
            delete *it;

        _waypointStore.erase(itr);
    }

    PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_WAYPOINT_DATA_BY_ID);

    stmt->setUInt32(0, id);

    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
        return;

    WaypointPath& path = _waypointStore[id];

    do
    {
        Field* fields = result->Fetch();
        WaypointData* wp = new WaypointData();

        float x = fields[1].GetFloat();
        float y = fields[2].GetFloat();
        float z = fields[3].GetFloat();
        float o = fields[4].GetFloat();

        acore::NormalizeMapCoord(x);
        acore::NormalizeMapCoord(y);

        wp->id = fields[0].GetUInt32();
        wp->x = x;
        wp->y = y;
        wp->z = z;
        wp->orientation = o;
        wp->move_type = fields[5].GetUInt32();
        
        if (wp->move_type >= WAYPOINT_MOVE_TYPE_MAX)
        {
            //TC_LOG_ERROR("sql.sql", "Waypoint %u in waypoint_data has invalid move_type, ignoring", wp->id);
            delete wp;
            continue;
        }
        
        wp->delay = fields[6].GetUInt32();
        wp->event_id = fields[7].GetUInt32();
        wp->event_chance = fields[8].GetUInt8();

        path.push_back(wp);

    }
    while (result->NextRow());
}
