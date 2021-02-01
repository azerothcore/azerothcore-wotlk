/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_COMPILERDEFS_H
#define ACORE_COMPILERDEFS_H

#define AC_PLATFORM_WINDOWS 0
#define AC_PLATFORM_UNIX    1
#define AC_PLATFORM_APPLE   2
#define AC_PLATFORM_INTEL   3

// must be first (win 64 also define _WIN32)
#if defined( _WIN64 )
#define AC_PLATFORM AC_PLATFORM_WINDOWS
#elif defined( __WIN32__ ) || defined( WIN32 ) || defined( _WIN32 )
#define AC_PLATFORM AC_PLATFORM_WINDOWS
#elif defined( __APPLE_CC__ )
#define AC_PLATFORM AC_PLATFORM_APPLE
#elif defined( __INTEL_COMPILER )
#define AC_PLATFORM AC_PLATFORM_INTEL
#else
#define AC_PLATFORM AC_PLATFORM_UNIX
#endif

#define AC_COMPILER_MICROSOFT 0
#define AC_COMPILER_GNU       1
#define AC_COMPILER_BORLAND   2
#define AC_COMPILER_INTEL     3

#ifdef _MSC_VER
#define AC_COMPILER AC_COMPILER_MICROSOFT
#elif defined( __BORLANDC__ )
#define AC_COMPILER AC_COMPILER_BORLAND
#elif defined( __INTEL_COMPILER )
#define AC_COMPILER AC_COMPILER_INTEL
#elif defined( __GNUC__ )
#define AC_COMPILER AC_COMPILER_GNU
#define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
#else
#  error "FATAL ERROR: Unknown compiler."
#endif

#endif
