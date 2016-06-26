// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

template<class T> ACE_INLINE T*
ACE_Intrusive_List_Node<T>::prev (void) const
{
  return this->prev_;
}

template<class T> ACE_INLINE void
ACE_Intrusive_List_Node<T>::prev (T *x)
{
  this->prev_ = x;
}

template<class T> ACE_INLINE T*
ACE_Intrusive_List_Node<T>::next (void) const
{
  return this->next_;
}

template<class T> ACE_INLINE void
ACE_Intrusive_List_Node<T>::next (T *x)
{
  this->next_ = x;
}

ACE_END_VERSIONED_NAMESPACE_DECL
