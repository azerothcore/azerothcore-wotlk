// -*- C++ -*-
#include "ace/OS_NS_unistd.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE int
ACE_FIFO::get_local_addr (const ACE_TCHAR *&r) const
{
  ACE_TRACE ("ACE_FIFO::get_local_addr");
  r = this->rendezvous_;
  return 0;
}

ACE_INLINE int
ACE_FIFO::remove (void)
{
  ACE_TRACE ("ACE_FIFO::remove");
  int const result = this->close ();
  return ACE_OS::unlink (this->rendezvous_) == -1 || result == -1 ? -1 : 0;
}

ACE_END_VERSIONED_NAMESPACE_DECL
