/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ADT_H
#define ADT_H
#include "ChunkedData.h"
#include "MapChunk.h"

class DoodadHandler;
class WorldModelHandler;
class LiquidHandler;

class ADT
{
public:
    ADT(std::string file, int x, int y);
    ~ADT();

    void Read();

    ChunkedData* ObjectData;
    ChunkedData* Data;
    std::vector<MapChunk*> MapChunks;
    MHDR Header;
    // Can we dispose of this?
    bool HasObjectData;

    DoodadHandler* _DoodadHandler;
    WorldModelHandler* _WorldModelHandler;
    LiquidHandler* _LiquidHandler;

    int X;
    int Y;
};
#endif