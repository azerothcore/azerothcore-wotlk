/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef WDT_H
#define WDT_H
#include <string>
#include <vector>

#include "ChunkedData.h"
#include "WorldModelHandler.h"
#include "WorldModelRoot.h"
#include "Utils.h"

class WDT
{
public:
    WDT(std::string file);

    ChunkedData* Data;
    std::vector<TilePos> TileTable;
    bool IsGlobalModel;
    bool IsValid;
    std::string ModelFile;
    WorldModelDefinition ModelDefinition;
    WorldModelRoot* Model;
    bool HasTile(int x, int y);
private:
    void ReadGlobalModel();
    void ReadTileTable();
};

#endif