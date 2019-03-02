/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef MAPCHUNK_H
#define MAPCHUNK_H
#include "Chunk.h"
#include "Utils.h"
#include "Constants.h"
#include <vector>
class ADT;

class MapChunk
{
public:
    MapChunk(ADT* _adt, Chunk* chunk);

    void GenerateTriangles();
    void GenerateVertices(FILE* stream);
    static bool HasHole(uint32 map, int x, int y);
    ADT* Adt;
    Chunk* Source;
    MapChunkHeader Header;
    std::vector<Vector3> Vertices;
    std::vector<Triangle<uint8> > Triangles;
    int32 Index;
};
#endif