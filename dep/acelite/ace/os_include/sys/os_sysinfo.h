// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_sysinfo.h
 *
 *  @author Johnny Willemsen  <jwillemsen@remedy.nl>
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_SYS_OS_SYSINFO_H
#define ACE_OS_INCLUDE_SYS_OS_SYSINFO_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-lite.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if defined (ACE_HAS_SYS_SYSINFO_H)
#  include /**/ <sys/sysinfo.h>
#endif /* ACE_HAS_SYS_SYSINFO_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_SYS_OS_SYSINFO_H */
