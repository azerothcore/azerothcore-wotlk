// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_ucontext.h
 *
 *  user context
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_UCONTEXT_H
#define ACE_OS_INCLUDE_OS_UCONTEXT_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-lite.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/os_signal.h"

#if !defined (ACE_LACKS_UCONTEXT_H)
#  include /**/ <ucontext.h>
#endif /* !ACE_LACKS_ucontext_H */

// Place all additions (especially function declarations) within extern "C" {}
#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

# if !defined (ACE_HAS_UCONTEXT_T)
typedef int ucontext_t;
# endif /* ACE_HAS_UCONTEXT_T */

#ifdef __cplusplus
}
#endif /* __cplusplus */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_UCONTEXT_H */
