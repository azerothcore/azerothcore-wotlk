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
#include <memory>

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
    enum MMAP_LOAD_RESULT
    {
        MMAP_LOAD_RESULT_ERROR,
        MMAP_LOAD_RESULT_OK,
        MMAP_LOAD_RESULT_IGNORED,
    };

    static char const* const MAP_FILE_NAME_FORMAT = "{}/mmaps/{:03}.mmap";
    static char const* const TILE_FILE_NAME_FORMAT = "{}/mmaps/{:03}{:02}{:02}.mmtile";

    struct NavMeshDeleter
    {
        void operator()(dtNavMesh* navMesh) noexcept { dtFreeNavMesh(navMesh); }
    };

    struct NavMeshQueryDeleter
    {
        void operator()(dtNavMeshQuery* query) noexcept { dtFreeNavMeshQuery(query); }
    };

    using ManagedNavMeshQuery = std::unique_ptr<dtNavMeshQuery, NavMeshQueryDeleter>;

    class MMapMgr
    {
    public:
        MMapMgr() = default;
        ~MMapMgr() = default;

        static std::shared_ptr<dtNavMesh> LoadNavMesh(uint32 mapId);
        static bool LoadTile(dtNavMesh* navMesh, uint32 mapId, int32 x, int32 y);
        static ManagedNavMeshQuery CreateNavMeshQuery(dtNavMesh* navMesh);

    private:
        static uint32 packTileID(int32 x, int32 y);
    };
}

#endif
