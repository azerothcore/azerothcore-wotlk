/**
 * Common configuration for platforms using the Linux Kernel, specifically
 * ACE_LINUX and ACE_ANDROID as of writing. config-android.h was originally
 * based off config-linux.h and this file was created from the common parts of
 * both.
 */
#ifndef ACE_CONFIG_LINUX_COMMON_H
#define ACE_CONFIG_LINUX_COMMON_H

#if !defined (ACE_MT_SAFE)
#  define ACE_MT_SAFE 1
#endif

// Compiler supports the ssize_t typedef.
#define ACE_HAS_SSIZE_T

// Needed to differentiate between libc 5 and libc 6 (aka glibc).
#include <features.h>

#include "ace/config-posix.h"

#ifndef ACE_DEFAULT_BASE_ADDR
#  if defined (__powerpc__) || defined (__x86_64__)
#    define ACE_DEFAULT_BASE_ADDR (reinterpret_cast< char* >(0x40000000))
#  elif defined (__ia64)
// Zero base address should work fine for Linux of IA-64: it just lets
// the kernel to choose the right value.
#    define ACE_DEFAULT_BASE_ADDR (reinterpret_cast< char*>(0x0000000000000000))
#  else
#    define ACE_DEFAULT_BASE_ADDR (reinterpret_cast< char* >(0x80000000))
#  endif
#endif /* ! ACE_DEFAULT_BASE_ADDR */

#define ACE_HAS_LSEEK64

#define ACE_HAS_P_READ_WRITE
// Use ACE's alternate cuserid() implementation since the use of the
// system cuserid() is discouraged.
#define ACE_HAS_ALT_CUSERID

#if (__GLIBC__  > 2)  || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 3)
#  define ACE_HAS_ISASTREAM_PROTOTYPE
#  define ACE_HAS_PTHREAD_SIGMASK_PROTOTYPE
#  define ACE_HAS_CPU_SET_T
#  define ACE_HAS_GLIBC_2_2_3
#endif /* __GLIBC__ > 2 || __GLIBC__ === 2 && __GLIBC_MINOR__ >= 3) */

#if (__GLIBC__  > 2)  || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30)
#  define ACE_LACKS_SYS_SYSCTL_H
#endif /* __GLIBC__ > 2 || __GLIBC__ === 2 && __GLIBC_MINOR__ >= 30) */

#if defined (__INTEL_COMPILER)
#  include "ace/config-icc-common.h"
#elif defined (__GNUG__)
  // config-g++-common.h undef's ACE_HAS_STRING_CLASS with -frepo, so
  // this must appear before its #include.
#  define ACE_HAS_STRING_CLASS
#  include "ace/config-g++-common.h"
#elif defined (__SUNCC_PRO) || defined (__SUNPRO_CC)
#  include "ace/config-suncc-common.h"
#elif defined (__PGI)
// Portable group compiler
#  define ACE_HAS_CPLUSPLUS_HEADERS
#  define ACE_HAS_STDCPP_STL_INCLUDES
#  define ACE_HAS_STANDARD_CPP_LIBRARY 1
#  define ACE_USES_STD_NAMESPACE_FOR_STDCPP_LIB 1
#  define ACE_LACKS_SWAB
#elif defined (__GNUC__)
/**
 * GNU C compiler.
 *
 * We need to recognize the GNU C compiler since TAO has at least one
 * C source header and file
 * (TAO/orbsvcs/orbsvcs/SSLIOP/params_dup.{h,c}) that may indirectly
 * include this
 */
#else  /* ! __GNUG__ && !__DECCXX && !__INTEL_COMPILER && && !__PGI */
#  ifdef __cplusplus  /* Let it slide for C compilers. */
#    error unsupported compiler in ace/config-linux.h
#  endif  /* __cplusplus */
#endif /* ! __GNUG__*/

// Platform/compiler has the sigwait(2) prototype
#define ACE_HAS_SIGWAIT

#define ACE_HAS_SIGSUSPEND

#define ACE_HAS_STRSIGNAL

#ifndef ACE_HAS_POSIX_REALTIME_SIGNALS
# define ACE_HAS_POSIX_REALTIME_SIGNALS
#endif /* ACE_HAS_POSIX_REALTIME_SIGNALS */

#define ACE_HAS_XPG4_MULTIBYTE_CHAR
#define ACE_HAS_VFWPRINTF

#define ACE_LACKS_ITOW
#define ACE_LACKS_WCSICMP
#define ACE_LACKS_WCSNICMP
#define ACE_LACKS_ISWASCII

#define ACE_HAS_3_PARAM_WCSTOK

#define ACE_HAS_3_PARAM_READDIR_R

#define ACE_HAS_ALLOCA

// Compiler/platform has <alloca.h>
#define ACE_HAS_ALLOCA_H
#define ACE_HAS_SYS_SYSINFO_H
#define ACE_HAS_LINUX_SYSINFO

// Compiler/platform has the getrusage() system call.
#define ACE_HAS_GETRUSAGE
#define ACE_HAS_GETRUSAGE_PROTOTYPE

#define ACE_HAS_BYTESWAP_H
#define ACE_HAS_BSWAP_16
#define ACE_HAS_BSWAP_32

#if defined (__GNUC__)
#  define ACE_HAS_BSWAP_64
#endif

#define ACE_HAS_CONSISTENT_SIGNAL_PROTOTYPES

// Optimize ACE_Handle_Set for select().
#define ACE_HAS_HANDLE_SET_OPTIMIZED_FOR_SELECT

// ONLY define this if you have config'd multicast into a 2.0.34 or
// prior kernel.  It is enabled by default in 2.0.35 kernels.
#if !defined (ACE_HAS_IP_MULTICAST)
#  define ACE_HAS_IP_MULTICAST
#endif /* ! ACE_HAS_IP_MULTICAST */

// At least for IPv4, Linux lacks perfect filtering.
#if !defined ACE_LACKS_PERFECT_MULTICAST_FILTERING
#  define ACE_LACKS_PERFECT_MULTICAST_FILTERING 1
#endif /* ACE_LACKS_PERFECT_MULTICAST_FILTERING */

#define ACE_HAS_BIG_FD_SET

// Linux defines struct msghdr in /usr/include/socket.h
#define ACE_HAS_MSG

// Linux "improved" the interface to select() so that it modifies
// the struct timeval to reflect the amount of time not slept
// (see NOTES in Linux's select(2) man page).
#define ACE_HAS_NONCONST_SELECT_TIMEVAL

#define ACE_DEFAULT_MAX_SOCKET_BUFSIZ 65535

#define ACE_CDR_IMPLEMENT_WITH_NATIVE_DOUBLE 1

#define ACE_HAS_GETPAGESIZE 1

// Platform defines struct timespec but not timespec_t
#define ACE_LACKS_TIMESPEC_T

// Platform supplies scandir()
#define ACE_HAS_SCANDIR

// Compiler/platform contains the <sys/syscall.h> file.
#define ACE_HAS_SYS_SYSCALL_H

#define ACE_HAS_TIMEZONE
#define ACE_HAS_TIMEZONE_GETTIMEOFDAY

// Compiler/platform defines the sig_atomic_t typedef.
#define ACE_HAS_SIG_ATOMIC_T

#define ACE_HAS_POSIX_TIME

#define ACE_HAS_GPERF

#define ACE_HAS_DIRENT

// Starting with FC9 rawhide this file is not available anymore but
// this define is set
#if !defined(_XOPEN_STREAMS) || (defined _XOPEN_STREAMS && _XOPEN_STREAMS == -1)
#  define ACE_LACKS_STROPTS_H
#  define ACE_LACKS_STRRECVFD
#endif

#if !defined (ACE_LACKS_STROPTS_H)
#  define ACE_HAS_STRBUF_T
#endif

#if defined (__ia64) || defined(__alpha) || defined (__x86_64__) || defined(__powerpc64__) || (defined(__mips__) && defined(__LP64__)) || defined (__aarch64__)
// On 64 bit platforms, the "long" type is 64-bits.  Override the
// default 32-bit platform-specific format specifiers appropriately.
#  define ACE_UINT64_FORMAT_SPECIFIER_ASCII "%lu"
#  define ACE_SSIZE_T_FORMAT_SPECIFIER_ASCII "%ld"
#  define ACE_SIZE_T_FORMAT_SPECIFIER_ASCII "%lu"
#endif /* __ia64 */

#define ACE_SIZEOF_WCHAR 4

// Platform has POSIX terminal interface.
#define ACE_HAS_TERMIOS

// Linux implements sendfile().
#define ACE_HAS_SENDFILE 1

#define ACE_HAS_VOIDPTR_MMAP

#define ACE_HAS_VASPRINTF

#define ACE_LACKS_PTHREAD_SCOPE_PROCESS

// According to man pages Linux uses different (compared to UNIX systems) types
// for setting IP_MULTICAST_TTL and IPV6_MULTICAST_LOOP / IP_MULTICAST_LOOP
// in setsockopt/getsockopt.
// In the current (circa 2012) kernel source however there is an explicit check
// for IPV6_MULTICAST_LOOP being sizeof(int). Anything else is rejected so it must
// not be a passed a bool, irrespective of what the man pages (still) say.
// i.e. #define ACE_HAS_IPV6_MULTICAST_LOOP_AS_BOOL 1 is wrong
#define ACE_HAS_IP_MULTICAST_TTL_AS_INT 1
#define ACE_HAS_IP_MULTICAST_LOOP_AS_INT 1

#define ACE_HAS_SVR4_DYNAMIC_LINKING
#define ACE_HAS_AUTOMATIC_INIT_FINI
#define ACE_HAS_RECURSIVE_MUTEXES
#define ACE_HAS_THREAD_SPECIFIC_STORAGE
#define ACE_HAS_RECURSIVE_THR_EXIT_SEMANTICS
#define ACE_HAS_2_PARAM_ASCTIME_R_AND_CTIME_R
#define ACE_HAS_REENTRANT_FUNCTIONS

/* ===========================================================================
 * By Kernel API Version
 * ===========================================================================
 */

#if !defined (ACE_LACKS_LINUX_VERSION_H)
#  include <linux/version.h>
#endif /* !ACE_LACKS_LINUX_VERSION_H */

#if !defined (ACE_GETNAME_RETURNS_RANDOM_SIN_ZERO)
// Detect if getsockname() and getpeername() returns random values in
// the sockaddr_in::sin_zero field by evaluation of the kernel
// version. Since version 2.5.47 this problem is fixed.
#  if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,47))
#    define ACE_GETNAME_RETURNS_RANDOM_SIN_ZERO 0
#  else
#    define ACE_GETNAME_RETURNS_RANDOM_SIN_ZERO 1
#  endif  /* (LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,47)) */
#endif  /* ACE_GETNAME_RETURNS_RANDOM_SIN_ZERO */

#if !defined (ACE_HAS_EVENT_POLL) && !defined (ACE_HAS_DEV_POLL)
#  if (LINUX_VERSION_CODE > KERNEL_VERSION (2,6,0))
#    define ACE_HAS_EVENT_POLL
#  endif
#endif

#if (LINUX_VERSION_CODE >= KERNEL_VERSION (2,4,11))
#  define ACE_HAS_GETTID // See ACE_OS::thr_gettid()
#endif

#endif /* ACE_CONFIG_LINUX_COMMON_H */
