// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_pdhmsg.h
 *
 *  definitions for the windows pdh API
 *
 *  @author Johnny Willemsen  <jwillemsen@remedy.nl>
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_PDHMSG_H
#define ACE_OS_INCLUDE_OS_PDHMSG_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if defined (ACE_HAS_PDHMSG_H) && !defined (ACE_LACKS_PDHMSG_H)
# include /**/ <pdhmsg.h>
#endif /* ACE_HAS_PDH_H && !ACE_LACKS_PDH_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_PDHMSG_H */
