/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
* Copyright (C) 2008-2018 TrinityCore <http://www.trinitycore.org/>
*/

#ifndef __GITREVISION_H__
#define __GITREVISION_H__

#include "Define.h"

namespace GitRevision
{
    AC_COMMON_API char const* GetHash();
    AC_COMMON_API char const* GetDate();
    AC_COMMON_API char const* GetBranch();
    AC_COMMON_API char const* GetCMakeCommand();
    AC_COMMON_API char const* GetCMakeVersion();
    AC_COMMON_API char const* GetHostOSVersion();
    AC_COMMON_API char const* GetBuildDirectory();
    AC_COMMON_API char const* GetSourceDirectory();
    AC_COMMON_API char const* GetMySQLExecutable();
    AC_COMMON_API char const* GetFullVersion();
    AC_COMMON_API char const* GetCompanyNameStr();
    AC_COMMON_API char const* GetLegalCopyrightStr();
    AC_COMMON_API char const* GetFileVersionStr();
    AC_COMMON_API char const* GetProductVersionStr();
}

#endif
