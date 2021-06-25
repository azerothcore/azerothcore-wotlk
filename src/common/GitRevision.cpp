/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
*/

#include "GitRevision.h"
#include "revision.h"

char const* GitRevision::GetHash()
{
    return _HASH;
}

char const* GitRevision::GetDate()
{
    return _DATE;
}

char const* GitRevision::GetBranch()
{
    return _BRANCH;
}

char const* GitRevision::GetCMakeVersion()
{
    return _CMAKE_VERSION;
}

char const* GitRevision::GetHostOSVersion()
{
    return _CMAKE_HOST_SYSTEM;
}

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#  ifdef _WIN64
#    define AZEROTH_PLATFORM_STR "Win64"
#  else
#    define AZEROTH_PLATFORM_STR "Win32"
#  endif
#else // AC_PLATFORM
#  define AZEROTH_PLATFORM_STR "Unix"
#endif

#ifndef ACORE_API_USE_DYNAMIC_LINKING
#  define ACORE_LINKAGE_TYPE_STR "Static"
#else
#  define ACORE_LINKAGE_TYPE_STR "Dynamic"
#endif

char const* GitRevision::GetFullVersion()
{
    return VER_COMPANYNAME_STR " rev. " VER_PRODUCTVERSION_STR " (" AZEROTH_PLATFORM_STR ", " _BUILD_DIRECTIVE ", " ACORE_LINKAGE_TYPE_STR ")";
}

char const* GitRevision::GetCompanyNameStr()
{
    return VER_COMPANYNAME_STR;
}

char const* GitRevision::GetLegalCopyrightStr()
{
    return VER_LEGALCOPYRIGHT_STR;
}

char const* GitRevision::GetFileVersionStr()
{
    return VER_FILEVERSION_STR;
}

char const* GitRevision::GetProductVersionStr()
{
    return VER_PRODUCTVERSION_STR;
}
