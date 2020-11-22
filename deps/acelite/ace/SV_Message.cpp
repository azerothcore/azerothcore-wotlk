// SV_Message.cpp
#include "ace/SV_Message.h"

#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

#if !defined (__ACE_INLINE__)
#include "ace/SV_Message.inl"
#endif /* __ACE_INLINE__ */



ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE(ACE_SV_Message)

void
ACE_SV_Message::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_SV_Message::dump");
#endif /* ACE_HAS_DUMP */
}

ACE_END_VERSIONED_NAMESPACE_DECL
