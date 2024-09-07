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

#include "MMapMgr.h"
#include "Config.h"
#include "Errors.h"
#include "Log.h"
#include "MapDefines.h"

namespace MMAP
{
    static char const* const MAP_FILE_NAME_FORMAT = "{}/mmaps/{:03}.mmap";
    static char const* const TILE_FILE_NAME_FORMAT = "{}/mmaps/{:03}{:02}{:02}.mmtile";

    // ######################## MMapMgr ########################
    MMapMgr::~MMapMgr()
    {
        for (MMapDataSet::iterator i = loadedMMaps.begin(); i != loadedMMaps.end(); ++i)
        {
            delete i->second;
        }

        // by now we should not have maps loaded
        // if we had, tiles in MMapData->mmapLoadedTiles, their actual data is lost!
    }

    void MMapMgr::InitializeThreadUnsafe(const std::vector<uint32>& mapIds)
    {
        // the caller must pass the list of all mapIds that will be used in the VMapMgr2 lifetime
        for (const uint32& mapId : mapIds)
        {
            loadedMMaps.emplace(mapId, nullptr);
        }

        thread_safe_environment = false;
    }

    MMapDataSet::const_iterator MMapMgr::GetMMapData(uint32 mapId) const
    {
        // return the iterator if found or end() if not found/NULL
        MMapDataSet::const_iterator itr = loadedMMaps.find(mapId);
        if (itr != loadedMMaps.cend() && !itr->second)
        {
            itr = loadedMMaps.cend();
        }

        return itr;
    }

    bool MMapMgr::loadMapData(uint32 mapId)
    {
        // we already have this map loaded?
        MMapDataSet::iterator itr = loadedMMaps.find(mapId);
        if (itr != loadedMMaps.end())
        {
            if (itr->second)
            {
                return true;
            }
        }
        else
        {
            if (thread_safe_environment)
            {
                itr = loadedMMaps.insert(MMapDataSet::value_type(mapId, nullptr)).first;
            }
            else
            {
                ABORT("Invalid mapId {} passed to MMapMgr after startup in thread unsafe environment", mapId);
            }
        }

        // load and init dtNavMesh - read parameters from file
        std::string fileName = Acore::StringFormat(MAP_FILE_NAME_FORMAT, sConfigMgr->GetOption<std::string>("DataDir", "."), mapId);

        FILE* file = fopen(fileName.c_str(), "rb");
        if (!file)
        {
            LOG_DEBUG("maps", "MMAP:loadMapData: Error: Could not open mmap file '{}'", fileName);
            return false;
        }

        dtNavMeshParams params;
        uint32 count = uint32(fread(&params, sizeof(dtNavMeshParams), 1, file));
        fclose(file);
        if (count != 1)
        {
            LOG_DEBUG("maps", "MMAP:loadMapData: Error: Could not read params from file '{}'", fileName);
            return false;
        }

        dtNavMesh* mesh = dtAllocNavMesh();
        ASSERT(mesh);
        if (DT_SUCCESS != mesh->init(&params))
        {
            dtFreeNavMesh(mesh);
            LOG_ERROR("maps", "MMAP:loadMapData: Failed to initialize dtNavMesh for mmap {:03} from file {}", mapId, fileName);
            return false;
        }

        LOG_DEBUG("maps", "MMAP:loadMapData: Loaded {:03}.mmap", mapId);

        // store inside our map list
        MMapData* mmap_data = new MMapData(mesh);
        itr->second = mmap_data;
        return true;
    }

    uint32 MMapMgr::packTileID(int32 x, int32 y)
    {
        return uint32(x << 16 | y);
    }

    bool MMapMgr::loadMap(uint32 mapId, int32 x, int32 y)
    {
        // make sure the mmap is loaded and ready to load tiles
        if (!loadMapData(mapId))
        {
            return false;
        }

        // get this mmap data
        MMapData* mmap = loadedMMaps[mapId];
        ASSERT(mmap->navMesh);

        // check if we already have this tile loaded
        uint32 packedGridPos = packTileID(x, y);
        if (mmap->loadedTileRefs.find(packedGridPos) != mmap->loadedTileRefs.end())
        {
            // Peiru: Commented out for now because Playerbots system uses this method to load or check loaded maps and will spam logs
//            LOG_ERROR("maps", "MMAP:loadMap: Asked to load already loaded navmesh tile. {:03}{:02}{:02}.mmtile", mapId, x, y);
            return false;
        }

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
        if (dtStatusSucceed(mmap->navMesh->addTile(data, fileHeader.size, DT_TILE_FREE_DATA, 0, &tileRef)))
        {
            mmap->loadedTileRefs.insert(std::pair<uint32, dtTileRef>(packedGridPos, tileRef));
            ++loadedTiles;
            dtMeshHeader* header = (dtMeshHeader*)data;
            LOG_DEBUG("maps", "MMAP:loadMap: Loaded mmtile {:03}[{:02},{:02}] into {:03}[{:02},{:02}]", mapId, x, y, mapId, header->x, header->y);
            return true;
        }

        LOG_ERROR("maps", "MMAP:loadMap: Could not load {:03}{:02}{:02}.mmtile into navmesh", mapId, x, y);
        dtFree(data);
        return false;
    }

    bool MMapMgr::unloadMap(uint32 mapId, int32 x, int32 y)
    {
        // check if we have this map loaded
        MMapDataSet::const_iterator itr = GetMMapData(mapId);
        if (itr == loadedMMaps.end())
        {
            // file may not exist, therefore not loaded
            LOG_DEBUG("maps", "MMAP:unloadMap: Asked to unload not loaded navmesh map. {:03}{:02}{:02}.mmtile", mapId, x, y);
            return false;
        }

        MMapData* mmap = itr->second;

        // check if we have this tile loaded
        uint32 packedGridPos = packTileID(x, y);
        if (mmap->loadedTileRefs.find(packedGridPos) == mmap->loadedTileRefs.end())
        {
            // file may not exist, therefore not loaded
            LOG_DEBUG("maps", "MMAP:unloadMap: Asked to unload not loaded navmesh tile. {:03}{:02}{:02}.mmtile", mapId, x, y);
            return false;
        }

        dtTileRef tileRef = mmap->loadedTileRefs[packedGridPos];

        // unload, and mark as non loaded
        if (dtStatusFailed(mmap->navMesh->removeTile(tileRef, nullptr, nullptr)))
        {
            // this is technically a memory leak
            // if the grid is later reloaded, dtNavMesh::addTile will return error but no extra memory is used
            // we cannot recover from this error - assert out
            LOG_ERROR("maps", "MMAP:unloadMap: Could not unload {:03}{:02}{:02}.mmtile from navmesh", mapId, x, y);
            ABORT();
        }

        mmap->loadedTileRefs.erase(packedGridPos);
        --loadedTiles;
        LOG_DEBUG("maps", "MMAP:unloadMap: Unloaded mmtile {:03}[{:02},{:02}] from {:03}", mapId, x, y, mapId);
        return true;
    }

    bool MMapMgr::unloadMap(uint32 mapId)
    {
        MMapDataSet::iterator itr = loadedMMaps.find(mapId);
        if (itr == loadedMMaps.end() || !itr->second)
        {
            // file may not exist, therefore not loaded
            LOG_DEBUG("maps", "MMAP:unloadMap: Asked to unload not loaded navmesh map {:03}", mapId);
            return false;
        }

        // unload all tiles from given map
        MMapData* mmap = itr->second;
        for (auto& i : mmap->loadedTileRefs)
        {
            uint32 x = (i.first >> 16);
            uint32 y = (i.first & 0x0000FFFF);

            if (dtStatusFailed(mmap->navMesh->removeTile(i.second, nullptr, nullptr)))
            {
                LOG_ERROR("maps", "MMAP:unloadMap: Could not unload {:03}{:02}{:02}.mmtile from navmesh", mapId, x, y);
            }
            else
            {
                --loadedTiles;
                LOG_DEBUG("maps", "MMAP:unloadMap: Unloaded mmtile {:03}[{:02},{:02}] from {:03}", mapId, x, y, mapId);
            }
        }

        delete mmap;
        itr->second = nullptr;
        LOG_DEBUG("maps", "MMAP:unloadMap: Unloaded {:03}.mmap", mapId);

        return true;
    }

    bool MMapMgr::unloadMapInstance(uint32 mapId, uint32 instanceId)
    {
        // check if we have this map loaded
        MMapDataSet::const_iterator itr = GetMMapData(mapId);
        if (itr == loadedMMaps.end())
        {
            // file may not exist, therefore not loaded
            LOG_DEBUG("maps", "MMAP:unloadMapInstance: Asked to unload not loaded navmesh map {:03}", mapId);
            return false;
        }

        MMapData* mmap = itr->second;
        if (mmap->navMeshQueries.find(instanceId) == mmap->navMeshQueries.end())
        {
            LOG_DEBUG("maps", "MMAP:unloadMapInstance: Asked to unload not loaded dtNavMeshQuery mapId {:03} instanceId {}", mapId, instanceId);
            return false;
        }

        dtNavMeshQuery* query = mmap->navMeshQueries[instanceId];

        dtFreeNavMeshQuery(query);
        mmap->navMeshQueries.erase(instanceId);
        LOG_DEBUG("maps", "MMAP:unloadMapInstance: Unloaded mapId {:03} instanceId {}", mapId, instanceId);

        return true;
    }

    dtNavMesh const* MMapMgr::GetNavMesh(uint32 mapId)
    {
        MMapDataSet::const_iterator itr = GetMMapData(mapId);
        if (itr == loadedMMaps.end())
        {
            return nullptr;
        }

        return itr->second->navMesh;
    }

    dtNavMeshQuery const* MMapMgr::GetNavMeshQuery(uint32 mapId, uint32 instanceId)
    {
        MMapDataSet::const_iterator itr = GetMMapData(mapId);
        if (itr == loadedMMaps.end())
        {
            return nullptr;
        }

        MMapData* mmap = itr->second;
        if (mmap->navMeshQueries.find(instanceId) == mmap->navMeshQueries.end())
        {
            // check again after acquiring mutex
            if (mmap->navMeshQueries.find(instanceId) == mmap->navMeshQueries.end())
            {
                // allocate mesh query
                dtNavMeshQuery* query = dtAllocNavMeshQuery();
                ASSERT(query);

                if (dtStatusFailed(query->init(mmap->navMesh, 1024)))
                {
                    dtFreeNavMeshQuery(query);
                    LOG_ERROR("maps", "MMAP:GetNavMeshQuery: Failed to initialize dtNavMeshQuery for mapId {:03} instanceId {}", mapId, instanceId);
                    return nullptr;
                }

                LOG_DEBUG("maps", "MMAP:GetNavMeshQuery: created dtNavMeshQuery for mapId {:03} instanceId {}", mapId, instanceId);
                mmap->navMeshQueries.insert(std::pair<uint32, dtNavMeshQuery*>(instanceId, query));
            }
        }

        return mmap->navMeshQueries[instanceId];
    }
}
