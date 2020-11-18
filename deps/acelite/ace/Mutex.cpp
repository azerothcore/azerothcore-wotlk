#include "ace/Mutex.h"

#if !defined (__ACE_INLINE__)
#include "ace/Mutex.inl"
#endif /* __ACE_INLINE__ */

#include "ace/Log_Category.h"
#include "ace/OS_NS_string.h"
#include "ace/os_include/sys/os_mman.h"
#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE (ACE_Mutex)

void
ACE_Mutex::dump (void) const
{
#if defined (ACE_HAS_DUMP)
// ACE_TRACE ("ACE_Mutex::dump");

  ACELIB_DEBUG ((LM_DEBUG, ACE_BEGIN_DUMP, this));
# ifdef ACE_MUTEX_USE_PROCESS_LOCK
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("lockname_ = %s\n"), this->lockname_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("process_lock_ = %x\n"), this->process_lock_));
# endif /* ACE_MUTEX_USE_PROCESS_LOCK */
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\n")));
  ACELIB_DEBUG ((LM_DEBUG, ACE_END_DUMP));
#endif /* ACE_HAS_DUMP */
}

int
ACE_Mutex::unlink (const ACE_TCHAR *name)
{
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  return ACE_OS::sema_unlink (ACE_TEXT_ALWAYS_CHAR (name));
#else
  ACE_UNUSED_ARG (name);
  return 0;
#endif
}

ACE_Mutex::ACE_Mutex (int type, const ACE_TCHAR *name,
                      ACE_mutexattr_t *arg, mode_t mode)
  :
#ifdef ACE_MUTEX_USE_PROCESS_LOCK
    process_lock_ (0),
    lockname_ (0),
#endif /* ACE_MUTEX_USE_PROCESS_LOCK */
    removed_ (false)
{
  // ACE_TRACE ("ACE_Mutex::ACE_Mutex");

  // These platforms need process-wide mutex to be in shared memory.
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (type == USYNC_PROCESS)
    {
      // Let's see if the shared memory entity already exists.
      ACE_HANDLE fd = ACE_OS::shm_open (name, O_RDWR | O_CREAT | O_EXCL, mode);
      if (fd == ACE_INVALID_HANDLE)
        {
          if (errno == EEXIST)
            fd = ACE_OS::shm_open (name, O_RDWR | O_CREAT, mode);
          else
            return;
        }
      else
        {
          // We own this shared memory object!  Let's set its size.
          if (ACE_OS::ftruncate (fd,
                                 sizeof (ACE_mutex_t)) == -1)
            {
              ACE_OS::close (fd);
              return;
            }
          this->lockname_ = ACE_OS::strdup (name);
          if (this->lockname_ == 0)
            {
              ACE_OS::close (fd);
              return;
            }
        }

      this->process_lock_ =
        (ACE_mutex_t *) ACE_OS::mmap (0,
                                      sizeof (ACE_mutex_t),
                                      PROT_RDWR,
                                      MAP_SHARED,
                                      fd,
                                      0);
      ACE_OS::close (fd);
      if (this->process_lock_ == MAP_FAILED)
        return;

      if (this->lockname_
          && ACE_OS::mutex_init (this->process_lock_,
                                 type,
                                 name,
                                 arg) != 0)
        {
          ACELIB_ERROR ((LM_ERROR, ACE_TEXT ("%p\n"),
                         ACE_TEXT ("ACE_Mutex::ACE_Mutex")));
        }
      return;
    }

#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  ACE_UNUSED_ARG (mode);
  if (type == USYNC_PROCESS)
    {
      if (name)
        this->lockname_ = ACE_OS::strdup (name);
      else
        {
          const size_t un_len = (ACE_UNIQUE_NAME_LEN + 1) * sizeof (ACE_TCHAR);
          ACE_TCHAR *const un =
# ifdef ACE_HAS_ALLOC_HOOKS
            (ACE_TCHAR *) ACE_Allocator::instance ()->malloc (un_len);
# else
            (ACE_TCHAR *) ACE_OS::malloc (un_len);
# endif /* ACE_HAS_ALLOC_HOOKS */
          un[0] = ACE_TEXT ('/');
          ACE_OS::unique_name (this, un + 1, ACE_UNIQUE_NAME_LEN);
          this->lockname_ = un;
        }

      this->process_lock_ = &this->process_sema_;
      if (ACE_OS::sema_init (&this->process_sema_, 1 /*mutex unlocked*/,
                             USYNC_PROCESS, this->lockname_) != 0)
        ACELIB_ERROR ((LM_ERROR, ACE_TEXT ("%p\n"),
                       ACE_TEXT ("ACE_Mutex::ACE_Mutex")));
      ACE_OS::sema_avoid_unlink (&this->process_sema_, true);
      return;
    }
#else
  ACE_UNUSED_ARG (mode);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */

  if (ACE_OS::mutex_init (&this->lock_, type, name, arg) != 0)
    ACELIB_ERROR ((LM_ERROR, ACE_TEXT ("%p\n"),
                   ACE_TEXT ("ACE_Mutex::ACE_Mutex")));
}

ACE_Mutex::~ACE_Mutex (void)
{
// ACE_TRACE ("ACE_Mutex::~ACE_Mutex");
  this->remove ();
}

ACE_END_VERSIONED_NAMESPACE_DECL
