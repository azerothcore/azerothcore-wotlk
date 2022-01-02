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
inline auto dtCustomAlloc(size_t size, dtAllocHint /*hint*/) -> void*
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
            for (auto & navMeshQuerie : navMeshQueries)
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
        auto loadMap(uint32 mapId, int32 x, int32 y) -> bool;
        auto unloadMap(uint32 mapId, int32 x, int32 y) -> bool;
        auto unloadMap(uint32 mapId) -> bool;
        auto unloadMapInstance(uint32 mapId, uint32 instanceId) -> bool;

        // the returned [dtNavMeshQuery const*] is NOT threadsafe
        auto GetNavMeshQuery(uint32 mapId, uint32 instanceId) -> dtNavMeshQuery const*;
        auto GetNavMesh(uint32 mapId) -> dtNavMesh const*;

        [[nodiscard]] auto getLoadedTilesCount() const -> uint32 { return loadedTiles; }
        [[nodiscard]] auto getLoadedMapsCount() const -> uint32 { return loadedMMaps.size(); }

    private:
        auto loadMapData(uint32 mapId) -> bool;
        auto packTileID(int32 x, int32 y) -> uint32;
        [[nodiscard]] auto GetMMapData(uint32 mapId) const -> MMapDataSet::const_iterator;

        MMapDataSet loadedMMaps;
        uint32 loadedTiles{0};
        bool thread_safe_environment{true};
    };
}

#endif
