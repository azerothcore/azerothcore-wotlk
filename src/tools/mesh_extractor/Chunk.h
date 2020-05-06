/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef CHUNK_H
#define CHUNK_H
#include "Define.h"
#include <string>
class ChunkedData;

class Chunk
{
public:
    Chunk(const char* name, uint32 length, uint32 offset, FILE* stream) : Name(name), Length(length), Offset(offset), Stream(stream) {}

    int32 FindSubChunkOffset(std::string name);
    FILE* GetStream();
    std::string Name;
    uint32 Length;
    uint32 Offset;
    FILE* Stream;
};

#endif