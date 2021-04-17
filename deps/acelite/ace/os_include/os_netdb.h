// -*- C++ -*-

//=============================================================================
/**
 *  @file    os_netdb.h
 *
 *  definitions for network database operations
 *
 *  @author Don Hinton <dhinton@dresystems.com>
 *  @author This code was originally in various places including ace/OS.h.
 */
//=============================================================================

#ifndef ACE_OS_INCLUDE_OS_NETDB_H
#define ACE_OS_INCLUDE_OS_NETDB_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/netinet/os_in.h"
#include "ace/os_include/os_limits.h"
#include "ace/os_include/sys/os_socket.h"

// Place all additions (especially function declarations) within extern "C" {}
#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

#if !defined (ACE_LACKS_NETDB_H)
#  include /**/ <netdb.h>
#endif /* !ACE_LACKS_NETDB_H */

#if defined (ACE_LACKS_HOSTENT)
struct  hostent {
        char    *h_name;        /* official name of host */
        char    **h_aliases;    /* alias list */
        int     h_addrtype;     /* host address type */
        int     h_length;       /* length of address */
        char    **h_addr_list;  /* list of addresses from name server */
#define h_addr  h_addr_list[0]  /* address, for backward compatibility */
};
#endif /* ACE_LACKS_HOSTENT */

#if defined (ACE_LACKS_PROTOENT)
struct  protoent {
        char    *p_name;        /* official protocol name */
        char    **p_aliases;    /* alias list */
        int     p_proto;        /* protocol # */
};
#endif /* ACE_LACKS_PROTOENT */

#if defined (ACE_LACKS_SERVENT)
struct  servent {
        char    *s_name;        /* official service name */
        char    **s_aliases;    /* alias list */
        int     s_port;         /* port # */
        char    *s_proto;       /* protocol to use */
};
#endif /* ACE_LACKS_SERVENT */

#ifdef ACE_LACKS_ADDRINFO
  struct addrinfo {
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    ACE_SOCKET_LEN ai_addrlen;
    sockaddr *ai_addr;
    char *ai_canonname;
    addrinfo *ai_next;
  };
#endif

#ifndef AI_V4MAPPED
# define AI_V4MAPPED 0x8
#endif

#ifndef AI_ADDRCONFIG
# define AI_ADDRCONFIG 0x20
#endif

#ifndef EAI_NONAME
# define EAI_NONAME -2 /* Error result from getaddrinfo(): no addr for name */
#endif

#ifndef EAI_AGAIN
# define EAI_AGAIN -3 /* Error result from getaddrinfo(): try again later */
#endif

#ifndef EAI_FAIL
# define EAI_FAIL -4 /* Error result from getaddrinfo(): non-recoverable */
#endif

#ifndef EAI_FAMILY
# define EAI_FAMILY -6 /* Error result from getaddrinfo(): family not supp. */
#endif

#ifndef EAI_MEMORY
# define EAI_MEMORY -10 /* Error result from getaddrinfo(): out of memory */
#endif

#ifndef EAI_SYSTEM
# define EAI_SYSTEM -11 /* Error result from getaddrinfo(): see errno */
#endif

#ifndef EAI_OVERFLOW
# define EAI_OVERFLOW -12 /* Error result from getaddrinfo(): buffer overflow */
#endif

#if defined (ACE_HAS_STRUCT_NETDB_DATA)
   typedef char ACE_HOSTENT_DATA[sizeof(struct hostent_data)];
   typedef char ACE_SERVENT_DATA[sizeof(struct servent_data)];
   typedef char ACE_PROTOENT_DATA[sizeof(struct protoent_data)];
#else
#  if !defined ACE_HOSTENT_DATA_SIZE
#    define ACE_HOSTENT_DATA_SIZE (4*1024)
#  endif /*ACE_HOSTENT_DATA_SIZE */
#  if !defined ACE_SERVENT_DATA_SIZE
#    define ACE_SERVENT_DATA_SIZE (4*1024)
#  endif /*ACE_SERVENT_DATA_SIZE */
#  if !defined ACE_PROTOENT_DATA_SIZE
#    define ACE_PROTOENT_DATA_SIZE (2*1024)
#  endif /*ACE_PROTOENT_DATA_SIZE */
   typedef char ACE_HOSTENT_DATA[ACE_HOSTENT_DATA_SIZE];
   typedef char ACE_SERVENT_DATA[ACE_SERVENT_DATA_SIZE];
   typedef char ACE_PROTOENT_DATA[ACE_PROTOENT_DATA_SIZE];
#endif /* ACE_HAS_STRUCT_NETDB_DATA */

# if !defined(MAXHOSTNAMELEN)
#   define MAXHOSTNAMELEN  HOST_NAME_MAX
# endif /* MAXHOSTNAMELEN */

#ifdef __cplusplus
}
#endif /* __cplusplus */

#include /**/ "ace/post.h"
#endif /* ACE_OS_INCLUDE_OS_NETDB_H */
