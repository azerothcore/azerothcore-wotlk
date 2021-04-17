#ifndef CONFIG_MQX_H
#define CONFIG_MQX_H

// This macro is required in order to build the SOCK_Connector_Test
#define ACE_LACKS_GETHOSTENT

#if defined(ACE_MQX_DLIB_FULL)
# define MQX_SUPPRESS_FILE_DEF 1
# define MQX_SUPPRESS_STDIO_MACROS 1
#endif

#define MQX_STD_TIME_API 0

#include <time32.h>
#define _SIGNAL

#include <mfs.h>
#include <rtcs.h>
#include <mutex.h>
#include <fio.h>

// These headers do not have the proper guards for C++
extern "C" {
// Allowing p_time.h to be included causes conflicts
// with time.h
#define __p_time_h__

#include <sys_types.h>
#include <p_pthread.h>
#include <p_signal.h>
#include <p_semaphore.h>
}

#if MQX_STD_TIME_API == 0
# define ACE_LACKS_LOCALTIME_R
#endif

#if !defined (ACE_DEFAULT_MAP_SIZE)
# define ACE_DEFAULT_MAP_SIZE 64
#endif /* ACE_DEFAULT_MAP_SIZE */

#if !defined (ACE_MAXLOGMSGLEN)
# define ACE_MAXLOGMSGLEN 1024
#endif /* ACE_MAXLOGMSGLEN */

#if !defined (ACE_DEFAULT_ACCEPTOR_USE_SELECT)
# define ACE_DEFAULT_ACCEPTOR_USE_SELECT 0
#endif /* ACE_DEFAULT_ACCEPTOR_USE_SELECT */

#define ACE_CHDIR_EQUIVALENT MQX_Filesystem::inst().chdir
#define ACE_RMDIR_EQUIVALENT MQX_Filesystem::inst().rmdir
#define ACE_GETCWD_EQUIVALENT MQX_Filesystem::inst().getcwd
#define ACE_UNLINK_EQUIVALENT MQX_Filesystem::inst().unlink
#define ACE_MKDIR_EQUIVALENT MQX_Filesystem::inst().mkdir
#define ACE_RENAME_EQUIVALENT MQX_Filesystem::inst().rename

#define ACE_MQX
#define ACE_TEMPLATES_REQUIRE_SOURCE
#define ACE_PAGE_SIZE 4096
#define ACE_SOCKET_LEN uint16_t
#define ACE_SOCKOPT_LEN socklen_t
typedef int SOCKET;

#define ACE_UNUSED_ARG(X)

// Add a check for null pointer before calling free().  This is not
// completely necessary, but MQX will set a task error of MQX_INVALID_POINTER
// if we call free with a null pointer.
#define ACE_FREE_FUNC(X) if ((X) != 0) ::free(X)

#define ACE_USES_SOCKET_H

#define ACE_LACKS_SIGINFO_H
#define ACE_LACKS_NEW_H
#define ACE_LACKS_UNISTD_H
#define ACE_LACKS_FCNTL_H
#define ACE_LACKS_UCONTEXT_H
#define ACE_LACKS_SEARCH_H
#define ACE_LACKS_PWD_H
#define ACE_LACKS_PTHREAD_H
#define ACE_LACKS_SCHED_H
#define ACE_LACKS_SEMAPHORE_H
#define ACE_LACKS_STROPTS_H
#define ACE_LACKS_DLFCN_H
#define ACE_LACKS_NETDB_H
#define ACE_LACKS_DIRENT_H
#define ACE_LACKS_STRINGS_H
#define ACE_LACKS_SYSLOG_H
#define ACE_LACKS_POLL_H
#define ACE_LACKS_REGEX_H

#define ACE_LACKS_SYS_TYPES_H
#define ACE_LACKS_SYS_STAT_H
#define ACE_LACKS_SYS_PARAM_H
#define ACE_LACKS_SYS_TIME_H
#define ACE_LACKS_SYS_RESOURCE_H
#define ACE_LACKS_SYS_WAIT_H
#define ACE_LACKS_SYS_UTSNAME_H
#define ACE_LACKS_SYS_MMAN_H
#define ACE_LACKS_SYS_IPC_H
#define ACE_LACKS_SYS_SEM_H
#define ACE_LACKS_SYS_UIO_H
#define ACE_LACKS_SYS_SOCKET_H
#define ACE_LACKS_SYS_IOCTL_H
#define ACE_LACKS_SYS_SELECT_H
#define ACE_LACKS_SYS_UN_H
#define ACE_LACKS_SYS_MSG_H
#define ACE_LACKS_SYS_SHM_H
#define ACE_LACKS_SYS_SYSCTL_H

#define ACE_LACKS_NETINET_IN_H
#define ACE_LACKS_NETINET_TCP_H
#define ACE_LACKS_NET_IF_H
#define ACE_LACKS_ARPA_INET_H

#define ACE_HAS_THREADS
#define ACE_HAS_PTHREADS
#define ACE_LACKS_COND_T
#define ACE_LACKS_RWLOCK_T
#define ACE_MT_SAFE 1
#define ACE_LACKS_SIGPROCMASK
#define ACE_LACKS_CONDATTR
#define ACE_LACKS_PTHREAD_CLEANUP
#define ACE_HAS_SIGINFO_T
#define ACE_HAS_POSIX_SEM
#define ACE_HAS_POSIX_SEM_TIMEOUT
#define ACE_LACKS_PTHREAD_CANCEL
#define ACE_HAS_CONSISTENT_SIGNAL_PROTOTYPES
#define ACE_HAS_THREAD_SPECIFIC_STORAGE
#define ACE_LACKS_NAMED_POSIX_SEM
#define ACE_DEFAULT_SEM_KEY { 1234 }
// MQX POSIX has this, but it doesn't appear to work
#define ACE_LACKS_SETINHERITSCHED
typedef pthread_mutex_t ACE_mutex_t;
typedef pthread_mutexattr_t ACE_mutexattr_t;

#if !defined(ACE_MQX_DLIB_FULL)
#define ACE_LACKS_FGETWC
#define ACE_LACKS_FGETWS
#define ACE_LACKS_FPUTWS
#define ACE_LACKS_FGETPOS
#define ACE_LACKS_FSETPOS
#define ACE_LACKS_FREOPEN
#define ACE_LACKS_FDOPEN
#define ACE_LACKS_FILENO
#define ACE_LACKS_LOCALECONV

#define BUFSIZ 512

#undef ungetc
#undef sscanf
#undef snprintf
#undef vsnprintf
#undef getchar
#undef putchar
#undef status

#define getc(X) _io_fgetc(X)
#define ungetc(X,Y) _io_fungetc(X,Y)

#ifdef fgetc
#undef fgetc
inline int fgetc(FILE* f) {
  return _io_fgetc(f);
}
#endif
#ifdef fread
#undef fread
inline size_t fread(void* ptr, size_t so, size_t no,FILE* f) {
  return (_io_read((f),(ptr),(so)*(no))/(so));
}
#endif
#ifdef fwrite
#undef fwrite
inline size_t fwrite(const void* ptr, size_t so, size_t no, FILE* f) {
  return (_io_write((f),(void*)(ptr),(so)*(no))/(so));
}
#endif
#ifdef puts
#undef puts
#define def_puts
#endif
#ifdef getline
#undef getline
inline int getline(char* x, int y) {
  return _io_fgetline(stdin, x, y);
}
#endif
#ifdef read
#undef read
inline int read(FILE* f, const void* b, int a) {
  return _io_read(f, (void*)b, a);
}
#endif
#ifdef write
#undef write
inline int write(FILE* f, void* b, int a) {
  return _io_write(f, b, a);
}
#endif
#ifdef printf
#undef printf
#define def_printf
#endif
#ifdef sprintf
#undef sprintf
#define def_sprintf
#endif
#ifdef fprintf
#undef fprintf
inline int fprintf(FILE* s, const char* f, ...) {
  va_list argp;
  va_start(argp, f);
  const int r = _io_vfprintf(s, f, argp);
  va_end (argp);
  return r;
}
#endif
#ifdef vprintf
#undef vprintf
#define def_vprintf
#endif
#ifdef vsprintf
#undef vsprintf
#define def_vsprintf
#endif
#ifdef vfprintf
#undef vfprintf
inline int vfprintf(FILE* s, const char* f, va_list argp) {
  return _io_vfprintf(s, f, argp);
}
#endif
#ifdef fclose
#undef fclose
inline int fclose(FILE* f) {
  return _io_fclose(f);
}
#endif
#ifdef fflush
#undef fflush
inline int fflush(FILE* f) {
  return _io_fflush(f);
}
#endif
#ifdef fgets
#undef fgets
inline char* fgets(char* b, int a, FILE* f) {
  return _io_fgets(b, a, f);
}
#endif
#ifdef fputs
#undef fputs
inline int fputs(const char* s, FILE* f) {
  return _io_fputs(s, f);
}
#endif
#ifdef fopen
#undef fopen
inline FILE* fopen(const char* f, const char* m) {
  return _io_fopen(f, m);
}
#endif
#ifdef fseek
#undef fseek
inline int fseek(FILE* f, long o, int s) {
  return _io_fseek(f, o, s);
}
#endif
#ifdef ftell
#undef ftell
inline int ftell(FILE* f) {
  return _io_ftell(f);
}
#endif
#ifdef ioctl
#undef ioctl
inline int ioctl(FILE* f, unsigned int r, void* p)
{
  return _io_ioctl(f, r, p);
}
#endif

#include <stdio.h>

#ifdef def_printf
#undef def_printf
inline int printf(const char* f, ...) {
  va_list argp;
  va_start(argp, f);
  const int r = _io_vprintf(f, argp);
  va_end (argp);
  return r;
}
#endif
#ifdef def_sprintf
#undef def_sprintf
inline int sprintf(char* s, const char* f, ...) {
  va_list argp;
  va_start(argp, f);
  const int r = _io_vsprintf(s, f, argp);
  va_end (argp);
  return r;
}
#endif
#ifdef def_vprintf
#undef def_vprintf
inline int vprintf(const char* f, va_list argp) {
  return _io_vprintf(f, argp);
}
#endif
#ifdef def_vsprintf
#undef def_vsprintf
inline int vsprintf(char* s, const char* f, va_list argp) {
  return _io_vsprintf(s, f, argp);
}
#endif
#ifdef def_puts
#undef def_puts
inline int puts(const char* str) {
  return _io_fputs(str, stdout);
}
#endif
#endif

#define ACE_HAS_LINGER_MS
#define ACE_HAS_WCHAR
#define ACE_SIZEOF_WCHAR 4
#define ACE_HAS_SSIZE_T
#define ACE_HAS_SIG_ATOMIC_T
#define ACE_HAS_POSIX_TIME
#define ACE_HAS_SOCKLEN_T
#define ACE_HAS_DIRENT

#define ACE_NEW_THROWS_EXCEPTIONS
#define ACE_USES_STD_NAMESPACE_FOR_STDCPP_LIB
#define ACE_TEXT_WIN32_FIND_DATA MFS_SEARCH_DATA

#define ACE_LACKS_UNIX_SIGNALS
#define ACE_LACKS_SO_DONTROUTE
#define ACE_LACKS_WCSDUP
#define ACE_LACKS_WCSTOK
#define ACE_LACKS_ITOW
#define ACE_LACKS_WCSICMP
#define ACE_LACKS_WCSNICMP
#define ACE_LACKS_INET_NTOA
#define ACE_LACKS_RAND_R
#define ACE_LACKS_PUTENV
#define ACE_LACKS_PWD_FUNCTIONS
#define ACE_LACKS_SETSID
#define ACE_LACKS_SETGID
#define ACE_LACKS_GETEGID
#define ACE_LACKS_GETGID
#define ACE_LACKS_GETEUID
#define ACE_LACKS_SETEGID
#define ACE_LACKS_SETEUID
#define ACE_LACKS_SETREUID
#define ACE_LACKS_SETREGID
#define ACE_LACKS_SETUID
#define ACE_LACKS_GETUID
#define ACE_LACKS_GETPGID
#define ACE_LACKS_SETPGID
#define ACE_LACKS_GETPPID
#define ACE_LACKS_GETPID
#define ACE_LACKS_EXEC
#define ACE_LACKS_FORK
#define ACE_LACKS_GETOPT
#define ACE_LACKS_SBRK
#define ACE_LACKS_PIPE
#define ACE_DISABLE_NOTIFY_PIPE_DEFAULT 1
#define ACE_LACKS_ISATTY
#define ACE_LACKS_ALARM
#define ACE_LACKS_SYSCONF
#define ACE_LACKS_SWAB
#define ACE_LACKS_CADDR_T
#define ACE_LACKS_SETENV
#define ACE_LACKS_UNSETENV
#define ACE_LACKS_CUSERID
#define ACE_LACKS_MADVISE
#define ACE_LACKS_MMAP
#define ACE_LACKS_MPROTECT
#define ACE_LACKS_MSYNC
#define ACE_LACKS_MUNMAP
#define ACE_LACKS_STRPTIME
#define ACE_LACKS_GMTIME_R
#define ACE_LACKS_ASCTIME_R
#define ACE_LACKS_TZSET
#define ACE_LACKS_IOVEC
#define ACE_LACKS_ISASCII
#define ACE_LACKS_ISCTYPE
#define ACE_LACKS_READV
#define ACE_LACKS_WRITEV
#define ACE_LACKS_RECVMSG
#define ACE_LACKS_SENDMSG
#define ACE_LACKS_SOCKETPAIR
#define ACE_LACKS_GETHOSTBYADDR
#define ACE_LACKS_GETHOSTBYADDR_R
#define ACE_LACKS_GETHOSTBYNAME
#define ACE_LACKS_GETSERVBYNAME
#define ACE_LACKS_GETSERVBYNAME_R
#define ACE_LACKS_GAI_STRERROR
#define ACE_LACKS_GETPROTOBYNUMBER
#define ACE_LACKS_GETPROTOBYNUMBER_R
#define ACE_LACKS_GETPROTOBYNAME
#define ACE_LACKS_GETPROTOBYNAME_R
#define ACE_LACKS_STRUCT_DIR
#define ACE_LACKS_HOSTENT
#define ACE_LACKS_PROTOENT
#define ACE_LACKS_SERVENT
#define ACE_LACKS_RLIMIT
#define ACE_LACKS_WAIT
#define ACE_LACKS_WAITPID
#define ACE_LACKS_SIGEMPTYSET
#define ACE_LACKS_SIGADDSET
#define ACE_LACKS_IOSTREAM_TOTALLY
#define ACE_LACKS_ACE_IOSTREAM
#define ACE_LACKS_UNIX_SYSLOG
#define ACE_LACKS_UNAME
#define ACE_LACKS_IFCONF
#define ACE_LACKS_IFREQ
#define ACE_LACKS_STRRECVFD
#define ACE_MKDIR_LACKS_MODE

// POSIX
#define ACE_HAS_PTHREAD_SIGMASK_PROTOTYPE
#define ACE_LACKS_SEMBUF_T
#define ACE_LACKS_UNIX_DOMAIN_SOCKETS
#define ACE_LACKS_KILL
#define NSIG 64
#define FD_SETSIZE RTCSCFG_FD_SETSIZE
#define FD_SET RTCS_FD_SET
#define FD_CLR RTCS_FD_CLR
#define FD_ZERO RTCS_FD_ZERO
#define FD_ISSET RTCS_FD_ISSET
#define NFDBITS (sizeof (fd_mask) * 8)
typedef long fd_mask;
struct fd_set: public rtcs_fd_set {
  fd_set()
   : fds_bits(fd_array) {
  }
  uint32_t* fds_bits;
};

// File System Related
#define ACE_LACKS_MKTEMP
#define ACE_LACKS_MKSTEMP
#define ACE_LACKS_ACCESS
#define ACE_LACKS_REALPATH
#define ACE_LACKS_LSTAT
#define ACE_LACKS_MKFIFO
#define ACE_LACKS_UMASK
#define ACE_LACKS_DUP
#define ACE_LACKS_DUP2
#define ACE_LACKS_FSYNC
#define ACE_LACKS_FTRUNCATE
#define ACE_LACKS_READLINK
#define ACE_LACKS_TRUNCATE
#define ACE_LACKS_TEMPNAM
#define ACE_LACKS_FCNTL
#define ACE_LACKS_REWINDDIR
#define ACE_LACKS_OPENDIR
#define ACE_LACKS_READDIR
#define ACE_LACKS_SEEKDIR
#define ACE_LACKS_TELLDIR
#define ACE_LACKS_CLOSEDIR
#define ACE_LACKS_ALPHASORT

#define ACE_DEFINE_MISSING_ERRNOS

#define O_NDELAY 1

struct stat
{
  long st_size;
  long st_mtime;
  long st_mode;
  long st_nlink;
};

typedef unsigned int uid_t;
typedef unsigned int gid_t;
typedef long off_t;
typedef long loff_t;
typedef unsigned int mode_t;
typedef struct timespec timespec_t;

struct timeval
{
  int tv_sec;
  suseconds_t tv_usec;
};

#define MAXSYMLINKS 1

#define FIONBIO 0

#define S_IFMT  00170000
#define S_IFREG 00100000
#define S_IFDIR 00040000
#define S_IFCHR 00020000
#define ACE_LACKS_MODE_MASKS

#define IP_TTL 0
#define IP_TOS 0

#define ACE_IPPROTO_TCP SOL_TCP
#define TCP_NODELAY OPT_NOWAIT

#endif

