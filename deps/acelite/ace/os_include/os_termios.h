// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_termios.h
 *
 *  define values for termios
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_TERMIOS_H
#define ACE_OS_INCLUDE_OS_TERMIOS_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if !defined (ACE_LACKS_TERMIOS_H)
#  include /**/ <termios.h>
#endif /* !ACE_LACKS_TERMIOS_H */

#if defined (HPUX)
#  include /**/ <sys/modem.h>
#endif /* HPUX */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_TERMIOS_H */
