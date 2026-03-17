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

#ifndef MAP_COLLISION_DATA_H
#define MAP_COLLISION_DATA_H

#include "DynamicTree.h"
#include "MapTree.h"
#include "MMapMgr.h"
#include "IVMapMgr.h"

class Map;

namespace VMAP
{
    enum class ModelIgnoreFlags : uint32;
}

// Simple wrappers for vmap static & dynamic trees to enable clear separation of use for increased readability
class StaticVMapCollisionData
{
    friend class MapCollisionData;

public:
    StaticVMapCollisionData(uint32 mapId) : _mapId(mapId) {}

    bool isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, VMAP::ModelIgnoreFlags ignoreFlags) const;
    bool GetObjectHitPos(float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist) const;
    float getHeight(float x, float y, float z, float maxSearchDist) const;
    bool GetAreaAndLiquidData(float x, float y, float z, Optional<uint8> reqLiquidType, VMAP::AreaAndLiquidData& data) const;
protected:
    // _staticTree is a shared_ptr as it will point to a parent maps static tree (if exists) to save on memory
    std::shared_ptr<VMAP::StaticMapTree> _staticTree;
    uint32 _mapId;
};

class DynamicVMapCollisionData : public DynamicMapTree
{
public:
    bool GetObjectHitPos(uint32 phasemask, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist) const;
};

class MMapData
{
    friend class MapCollisionData;

public:
    dtNavMesh const* GetNavMesh() const { return _navMesh.get(); }
    dtNavMeshQuery const* GetNavMeshQuery();

protected:
    // _navMesh is a shared_ptr as it will point to a parent maps nav mesh (if exists) to save on memory
    std::shared_ptr<dtNavMesh> _navMesh;
    // navMeshQuery is not thread safe and needs its own instance per map
    MMAP::ManagedNavMeshQuery _navMeshQuery;
};

// Map collision data holders (dynamic&static vmap, mmaps)
class MapCollisionData
{
public:
    MapCollisionData(Map const& map, Map const* parentMap);
    ~MapCollisionData() = default;

    int LoadVMapTile(uint32 tileX, uint32 tileY);
    int LoadMMapTile(uint32 tileX, uint32 tileY);

    DynamicVMapCollisionData& GetDynamicTree() { return _dynamicVMapData; }
    DynamicVMapCollisionData const& GetDynamicTree() const { return _dynamicVMapData; }
    StaticVMapCollisionData& GetStaticTree() { return _staticVMapData; }
    StaticVMapCollisionData const& GetStaticTree() const { return _staticVMapData; }
    MMapData& GetMMapData() { return _mmapData; }
    MMapData const& GetMMapData() const { return _mmapData; }

    std::shared_ptr<VMAP::StaticMapTree> const GetStaticTreeSharedPtr() const { return _staticVMapData._staticTree; }
    std::shared_ptr<dtNavMesh> const GetMMapNavMeshSharedPtr() const { return _mmapData._navMesh; }

private:
    Map const& _map;

    DynamicVMapCollisionData _dynamicVMapData;
    StaticVMapCollisionData _staticVMapData;
    MMapData _mmapData;
};

#endif
