/**
 * @file TSS_Adapter.cpp
 *
 * Originally in Synch.cpp
 *
 * @author Douglas C. Schmidt <d.schmidt@vanderbilt.edu>
 */

#include "ace/TSS_Adapter.h"

#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_TSS_Adapter::ACE_TSS_Adapter (void *object, ACE_THR_DEST f)
  : ts_obj_ (object),
    func_ (f)
{
}

ACE_ALLOC_HOOK_DEFINE(ACE_TSS_Adapter);

void
ACE_TSS_Adapter::cleanup (void)
{
  (*this->func_)(this->ts_obj_);  // call cleanup routine for ts_obj_
}

ACE_END_VERSIONED_NAMESPACE_DECL

extern "C" ACE_Export void
ACE_TSS_C_cleanup (void *object)
{
  if (object != 0)
    {
      ACE_TSS_Adapter * const tss_adapter = (ACE_TSS_Adapter *) object;
      // Perform cleanup on the real TS object.
      tss_adapter->cleanup ();
      // Delete the adapter object.
      delete tss_adapter;
    }
}
