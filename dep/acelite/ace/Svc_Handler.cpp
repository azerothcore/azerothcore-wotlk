#ifndef ACE_SVC_HANDLER_CPP
#define ACE_SVC_HANDLER_CPP

#include "ace/Svc_Handler.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/OS_NS_sys_time.h"
#include "ace/Object_Manager.h"
#include "ace/Connection_Recycling_Strategy.h"

#include "ace/Dynamic.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

template <typename PEER_STREAM, typename SYNCH_TRAITS> void *
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator new (size_t, void *p)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator new (NOOP, 2 parameters)");
  return p;
}

#if !defined (ACE_LACKS_PLACEMENT_OPERATOR_DELETE)
template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator delete (void *, void *)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator delete (NOOP, 2 parameters)");
  return;
}
#endif /* ACE_LACKS_PLACEMENT_OPERATOR_DELETE */

template <typename PEER_STREAM, typename SYNCH_TRAITS> void *
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator new (size_t n)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator new");

  ACE_Dynamic *const dynamic_instance = ACE_Dynamic::instance ();

  if (dynamic_instance == 0)
    {
      // If this ACE_ASSERT fails, it may be due to running of out TSS
      // keys.  Try using ACE_HAS_TSS_EMULATION, or increasing
      // ACE_DEFAULT_THREAD_KEYS if already using TSS emulation.
      ACE_ASSERT (dynamic_instance != 0);

      ACE_throw_bad_alloc;
    }
  else
    {
      // Allocate the memory and store it (usually in thread-specific
      // storage, depending on config flags).
      dynamic_instance->set ();

      return ::new char[n];
    }
}

#if defined (ACE_HAS_NEW_NOTHROW)
template <typename PEER_STREAM, typename SYNCH_TRAITS> void *
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator new (size_t n,
                                                          const ACE_nothrow_t&) throw()
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator new(nothrow)");

  ACE_Dynamic *const dynamic_instance = ACE_Dynamic::instance ();

  if (dynamic_instance == 0)
    {
      // If this ACE_ASSERT fails, it may be due to running of out TSS
      // keys.  Try using ACE_HAS_TSS_EMULATION, or increasing
      // ACE_DEFAULT_THREAD_KEYS if already using TSS emulation.
      ACE_ASSERT (dynamic_instance != 0);

      return 0;
    }
  else
    {
      // Allocate the memory and store it (usually in thread-specific
      // storage, depending on config flags).
      dynamic_instance->set ();

      return ::new(ACE_nothrow) char[n];
    }
}

#if !defined (ACE_LACKS_PLACEMENT_OPERATOR_DELETE)
template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator delete (void *p,
                                         const ACE_nothrow_t&) throw()
{
  ACE_TRACE("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator delete(nothrow)");
  ::delete [] static_cast <char *> (p);
}
#endif /* ACE_LACKS_PLACEMENT_OPERATOR_DELETE */

#endif /* ACE_HAS_NEW_NOTHROW */

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::destroy (void)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::destroy");

  // Only delete ourselves if we're not owned by a module and have
  // been allocated dynamically.
  if (this->mod_ == 0 && this->dynamic_ && this->closing_ == false)
    // Will call the destructor, which automatically calls <shutdown>.
    // Note that if we are *not* allocated dynamically then the
    // destructor will call <shutdown> automatically when it gets run
    // during cleanup.
    delete this;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator delete (void *obj)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::operator delete");
  // You cannot delete a 'void*' (X3J16/95-0087 5.3.5.3), but we know
  // the pointer was created using new char[] (see operator new code),
  // so we use a cast:
  ::delete [] static_cast <char *> (obj);
}

// Default constructor.

template <typename PEER_STREAM, typename SYNCH_TRAITS>
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::ACE_Svc_Handler (ACE_Thread_Manager *tm,
                                                          ACE_Message_Queue<SYNCH_TRAITS> *mq,
                                                          ACE_Reactor *reactor)
  : ACE_Task<SYNCH_TRAITS> (tm, mq),
    closing_ (false),
    recycler_ (0),
    recycling_act_ (0)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::ACE_Svc_Handler");

  this->reactor (reactor);

  // This clever idiom transparently checks if we were allocated
  // dynamically.  This information is used by the <destroy> method to
  // decide if we need to delete <this>...  The idiom is based on a
  // paper by Michael van Rooyen (mrooyen@cellnet.co.uk) that appeared
  // in the April '96 issue of the C++ Report.  We've spruced it up to
  // work correctly in multi-threaded programs by using our ACE_TSS
  // class.
  this->dynamic_ = ACE_Dynamic::instance ()->is_dynamic ();

  if (this->dynamic_)
    // Make sure to reset the flag.
    ACE_Dynamic::instance ()->reset ();
}

// Default behavior for a ACE_Svc_Handler object is to be registered
// with the ACE_Reactor (thereby ensuring single threading).

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::open (void *)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::open");
#if defined (ACELIB_DEBUGGING)
  ACE_TCHAR buf[BUFSIZ];
  ACE_PEER_STREAM_ADDR client_addr;

  if (this->peer_.get_remote_addr (client_addr) == -1)
    ACELIB_ERROR_RETURN ((LM_ERROR,
                       ACE_TEXT ("%p\n"),
                       ACE_TEXT ("get_remote_addr")),
                      -1);
  else if (client_addr.addr_to_string (buf, sizeof buf) == -1)
    ACELIB_ERROR_RETURN ((LM_ERROR,
                       ACE_TEXT ("%p\n"),
                       ACE_TEXT ("can't obtain peer's address")),
                      -1);
  ACELIB_DEBUG ((LM_DEBUG,
              ACE_TEXT ("connected to %s on fd %d\n"),
              buf,
              this->peer_.get_handle ()));
#endif /* ACELIB_DEBUGGING */
  if (this->reactor ()
      && this->reactor ()->register_handler
      (this,
       ACE_Event_Handler::READ_MASK) == -1)
    ACELIB_ERROR_RETURN ((LM_ERROR,
                       ACE_TEXT ("%p\n"),
                       ACE_TEXT ("unable to register client handler")),
                      -1);
  return 0;
}

// Perform termination activities.

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::shutdown (void)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::shutdown");

  // Deregister this handler with the ACE_Reactor.
  if (this->reactor ())
    {
      ACE_Reactor_Mask mask = ACE_Event_Handler::ALL_EVENTS_MASK |
        ACE_Event_Handler::DONT_CALL;

      // Make sure there are no timers.
      this->reactor ()->cancel_timer (this);

      if (this->peer ().get_handle () != ACE_INVALID_HANDLE)
        // Remove self from reactor.
        this->reactor ()->remove_handler (this, mask);
    }

  // Remove self from the recycler.
  if (this->recycler ())
    this->recycler ()->purge (this->recycling_act_);

  this->peer ().close ();
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::cleanup_hint (void **act_holder)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::cleanup_hint");

  // Remove as hint.
  if (this->recycler ())
    this->recycler ()->cleanup_hint (this->recycling_act_,
                                     act_holder);
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::dump");

  this->peer_.dump ();
  ACELIB_DEBUG ((LM_DEBUG,
              "dynamic_ = %d\n",
              this->dynamic_));
  ACELIB_DEBUG ((LM_DEBUG,
              "closing_ = %d\n",
              this->closing_));
  ACELIB_DEBUG ((LM_DEBUG,
              "recycler_ = %d\n",
              this->recycler_));
  ACELIB_DEBUG ((LM_DEBUG,
              "recycling_act_ = %d\n",
              this->recycling_act_));
#endif /* ACE_HAS_DUMP */
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> PEER_STREAM &
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::peer (void) const
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::peer");
  return (PEER_STREAM &) this->peer_;
}

// Extract the underlying I/O descriptor.

template <typename PEER_STREAM, typename SYNCH_TRAITS> ACE_HANDLE
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::get_handle (void) const
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::get_handle");
  return this->peer_.get_handle ();
}

// Set the underlying I/O descriptor.

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::set_handle (ACE_HANDLE h)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::set_handle");
  this->peer_.set_handle (h);
}

template <typename PEER_STREAM, typename SYNCH_TRAITS>
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::~ACE_Svc_Handler (void)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::~ACE_Svc_Handler");

  if (this->closing_ == false)
    {
      // We're closing down now, so make sure not to call ourselves
      // recursively via other calls to handle_close() (e.g., from the
      // Timer_Queue).
      this->closing_ = true;

      this->shutdown ();
    }
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::handle_close (ACE_HANDLE,
                                                       ACE_Reactor_Mask)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::handle_close");

  if (this->reference_counting_policy ().value () ==
      ACE_Event_Handler::Reference_Counting_Policy::DISABLED)
    {
      this->destroy ();
    }

  return 0;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::handle_timeout (const ACE_Time_Value &,
                                                         const void *)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::handle_timeout");
  return this->handle_close ();
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::close (u_long)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::close");
  return this->handle_close ();
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::init (int /* argc */,
                                               ACE_TCHAR * /* argv */[])
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::init");
  return -1;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::fini (void)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::fini");
  return -1;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::info (ACE_TCHAR **, size_t) const
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::info");
  return -1;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::idle (u_long flags)
{
  if (this->recycler ())
    return this->recycler ()->cache (this->recycling_act_);
  else
    return this->close (flags);
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycle_state (ACE_Recyclable_State new_state)
{
  if (this->recycler ())
    return this->recycler ()->recycle_state (this->recycling_act_,
                                             new_state);

  return 0;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> ACE_Recyclable_State
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycle_state (void) const
{
  if (this->recycler ())
    return this->recycler ()->recycle_state (this->recycling_act_);

  return ACE_RECYCLABLE_UNKNOWN;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycler (ACE_Connection_Recycling_Strategy *recycler,
                                                   const void *recycling_act)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycler");
  this->recycler_ = recycler;
  this->recycling_act_ = recycling_act;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> ACE_Connection_Recycling_Strategy *
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycler (void) const
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycler");
  return this->recycler_;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> const void *
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycling_act (void) const
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycling_act");
  return this->recycling_act_;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycle (void *)
{
  ACE_TRACE ("ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::recycle");
  // By default, the object is ready and willing to be recycled.
  return 0;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS>
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::~ACE_Buffered_Svc_Handler (void)
{
  this->flush ();
}

template <typename PEER_STREAM, typename SYNCH_TRAITS>
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::ACE_Buffered_Svc_Handler (ACE_Thread_Manager *tm,
                                                                            ACE_Message_Queue<SYNCH_TRAITS> *mq,
                                                                            ACE_Reactor *reactor,
                                                                            size_t maximum_buffer_size,
                                                                            ACE_Time_Value *timeout)
  : ACE_Svc_Handler<PEER_STREAM, SYNCH_TRAITS> (tm, mq, reactor),
    maximum_buffer_size_ (maximum_buffer_size),
    current_buffer_size_ (0),
    timeoutp_ (timeout)
{
  ACE_TRACE ("ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::ACE_Buffered_Svc_Handler");

  if (this->timeoutp_ != 0)
    {
      this->interval_ = *timeout;
      this->next_timeout_ = ACE_OS::gettimeofday () + this->interval_;
    }
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::put (ACE_Message_Block *mb,
                                                          ACE_Time_Value *tv)
{
  ACE_GUARD_RETURN (typename SYNCH_TRAITS::MUTEX, m, this->msg_queue ()->lock (), -1);

  // Enqueue <mb> onto the message queue.
  if (this->putq (mb, tv) == -1)
    return -1;
  else
    {
      // Update the current number of bytes on the queue.
      this->current_buffer_size_ += mb->total_size ();

      // Flush the buffer when the number of bytes exceeds the maximum
      // buffer size or when the timeout period has elapsed.
      if (this->current_buffer_size_ >= this->maximum_buffer_size_
          || (this->timeoutp_ != 0
              && this->next_timeout_ <= ACE_OS::gettimeofday ()))
        return this->flush_i ();
      else
        return 0;
    }
}

// Flush the buffer.

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::flush (void)
{
  ACE_GUARD_RETURN (typename SYNCH_TRAITS::MUTEX, m, this->msg_queue ()->lock (), -1);

  return this->flush_i ();
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::flush_i (void)
{
  ACE_Message_Queue_Iterator<SYNCH_TRAITS> iterator (*this->msg_queue ());
  ACE_Message_Block *mblk = 0;
  ssize_t result = 0;

  // Get the first <ACE_Message_Block> so that we can write everything
  // out via the <send_n>.
  if (iterator.next (mblk) != 0)
    result = this->peer ().send_n (mblk);

  // This method assumes the caller holds the queue's lock!
  if (result != -1)
    this->msg_queue ()->flush_i ();

  if (this->timeoutp_ != 0)
    // Update the next timeout period by adding the interval.
    this->next_timeout_ += this->interval_;

  this->current_buffer_size_ = 0;

  return result;
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> void
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::dump");

  ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::dump ();
  ACELIB_DEBUG ((LM_DEBUG,
              "maximum_buffer_size_ = %d\n",
              this->maximum_buffer_size_));
  ACELIB_DEBUG ((LM_DEBUG,
              "current_buffer_size_ = %d\n",
              this->current_buffer_size_));
  if (this->timeoutp_ != 0)
    ACELIB_DEBUG ((LM_DEBUG,
                "next_timeout_.sec = %d, next_timeout_.usec = %d\n",
                this->next_timeout_.sec (),
                this->next_timeout_.usec ()));
#endif /* ACE_HAS_DUMP */
}

template <typename PEER_STREAM, typename SYNCH_TRAITS> int
ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::handle_timeout (const ACE_Time_Value &,
                                                                     const void *)
{
  ACE_TRACE ("ACE_Buffered_Svc_Handler<PEER_STREAM, SYNCH_TRAITS>::handle_timeout");
  return 0;
}

ACE_END_VERSIONED_NAMESPACE_DECL

#endif /* ACE_SVC_HANDLER_CPP */
