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

#include "WaypointMgr.h"
#include "DatabaseEnv.h"
#include "GridDefines.h"
#include "Log.h"
#include "QueryResult.h"
#include "Timer.h"

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
        LOG_WARN("server.loading", ">> Loaded 0 waypoints. DB table `waypoint_data` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        WaypointData* wp = new WaypointData();

        uint32 pathId = fields[0].Get<uint32>();
        WaypointPath& path = _waypointStore[pathId];

        float x = fields[2].Get<float>();
        float y = fields[3].Get<float>();
        float z = fields[4].Get<float>();
        std::optional<float > o;
        if (!fields[5].IsNull())
            o = fields[5].Get<float>();

        Acore::NormalizeMapCoord(x);
        Acore::NormalizeMapCoord(y);

        wp->id = fields[1].Get<uint32>();
        wp->x = x;
        wp->y = y;
        wp->z = z;
        wp->orientation = o;
        wp->move_type = fields[6].Get<uint32>();

        if (wp->move_type >= WAYPOINT_MOVE_TYPE_MAX)
        {
            //LOG_ERROR("sql.sql", "Waypoint {} in waypoint_data has invalid move_type, ignoring", wp->id);
            delete wp;
            continue;
        }

        wp->delay = fields[7].Get<uint32>();
        wp->event_id = fields[8].Get<uint32>();
        wp->event_chance = fields[9].Get<int16>();

        path.push_back(wp);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} waypoints in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
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

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_WAYPOINT_DATA_BY_ID);

    stmt->SetData(0, id);

    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
        return;

    WaypointPath& path = _waypointStore[id];

    do
    {
        Field* fields = result->Fetch();
        WaypointData* wp = new WaypointData();

        float x = fields[1].Get<float>();
        float y = fields[2].Get<float>();
        float z = fields[3].Get<float>();
        std::optional<float> o;
        if (!fields[4].IsNull())
            o = fields[4].Get<float>();

        Acore::NormalizeMapCoord(x);
        Acore::NormalizeMapCoord(y);

        wp->id = fields[0].Get<uint32>();
        wp->x = x;
        wp->y = y;
        wp->z = z;
        wp->orientation = o;
        wp->move_type = fields[5].Get<uint32>();

        if (wp->move_type >= WAYPOINT_MOVE_TYPE_MAX)
        {
            //LOG_ERROR("sql.sql", "Waypoint {} in waypoint_data has invalid move_type, ignoring", wp->id);
            delete wp;
            continue;
        }

        wp->delay = fields[6].Get<uint32>();
        wp->event_id = fields[7].Get<uint32>();
        wp->event_chance = fields[8].Get<uint8>();

        path.push_back(wp);
    } while (result->NextRow());
}
