// -*- C++ -*-

#include "ace/OS_NS_sys_mman.h"

#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_INLINE int
ACE_Mutex::acquire_read (void)
{
// ACE_TRACE ("ACE_Mutex::acquire_read");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_lock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_wait (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_lock (&this->lock_);
}

ACE_INLINE int
ACE_Mutex::acquire_write (void)
{
// ACE_TRACE ("ACE_Mutex::acquire_write");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_lock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_wait (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_lock (&this->lock_);
}

ACE_INLINE int
ACE_Mutex::tryacquire_read (void)
{
// ACE_TRACE ("ACE_Mutex::tryacquire_read");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_trylock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_trywait (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_trylock (&this->lock_);
}

ACE_INLINE const ACE_mutex_t &
ACE_Mutex::lock (void) const
{
// ACE_TRACE ("ACE_Mutex::lock");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return *this->process_lock_;
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return this->lock_;
}

ACE_INLINE ACE_mutex_t &
ACE_Mutex::lock (void)
{
// ACE_TRACE ("ACE_Mutex::lock");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return *this->process_lock_;
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return this->lock_;
}

ACE_INLINE int
ACE_Mutex::tryacquire_write (void)
{
// ACE_TRACE ("ACE_Mutex::tryacquire_write");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_trylock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_trywait (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_trylock (&this->lock_);
}

ACE_INLINE int
ACE_Mutex::tryacquire_write_upgrade (void)
{
// ACE_TRACE ("ACE_Mutex::tryacquire_write_upgrade");
  return 0;
}

ACE_INLINE int
ACE_Mutex::acquire (void)
{
// ACE_TRACE ("ACE_Mutex::acquire");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_lock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_wait (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_lock (&this->lock_);
}

ACE_INLINE int
ACE_Mutex::acquire (ACE_Time_Value &tv)
{
  // ACE_TRACE ("ACE_Mutex::acquire");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_lock (this->process_lock_, tv);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_wait (this->process_lock_, tv);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_lock (&this->lock_, tv);
}

ACE_INLINE int
ACE_Mutex::acquire (ACE_Time_Value *tv)
{
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_lock (this->process_lock_, tv);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_wait (this->process_lock_, tv);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_lock (&this->lock_, tv);
}

ACE_INLINE int
ACE_Mutex::tryacquire (void)
{
// ACE_TRACE ("ACE_Mutex::tryacquire");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_trylock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_trywait (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_trylock (&this->lock_);
}

ACE_INLINE int
ACE_Mutex::release (void)
{
// ACE_TRACE ("ACE_Mutex::release");
#ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
  if (this->process_lock_)
    return ACE_OS::mutex_unlock (this->process_lock_);
#elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
  if (this->process_lock_)
    return ACE_OS::sema_post (this->process_lock_);
#endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */
  return ACE_OS::mutex_unlock (&this->lock_);
}

ACE_INLINE int
ACE_Mutex::remove (void)
{
// ACE_TRACE ("ACE_Mutex::remove");
  int result = 0;
#ifdef ACE_MUTEX_USE_PROCESS_LOCK
  // In the case of a interprocess mutex, the owner is the first
  // process that created the shared memory object. In this case, the
  // lockname_ pointer will be non-zero (points to allocated memory
  // for the name).  Owner or not, the memory needs to be unmapped
  // from the process.  If we are the owner, the file used for
  // shm_open needs to be deleted as well.
  if (this->process_lock_)
    {
      if (this->removed_ == false)
        {
          this->removed_ = true;
          // Only destroy the lock if we're the ones who initialized
          // it.
# ifdef ACE_MUTEX_PROCESS_LOCK_IS_MUTEX
          if (!this->lockname_)
            ACE_OS::munmap ((void *) this->process_lock_,
                            sizeof (ACE_mutex_t));
          else
            {
              result = ACE_OS::mutex_destroy (this->process_lock_);
              ACE_OS::munmap ((void *) this->process_lock_,
                              sizeof (ACE_mutex_t));
              ACE_OS::shm_unlink (this->lockname_);
            }
# elif defined ACE_MUTEX_PROCESS_LOCK_IS_SEMA
          result = ACE_OS::sema_destroy (this->process_lock_);
# endif /* ACE_MUTEX_PROCESS_LOCK_IS_MUTEX */

# ifdef ACE_HAS_ALLOC_HOOKS
          ACE_Allocator::instance ()->free (const_cast<ACE_TCHAR *> (
                                                this->lockname_));
# else
          ACE_OS::free (const_cast<ACE_TCHAR *> (this->lockname_));
# endif /* ACE_HAS_ALLOC_HOOKS */
        }
      return result;
    }
#endif /* ACE_MUTEX_USE_PROCESS_LOCK */

  if (this->removed_ == false)
    {
      this->removed_ = true;
      result = ACE_OS::mutex_destroy (&this->lock_);
    }

  return result;
}

ACE_END_VERSIONED_NAMESPACE_DECL
