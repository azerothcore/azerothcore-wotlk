// -*- C++ -*-
//
// The following configuration file is designed to work for win32 and win64
// platforms using gcc/g++ with mingw64 (http://http://mingw-w64.sourceforge.net/).
//

#ifndef ACE_CONFIG_WIN32_MINGW64_H
#define ACE_CONFIG_WIN32_MINGW64_H
#include /**/ "ace/pre.h"

#ifndef ACE_CONFIG_WIN32_H
#  error Use config-win32.h in config.h instead of this header
#endif /* ACE_CONFIG_WIN32_H */

#define ACE_CC_PREPROCESSOR "cpp"
#define ACE_CC_PREPROCESOR_ARGS ""

#if !defined(__MINGW32__) || !defined (__MINGW64_VERSION_MAJOR)
#  error You do not seem to be using mingw64
#endif

#if defined (WIN64) || defined (__WIN64__)
# define ACE_SIZEOF_LONG_DOUBLE 16
#else
# define ACE_SIZEOF_LONG_DOUBLE 12
#endif

#include "ace/config-g++-common.h"

#include /**/ <_mingw.h>
#include /**/ <w32api.h>

#if defined (exception_info)
# undef exception_info
#endif

#define ACE_HAS_USER_MODE_MASKS

#if (!defined (__MINGW64_VERSION_MAJOR) || (__MINGW64_VERSION_MAJOR < 2))
# error You need a newer version (>= 2.0) of mingw32/w32api
#endif

#include <stdio.h>

#if defined (fileno)
# undef fileno
#endif
#if (__MINGW64_VERSION_MAJOR >= 3)
# define ACE_FILENO_EQUIVALENT ::_fileno

// Latest version of MingW64 (GCC 4.8.2) with Win32 threading
// defines a 'pthread_sigmask' macro when including signal.h.
// We have to remove that one since ACE declares a (non-functional)
// pthread_sigmask method in ACE_OS.
# include <signal.h>
# if defined (pthread_sigmask)
#   undef pthread_sigmask
# endif
#endif

#if (__MINGW64_VERSION_MAJOR >= 2)

# define ACE_HAS_SSIZE_T
# undef ACE_LACKS_STRUCT_DIR
# undef ACE_LACKS_OPENDIR
# undef ACE_LACKS_CLOSEDIR
# undef ACE_LACKS_READDIR
# undef ACE_LACKS_TELLDIR
# undef ACE_LACKS_SEEKDIR
# undef ACE_LACKS_REWINDDIR
# undef ACE_LACKS_USECONDS_T

# define ACE_HAS_POSIX_TIME 1
# define ACE_LACKS_TIMESPEC_T 1
# define ACE_HAS_NONCONST_SELECT_TIMEVAL 1

# if defined (ACE_HAS_QOS) && !defined (ACE_HAS_WINSOCK2_GQOS)
#   define ACE_HAS_WINSOCK2_GQOS
# endif

# if defined (WIN64) || defined (__WIN64__)
#   define ACE_LACKS_INLINE_ASSEMBLY
# endif

# include <stdlib.h>
# if defined (strtod)
#  undef strtod
# endif

#else
#  define ACE_LACKS_DIRENT_H
#endif // __MINGW64_VERSION_MAJOR >= 3

#undef ACE_HAS_WTOF

#define ACE_LACKS_SYS_SHM_H
#define ACE_LACKS_TERMIOS_H
#define ACE_LACKS_NETINET_TCP_H
#define ACE_LACKS_STRRECVFD
#define ACE_LACKS_STRPTIME
#define ACE_LACKS_POLL_H
#define ACE_LACKS_REGEX_H
#define ACE_LACKS_SYS_MSG_H
#define ACE_LACKS_PWD_H
#define ACE_LACKS_SEMAPHORE_H
#define ACE_LACKS_UCONTEXT_H
#define ACE_LACKS_SYS_SELECT_H
#define ACE_LACKS_SYS_RESOURCE_H
#define ACE_LACKS_SYS_WAIT_H
#define ACE_LACKS_DLFCN_H
#define ACE_LACKS_SYS_MMAN_H
#define ACE_LACKS_SYS_UIO_H
#define ACE_LACKS_SYS_SOCKET_H
#define ACE_LACKS_NETINET_IN_H
#define ACE_LACKS_NETDB_H
#define ACE_LACKS_NET_IF_H
#define ACE_LACKS_SYS_IPC_H
#define ACE_LACKS_SYS_SEM_H
#define ACE_LACKS_STROPTS_H
#define ACE_LACKS_SYS_IOCTL_H
#define ACE_LACKS_PDH_H
#define ACE_LACKS_PDHMSG_H
#define ACE_LACKS_STRTOK_R
#define ACE_LACKS_LOCALTIME_R
#define ACE_LACKS_GMTIME_R
#define ACE_LACKS_ASCTIME_R
#define ACE_HAS_NONCONST_WCSDUP
#define ACE_ISCTYPE_EQUIVALENT ::_isctype

#define ACE_HAS_PTHREAD_SIGMASK_PROTOTYPE

#define ACE_INT64_FORMAT_SPECIFIER_ASCII "%I64d"
#define ACE_UINT64_FORMAT_SPECIFIER_ASCII "%I64u"

#define ACE_ENDTHREADEX(STATUS)  ::_endthreadex ((DWORD) (STATUS))

#define ACE_DLL_PREFIX ACE_TEXT ("lib")

#include /**/ "ace/post.h"
#endif /* ACE_CONFIG_WIN32_MINGW64_H */
