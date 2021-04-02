// -*- C++ -*-
#include "ace/OS_NS_string.h"
#include "ace/OS_NS_errno.h"
#include "ace/OS_NS_stdio.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE unsigned long
ACE_OS::inet_addr (const char *name)
{
  ACE_OS_TRACE ("ACE_OS::inet_addr");
#if defined (ACE_LACKS_INET_ADDR)
  ACE_UNUSED_ARG (name);
  ACE_NOTSUP_RETURN (0);
#elif defined (ACE_HAS_NONCONST_INET_ADDR)
  return ::inet_addr (const_cast <char*> (name));
#else
  return ::inet_addr (name);
#endif /* ACE_HAS_NONCONST_INET_ADDR */
}

ACE_INLINE char *
ACE_OS::inet_ntoa (const struct in_addr addr)
{
  ACE_OS_TRACE ("ACE_OS::inet_ntoa");
#if defined (ACE_LACKS_INET_NTOA)
  ACE_UNUSED_ARG (addr);
  ACE_NOTSUP_RETURN (0);
#else
  ACE_OSCALL_RETURN (::inet_ntoa (addr), char *, 0);
#endif
}

ACE_INLINE const char *
ACE_OS::inet_ntop (int family, const void *addrptr, char *strptr, size_t len)
{
  ACE_OS_TRACE ("ACE_OS::inet_ntop");

#if defined ACE_HAS_IPV6 && !defined ACE_LACKS_INET_NTOP
#  if defined (ACE_HAS_NONCONST_INET_NTOP)
  ACE_OSCALL_RETURN (::inet_ntop (family, const_cast<void *> (addrptr), strptr, len), const char *, 0);
#  else
  ACE_OSCALL_RETURN (::inet_ntop (family, addrptr, strptr, len), const char *, 0);
#  endif
#else

  if (family == AF_INET)
    {
      const u_char *const p = reinterpret_cast<const u_char *> (addrptr);
      if (ACE_OS::snprintf (strptr, len, "%d.%d.%d.%d", p[0], p[1], p[2], p[3])
          > static_cast<int> (len))
        {
          errno = ENOSPC;
          return 0; // Failure
        }
      return strptr;
    }

  errno = EAFNOSUPPORT;
  return 0;
#endif
}

ACE_INLINE int
ACE_OS::inet_pton (int family, const char *strptr, void *addrptr)
{
  ACE_OS_TRACE ("ACE_OS::inet_pton");

#if defined ACE_HAS_IPV6 && !defined ACE_LACKS_INET_PTON
  ACE_OSCALL_RETURN (::inet_pton (family, strptr, addrptr), int, -1);
#else

  if (family == AF_INET)
    {
      if (ACE_OS::inet_aton (strptr, static_cast<in_addr *> (addrptr)))
        return 1; // Success

      return 0; // Input is not a valid presentation format
    }

  errno = EAFNOSUPPORT;
  return 0;
#endif
}

ACE_END_VERSIONED_NAMESPACE_DECL
