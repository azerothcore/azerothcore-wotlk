/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TILE_BUILD_H
#define TILE_BUILD_H
#include <string>
#include "Recast.h"

#include "Geometry.h"
#include "WorldModelRoot.h"

class ContinentBuilder;
class WDT;

class TileBuilder
{
public:
    TileBuilder(ContinentBuilder* _cBuilder, std::string world, int x, int y, uint32 mapId);
    ~TileBuilder();

    void CalculateTileBounds(float*& bmin, float*& bmax, dtNavMeshParams& navMeshParams);
    uint8* BuildTiled(dtNavMeshParams& navMeshParams);
    uint8* BuildInstance(dtNavMeshParams& navMeshParams);
    void AddGeometry(WorldModelRoot* root, const WorldModelDefinition& def);
    void OutputDebugVertices();
    std::string World;
    int X;
    int Y;
    int MapId;
    rcConfig Config;
    rcConfig InstanceConfig;
    rcContext* Context;
    Geometry* _Geometry;
    uint32 DataSize;
    ContinentBuilder* cBuilder;
};
#endif