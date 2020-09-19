#include "ace/OS_NS_sys_sendfile.h"
#include "ace/OS_NS_sys_mman.h"

#if defined (ACE_WIN32) || defined (HPUX)
# include "ace/OS_NS_sys_socket.h"
#endif  /* ACE_WIN32 || HPUX */

#include "ace/OS_NS_unistd.h"

#ifndef ACE_HAS_INLINED_OSCALLS
# include "ace/OS_NS_sys_sendfile.inl"
#endif  /* ACE_HAS_INLINED_OSCALLS */

#include "ace/Malloc_Base.h"
#include "ace/OS_Memory.h"
#include "ace/os_include/os_errno.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

#if defined ACE_HAS_SENDFILE && ACE_HAS_SENDFILE == 0
ssize_t
ACE_OS::sendfile_emulation (ACE_HANDLE out_fd,
                            ACE_HANDLE in_fd,
                            off_t *offset,
                            size_t count)
{
  // @@ Is it possible to inline a call to ::TransmitFile() on
  //    MS Windows instead of emulating here?

  // @@ We may want set up a signal lease (or oplock) if supported by
  //    the platform so that we don't get a bus error if the mmap()ed
  //    file is truncated.
  void *buf = ACE_OS::mmap (0, count, PROT_READ, MAP_SHARED, in_fd, *offset);
  const bool use_read = buf == MAP_FAILED && errno == ENODEV;
  ACE_OFF_T prev_pos;

  if (use_read)
    {
# ifdef ACE_HAS_ALLOC_HOOKS
      ACE_ALLOCATOR_RETURN (buf,
                            ACE_Allocator::instance ()->malloc (count), -1);
# else
      ACE_NEW_RETURN (buf, char[count], -1);
# endif
      prev_pos = ACE_OS::lseek (in_fd, 0, SEEK_CUR);
      if (ACE_OS::lseek (in_fd, *offset, SEEK_SET) == -1
          || ACE_OS::read (in_fd, buf, count) == -1)
        return -1;
    }
  else if (buf == MAP_FAILED)
    return -1;

#if defined (ACE_WIN32) || defined (HPUX)
  ssize_t const r =
    ACE_OS::send (out_fd, static_cast<const char *> (buf), count);
#else
  ssize_t const r = ACE_OS::write (out_fd, buf, count);
#endif /* ACE_WIN32 */

  if (use_read)
    {
      ACE_OS::lseek (in_fd, prev_pos, SEEK_SET);
# ifdef ACE_HAS_ALLOC_HOOKS
      ACE_Allocator::instance ()->free (buf);
# else
      delete[] static_cast<char *> (buf);
# endif
    }
  else
    (void) ACE_OS::munmap (buf, count);

  if (r > 0)
    *offset += static_cast<off_t> (r);

  return r;
}
#endif  /* ACE_HAS_SENDFILE==0 */

ACE_END_VERSIONED_NAMESPACE_DECL
