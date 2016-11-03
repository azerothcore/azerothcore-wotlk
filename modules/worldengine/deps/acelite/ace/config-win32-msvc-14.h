/* -*- C++ -*- */
//=============================================================================
/**
 *  @file   config-win32-msvc-14.h
 *
 *  @brief  Microsoft Visual C++ 14.0 configuration file.
 *
 *  This file is the ACE configuration file for Microsoft Visual C++ version 2015.
 *
 *  @note Do not include this file directly, include config-win32.h instead.
 */
//=============================================================================

#ifndef ACE_CONFIG_WIN32_MSVC_14_H
#define ACE_CONFIG_WIN32_MSVC_14_H
#include /**/ "ace/pre.h"

#ifndef ACE_CONFIG_WIN32_H
#error Use config-win32.h in config.h instead of this header
#endif /* ACE_CONFIG_WIN32_H */

#ifndef ACE_WIN32_VC14
#  define ACE_WIN32_VC14
#endif

// Until we have specific msvc14 settings, include the msvc12 file
#include "ace/config-win32-msvc-12.h"

#define ACE_HAS_POSIX_TIME 1
#define ACE_LACKS_TIMESPEC_T 1

// According to MS the Visual Studio 2015 C-runtime has a
// C99 compliant vsnprintf/vsnwprintf, this is a change compared to
// previous versions
#define ACE_HAS_C99_VSNPRINTF
#define ACE_HAS_C99_VSNWPRINTF

// Visual Studio 2015 has 3 parameter wcstok
#define ACE_HAS_3_PARAM_WCSTOK

#include /**/ "ace/post.h"
#endif /* ACE_CONFIG_WIN32_MSVC_14_H */
