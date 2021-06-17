/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_DEFINE_H
#define ACORE_DEFINE_H

#include "CompilerDefs.h"
#include <cstddef>
#include <cinttypes>
#include <climits>

#define ACORE_LITTLEENDIAN 0
#define ACORE_BIGENDIAN    1

#if !defined(ACORE_ENDIAN)
#  if defined (ACE_BIG_ENDIAN)
#    define ACORE_ENDIAN ACORE_BIGENDIAN
#  else //ACE_BYTE_ORDER != ACE_BIG_ENDIAN
#    define ACORE_ENDIAN ACORE_LITTLEENDIAN
#  endif //ACE_BYTE_ORDER
#endif //ACORE_ENDIAN

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#  define ACORE_PATH_MAX MAX_PATH
#  define _USE_MATH_DEFINES
#  ifndef DECLSPEC_NORETURN
#    define DECLSPEC_NORETURN __declspec(noreturn)
#  endif //DECLSPEC_NORETURN
#  ifndef DECLSPEC_DEPRECATED
#    define DECLSPEC_DEPRECATED __declspec(deprecated)
#  endif //DECLSPEC_DEPRECATED
#else //AC_PLATFORM != AC_PLATFORM_WINDOWS
#  define ACORE_PATH_MAX PATH_MAX
#  define DECLSPEC_NORETURN
#  define DECLSPEC_DEPRECATED
#endif //AC_PLATFORM

#if !defined(COREDEBUG)
#  define ACORE_INLINE inline
#else //COREDEBUG
#  if !defined(ACORE_DEBUG)
#    define ACORE_DEBUG
#  endif //ACORE_DEBUG
#  define ACORE_INLINE
#endif //!COREDEBUG

#if AC_COMPILER == AC_COMPILER_GNU
#  define ATTR_NORETURN __attribute__((noreturn))
#  define ATTR_PRINTF(F, V) __attribute__ ((format (printf, F, V)))
#  define ATTR_DEPRECATED __attribute__((deprecated))
#else //AC_COMPILER != AC_COMPILER_GNU
#  define ATTR_NORETURN
#  define ATTR_PRINTF(F, V)
#  define ATTR_DEPRECATED
#endif //AC_COMPILER == AC_COMPILER_GNU

#ifdef ACORE_API_USE_DYNAMIC_LINKING
#  if AC_COMPILER == AC_COMPILER_MICROSOFT
#    define AC_API_EXPORT __declspec(dllexport)
#    define AC_API_IMPORT __declspec(dllimport)
#  elif AC_COMPILER == AC_COMPILER_GNU
#    define AC_API_EXPORT __attribute__((visibility("default")))
#    define AC_API_IMPORT
#  else
#    error compiler not supported!
#  endif
#else
#  define AC_API_EXPORT
#  define AC_API_IMPORT
#endif

#ifdef ACORE_API_EXPORT_COMMON
#  define AC_COMMON_API AC_API_EXPORT
#else
#  define AC_COMMON_API AC_API_IMPORT
#endif

#ifdef ACORE_API_EXPORT_DATABASE
#  define AC_DATABASE_API AC_API_EXPORT
#else
#  define AC_DATABASE_API AC_API_IMPORT
#endif

#ifdef ACORE_API_EXPORT_SHARED
#  define AC_SHARED_API AC_API_EXPORT
#else
#  define AC_SHARED_API AC_API_IMPORT
#endif

#ifdef ACORE_API_EXPORT_GAME
#  define AC_GAME_API AC_API_EXPORT
#else
#  define AC_GAME_API AC_API_IMPORT
#endif

#define UI64FMTD "%" PRIu64
#define UI64LIT(N) UINT64_C(N)

#define SI64FMTD "%" PRId64
#define SI64LIT(N) INT64_C(N)

#define SZFMTD "%" PRIuPTR

typedef std::int64_t int64;
typedef std::int32_t int32;
typedef std::int16_t int16;
typedef std::int8_t int8;
typedef std::uint64_t uint64;
typedef std::uint32_t uint32;
typedef std::uint16_t uint16;
typedef std::uint8_t uint8;

#endif //ACORE_DEFINE_H
