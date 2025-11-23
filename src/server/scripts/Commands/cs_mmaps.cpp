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

/**
* @file cs_mmaps.cpp
* @brief .mmap related commands
*
* This file contains the CommandScripts for all
* mmap sub-commands
*/

#include "CellImpl.h"
#include "Chat.h"
#include "CommandScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "MMapFactory.h"
#include "MMapMgr.h"
#include "Map.h"
#include "PathGenerator.h"
#include "Player.h"
#include "TargetedMovementGenerator.h"

using namespace Acore::ChatCommands;

class mmaps_commandscript : public CommandScript
{
public:
    mmaps_commandscript() : CommandScript("mmaps_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable mmapCommandTable =
        {
            { "loadedtiles", HandleMmapLoadedTilesCommand, SEC_ADMINISTRATOR, Console::No },
            { "loc",         HandleMmapLocCommand,         SEC_ADMINISTRATOR, Console::No },
            { "path",        HandleMmapPathCommand,        SEC_ADMINISTRATOR, Console::No },
            { "stats",       HandleMmapStatsCommand,       SEC_ADMINISTRATOR, Console::No },
            { "testarea",    HandleMmapTestArea,           SEC_ADMINISTRATOR, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "mmap", mmapCommandTable }
        };
        return commandTable;
    }

    static bool HandleMmapPathCommand(ChatHandler* handler, Optional<std::string> param)
    {
        if (!MMAP::MMapFactory::createOrGetMMapMgr()->GetNavMesh(handler->GetSession()->GetPlayer()->GetMapId()))
        {
            handler->PSendSysMessage("NavMesh not loaded for current map.");
            return true;
        }

        handler->PSendSysMessage("mmap path:");

        // units
        Player* player = handler->GetSession()->GetPlayer();
        Unit* target = handler->getSelectedUnit();
        if (!player || !target)
        {
            handler->PSendSysMessage("Invalid target/source selection.");
            return true;
        }

        bool useStraightPath = false;
        bool useRaycast = false;
        if (param)
        {
            auto paramValue = param.value();
            if (paramValue.starts_with("true"))
            {
                useStraightPath = true;
            }

            if (paramValue.starts_with("line") || paramValue.starts_with("ray") || paramValue.starts_with("raycast"))
            {
                useRaycast = true;
            }
        }

        // unit locations
        float x, y, z;
        player->GetPosition(x, y, z);

        // path
        PathGenerator path(target);
        path.SetUseStraightPath(useStraightPath);
        path.SetUseRaycast(useRaycast);
        bool result = path.CalculatePath(x, y, z, false);

        Movement::PointsArray const& pointPath = path.GetPath();
        handler->PSendSysMessage("{}'s path to {}:", target->GetName(), player->GetName());
        handler->PSendSysMessage("Building: {}", useStraightPath ? "StraightPath" : useRaycast ? "Raycast" : "SmoothPath");
        handler->PSendSysMessage("Result: {} - Length: {} - Type: {}", (result ? "true" : "false"), pointPath.size(), path.GetPathType());

        G3D::Vector3 const& start = path.GetStartPosition();
        G3D::Vector3 const& end = path.GetEndPosition();
        G3D::Vector3 const& actualEnd = path.GetActualEndPosition();

        handler->PSendSysMessage("StartPosition     ({}, {}, {})", start.x, start.y, start.z);
        handler->PSendSysMessage("EndPosition       ({}, {}, {})", end.x, end.y, end.z);
        handler->PSendSysMessage("ActualEndPosition ({}, {}, {})", actualEnd.x, actualEnd.y, actualEnd.z);

        if (!player->IsGameMaster())
            handler->PSendSysMessage("Enable GM mode to see the path points.");

        for (auto i : pointPath)
            player->SummonCreature(VISUAL_WAYPOINT, i.x, i.y, i.z, 0, TEMPSUMMON_TIMED_DESPAWN, 9000);

        return true;
    }

    static bool HandleMmapLocCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage("mmap tileloc:");

        // grid tile location
        Player* player = handler->GetSession()->GetPlayer();

        GridCoord const gridCoord = Acore::ComputeGridCoord(player->GetPositionX(), player->GetPositionY());

        handler->PSendSysMessage("{}{}{}.mmtile", player->GetMapId(), gridCoord.x_coord, gridCoord.y_coord);

        std::string fileName = Acore::StringFormat(MMAP::TILE_FILE_NAME_FORMAT, sConfigMgr->GetOption<std::string>("DataDir", "."), player->GetMapId(), gridCoord.x_coord, gridCoord.y_coord);
        FILE* file = fopen(fileName.c_str(), "rb");
        if (!file)
        {
            LOG_DEBUG("maps", "MMAP:loadMap: Could not open mmtile file '{}'", fileName);
            return false;
        }

        // read header
        MmapTileHeader fileHeader;
        if (fread(&fileHeader, sizeof(MmapTileHeader), 1, file) != 1 || fileHeader.mmapMagic != MMAP_MAGIC)
        {
            LOG_ERROR("maps", "MMAP:loadMap: Bad header in mmap {:03}{:02}{:02}.mmtile", player->GetMapId(), gridCoord.x_coord, gridCoord.y_coord);
            fclose(file);
            return false;
        }
        fclose(file);
        handler->PSendSysMessage("Recast config used:");
        handler->PSendSysMessage("- walkableSlopeAngle: {}", fileHeader.recastConfig.walkableSlopeAngle);

        const float cellHeight = fileHeader.recastConfig.cellSizeVertical;
        handler->PSendSysMessage("- walkableHeight: {} ({} units)", fileHeader.recastConfig.walkableHeight * cellHeight, fileHeader.recastConfig.walkableHeight);
        handler->PSendSysMessage("- walkableClimb: {} ({} units)", fileHeader.recastConfig.walkableClimb * cellHeight, fileHeader.recastConfig.walkableClimb);
        handler->PSendSysMessage("- walkableRadius: {} ({} units)", fileHeader.recastConfig.walkableRadius * cellHeight, fileHeader.recastConfig.walkableRadius);

        handler->PSendSysMessage("- maxSimplificationError: {}", fileHeader.recastConfig.maxSimplificationError);
        handler->PSendSysMessage("- vertexPerMapEdge: {}", fileHeader.recastConfig.vertexPerMapEdge);
        handler->PSendSysMessage("- vertexPerTileEdge: {}", fileHeader.recastConfig.vertexPerTileEdge);
        handler->PSendSysMessage("- tilesPerMapEdge: {}", fileHeader.recastConfig.tilesPerMapEdge);
        handler->PSendSysMessage("- baseUnitDim: {}", fileHeader.recastConfig.baseUnitDim);
        handler->PSendSysMessage("- cellSizeHorizontal: {}", fileHeader.recastConfig.cellSizeHorizontal);
        handler->PSendSysMessage("- cellSizeVertical: {}", fileHeader.recastConfig.cellSizeVertical);

        handler->PSendSysMessage("gridloc [{}, {}]", gridCoord.x_coord, gridCoord.y_coord);

        // calculate navmesh tile location
        dtNavMesh const* navmesh = MMAP::MMapFactory::createOrGetMMapMgr()->GetNavMesh(handler->GetSession()->GetPlayer()->GetMapId());
        dtNavMeshQuery const* navmeshquery = MMAP::MMapFactory::createOrGetMMapMgr()->GetNavMeshQuery(handler->GetSession()->GetPlayer()->GetMapId(), player->GetInstanceId());
        if (!navmesh || !navmeshquery)
        {
            handler->PSendSysMessage("NavMesh not loaded for current map.");
            return true;
        }

        float const* min = navmesh->getParams()->orig;
        float x, y, z;
        player->GetPosition(x, y, z);
        float location[VERTEX_SIZE] = {y, z, x};
        float extents[VERTEX_SIZE] = {3.0f, 5.0f, 3.0f};

        int32 tilex = int32((y - min[0]) / SIZE_OF_GRIDS);
        int32 tiley = int32((x - min[2]) / SIZE_OF_GRIDS);

        handler->PSendSysMessage("Calc   [{}, {}]", tilex, tiley);

        // navmesh poly -> navmesh tile location
        dtQueryFilterExt filter = dtQueryFilterExt();
        dtPolyRef polyRef = INVALID_POLYREF;
        if (dtStatusFailed(navmeshquery->findNearestPoly(location, extents, &filter, &polyRef, nullptr)))
        {
            handler->PSendSysMessage("Dt     [??,??] (invalid poly, probably no tile loaded)");
            return true;
        }

        if (polyRef == INVALID_POLYREF)
            handler->PSendSysMessage("Dt     [??, ??] (invalid poly, probably no tile loaded)");
        else
        {
            dtMeshTile const* tile;
            dtPoly const* poly;
            if (dtStatusSucceed(navmesh->getTileAndPolyByRef(polyRef, &tile, &poly)))
            {
                if (tile)
                {
                    handler->PSendSysMessage("Dt     [{},{}]", tile->header->x, tile->header->y);
                    return false;
                }
            }

            handler->PSendSysMessage("Dt     [??,??] (no tile loaded)");
        }

        return true;
    }

    static bool HandleMmapLoadedTilesCommand(ChatHandler* handler)
    {
        uint32 mapid = handler->GetSession()->GetPlayer()->GetMapId();
        dtNavMesh const* navmesh = MMAP::MMapFactory::createOrGetMMapMgr()->GetNavMesh(mapid);
        dtNavMeshQuery const* navmeshquery = MMAP::MMapFactory::createOrGetMMapMgr()->GetNavMeshQuery(mapid, handler->GetSession()->GetPlayer()->GetInstanceId());
        if (!navmesh || !navmeshquery)
        {
            handler->PSendSysMessage("NavMesh not loaded for current map.");
            return true;
        }

        handler->PSendSysMessage("mmap loadedtiles:");

        for (int32 i = 0; i < navmesh->getMaxTiles(); ++i)
        {
            dtMeshTile const* tile = navmesh->getTile(i);
            if (!tile || !tile->header)
                continue;

            handler->PSendSysMessage("[{}, {}]", tile->header->x, tile->header->y);
        }

        return true;
    }

    static bool HandleMmapStatsCommand(ChatHandler* handler)
    {
        handler->PSendSysMessage("mmap stats:");
        //handler->PSendSysMessage("  global mmap pathfinding is {}abled", sDisableMgr->IsPathfindingEnabled(mapId) ? "en" : "dis");
        MMAP::MMapMgr* manager = MMAP::MMapFactory::createOrGetMMapMgr();
        handler->PSendSysMessage(" {} maps loaded with {} tiles overall", manager->getLoadedMapsCount(), manager->getLoadedTilesCount());

        dtNavMesh const* navmesh = manager->GetNavMesh(handler->GetSession()->GetPlayer()->GetMapId());
        if (!navmesh)
        {
            handler->PSendSysMessage("NavMesh not loaded for current map.");
            return true;
        }

        uint32 tileCount = 0;
        uint32 nodeCount = 0;
        uint32 polyCount = 0;
        uint32 vertCount = 0;
        uint32 triCount = 0;
        uint32 triVertCount = 0;
        uint32 dataSize = 0;
        for (int32 i = 0; i < navmesh->getMaxTiles(); ++i)
        {
            dtMeshTile const* tile = navmesh->getTile(i);
            if (!tile || !tile->header)
                continue;

            tileCount++;
            nodeCount += tile->header->bvNodeCount;
            polyCount += tile->header->polyCount;
            vertCount += tile->header->vertCount;
            triCount += tile->header->detailTriCount;
            triVertCount += tile->header->detailVertCount;
            dataSize += tile->dataSize;
        }

        handler->PSendSysMessage("Navmesh stats:");
        handler->PSendSysMessage(" {} tiles loaded", tileCount);
        handler->PSendSysMessage(" {} BVTree nodes", nodeCount);
        handler->PSendSysMessage(" {} polygons ({} vertices)", polyCount, vertCount);
        handler->PSendSysMessage(" {} triangles ({} vertices)", triCount, triVertCount);
        handler->PSendSysMessage(" {} MB of data (not including pointers)", ((float)dataSize / sizeof(unsigned char)) / 1048576);

        return true;
    }

    static bool HandleMmapTestArea(ChatHandler* handler)
    {
        float radius = 40.0f;
        WorldObject* object = handler->GetSession()->GetPlayer();

        // Get Creatures
        std::list<Creature*> creatureList;
        Acore::AnyUnitInObjectRangeCheck go_check(object, radius);
        Acore::CreatureListSearcher<Acore::AnyUnitInObjectRangeCheck> go_search(object, creatureList, go_check);
        Cell::VisitObjects(object, go_search, radius);

        if (!creatureList.empty())
        {
            handler->PSendSysMessage("Found {} Creatures.", creatureList.size());

            uint32 paths = 0;
            uint32 uStartTime = getMSTime();

            float gx, gy, gz;
            object->GetPosition(gx, gy, gz);
            for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
            {
                PathGenerator path(*itr);
                path.CalculatePath(gx, gy, gz);
                ++paths;
            }

            uint32 uPathLoadTime = getMSTimeDiff(uStartTime, getMSTime());
            handler->PSendSysMessage("Generated {} paths in {} ms", paths, uPathLoadTime);
        }
        else
            handler->PSendSysMessage("No creatures in {} yard range.", radius);

        return true;
    }
};

void AddSC_mmaps_commandscript()
{
    new mmaps_commandscript();
}
