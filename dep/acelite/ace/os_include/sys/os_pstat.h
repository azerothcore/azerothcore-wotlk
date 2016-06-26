// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_pstat.h
 *
 *  pstat functions
 *
 *  @author Johnny Willemsen  <jwillemsen@remedy.nl>
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_SYS_OS_PSTAT_H
#define ACE_OS_INCLUDE_SYS_OS_PSTAT_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if defined (ACE_HAS_SYS_PSTAT_H)
#  include /**/ <sys/param.h>
#  include /**/ <sys/pstat.h>
#endif /* ACE_HAS_SYS_PSTAT_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_SYS_OS_PSTAT_H */
