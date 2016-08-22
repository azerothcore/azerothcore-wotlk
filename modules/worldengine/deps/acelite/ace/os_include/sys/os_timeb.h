// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_timeb.h
 *
 *  additional definitions for date and time
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_SYS_OS_TIMEB_H
#define ACE_OS_INCLUDE_SYS_OS_TIMEB_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-lite.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/sys/os_types.h"

#if !defined (ACE_LACKS_SYS_TIMEB_H)
#  include /**/ <sys/timeb.h>
#endif /* !ACE_LACKS_SYS_TIMEB_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_SYS_OS_TIMEB_H */
