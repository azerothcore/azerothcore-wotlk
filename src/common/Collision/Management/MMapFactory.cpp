/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MMapFactory.h"
#include <set>

namespace MMAP
{
    // ######################## MMapFactory ########################
    // our global singleton copy
    MMapManager* g_MMapManager = nullptr;
    bool MMapFactory::forbiddenMaps[1000] = {0};

    MMapManager* MMapFactory::createOrGetMMapManager()
    {
        if (g_MMapManager == nullptr)
            g_MMapManager = new MMapManager();

        return g_MMapManager;
    }

    void MMapFactory::InitializeDisabledMaps()
    {
        memset(&forbiddenMaps, 0, sizeof(forbiddenMaps));
        int32 f[] = {616 /*EoE*/, 649 /*ToC25*/, 650 /*ToC5*/, -1};
        uint32 i = 0;
        while (f[i] >= 0)
            forbiddenMaps[f[i++]] = true;
    }

    void MMapFactory::clear()
    {
        if (g_MMapManager)
        {
            delete g_MMapManager;
            g_MMapManager = nullptr;
        }
    }
}
