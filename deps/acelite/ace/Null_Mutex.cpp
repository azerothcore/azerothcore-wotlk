/**
 * @file Null_Mutex.cpp
 *
 *
 *
 * @author Justin Wilson <wilsonj@ociweb.com>
 */

#include "ace/Null_Mutex.h"

#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE(ACE_Null_Mutex)

ACE_END_VERSIONED_NAMESPACE_DECL
