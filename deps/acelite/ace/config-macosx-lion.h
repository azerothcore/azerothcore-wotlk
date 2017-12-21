#ifndef ACE_CONFIG_MACOSX_LION_H
#define ACE_CONFIG_MACOSX_LION_H

#include "ace/config-macosx-leopard.h"

#ifdef __clang__
# ifdef ACE_HAS_GCC_ATOMIC_BUILTINS
# undef ACE_HAS_GCC_ATOMIC_BUILTINS
# endif

# define ACE_ANY_OPS_USE_NAMESPACE
#endif /* __clang__ */

#if  defined (__x86_64__)
// On 64 bit platforms, the "long" type is 64-bits.  Override the
// default 32-bit platform-specific format specifiers appropriately.
# define ACE_INT64_FORMAT_SPECIFIER_ASCII "%ld"
# define ACE_INT64_FORMAT_SPECIFIER "%ld"
# define ACE_UINT64_FORMAT_SPECIFIER_ASCII "%lu"
# define ACE_UINT64_FORMAT_SPECIFIER "%lu"
# define ACE_UINT64_FORMAT_SPECIFIER_ASCII "%lu"
# define ACE_SSIZE_T_FORMAT_SPECIFIER_ASCII "%ld"
# define ACE_SIZE_T_FORMAT_SPECIFIER_ASCII "%lu"
#endif /* __x86_64__ */

#define ACE_LACKS_UCONTEXT_H

#endif // ACE_CONFIG_MACOSX_LION_H
