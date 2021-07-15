/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _VMAPFACTORY_H
#define _VMAPFACTORY_H

#include "IVMapMgr.h"

// This is the access point to the VMapMgr.
namespace VMAP
{
    class VMapMgr2;

    class VMapFactory
    {
    public:
        static VMapMgr2* createOrGetVMapMgr();
        static void clear();
    };
}
#endif
