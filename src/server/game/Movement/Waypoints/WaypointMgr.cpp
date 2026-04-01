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

#include "WaypointMgr.h"
#include "DatabaseEnv.h"
#include "GridDefines.h"
#include "Log.h"
#include "QueryResult.h"
#include "Timer.h"

WaypointMgr* WaypointMgr::instance()
{
    static WaypointMgr instance;
    return &instance;
}

void WaypointMgr::Load()
{
    uint32 oldMSTime = getMSTime();

    //                                                0    1         2           3          4            5          6      7      8                 9         10       11
    QueryResult result = WorldDatabase.Query("SELECT id, point, position_x, position_y, position_z, orientation, velocity, delay, smoothTransition, move_type, action, action_chance FROM waypoint_data ORDER BY id, point");

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
        uint32 pathId = fields[0].Get<uint32>();
        float x = fields[2].Get<float>();
        float y = fields[3].Get<float>();
        float z = fields[4].Get<float>();
        std::optional<float> o;
        if (!fields[5].IsNull())
            o = fields[5].Get<float>();

        float velocity = fields[6].Get<float>();

        Acore::NormalizeMapCoord(x);
        Acore::NormalizeMapCoord(y);

        WaypointNode waypoint;
        waypoint.Id = fields[1].Get<uint32>();
        waypoint.X = x;
        waypoint.Y = y;
        waypoint.Z = z;
        if (o.has_value())
            waypoint.Orientation = o;
        waypoint.Velocity = velocity;
        waypoint.Delay = fields[7].Get<uint32>();
        waypoint.SmoothTransition = fields[8].Get<bool>();
        waypoint.MoveType = fields[9].Get<uint32>();

        if (waypoint.MoveType >= WAYPOINT_MOVE_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "Waypoint {} in waypoint_data has invalid move_type, ignoring", waypoint.Id);
            continue;
        }

        waypoint.EventId = fields[10].Get<uint32>();
        waypoint.EventChance = fields[11].Get<int16>();

        WaypointPath& path = _waypointStore[pathId];
        path.Id = pathId;
        path.Nodes.push_back(std::move(waypoint));
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} waypoints in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void WaypointMgr::LoadWaypointAddons()
{
    uint32 oldMSTime = getMSTime();

    //                                               0       1        2                 3          4          5
    QueryResult result = WorldDatabase.Query("SELECT PathID, PointID, SplinePointIndex, PositionX, PositionY, PositionZ FROM waypoint_data_addon ORDER BY PathID, PointID, SplinePointIndex");

    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 waypoint addon data. DB table `waypoint_data_addon` is empty!");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 pathId = fields[0].Get<uint32>();

        auto it = _waypointStore.find(pathId);
        if (it == _waypointStore.end())
        {
            LOG_ERROR("sql.sql", "Tried to load waypoint_data_addon data for PathID {} but there is no such path in waypoint_data. Ignoring.", pathId);
            continue;
        }

        WaypointPath& path = it->second;
        uint32 pointId = fields[1].Get<uint32>();

        auto itr = std::find_if(path.Nodes.begin(), path.Nodes.end(), [pointId](WaypointNode const& node)
        {
            return node.Id == pointId;
        });

        if (itr == path.Nodes.end())
        {
            LOG_ERROR("sql.sql", "Tried to load waypoint_data_addon data for PointID {} of PathID {} but there is no such point in waypoint_data. Ignoring.", pointId, pathId);
            continue;
        }

        float x = fields[3].Get<float>();
        float y = fields[4].Get<float>();
        float z = fields[5].Get<float>();

        Acore::NormalizeMapCoord(x);
        Acore::NormalizeMapCoord(y);

        itr->SplinePoints.push_back(G3D::Vector3(x, y, z));

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} waypoint addon data in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void WaypointMgr::ReloadPath(uint32 id)
{
    auto itr = _waypointStore.find(id);
    if (itr != _waypointStore.end())
        _waypointStore.erase(itr);

    WorldDatabasePreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_WAYPOINT_DATA_BY_ID);

    stmt->SetData(0, id);

    PreparedQueryResult result = WorldDatabase.Query(stmt);

    if (!result)
        return;

    std::vector<WaypointNode> values;
    do
    {
        Field* fields = result->Fetch();
        float x = fields[1].Get<float>();
        float y = fields[2].Get<float>();
        float z = fields[3].Get<float>();
        std::optional<float> o;
        if (!fields[4].IsNull())
            o = fields[4].Get<float>();

        float velocity = fields[5].Get<float>();

        Acore::NormalizeMapCoord(x);
        Acore::NormalizeMapCoord(y);

        WaypointNode waypoint;
        waypoint.Id = fields[0].Get<uint32>();
        waypoint.X = x;
        waypoint.Y = y;
        waypoint.Z = z;
        if (o.has_value())
            waypoint.Orientation = o;
        waypoint.Velocity = velocity;
        waypoint.Delay = fields[6].Get<uint32>();
        waypoint.SmoothTransition = fields[7].Get<bool>();
        waypoint.MoveType = fields[8].Get<uint32>();

        if (waypoint.MoveType >= WAYPOINT_MOVE_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "Waypoint {} in waypoint_data has invalid move_type, ignoring", waypoint.Id);
            continue;
        }

        waypoint.EventId = fields[9].Get<uint32>();
        waypoint.EventChance = fields[10].Get<uint8>();

        values.push_back(std::move(waypoint));
    } while (result->NextRow());

    _waypointStore[id] = WaypointPath(id, std::move(values));
}
