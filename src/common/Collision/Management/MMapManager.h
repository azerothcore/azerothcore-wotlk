/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MMAP_MANAGER_H
#define _MMAP_MANAGER_H

#include "Common.h"
#include "DetourAlloc.h"
#include "DetourExtended.h"
#include "DetourNavMesh.h"
#include <shared_mutex>
#include <unordered_map>
#include <vector>

//  memory management
inline void* dtCustomAlloc(size_t size, dtAllocHint /*hint*/)
{
    return (void*)new unsigned char[size];
}

inline void dtCustomFree(void* ptr)
{
    delete [] (unsigned char*)ptr;
}

//  move map related classes
namespace MMAP
{
    typedef std::unordered_map<uint32, dtTileRef> MMapTileSet;
    typedef std::unordered_map<uint32, dtNavMeshQuery*> NavMeshQuerySet;

    // dummy struct to hold map's mmap data
    struct MMapData
    {
        MMapData(dtNavMesh* mesh) : navMesh(mesh) { }

        ~MMapData()
        {
            for (NavMeshQuerySet::iterator i = navMeshQueries.begin(); i != navMeshQueries.end(); ++i)
            {
                dtFreeNavMeshQuery(i->second);
            }

            if (navMesh)
            {
                dtFreeNavMesh(navMesh);
            }
        }

        // we have to use single dtNavMeshQuery for every instance, since those are not thread safe
        NavMeshQuerySet navMeshQueries; // instanceId to query
        dtNavMesh* navMesh;
        MMapTileSet loadedTileRefs; // maps [map grid coords] to [dtTile]
    };

    typedef std::unordered_map<uint32, MMapData*> MMapDataSet;

    // singleton class
    // holds all all access to mmap loading unloading and meshes
    class MMapManager
    {
    public:
        MMapManager() : loadedTiles(0), thread_safe_environment(true) { }
        ~MMapManager();

        void InitializeThreadUnsafe(const std::vector<uint32>& mapIds);
        bool loadMap(uint32 mapId, int32 x, int32 y);
        bool unloadMap(uint32 mapId, int32 x, int32 y);
        bool unloadMap(uint32 mapId);
        bool unloadMapInstance(uint32 mapId, uint32 instanceId);

        // the returned [dtNavMeshQuery const*] is NOT threadsafe
        dtNavMeshQuery const* GetNavMeshQuery(uint32 mapId, uint32 instanceId);
        dtNavMesh const* GetNavMesh(uint32 mapId);

        uint32 getLoadedTilesCount() const { return loadedTiles; }
        uint32 getLoadedMapsCount() const { return loadedMMaps.size(); }

    private:
        bool loadMapData(uint32 mapId);
        uint32 packTileID(int32 x, int32 y);
        MMapDataSet::const_iterator GetMMapData(uint32 mapId) const;

        MMapDataSet loadedMMaps;
        uint32 loadedTiles;
        bool thread_safe_environment;
    };
}

#endif
