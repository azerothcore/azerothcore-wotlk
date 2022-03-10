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

#ifndef _MAP_BUILDER_H
#define _MAP_BUILDER_H

#include <atomic>
#include <list>
#include <map>
#include <set>
#include <thread>
#include <vector>

#include "IntermediateValues.h"
#include "Optional.h"
#include "TerrainBuilder.h"

#include "DetourNavMesh.h"
#include "PCQueue.h"
#include "Recast.h"

using namespace VMAP;

namespace MMAP
{
    struct MapTiles
    {
        MapTiles() : m_mapId(uint32(-1)) {}

        MapTiles(uint32 id, std::set<uint32>* tiles) : m_mapId(id), m_tiles(tiles) {}
        ~MapTiles() = default;

        uint32 m_mapId;
        std::set<uint32>* m_tiles{nullptr};

        bool operator==(uint32 id)
        {
            return m_mapId == id;
        }
    };

    typedef std::list<MapTiles> TileList;

    struct Tile
    {
        Tile()  {}
        ~Tile()
        {
            rcFreeCompactHeightfield(chf);
            rcFreeContourSet(cset);
            rcFreeHeightField(solid);
            rcFreePolyMesh(pmesh);
            rcFreePolyMeshDetail(dmesh);
        }
        rcCompactHeightfield* chf{nullptr};
        rcHeightfield* solid{nullptr};
        rcContourSet* cset{nullptr};
        rcPolyMesh* pmesh{nullptr};
        rcPolyMeshDetail* dmesh{nullptr};
    };

    class MapBuilder
    {
    public:
        MapBuilder(Optional<float> maxWalkableAngle,
                   Optional<float> maxWalkableAngleNotSteep,
                   bool skipLiquid          = false,
                   bool skipContinents      = false,
                   bool skipJunkMaps        = true,
                   bool skipBattlegrounds   = false,
                   bool debugOutput         = false,
                   bool bigBaseUnit         = false,
                   const char* offMeshFilePath = nullptr);

        ~MapBuilder();

        // builds all mmap tiles for the specified map id (ignores skip settings)
        void buildMap(uint32 mapID);
        void buildMeshFromFile(char* name);

        // builds an mmap tile for the specified map and its mesh
        void buildSingleTile(uint32 mapID, uint32 tileX, uint32 tileY);

        // builds list of maps, then builds all of mmap tiles (based on the skip settings)
        void buildAllMaps(unsigned int threads);

        void WorkerThread();

    private:
        // detect maps and tiles
        void discoverTiles();
        std::set<uint32>* getTileList(uint32 mapID);

        void buildNavMesh(uint32 mapID, dtNavMesh*& navMesh);

        void buildTile(uint32 mapID, uint32 tileX, uint32 tileY, dtNavMesh* navMesh);

        // move map building
        void buildMoveMapTile(uint32 mapID,
                              uint32 tileX,
                              uint32 tileY,
                              MeshData& meshData,
                              float bmin[3],
                              float bmax[3],
                              dtNavMesh* navMesh);

        void getTileBounds(uint32 tileX, uint32 tileY,
                           float* verts, int vertCount,
                           float* bmin, float* bmax);
        void getGridBounds(uint32 mapID, uint32& minX, uint32& minY, uint32& maxX, uint32& maxY) const;

        bool shouldSkipMap(uint32 mapID);
        bool isTransportMap(uint32 mapID);
        bool shouldSkipTile(uint32 mapID, uint32 tileX, uint32 tileY);
        // percentageDone - method to calculate percentage
        uint32 percentageDone(uint32 totalTiles, uint32 totalTilesDone);

        TerrainBuilder* m_terrainBuilder{nullptr};
        TileList m_tiles;

        bool m_debugOutput;

        const char* m_offMeshFilePath;
        bool m_skipContinents;
        bool m_skipJunkMaps;
        bool m_skipBattlegrounds;

        Optional<float> m_maxWalkableAngle;
        Optional<float> m_maxWalkableAngleNotSteep;
        bool m_bigBaseUnit;
        // percentageDone - variables to calculate percentage
        std::atomic<uint32> m_totalTiles;
        std::atomic<uint32> m_totalTilesBuilt;

        // build performance - not really used for now
        rcContext* m_rcContext{nullptr};

        std::vector<std::thread> _workerThreads;
        ProducerConsumerQueue<uint32> _queue;
        std::atomic<bool> _cancelationToken;
    };
}

#endif
