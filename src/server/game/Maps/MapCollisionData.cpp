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

#include "DBCStores.h"
#include "DetourNavMeshQuery.h"
#include "DisableMgr.h"
#include "MapCollisionData.h"
#include "MapTree.h"
#include "ModelInstance.h"
#include "VMapFactory.h"
#include "VMapMgr2.h"
#include "World.h"
#include "WorldModel.h"

#include <G3D/Vector3.h>

MapCollisionData::MapCollisionData(Map const& map, Map const* parentMap) :
    _map(map), _staticVMapData(map.GetId())
{
    if (parentMap)
    {
        // If we have a parent map, point our static tree and mmap nav mesh to the parent maps
        _staticVMapData._staticTree = parentMap->GetMapCollisionData().GetStaticTreeSharedPtr();
        _mmapData._navMesh = parentMap->GetMapCollisionData().GetMMapNavMeshSharedPtr();
    }
    else
    {
        // If we are a base map create a new static tree and mmap nav mesh
        std::string const mapFileName = VMAP::VMapMgr2::getMapFileName(map.GetId());
        std::shared_ptr<VMAP::StaticMapTree> newTree = std::make_shared<VMAP::StaticMapTree>(map.GetId(), (sWorld->GetDataPath() + "vmaps"));
        if (newTree->InitMap(mapFileName))
            _staticVMapData._staticTree = newTree;

        _mmapData._navMesh = MMAP::MMapMgr::LoadNavMesh(map.GetId());
    }
}

int MapCollisionData::LoadVMapTile(uint32 tileX, uint32 tileY)
{
    if (!VMAP::VMapFactory::createOrGetVMapMgr()->isMapLoadingEnabled() || !_staticVMapData._staticTree)
        return VMAP::VMAP_LOAD_RESULT_IGNORED;

    if (!_staticVMapData._staticTree->LoadMapTile(tileX, tileY))
        return VMAP::VMAP_LOAD_RESULT_ERROR;

    return VMAP::VMAP_LOAD_RESULT_OK;
}

int MapCollisionData::LoadMMapTile(uint32 tileX, uint32 tileY)
{
    if (!DisableMgr::IsPathfindingEnabled(&_map) || !_mmapData._navMesh)
        return MMAP::MMAP_LOAD_RESULT_IGNORED;

    return MMAP::MMapMgr::LoadTile(_mmapData._navMesh.get(), _map.GetId(), tileX, tileY);
}

bool StaticVMapCollisionData::isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, VMAP::ModelIgnoreFlags ignoreFlags) const
{
#if defined(ENABLE_VMAP_CHECKS)
    if (!sWorld->getBoolConfig(CONFIG_VMAP_ENABLE_LOS) || DisableMgr::IsVMAPDisabledFor(_mapId, VMAP::VMAP_DISABLE_LOS))
        return true;
#endif

    if (!_staticTree)
        return true;

    G3D::Vector3 const pos1 = VMAP::VMapMgr2::convertPositionToInternalRep(x1, y1, z1);
    G3D::Vector3 const pos2 = VMAP::VMapMgr2::convertPositionToInternalRep(x2, y2, z2);
    if (pos1 != pos2)
        return _staticTree->isInLineOfSight(pos1, pos2, ignoreFlags);

    return true;
}

bool StaticVMapCollisionData::GetObjectHitPos(float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist) const
{
#if defined(ENABLE_VMAP_CHECKS)
    if (sWorld->getBoolConfig(CONFIG_VMAP_ENABLE_LOS) && !DisableMgr::IsVMAPDisabledFor(_mapId, VMAP::VMAP_DISABLE_LOS))
#endif
    {
        if (_staticTree)
        {
            G3D::Vector3 const pos1 = VMAP::VMapMgr2::convertPositionToInternalRep(x1, y1, z1);
            G3D::Vector3 const pos2 = VMAP::VMapMgr2::convertPositionToInternalRep(x2, y2, z2);
            G3D::Vector3 resultPos;
            bool result = _staticTree->GetObjectHitPos(pos1, pos2, resultPos, modifyDist);
            resultPos = VMAP::VMapMgr2::convertPositionToInternalRep(resultPos.x, resultPos.y, resultPos.z);
            rx = resultPos.x;
            ry = resultPos.y;
            rz = resultPos.z;
            return result;
        }
    }

    rx = x2;
    ry = y2;
    rz = z2;

    return false;
}

float StaticVMapCollisionData::getHeight(float x, float y, float z, float maxSearchDist) const
{
#if defined(ENABLE_VMAP_CHECKS)
    if (sWorld->getBoolConfig(CONFIG_VMAP_ENABLE_HEIGHT) && !DisableMgr::IsVMAPDisabledFor(_mapId, VMAP::VMAP_DISABLE_HEIGHT))
#endif
    {
        if (_staticTree)
        {
            G3D::Vector3 const pos = VMAP::VMapMgr2::convertPositionToInternalRep(x, y, z);
            float height = _staticTree->getHeight(pos, maxSearchDist);
            if (height >= G3D::finf())
                return VMAP_INVALID_HEIGHT_VALUE; // No height

            return height;
        }
    }

    return VMAP_INVALID_HEIGHT_VALUE;
}

bool StaticVMapCollisionData::GetAreaAndLiquidData(float x, float y, float z, Optional<uint8> reqLiquidType, VMAP::AreaAndLiquidData& data) const
{
    if (_staticTree)
    {
        VMAP::LocationInfo info;
        G3D::Vector3 const pos = VMAP::VMapMgr2::convertPositionToInternalRep(x, y, z);
        if (_staticTree->GetLocationInfo(pos, info))
        {
            data.floorZ = info.ground_Z;
            if (!DisableMgr::IsVMAPDisabledFor(_mapId, VMAP::VMAP_DISABLE_LIQUIDSTATUS))
            {
                uint32 liquidType = info.hitModel->GetLiquidType(); // entry from LiquidType.dbc
                float liquidLevel;
                if (!reqLiquidType || (GetLiquidFlags(liquidType) & *reqLiquidType))
                    if (info.hitInstance->GetLiquidLevel(pos, info, liquidLevel))
                        data.liquidInfo.emplace(liquidType, liquidLevel);
            }

            if (!DisableMgr::IsVMAPDisabledFor(_mapId, VMAP::VMAP_DISABLE_AREAFLAG))
                data.areaInfo.emplace(info.hitModel->GetWmoID(), info.hitInstance->adtId, info.rootId, info.hitModel->GetMogpFlags(), info.hitInstance->ID);
            return true;
        }
    }

    return false;
}

bool DynamicVMapCollisionData::GetObjectHitPos(uint32 phasemask, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float& ry, float& rz, float modifyDist) const
{
    G3D::Vector3 startPos(x1, y1, z1);
    G3D::Vector3 dstPos(x2, y2, z2);

    G3D::Vector3 resultPos;
    bool result = DynamicMapTree::GetObjectHitPos(phasemask, startPos, dstPos, resultPos, modifyDist);

    rx = resultPos.x;
    ry = resultPos.y;
    rz = resultPos.z;
    return result;
}

dtNavMeshQuery const* MMapData::GetNavMeshQuery()
{
    if (_navMesh && !_navMeshQuery)
        _navMeshQuery = MMAP::MMapMgr::CreateNavMeshQuery(_navMesh.get());

    return _navMeshQuery.get();
}
