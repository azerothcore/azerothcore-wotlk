/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _TILEASSEMBLER_H_
#define _TILEASSEMBLER_H_

#include <G3D/Vector3.h>
#include <G3D/Matrix3.h>
#include <map>
#include <set>

#include "ModelInstance.h"
#include "WorldModel.h"

namespace VMAP
{
    /**
    This Class is used to convert raw vector data into balanced BSP-Trees.
    To start the conversion call convertWorld().
    */
    //===============================================

    class ModelPosition
    {
    private:
        G3D::Matrix3 iRotation;
    public:
        ModelPosition() { }
        G3D::Vector3 iPos;
        G3D::Vector3 iDir;
        float iScale{0.0f};
        void init()
        {
            iRotation = G3D::Matrix3::fromEulerAnglesZYX(G3D::pif() * iDir.y / 180.f, G3D::pif() * iDir.x / 180.f, G3D::pif() * iDir.z / 180.f);
        }
        [[nodiscard]] G3D::Vector3 transform(const G3D::Vector3& pIn) const;
        void moveToBasePos(const G3D::Vector3& pBasePos) { iPos -= pBasePos; }
    };

    typedef std::map<uint32, ModelSpawn> UniqueEntryMap;
    typedef std::multimap<uint32, uint32> TileMap;

    struct MapSpawns
    {
        UniqueEntryMap UniqueEntries;
        TileMap TileEntries;
    };

    typedef std::map<uint32, MapSpawns*> MapData;
    //===============================================

    struct GroupModel_Raw
    {
        uint32 mogpflags{0};
        uint32 GroupWMOID{0};

        G3D::AABox bounds;
        uint32 liquidflags{0};
        std::vector<MeshTriangle> triangles;
        std::vector<G3D::Vector3> vertexArray;
        class WmoLiquid* liquid;

        GroupModel_Raw() : liquid(nullptr) { }

        ~GroupModel_Raw();

        bool Read(FILE* f);
    };

    struct WorldModel_Raw
    {
        uint32 RootWMOID;
        std::vector<GroupModel_Raw> groupsArray;

        bool Read(const char* path);
    };

    class TileAssembler
    {
        private:
            std::string iDestDir;
            std::string iSrcDir;
            G3D::Table<std::string, unsigned int > iUniqueNameIds;
            MapData mapData;
            std::set<std::string> spawnedModelFiles;

        public:
            TileAssembler(const std::string& pSrcDirName, const std::string& pDestDirName);
            virtual ~TileAssembler();

            bool convertWorld2();
            bool readMapSpawns();
            bool calculateTransformedBound(ModelSpawn &spawn);
            void exportGameobjectModels();

            bool convertRawFile(const std::string& pModelFilename);
    };

}                                                           // VMAP
#endif                                                      /*_TILEASSEMBLER_H_*/
