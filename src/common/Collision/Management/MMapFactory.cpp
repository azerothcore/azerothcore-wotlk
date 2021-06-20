/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MMapFactory.h"
#include "World.h"
#include <set>

namespace MMAP
{
    // ######################## MMapFactory ########################
    // our global singleton copy
    MMapManager *g_MMapManager = NULL;
    bool MMapFactory::forbiddenMaps[1000] = {0};

    MMapManager* MMapFactory::createOrGetMMapManager()
    {
        if (g_MMapManager == NULL)
            g_MMapManager = new MMapManager();

        return g_MMapManager;
    }

    bool MMapFactory::IsPathfindingEnabled(const Map* map)
    {
        if (!map) return false;
        return !forbiddenMaps[map->GetId()] && (sWorld->getBoolConfig(CONFIG_ENABLE_MMAPS) ? true : map->IsBattlegroundOrArena());
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
            g_MMapManager = NULL;
        }
    }
}