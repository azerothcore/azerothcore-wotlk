/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _INTERMEDIATE_VALUES_H
#define _INTERMEDIATE_VALUES_H

#include "PathCommon.h"
#include "TerrainBuilder.h"
#include "Recast.h"
#include "DetourNavMesh.h"

namespace MMAP
{
    // this class gathers all debug info holding and output
    struct IntermediateValues
    {
        rcHeightfield* heightfield;
        rcCompactHeightfield* compactHeightfield;
        rcContourSet* contours;
        rcPolyMesh* polyMesh;
        rcPolyMeshDetail* polyMeshDetail;

        IntermediateValues() :  heightfield(nullptr), compactHeightfield(nullptr),
                                contours(nullptr), polyMesh(nullptr), polyMeshDetail(nullptr) {}
        ~IntermediateValues();

        void writeIV(uint32 mapID, uint32 tileX, uint32 tileY);

        void debugWrite(FILE* file, const rcHeightfield* mesh);
        void debugWrite(FILE* file, const rcCompactHeightfield* chf);
        void debugWrite(FILE* file, const rcContourSet* cs);
        void debugWrite(FILE* file, const rcPolyMesh* mesh);
        void debugWrite(FILE* file, const rcPolyMeshDetail* mesh);

        void generateObjFile(uint32 mapID, uint32 tileX, uint32 tileY, MeshData &meshData);
    };
}
#endif
