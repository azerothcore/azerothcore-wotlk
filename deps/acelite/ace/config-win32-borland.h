//-*- C++ -*-
// The following configuration file contains defines for Borland compilers.

#ifndef ACE_CONFIG_WIN32_BORLAND_H
#define ACE_CONFIG_WIN32_BORLAND_H
#include /**/ "ace/pre.h"

#ifndef ACE_CONFIG_WIN32_H
#error Use config-win32.h in config.h instead of this header
#endif /* ACE_CONFIG_WIN32_H */

#define ACE_HAS_CUSTOM_EXPORT_MACROS 1
#define ACE_Proper_Export_Flag __declspec (dllexport)
#define ACE_Proper_Import_Flag __declspec (dllimport)
#define ACE_EXPORT_SINGLETON_DECLARATION(T) template class __declspec (dllexport) T
#define ACE_EXPORT_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK) template class __declspec (dllexport) SINGLETON_TYPE<CLASS, LOCK>;
#define ACE_IMPORT_SINGLETON_DECLARATION(T) template class __declspec (dllimport) T
#define ACE_IMPORT_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK) template class __declspec (dllimport) SINGLETON_TYPE <CLASS, LOCK>;

// In later versions of C++Builder we will prefer inline functions by
// default. The debug configuration of ACE is built with functions
// out-of-line, so when linking your application against a debug ACE
// build, you can choose to use the out-of-line functions by adding
// ACE_NO_INLINE=1 to your project settings.
# if !defined (__ACE_INLINE__)
#  define __ACE_INLINE__ 1
# endif /* __ACE_INLINE__ */

# define ACE_CC_NAME ACE_TEXT ("Embarcadero C++ Builder")
# define ACE_CC_MAJOR_VERSION (__BORLANDC__ / 0x100)
# define ACE_CC_MINOR_VERSION (__BORLANDC__ % 0x100)
# define ACE_CC_BETA_VERSION (0)

#if (__BORLANDC__ >= 0x620)
# define ACE_CC_PREPROCESSOR_ARGS "-q -Sl -o%s"
#endif

#if !defined (WIN32)
# if defined (__WIN32__) || defined (_WIN32)
#  define WIN32 1
# endif
#endif

// When building a VCL application, the main VCL header file should be
// included before anything else. You can define ACE_HAS_VCL=1 in your
// project settings to have this file included for you automatically.
# if defined (ACE_HAS_VCL) && (ACE_HAS_VCL != 0)
#  include /**/ <vcl.h>
# endif

#if defined (_WIN64)
# define ACE_HAS_BCC64
#else
# define ACE_HAS_BCC32
#endif

#if defined (ACE_HAS_BCC64)
// Use 32bit pre processor because cpp64 doesn't have the same
// options
# define ACE_CC_PREPROCESSOR "CPP32.EXE"
#else
# define ACE_CC_PREPROCESSOR "CPP32.EXE"
#endif

# include "ace/config-win32-common.h"

# define ACE_WSTRING_HAS_USHORT_SUPPORT 1
# define ACE_HAS_DIRENT

#define ACE_USES_STD_NAMESPACE_FOR_STDC_LIB 1

#define ACE_LACKS_TERMIOS_H
#define ACE_LACKS_NETINET_TCP_H
#define ACE_LACKS_REGEX_H
#define ACE_LACKS_SYS_MSG_H
#define ACE_LACKS_PWD_H
#define ACE_LACKS_POLL_H
#define ACE_LACKS_SYS_SHM_H
#define ACE_LACKS_STRINGS_H
#define ACE_LACKS_SEMAPHORE_H
#define ACE_LACKS_INTTYPES_H
#define ACE_LACKS_UCONTEXT_H
#define ACE_LACKS_SYS_SELECT_H
#define ACE_LACKS_SYS_TIME_H
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
#define ACE_LACKS_SYS_IOCTL_H
#define ACE_LACKS_STROPTS_H
#define ACE_LACKS_WCSRTOMBS

#undef ACE_LACKS_STRUCT_DIR
#undef ACE_LACKS_CLOSEDIR
#undef ACE_LACKS_OPENDIR
#undef ACE_LACKS_READDIR
#undef ACE_LACKS_REWINDDIR

#define ACE_HAS_WOPENDIR
#define ACE_HAS_WCLOSEDIR
#define ACE_HAS_WREADDIR
#define ACE_HAS_WREWINDDIR

#define ACE_LACKS_STRRECVFD
#define ACE_USES_EXPLICIT_STD_NAMESPACE

#if defined (ACE_HAS_BCC64)
# define ACE_HAS_TIME_T_LONG_MISMATCH
#endif

#define ACE_HAS_CPLUSPLUS_HEADERS 1
#define ACE_HAS_NONCONST_SELECT_TIMEVAL
#define ACE_HAS_SIG_ATOMIC_T
#define ACE_HAS_STANDARD_CPP_LIBRARY 1
#define ACE_HAS_STDCPP_STL_INCLUDES 1
#define ACE_HAS_STRING_CLASS 1
#define ACE_HAS_USER_MODE_MASKS 1
#define ACE_LACKS_ACE_IOSTREAM 1
#define ACE_LACKS_LINEBUFFERED_STREAMBUF 1
#define ACE_HAS_NEW_NOTHROW
#define ACE_TEMPLATES_REQUIRE_SOURCE 1
#if defined (ACE_HAS_BCC32)
# define ACE_UINT64_FORMAT_SPECIFIER_ASCII "%Lu"
# define ACE_INT64_FORMAT_SPECIFIER_ASCII "%Ld"
#endif
#define ACE_USES_STD_NAMESPACE_FOR_STDCPP_LIB 1
#define ACE_USES_STD_NAMESPACE_FOR_ABS 1
#define ACE_ENDTHREADEX(STATUS) ::_endthreadex ((DWORD) STATUS)

#if defined(ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
// must have _MT defined to include multithreading
// features from win32 headers
# if !defined(__MT__)
// *** DO NOT *** defeat this error message by defining __MT__ yourself.
// You must link with the multi threaded libraries. Add -tWM to your
// compiler options
#  error You must link against multi-threaded libraries when using ACE (check your project settings)
# endif /* !__MT__ */
#endif /* ACE_MT_SAFE && ACE_MT_SAFE != 0 */

#if (__BORLANDC__ <= 0x750)
# define ACE_LACKS_ISWCTYPE
# define ACE_LACKS_ISCTYPE
#endif

#if (__BORLANDC__ >= 0x640) && (__BORLANDC__ <= 0x750)
# define ACE_LACKS_STRTOK_R
#endif

#if (__BORLANDC__ <= 0x740)
# define ACE_LACKS_LOCALTIME_R
# define ACE_LACKS_GMTIME_R
#endif

#if (__BORLANDC__ <= 0x750)
# define ACE_LACKS_ASCTIME_R
#endif

#define ACE_WCSDUP_EQUIVALENT ::_wcsdup
#define ACE_STRCASECMP_EQUIVALENT ::stricmp
#define ACE_STRNCASECMP_EQUIVALENT ::strnicmp
#define ACE_WTOF_EQUIVALENT ::_wtof
#define ACE_FILENO_EQUIVALENT(X) (_get_osfhandle (::_fileno (X)))
#define ACE_HAS_ITOA 1

#if defined (ACE_HAS_BCC64)
# if (__BORLANDC__ <= 0x730)
#  define ACE_LACKS_SWAB
# endif
#endif

#if defined (ACE_HAS_BCC32)
// The bcc32 compiler can't handle assembly in inline methods or
// templates (E2211). When we build for pentium optimized and we are inlining
// then we disable inline assembly
# if defined (ACE_HAS_PENTIUM) && defined(__ACE_INLINE__) && !defined(__clang__)
#  define ACE_LACKS_INLINE_ASSEMBLY
# endif
# define ACE_SIZEOF_LONG_DOUBLE 10
# define ACE_NEEDS_DL_UNDERSCORE
#endif

#ifdef __clang__
# define ACE_ANY_OPS_USE_NAMESPACE
# define ACE_HAS_BUILTIN_BSWAP16
# define ACE_HAS_BUILTIN_BSWAP32
# define ACE_HAS_BUILTIN_BSWAP64
# define ACE_LACKS_INLINE_ASSEMBLY

# if __cplusplus >= 201103L
#  define ACE_HAS_CPP11
# endif
# if __cplusplus >= 201402L
#  define ACE_HAS_CPP14
# endif
# if __cplusplus >= 201703L
#  define ACE_HAS_CPP17
# endif
# if __cplusplus >= 202002L
#  define ACE_HAS_CPP20
# endif
#endif /* __clang__ */

#include /**/ "ace/post.h"
#endif /* ACE_CONFIG_WIN32_BORLAND_H */

