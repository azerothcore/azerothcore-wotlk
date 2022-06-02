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

#ifndef _MAPTREE_H
#define _MAPTREE_H

#include "BoundingIntervalHierarchy.h"
#include "Define.h"
#include <unordered_map>

namespace VMAP
{
    class ModelInstance;
    class GroupModel;
    class VMapMgr2;
    enum class ModelIgnoreFlags : uint32;
    enum class LoadResult : uint8;

    struct LocationInfo
    {
        LocationInfo():  ground_Z(-G3D::inf()) { }
        const ModelInstance* hitInstance{nullptr};
        const GroupModel* hitModel{nullptr};
        float ground_Z;
        int32 rootId = -1;
    };

    class StaticMapTree
    {
        typedef std::unordered_map<uint32, bool> loadedTileMap;
        typedef std::unordered_map<uint32, uint32> loadedSpawnMap;
    private:
        uint32 iMapID;
        bool iIsTiled;
        BIH iTree;
        ModelInstance* iTreeValues; // the tree entries
        uint32 iNTreeValues;

        // Store all the map tile idents that are loaded for that map
        // some maps are not splitted into tiles and we have to make sure, not removing the map before all tiles are removed
        // empty tiles have no tile file, hence map with bool instead of just a set (consistency check)
        loadedTileMap iLoadedTiles;
        // stores <tree_index, reference_count> to invalidate tree values, unload map, and to be able to report errors
        loadedSpawnMap iLoadedSpawns;
        std::string iBasePath;

    private:
        bool GetIntersectionTime(const G3D::Ray& pRay, float& pMaxDist, bool StopAtFirstHit, ModelIgnoreFlags ignoreFlags) const;
        //bool containsLoadedMapTile(unsigned int pTileIdent) const { return(iLoadedMapTiles.containsKey(pTileIdent)); }
    public:
        static std::string getTileFileName(uint32 mapID, uint32 tileX, uint32 tileY);
        static uint32 packTileID(uint32 tileX, uint32 tileY) { return tileX << 16 | tileY; }
        static void unpackTileID(uint32 ID, uint32& tileX, uint32& tileY) { tileX = ID >> 16; tileY = ID & 0xFF; }
        static LoadResult CanLoadMap(const std::string& basePath, uint32 mapID, uint32 tileX, uint32 tileY);

        StaticMapTree(uint32 mapID, const std::string& basePath);
        ~StaticMapTree();

        [[nodiscard]] bool isInLineOfSight(const G3D::Vector3& pos1, const G3D::Vector3& pos2, ModelIgnoreFlags ignoreFlags) const;
        bool GetObjectHitPos(const G3D::Vector3& pos1, const G3D::Vector3& pos2, G3D::Vector3& pResultHitPos, float pModifyDist) const;
        [[nodiscard]] float getHeight(const G3D::Vector3& pPos, float maxSearchDist) const;
        bool GetAreaInfo(G3D::Vector3& pos, uint32& flags, int32& adtId, int32& rootId, int32& groupId) const;
        bool GetLocationInfo(const G3D::Vector3& pos, LocationInfo& info) const;

        bool InitMap(const std::string& fname, VMapMgr2* vm);
        void UnloadMap(VMapMgr2* vm);
        bool LoadMapTile(uint32 tileX, uint32 tileY, VMapMgr2* vm);
        void UnloadMapTile(uint32 tileX, uint32 tileY, VMapMgr2* vm);
        [[nodiscard]] bool isTiled() const { return iIsTiled; }
        [[nodiscard]] uint32 numLoadedTiles() const { return iLoadedTiles.size(); }
        void GetModelInstances(ModelInstance*& models, uint32& count);
    };

    struct AreaInfo
    {
        AreaInfo():  ground_Z(-G3D::inf()) { }
        bool result{false};
        float ground_Z;
        uint32 flags{0};
        int32 adtId{0};
        int32 rootId{0};
        int32 groupId{0};
    };
}                                                           // VMAP

#endif // _MAPTREE_H
