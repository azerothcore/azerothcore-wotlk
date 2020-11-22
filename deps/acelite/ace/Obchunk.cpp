#include "ace/Obchunk.h"
#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

#if !defined (__ACE_INLINE__)
#include "ace/Obchunk.inl"
#endif /* __ACE_INLINE__ */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE(ACE_Obchunk)

void
ACE_Obchunk::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_Obchunk::dump");

  ACELIB_DEBUG ((LM_DEBUG, ACE_BEGIN_DUMP, this));
  ACELIB_DEBUG ((LM_DEBUG,  ACE_TEXT ("end_ = %x\n"), this->end_));
  ACELIB_DEBUG ((LM_DEBUG,  ACE_TEXT ("cur_ = %x\n"), this->cur_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_END_DUMP));
#endif /* ACE_HAS_DUMP */
}

ACE_Obchunk::ACE_Obchunk (size_t size)
  : end_ (contents_ + size),
    block_ (contents_),
    cur_ (contents_),
    next_ (0)
{
}

ACE_END_VERSIONED_NAMESPACE_DECL
