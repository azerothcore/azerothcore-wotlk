// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_spawn.h
 *
 *  spawn (ADVANCED REALTIME)
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_SPAWN_H
#define ACE_OS_INCLUDE_OS_SPAWN_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/os_signal.h"
#include "ace/os_include/sys/os_types.h"
#include "ace/os_include/os_sched.h"

#if !defined (ACE_LACKS_SPAWN_H)
# include /**/ <spawn.h>
#endif /* !ACE_LACKS_SPAWN_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_SPAWN_H */
