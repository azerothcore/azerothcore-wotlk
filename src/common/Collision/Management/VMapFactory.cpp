/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "VMapFactory.h"
#include "VMapMgr2.h"

namespace VMAP
{
    VMapMgr2* gVMapMgr = nullptr;

    //===============================================
    // just return the instance
    VMapMgr2* VMapFactory::createOrGetVMapMgr()
    {
        if (!gVMapMgr)
        {
            gVMapMgr = new VMapMgr2();
        }

        return gVMapMgr;
    }

    //===============================================
    // delete all internal data structures
    void VMapFactory::clear()
    {
        delete gVMapMgr;
        gVMapMgr = nullptr;
    }
}
