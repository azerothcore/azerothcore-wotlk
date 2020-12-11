// ACE configuration for building on top of the FACE Conformance Test Suite's
// safety base replacement headers for libc and libstdc++.

#ifndef ACE_MT_SAFE
#define ACE_MT_SAFE 1
#endif

#define ACE_EMULATE_POSIX_DEVCTL 0
#define ACE_HOSTENT_H_ADDR h_addr_list[0]
#define ACE_PAGE_SIZE 4096
#define ACE_SIZEOF_FLOAT 4
#define ACE_SIZEOF_DOUBLE 8
#define ACE_SIZEOF_LONG_DOUBLE 16
#define ACE_SIZEOF_LONG 8
#define ACE_SIZEOF_LONG_LONG 8
#define ACE_THREAD_T_IS_A_STRUCT
#define ACE_DEFAULT_SEM_KEY {}

#define ACE_HAS_3_PARAM_READDIR_R
#define ACE_HAS_CLOCK_GETTIME
#define ACE_HAS_CONSISTENT_SIGNAL_PROTOTYPES
#define ACE_HAS_DIRENT
#define ACE_HAS_IPPORT_RESERVED
#define ACE_HAS_MSG
#define ACE_HAS_POSIX_TIME
#define ACE_HAS_POSIX_NONBLOCK
#define ACE_HAS_PTHREAD_SIGMASK_PROTOTYPE
#define ACE_HAS_PTHREADS
#define ACE_HAS_OPAQUE_PTHREAD_T
#define ACE_HAS_REENTRANT_FUNCTIONS
#define ACE_HAS_SIGINFO_T
#define ACE_HAS_SIGWAIT
#define ACE_HAS_STRBUF_T
#define ACE_HAS_STRERROR_R
#define ACE_HAS_STRERROR_R_XSI
#define ACE_HAS_THREAD_SPECIFIC_STORAGE
#define ACE_HAS_THREADS 1
#define ACE_HAS_UCONTEXT_T

#define ACE_LACKS_BSD_TYPES
#define ACE_LACKS_CADDR_T
#define ACE_LACKS_IFCONF
#define ACE_LACKS_IFREQ
#define ACE_LACKS_IP_MREQ
#define ACE_LACKS_ISCTYPE
#define ACE_LACKS_MEMORY_H
#define ACE_LACKS_SELECT // safetyBase headers are missing select()
#define ACE_LACKS_SETENV
#define ACE_LACKS_SIGINFO_H
#define ACE_LACKS_SYS_IOCTL_H
#define ACE_LACKS_SYS_PARAM_H
#define ACE_LACKS_SYS_SYSCTL_H
#define ACE_LACKS_TIMESPEC_T
#define ACE_LACKS_UCONTEXT_H
#define ACE_LACKS_UNSETENV
#define ACE_LACKS_USECONDS_T

#define ACE_HAS_NEW_THROW_SPEC

#ifndef stdin
# define stdin 0
#endif

#ifndef stderr
# define stderr 0
#endif

#ifndef stdout
# define stdout 0
#endif

#define NSIG 32

#define NFDBITS 64
#define FD_ZERO(x)
#define FD_SET(x, y)
#define FD_CLR(x, y)
#define FD_ISSET(x ,y) 0
#define ACE_FDS_BITS __0
typedef long fd_mask;

#define FIONBIO 0x5421

typedef unsigned long uintptr_t;

#define __FACE_CONFORM____PTRDIFF_T__
typedef long ptrdiff_t;

#define __FACE_CONFORM____INTPTR_T__
typedef long intptr_t;

#include "ace/config-posix.h"
#include "ace/config-g++-common.h"
