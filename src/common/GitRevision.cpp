/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
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

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#  ifdef _WIN64
#    define AZEROTH_PLATFORM_STR "Win64"
#  else
#    define AZEROTH_PLATFORM_STR "Win32"
#  endif
#else // AC_PLATFORM
#  define AZEROTH_PLATFORM_STR "Unix"
#endif

char const* GitRevision::GetFullVersion()
{
    return VER_COMPANYNAME_STR " rev. " VER_PRODUCTVERSION_STR " (" AZEROTH_PLATFORM_STR ", " _BUILD_DIRECTIVE ")";
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
