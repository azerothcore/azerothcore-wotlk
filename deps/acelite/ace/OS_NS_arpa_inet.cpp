// -*- C++ -*-
#include "ace/OS_NS_arpa_inet.h"

#if !defined (ACE_HAS_INLINED_OSCALLS)
# include "ace/OS_NS_arpa_inet.inl"
#endif /* ACE_HAS_INLINED_OSCALLS */

#include "ace/Basic_Types.h"

#include <cstdlib>

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

int
ACE_OS::inet_aton (const char *host_name, struct in_addr *addr)
{
#if defined (ACE_LACKS_INET_ATON)
#  if defined (ACE_WIN32)
  // Windows Server 2003 changed the behavior of a zero-length input
  // string to inet_addr(). It used to return 0 (INADDR_ANY) but now
  // returns -1 (INADDR_NONE). It will return INADDR_ANY for a 1-space
  // string, though, as do previous versions of Windows.
  if (host_name == 0 || host_name[0] == '\0')
    host_name = " ";
#  endif /* ACE_WIN32 */

#  if defined (ACE_LACKS_INET_ADDR)
  if (!host_name)
    return 0;
  ACE_UINT32 ip = 0;
  int part = 0;
  for (const char *dot; *host_name; host_name = *dot ? dot + 1 : dot, ++part)
    {
      if (part > 3)
        return 0;
      dot = ACE_OS::strchr (host_name, '.');
      if (!dot)
        dot = host_name + ACE_OS::strlen (host_name);
      char *last;
      const unsigned long n = std::strtoul (host_name, &last, 0);
      if (last != dot)
        return 0;
      if (!*dot)
        switch (part)
          {
          case 0:
#    if ACE_SIZEOF_LONG > 4
            if (n > 0xffffffff)
              return 0;
#    endif
            ip = static_cast<ACE_UINT32> (n);
            continue;
          case 1:
            if (n > 0xffffff)
              return 0;
            ip <<= 24;
            ip |= n;
            continue;
          case 2:
            if (n > 0xffff)
              return 0;
            ip <<= 16;
            ip |= n;
            continue;
          }
      if (n > 0xff)
        return 0;
      ip <<= 8;
      ip |= n;
    }
  addr->s_addr = ACE_HTONL (ip);
  return 1;
#  else
  unsigned long ip_addr = ACE_OS::inet_addr (host_name);

  if (ip_addr == INADDR_NONE
      // Broadcast addresses are weird...
      && ACE_OS::strcmp (host_name, "255.255.255.255") != 0)
    return 0;
  else if (addr == 0)
    return 0;
  else
    {
      addr->s_addr = ip_addr;  // Network byte ordered
      return 1;
    }
#  endif // ACE_LACKS_INET_ADDR
#elif defined (ACE_VXWORKS)
  // inet_aton() returns OK (0) on success and ERROR (-1) on failure.
  // Must reset errno first. Refer to WindRiver SPR# 34949, SPR# 36026
  ::errnoSet(0);
  int result = ERROR;
  ACE_OSCALL (::inet_aton (const_cast <char*>(host_name), addr), int, ERROR, result);
  return (result == ERROR) ? 0 : 1;
#else
  // inet_aton() returns 0 upon failure, not -1 since -1 is a valid
  // address (255.255.255.255).
  ACE_OSCALL_RETURN (::inet_aton (host_name, addr), int, 0);
#endif  /* ACE_LACKS_INET_ATON */
}

ACE_END_VERSIONED_NAMESPACE_DECL
