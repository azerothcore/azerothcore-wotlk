// -*- C++ -*-
ACE_INLINE
ACE_Sig_Handler::ACE_Sig_Handler (void)
{
}

ACE_INLINE int
ACE_Sig_Handler::in_range (int signum)
{
  ACE_TRACE ("ACE_Sig_Handler::in_range");
  return signum > 0 && signum < ACE_NSIG;
}
