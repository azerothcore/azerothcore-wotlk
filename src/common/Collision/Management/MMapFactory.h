/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MMAP_FACTORY_H
#define _MMAP_FACTORY_H

#include "DetourAlloc.h"
#include "DetourExtended.h"
#include "DetourNavMesh.h"
#include "MMapManager.h"
#include <unordered_map>

namespace MMAP
{
    enum MMAP_LOAD_RESULT
    {
        MMAP_LOAD_RESULT_ERROR,
        MMAP_LOAD_RESULT_OK,
        MMAP_LOAD_RESULT_IGNORED,
    };

    // static class
    // holds all mmap global data
    // access point to MMapManager singleton
    class MMapFactory
    {
    public:
        static MMapManager* createOrGetMMapManager();
        static void clear();
        static void InitializeDisabledMaps();
        static bool forbiddenMaps[1000];
    };
}

#endif
