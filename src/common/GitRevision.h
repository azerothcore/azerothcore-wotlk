/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
* Copyright (C) 2008-2018 TrinityCore <http://www.trinitycore.org/>
*/

#ifndef __GITREVISION_H__
#define __GITREVISION_H__

#include "Define.h"

namespace GitRevision
{
    char const* GetHash();
    char const* GetDate();
    char const* GetBranch();
    char const* GetFullVersion();
    char const* GetCompanyNameStr();
    char const* GetLegalCopyrightStr();
    char const* GetFileVersionStr();
    char const* GetProductVersionStr();
}

#endif
