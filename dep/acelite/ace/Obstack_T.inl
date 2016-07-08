// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

template <class ACE_CHAR_T> ACE_INLINE size_t
ACE_Obstack_T<ACE_CHAR_T>::size () const
{
  return this->size_;
}

ACE_END_VERSIONED_NAMESPACE_DECL
