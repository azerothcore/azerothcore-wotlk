// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_inttypes.h
 *
 *  fixed size integer types
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_INTTYPES_H
#define ACE_OS_INCLUDE_OS_INTTYPES_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-lite.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/os_stdint.h"

#if !defined (ACE_LACKS_INTTYPES_H)
# include /**/ <inttypes.h>
#endif /* !ACE_LACKS_INTTYPES_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_INTTYPES_H */
