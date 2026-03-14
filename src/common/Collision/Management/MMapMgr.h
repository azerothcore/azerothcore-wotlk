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

#ifndef _MMAP_MANAGER_H
#define _MMAP_MANAGER_H

#include "Common.h"
#include "DetourAlloc.h"
#include "DetourExtended.h"
#include "DetourNavMesh.h"
#include <unordered_map>
#include <vector>

//  memory management
inline void* dtCustomAlloc(std::size_t size, dtAllocHint /*hint*/)
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
    static char const* const MAP_FILE_NAME_FORMAT = "{}/mmaps/{:03}.mmap";
    static char const* const TILE_FILE_NAME_FORMAT = "{}/mmaps/{:03}{:02}{:02}.mmtile";

    typedef std::unordered_map<uint32, dtTileRef> MMapTileSet;
    typedef std::unordered_map<uint32, dtNavMeshQuery*> NavMeshQuerySet;

    // dummy struct to hold map's mmap data
    struct MMapData
    {
        MMapData(dtNavMesh* mesh) : navMesh(mesh) { }

        ~MMapData()
        {
            for (auto& navMeshQuerie : navMeshQueries)
            {
                dtFreeNavMeshQuery(navMeshQuerie.second);
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
    class MMapMgr
    {
    public:
        MMapMgr()  = default;
        ~MMapMgr();

        void InitializeThreadUnsafe(const std::vector<uint32>& mapIds);
        bool loadMap(uint32 mapId, int32 x, int32 y);
        bool unloadMap(uint32 mapId, int32 x, int32 y);
        bool unloadMap(uint32 mapId);
        bool unloadMapInstance(uint32 mapId, uint32 instanceId);

        // the returned [dtNavMeshQuery const*] is NOT threadsafe
        dtNavMeshQuery const* GetNavMeshQuery(uint32 mapId, uint32 instanceId);
        dtNavMesh const* GetNavMesh(uint32 mapId);

        [[nodiscard]] uint32 getLoadedTilesCount() const { return loadedTiles; }
        [[nodiscard]] uint32 getLoadedMapsCount() const { return loadedMMaps.size(); }

    private:
        bool loadMapData(uint32 mapId);
        uint32 packTileID(int32 x, int32 y);
        [[nodiscard]] MMapDataSet::const_iterator GetMMapData(uint32 mapId) const;

        MMapDataSet loadedMMaps;
        uint32 loadedTiles{0};
        bool thread_safe_environment{true};
    };
}

#endif
