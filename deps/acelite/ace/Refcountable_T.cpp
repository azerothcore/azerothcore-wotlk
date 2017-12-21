#ifndef ACE_REFCOUNTABLE_T_CPP
#define ACE_REFCOUNTABLE_T_CPP

#include "ace/Refcountable_T.h"

#if !defined (__ACE_INLINE__)
#include "ace/Refcountable_T.inl"
#endif /* __ACE_INLINE__ */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

template <class ACE_LOCK>
ACE_Refcountable_T<ACE_LOCK>::~ACE_Refcountable_T (void)
{
}

ACE_END_VERSIONED_NAMESPACE_DECL

#endif  /* !ACE_REFCOUNTABLE_T_CPP */
