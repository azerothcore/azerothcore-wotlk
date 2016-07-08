// -*- C++ -*-
ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE void
ACE_ATM_QoS::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_ATM_QoS::dump");
#endif /* ACE_HAS_DUMP */
}

ACE_INLINE
ACE_ATM_QoS::~ACE_ATM_QoS ()
{
  ACE_TRACE ("ACE_ATM_QoS::~ACE_ATM_QoS");
}

ACE_INLINE
ATM_QoS
ACE_ATM_QoS::get_qos (void)
{
  ACE_TRACE ("ACE_ATM_QoS::get_qos");
  return qos_;
}

ACE_END_VERSIONED_NAMESPACE_DECL
