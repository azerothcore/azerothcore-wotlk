// -*- C++ -*-
// Establish a connection.

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE ACE_MEM_IO::Signal_Strategy
ACE_MEM_Connector::preferred_strategy (void) const
{
  return this->preferred_strategy_;
}

ACE_INLINE void
ACE_MEM_Connector::preferred_strategy (ACE_MEM_IO::Signal_Strategy strategy)
{
  this->preferred_strategy_ = strategy;
}

ACE_END_VERSIONED_NAMESPACE_DECL
