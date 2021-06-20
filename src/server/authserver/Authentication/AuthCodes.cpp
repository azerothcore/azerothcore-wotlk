/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AuthCodes.h"
#include "RealmList.h"

namespace AuthHelper
{
    constexpr static uint32 MAX_PRE_BC_CLIENT_BUILD = 6141;

    bool IsPreBCAcceptedClientBuild(uint32 build)
    {
        return build <= MAX_PRE_BC_CLIENT_BUILD && sRealmList->GetBuildInfo(build);
    }

    bool IsPostBCAcceptedClientBuild(uint32 build)
    {
        return build > MAX_PRE_BC_CLIENT_BUILD && sRealmList->GetBuildInfo(build);
    }

    bool IsAcceptedClientBuild(uint32 build)
    {
        return sRealmList->GetBuildInfo(build) != nullptr;
    }
};
