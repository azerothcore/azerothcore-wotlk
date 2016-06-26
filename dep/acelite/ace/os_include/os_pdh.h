// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_pdh.h
 *
 *  definitions for the windows pdh API
 *
 *  @author Johnny Willemsen  <jwillemsen@remedy.nl>
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_PDH_H
#define ACE_OS_INCLUDE_OS_PDH_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if defined (ACE_HAS_PDH_H) && !defined (ACE_LACKS_PDH_H)
# include /**/ <pdh.h>
#endif /* ACE_HAS_PDH_H && !ACE_LACKS_PDH_H */

#if defined (ACE_HAS_PDH_H) && !defined (ACE_LACKS_PDH_H)
# define ACE_HAS_WIN32_PDH
#endif

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_PDH_H */
