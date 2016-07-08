// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_utime.h
 *
 *  access and modification times structure
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_UTIME_H
#define ACE_OS_INCLUDE_OS_UTIME_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/sys/os_types.h"

#if !defined (ACE_LACKS_UTIME_H)
#  include /**/ <utime.h>
#endif /* !ACE_LACKS_UTIME_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_UTIME_H */
