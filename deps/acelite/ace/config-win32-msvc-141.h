/* -*- C++ -*- */
//=============================================================================
/**
 *  @file   config-win32-msvc-141.h
 *
 *  @brief  Microsoft Visual C++ 14.1 configuration file.
 *
 *  This file is the ACE configuration file for Microsoft Visual C++ 14.1 (as released with Visual Studio 2017).
 *
 *  @note Do not include this file directly, include config-win32.h instead.
 */
//=============================================================================

#ifndef ACE_CONFIG_WIN32_MSVC_141_H
#define ACE_CONFIG_WIN32_MSVC_141_H
#include /**/ "ace/pre.h"

#ifndef ACE_CONFIG_WIN32_H
#error Use config-win32.h in config.h instead of this header
#endif /* ACE_CONFIG_WIN32_H */

#ifndef ACE_WIN32_VC141
#  define ACE_WIN32_VC141
#endif

#include "ace/config-win32-msvc-14.h"

#if _MSVC_LANG >= 201402L
# define ACE_HAS_CPP14
#endif /* _MSVC_LANG >= 201402L */

#if _MSVC_LANG >= 201703L
# define ACE_HAS_CPP17
#endif /* _MSVC_LANG >= 201703L */

#include /**/ "ace/post.h"
#endif /* ACE_CONFIG_WIN32_MSVC_141_H */
