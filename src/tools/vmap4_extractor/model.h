/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef MODEL_H
#define MODEL_H

#include "loadlib/loadlib.h"
#include "vec3d.h"
#include "modelheaders.h"
#include <vector>

class MPQFile;
struct WMODoodadData;
namespace ADT { struct MDDF; struct MODF; }

Vec3D fixCoordSystem(Vec3D const& v);

class Model
{
private:
    void _unload()
    {
        delete[] vertices;
        delete[] indices;
        vertices = nullptr;
        indices = nullptr;
    }
    std::string filename;
public:
    ModelHeader header;
    Vec3D* vertices;
    uint16* indices;

    bool open();
    bool ConvertToVMAPModel(char const* outfilename);

    Model(std::string& filename);
    ~Model() { _unload(); }
};

namespace Doodad
{
    void Extract(ADT::MDDF const& doodadDef, char const* ModelInstName, uint32 mapID, uint32 tileX, uint32 tileY, FILE* pDirfile);

    void ExtractSet(WMODoodadData const& doodadData, ADT::MODF const& wmo, uint32 mapID, uint32 tileX, uint32 tileY, FILE* pDirfile);
}

#endif
