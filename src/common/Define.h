/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL2 v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_DEFINE_H
#define ACORE_DEFINE_H

#include <cstdint>
#include <cstddef>
#include <sys/types.h>
#include <ace/Basic_Types.h>
#include <ace/ACE_export.h>
#include <ace/Default_Constants.h>
#include "CompilerDefs.h"

#if defined(_WIN32) || defined(WIN32) || defined(__CYGWIN__) || defined(__MINGW32__) || defined(__BORLANDC__)
#define OS_WIN
#endif

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
#  ifndef DECLSPEC_NORETURN
#    define DECLSPEC_NORETURN __declspec(noreturn)
#  endif //DECLSPEC_NORETURN
#  ifndef DECLSPEC_DEPRECATED
#    define DECLSPEC_DEPRECATED __declspec(deprecated)
#  endif //DECLSPEC_DEPRECATED
#  define ACORE_THREAD_DECL __declspec(dllexport)
#  define ACORE_THREAD_DECL __declspec(dllimport)
#else //AC_PLATFORM != AC_PLATFORM_WINDOWS
#  define ACORE_PATH_MAX PATH_MAX
#  define DECLSPEC_NORETURN
#  define DECLSPEC_DEPRECATED
#  define ACORE_THREAD_DECL
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

#define UI64FMTD ACE_UINT64_FORMAT_SPECIFIER
#define UI64LIT(N) ACE_UINT64_LITERAL(N)

#define SI64FMTD ACE_INT64_FORMAT_SPECIFIER
#define SI64LIT(N) ACE_INT64_LITERAL(N)

#define SIZEFMTD ACE_SIZE_T_FORMAT_SPECIFIER

#define UNUSED(x) (void)(x)

typedef std::int64_t int64;
typedef std::int32_t int32;
typedef std::int16_t int16;
typedef std::int8_t int8;
typedef std::uint64_t uint64;
typedef std::uint32_t uint32;
typedef std::uint16_t uint16;
typedef std::uint8_t uint8;

#endif //ACORE_DEFINE_H
