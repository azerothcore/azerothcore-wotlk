/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
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
    char const* GetCMakeVersion();
    char const* GetHostOSVersion();
    char const* GetFullVersion();
    char const* GetCompanyNameStr();
    char const* GetLegalCopyrightStr();
    char const* GetFileVersionStr();
    char const* GetProductVersionStr();
}

#endif
