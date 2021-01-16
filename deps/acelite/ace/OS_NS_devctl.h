#ifndef ACE_OS_NS_DEVCTL_H
#define ACE_OS_NS_DEVCTL_H

#include /**/ "ace/pre.h"
#include "ace/config-all.h"

#ifndef ACE_LACKS_PRAGMA_ONCE
#pragma once
#endif

#include "ace/os_include/sys/os_types.h"

#include "ace/ACE_export.h"

#ifdef ACE_EXPORT_MACRO
# undef ACE_EXPORT_MACRO
#endif
#define ACE_EXPORT_MACRO ACE_Export

ACE_BEGIN_VERSIONED_NAMESPACE_DECL
namespace ACE_OS {

  ACE_NAMESPACE_INLINE_FUNCTION
  int posix_devctl (int filedes, int dcmd,
                    void *dev_data_ptr, size_t nbyte,
                    int *dev_info_ptr);

}
ACE_END_VERSIONED_NAMESPACE_DECL

#ifdef ACE_HAS_INLINED_OSCALLS
# ifdef ACE_INLINE
#  undef ACE_INLINE
# endif
# define ACE_INLINE inline
# include "ace/OS_NS_devctl.inl"
#endif

#include /**/ "ace/post.h"
#endif // ACE_OS_NS_DEVCTL_H
