/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <vector>
#include "MapTree.h"
#include "VMapManager2.h"
#include "WorldModel.h"
#include "ModelInstance.h"

#include "Database/DatabaseEnv.h"
LoginDatabaseWorkerPool LoginDatabase;
WorldDatabaseWorkerPool WorldDatabase;

namespace VMAP
{
    // Need direct access to encapsulated VMAP data, so we add functions for MMAP generator
    // maybe add MapBuilder as friend to all of the below classes would be better?

    // declared in src/common/vmap/MapTree.h
    void StaticMapTree::getModelInstances(ModelInstance* &models, uint32 &count)
    {
        models = iTreeValues;
        count = iNTreeValues;
    }

    // declared in src/common/vmap/VMapManager2.h
    void VMapManager2::getInstanceMapTree(InstanceTreeMap &instanceMapTree)
    {
        instanceMapTree = iInstanceMapTrees;
    }

    // declared in src/common/vmap/WorldModel.h
    void WorldModel::getGroupModels(std::vector<GroupModel> &groupModels)
    {
        groupModels = this->groupModels;
    }

    // declared in src/common/vmap/WorldModel.h
    void GroupModel::getMeshData(std::vector<G3D::Vector3> &vertices, std::vector<MeshTriangle> &triangles, WmoLiquid* &liquid)
    {
        vertices = this->vertices;
        triangles = this->triangles;
        liquid = iLiquid;
    }

    // declared in src/common/vmap/ModelInstance.h
    WorldModel* ModelInstance::getWorldModel()
    {
        return iModel;
    }

    // declared in src/common/vmap/WorldModel.h
    void WmoLiquid::getPosInfo(uint32 &tilesX, uint32 &tilesY, G3D::Vector3 &corner) const
    {
        tilesX = iTilesX;
        tilesY = iTilesY;
        corner = iCorner;
    }
}
