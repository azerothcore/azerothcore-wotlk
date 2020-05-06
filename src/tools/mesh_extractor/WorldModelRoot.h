/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef WMOROOT_H
#define WMOROOT_H
#include <string>
#include <vector>

#include "ChunkedData.h"
#include "Utils.h"
#include "WorldModelGroup.h"

class WorldModelRoot
{
public:
    WorldModelRoot(std::string path);
    ~WorldModelRoot();
    std::string Path;
    ChunkedData* Data;
    WorldModelHeader Header;
    std::vector<DoodadInstance> DoodadInstances;
    std::vector<DoodadSet> DoodadSets;
    std::vector<WorldModelGroup> Groups;
private:
    void ReadGroups();
    void ReadDoodadSets();
    void ReadDoodadInstances();
    void ReadHeader();
};
#endif