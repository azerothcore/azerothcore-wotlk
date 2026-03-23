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

#include "MMapMgr.h"
#include "Config.h"
#include "Errors.h"
#include "Log.h"
#include "MapDefines.h"

namespace MMAP
{
    // ######################## MMapMgr ########################
    std::shared_ptr<dtNavMesh> MMapMgr::LoadNavMesh(uint32 mapId)
    {
        // load and init dtNavMesh - read parameters from file
        std::string fileName = Acore::StringFormat(MAP_FILE_NAME_FORMAT, sConfigMgr->GetOption<std::string>("DataDir", "."), mapId);

        FILE* file = fopen(fileName.c_str(), "rb");
        if (!file)
        {
            LOG_DEBUG("maps", "MMAP:loadMapData: Error: Could not open mmap file '{}'", fileName);
            return nullptr;
        }

        dtNavMeshParams params;
        uint32 count = uint32(fread(&params, sizeof(dtNavMeshParams), 1, file));
        fclose(file);
        if (count != 1)
        {
            LOG_DEBUG("maps", "MMAP:loadMapData: Error: Could not read params from file '{}'", fileName);
            return nullptr;
        }

        dtNavMesh* mesh = dtAllocNavMesh();
        ASSERT(mesh);
        if (DT_SUCCESS != mesh->init(&params))
        {
            dtFreeNavMesh(mesh);
            LOG_ERROR("maps", "MMAP:loadMapData: Failed to initialize dtNavMesh for mmap {:03} from file {}", mapId, fileName);
            return nullptr;
        }

        LOG_DEBUG("maps", "MMAP:loadMapData: Loaded {:03}.mmap", mapId);

        std::shared_ptr<dtNavMesh> navMesh = std::shared_ptr<dtNavMesh>(mesh, NavMeshDeleter());
        return navMesh;
    }

    uint32 MMapMgr::packTileID(int32 x, int32 y)
    {
        return uint32(x << 16 | y);
    }

    bool MMapMgr::LoadTile(dtNavMesh* navMesh, uint32 mapId, int32 x, int32 y)
    {
        // load this tile :: mmaps/MMMXXYY.mmtile
        std::string fileName = Acore::StringFormat(TILE_FILE_NAME_FORMAT, sConfigMgr->GetOption<std::string>("DataDir", "."), mapId, x, y);
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
            LOG_ERROR("maps", "MMAP:loadMap: Bad header in mmap {:03}{:02}{:02}.mmtile", mapId, x, y);
            fclose(file);
            return false;
        }

        if (fileHeader.mmapVersion != MMAP_VERSION)
        {
            LOG_ERROR("maps", "MMAP:loadMap: {:03}{:02}{:02}.mmtile was built with generator v{}, expected v{}",
                           mapId, x, y, fileHeader.mmapVersion, MMAP_VERSION);
            fclose(file);
            return false;
        }

        unsigned char* data = (unsigned char*)dtAlloc(fileHeader.size, DT_ALLOC_PERM);
        ASSERT(data);

        std::size_t result = fread(data, fileHeader.size, 1, file);
        if (!result)
        {
            LOG_ERROR("maps", "MMAP:loadMap: Bad header or data in mmap {:03}{:02}{:02}.mmtile", mapId, x, y);
            fclose(file);
            return false;
        }

        fclose(file);

        dtTileRef tileRef = 0;

        // memory allocated for data is now managed by detour, and will be deallocated when the tile is removed
        if (dtStatusSucceed(navMesh->addTile(data, fileHeader.size, DT_TILE_FREE_DATA, 0, &tileRef)))
        {
            dtMeshHeader* header = (dtMeshHeader*)data;
            LOG_DEBUG("maps", "MMAP:loadMap: Loaded mmtile {:03}[{:02},{:02}] into {:03}[{:02},{:02}]", mapId, x, y, mapId, header->x, header->y);
            return true;
        }

        LOG_ERROR("maps", "MMAP:loadMap: Could not load {:03}{:02}{:02}.mmtile into navmesh", mapId, x, y);
        dtFree(data);
        return false;
    }

    ManagedNavMeshQuery MMapMgr::CreateNavMeshQuery(dtNavMesh* navMesh)
    {
        // allocate mesh query
        dtNavMeshQuery* query = dtAllocNavMeshQuery();
        ASSERT(query);

        if (dtStatusFailed(query->init(navMesh, 1024)))
        {
            dtFreeNavMeshQuery(query);
            return nullptr;
        }

        ManagedNavMeshQuery navMeshQuery = ManagedNavMeshQuery(query);
        return navMeshQuery;
    }
}
