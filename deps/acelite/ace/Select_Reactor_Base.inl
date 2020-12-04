// -*- C++ -*-
#include "ace/Reactor.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE ACE_Select_Reactor_Handler_Repository::size_type
ACE_Select_Reactor_Handler_Repository::size (void) const
{
#ifdef ACE_SELECT_REACTOR_BASE_USES_HASH_MAP
  return this->event_handlers_.total_size ();
#else
  return this->event_handlers_.size ();
#endif  /* ACE_SELECT_REACTOR_BASE_USES_HASH_MAP */
}

ACE_INLINE ACE_Select_Reactor_Handler_Repository::max_handlep1_type
ACE_Select_Reactor_Handler_Repository::max_handlep1 (void) const
{
#ifdef ACE_SELECT_REACTOR_BASE_USES_HASH_MAP
  return this->event_handlers_.current_size ();
#else
  return this->max_handlep1_;
#endif  /* ACE_SELECT_REACTOR_BASE_USES_HASH_MAP */
}

ACE_INLINE int
ACE_Select_Reactor_Handler_Repository::unbind (ACE_HANDLE handle,
                                               ACE_Reactor_Mask mask)
{
  // Do not refactor this code to optimize the call to the unbind impl.
  // To resolve bug 2653, unbind must be called even when find_eh returns
  // event_handlers_.end().

  return !this->handle_in_range (handle) ? -1
          : this->unbind (handle,
                          this->find_eh (handle),
                          mask);
}

ACE_INLINE ACE_Event_Handler *
ACE_Select_Reactor_Handler_Repository::find (ACE_HANDLE handle)
{
  ACE_TRACE ("ACE_Select_Reactor_Handler_Repository::find");

  ACE_Event_Handler * eh = 0;

  if (this->handle_in_range (handle))
    {
      map_type::iterator const pos = this->find_eh (handle);

      if (pos != this->event_handlers_.end ())
        {
#ifdef ACE_SELECT_REACTOR_BASE_USES_HASH_MAP
          eh = (*pos).item ();
#else
          eh = *pos;
#endif  /* ACE_SELECT_REACTOR_BASE_USES_HASH_MAP */
        }
    }
  // Don't bother setting errno.  It isn't used in the select()-based
  // reactors and incurs a TSS access.
  //   else
  //     {
  //       errno = ENOENT;
  //     }

  return eh;
}

// ------------------------------------------------------------------

ACE_INLINE bool
ACE_Select_Reactor_Handler_Repository_Iterator::done (void) const
{
#ifdef ACE_SELECT_REACTOR_BASE_USES_HASH_MAP
  return this->current_ == this->rep_->event_handlers_.end ();
#else
  return this->current_ == (this->rep_->event_handlers_.begin ()
                            + this->rep_->max_handlep1 ());
#endif /* ACE_SELECT_REACTOR_BASE_USES_HASH_MAP */
}

// ------------------------------------------------------------------

ACE_INLINE
ACE_Event_Tuple::ACE_Event_Tuple (void)
  : handle_ (ACE_INVALID_HANDLE),
    event_handler_ (0)
{
}

ACE_INLINE
ACE_Event_Tuple::ACE_Event_Tuple (ACE_Event_Handler* eh,
                                  ACE_HANDLE h)
  : handle_ (h),
    event_handler_ (eh)
{
}

ACE_INLINE bool
ACE_Event_Tuple::operator== (const ACE_Event_Tuple &rhs) const
{
  return this->handle_ == rhs.handle_;
}

ACE_INLINE bool
ACE_Event_Tuple::operator!= (const ACE_Event_Tuple &rhs) const
{
  return !(*this == rhs);
}

#if defined (ACE_WIN32_VC8) || defined (ACE_WIN32_VC9)
#  pragma warning (push)
#  pragma warning (disable:4355)  /* Use of 'this' in initializer list */
#endif
ACE_INLINE
ACE_Select_Reactor_Impl::ACE_Select_Reactor_Impl (bool ms)
  : handler_rep_ (*this)
  , timer_queue_ (0)
  , signal_handler_ (0)
  , notify_handler_ (0)
  , delete_timer_queue_ (false)
  , delete_signal_handler_ (false)
  , delete_notify_handler_ (false)
  , initialized_ (false)
  , restart_ (false)
  , requeue_position_ (-1) // Requeue at end of waiters by default.
  , owner_ (ACE_OS::NULL_thread)
  , state_changed_ (false)
  , mask_signals_ (ms)
  , supress_renew_ (0)
{
}
#if defined (ACE_WIN32_VC8) || defined (ACE_WIN32_VC9)
#  pragma warning (pop)
#endif

ACE_INLINE bool
ACE_Select_Reactor_Impl::supress_notify_renew (void)
{
  return this->supress_renew_;
}

ACE_INLINE void
ACE_Select_Reactor_Impl::supress_notify_renew (bool sr)
{
  this->supress_renew_ = sr;
}

ACE_END_VERSIONED_NAMESPACE_DECL
