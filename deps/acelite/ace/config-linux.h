// -*- C++ -*-
// The following configuration file is designed to work for Linux
// platforms using GNU C++.

#ifndef ACE_CONFIG_LINUX_H
#define ACE_CONFIG_LINUX_H
#include /**/ "ace/pre.h"

#if !defined (ACE_LINUX)
#define ACE_LINUX
#endif /* ACE_LINUX */

#if !defined (__ACE_INLINE__)
#  define __ACE_INLINE__
#endif /* ! __ACE_INLINE__ */

#if !defined (ACE_PLATFORM_CONFIG)
#define ACE_PLATFORM_CONFIG config-linux.h
#endif

#include "ace/config-linux-common.h"

#define ACE_HAS_BYTESEX_H

#if (defined _XOPEN_SOURCE && (_XOPEN_SOURCE - 0) >= 500)
#  define ACE_HAS_PTHREADS_UNIX98_EXT
#endif /* _XOPEN_SOURCE - 0 >= 500 */

#if !defined (ACE_LACKS_LINUX_NPTL)

  // Temporary fix because NPTL kernels do have shm_open but there is a problem
  // with shm_open/shm_unlink pairing in ACE which needs to be fixed when I have time.
# if defined (ACE_HAS_SHM_OPEN)
#   undef ACE_HAS_SHM_OPEN
# endif /* ACE_HAS_SHM_OPEN */

# if defined (ACE_USES_FIFO_SEM)
    // Don't use this for Linux NPTL since this has complete
    // POSIX semaphores which are more efficient
#   undef ACE_USES_FIFO_SEM
# endif /* ACE_USES_FIFO_SEM */

# if defined (ACE_HAS_POSIX_SEM)
    // Linux NPTL may not define the right POSIX macro
    // but they have the actual runtime support for this stuff
#   if !defined (ACE_HAS_POSIX_SEM_TIMEOUT) && (((_POSIX_C_SOURCE - 0) >= 200112L) || (_XOPEN_SOURCE >= 600))
#     define ACE_HAS_POSIX_SEM_TIMEOUT
#   endif /* !ACE_HAS_POSIX_SEM_TIMEOUT && (((_POSIX_C_SOURCE - 0) >= 200112L) || (_XOPEN_SOURCE >= 600)) */
# endif /* ACE_HAS_POSIX_SEM */
#endif /* !ACE_LACKS_LINUX_NPTL */

// AIO support pulls in the rt library, which pulls in the pthread
// library.  Disable AIO in single-threaded builds.
#if defined (ACE_HAS_THREADS)
#  define ACE_HAS_CLOCK_GETTIME
#  define ACE_HAS_CLOCK_SETTIME
#else
#  undef ACE_HAS_AIO_CALLS
#endif

// Then glibc/libc5 specific parts

#if defined(__GLIBC__) || defined (__INTEL_COMPILER)
# if !defined (__INTEL_COMPILER) && \
     (__GLIBC__  < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 3)
#   define ACE_HAS_RUSAGE_WHO_ENUM enum __rusage_who
#   define ACE_HAS_RLIMIT_RESOURCE_ENUM enum __rlimit_resource
#   define ACE_LACKS_ISCTYPE
# endif
# define ACE_HAS_SOCKLEN_T
# define ACE_HAS_4_4BSD_SENDMSG_RECVMSG

  // glibc defines both of these, used in OS_String.
# if defined (_GNU_SOURCE)
#   define ACE_HAS_STRNLEN
#   define ACE_HAS_WCSNLEN

  // This is probably not a 100%-sure-fire check... Red Hat Linux 9
  // and Enterprise Linux 3 and up have a new kernel that can send signals
  // across threads. This was not possible prior because there was no real
  // difference between a process and a thread. With this, the
  // ACE_POSIX_SIG_Proactor is the only chance of getting asynch I/O working.
  // There are restrictions, such as all socket operations being silently
  // converted to synchronous by the kernel, that make aio a non-starter
  // for most Linux platforms at this time. But we'll start to crawl...
#   define ACE_POSIX_SIG_PROACTOR
# endif

  // To avoid the strangeness with Linux's ::select (), which modifies
  // its timeout argument, use ::poll () instead.
# define ACE_HAS_POLL

# define ACE_HAS_SIGINFO_T
# define ACE_LACKS_SIGINFO_H
# define ACE_HAS_UCONTEXT_T
# define ACE_HAS_SIGTIMEDWAIT
# define ACE_HAS_STRERROR_R

#else  /* ! __GLIBC__ */
    // Fixes a problem with some non-glibc versions of Linux...
#   define ACE_LACKS_MADVISE
#   define ACE_LACKS_MSG_ACCRIGHTS
#endif /* ! __GLIBC__ */

// Completely common part :-)

#define ACE_HAS_UALARM

#if (__GLIBC__ < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 10)
// Although the scandir man page says otherwise, this setting is correct.
// The setting was fixed in 2.10, so do not use the hack after that.
#  define ACE_SCANDIR_CMP_USES_CONST_VOIDPTR
#endif

// A conflict appears when including both <ucontext.h> and
// <sys/procfs.h> with recent glibc headers.
//#define ACE_HAS_PROC_FS

// Platform supports System V IPC (most versions of UNIX, but not Win32)
#define ACE_HAS_SYSV_IPC

// Compiler/platform defines a union semun for SysV shared memory.
#define ACE_HAS_SEMUN

#if defined (__powerpc__) && !defined (ACE_SIZEOF_LONG_DOUBLE)
// 32bit PowerPC Linux uses 128bit long double
# define ACE_SIZEOF_LONG_DOUBLE 16
#endif

#define ACE_LACKS_GETIPNODEBYADDR
#define ACE_LACKS_GETIPNODEBYNAME

#define ACE_HAS_ICMP_SUPPORT 1

#if defined (ACE_LACKS_NETWORKING)
# include "ace/config-posix-nonetworking.h"
#else
# define ACE_HAS_NETLINK
# define ACE_HAS_GETIFADDRS
#endif

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,8))
# define ACE_HAS_SCHED_GETAFFINITY 1
# define ACE_HAS_SCHED_SETAFFINITY 1
#endif

// This is ghastly, but as long as there are platforms supported
// which define the right POSIX macros but lack actual support
// we have no choice.
// RHEL4 fails (2.6.9) while RHEL5 works (2.6.18)
#if !defined (ACE_LACKS_CONDATTR_SETCLOCK)
# if (LINUX_VERSION_CODE < KERNEL_VERSION (2,6,18))
#  define ACE_LACKS_CONDATTR_SETCLOCK
# endif
#endif

#define ACE_HAS_MNTENT

// To support UCLIBC
#if defined (__UCLIBC__)

#  define ACE_LACKS_STROPTS_H
#  define ACE_LACKS_GETLOADAVG
#  define ACE_LACKS_NETDB_REENTRANT_FUNCTIONS
#  define ACE_LACKS_PTHREAD_SETSTACK
#  define ACE_LACKS_STRRECVFD
#  define ACE_HAS_CPU_SET_T

#  if defined (ACE_HAS_STRBUF_T)
#    undef ACE_HAS_STRBUF_T
#  endif /* ACE_HAS_STRBUF_T */

#  if defined (ACE_HAS_PTHREAD_SETSTACK)
#    undef ACE_HAS_PTHREAD_SETSTACK
#  endif /* ACE_HAS_PTHREAD_SETSTACK */

#  if defined (ACE_HAS_AIO_CALLS)
#    undef ACE_HAS_AIO_CALLS
#  endif /* ACE_HAS_AIO_CALLS */

#  if defined (ACE_HAS_GETIFADDRS)
#    undef ACE_HAS_GETIFADDRS
#  endif /* ACE_HAS_GETIFADDRS */

#  if defined (ACE_SCANDIR_CMP_USES_VOIDPTR)
#    undef ACE_SCANDIR_CMP_USES_VOIDPTR
#  endif /* ACE_SCANDIR_CMP_USES_VOIDPTR */

#  if defined (ACE_SCANDIR_CMP_USES_CONST_VOIDPTR)
#    undef ACE_SCANDIR_CMP_USES_CONST_VOIDPTR
#  endif /* ACE_SCANDIR_CMP_USES_CONST_VOIDPTR */

#  if defined (ACE_HAS_EXECINFO_H)
#    undef ACE_HAS_EXECINFO_H
#  endif /* ACE_HAS_EXECINFO_H */

#  if defined(__GLIBC__)
#    undef __GLIBC__
#  endif /* __GLIBC__ */

#  if defined(ACE_HAS_SEMUN)
#    undef ACE_HAS_SEMUN
#  endif /* ACE_HAS_SEMUN */

#endif /* __UCLIBC__ */

#include /**/ "ace/post.h"

#endif /* ACE_CONFIG_LINUX_H */
