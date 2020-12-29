#include "ace/OS_NS_sys_uio.h"

#if !defined (ACE_HAS_INLINED_OSCALLS)
# include "ace/OS_NS_sys_uio.inl"
#endif /* ACE_HAS_INLINED_OSCALLS */

#include "ace/OS_Memory.h"
#include "ace/OS_NS_string.h"
#include "ace/OS_NS_unistd.h"

#ifdef ACE_HAS_ALLOC_HOOKS
# include "ace/Global_Macros.h"
# include "ace/Malloc_Base.h"
#endif

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

#if defined (ACE_LACKS_READV)

// "Fake" readv for operating systems without it.  Note that this is
// thread-safe.

ssize_t
ACE_OS::readv_emulation (ACE_HANDLE handle,
                         const iovec *iov,
                         int n)
{
  ACE_OS_TRACE ("ACE_OS::readv_emulation");

  // In case there's a single element, skip the memcpy.
  if (1 == n)
    return ACE_OS::read (handle, iov[0].iov_base, iov[0].iov_len);

  ssize_t length = 0;
  int i;

  for (i = 0; i < n; ++i)
    if (static_cast<int> (iov[i].iov_len) < 0)
      return -1;
    else
      length += iov[i].iov_len;

  char *buf;
# ifdef ACE_HAS_ALLOC_HOOKS
  ACE_ALLOCATOR_RETURN (buf,
                        (char *) ACE_Allocator::instance ()->malloc (length),
                        -1);
# else
  ACE_NEW_RETURN (buf,
                  char[length],
                  -1);
# endif /* ACE_HAS_ALLOC_HOOKS */

  length = ACE_OS::read (handle, buf, length);

  if (length != -1)
    {
      char *ptr = buf;
      ssize_t copyn = length;

      for (i = 0;
           i < n && copyn > 0;
           ++i)
        {
          ACE_OS::memcpy (iov[i].iov_base, ptr,
                          // iov_len is int on some platforms, size_t on others
                          copyn > (int) iov[i].iov_len
                            ? (size_t) iov[i].iov_len
                            : (size_t) copyn);
          ptr += iov[i].iov_len;
          copyn -= iov[i].iov_len;
        }
    }

# ifdef ACE_HAS_ALLOC_HOOKS
  ACE_Allocator::instance ()->free (buf);
# else
  delete [] buf;
# endif /* ACE_HAS_ALLOC_HOOKS */
  return length;
}
#endif /* ACE_LACKS_READV */

#if defined (ACE_LACKS_WRITEV)

// "Fake" writev for operating systems without it.  Note that this is
// thread-safe.

ssize_t
ACE_OS::writev_emulation (ACE_HANDLE handle, const iovec *iov, int n)
{
  ACE_OS_TRACE ("ACE_OS::writev_emulation");

  // 'handle' may be a datagram socket (or similar) so this operation
  // must not be divided into multiple smaller writes.

  if (n == 1)
    return ACE_OS::write (handle, iov[0].iov_base, iov[0].iov_len);

  ssize_t length = 0;
  for (int i = 0; i < n; ++i)
    length += iov[i].iov_len;

  char *buf;
# ifdef ACE_HAS_ALLOC_HOOKS
  ACE_ALLOCATOR_RETURN (buf,
                        (char *) ACE_Allocator::instance ()->malloc (length),
                        -1);
# else
  ACE_NEW_RETURN (buf, char[length], -1);
# endif /* ACE_HAS_ALLOC_HOOKS */

  char *iter = buf;
  for (int i = 0; i < n; iter += iov[i++].iov_len)
    ACE_OS::memcpy (iter, iov[i].iov_base, iov[i].iov_len);

  const ssize_t result = ACE_OS::write (handle, buf, length);

# ifdef ACE_HAS_ALLOC_HOOKS
  ACE_Allocator::instance ()->free (buf);
# else
  delete[] buf;
# endif /* ACE_HAS_ALLOC_HOOKS */

  return result;
}
# endif /* ACE_LACKS_WRITEV */

ACE_END_VERSIONED_NAMESPACE_DECL
