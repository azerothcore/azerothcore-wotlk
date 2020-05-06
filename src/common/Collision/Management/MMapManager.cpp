/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MapManager.h"
#include "MMapManager.h"
#include "Log.h"

namespace MMAP
{
    // ######################## MMapManager ########################
    MMapManager::~MMapManager()
    {
        for (MMapDataSet::iterator i = loadedMMaps.begin(); i != loadedMMaps.end(); ++i)
            delete i->second;

        // by now we should not have maps loaded
        // if we had, tiles in MMapData->mmapLoadedTiles, their actual data is lost!
    }

    bool MMapManager::loadMapData(uint32 mapId)
    {
        // we already have this map loaded?
        if (loadedMMaps.find(mapId) != loadedMMaps.end())
            return true;

        // load and init dtNavMesh - read parameters from file
        uint32 pathLen = sWorld->GetDataPath().length() + strlen("mmaps/%03i.mmap")+1;
        char *fileName = new char[pathLen];
        snprintf(fileName, pathLen, (sWorld->GetDataPath()+"mmaps/%03i.mmap").c_str(), mapId);

        FILE* file = fopen(fileName, "rb");
        if (!file)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:loadMapData: Error: Could not open mmap file '%s'", fileName);
#endif
            delete [] fileName;
            return false;
        }

        dtNavMeshParams params;
        int count = fread(&params, sizeof(dtNavMeshParams), 1, file);
        fclose(file);
        if (count != 1)
        {
            ;//TC_LOG_DEBUG(LOG_FILTER_MAPS, "MMAP:loadMapData: Error: Could not read params from file '%s'", fileName);
            delete [] fileName;
            return false;
        }

        dtNavMesh* mesh = dtAllocNavMesh();
        ASSERT(mesh);
        if (DT_SUCCESS != mesh->init(&params))
        {
            dtFreeNavMesh(mesh);
            sLog->outError("MMAP:loadMapData: Failed to initialize dtNavMesh for mmap %03u from file %s", mapId, fileName);
            delete [] fileName;
            return false;
        }

        delete [] fileName;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail("MMAP:loadMapData: Loaded %03i.mmap", mapId);
#endif

        // store inside our map list
        MMapData* mmap_data = new MMapData(mesh);
        mmap_data->mmapLoadedTiles.clear();

        loadedMMaps.insert(std::pair<uint32, MMapData*>(mapId, mmap_data));
        return true;
    }

    uint32 MMapManager::packTileID(int32 x, int32 y)
    {
        return uint32(x << 16 | y);
    }

    ACE_RW_Thread_Mutex& MMapManager::GetMMapLock(uint32 mapId)
    {
        Map* map = sMapMgr->FindBaseMap(mapId);
        if (!map)
        {
            sLog->outMisc("ZOMG! MoveMaps: BaseMap not found!");
            return this->MMapLock;
        }
        return map->GetMMapLock();
    }

    bool MMapManager::loadMap(uint32 mapId, int32 x, int32 y)
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, MMapManagerLock);

        // make sure the mmap is loaded and ready to load tiles
        if(!loadMapData(mapId))
            return false;

        // get this mmap data
        MMapData* mmap = loadedMMaps[mapId];
        ASSERT(mmap->navMesh);

        // check if we already have this tile loaded
        uint32 packedGridPos = packTileID(x, y);
        if (mmap->mmapLoadedTiles.find(packedGridPos) != mmap->mmapLoadedTiles.end())
        {
            sLog->outError("MMAP:loadMap: Asked to load already loaded navmesh tile. %03u%02i%02i.mmtile", mapId, x, y);
            return false;
        }

        // load this tile :: mmaps/MMMXXYY.mmtile
        uint32 pathLen = sWorld->GetDataPath().length() + strlen("mmaps/%03i%02i%02i.mmtile")+1;
        char *fileName = new char[pathLen];
        snprintf(fileName, pathLen, (sWorld->GetDataPath()+"mmaps/%03i%02i%02i.mmtile").c_str(), mapId, x, y);

        FILE *file = fopen(fileName, "rb");
        if (!file)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:loadMap: Could not open mmtile file '%s'", fileName);
#endif
            delete [] fileName;
            return false;
        }
        delete [] fileName;

        // read header
        MmapTileHeader fileHeader;
        if (fread(&fileHeader, sizeof(MmapTileHeader), 1, file) != 1 || fileHeader.mmapMagic != MMAP_MAGIC)
        {
            sLog->outError("MMAP:loadMap: Bad header in mmap %03u%02i%02i.mmtile", mapId, x, y);
            fclose(file);
            return false;
        }

        if (fileHeader.mmapVersion != MMAP_VERSION)
        {
            sLog->outError("MMAP:loadMap: %03u%02i%02i.mmtile was built with generator v%i, expected v%i",
                mapId, x, y, fileHeader.mmapVersion, MMAP_VERSION);
            fclose(file);
            return false;
        }

        unsigned char* data = (unsigned char*)dtAlloc(fileHeader.size, DT_ALLOC_PERM);
        ASSERT(data);

        size_t result = fread(data, fileHeader.size, 1, file);
        if(!result)
        {
            sLog->outError("MMAP:loadMap: Bad header or data in mmap %03u%02i%02i.mmtile", mapId, x, y);
            fclose(file);
            return false;
        }

        fclose(file);

        dtTileRef tileRef = 0;

        dtStatus stat;
        {
            ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, GetMMapLock(mapId));
            stat = mmap->navMesh->addTile(data, fileHeader.size, DT_TILE_FREE_DATA, 0, &tileRef);
        }

        // memory allocated for data is now managed by detour, and will be deallocated when the tile is removed
        if (stat == DT_SUCCESS)
        {
            mmap->mmapLoadedTiles.insert(std::pair<uint32, dtTileRef>(packedGridPos, tileRef));
            ++loadedTiles;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            dtMeshHeader* header = (dtMeshHeader*)data;
            sLog->outDetail("MMAP:loadMap: Loaded mmtile %03i[%02i,%02i] into %03i[%02i,%02i]", mapId, x, y, mapId, header->x, header->y);
#endif
            return true;
        }
        else
        {
            sLog->outError("MMAP:loadMap: Could not load %03u%02i%02i.mmtile into navmesh", mapId, x, y);
            dtFree(data);
            return false;
        }

        return false;
    }

    bool MMapManager::unloadMap(uint32 mapId, int32 x, int32 y)
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, MMapManagerLock);

        // check if we have this map loaded
        if (loadedMMaps.find(mapId) == loadedMMaps.end())
        {
            // file may not exist, therefore not loaded
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:unloadMap: Asked to unload not loaded navmesh map. %03u%02i%02i.mmtile", mapId, x, y);
#endif
            return false;
        }

        MMapData* mmap = loadedMMaps[mapId];

        // check if we have this tile loaded
        uint32 packedGridPos = packTileID(x, y);
        if (mmap->mmapLoadedTiles.find(packedGridPos) == mmap->mmapLoadedTiles.end())
        {
            // file may not exist, therefore not loaded
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:unloadMap: Asked to unload not loaded navmesh tile. %03u%02i%02i.mmtile", mapId, x, y);
#endif
            return false;
        }

        dtTileRef tileRef = mmap->mmapLoadedTiles[packedGridPos];

        dtStatus status;
        {
            ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, GetMMapLock(mapId));
            status = mmap->navMesh->removeTile(tileRef, NULL, NULL);
        }

        // unload, and mark as non loaded
        if (status != DT_SUCCESS)
        {
            // this is technically a memory leak
            // if the grid is later reloaded, dtNavMesh::addTile will return error but no extra memory is used
            // we cannot recover from this error - assert out
            sLog->outError("MMAP:unloadMap: Could not unload %03u%02i%02i.mmtile from navmesh", mapId, x, y);
            ABORT();
        }
        else
        {
            mmap->mmapLoadedTiles.erase(packedGridPos);
            --loadedTiles;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("MMAP:unloadMap: Unloaded mmtile %03i[%02i,%02i] from %03i", mapId, x, y, mapId);
#endif
            return true;
        }

        return false;
    }

    bool MMapManager::unloadMap(uint32 mapId)
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, MMapManagerLock);

        if (loadedMMaps.find(mapId) == loadedMMaps.end())
        {
            // file may not exist, therefore not loaded
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:unloadMap: Asked to unload not loaded navmesh map %03u", mapId);
#endif
            return false;
        }

        // unload all tiles from given map
        MMapData* mmap = loadedMMaps[mapId];
        for (MMapTileSet::iterator i = mmap->mmapLoadedTiles.begin(); i != mmap->mmapLoadedTiles.end(); ++i)
        {
            uint32 x = (i->first >> 16);
            uint32 y = (i->first & 0x0000FFFF);

            dtStatus status;
            {
                ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, GetMMapLock(mapId));
                status = mmap->navMesh->removeTile(i->second, NULL, NULL);
            }

            if (status != DT_SUCCESS)
                sLog->outError("MMAP:unloadMap: Could not unload %03u%02i%02i.mmtile from navmesh", mapId, x, y);
            else
            {
                --loadedTiles;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDetail("MMAP:unloadMap: Unloaded mmtile %03i[%02i,%02i] from %03i", mapId, x, y, mapId);
#endif
            }
        }

        delete mmap;
        loadedMMaps.erase(mapId);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail("MMAP:unloadMap: Unloaded %03i.mmap", mapId);
#endif

        return true;
    }

    bool MMapManager::unloadMapInstance(uint32 mapId, uint32 instanceId)
    {
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, MMapManagerLock);

        // check if we have this map loaded
        if (loadedMMaps.find(mapId) == loadedMMaps.end())
        {
            // file may not exist, therefore not loaded
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:unloadMapInstance: Asked to unload not loaded navmesh map %03u", mapId);
#endif
            return false;
        }

        MMapData* mmap = loadedMMaps[mapId];
        if (mmap->navMeshQueries.find(instanceId) == mmap->navMeshQueries.end())
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_MAPS, "MMAP:unloadMapInstance: Asked to unload not loaded dtNavMeshQuery mapId %03u instanceId %u", mapId, instanceId);
#endif
            return false;
        }

        dtNavMeshQuery* query = mmap->navMeshQueries[instanceId];

        dtFreeNavMeshQuery(query);
        mmap->navMeshQueries.erase(instanceId);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail("MMAP:unloadMapInstance: Unloaded mapId %03u instanceId %u", mapId, instanceId);
#endif

        return true;
    }

    dtNavMesh const* MMapManager::GetNavMesh(uint32 mapId)
    {
        // pussywizard: moved to calling function
        //ACORE_READ_GUARD(ACE_RW_Thread_Mutex, MMapManagerLock);

        if (loadedMMaps.find(mapId) == loadedMMaps.end())
            return NULL;

        return loadedMMaps[mapId]->navMesh;
    }

    dtNavMeshQuery const* MMapManager::GetNavMeshQuery(uint32 mapId, uint32 instanceId)
    {
        // pussywizard: moved to calling function
        //ACORE_READ_GUARD(ACE_RW_Thread_Mutex, MMapManagerLock);

        if (loadedMMaps.find(mapId) == loadedMMaps.end())
            return NULL;

        MMapData* mmap = loadedMMaps[mapId];
        if (mmap->navMeshQueries.find(instanceId) == mmap->navMeshQueries.end())
        {
        // pussywizard: different instances of the same map shouldn't access this simultaneously
        ACORE_WRITE_GUARD(ACE_RW_Thread_Mutex, GetMMapLock(mapId));
        // check again after acquiring mutex
        if (mmap->navMeshQueries.find(instanceId) == mmap->navMeshQueries.end())
        {
            // allocate mesh query
            dtNavMeshQuery* query = dtAllocNavMeshQuery();
            ASSERT(query);
            if (DT_SUCCESS != query->init(mmap->navMesh, 1024))
            {
                dtFreeNavMeshQuery(query);
                sLog->outError("MMAP:GetNavMeshQuery: Failed to initialize dtNavMeshQuery for mapId %03u instanceId %u", mapId, instanceId);
                return NULL;
            }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("MMAP:GetNavMeshQuery: created dtNavMeshQuery for mapId %03u instanceId %u", mapId, instanceId);
#endif
            mmap->navMeshQueries.insert(std::pair<uint32, dtNavMeshQuery*>(instanceId, query));
        }
        }

        return mmap->navMeshQueries[instanceId];
    }
}
