// Defines the Internet domain address family address format.

#include "ace/INET_Addr.h"

#if !defined (__ACE_INLINE__)
#include "ace/INET_Addr.inl"
#endif /* __ACE_INLINE__ */

#include "ace/Log_Category.h"
#include "ace/OS_NS_stdio.h"
#include "ace/OS_NS_errno.h"
#include "ace/OS_NS_stdlib.h"
#include "ace/OS_Memory.h"
#include "ace/OS_NS_arpa_inet.h"
#include "ace/OS_NS_netdb.h"
#include "ace/OS_NS_unistd.h"
#include "ace/OS_NS_sys_socket.h"
#include "ace/Truncate.h"
#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE(ACE_INET_Addr)

// Transform the current address into string format.

int
ACE_INET_Addr::addr_to_string (ACE_TCHAR s[],
                               size_t size,
                               int ipaddr_format) const
{
  ACE_TRACE ("ACE_INET_Addr::addr_to_string");

  // XXX Can we (should we) include the scope id for IPv6 addresses?
  char hoststr[MAXHOSTNAMELEN+1];

  bool result = false;
  if (ipaddr_format == 0)
    result = (this->get_host_name (hoststr, MAXHOSTNAMELEN+1) == 0);
  else
    result = (this->get_host_addr (hoststr, MAXHOSTNAMELEN+1) != 0);

  if (!result)
    return -1;

  size_t total_len =
    ACE_OS::strlen (hoststr)
    + 5 // ACE_OS::strlen ("65535"), Assuming the max port number.
    + 1 // sizeof (':'), addr/port sep
    + 1; // sizeof ('\0'), terminating NUL
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
  ACE_TCHAR const *format = ACE_TEXT("%ls:%d");
#else
  ACE_TCHAR const *format = ACE_TEXT("%s:%d");
#endif /* !ACE_WIN32 && ACE_USES_WCHAR */
#if defined (ACE_HAS_IPV6)
  if (ACE_OS::strchr (hoststr, ACE_TEXT (':')) != 0)
    {
      total_len += 2; // ACE_OS::strlen ("[]") IPv6 addr frames
#  if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
      format = ACE_TEXT("[%ls]:%d");
#  else
      format = ACE_TEXT("[%s]:%d");
#  endif /* !ACE_WIN32 && ACE_USES_WCHAR */
    }
#endif // ACE_HAS_IPV6

  if (size < total_len)
    return -1;
  else
    ACE_OS::snprintf (s, size, format,
                      ACE_TEXT_CHAR_TO_TCHAR (hoststr),
                      this->get_port_number ());
  return 0;
}

void
ACE_INET_Addr::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_INET_Addr::dump");

  ACELIB_DEBUG ((LM_DEBUG, ACE_BEGIN_DUMP, this));

  ACE_TCHAR s[ACE_MAX_FULLY_QUALIFIED_NAME_LEN + 16];
  this->addr_to_string(s, ACE_MAX_FULLY_QUALIFIED_NAME_LEN + 16);
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("%s"), s));
  ACELIB_DEBUG ((LM_DEBUG, ACE_END_DUMP));
#endif /* ACE_HAS_DUMP */
}

// Compare two addresses for inequality.

bool
ACE_INET_Addr::operator != (const ACE_INET_Addr &sap) const
{
  ACE_TRACE ("ACE_INET_Addr::operator !=");
  return !((*this) == sap);
}

// Compare two addresses for equality.

bool
ACE_INET_Addr::operator == (const ACE_INET_Addr &sap) const
{
  ACE_TRACE ("ACE_INET_Addr::operator ==");

  if (this->get_type () != sap.get_type ()
      || this->get_size () != sap.get_size ())
    return false;

  return (ACE_OS::memcmp (&this->inet_addr_,
                          &sap.inet_addr_,
                          this->get_size ()) == 0);
}

bool
ACE_INET_Addr::is_ip_equal (const ACE_INET_Addr &sap) const
{
    if (this->get_type () != sap.get_type ()
      || this->get_size () != sap.get_size ())
    return false;

#if defined (ACE_HAS_IPV6)
  if (this->get_type () == PF_INET6)
    {
      const unsigned int *addr =
        reinterpret_cast<const unsigned int*>(this->ip_addr_pointer());
      const unsigned int *saddr =
        reinterpret_cast<const unsigned int*>(sap.ip_addr_pointer());
      return (addr[0] == saddr[0] &&
              addr[1] == saddr[1] &&
              addr[2] == saddr[2] &&
              addr[3] == saddr[3]);
    }
  else
#endif /* ACE_HAS_IPV6 */
  return this->get_ip_address () == sap.get_ip_address();
}


u_long
ACE_INET_Addr::hash (void) const
{
#if defined (ACE_HAS_IPV6)
  if (this->get_type () == PF_INET6)
    {
      const unsigned int *addr = (const unsigned int*)this->ip_addr_pointer();
      return addr[0] + addr[1] + addr[2] + addr[3] + this->get_port_number();
    }
  else
#endif /* ACE_HAS_IPV6 */
  return this->get_ip_address () + this->get_port_number ();
}

bool
ACE_INET_Addr::next (void)
{
  if (this->inet_addrs_.empty () ||
      this->inet_addrs_iter_ == this->inet_addrs_.end ())
    return false;

  union ip46 next_a = *this->inet_addrs_iter_++;
  this->set_addr (&next_a, sizeof (next_a));
  return true;
}

void
ACE_INET_Addr::reset (void)
{
  this->inet_addrs_iter_ = this->inet_addrs_.begin ();
  this->next ();
}

ACE_INET_Addr::ACE_INET_Addr (void)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  // ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  this->reset_i ();
}

ACE_INET_Addr &
ACE_INET_Addr::operator= (const ACE_INET_Addr& rhs)
{
  if (this != &rhs)
    this->set (rhs);
  return *this;
}

int
ACE_INET_Addr::set (const ACE_INET_Addr &sa)
{
  ACE_TRACE ("ACE_INET_Addr::set");

  if (sa.get_type () == AF_ANY)
    // Ugh, this is really a base class, so don't copy it.
    ACE_OS::memset (&this->inet_addr_, 0, sizeof (this->inet_addr_));
  else
    {
      // It's ok to make the copy.
      ACE_OS::memcpy (&this->inet_addr_,
                      &sa.inet_addr_,
                      sa.get_size ());

      this->set_type (sa.get_type());
      this->set_size (sa.get_size());
      this->inet_addrs_ = sa.inet_addrs_;
      this->reset ();
    }

  return 0;
}

// Transform the string into the current addressing format.

int
ACE_INET_Addr::string_to_addr (const char s[], int address_family)
{
  ACE_TRACE ("ACE_INET_Addr::string_to_addr");
  int result;
  char *ip_buf = 0;
  char *ip_addr = 0;

  // Need to make a duplicate since we'll be overwriting the string.
  ACE_ALLOCATOR_RETURN (ip_buf,
                        ACE_OS::strdup (s),
                        -1);
  ip_addr = ip_buf;
  // We use strrchr because of IPv6 addresses.
  char *port_p = ACE_OS::strrchr (ip_addr, ':');
#if defined (ACE_HAS_IPV6)
  // Check for extended IPv6 format : '[' <ipv6 address> ']' ':' <port>
  if (ip_addr[0] == '[')
    {
      // find closing bracket
      char *cp_pos = ACE_OS::strchr (ip_addr, ']');
      // check for port separator after closing bracket
      // if not found leave it, error will come later
      if (cp_pos)
        {
          *cp_pos = '\0'; // blank out ']'
          ++ip_addr; // skip over '['
          if (cp_pos[1] == ':')
            port_p = cp_pos + 1;
          else
            port_p = cp_pos; // leads to error on missing port
        }
    }
#endif /* ACE_HAS_IPV6 */

  if (port_p == 0) // Assume it's a port number.
    {
      char *endp = 0;
      long const port = ACE_OS::strtol (ip_addr, &endp, 10);

      if (*endp == '\0')    // strtol scanned the entire string - all digits
        {
          if (port < 0 || port > ACE_MAX_DEFAULT_PORT)
            result = -1;
          else
            result = this->set (u_short (port), ACE_UINT32 (INADDR_ANY));
        }
      else // port name
        result = this->set (ip_addr, ACE_UINT32 (INADDR_ANY));
    }
  else
    {
      *port_p = '\0'; ++port_p; // skip over ':'

      char *endp = 0;
      long port = ACE_OS::strtol (port_p, &endp, 10);

      if (*endp == '\0')    // strtol scanned the entire string - all digits
        {
          if (port < 0 || port > ACE_MAX_DEFAULT_PORT)
            result = -1;
          else
            result = this->set (u_short (port), ip_addr, 1, address_family);
        }
      else
        result = this->set (port_p, ip_addr);
    }

#if defined (ACE_HAS_ALLOC_HOOKS)
  ACE_Allocator::instance()->free (ACE_MALLOC_T (ip_buf));
#else
  ACE_OS::free (ACE_MALLOC_T (ip_buf));
#endif /* ACE_HAS_ALLOC_HOOKS */
  return result;
}

int
ACE_INET_Addr::set (const char address[], int address_family)
{
  ACE_TRACE ("ACE_INET_Addr::set");
  this->reset_i ();
  return this->string_to_addr (address, address_family);
}

ACE_INET_Addr::ACE_INET_Addr (const char address[], int address_family)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  this->set (address, address_family);
}

#if defined (ACE_HAS_WCHAR)
ACE_INET_Addr::ACE_INET_Addr (const wchar_t address[], int address_family)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  this->set (address, address_family);
}

#endif /* ACE_HAS_WCHAR */

// Copy constructor.

ACE_INET_Addr::ACE_INET_Addr (const ACE_INET_Addr &sa)
  : ACE_Addr (sa.get_type (), sa.get_size())
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  this->set (sa);
}

// Initializes a ACE_INET_Addr from a PORT_NUMBER and a 32 bit Internet
// address.

int
ACE_INET_Addr::set (u_short port_number,
                    ACE_UINT32 inet_address,
                    int encode,
                    int map)
{
  ACE_TRACE ("ACE_INET_Addr::set");
  this->reset_i ();
  this->set_address (reinterpret_cast<const char *> (&inet_address),
                     sizeof inet_address,
                     encode, map);
  this->set_port_number (port_number, encode);

  return 0;
}


// Initializes a ACE_INET_Addr from a PORT_NUMBER and the remote
// HOST_NAME.

int
ACE_INET_Addr::set (u_short port_number,
                    const char host_name[],
                    int encode,
                    int address_family)
{
  ACE_TRACE ("ACE_INET_Addr::set");

  // Yow, someone gave us a NULL host_name!
  if (host_name == 0)
    {
      errno = EINVAL;
      return -1;
    }

  this->reset_i ();

#if defined ACE_HAS_IPV6 && defined ACE_USES_IPV4_IPV6_MIGRATION
  if (address_family == AF_UNSPEC && !ACE::ipv6_enabled ())
    address_family = AF_INET;
#endif /* ACE_HAS_IPV6 && ACE_USES_IPV4_IPV6_MIGRATION */

#ifdef ACE_HAS_IPV6
  if (address_family == AF_UNSPEC && ACE::ipv6_enabled ())
    address_family = AF_INET6;

  if (address_family != AF_INET
      && ACE_OS::inet_pton (AF_INET6, host_name,
                            &this->inet_addr_.in6_.sin6_addr) == 1)
    {
      this->base_set (AF_INET6, sizeof this->inet_addr_.in4_);
# ifdef ACE_HAS_SOCKADDR_IN6_SIN6_LEN
      this->inet_addr_.in6_.sin6_len = sizeof this->inet_addr_.in6_;
# endif
      this->inet_addr_.in6_.sin6_family = AF_INET6;
      this->set_size (sizeof this->inet_addr_.in6_);
      this->set_type (AF_INET6);
      this->set_port_number (port_number, encode);
      return 0;
    }
#else
   address_family = AF_INET;
#endif /* ACE_HAS_IPV6 */

  if (ACE_OS::inet_pton (AF_INET, host_name,
                         &this->inet_addr_.in4_.sin_addr) == 1)
    {
      this->base_set (AF_INET, sizeof this->inet_addr_.in4_);
#ifdef ACE_HAS_SOCKADDR_IN_SIN_LEN
      this->inet_addr_.in4_.sin_len = sizeof this->inet_addr_.in4_;
#endif
      this->inet_addr_.in4_.sin_family = AF_INET;
      this->set_size (sizeof this->inet_addr_.in4_);
      this->set_type (AF_INET);
      this->set_port_number (port_number, encode);
      return 0;
    }

  addrinfo hints;
  ACE_OS::memset (&hints, 0, sizeof hints);
  hints.ai_family = address_family;
  // The ai_flags used to contain AI_ADDRCONFIG as well but that prevented
  // lookups from completing if there is no, or only a loopback, IPv6
  // interface configured. See Bugzilla 4211 for more info.

  hints.ai_flags = AI_V4MAPPED;
#if defined(ACE_HAS_IPV6) && defined(AI_ALL)
  // Without AI_ALL, Windows machines exhibit inconsistent behaviors on
  // difference machines we have tested.
  hints.ai_flags |= AI_ALL;
#endif

  // Note - specify the socktype here to avoid getting multiple entries
  // returned with the same address for different socket types or
  // protocols. If this causes a problem for some reason (an address that's
  // available for TCP but not UDP, or vice-versa) this will need to change
  // back to unrestricted hints and weed out the duplicate addresses by
  // searching this->inet_addrs_ which would slow things down.
  hints.ai_socktype = SOCK_STREAM;

  addrinfo *res = 0;
  const int error = ACE_OS::getaddrinfo (host_name, 0, &hints, &res);

  if (error)
    {
      errno = error;
      return -1;
    }

  this->set_type (res->ai_family);

  for (addrinfo *curr = res; curr; curr = curr->ai_next)
    {
      ip46 addr;
      ACE_OS::memcpy (&addr, curr->ai_addr, curr->ai_addrlen);
#ifdef ACE_HAS_IPV6
      if (curr->ai_family == AF_INET6)
        addr.in6_.sin6_port = encode ? ACE_NTOHS (port_number) : port_number;
      else
#endif
        addr.in4_.sin_port = encode ? ACE_NTOHS (port_number) : port_number;
      this->inet_addrs_.push_back (addr);
    }

  ACE_OS::freeaddrinfo (res);
  this->reset ();
  return 0;
}

// Helper function to get a port number from a port name.

static int get_port_number_from_name (const char port_name[],
                                      const char protocol[])
{
  // Maybe port_name is directly a port number?
  char *endp = 0;
  long port_number = ACE_OS::strtol (port_name, &endp, 10);

  if (*endp == '\0')
    {
      // port_name was really a number, and nothing else.

      // Check for overflow.
      if (port_number < 0 || port_number > ACE_MAX_DEFAULT_PORT)
        return -1;

      // Return the port number.  NOTE: this number must
      // be returned in network byte order!
      u_short n = static_cast<u_short> (port_number);
      n = ACE_HTONS (n);
      return n;
    }

  // We try to resolve port number from its name.

#if defined (ACE_LACKS_GETSERVBYNAME)
  port_number = 0;
  ACE_UNUSED_ARG (port_name);
  ACE_UNUSED_ARG (protocol);
#else
  port_number = -1;
  servent sentry;
  ACE_SERVENT_DATA buf;
  servent *sp = ACE_OS::getservbyname_r (port_name,
                                         protocol,
                                         &sentry,
                                         buf);
  if (sp != 0)
    port_number = sp->s_port;
#endif /* ACE_LACKS_GETSERVBYNAME */

  return port_number;
}

// Initializes a ACE_INET_Addr from a <port_name> and the remote
// <host_name>.

int
ACE_INET_Addr::set (const char port_name[],
                    const char host_name[],
                    const char protocol[])
{
  ACE_TRACE ("ACE_INET_Addr::set");

  this->reset_i ();
  int const port_number = get_port_number_from_name (port_name, protocol);
  if (port_number == -1)
    {
      ACE_NOTSUP_RETURN (-1);
    }

  int address_family = PF_UNSPEC;
  if (ACE_OS::strcmp(protocol, "tcp") == 0)
    address_family = AF_INET;

#  if defined (ACE_HAS_IPV6)
  if (ACE_OS::strcmp (protocol, "tcp6") == 0)
    address_family = AF_INET6;
#  endif /* ACE_HAS_IPV6 */

  return this->set (static_cast<u_short> (port_number),
                    host_name, 0, address_family);
}

// Initializes a ACE_INET_Addr from a <port_name> and a 32 bit
// Internet address.

int
ACE_INET_Addr::set (const char port_name[],
                    ACE_UINT32 inet_address,
                    const char protocol[])
{
  ACE_TRACE ("ACE_INET_Addr::set");

  this->reset_i ();
  int const port_number = get_port_number_from_name (port_name, protocol);
  if (port_number == -1)
    {
      ACE_NOTSUP_RETURN (-1);
    }

  return this->set (static_cast<u_short> (port_number),
                    inet_address, 0);
}

// Creates a ACE_INET_Addr from a PORT_NUMBER and the remote
// HOST_NAME.

ACE_INET_Addr::ACE_INET_Addr (u_short port_number,
                              const char host_name[],
                              int address_family)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  ACE_OS::memset (&this->inet_addr_, 0, sizeof (this->inet_addr_));
  if (this->set (port_number,
                 host_name,
                 1,
                 address_family) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr: %p\n"),
                ACE_TEXT_CHAR_TO_TCHAR ((host_name == 0) ?
                                        "<unknown>" : host_name)));
}

#if defined (ACE_HAS_WCHAR)
ACE_INET_Addr::ACE_INET_Addr (u_short port_number,
                              const wchar_t host_name[],
                              int address_family)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  ACE_OS::memset (&this->inet_addr_, 0, sizeof (this->inet_addr_));
  if (this->set (port_number,
                 host_name,
                 1,
                 address_family) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr: %p\n"),
                ACE_TEXT_WCHAR_TO_TCHAR ((host_name == 0) ?
                                         ACE_TEXT_WIDE ("<unknown>") :
                                         host_name)));
}
#endif /* ACE_HAS_WCHAR */

// Creates a ACE_INET_Addr from a sockaddr_in structure.

int
ACE_INET_Addr::set (const sockaddr_in *addr, int len)
{
  ACE_TRACE ("ACE_INET_Addr::set");

  this->reset_i ();
  if (addr->sin_family == AF_INET)
    {
      int maxlen = static_cast<int> (sizeof (this->inet_addr_.in4_));
      if (len > maxlen)
        len = maxlen;
      ACE_OS::memcpy (&this->inet_addr_.in4_, addr, len);
      this->base_set (AF_INET, len);
      return 0;
    }
#if defined (ACE_HAS_IPV6)
  else if (addr->sin_family == AF_INET6)
    {
      int maxlen = static_cast<int> (sizeof (this->inet_addr_.in6_));
      if (len > maxlen)
        len = maxlen;
      ACE_OS::memcpy (&this->inet_addr_.in6_, addr, len);
      this->base_set (AF_INET6, len);
      return 0;
    }
#endif /* ACE_HAS_IPV6 */

  errno = EAFNOSUPPORT;
  return -1;
}

// Return the address.

void *
ACE_INET_Addr::get_addr (void) const
{
  ACE_TRACE ("ACE_INET_Addr::get_addr");
  return (void*)&this->inet_addr_;
}

void
ACE_INET_Addr::set_addr (const void *addr, int len)
{
  this->set_addr (addr, len, 0);
}

// Set a pointer to the address.
void
ACE_INET_Addr::set_addr (const void *addr, int /* len */, int map)
{
  ACE_TRACE ("ACE_INET_Addr::set_addr");
  const struct sockaddr_in *getfamily =
    static_cast<const struct sockaddr_in *> (addr);

  if (getfamily->sin_family == AF_INET)
    {
#if defined (ACE_HAS_IPV6)
      if (map)
        this->set_type (AF_INET6);
      else
#endif /* ACE_HAS_IPV6 */
        this->set_type (AF_INET);
      this->set_port_number (getfamily->sin_port, 0);
      this->set_address (reinterpret_cast<const char*> (&getfamily->sin_addr),
                         sizeof (getfamily->sin_addr),
                         0, map);
    }
#if defined (ACE_HAS_IPV6)
  else if (getfamily->sin_family == AF_INET6)
    {
      const struct sockaddr_in6 *in6 =
        static_cast<const struct sockaddr_in6*> (addr);
      this->set_port_number (in6->sin6_port, 0);
      this->set_address (reinterpret_cast<const char*> (&in6->sin6_addr),
                         sizeof (in6->sin6_addr),
                         0);
      this->inet_addr_.in6_.sin6_scope_id = in6->sin6_scope_id;
    }
#endif // ACE_HAS_IPV6
}

// Creates a ACE_INET_Addr from a sockaddr_in structure.

ACE_INET_Addr::ACE_INET_Addr (const sockaddr_in *addr, int len)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  this->set (addr, len);
}

// Creates a ACE_INET_Addr from a PORT_NUMBER and an Internet address.

ACE_INET_Addr::ACE_INET_Addr (u_short port_number,
                              ACE_UINT32 inet_address)
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  if (this->set (port_number, inet_address) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("%p\n"),
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr")));
}

// Creates a ACE_INET_Addr from a PORT_NAME and the remote
// HOST_NAME.

ACE_INET_Addr::ACE_INET_Addr (const char port_name[],
                              const char host_name[],
                              const char protocol[])
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  if (this->set (port_name,
                 host_name,
                 protocol) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr")));
}

#if defined (ACE_HAS_WCHAR)
ACE_INET_Addr::ACE_INET_Addr (const wchar_t port_name[],
                              const wchar_t host_name[],
                              const wchar_t protocol[])
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  if (this->set (port_name,
                 host_name,
                 protocol) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr")));
}
#endif /* ACE_HAS_WCHAR */

// Creates a ACE_INET_Addr from a PORT_NAME and an Internet address.

ACE_INET_Addr::ACE_INET_Addr (const char port_name[],
                              ACE_UINT32 inet_address,
                              const char protocol[])
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  if (this->set (port_name,
                 ACE_HTONL (inet_address),
                 protocol) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr")));
}

#if defined (ACE_HAS_WCHAR)
ACE_INET_Addr::ACE_INET_Addr (const wchar_t port_name[],
                              ACE_UINT32 inet_address,
                              const wchar_t protocol[])
  : ACE_Addr (determine_type (), sizeof (inet_addr_))
{
  ACE_TRACE ("ACE_INET_Addr::ACE_INET_Addr");
  if (this->set (port_name,
                 ACE_HTONL (inet_address),
                 protocol) == -1)
    ACELIB_ERROR ((LM_ERROR,
                ACE_TEXT ("ACE_INET_Addr::ACE_INET_Addr")));
}
#endif /* ACE_HAS_WCHAR */

ACE_INET_Addr::~ACE_INET_Addr (void)
{
}

int
ACE_INET_Addr::get_host_name (char hostname[],
                              size_t len) const
{
  ACE_TRACE ("ACE_INET_Addr::get_host_name");

  int result;
  if (len > 1)
    {
      result = this->get_host_name_i (hostname,len);
      if (result < 0)
        {
          if (result == -2)
            // We know that hostname is nul-terminated
            result = -1;
          else
            {
              //result == -1;
              // This could be worse than hostname[len -1] = '\0'?
              hostname[0] = '\0';
            }
        }
    }
  else
    {
      if (len == 1)
        hostname[0] = '\0';
      result = -1;
    }

  return result;
}

#if defined (ACE_HAS_WCHAR)
int
ACE_INET_Addr::get_host_name (wchar_t hostname[],
                              size_t len) const
{
  ACE_TRACE ("ACE_INET_Addr::get_host_name");

  char char_hostname [MAXHOSTNAMELEN + 1];

  // We have a build in limitation of MAXHOSTNAMELEN
  if (len > MAXHOSTNAMELEN + 1)
    len = MAXHOSTNAMELEN + 1;

  // Call the char version
  int result = this->get_host_name (char_hostname, len);

  // And copy it over, if successful
  if (result == 0)
    ACE_OS::strcpy (hostname,
                    ACE_Ascii_To_Wide (char_hostname).wchar_rep ());

  return result;
}
#endif /* ACE_HAS_WCHAR */

// Return the character representation of the hostname.

const char *
ACE_INET_Addr::get_host_name (void) const
{
  ACE_TRACE ("ACE_INET_Addr::get_host_name");

  static char name[MAXHOSTNAMELEN + 1];
  if (this->get_host_name (name, MAXHOSTNAMELEN + 1) == -1)
    ACE_OS::strcpy (name, "<unknown>");
  return name;
}

void
ACE_INET_Addr::set_port_number (u_short port_number,
                                int encode)
{
  ACE_TRACE ("ACE_INET_Addr::set_port_number");

  if (encode)
    port_number = ACE_HTONS (port_number);

#if defined (ACE_HAS_IPV6)
  if (this->get_type () == AF_INET6)
    this->inet_addr_.in6_.sin6_port = port_number;
  else
#endif /* ACE_HAS_IPV6 */
    this->inet_addr_.in4_.sin_port = port_number;

  if (this->inet_addrs_.empty ())
    return;
  for (std::vector<union ip46>::iterator i = this->inet_addrs_.begin ();
       i != this->inet_addrs_.end ();
       i++)
    {
#if defined (ACE_HAS_IPV6)
      if (this->get_type () == AF_INET6)
        i->in6_.sin6_port = port_number;
      else
#endif /* ACE_HAS_IPV6 */
        i->in4_.sin_port = port_number;
    }
}

// returns -2 when the hostname is truncated
int
ACE_INET_Addr::get_host_name_i (char hostname[], size_t len) const
{
  ACE_TRACE ("ACE_INET_Addr::get_host_name_i");

#if defined (ACE_HAS_IPV6)
  if ((this->get_type () == PF_INET6 &&
       0 == ACE_OS::memcmp (&this->inet_addr_.in6_.sin6_addr,
                            &in6addr_any,
                            sizeof (this->inet_addr_.in6_.sin6_addr)))
      ||
      (this->get_type () == PF_INET &&
       this->inet_addr_.in4_.sin_addr.s_addr == INADDR_ANY))
#else
  if (this->inet_addr_.in4_.sin_addr.s_addr == INADDR_ANY)
#endif /* ACE_HAS_IPV6 */
    return (ACE_OS::hostname (hostname, len) == -1) ? -1 : 0;

  const ACE_SOCKET_LEN addr_size =
#ifdef ACE_HAS_IPV6
    (this->get_type () == PF_INET6) ? sizeof (sockaddr_in6) :
#endif
    sizeof (sockaddr_in);

  const int res = ACE_OS::getnameinfo ((const sockaddr *) this->get_addr (),
                                       addr_size, hostname,
                                       static_cast<ACE_SOCKET_LEN> (len),
                                       0, 0, 0);
  return (res == 0) ? 0 : -1;
}

int ACE_INET_Addr::set_address (const char *ip_addr,
                                int len,
                                int encode /* = 1 */,
                                int map /* = 0 */)
{
  ACE_TRACE ("ACE_INET_Addr::set_address");
  // This is really intended for IPv4. If the object is IPv4, or the type
  // hasn't been set but it's a 4-byte address, go ahead. If this is an
  // IPv6 object and <encode> is requested, refuse.
  if (encode && len != 4)
    {
      errno = EAFNOSUPPORT;
      return -1;
    }

  if (len == 4)
    {
      ACE_UINT32 ip4 = *reinterpret_cast<const ACE_UINT32 *> (ip_addr);
      if (encode)
        ip4 = ACE_HTONL (ip4);


      if (this->get_type () == AF_INET && map == 0) {
        this->base_set (AF_INET, sizeof (this->inet_addr_.in4_));
#ifdef ACE_HAS_SOCKADDR_IN_SIN_LEN
        this->inet_addr_.in4_.sin_len = sizeof (this->inet_addr_.in4_);
#endif
        this->inet_addr_.in4_.sin_family = AF_INET;
        this->set_size (sizeof (this->inet_addr_.in4_));
        ACE_OS::memcpy (&this->inet_addr_.in4_.sin_addr,
                        &ip4,
                        len);
      }
#if defined (ACE_HAS_IPV6)
      else if (map == 0)
        {
          // this->set_type (AF_INET);
          this->base_set (AF_INET, sizeof (this->inet_addr_.in4_));
#ifdef ACE_HAS_SOCKADDR_IN_SIN_LEN
          this->inet_addr_.in4_.sin_len = sizeof (this->inet_addr_.in4_);
#endif
          this->inet_addr_.in4_.sin_family = AF_INET;
          this->set_size (sizeof (this->inet_addr_.in4_));
          ACE_OS::memcpy (&this->inet_addr_.in4_.sin_addr,
                          &ip4, len);
        }
      // If given an IPv4 address to copy to an IPv6 object, map it to
      // an IPv4-mapped IPv6 address.
      else
        {
          this->base_set (AF_INET6, sizeof (this->inet_addr_.in6_));
#ifdef ACE_HAS_SOCKADDR_IN6_SIN6_LEN
          this->inet_addr_.in6_.sin6_len = sizeof (this->inet_addr_.in6_);
#endif
          this->inet_addr_.in6_.sin6_family = AF_INET6;
          this->set_size (sizeof (this->inet_addr_.in6_));
          if (ip4 == ACE_HTONL (INADDR_ANY))
            {
              in6_addr const ip6 = in6addr_any;
              ACE_OS::memcpy (&this->inet_addr_.in6_.sin6_addr,
                              &ip6,
                              sizeof (ip6));
              return 0;
            }
          else
            {
              // Build up a 128 bit address.  An IPv4-mapped IPv6 address
              // is defined as 0:0:0:0:0:ffff:IPv4_address.  This is defined
              // in RFC 1884 */
              ACE_OS::memset (&this->inet_addr_.in6_.sin6_addr, 0, 16);
              this->inet_addr_.in6_.sin6_addr.s6_addr[10] =
                this->inet_addr_.in6_.sin6_addr.s6_addr[11] = 0xff;
              ACE_OS::memcpy
                (&this->inet_addr_.in6_.sin6_addr.s6_addr[12], &ip4, 4);
            }
        }
#endif /* ACE_HAS_IPV6 */

      return 0;
    }   /* end if (len == 4) */
#if defined (ACE_HAS_IPV6)
  else if (len == 16)
    {
      if (this->get_type () != PF_INET6)
        {
          errno = EAFNOSUPPORT;
          return -1;
        }
      // We protect ourselves up above so IPv6 must be possible here.
      this->base_set (AF_INET6, sizeof (this->inet_addr_.in6_));
      this->inet_addr_.in6_.sin6_family = AF_INET6;
#ifdef ACE_HAS_SOCKADDR_IN6_SIN6_LEN
      this->inet_addr_.in6_.sin6_len = sizeof (this->inet_addr_.in6_);
#endif
      ACE_OS::memcpy (&this->inet_addr_.in6_.sin6_addr, ip_addr, len);
      return 0;
    } /* end len == 16 */
#endif /* ACE_HAS_IPV6 */

  // Here with an unrecognized length.
  errno = EAFNOSUPPORT;
  return -1;

}

#if (defined (ACE_LINUX) || defined (ACE_WIN32)) && defined (ACE_HAS_IPV6)
int
ACE_INET_Addr::set_interface (const char *intf_name)
{
  if (this->get_type () == PF_INET6 &&
      (IN6_IS_ADDR_LINKLOCAL (&this->inet_addr_.in6_.sin6_addr) ||
       IN6_IS_ADDR_MC_LINKLOCAL (&this->inet_addr_.in6_.sin6_addr)))
    {
#if defined (ACE_LINUX)
      this->inet_addr_.in6_.sin6_scope_id =
        ACE_OS::if_nametoindex (intf_name);
#else
      this->inet_addr_.in6_.sin6_scope_id =
        intf_name ? ACE_OS::atoi (intf_name) : 0;
#endif
      // check to see if the interface lookup succeeded
      if (this->inet_addr_.in6_.sin6_scope_id != 0)
        return 0;
      else
        return -1;
    }
  else
    return 0;

}
#endif /* ACE_LINUX && ACE_HAS_IPV6 */

const char *
ACE_INET_Addr::get_host_addr (char *dst, int size) const
{
#if defined (ACE_HAS_IPV6)
  if (this->get_type () == AF_INET6)
    {
      // mcorino@remedy.nl - Aug-26, 2005
      // I don't think this should be done because it results in a decimal address
      // representation which is not distinguishable from the IPv4 form which makes
      // it impossible to resolve back to an IPv6 INET_Addr without prior knowledge
      // that this was such an address to begin with.

      //if (IN6_IS_ADDR_V4MAPPED (&this->inet_addr_.in6_.sin6_addr))
      //{
      //  ACE_UINT32 addr;
      //  addr = this->get_ip_address();
      //  addr = ACE_HTONL (addr);
      //  return ACE_OS::inet_ntop (AF_INET, &addr, dst, size);
      //}

#  if defined (ACE_WIN32)
      sockaddr *sa = reinterpret_cast<sockaddr *>
                       (const_cast<sockaddr_in6 *> (&this->inet_addr_.in6_));
      if (ACE_OS::getnameinfo (sa, this->get_size (), dst, size,
                               0, 0,    // Don't want service name
                               NI_NUMERICHOST) == 0)
        return dst;
      ACE_OS::set_errno_to_wsa_last_error ();
      return 0;
#  else
      const char *ch = ACE_OS::inet_ntop (AF_INET6,
                                          &this->inet_addr_.in6_.sin6_addr,
                                          dst,
                                          size);
#if defined (ACE_LINUX)
      if ((IN6_IS_ADDR_LINKLOCAL (&this->inet_addr_.in6_.sin6_addr) ||
           IN6_IS_ADDR_MC_LINKLOCAL (&this->inet_addr_.in6_.sin6_addr)) &&
          this->inet_addr_.in6_.sin6_scope_id != 0)
        {
          char scope_buf[32];
          ACE_OS::snprintf (scope_buf, 32, "%%%u",
                            this->inet_addr_.in6_.sin6_scope_id);
          if ((ACE_OS::strlen (ch)+ACE_OS::strlen (scope_buf)) < (size_t)size)
            {
              ACE_OS::strcat (dst, scope_buf);
            }
        }
#endif
      return ch;
#  endif /* ACE_WIN32 */
    }
#endif /* ACE_HAS_IPV6 */

  return ACE_OS::inet_ntop (AF_INET,
          &this->inet_addr_.in4_.sin_addr,
          dst,
          size);
}

// Return the dotted Internet address.
const char *
ACE_INET_Addr::get_host_addr (void) const
{
  ACE_TRACE ("ACE_INET_Addr::get_host_addr");
#if defined (ACE_HAS_IPV6)
  static char buf[INET6_ADDRSTRLEN];
  return this->get_host_addr (buf, INET6_ADDRSTRLEN);
#else /* ACE_HAS_IPV6 */
  static char buf[INET_ADDRSTRLEN];
  return this->get_host_addr (buf, INET_ADDRSTRLEN);
#endif /* !ACE_HAS_IPV6 */
}

// Return the 4-byte IP address, converting it into host byte order.
ACE_UINT32
ACE_INET_Addr::get_ip_address (void) const
{
  ACE_TRACE ("ACE_INET_Addr::get_ip_address");
#if defined (ACE_HAS_IPV6)
  if (this->get_type () == AF_INET6)
    {
      if (IN6_IS_ADDR_V4MAPPED (&this->inet_addr_.in6_.sin6_addr) ||
          IN6_IS_ADDR_V4COMPAT (&this->inet_addr_.in6_.sin6_addr)    )
        {
          ACE_UINT32 addr;
          // Return the last 32 bits of the address
          char *thisaddrptr = (char*)this->ip_addr_pointer ();
          thisaddrptr += 128/8 - 32/8;
          ACE_OS::memcpy (&addr, thisaddrptr, sizeof (addr));
          return ACE_NTOHL (addr);
        }

      ACELIB_ERROR ((LM_ERROR,
                  ACE_TEXT ("ACE_INET_Addr::get_ip_address: address is a IPv6 address not IPv4\n")));
      errno = EAFNOSUPPORT;
      return 0;
    }
#endif /* ACE_HAS_IPV6 */
  return ACE_NTOHL (ACE_UINT32 (this->inet_addr_.in4_.sin_addr.s_addr));
}

ACE_END_VERSIONED_NAMESPACE_DECL
