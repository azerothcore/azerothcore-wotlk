// -*- C++ -*-
#include "ace/OS_NS_netdb.h"

#if !defined (ACE_HAS_INLINED_OSCALLS)
# include "ace/OS_NS_netdb.inl"
#endif /* ACE_HAS_INLINED_OSCALLS */

#if defined (ACE_WIN32) && defined (ACE_HAS_PHARLAP)
# include "ace/OS_NS_stdio.h"
#endif

#include "ace/os_include/net/os_if.h"
#include "ace/Global_Macros.h"
#include "ace/OS_NS_arpa_inet.h"
#include "ace/OS_NS_stdlib.h"
#include "ace/OS_NS_stropts.h"
#include "ace/OS_NS_sys_socket.h"
#include "ace/OS_NS_unistd.h"

#if defined (ACE_LINUX) && !defined (ACE_LACKS_NETWORKING)
#  include "ace/os_include/os_ifaddrs.h"
#endif /* ACE_LINUX && !ACE_LACKS_NETWORKING */

#ifdef ACE_LACKS_IOCTL
#include "ace/OS_NS_devctl.h"
#endif

#ifdef ACE_VXWORKS
# include "ace/os_include/sys/os_sysctl.h"
# include <net/route.h>
#endif

#ifdef ACE_HAS_ALLOC_HOOKS
# include "ace/Malloc_Base.h"
#endif

// Include if_arp so that getmacaddr can use the
// arp structure.
#if defined (sun)
# include /**/ <net/if_arp.h>
#endif

#include <algorithm>

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

int
ACE_OS::getmacaddress (struct macaddr_node_t *node)
{
  ACE_OS_TRACE ("ACE_OS::getmacaddress");

#if defined (ACE_WIN32) && !defined (ACE_HAS_WINCE)
# if !defined (ACE_HAS_PHARLAP)
    /** Define a structure for use with the netbios routine */
    struct ADAPTERSTAT
    {
      ADAPTER_STATUS adapt;
      NAME_BUFFER    NameBuff [30];
    };

    NCB         ncb;
    LANA_ENUM   lenum;
    unsigned char result;

    ACE_OS::memset (&ncb, 0, sizeof(ncb));
    ncb.ncb_command = NCBENUM;
    ncb.ncb_buffer  = reinterpret_cast<unsigned char*> (&lenum);
    ncb.ncb_length  = sizeof(lenum);

    result = Netbios (&ncb);

    for(int i = 0; i < lenum.length; i++)
      {
        ACE_OS::memset (&ncb, 0, sizeof(ncb));
        ncb.ncb_command  = NCBRESET;
        ncb.ncb_lana_num = lenum.lana [i];

        /** Reset the netbios */
        result = Netbios (&ncb);

        if (ncb.ncb_retcode != NRC_GOODRET)
        {
          return -1;
        }

        ADAPTERSTAT adapter;
        ACE_OS::memset (&ncb, 0, sizeof (ncb));
        ACE_OS::strcpy (reinterpret_cast<char*> (ncb.ncb_callname), "*");
        ncb.ncb_command     = NCBASTAT;
        ncb.ncb_lana_num    = lenum.lana[i];
        ncb.ncb_buffer      = reinterpret_cast<unsigned char*> (&adapter);
        ncb.ncb_length      = sizeof (adapter);

        result = Netbios (&ncb);

        if (result == 0)
        {
          ACE_OS::memcpy (node->node,
              adapter.adapt.adapter_address,
              6);
          return 0;
        }
      }
    return 0;
# else
#   if defined (ACE_HAS_PHARLAP_RT)
      DEVHANDLE ip_dev = (DEVHANDLE)0;
      EK_TCPIPCFG *devp = 0;
      size_t i;
      ACE_TCHAR dev_name[16];

      for (i = 0; i < 10; i++)
        {
          // Ethernet.
          ACE_OS::snprintf (dev_name, 16, "ether%d", i);
          ip_dev = EtsTCPGetDeviceHandle (dev_name);
          if (ip_dev != 0)
            break;
        }
      if (ip_dev == 0)
        return -1;
      devp = EtsTCPGetDeviceCfg (ip_dev);
      if (devp == 0)
        return -1;
      ACE_OS::memcpy (node->node,
            &devp->EthernetAddress[0],
            6);
      return 0;
#   else
      ACE_UNUSED_ARG (node);
      ACE_NOTSUP_RETURN (-1);
#   endif /* ACE_HAS_PHARLAP_RT */
# endif /* ACE_HAS_PHARLAP */
#elif defined (sun)

  /** obtain the local host name */
  char hostname [MAXHOSTNAMELEN];
  ACE_OS::hostname (hostname, sizeof (hostname));

  /** Get the hostent to use with ioctl */
  struct hostent *phost =
    ACE_OS::gethostbyname (hostname);

  if (phost == 0)
    return -1;

  ACE_HANDLE handle =
    ACE_OS::socket (PF_INET, SOCK_DGRAM, IPPROTO_UDP);

  if (handle == ACE_INVALID_HANDLE)
    return -1;

  char **paddrs = phost->h_addr_list;

  struct arpreq ar;

  struct sockaddr_in *psa =
    (struct sockaddr_in *)&(ar.arp_pa);

  ACE_OS::memset (&ar,
                  0,
                  sizeof (struct arpreq));

  psa->sin_family = AF_INET;

  ACE_OS::memcpy (&(psa->sin_addr),
                  *paddrs,
                  sizeof (struct in_addr));

  if (ACE_OS::ioctl (handle,
                     SIOCGARP,
                     &ar) == -1)
    {
      ACE_OS::close (handle);
      return -1;
    }

  ACE_OS::close (handle);

  ACE_OS::memcpy (node->node,
                  ar.arp_ha.sa_data,
                  6);

  return 0;

#elif defined (ACE_LINUX) && !defined (ACE_LACKS_NETWORKING)

  // It's easiest to know the first MAC-using interface. Use the BSD
  // getifaddrs function that simplifies access to connected interfaces.
  struct ifaddrs *ifap = 0;
  struct ifaddrs *p_if = 0;

  if (::getifaddrs (&ifap) != 0)
    return -1;

  for (p_if = ifap; p_if != 0; p_if = p_if->ifa_next)
    {
      if (p_if->ifa_addr == 0)
        continue;

      // Check to see if it's up and is not either PPP or loopback
      if ((p_if->ifa_flags & IFF_UP) == IFF_UP &&
          (p_if->ifa_flags & (IFF_LOOPBACK | IFF_POINTOPOINT)) == 0)
        break;
    }
  if (p_if == 0)
    {
      errno = ENODEV;
      ::freeifaddrs (ifap);
      return -1;
    }

  struct ifreq ifr;
  ACE_OS::strcpy (ifr.ifr_name, p_if->ifa_name);
  ::freeifaddrs (ifap);

  ACE_HANDLE handle =
    ACE_OS::socket (PF_INET, SOCK_DGRAM, 0);

  if (handle == ACE_INVALID_HANDLE)
    return -1;

# ifdef ACE_LACKS_IOCTL
  int info = 0;
  if (ACE_OS::posix_devctl (handle, SIOCGIFHWADDR, &ifr, sizeof ifr, &info) < 0)
# else
  if (ACE_OS::ioctl (handle/*s*/, SIOCGIFHWADDR, &ifr) < 0)
# endif
    {
      ACE_OS::close (handle);
      return -1;
    }

  struct sockaddr* sa =
    (struct sockaddr *) &ifr.ifr_addr;

  ACE_OS::close (handle);

  ACE_OS::memcpy (node->node,
                  sa->sa_data,
                  6);

  return 0;

#elif defined (__ANDROID_API__) && defined (ACE_HAS_SIOCGIFCONF) && !defined (ACE_LACKS_NETWORKING)

  struct ifconf ifc;
  struct ifreq ifr_buf[32];


  ACE_HANDLE handle =
    ACE_OS::socket (AF_INET, SOCK_DGRAM, 0);

  if (handle == ACE_INVALID_HANDLE)
    {
      return -1;
    }


  ifc.ifc_len = sizeof(ifr_buf);
  ifc.ifc_req = &ifr_buf[0];

  if (ACE_OS::ioctl (handle, SIOCGIFCONF, &ifc) < 0)
    {
      ACE_OS::close (handle);
      return -1;
    }

  int numif = ifc.ifc_len / sizeof(struct ifreq);

  // find first eligible device
  struct ifreq* ifr = 0;
  for (int i=0; i< numif ;++i)
    {
      ifr = &ifr_buf[i];

      // get device flags
      if (ACE_OS::ioctl (handle, SIOCGIFFLAGS, ifr) < 0)
        {
          ACE_OS::close (handle);
          return -1;
        }

      // Check to see if it's up and is not either PPP or loopback
      if ((ifr->ifr_flags & IFF_UP) == IFF_UP &&
          (ifr->ifr_flags & (IFF_LOOPBACK | IFF_POINTOPOINT)) == 0)
        break;

      ifr = 0;
    }
  // did we find any?
  if (ifr == 0)
    {
      ACE_OS::close (handle);
      errno = ENODEV;
      return -1;
    }

  if (ACE_OS::ioctl (handle, SIOCGIFHWADDR, ifr) < 0)
    {
      ACE_OS::close (handle);
      return -1;
    }

  struct sockaddr* sa =
    (struct sockaddr *) &ifr->ifr_hwaddr;

  ACE_OS::close (handle);

  ACE_OS::memcpy (node->node,
                  sa->sa_data,
                  6);

  return 0;

#elif defined (ACE_HAS_SIOCGIFCONF) && !defined (__ANDROID_API__)

  const long BUFFERSIZE = 4000;
  char buffer[BUFFERSIZE];

  struct ifconf ifc;
  struct ifreq* ifr = 0;

  ACE_HANDLE handle =
    ACE_OS::socket (AF_INET, SOCK_DGRAM, 0);

  if (handle == ACE_INVALID_HANDLE)
    {
      return -1;
    }

  ifc.ifc_len = BUFFERSIZE;
  ifc.ifc_buf = buffer;

  if (ACE_OS::ioctl (handle, SIOCGIFCONF, &ifc) < 0)
    {
      ACE_OS::close (handle);
      return -1;
    }

  for(char* ptr=buffer; ptr < buffer + ifc.ifc_len; )
    {
      ifr = (struct ifreq *) ptr;

      if (ifr->ifr_addr.sa_family == AF_LINK)
        {
          if(ACE_OS::strcmp (ifr->ifr_name, "en0") == 0)
            {
              struct sockaddr_dl* sdl =
                (struct sockaddr_dl *) &ifr->ifr_addr;

              ACE_OS::memcpy (node->node,
                              LLADDR(sdl),
                              6);
            }
        }

      ptr += sizeof(ifr->ifr_name);

      if(sizeof(ifr->ifr_addr) > ifr->ifr_addr.sa_len)
        ptr += sizeof(ifr->ifr_addr);
      else
        ptr += ifr->ifr_addr.sa_len;
    }

  ACE_OS::close (handle);

  return 0;

#elif defined ACE_VXWORKS

  int name[] = {CTL_NET, AF_ROUTE, 0, 0, NET_RT_IFLIST, 0};
  static const size_t name_elts = sizeof name / sizeof name[0];

  size_t result_sz = 0u;
  if (sysctl (name, name_elts, 0, &result_sz, 0, 0u) != 0)
    return -1;

# ifdef ACE_HAS_ALLOC_HOOKS
  char *const result =
    static_cast<char *> (ACE_Allocator::instance ()->malloc (result_sz));
#  define ACE_NETDB_CLEANUP ACE_Allocator::instance ()->free (result)
# else
  char *const result = static_cast<char *> (ACE_OS::malloc (result_sz));
#  define ACE_NETDB_CLEANUP ACE_OS::free (result)
# endif

  if (sysctl (name, name_elts, result, &result_sz, 0, 0u) != 0)
    {
      ACE_NETDB_CLEANUP;
      return -1;
    }

  for (size_t pos = 0, n; pos + sizeof (if_msghdr) < result_sz; pos += n)
    {
      if_msghdr *const hdr = reinterpret_cast<if_msghdr *> (result + pos);
      n = hdr->ifm_msglen;
      sockaddr_dl *const addr =
        reinterpret_cast<sockaddr_dl *> (result + pos + sizeof (if_msghdr));

      if (addr->sdl_alen >= sizeof node->node)
        {
          ACE_OS::memcpy (node->node, LLADDR (addr), sizeof node->node);
          ACE_NETDB_CLEANUP;
          return 0;
        }

      while (pos + n < result_sz)
        {
          ifa_msghdr *const ifa =
            reinterpret_cast<ifa_msghdr *> (result + pos + n);
          if (ifa->ifam_type != RTM_NEWADDR)
            break;
          n += ifa->ifam_msglen;
        }
    }

  ACE_NETDB_CLEANUP;
# undef ACE_NETDB_CLEANUP
  return -1;

#else
  ACE_UNUSED_ARG (node);
  ACE_NOTSUP_RETURN (-1);
#endif
}

#ifdef ACE_LACKS_GETADDRINFO
int
ACE_OS::getaddrinfo_emulation (const char *name, addrinfo **result)
{
  hostent entry;
  ACE_HOSTENT_DATA buffer;
  int herr = 0;
  const hostent *host = ACE_OS::gethostbyname_r (name, &entry, buffer, &herr);

  if (host == 0)
    {
      switch (herr)
        {
        case NO_DATA:
        case HOST_NOT_FOUND:
          return EAI_NONAME;
        case TRY_AGAIN:
          return EAI_AGAIN;
        case NO_RECOVERY:
          return EAI_FAIL;
        case ENOTSUP:
          if (ACE_OS::inet_aton (name, (in_addr *) &buffer[0]) != 0)
            {
              host = &entry;
              entry.h_length = sizeof (in_addr);
              entry.h_addr_list = (char **) (buffer + sizeof (in_addr));
              entry.h_addr_list[0] = buffer;
              entry.h_addr_list[1] = 0;
              break;
            }
          // fall-through
        default:
          errno = herr;
          return EAI_SYSTEM;
        }
    }

  size_t n = 0;
  for (char **addr = host->h_addr_list; *addr; ++addr, ++n) /*empty*/;

# ifdef ACE_HAS_ALLOC_HOOKS
  ACE_Allocator *const al = ACE_Allocator::instance ();
#  define ACE_ALLOC al->
# else
#  define ACE_ALLOC ACE_OS::
# endif

  ACE_ALLOCATOR_RETURN (*result,
                        (addrinfo *) ACE_ALLOC calloc (n, sizeof (addrinfo)),
                        EAI_MEMORY);

  sockaddr_in *const addr_storage =
    (sockaddr_in *) ACE_ALLOC calloc (n, sizeof (sockaddr_in));

  if (!addr_storage)
    {
      ACE_ALLOC free (*result);
      *result = 0;
      return EAI_MEMORY;
    }

  for (size_t i = 0; i < n; ++i)
    {
      (*result)[i].ai_family = AF_INET;
      (*result)[i].ai_addrlen = sizeof (sockaddr_in);
      (*result)[i].ai_addr = (sockaddr *) addr_storage + i;
      (*result)[i].ai_addr->sa_family = AF_INET;
      ACE_OS::memcpy (&addr_storage[i].sin_addr, host->h_addr_list[i],
                      (std::min) (size_t (host->h_length), sizeof (in_addr)));
      if (i < n - 1)
        (*result)[i].ai_next = (*result) + i + 1;
    }

  return 0;
}

void
ACE_OS::freeaddrinfo_emulation (addrinfo *result)
{
# ifdef ACE_HAS_ALLOC_HOOKS
  ACE_Allocator *const al = ACE_Allocator::instance ();
  al->free (result->ai_addr);
  al->free (result);
# else
  ACE_OS::free (result->ai_addr);
  ACE_OS::free (result);
# endif
}
#endif /* ACE_LACKS_GETADDRINFO */

#ifdef ACE_LACKS_GETNAMEINFO
int
ACE_OS::getnameinfo_emulation (const sockaddr *saddr, ACE_SOCKET_LEN saddr_len,
                               char *host, ACE_SOCKET_LEN host_len)
{
  if (saddr_len != sizeof (sockaddr_in) || saddr->sa_family != AF_INET)
    return EAI_FAMILY; // IPv6 support requries actual OS-provided getnameinfo

  const void *addr = &((const sockaddr_in *) saddr)->sin_addr;
  int h_error;
  hostent hentry;
  ACE_HOSTENT_DATA buf;
  hostent *const hp =
    ACE_OS::gethostbyaddr_r (static_cast<const char *> (addr),
# ifdef ACE_LACKS_IN_ADDR_T
                             4,
# else
                             sizeof (in_addr_t),
# endif
                             AF_INET, &hentry, buf, &h_error);

  if (hp == 0 || hp->h_name == 0)
    return EAI_NONAME;

  if (ACE_OS::strlen (hp->h_name) >= size_t (host_len))
    {
      if (host_len > 0)
        {
          ACE_OS::memcpy (host, hp->h_name, host_len - 1);
          host[host_len - 1] = '\0';
        }
      return EAI_OVERFLOW;
    }

  ACE_OS::strcpy (host, hp->h_name);
  return 0;
}
#endif /* ACE_LACKS_GETNAMEINFO */

ACE_END_VERSIONED_NAMESPACE_DECL

# if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0) && defined (ACE_LACKS_NETDB_REENTRANT_FUNCTIONS)
#   include "ace/OS_NS_Thread.h"
#   include "ace/Object_Manager_Base.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

int
ACE_OS::netdb_acquire (void)
{
  return ACE_OS::thread_mutex_lock ((ACE_thread_mutex_t *)
    ACE_OS_Object_Manager::preallocated_object[
      ACE_OS_Object_Manager::ACE_OS_MONITOR_LOCK]);
}

int
ACE_OS::netdb_release (void)
{
  return ACE_OS::thread_mutex_unlock ((ACE_thread_mutex_t *)
    ACE_OS_Object_Manager::preallocated_object[
      ACE_OS_Object_Manager::ACE_OS_MONITOR_LOCK]);
}

ACE_END_VERSIONED_NAMESPACE_DECL

# endif /* defined (ACE_LACKS_NETDB_REENTRANT_FUNCTIONS) */
