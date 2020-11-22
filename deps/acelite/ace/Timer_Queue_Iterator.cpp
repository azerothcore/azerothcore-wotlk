#ifndef ACE_TIMER_QUEUE_ITERATOR_CPP
#define ACE_TIMER_QUEUE_ITERATOR_CPP

#include "ace/config-all.h"
#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if !defined (__ACE_INLINE__)
#include "ace/Timer_Queue_Iterator.inl"
#endif /* __ACE_INLINE__ */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE_Tc(ACE_Timer_Node_T)

template <class TYPE> void
ACE_Timer_Node_T<TYPE>::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_Timer_Node_T::dump");
  ACELIB_DEBUG ((LM_DEBUG, ACE_BEGIN_DUMP, this));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nact_ = %x"), this->act_));
  this->timer_value_.dump ();
  this->interval_.dump ();
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nprev_ = %x"), this->prev_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nnext_ = %x"), this->next_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\ntimer_id_ = %d\n"), this->timer_id_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_END_DUMP));
#endif /* ACE_HAS_DUMP */
}

template <class TYPE>
ACE_Timer_Node_T<TYPE>::ACE_Timer_Node_T (void)
  : act_ (0),
    prev_ (0),
    next_ (0),
    timer_id_ (-1)
{
  ACE_TRACE ("ACE_Timer_Node_T::ACE_Timer_Node_T");
}

template <class TYPE>
ACE_Timer_Node_T<TYPE>::~ACE_Timer_Node_T (void)
{
  ACE_TRACE ("ACE_Timer_Node_T::~ACE_Timer_Node_T");
}

template <class TYPE>
ACE_Timer_Queue_Iterator_T<TYPE>::ACE_Timer_Queue_Iterator_T (void)
{
}

template <class TYPE>
ACE_Timer_Queue_Iterator_T<TYPE>::~ACE_Timer_Queue_Iterator_T (void)
{
}

ACE_END_VERSIONED_NAMESPACE_DECL

#endif /* ACE_TIMER_QUEUE_ITERATOR_CPP */
