// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

#if defined (ACE_VXWORKS)
// Specialization to use native VxWorks Message Queues.

ACE_INLINE MSG_Q_ID
ACE_Message_Queue_Vx::msgq (void)
{
  // Hijack the tail_ field to store the MSG_Q_ID.
  return static_cast<MSG_Q_ID> (
#if defined __LP64__ && defined __RTP__
  // In RTP-mode only MSG_Q_ID is an int; in a 64-bit build the size of MSG_Q_ID
  // doesn't match the size of a pointer, tail_, so first treat it as 64-bit.
                                reinterpret_cast<long> (tail_)
#elif defined __RTP__
                                reinterpret_cast<int> (tail_)
#else
                                reinterpret_cast<MSG_Q_ID> (tail_)
#endif /* __RTP__ */
                                );
}

ACE_INLINE int
ACE_Message_Queue_Vx::peek_dequeue_head (ACE_Message_Block *&,
                                         ACE_Time_Value *)
{
  ACE_NOTSUP_RETURN (-1);
}

#endif /* ACE_VXWORKS */

ACE_END_VERSIONED_NAMESPACE_DECL
