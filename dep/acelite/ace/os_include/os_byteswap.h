// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_byteswap.h
 *
 *  Byteswap methods
 *
 *  @author Johnny Willemsen  <jwillemsen@remedy.nl>
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_BYTESWAP_H
#define ACE_OS_INCLUDE_OS_BYTESWAP_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if defined (ACE_HAS_BYTESWAP_H)
# include /**/ <byteswap.h>
#endif /* !ACE_HAS_INTRIN_H */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_BYTESWAP_H */
