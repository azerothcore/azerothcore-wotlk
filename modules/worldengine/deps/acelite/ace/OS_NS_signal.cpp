#include "ace/OS_NS_signal.h"

#if !defined (ACE_HAS_INLINED_OSCALLS)
# include "ace/OS_NS_signal.inl"
#endif /* ACE_HAS_INLINED_OSCALLS */

#if !defined (ACE_HAS_SIGINFO_T)
siginfo_t::siginfo_t (ACE_HANDLE handle)
  : si_handle_ (handle)
{
}
#endif /* ACE_HAS_SIGINFO_T */
