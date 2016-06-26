/* -*- C++ -*- */
//=============================================================================
/**
 *  @file   config-win32-msvc-11.h
 *
 *  @brief  Microsoft Visual C++ 11.0 configuration file.
 *
 *  This file is the ACE configuration file for Microsoft Visual C++ version 11.
 *
 *  @note Do not include this file directly, include config-win32.h instead.
 */
//=============================================================================

#ifndef ACE_CONFIG_WIN32_MSVC_11_H
#define ACE_CONFIG_WIN32_MSVC_11_H
#include /**/ "ace/pre.h"

#ifndef ACE_CONFIG_WIN32_H
#error Use config-win32.h in config.h instead of this header
#endif /* ACE_CONFIG_WIN32_H */

#ifndef ACE_WIN32_VC11
#  define ACE_WIN32_VC11
#endif

// Until we have specific msvc11 settings, include the msvc10 file
#include "ace/config-win32-msvc-10.h"

#include /**/ "ace/post.h"
#endif /* ACE_CONFIG_WIN32_MSVC_10_H */
