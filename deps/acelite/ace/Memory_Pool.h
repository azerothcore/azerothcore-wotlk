/* -*- C++ -*- */

//=============================================================================
/**
 *  @file     Memory_Pool.h
 *
 *  @author Dougls C. Schmidt <d.schmidt@vanderbilt.edu>
 *  @author Prashant Jain <pjain@cs.wustl.edu>
 */
//=============================================================================

#ifndef ACE_MEMORY_POOL_H
#define ACE_MEMORY_POOL_H
#include /**/ "ace/pre.h"

#include "ace/ACE.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/Local_Memory_Pool.h"
#include "ace/MMAP_Memory_Pool.h"
#include "ace/Sbrk_Memory_Pool.h"
#include "ace/Shared_Memory_Pool.h"
#include "ace/Pagefile_Memory_Pool.h"

#include /**/ "ace/post.h"
#endif /* ACE_MEMORY_POOL_H */
