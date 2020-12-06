#if defined ACE_LACKS_POSIX_DEVCTL && defined ACE_EMULATE_POSIX_DEVCTL
#include "ace/os_include/os_stropts.h"
#endif

#include "ace/os_include/os_errno.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE int
ACE_OS::posix_devctl (int filedes, int dcmd,
                      void *dev_data_ptr, size_t nbyte,
                      int *dev_info_ptr)
{
  ACE_OS_TRACE ("ACE_OS::posix_devctl");
#ifdef ACE_LACKS_POSIX_DEVCTL
  ACE_UNUSED_ARG (nbyte);
  ACE_UNUSED_ARG (dev_info_ptr);
# if defined ACE_EMULATE_POSIX_DEVCTL && ACE_EMULATE_POSIX_DEVCTL
  ACE_OSCALL_RETURN (::ioctl (filedes, dcmd, dev_data_ptr), int, -1);
# else
  ACE_UNUSED_ARG (filedes);
  ACE_UNUSED_ARG (dcmd);
  ACE_UNUSED_ARG (dev_data_ptr);
  ACE_NOTSUP_RETURN (-1);
# endif
#else
  ACE_OSCALL_RETURN (::posix_devctl (filedes, dcmd, dev_data_ptr, nbyte,
                                     dev_info_ptr), int, -1);
#endif
}

ACE_END_VERSIONED_NAMESPACE_DECL
