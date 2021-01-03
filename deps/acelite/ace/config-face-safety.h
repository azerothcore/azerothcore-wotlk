// Specialized configuration for FACE Safety Profiles
// See http://www.opengroup.org/face for more info about the Future Airborne
// Capability Environment

// Using this header:
// In ace/config.h, #define ACE_FACE_SAFETY_BASE or ACE_FACE_SAFETY_EXTENDED
// Optionally #define ACE_FACE_DEV
// ACE_FACE_DEV is a development mode setting which produces an ACE library
// that allows debug logging (doesn't enforce ACE_NDEBUG) and ACE_OS::getenv().

// Maintaining this header:
// This version of the header is written for FACE technical standard 2.1.
// See Appendix A for a chart of POSIX calls that are excluded from the
// various profiles.
// The top half of this file is only included if the user enables Safety Base,
// so these are exclusions that apply to Base but not to Extended.
// The bottom half is included for either profile, so it contains restrictions
// that are common to both Based and Extended.
// Keep macro definitions in sorted order.  Macros set by this file that are
// also set by some platform-specific config-*.h are "protected" from double
// definition by this construct:
//# ifndef ACE_LACKS_X
//#  define ACE_LACKS_X
//# endif
// Macros that are undefined in this file are similarly guarded:
//# ifdef ACE_HAS_X
//#  undef ACE_HAS_X
//# endif

#ifdef ACE_FACE_SAFETY_BASE

# ifndef ACE_FACE_SAFETY_EXTENDED
#  define ACE_FACE_SAFETY_EXTENDED
# endif

# ifndef ACE_HAS_ALLOC_HOOKS
#  define ACE_HAS_ALLOC_HOOKS
# endif

// Due to ACE_LACKS_PTHREAD_KEY_DELETE, ACE must explicitly clear out TSS
// when keyfree would have normally occurred.  This prevents the system's
// TSS destructors running later, which could be after libACE unloading.
# ifndef ACE_HAS_BROKEN_THREAD_KEYFREE
#  define ACE_HAS_BROKEN_THREAD_KEYFREE
# endif

# ifndef ACE_HAS_REACTOR_NOTIFICATION_QUEUE
#  define ACE_HAS_REACTOR_NOTIFICATION_QUEUE
# endif

// TSS emulation required with ACE_LACKS_PTHREAD_JOIN
# ifndef ACE_HAS_TSS_EMULATION
#  define ACE_HAS_TSS_EMULATION
# endif

# define ACE_LACKS_ABORT
# define ACE_LACKS_EXIT
# define ACE_LACKS__EXIT
# define ACE_LACKS_FREE
# define ACE_LACKS_PTHREAD_EXIT
# define ACE_LACKS_PTHREAD_JOIN
# define ACE_LACKS_PTHREAD_KEY_DELETE
# define ACE_LACKS_PTHREAD_MUTEX_DESTROY
# define ACE_LACKS_REALLOC
# define ACE_LACKS_SEM_DESTROY
# define ACE_LACKS_SEM_UNLINK
# define ACE_LACKS_SETPID
# define ACE_LACKS_SLEEP
# define ACE_LACKS_SSCANF
# define ACE_LACKS_VA_FUNCTIONS
# define ACE_LACKS_VFPRINTF

# ifndef ACE_LACKS_ACCEPT
#  define ACE_LACKS_ACCEPT
# endif

# ifndef ACE_LACKS_BSEARCH
#  define ACE_LACKS_BSEARCH
# endif

# ifndef ACE_LACKS_DUP2
#  define ACE_LACKS_DUP2
# endif

# ifndef ACE_LACKS_EXEC
#  define ACE_LACKS_EXEC
# endif

# ifndef ACE_LACKS_FCNTL
#  define ACE_LACKS_FCNTL
# endif

# ifndef ACE_LACKS_FORK
#  define ACE_LACKS_FORK
# endif

# ifndef ACE_LACKS_GETEGID
#  define ACE_LACKS_GETEGID
# endif

# if !defined ACE_LACKS_GETENV && !defined ACE_FACE_DEV
#  define ACE_LACKS_GETENV
# endif

# ifndef ACE_LACKS_GETEUID
#  define ACE_LACKS_GETEUID
# endif

# ifndef ACE_LACKS_GETGID
#  define ACE_LACKS_GETGID
# endif

# ifndef ACE_LACKS_GETPID
#  define ACE_LACKS_GETPID
# endif

# ifndef ACE_LACKS_GETPPID
#  define ACE_LACKS_GETPPID
# endif

# ifndef ACE_LACKS_GETUID
#  define ACE_LACKS_GETUID
# endif

# ifndef ACE_LACKS_KILL
#  define ACE_LACKS_KILL
# endif

# ifndef ACE_LACKS_LISTEN
#  define ACE_LACKS_LISTEN
# endif

# ifndef ACE_LACKS_LSTAT
#  define ACE_LACKS_LSTAT
# endif

# ifndef ACE_LACKS_MKFIFO
#  define ACE_LACKS_MKFIFO
# endif

# ifndef ACE_LACKS_PIPE
#  define ACE_LACKS_PIPE
# endif

# ifndef ACE_LACKS_PTHREAD_KILL
#  define ACE_LACKS_PTHREAD_KILL
# endif

# ifndef ACE_LACKS_PTHREAD_CANCEL
#  define ACE_LACKS_PTHREAD_CANCEL
# endif

# ifndef ACE_LACKS_PTHREAD_CLEANUP
#  define ACE_LACKS_PTHREAD_CLEANUP
# endif

# ifndef ACE_LACKS_RAISE
#  define ACE_LACKS_RAISE
# endif

# ifndef ACE_LACKS_SETDETACH
#  define ACE_LACKS_SETDETACH
# endif

# ifndef ACE_LACKS_SETEGID
#  define ACE_LACKS_SETEGID
# endif

# ifndef ACE_LACKS_SETEUID
#  define ACE_LACKS_SETEUID
# endif

# ifndef ACE_LACKS_SETGID
#  define ACE_LACKS_SETGID
# endif

# ifndef ACE_LACKS_SETSCHED
#  define ACE_LACKS_SETSCHED
# endif

# ifndef ACE_LACKS_SETUID
#  define ACE_LACKS_SETUID
# endif

# ifndef ACE_LACKS_STRFTIME
#  define ACE_LACKS_STRFTIME
# endif

# ifndef ACE_LACKS_STRTOLL
#  define ACE_LACKS_STRTOLL
# endif

# ifndef ACE_LACKS_SYSCONF
#  define ACE_LACKS_SYSCONF
# endif

# ifndef ACE_LACKS_UNAME
#  define ACE_LACKS_UNAME
# endif

# ifndef ACE_LACKS_VSNPRINTF
#  define ACE_LACKS_VSNPRINTF
# endif

# ifndef ACE_LACKS_WAITPID
#  define ACE_LACKS_WAITPID
# endif

# if !defined ACE_FACE_DEV && !defined ACE_NDEBUG
#  define ACE_NDEBUG
# endif

# define ACE_STDIO_USE_STDLIB_FOR_VARARGS

#endif // ACE_FACE_SAFETY_BASE

#ifdef ACE_FACE_SAFETY_EXTENDED

# if defined ACE_WIN32 || defined ACE_HAS_WINCE
#  error "FACE Safety profile not compatible with win32 or winCE"
# endif

# ifndef ACE_EMULATE_POSIX_DEVCTL
#  define ACE_EMULATE_POSIX_DEVCTL 1
# endif

# ifdef ACE_HAS_AIO_CALLS
#  undef ACE_HAS_AIO_CALLS
# endif

# ifdef ACE_HAS_DEV_POLL
#  undef ACE_HAS_DEV_POLL
# endif

# ifdef ACE_HAS_EVENT_POLL
#  undef ACE_HAS_EVENT_POLL
# endif

# ifdef ACE_HAS_ICONV
#  undef ACE_HAS_ICONV
# endif

# ifdef ACE_HAS_P_READ_WRITE
#  undef ACE_HAS_P_READ_WRITE
# endif

# ifdef ACE_HAS_RECURSIVE_MUTEXES
#  undef ACE_HAS_RECURSIVE_MUTEXES
# endif

# ifdef ACE_HAS_SCANDIR
#  undef ACE_HAS_SCANDIR
# endif

# ifdef ACE_HAS_STREAM_PIPES
#  undef ACE_HAS_STREAM_PIPES
# endif

# ifdef ACE_HAS_STRNLEN
#  undef ACE_HAS_STRNLEN
# endif

# ifdef ACE_HAS_SVR4_GETTIMEOFDAY
#  undef ACE_HAS_SVR4_GETTIMEOFDAY
# endif

# ifdef ACE_HAS_SYSV_IPC
#  undef ACE_HAS_SYSV_IPC
# endif

# ifdef ACE_HAS_TIMEZONE_GETTIMEOFDAY
#  undef ACE_HAS_TIMEZONE_GETTIMEOFDAY
# endif

# ifdef ACE_HAS_VFWPRINTF
#  undef ACE_HAS_VFWPRINTF
# endif

# ifdef ACE_HAS_VOIDPTR_GETTIMEOFDAY
#  undef ACE_HAS_VOIDPTR_GETTIMEOFDAY
# endif

# ifdef ACE_HAS_VSWPRINTF
#  undef ACE_HAS_VSWPRINTF
# endif

# ifdef ACE_HAS_VWPRINTF
#  undef ACE_HAS_VWPRINTF
# endif

# ifdef ACE_HAS_WCHAR
#  undef ACE_HAS_WCHAR
# endif

# ifdef ACE_HAS_XPG4_MULTIBYTE_CHAR
#  undef ACE_HAS_XPG4_MULTIBYTE_CHAR
# endif

# define ACE_LACKS_CTIME
# define ACE_LACKS_FDOPEN
# define ACE_LACKS_FGETPOS
# define ACE_LACKS_FPUTC
# define ACE_LACKS_FPUTS
# define ACE_LACKS_FSCANF
# define ACE_LACKS_FSETPOS
# define ACE_LACKS_GETC
# define ACE_LACKS_GETTIMEOFDAY
# define ACE_LACKS_IF_NAMEINDEX
# define ACE_LACKS_IF_NAMETOINDEX
# define ACE_LACKS_IOCTL
# define ACE_LACKS_LOCALECONV
# define ACE_LACKS_MUNMAP
# define ACE_LACKS_OPENLOG
# define ACE_LACKS_PRAGMA_ONCE
# define ACE_LACKS_PTHREAD_MUTEXATTR_SETTYPE
# define ACE_LACKS_PUTC
# define ACE_LACKS_PUTS
# define ACE_LACKS_RAND
# define ACE_LACKS_REWIND
# define ACE_LACKS_SHM_UNLINK
# define ACE_LACKS_SIGNAL
# define ACE_LACKS_SRAND
# define ACE_LACKS_STDERR
# define ACE_LACKS_STDIN
# define ACE_LACKS_STDOUT
# define ACE_LACKS_STRTOK
# define ACE_LACKS_UNGETC
# define ACE_LACKS_VA_COPY
# define ACE_LACKS_VPRINTF
# define ACE_LACKS_VSPRINTF

# ifndef ACE_LACKS_ACE_IOSTREAM
#  define ACE_LACKS_ACE_IOSTREAM
# endif

# ifndef ACE_LACKS_ALPHASORT
#  define ACE_LACKS_ALPHASORT
# endif

# ifndef ACE_LACKS_ASCTIME
#  define ACE_LACKS_ASCTIME
# endif

# ifndef ACE_LACKS_CONDATTR_PSHARED
#  define ACE_LACKS_CONDATTR_PSHARED
# endif

# ifndef ACE_LACKS_CUSERID
#  define ACE_LACKS_CUSERID
# endif

# ifndef ACE_LACKS_DUP
#  define ACE_LACKS_DUP
# endif

# ifndef ACE_LACKS_EXECVP
#  define ACE_LACKS_EXECVP
# endif

# ifndef ACE_LACKS_GAI_STRERROR
#  define ACE_LACKS_GAI_STRERROR
# endif

# ifndef ACE_LACKS_GETHOSTBYADDR
#  define ACE_LACKS_GETHOSTBYADDR
# endif

# ifndef ACE_LACKS_GETHOSTBYADDR_R
#  define ACE_LACKS_GETHOSTBYADDR_R
# endif

# ifndef ACE_LACKS_GETHOSTBYNAME
#  define ACE_LACKS_GETHOSTBYNAME
# endif

# ifndef ACE_LACKS_GETHOSTENT
#  define ACE_LACKS_GETHOSTENT
# endif

# ifndef ACE_LACKS_GETOPT
#  define ACE_LACKS_GETOPT
# endif

# ifndef ACE_LACKS_GETPGID
#  define ACE_LACKS_GETPGID
# endif

# ifndef ACE_LACKS_GETPROTOBYNAME
#  define ACE_LACKS_GETPROTOBYNAME
# endif

# ifndef ACE_LACKS_GETPROTOBYNUMBER
#  define ACE_LACKS_GETPROTOBYNUMBER
# endif

# ifndef ACE_LACKS_GETSERVBYNAME
#  define ACE_LACKS_GETSERVBYNAME
# endif

# ifndef ACE_LACKS_GMTIME
#  define ACE_LACKS_GMTIME
# endif

# ifndef ACE_LACKS_INET_ADDR
#  define ACE_LACKS_INET_ADDR
# endif

# ifndef ACE_LACKS_INET_ATON
#  define ACE_LACKS_INET_ATON
# endif

# ifndef ACE_LACKS_INET_NTOA
#  define ACE_LACKS_INET_NTOA
# endif

# ifndef ACE_LACKS_IOSTREAM_TOTALLY
#  define ACE_LACKS_IOSTREAM_TOTALLY
# endif

# ifndef ACE_LACKS_ISASCII
#  define ACE_LACKS_ISASCII
# endif

# ifndef ACE_LACKS_ISATTY
#  define ACE_LACKS_ISATTY
# endif

# ifndef ACE_LACKS_ISBLANK
#  define ACE_LACKS_ISBLANK
# endif

# ifndef ACE_LACKS_ISWASCII
#  define ACE_LACKS_ISWASCII
# endif

# ifndef ACE_LACKS_ISWBLANK
#  define ACE_LACKS_ISWBLANK
# endif

# ifndef ACE_LACKS_ISWCTYPE
#  define ACE_LACKS_ISWCTYPE
# endif

# ifndef ACE_LACKS_LOCALTIME
#  define ACE_LACKS_LOCALTIME
# endif

# ifndef ACE_LACKS_LOG2
#  define ACE_LACKS_LOG2
# endif

# ifndef ACE_LACKS_MADVISE
#  define ACE_LACKS_MADVISE
# endif

# ifndef ACE_LACKS_MKSTEMP
#  define ACE_LACKS_MKSTEMP
# endif

# ifndef ACE_LACKS_MKTEMP
#  define ACE_LACKS_MKTEMP
# endif

# ifndef ACE_LACKS_MPROTECT
#  define ACE_LACKS_MPROTECT
# endif

# ifndef ACE_LACKS_MSYNC
#  define ACE_LACKS_MSYNC
# endif

# ifndef ACE_LACKS_MUTEXATTR_PSHARED
#  define ACE_LACKS_MUTEXATTR_PSHARED
# endif

# ifndef ACE_LACKS_PERROR
#  define ACE_LACKS_PERROR
# endif

# ifndef ACE_LACKS_PTHREAD_ATTR_SETSTACKADDR
#  define ACE_LACKS_PTHREAD_ATTR_SETSTACKADDR
# endif

# ifndef ACE_LACKS_PTHREAD_CANCEL
#  define ACE_LACKS_PTHREAD_CANCEL
# endif

# ifndef ACE_LACKS_PUTENV
#  define ACE_LACKS_PUTENV
# endif

# ifndef ACE_LACKS_PWD_FUNCTIONS
#  define ACE_LACKS_PWD_FUNCTIONS
# endif

# ifndef ACE_LACKS_QSORT
#  define ACE_LACKS_QSORT
# endif

# ifndef ACE_LACKS_READLINK
#  define ACE_LACKS_READLINK
# endif

# ifndef ACE_LACKS_READV
#  define ACE_LACKS_READV
# endif

# ifndef ACE_LACKS_RECVMSG
#  define ACE_LACKS_RECVMSG
# endif

# ifndef ACE_LACKS_REALPATH
#  define ACE_LACKS_REALPATH
# endif

# ifndef ACE_LACKS_RLIMIT
#  define ACE_LACKS_RLIMIT
# endif

# ifndef ACE_LACKS_RWLOCK_T
#  define ACE_LACKS_RWLOCK_T
# endif

# ifndef ACE_LACKS_SBRK
#  define ACE_LACKS_SBRK
# endif

# ifndef ACE_LACKS_SEEKDIR
#  define ACE_LACKS_SEEKDIR
# endif

# ifndef ACE_LACKS_SENDMSG
#  define ACE_LACKS_SENDMSG
# endif

# ifndef ACE_LACKS_SETLOGMASK
#  define ACE_LACKS_SETLOGMASK
# endif

# ifndef ACE_LACKS_SETPGID
#  define ACE_LACKS_SETPGID
# endif

# ifndef ACE_LACKS_SETREGID
#  define ACE_LACKS_SETREGID
# endif

# ifndef ACE_LACKS_SETREUID
#  define ACE_LACKS_SETREUID
# endif

# ifndef ACE_LACKS_SETSID
#  define ACE_LACKS_SETSID
# endif

# ifndef ACE_LACKS_SIGPROCMASK
#  define ACE_LACKS_SIGPROCMASK
# endif

# ifndef ACE_LACKS_SOCKETPAIR
#  define ACE_LACKS_SOCKETPAIR
# endif

# ifndef ACE_LACKS_STD_WSTRING
#  define ACE_LACKS_STD_WSTRING
# endif

# ifndef ACE_LACKS_STRCASECMP
#  define ACE_LACKS_STRCASECMP
# endif

# ifndef ACE_LACKS_STRDUP
#  define ACE_LACKS_STRDUP
# endif

# ifndef ACE_LACKS_STRERROR
#  define ACE_LACKS_STRERROR
# endif

# ifndef ACE_LACKS_STRPTIME
#  define ACE_LACKS_STRPTIME
# endif

# ifndef ACE_LACKS_STRTOLL
#  define ACE_LACKS_STRTOLL
# endif

# ifndef ACE_LACKS_STRTOULL
#  define ACE_LACKS_STRTOULL
# endif

# ifndef ACE_LACKS_SWAB
#  define ACE_LACKS_SWAB
# endif

# ifndef ACE_LACKS_SYMLINKS
#  define ACE_LACKS_SYMLINKS
# endif

# ifndef ACE_LACKS_SYSTEM
#  define ACE_LACKS_SYSTEM
# endif

# ifndef ACE_LACKS_SYS_SHM_H
#  define ACE_LACKS_SYS_SHM_H
# endif

# ifndef ACE_LACKS_TELLDIR
#  define ACE_LACKS_TELLDIR
# endif

# ifndef ACE_LACKS_TMPNAM
#  define ACE_LACKS_TMPNAM
# endif

# ifndef ACE_LACKS_TEMPNAM
#  define ACE_LACKS_TEMPNAM
# endif

# ifndef ACE_LACKS_TRUNCATE
#  define ACE_LACKS_TRUNCATE
# endif

# ifndef ACE_LACKS_UNIX_SYSLOG
#  define ACE_LACKS_UNIX_SYSLOG
# endif

# ifndef ACE_LACKS_WAIT
#  define ACE_LACKS_WAIT
# endif

# ifndef ACE_LACKS_WCSCAT
#  define ACE_LACKS_WCSCAT
# endif

# ifndef ACE_LACKS_WCSCHR
#  define ACE_LACKS_WCSCHR
# endif

# ifndef ACE_LACKS_WCSCMP
#  define ACE_LACKS_WCSCMP
# endif

# ifndef ACE_LACKS_WCSCPY
#  define ACE_LACKS_WCSCPY
# endif

# ifndef ACE_LACKS_WCSCSPN
#  define ACE_LACKS_WCSCSPN
# endif

# ifndef ACE_LACKS_WCSDUP
#  define ACE_LACKS_WCSDUP
# endif

# ifndef ACE_LACKS_WCSLEN
#  define ACE_LACKS_WCSLEN
# endif

# ifndef ACE_LACKS_WCSNCAT
#  define ACE_LACKS_WCSNCAT
# endif

# ifndef ACE_LACKS_WCSNCMP
#  define ACE_LACKS_WCSNCMP
# endif

# ifndef ACE_LACKS_WCSNCPY
#  define ACE_LACKS_WCSNCPY
# endif

# ifndef ACE_LACKS_WCSNLEN
#  define ACE_LACKS_WCSNLEN
# endif

# ifndef ACE_LACKS_WCSPBRK
#  define ACE_LACKS_WCSPBRK
# endif

# ifndef ACE_LACKS_WCSRCHR
#  define ACE_LACKS_WCSRCHR
# endif

# ifndef ACE_LACKS_WCSRTOMBS
#  define ACE_LACKS_WCSRTOMBS
# endif

# ifndef ACE_LACKS_WCSSPN
#  define ACE_LACKS_WCSSPN
# endif

# ifndef ACE_LACKS_WCSSTR
#  define ACE_LACKS_WCSSTR
# endif

# ifndef ACE_LACKS_WCSTOK
#  define ACE_LACKS_WCSTOK
# endif

# ifndef ACE_LACKS_WCSLEN
#  define ACE_LACKS_WCSLEN
# endif

# ifndef ACE_LACKS_WRITEV
#  define ACE_LACKS_WRITEV
# endif

// due to ACE_LACKS_GETHOSTBYNAME:
# ifndef ACE_LOCALHOST
#  define ACE_LOCALHOST ACE_TEXT ("127.0.0.1")
# endif

# ifdef ACE_USES_GPROF
#  undef ACE_USES_GPROF
# endif

#endif // ACE_FACE_SAFETY_EXTENDED
