// We need this to get the status of ACE_NTRACE...
#include "ace/config-all.h"

// Turn off tracing for the duration of this file.
#if defined (ACE_NTRACE)
# undef ACE_NTRACE
#endif /* ACE_NTRACE */
#define ACE_NTRACE 1

#include "ace/ACE.h"
#include "ace/Thread_Manager.h"
#include "ace/Guard_T.h"
#include "ace/OS_NS_stdio.h"
#include "ace/OS_NS_errno.h"
#include "ace/OS_NS_sys_time.h"
#include "ace/OS_NS_string.h"
#include "ace/OS_NS_wchar.h"
#include "ace/OS_NS_signal.h"
#include "ace/os_include/os_typeinfo.h"

#if !defined (ACE_MT_SAFE) || (ACE_MT_SAFE != 0)
# include "ace/Object_Manager.h"
#endif /* ! ACE_MT_SAFE */

#if !defined (ACE_LACKS_IOSTREAM_TOTALLY)
// FUZZ: disable check_for_streams_include
# include "ace/streams.h"
#endif /* ! ACE_LACKS_IOSTREAM_TOTALLY */

#if defined (ACE_HAS_TRACE)
# include "ace/Trace.h"
#endif /* ACE_HAS_TRACE */

#include "ace/Log_Msg.h"
#include "ace/Log_Msg_Callback.h"
#include "ace/Log_Msg_IPC.h"
#include "ace/Log_Msg_NT_Event_Log.h"
#include "ace/Log_Msg_UNIX_Syslog.h"
#include "ace/Log_Record.h"
#include "ace/Recursive_Thread_Mutex.h"
#include "ace/Stack_Trace.h"
#include "ace/Atomic_Op.h"

#include <algorithm>

#if !defined (__ACE_INLINE__)
#include "ace/Log_Msg.inl"
#endif /* __ACE_INLINE__ */

#ifdef ACE_ANDROID
#  include "ace/Log_Msg_Android_Logcat.h"
#endif

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE(ACE_Log_Msg)

#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
  bool ACE_Log_Msg::key_created_ = 0;
# if defined (ACE_HAS_THREAD_SPECIFIC_STORAGE) || \
    defined (ACE_HAS_TSS_EMULATION)

static ACE_thread_key_t the_log_msg_tss_key;

ACE_thread_key_t *log_msg_tss_key (void)
{
  return &the_log_msg_tss_key;
}

# endif /* ACE_HAS_THREAD_SPECIFIC_STORAGE || ACE_HAS_TSS_EMULATION */
#else
static ACE_Cleanup_Adapter<ACE_Log_Msg>* log_msg_cleanup = 0;
class ACE_Msg_Log_Cleanup: public ACE_Cleanup_Adapter<ACE_Log_Msg>
{
public:
  virtual ~ACE_Msg_Log_Cleanup (void) {
    if (this == log_msg_cleanup)
      log_msg_cleanup = 0;
  }
};
#endif /* ACE_MT_SAFE */

#if defined (ACE_WIN32) && !defined (ACE_HAS_WINCE) && !defined (ACE_HAS_PHARLAP)
#  define ACE_LOG_MSG_SYSLOG_BACKEND ACE_Log_Msg_NT_Event_Log
#elif defined (ACE_ANDROID)
#  define ACE_LOG_MSG_SYSLOG_BACKEND ACE_Log_Msg_Android_Logcat
#elif !defined (ACE_LACKS_UNIX_SYSLOG) && !defined (ACE_HAS_WINCE)
#  define ACE_LOG_MSG_SYSLOG_BACKEND ACE_Log_Msg_UNIX_Syslog
#endif

// When doing ACE_OS::s[n]printf() calls in log(), we need to update
// the space remaining in the output buffer based on what's returned from
// the output function. If we could rely on more modern compilers, this
// would be in an unnamed namespace, but it's a macro instead.
// count is a size_t, len is an int and assumed to be non-negative.
#define ACE_UPDATE_COUNT(COUNT, LEN) \
   do { if (static_cast<size_t> (LEN) > COUNT) COUNT = 0; \
     else COUNT -= static_cast<size_t> (LEN); \
   } while (0)

/// Instance count for Log_Msg - used to know when dynamically
/// allocated storage (program name and host name) can be safely
/// deleted.
int ACE_Log_Msg::instance_count_ = 0;

/**
 * @class ACE_Log_Msg_Manager
 *
 * @brief Synchronize output operations.
 *
 * Provides global point of contact for all ACE_Log_Msg instances
 * in a process.
 *
 * For internal use by ACE, only!
 */
class ACE_Log_Msg_Manager
{
public:
  static ACE_Log_Msg_Backend *log_backend_;
  static ACE_Log_Msg_Backend *custom_backend_;

  static u_long log_backend_flags_;

  static int init_backend (const u_long *flags = 0);

#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
  //FUZZ: disable check_for_lack_ACE_OS
  static void close (void) ACE_GCC_DESTRUCTOR_ATTRIBUTE;
  //FUZZ: enable check_for_lack_ACE_OS

  static ACE_Recursive_Thread_Mutex *get_lock (void);

private:
  static ACE_Recursive_Thread_Mutex *lock_;
#endif /* ! ACE_MT_SAFE */
};

ACE_Log_Msg_Backend *ACE_Log_Msg_Manager::log_backend_ = 0;
ACE_Log_Msg_Backend *ACE_Log_Msg_Manager::custom_backend_ = 0;

#ifndef ACE_DEFAULT_LOG_BACKEND_FLAGS
#  ifdef ACE_ANDROID
#    define ACE_DEFAULT_LOG_BACKEND_FLAGS ACE_Log_Msg::SYSLOG
#  else
#    define ACE_DEFAULT_LOG_BACKEND_FLAGS 0
#  endif
#endif

u_long ACE_Log_Msg_Manager::log_backend_flags_ = ACE_DEFAULT_LOG_BACKEND_FLAGS;

int ACE_Log_Msg_Manager::init_backend (const u_long *flags)
{
  // If flags have been supplied, and they are different from the flags
  // we had last time, then we may have to re-create the backend as a
  // different type.
  if (flags)
    {
      // Sanity check for custom backend.
      if (ACE_BIT_ENABLED (*flags, ACE_Log_Msg::CUSTOM) &&
          ACE_Log_Msg_Manager::custom_backend_ == 0)
        {
          return -1;
        }

      if ((ACE_BIT_ENABLED (*flags, ACE_Log_Msg::SYSLOG)
            && ACE_BIT_DISABLED (ACE_Log_Msg_Manager::log_backend_flags_, ACE_Log_Msg::SYSLOG))
          || (ACE_BIT_DISABLED (*flags, ACE_Log_Msg::SYSLOG)
            && ACE_BIT_ENABLED (ACE_Log_Msg_Manager::log_backend_flags_, ACE_Log_Msg::SYSLOG)))
        {
          delete ACE_Log_Msg_Manager::log_backend_;
          ACE_Log_Msg_Manager::log_backend_ = 0;
        }

      ACE_Log_Msg_Manager::log_backend_flags_ = *flags;
    }

  if (ACE_Log_Msg_Manager::log_backend_ == 0)
    {
#ifdef ACE_LOG_MSG_SYSLOG_BACKEND
      // Allocate the ACE_Log_Msg_Backend instance.
      if (ACE_BIT_ENABLED (ACE_Log_Msg_Manager::log_backend_flags_, ACE_Log_Msg::SYSLOG))
        ACE_NEW_RETURN (ACE_Log_Msg_Manager::log_backend_,
                        ACE_LOG_MSG_SYSLOG_BACKEND,
                        -1);
      else
#endif
        ACE_NEW_RETURN (ACE_Log_Msg_Manager::log_backend_,
                        ACE_Log_Msg_IPC,
                        -1);
    }

  return 0;
}

#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
ACE_Recursive_Thread_Mutex *ACE_Log_Msg_Manager::lock_ = 0;

ACE_Recursive_Thread_Mutex *
ACE_Log_Msg_Manager::get_lock (void)
{
  // This function is called by the first thread to create an ACE_Log_Msg
  // instance.  It makes the call while holding a mutex, so we don't have
  // to grab another one here.
  if (ACE_Log_Msg_Manager::lock_ == 0)
    {
      ACE_NEW_RETURN (ACE_Log_Msg_Manager::lock_,
                      ACE_Recursive_Thread_Mutex,
                      0);
    }

  if (init_backend () == -1)
    return 0;

  return ACE_Log_Msg_Manager::lock_;
}

void
ACE_Log_Msg_Manager::close (void)
{
#if defined (ACE_HAS_STHREADS) && ! defined (ACE_HAS_TSS_EMULATION) && ! defined (ACE_HAS_EXCEPTIONS)
  // Delete the (main thread's) Log_Msg instance.  I think that this
  // is only "necessary" if exception handling is not enabled.
  // Without exception handling, main thread TSS destructors don't
  // seem to be called.  It's not really necessary anyways, because
  // this one leak is harmless on Solaris.
  delete ACE_Log_Msg::instance ();
#endif /* ACE_HAS_STHREADS && ! TSS_EMULATION && ! ACE_HAS_EXCEPTIONS */

  // Ugly, ugly, but don't know a better way.
  delete ACE_Log_Msg_Manager::lock_;
  ACE_Log_Msg_Manager::lock_ = 0;

  delete ACE_Log_Msg_Manager::log_backend_;
  ACE_Log_Msg_Manager::log_backend_ = 0;

  // we are never responsible for custom backend
  ACE_Log_Msg_Manager::custom_backend_ = 0;
}

# if defined (ACE_HAS_THREAD_SPECIFIC_STORAGE) || \
     defined (ACE_HAS_TSS_EMULATION)
/* static */
#  if defined (ACE_HAS_THR_C_DEST)
#   define LOCAL_EXTERN_PREFIX extern "C"
#  else
#   define LOCAL_EXTERN_PREFIX
#  endif /* ACE_HAS_THR_C_DEST */
LOCAL_EXTERN_PREFIX
void
ACE_TSS_CLEANUP_NAME (void *ptr)
{
  if (ptr != 0)
    {
      // Delegate to thr_desc if this not has terminated
      ACE_Log_Msg *log_msg = (ACE_Log_Msg *) ptr;
      if (log_msg->thr_desc () != 0)
        log_msg->thr_desc ()->log_msg_cleanup (log_msg);
      else
        delete log_msg;
    }
}
# endif /* ACE_HAS_THREAD_SPECIFIC_STORAGE || ACE_HAS_TSS_EMULATION */
#endif /* ! ACE_MT_SAFE */

/* static */
int
ACE_Log_Msg::exists (void)
{
#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
# if defined (ACE_HAS_THREAD_SPECIFIC_STORAGE) || \
     defined (ACE_HAS_TSS_EMULATION)
  void *tss_log_msg = 0; // The actual type is ACE_Log_Msg*, but we need this
                         // void to keep G++ from complaining.

  // Get the tss_log_msg from thread-specific storage.
  return ACE_Log_Msg::key_created_
    && ACE_Thread::getspecific (*(log_msg_tss_key ()), &tss_log_msg) != -1
    && tss_log_msg != 0;
# else
#   error "Platform must support thread-specific storage if threads are used."
# endif /* ACE_HAS_THREAD_SPECIFIC_STORAGE || ACE_HAS_TSS_EMULATION */
#else  /* ! ACE_MT_SAFE */
  return 1;
#endif /* ! ACE_MT_SAFE */
}

ACE_Log_Msg *
ACE_Log_Msg::instance (void)
{
#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
# if defined (ACE_HAS_THREAD_SPECIFIC_STORAGE) || \
     defined (ACE_HAS_TSS_EMULATION)
  // TSS Singleton implementation.

  if (!ACE_Log_Msg::key_created_)
    {
      ACE_thread_mutex_t *lock =
        reinterpret_cast<ACE_thread_mutex_t *> (
          ACE_OS_Object_Manager::preallocated_object
            [ACE_OS_Object_Manager::ACE_LOG_MSG_INSTANCE_LOCK]);

      if (1 == ACE_OS_Object_Manager::starting_up())
        //This function is called before ACE_OS_Object_Manager is
        //initialized.  So the lock might not be valid.  Assume it's
        //single threaded and so don't need the lock.
        ;
      else
        ACE_OS::thread_mutex_lock (lock);

      if (!ACE_Log_Msg::key_created_)
        {
          // Allocate the Singleton lock.
          ACE_Log_Msg_Manager::get_lock ();

          if (ACE_Thread::keycreate (log_msg_tss_key (),
                                      &ACE_TSS_CLEANUP_NAME) != 0)
            {
              if (1 == ACE_OS_Object_Manager::starting_up())
                //This function is called before ACE_OS_Object_Manager is
                //initialized.  So the lock might not be valid.  Assume it's
                //single threaded and so don't need the lock.
                ;
              else
                ACE_OS::thread_mutex_unlock (lock);
              return 0; // Major problems, this should *never* happen!
            }

          ACE_Log_Msg::key_created_ = true;
        }

      if (1 == ACE_OS_Object_Manager::starting_up())
        //This function is called before ACE_OS_Object_Manager is
        //initialized.  So the lock might not be valid.  Assume it's
        //single threaded and so don't need the lock.
        ;
      else
        ACE_OS::thread_mutex_unlock (lock);
    }

  ACE_Log_Msg *tss_log_msg = 0;
  void *temp = 0;

  // Get the tss_log_msg from thread-specific storage.
  if (ACE_Thread::getspecific (*(log_msg_tss_key ()), &temp) == -1)
    return 0; // This should not happen!

  tss_log_msg = static_cast <ACE_Log_Msg *> (temp);

  // Check to see if this is the first time in for this thread.
  if (tss_log_msg == 0)
    {
      // Allocate memory off the heap and store it in a pointer in
      // thread-specific storage (on the stack...).  The memory will
      // always be freed by the thread rundown because of the TSS
      // callback set up when the key was created.
      ACE_NEW_RETURN (tss_log_msg,
                      ACE_Log_Msg,
                      0);
      // Store the dynamically allocated pointer in thread-specific
      // storage.  It gets deleted via the ACE_TSS_cleanup function
      // when the thread terminates.

      if (ACE_Thread::setspecific (*(log_msg_tss_key()),
                                    reinterpret_cast<void *> (tss_log_msg))
          != 0)
        return 0; // Major problems, this should *never* happen!
    }

  return tss_log_msg;
# else
#  error "Platform must support thread-specific storage if threads are used."
# endif /* ACE_HAS_THREAD_SPECIFIC_STORAGE || ACE_HAS_TSS_EMULATION */
#else  /* ! ACE_MT_SAFE */
  // We don't have threads, we cannot call
  // ACE_Log_Msg_Manager::get_lock () to initialize the logger
  // callback, so instead we do it here.
  if (ACE_Log_Msg_Manager::init_backend () == -1)
    return 0;

  // Singleton implementation.

  if (log_msg_cleanup == 0)
    {
      ACE_NEW_RETURN (log_msg_cleanup, ACE_Msg_Log_Cleanup, 0);
      // Register the instance for destruction at program termination.
      ACE_Object_Manager::at_exit (log_msg_cleanup,
                                   0,
                                   typeid (*log_msg_cleanup).name ());
    }

  return &log_msg_cleanup->object ();
#endif /* ! ACE_MT_SAFE */
}

// Not inlined to help prevent having to include OS.h just to
// get ACELIB_DEBUG, et al, macros.
int
ACE_Log_Msg::last_error_adapter (void)
{
  return ACE_OS::last_error ();
}

// Sets the flag in the default priority mask used to initialize
// ACE_Log_Msg instances, as well as the current per-thread instance.

void
ACE_Log_Msg::enable_debug_messages (ACE_Log_Priority priority)
{
  ACE_SET_BITS (ACE_Log_Msg::default_priority_mask_, priority);
  ACE_Log_Msg *i = ACE_Log_Msg::instance ();
  i->priority_mask (i->priority_mask () | priority);
}

// Clears the flag in the default priority mask used to initialize
// ACE_Log_Msg instances, as well as the current per-thread instance.

void
ACE_Log_Msg::disable_debug_messages (ACE_Log_Priority priority)
{
  ACE_CLR_BITS (ACE_Log_Msg::default_priority_mask_, priority);
  ACE_Log_Msg *i = ACE_Log_Msg::instance ();
  i->priority_mask (i->priority_mask () & ~priority);
}

const ACE_TCHAR *
ACE_Log_Msg::program_name (void)
{
  return ACE_Log_Msg::program_name_;
}

/// Name of the local host.
const ACE_TCHAR *ACE_Log_Msg::local_host_ = 0;

/// Records the program name.
const ACE_TCHAR *ACE_Log_Msg::program_name_ = 0;

/// Default is to use stderr.
u_long ACE_Log_Msg::flags_ = ACE_DEFAULT_LOG_FLAGS;

/// Current offset of msg_[].
ptrdiff_t ACE_Log_Msg::msg_off_ = 0;

/// Default per-thread priority mask
/// By default, no priorities are enabled.
u_long ACE_Log_Msg::default_priority_mask_ = 0;

/// Default per-process priority mask
/// By default, all priorities are enabled.
u_long ACE_Log_Msg::process_priority_mask_ = LM_SHUTDOWN
                                             | LM_TRACE
                                             | LM_DEBUG
                                             | LM_INFO
                                             | LM_NOTICE
                                             | LM_WARNING
                                             | LM_STARTUP
                                             | LM_ERROR
                                             | LM_CRITICAL
                                             | LM_ALERT
                                             | LM_EMERGENCY;

void
ACE_Log_Msg::close (void)
{
  // This call needs to go here to avoid memory leaks.
  ACE_MT (ACE_Log_Msg_Manager::close ());

  // Please note that this will be called by a statement that is
  // harded coded into the ACE_Object_Manager's shutdown sequence, in
  // its destructor.

#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0) && \
    (defined (ACE_HAS_THREAD_SPECIFIC_STORAGE) || \
     defined (ACE_HAS_TSS_EMULATION))

  if (ACE_Log_Msg::key_created_)
    {
      ACE_thread_mutex_t *lock =
        reinterpret_cast<ACE_thread_mutex_t *>
  (ACE_OS_Object_Manager::preallocated_object
   [ACE_OS_Object_Manager::ACE_LOG_MSG_INSTANCE_LOCK]);
      if (lock)
        ACE_OS::thread_mutex_lock (lock);

     if (ACE_Log_Msg::key_created_)
       {
         // Clean up this ACE_Log_Msg instance and reset the TSS to
         // prevent any future cleanup attempts via TSS mechanisms at
         // thread exit. Otherwise in the event of a dynamic library
         // unload of libACE, by a program not linked with libACE,
         // ACE_TSS_cleanup will be invoked after libACE has been unloaded.
         // See Bugzilla 2980 for lots of details.
         void *temp = 0;

         // Get the tss_log_msg from thread-specific storage.
         if (ACE_Thread::getspecific (*(log_msg_tss_key ()), &temp) != -1
             && temp)
           {
             ACE_Log_Msg *tss_log_msg = static_cast <ACE_Log_Msg *> (temp);
             // we haven't been cleaned up
             ACE_TSS_CLEANUP_NAME(tss_log_msg);
             if (ACE_Thread::setspecific(*(log_msg_tss_key()),
                                         reinterpret_cast <void *>(0)) != 0)
               ACE_OS::printf ("ACE_Log_Msg::close failed to ACE_Thread::setspecific to 0\n");
           }

         // The key is not needed any longer; ACE_Log_Msg is closing
         // and will need to be reopened if this process wishes to use
         // logging again. So delete the key.
         ACE_Thread::keyfree (*(log_msg_tss_key()));
         ACE_Log_Msg::key_created_ = false;
       }

     if (lock)
       ACE_OS::thread_mutex_unlock (lock);
    }
#endif /* (ACE_HAS_THREAD_SPECIFIC_STORAGE || ACE_HAS_TSS_EMULATION) && ACE_MT_SAFE */
}

void
ACE_Log_Msg::sync_hook (const ACE_TCHAR *prg_name)
{
  ACE_LOG_MSG->sync (prg_name);
}

ACE_OS_Thread_Descriptor *
ACE_Log_Msg::thr_desc_hook (void)
{
  return ACE_LOG_MSG->thr_desc ();
}

// Call after a fork to resynchronize the PID and PROGRAM_NAME
// variables.
void
ACE_Log_Msg::sync (const ACE_TCHAR *prog_name)
{
  ACE_TRACE ("ACE_Log_Msg::sync");

  if (prog_name)
    {
      // Must free if already allocated!!!
#if defined (ACE_HAS_ALLOC_HOOKS)
      ACE_Allocator::instance()->free ((void *) ACE_Log_Msg::program_name_);
#else
      ACE_OS::free ((void *) ACE_Log_Msg::program_name_);
#endif /* ACE_HAS_ALLOC_HOOKS */

      ACE_Log_Msg::program_name_ = ACE_OS::strdup (prog_name);
    }

  ACE_Log_Msg::msg_off_ = 0;
}

u_long
ACE_Log_Msg::flags (void)
{
  ACE_TRACE ("ACE_Log_Msg::flags");
  u_long result;
  ACE_MT (ACE_GUARD_RETURN (ACE_Recursive_Thread_Mutex, ace_mon,
                            *ACE_Log_Msg_Manager::get_lock (), 0));

  result = ACE_Log_Msg::flags_;
  return result;
}

void
ACE_Log_Msg::set_flags (u_long flgs)
{
  ACE_TRACE ("ACE_Log_Msg::set_flags");
  ACE_MT (ACE_GUARD (ACE_Recursive_Thread_Mutex, ace_mon,
                     *ACE_Log_Msg_Manager::get_lock ()));

  ACE_SET_BITS (ACE_Log_Msg::flags_, flgs);
}

void
ACE_Log_Msg::clr_flags (u_long flgs)
{
  ACE_TRACE ("ACE_Log_Msg::clr_flags");
  ACE_MT (ACE_GUARD (ACE_Recursive_Thread_Mutex, ace_mon,
                     *ACE_Log_Msg_Manager::get_lock ()));

  ACE_CLR_BITS (ACE_Log_Msg::flags_, flgs);
}

int
ACE_Log_Msg::acquire (void)
{
  ACE_TRACE ("ACE_Log_Msg::acquire");
#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
  return ACE_Log_Msg_Manager::get_lock ()->acquire ();
#else  /* ! ACE_MT_SAFE */
  return 0;
#endif /* ! ACE_MT_SAFE */
}

u_long
ACE_Log_Msg::priority_mask (u_long n_mask, MASK_TYPE mask_type)
{
  u_long o_mask;

  if (mask_type == THREAD)
    {
      o_mask = this->priority_mask_;
      this->priority_mask_ = n_mask;
    }
  else
    {
      o_mask = ACE_Log_Msg::process_priority_mask_;
      ACE_Log_Msg::process_priority_mask_ = n_mask;
    }

  return o_mask;
}

int
ACE_Log_Msg::release (void)
{
  ACE_TRACE ("ACE_Log_Msg::release");

#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
  return ACE_Log_Msg_Manager::get_lock ()->release ();
#else  /* ! ACE_MT_SAFE */
  return 0;
#endif /* ! ACE_MT_SAFE */
}

ACE_Log_Msg::ACE_Log_Msg (void)
  : status_ (0),
    errnum_ (0),
    linenum_ (0),
    msg_ (0),
    restart_ (1),  // Restart by default...
    ostream_ (0),
    ostream_refcount_ (0),
    msg_callback_ (0),
    trace_depth_ (0),
    trace_active_ (false),
    tracing_enabled_ (true), // On by default?
    thr_desc_ (0),
    priority_mask_ (default_priority_mask_),
    timestamp_ (0)
{
  // ACE_TRACE ("ACE_Log_Msg::ACE_Log_Msg");

  ACE_MT (ACE_GUARD (ACE_Recursive_Thread_Mutex, ace_mon,
                     *ACE_Log_Msg_Manager::get_lock ()));
  ++instance_count_;

  if (this->instance_count_ == 1)
    ACE_Base_Thread_Adapter::set_log_msg_hooks (ACE_Log_Msg::init_hook,
                                                ACE_Log_Msg::inherit_hook,
                                                ACE_Log_Msg::close,
                                                ACE_Log_Msg::sync_hook,
                                                ACE_Log_Msg::thr_desc_hook);

  this->conditional_values_.is_set_ = false;

  char *timestamp = ACE_OS::getenv ("ACE_LOG_TIMESTAMP");
  if (timestamp != 0)
    {
      // If variable is set or is set to date tag so we print date and time.
      if (ACE_OS::strcmp (timestamp, "TIME") == 0)
        {
          this->timestamp_ = 1;
        }
      else if (ACE_OS::strcmp (timestamp, "DATE") == 0)
        {
          this->timestamp_ = 2;
        }
    }

#if defined (ACE_HAS_ALLOC_HOOKS)
  ACE_ALLOCATOR_NORETURN (this->msg_, static_cast<ACE_TCHAR *>(ACE_Allocator::instance()->malloc(sizeof(ACE_TCHAR) * (ACE_MAXLOGMSGLEN+1))));
#else
  ACE_NEW_NORETURN (this->msg_, ACE_TCHAR[ACE_MAXLOGMSGLEN+1]);
#endif /* ACE_HAS_ALLOC_HOOKS */
}

ACE_Log_Msg::~ACE_Log_Msg (void)
{
#if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)

  int instance_count = 0;

  // Only hold the guard while updating the instance_count_.
  // If ACE_Log_Msg_Manager::close () is called, the lock will
  // be deleted.
  {
    ACE_MT (ACE_GUARD (ACE_Recursive_Thread_Mutex, ace_mon,
                       *ACE_Log_Msg_Manager::get_lock ()));
    instance_count = --instance_count_;
  }
  // Release the guard.

#else  /* ! ACE_MT_SAFE */
  int instance_count = --instance_count_;
#endif /* ! ACE_MT_SAFE */

  // If this is the last instance then cleanup.  Only the last
  // thread to destroy its ACE_Log_Msg instance should execute
  // this block.
  if (instance_count == 0)
    {
      // Destroy the message queue instance.
      if (ACE_Log_Msg_Manager::log_backend_ != 0)
        ACE_Log_Msg_Manager::log_backend_->close ();

      // Close down custom backend
      if (ACE_Log_Msg_Manager::custom_backend_ != 0)
        ACE_Log_Msg_Manager::custom_backend_->close ();

#     if defined (ACE_MT_SAFE) && (ACE_MT_SAFE != 0)
#       if defined (ACE_HAS_TSS_EMULATION)
          ACE_Log_Msg_Manager::close ();
#       endif /* ACE_HAS_TSS_EMULATION */
#     endif /* ACE_MT_SAFE */

      if (ACE_Log_Msg::program_name_)
        {
#if defined (ACE_HAS_ALLOC_HOOKS)
          ACE_Allocator::instance()->free ((void *) ACE_Log_Msg::program_name_);
#else
          ACE_OS::free ((void *) ACE_Log_Msg::program_name_);
#endif /* ACE_HAS_ALLOC_HOOKS */
          ACE_Log_Msg::program_name_ = 0;
        }

      if (ACE_Log_Msg::local_host_)
        {
#if defined (ACE_HAS_ALLOC_HOOKS)
          ACE_Allocator::instance()->free ((void *) ACE_Log_Msg::local_host_);
#else
          ACE_OS::free ((void *) ACE_Log_Msg::local_host_);
#endif /* ACE_HAS_ALLOC_HOOKS */
          ACE_Log_Msg::local_host_ = 0;
        }
    }

  this->cleanup_ostream ();

#if defined (ACE_HAS_ALLOC_HOOKS)
  ACE_Allocator::instance()->free(this->msg_);
#else
  delete[] this->msg_;
#endif /* ACE_HAS_ALLOC_HOOKS */
}

void
ACE_Log_Msg::cleanup_ostream ()
{
  if (this->ostream_refcount_)
    {
      if (--*this->ostream_refcount_ == 0)
        {
#if defined (ACE_HAS_ALLOC_HOOKS)
          this->ostream_refcount_->~Atomic_ULong();
          ACE_Allocator::instance()->free(this->ostream_refcount_);
#else
          delete this->ostream_refcount_;
#endif /* ACE_HAS_ALLOC_HOOKS */
#if defined (ACE_LACKS_IOSTREAM_TOTALLY)
          ACE_OS::fclose (this->ostream_);
#else
          delete this->ostream_;
          this->ostream_ = 0;
#endif
        }
      this->ostream_refcount_ = 0;
    }
}

// Open the sender-side of the message queue.
int
ACE_Log_Msg::open (const ACE_TCHAR *prog_name,
                   u_long flags,
                   const ACE_TCHAR *logger_key)
{
  ACE_TRACE ("ACE_Log_Msg::open");
  ACE_MT (ACE_GUARD_RETURN (ACE_Recursive_Thread_Mutex, ace_mon,
                            *ACE_Log_Msg_Manager::get_lock (), -1));

  if (prog_name)
    {
#if defined(ACE_HAS_ALLOC_HOOKS)
      ACE_Allocator::instance()->free ((void *) ACE_Log_Msg::program_name_);
#else
      ACE_OS::free ((void *) ACE_Log_Msg::program_name_);
#endif /* ACE_HAS_ALLOC_HOOKS */

      ACE_ALLOCATOR_RETURN (ACE_Log_Msg::program_name_,
                            ACE_OS::strdup (prog_name),
                            -1);
    }
  else if (ACE_Log_Msg::program_name_ == 0)
    {
      ACE_ALLOCATOR_RETURN (ACE_Log_Msg::program_name_,
                            ACE_OS::strdup (ACE_TEXT ("<unknown>")),
                            -1);
    }

  int status = 0;

  // Be sure that there is a message_queue_, with multiple threads.
  ACE_MT (ACE_Log_Msg_Manager::init_backend (&flags));

  // Always close the current handle before doing anything else.
  if (ACE_Log_Msg_Manager::log_backend_ != 0)
    ACE_Log_Msg_Manager::log_backend_->reset ();

  if (ACE_Log_Msg_Manager::custom_backend_ != 0)
    ACE_Log_Msg_Manager::custom_backend_->reset ();

  // Note that if we fail to open the message queue the default action
  // is to use stderr (set via static initialization in the
  // Log_Msg.cpp file).

  if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::LOGGER)
      || ACE_BIT_ENABLED (flags, ACE_Log_Msg::SYSLOG))
    {
      // The SYSLOG backends (both NT and UNIX) can get along fine
      // without the logger_key - they will default to prog_name if
      // logger key is 0.
      if (logger_key == 0 && ACE_BIT_ENABLED (flags, ACE_Log_Msg::LOGGER))
        status = -1;
      else
        status = ACE_Log_Msg_Manager::log_backend_->open (logger_key);

      if (status == -1)
        ACE_SET_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::STDERR);
      else
        {
          if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::LOGGER))
            ACE_SET_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::LOGGER);
          if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::SYSLOG))
            ACE_SET_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::SYSLOG);
        }
    }
  else if (ACE_BIT_ENABLED (ACE_Log_Msg::flags_, ACE_Log_Msg::LOGGER)
           || ACE_BIT_ENABLED (ACE_Log_Msg::flags_, ACE_Log_Msg::SYSLOG))
    {
      // If we are closing down logger, redirect logging to stderr.
      ACE_CLR_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::LOGGER);
      ACE_CLR_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::SYSLOG);
      ACE_SET_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::STDERR);
    }

  if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::CUSTOM))
    {
      status =
        ACE_Log_Msg_Manager::custom_backend_->open (logger_key);

      if (status != -1)
        ACE_SET_BITS (ACE_Log_Msg::flags_, ACE_Log_Msg::CUSTOM);
    }

  // Remember, ACE_Log_Msg::STDERR bit is on by default...
  if (status != -1
      && ACE_BIT_ENABLED (flags,
                          ACE_Log_Msg::STDERR) == 0)
    ACE_CLR_BITS (ACE_Log_Msg::flags_,
                  ACE_Log_Msg::STDERR);

  // VERBOSE takes precedence over VERBOSE_LITE...
  if (ACE_BIT_ENABLED (flags,
                       ACE_Log_Msg::VERBOSE_LITE))
    ACE_SET_BITS (ACE_Log_Msg::flags_,
                  ACE_Log_Msg::VERBOSE_LITE);
  else if (ACE_BIT_ENABLED (flags,
                            ACE_Log_Msg::VERBOSE))
    ACE_SET_BITS (ACE_Log_Msg::flags_,
                  ACE_Log_Msg::VERBOSE);

  if (ACE_BIT_ENABLED (flags,
                       ACE_Log_Msg::OSTREAM))
    {
      ACE_SET_BITS (ACE_Log_Msg::flags_,
                    ACE_Log_Msg::OSTREAM);
      // Only set this to cerr if it hasn't already been set.
      if (this->msg_ostream () == 0)
        this->msg_ostream (ACE_DEFAULT_LOG_STREAM);
    }

  if (ACE_BIT_ENABLED (flags,
                       ACE_Log_Msg::MSG_CALLBACK))
    ACE_SET_BITS (ACE_Log_Msg::flags_,
                  ACE_Log_Msg::MSG_CALLBACK);

  if (ACE_BIT_ENABLED (flags,
                       ACE_Log_Msg::SILENT))
    ACE_SET_BITS (ACE_Log_Msg::flags_,
                  ACE_Log_Msg::SILENT);

  return status;
}

#ifndef ACE_LACKS_VA_FUNCTIONS
/**
 * Valid Options (prefixed by '%', as in printf format strings) include:
 *   'A': print an ACE_timer_t value
 *   'a': exit the program at this point (var-argument is the exit status!)
 *   'b': print a ssize_t value
 *   'B': print a size_t value
 *   'c': print a character
 *   'C': print a character string
 *   'i', 'd': print a decimal number
 *   'I', indent according to nesting depth
 *   'e', 'E', 'f', 'F', 'g', 'G': print a double
 *   'l', print line number where an error occurred.
 *   'M': print the name of the priority of the message.
 *   'm': Return the message corresponding to errno value, e.g., as done by <strerror>
 *   'N': print file name where the error occurred.
 *   'n': print the name of the program (or "<unknown>" if not set)
 *   'o': print as an octal number
 *   'P': format the current process id
 *   'p': format the appropriate errno message from sys_errlist, e.g., as done by <perror>
 *   'Q': print out the uint64 number
 *   'q': print out the int64 number
 *   '@': print a void* pointer (in hexadecimal)
 *   'r': call the function pointed to by the corresponding argument
 *   'R': print return status
 *   'S': print out the appropriate signal message corresponding
 *        to var-argument, e.g., as done by strsignal()
 *   's': format a character string
 *   'T': print timestamp in hour:minute:sec:usec format.
 *   'D': print timestamp in month/day/year hour:minute:sec:usec format.
 *   't': print thread id (1 if single-threaded)
 *   'u': print as unsigned int
 *   'x': print as a hex number
 *   'X': print as a hex number
 *   'w': print a wide character
 *   'W': print out a wide character string.
 *   'z': print an ACE_OS::WChar character
 *   'Z': print an ACE_OS::WChar character string
 *   ':': print a time_t value as an integral number
 *   '%': format a single percent sign, '%'
 */
ssize_t
ACE_Log_Msg::log (ACE_Log_Priority log_priority,
                  const ACE_TCHAR *format_str, ...)
{
  ACE_TRACE ("ACE_Log_Msg::log");
  // Start of variable args section.
  va_list argp;

  va_start (argp, format_str);

  ssize_t const result = this->log (format_str,
                                    log_priority,
                                    argp);
  va_end (argp);

  return result;
}

#if defined (ACE_HAS_WCHAR)
/**
 * Since this is the ANTI_TCHAR version, we need to convert
 * the format string over.
 */
ssize_t
ACE_Log_Msg::log (ACE_Log_Priority log_priority,
                  const ACE_ANTI_TCHAR *format_str, ...)
{
  ACE_TRACE ("ACE_Log_Msg::log");

  // Start of variable args section.
  va_list argp;

  va_start (argp, format_str);

  ssize_t const result = this->log (ACE_TEXT_ANTI_TO_TCHAR (format_str),
                                    log_priority,
                                    argp);
  va_end (argp);

  return result;
}
#endif /* ACE_HAS_WCHAR */

#endif /* ACE_LACKS_VA_FUNCTIONS */

#if defined ACE_HAS_STRERROR_R && defined ACE_LACKS_STRERROR
#define ACE_LOG_MSG_USE_STRERROR_R
#endif

ssize_t
ACE_Log_Msg::log (const ACE_TCHAR *format_str,
                  ACE_Log_Priority log_priority,
                  va_list argp,
                  ACE_Log_Category_TSS* category)
{
  ACE_TRACE ("ACE_Log_Msg::log");
#if defined (ACE_LACKS_VA_FUNCTIONS)
  ACE_UNUSED_ARG (log_priority);
  ACE_UNUSED_ARG (format_str);
  ACE_UNUSED_ARG (argp);
  ACE_UNUSED_ARG (category);
  ACE_NOTSUP_RETURN (-1);
#else
  // External decls.

  typedef void (*PointerToFunction)(...);

  // Check if there were any conditional values set.
  bool const conditional_values = this->conditional_values_.is_set_;

  // Reset conditional values.
  this->conditional_values_.is_set_ = false;

  // Only print the message if <priority_mask_> hasn't been reset to
  // exclude this logging priority.
  if (this->log_priority_enabled (log_priority) == 0)
    return 0;

  // If conditional values were set and the log priority is correct,
  // then the values are actually set.
  if (conditional_values)
    this->set (this->conditional_values_.file_,
               this->conditional_values_.line_,
               this->conditional_values_.op_status_,
               this->conditional_values_.errnum_,
               this->restart (),
               this->msg_ostream (),
               this->msg_callback ());

  // Logging is supposed to be a benign activity (i.e., not interfer
  // with normal application operations), so don't inadvertently smash
  // errno!
  ACE_Errno_Guard guard (errno);

  ACE_Log_Record log_record (log_priority,
                             ACE_OS::gettimeofday (),
                             this->getpid ());

  log_record.category(category);

  // bp is pointer to where to put next part of logged message.
  // bspace is the number of characters remaining in msg_.
  ACE_TCHAR *bp = const_cast<ACE_TCHAR *> (this->msg ());
  size_t bspace = ACE_MAXLOGMSGLEN;  // Leave room for Nul term.
  if (this->msg_off_ <= ACE_Log_Record::MAXLOGMSGLEN)
    bspace -= static_cast<size_t> (this->msg_off_);

  // If this platform has snprintf() capability to prevent overrunning the
  // output buffer, use it. To avoid adding a maintenance-hassle compile-
  // time couple between here and OS.cpp, don't try to figure this out at
  // compile time. Instead, do a quick check now; if we get a -1 return,
  // the platform doesn't support the length-limiting capability.
  ACE_TCHAR test[2];
  bool can_check = ACE_OS::snprintf (test, 1, ACE_TEXT ("x")) != -1;

  bool abort_prog = false;
  int exit_value = 0;

  // Retrieve the flags in a local variable on the stack, it is
  // accessed by multiple threads and within this operation we
  // check it several times, so this way we only lock once
  u_long flags = this->flags ();

  if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::VERBOSE))
    {
      // Prepend the program name onto this message
      if (ACE_Log_Msg::program_name_ != 0)
        {
          for (const ACE_TCHAR *s = ACE_Log_Msg::program_name_;
               bspace > 1 && (*bp = *s) != '\0';
               ++s, --bspace)
            bp++;

          *bp++ = '|';
          --bspace;
        }
    }

  if (timestamp_ > 0)
    {
      ACE_TCHAR day_and_time[27];
      const ACE_TCHAR *s = 0;
      if (timestamp_ == 1)
        {
          // Print just the time
          s = ACE::timestamp (day_and_time,
                              sizeof (day_and_time) / sizeof (ACE_TCHAR),
                              true);
        }
      else
        {
          // Print time and date
          ACE::timestamp (day_and_time,
                          sizeof (day_and_time) / sizeof (ACE_TCHAR));
          s = day_and_time;
        }

      for (; bspace > 1 && (*bp = *s) != '\0'; ++s, --bspace)
        ++bp;

      *bp++ = '|';
      --bspace;
    }

  while (*format_str != '\0' && bspace > 0)
    {
      // Copy input to output until we encounter a %, however a
      // % followed by another % is not a format specification.

      if (*format_str != '%')
        {
          *bp++ = *format_str++;
          --bspace;
        }
      else if (format_str[1] == '%') // An "escaped" '%' (just print one '%').
        {
          *bp++ = *format_str++;    // Store first %
          ++format_str;             // but skip second %
          --bspace;
        }
      else
        {
          // This is most likely a format specification that ends with
          // one of the valid options described previously. To enable full
          // use of all sprintf capabilities, save the format specifier
          // from the '%' up to the format letter in a new char array.
          // This allows the full sprintf capability for padding, field
          // widths, alignment, etc.  Any width/precision requiring a
          // caller-supplied argument is extracted and placed as text
          // into the format array. Lastly, we convert the caller-supplied
          // format specifier from the ACE_Log_Msg-supported list to the
          // equivalent sprintf specifier, and run the new format spec
          // through sprintf, adding it to the bp string.

          const ACE_TCHAR *abort_str = ACE_TEXT ("Aborting...");
          const ACE_TCHAR *start_format = format_str;
          size_t fspace = 128;
          ACE_TCHAR format[128]; // Converted format string
          ACE_OS::memset (format, '\0', 128); // Set this string to known values.
          ACE_TCHAR *fp = 0;         // Current format pointer
          int       wp = 0;      // Width/precision extracted from args
          bool      done = false;
          bool      skip_nul_locate = false;
          int       this_len = 0;    // How many chars s[n]printf wrote

#ifdef ACE_LOG_MSG_USE_STRERROR_R
          char strerror_buf[128]; // always narrow chars
          ACE_OS::strcpy (strerror_buf, "strerror_r failed");
#endif

          fp = format;
          *fp++ = *format_str++;   // Copy in the %
          --fspace;

          // Initialization to satisfy VC6
          int tmp_indent = 0;
          // Work through the format string to copy in the format
          // from the caller. While it's going across, extract ints
          // for '*' width/precision values from the argument list.
          // When the real format specifier is located, change it to
          // one recognized by sprintf, if needed, and do the sprintf
          // call.

          while (!done)
            {
              done = true; // Unless a conversion spec changes it

              switch (*format_str)
                {
                // The initial set of cases are the conversion
                // specifiers. Copy them in to the format array.
                // Note we don't use 'l', a normal conversion spec,
                // as a conversion because it is a ACE_Log_Msg format
                // specifier.
                case '-':
                case '+':
                case '0':
                case ' ':
                case '#':
                case '1':
                case '2':
                case '3':
                case '4':
                case '5':
                case '6':
                case '7':
                case '8':
                case '9':
                case '.':
                case 'h':
                  *fp++ = *format_str;
                  --fspace;
                  done = false;
                  break;
                case 'L':
                  *fp++ = 'l';
                  done = false;
                  break;

                case '*':
                  wp = va_arg (argp, int);
                  if (can_check)
                    this_len = ACE_OS::snprintf (fp, fspace,
                                                 ACE_TEXT ("%d"), wp);
                  else
                    this_len = ACE_OS::sprintf (fp, ACE_TEXT ("%d"), wp);
                  ACE_UPDATE_COUNT (fspace, this_len);
                  fp += ACE_OS::strlen (fp);
                  done = false;
                  break;

                case 'A':             // ACE_timer_t
                  {
                    ACE_OS::strcpy (fp, ACE_TEXT ("f"));
                    --fspace;
                    double const value = va_arg (argp, double);
                    if (can_check)
                      this_len = ACE_OS::snprintf (bp, bspace, format, value);
                    else
                      this_len = ACE_OS::sprintf (bp, format, value);
                    ACE_UPDATE_COUNT (bspace, this_len);
                  }
                  break;

                case 'a': // Abort program after handling all of format string.
                  abort_prog = true;
                  exit_value = va_arg (argp, int);
                  ACE_OS::strsncpy (bp, abort_str, bspace);
                  if (bspace > ACE_OS::strlen (abort_str))
                    bspace -= ACE_OS::strlen (abort_str);
                  else
                    bspace = 0;
                  break;

                case 'l':             // Source file line number
                  ACE_OS::strcpy (fp, ACE_TEXT ("d"));
                  if (can_check)
                    this_len = ACE_OS::snprintf (bp,
                                                 bspace,
                                                 format,
                                                 this->linenum ());
                  else
                    this_len = ACE_OS::sprintf (bp, format, this->linenum ());
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'N':             // Source file name
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                  ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else
                  ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif
                  if (can_check)
                    this_len = ACE_OS::snprintf (bp, bspace, format,
                                                 this->file () ?
                                                 ACE_TEXT_CHAR_TO_TCHAR (this->file ())
                                                 : ACE_TEXT ("<unknown file>"));
                  else
                    this_len = ACE_OS::sprintf (bp, format,
                                                this->file () ?
                                                ACE_TEXT_CHAR_TO_TCHAR (this->file ())
                                                : ACE_TEXT ("<unknown file>"));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'n':             // Program name
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                  ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else /* ACE_WIN32 && ACE_USES_WCHAR */
                  ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif
                  if (can_check)
                    this_len = ACE_OS::snprintf (bp, bspace, format,
                                                 ACE_Log_Msg::program_name_ ?
                                                 ACE_Log_Msg::program_name_ :
                                                 ACE_TEXT ("<unknown>"));
                  else
                    this_len = ACE_OS::sprintf (bp, format,
                                                ACE_Log_Msg::program_name_ ?
                                                ACE_Log_Msg::program_name_ :
                                                ACE_TEXT ("<unknown>"));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'P':             // Process ID
#if defined (ACE_OPENVMS)
                  // Print the process id in hex on OpenVMS.
                  ACE_OS::strcpy (fp, ACE_TEXT ("x"));
#else
                  ACE_OS::strcpy (fp, ACE_TEXT ("d"));
#endif
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format,
                       static_cast<int> (this->getpid ()));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, static_cast<int> (this->getpid ()));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'p':             // <errno> string, ala perror()
                  {
                    errno = 0;
                    const int mapped = ACE::map_errno (this->errnum ());
#ifdef ACE_LOG_MSG_USE_STRERROR_R
                    char *msg = ACE_OS::strerror_r (mapped, strerror_buf,
                                                    sizeof strerror_buf);
#else
                    char *msg = ACE_OS::strerror (mapped);
#endif
                    // Windows can try to translate the errnum using
                    // system calls if strerror() doesn't get anything useful.
#if defined (ACE_WIN32)
                    if (errno == 0)
                      {
#endif

#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                        ACE_OS::strcpy (fp, ACE_TEXT ("ls: %ls"));
                        wchar_t *str = va_arg (argp, wchar_t *);
#else
                        ACE_OS::strcpy (fp, ACE_TEXT ("s: %s"));
                        ACE_TCHAR *str = va_arg (argp, ACE_TCHAR *);
#endif
                        if (can_check)
                          this_len = ACE_OS::snprintf
                            (bp, bspace, format,
                             str ? str : ACE_TEXT ("(null)"),
                             ACE_TEXT_CHAR_TO_TCHAR (msg));
                        else
                          this_len = ACE_OS::sprintf
                            (bp, format,
                             str ? str : ACE_TEXT ("(null)"),
                             ACE_TEXT_CHAR_TO_TCHAR (msg));
#if defined (ACE_WIN32)
                      }
                    else
                      {
                        errno = ACE::map_errno (this->errnum ());
                        ACE_TCHAR *lpMsgBuf = 0;

     // PharLap can't do FormatMessage, so try for socket
     // error.
# if !defined (ACE_HAS_PHARLAP)
                        ACE_TEXT_FormatMessage (FORMAT_MESSAGE_ALLOCATE_BUFFER
                                                  | FORMAT_MESSAGE_MAX_WIDTH_MASK
                                                  | FORMAT_MESSAGE_FROM_SYSTEM,
                                                  0,
                                                  errno,
                                                  MAKELANGID (LANG_NEUTRAL,
                                                              SUBLANG_DEFAULT),
                                                              // Default language
                                                  (ACE_TCHAR *) &lpMsgBuf,
                                                  0,
                                                  0);
# endif /* ACE_HAS_PHARLAP */

                        // If we don't get a valid response from
                        // <FormatMessage>, we'll assume this is a
                        // WinSock error and so we'll try to convert
                        // it into a string.  If this doesn't work it
                        // returns "unknown error" which is fine for
                        // our purposes.
                        ACE_TCHAR *str = va_arg (argp, ACE_TCHAR *);
                        if (lpMsgBuf == 0)
                          {
                            const ACE_TCHAR *message =
                              ACE::sock_error (errno);
                            ACE_OS::strcpy (fp, ACE_TEXT ("s: %s"));
                            if (can_check)
                              this_len = ACE_OS::snprintf
                                (bp, bspace, format,
                                 str ? str : ACE_TEXT ("(null)"),
                                 message);
                            else
                              this_len = ACE_OS::sprintf
                                (bp, format,
                                 str ? str : ACE_TEXT ("(null)"),
                                 message);
                          }
                        else
                          {
                            ACE_OS::strcpy (fp, ACE_TEXT ("s: %s"));
                            if (can_check)
                              this_len = ACE_OS::snprintf
                                (bp, bspace, format,
                                 str ? str : ACE_TEXT ("(null)"),
                                 lpMsgBuf);
                            else
                              this_len = ACE_OS::sprintf
                                (bp, format,
                                 str ? str : ACE_TEXT ("(null)"),
                                 lpMsgBuf);
                            // Free the buffer.
                            ::LocalFree (lpMsgBuf);
                          }
                      }
#endif /* ACE_WIN32 */
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }

                case 'M': // Print the name of the priority of the message.

                    // Look at the format precision specifier. .1 is interpreted
                    // as a single character printout, otherwise we print the name of
                    // the priority.

                  // So, did we find a .1 specifier? Do we need to override it?
                  if (format[1] == ACE_TEXT('.') &&
                      format[2] == ACE_TEXT('1'))
                  {
                      // Yup.
                      // Print a single character signifying the severity of the message
                      fp = format;
                      fp++;

# if defined (ACE_USES_WCHAR)

#     if defined (ACE_WIN32) // Windows uses 'c' for a wide character
                    ACE_OS::strcpy (fp, ACE_TEXT ("c"));
#     else // Other platforms behave differently
#         if defined (HPUX) // HP-Unix compatible
                  ACE_OS::strcpy (fp, ACE_TEXT ("C"));
#         else // Other
                  ACE_OS::strcpy (fp, ACE_TEXT ("lc"));
#         endif /* HPUX */
#     endif

# else /* ACE_USES_WCHAR */

                      // Non-unicode builds simply use a standard character format specifier
                      ACE_OS::strcpy (fp, ACE_TEXT ("c"));

# endif /* ACE_USES_WCHAR */

                      // Below is an optimized (binary search based)
                      // version of the following simple piece of code:
                      //
                      // log_priority == LM_SHUTDOWN  ? 'S' :   // Shutdown
                      // log_priority == LM_TRACE     ? 'T' :   // Trace
                      // log_priority == LM_DEBUG     ? 'D' :   // Debug
                      // log_priority == LM_INFO      ? 'I' :   // Info
                      // log_priority == LM_NOTICE    ? 'N' :   // Notice
                      // log_priority == LM_WARNING   ? 'W' :   // Warning
                      // log_priority == LM_STARTUP   ? 'U' :   // Startup
                      // log_priority == LM_ERROR     ? 'E' :   // Error
                      // log_priority == LM_CRITICAL  ? 'C' :   // Critical
                      // log_priority == LM_ALERT     ? 'A' :   // Alert
                      // log_priority == LM_EMERGENCY ? '!' :   // Emergency
                      //                                '?'      // Unknown

                      if (can_check)
                      {
                        this_len = ACE_OS::snprintf
                          (bp, bspace, format,
#if !defined (ACE_USES_WCHAR) || defined (ACE_WIN32)
                           (int)
#else
                           (wint_t)
#endif
                           (log_priority <= LM_WARNING) ?
                           (log_priority <= LM_DEBUG) ?
                           (log_priority <= LM_TRACE) ?
                           (log_priority == LM_SHUTDOWN) ?
                           ACE_TEXT('S') : ACE_TEXT('T') : ACE_TEXT('D') :
                           (log_priority <= LM_NOTICE) ?
                           (log_priority == LM_INFO) ?
                           ACE_TEXT('I') : ACE_TEXT('N') : ACE_TEXT('W') :
                           (log_priority <= LM_CRITICAL) ?
                           (log_priority <= LM_ERROR) ?
                           (log_priority == LM_STARTUP) ?
                           ACE_TEXT('U') : ACE_TEXT('E') : ACE_TEXT('C') :
                           (log_priority <= LM_EMERGENCY) ?
                           (log_priority == LM_ALERT) ?
                           ACE_TEXT('A') : ACE_TEXT('!') : ACE_TEXT('?'));
                      }
                      else
                      {
                        this_len = ACE_OS::sprintf
                          (bp, format,
#if !defined (ACE_USES_WCHAR) || defined (ACE_WIN32)
                           (int)
#else
                           (wint_t)
#endif
                           (log_priority <= LM_WARNING) ?
                           (log_priority <= LM_DEBUG) ?
                           (log_priority <= LM_TRACE) ?
                           (log_priority == LM_SHUTDOWN) ?
                           ACE_TEXT('S') : ACE_TEXT('T') : ACE_TEXT('D') :
                           (log_priority <= LM_NOTICE) ?
                           (log_priority == LM_INFO) ?
                           ACE_TEXT('I') : ACE_TEXT('N') : ACE_TEXT('W') :
                           (log_priority <= LM_CRITICAL) ?
                           (log_priority <= LM_ERROR) ?
                           (log_priority == LM_STARTUP) ?
                           ACE_TEXT('U') : ACE_TEXT('E') : ACE_TEXT('C') :
                           (log_priority <= LM_EMERGENCY) ?
                           (log_priority == LM_ALERT) ?
                           ACE_TEXT('A') : ACE_TEXT('!') : ACE_TEXT('?'));
                      }

                      ACE_UPDATE_COUNT (bspace, this_len);
                  }
                  else
                  {
                      // Nope, print out standard priority_name() string

#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                      ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else
                      ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif
                      if (can_check)
                        this_len = ACE_OS::snprintf
                          (bp, bspace, format,
                           ACE_Log_Record::priority_name (log_priority));
                      else
                        this_len = ACE_OS::sprintf
                          (bp, format,
                           ACE_Log_Record::priority_name (log_priority));
                      ACE_UPDATE_COUNT (bspace, this_len);
                  }
                  break;

                case 'm': // Format the string assocated with the errno value.
                  {
                    errno = 0;
                    const int mapped = ACE::map_errno (this->errnum ());
#ifdef ACE_LOG_MSG_USE_STRERROR_R
                    char *msg = ACE_OS::strerror_r (mapped, strerror_buf,
                                                    sizeof strerror_buf);
#else
                    char *msg = ACE_OS::strerror (mapped);
#endif
                    // Windows can try to translate the errnum using
                    // system calls if strerror() doesn't get anything useful.
#if defined (ACE_WIN32)
                    if (errno == 0)
                      {
#endif

#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                        ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else /* ACE_WIN32 && ACE_USES_WCHAR */
                        ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif
                        if (can_check)
                          this_len = ACE_OS::snprintf
                            (bp, bspace, format, ACE_TEXT_CHAR_TO_TCHAR (msg));
                        else
                          this_len = ACE_OS::sprintf
                            (bp, format, ACE_TEXT_CHAR_TO_TCHAR (msg));
#if defined (ACE_WIN32)
                      }
                    else
                      {
                        errno = ACE::map_errno (this->errnum ());
                        ACE_TCHAR *lpMsgBuf = 0;

     // PharLap can't do FormatMessage, so try for socket
     // error.
# if !defined (ACE_HAS_PHARLAP)
                        ACE_TEXT_FormatMessage (FORMAT_MESSAGE_ALLOCATE_BUFFER
                                                  | FORMAT_MESSAGE_MAX_WIDTH_MASK
                                                  | FORMAT_MESSAGE_FROM_SYSTEM,
                                                  0,
                                                  errno,
                                                  MAKELANGID (LANG_NEUTRAL,
                                                              SUBLANG_DEFAULT),
                                                              // Default language
                                                  (ACE_TCHAR *) &lpMsgBuf,
                                                  0,
                                                  0);
# endif /* ACE_HAS_PHARLAP */

                        // If we don't get a valid response from
                        // <FormatMessage>, we'll assume this is a
                        // WinSock error and so we'll try to convert
                        // it into a string.  If this doesn't work it
                        // returns "unknown error" which is fine for
                        // our purposes.
                        if (lpMsgBuf == 0)
                          {
                            const ACE_TCHAR *message =
                              ACE::sock_error (errno);
                            ACE_OS::strcpy (fp, ACE_TEXT ("s"));
                            if (can_check)
                              this_len = ACE_OS::snprintf
                                (bp, bspace, format, message);
                            else
                              this_len = ACE_OS::sprintf (bp, format, message);
                          }
                        else
                          {
                            ACE_OS::strcpy (fp, ACE_TEXT ("s"));
                            if (can_check)
                              this_len = ACE_OS::snprintf
                                (bp, bspace, format, lpMsgBuf);
                            else
                              this_len = ACE_OS::sprintf
                                (bp, format, lpMsgBuf);
                            // Free the buffer.
                            ::LocalFree (lpMsgBuf);
                          }
                      }
#endif /* ACE_WIN32 */
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }

                case 'R': // Format the return status of the operation.
                  this->op_status (va_arg (argp, int));
                  ACE_OS::strcpy (fp, ACE_TEXT ("d"));
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, this->op_status ());
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, this->op_status ());
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case '{': // Increment the trace_depth, then indent
                  skip_nul_locate = true;
                  (void) this->inc ();
                  break;

                case '}': // indent, then decrement trace_depth
                  skip_nul_locate = true;
                  (void) this->dec ();
                  break;

                case '$': // insert a newline, then indent the next line
                          // according to %I
                  *bp++ = '\n';
                  --bspace;
                  /* fallthrough */

                case 'I': // Indent with nesting_depth*width spaces
                  // Caller can do %*I to override nesting indent, and
                  // if %*I was done, wp has the extracted width.
#if defined (ACE_HAS_TRACE)
                  if (0 == wp)
                    wp = ACE_Trace::get_nesting_indent ();
#else
                  if (0 == wp)
                    wp = 4;
#endif /* ACE_HAS_TRACE */
                  wp *= this->trace_depth_;
                  if (static_cast<size_t> (wp) > bspace)
                    wp = static_cast<int> (bspace);
                  for (tmp_indent = wp;
                       tmp_indent;
                       --tmp_indent)
                    *bp++ = ' ';

                  *bp = '\0';
                  bspace -= static_cast<size_t> (wp);
                  skip_nul_locate = true;
                  break;

                case 'r': // Run (invoke) this subroutine.
                  {
                    ptrdiff_t const osave = ACE_Log_Msg::msg_off_;

                    if (ACE_BIT_ENABLED (flags,
                                         ACE_Log_Msg::SILENT) &&
                        bspace > 1)
                      {
                        *bp++ = '{';
                        --bspace;
                      }
                    ACE_Log_Msg::msg_off_ =  bp - this->msg_;

                    (*va_arg (argp, PointerToFunction))();

                    if (ACE_BIT_ENABLED (flags,
                                         ACE_Log_Msg::SILENT) &&
                        bspace > (1 + ACE_OS::strlen (bp)))
                      {
                        bspace -= (ACE_OS::strlen (bp) + 1);
                        bp += ACE_OS::strlen (bp);
                        *bp++ =  '}';
                      }
                    *bp = '\0';
                    skip_nul_locate = true;
                    ACE_Log_Msg::msg_off_ = osave;
                    break;
                  }

                case 'S': // format the string for with this signal number.
                  {
                    const int sig = va_arg (argp, int);
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, ACE_OS::strsignal(sig));
                    else
                      this_len = ACE_OS::sprintf
                        (bp, format, ACE_OS::strsignal(sig));
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }

                case 'D': // Format the timestamp in format:
                          // yyyy-mm-dd hour:minute:sec.usec
                          // This is a maximum of 27 characters
                          // including terminator.
                  {
                    ACE_TCHAR day_and_time[27];
                    // Did we find the flag indicating a time value argument
                    if (format[1] == ACE_TEXT('#'))
                    {
                      ACE_Time_Value* time_value = va_arg (argp, ACE_Time_Value*);
                      ACE::timestamp (*time_value,
                                      day_and_time,
                                      sizeof (day_and_time) / sizeof (ACE_TCHAR),
                                      true);
                    }
                    else
                    {
                      ACE::timestamp (day_and_time,
                                      sizeof (day_and_time) / sizeof (ACE_TCHAR),
                                      true);
                    }
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                    ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, day_and_time);
                    else
                      this_len = ACE_OS::sprintf (bp, format, day_and_time);
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }

                case 'T': // Format the timestamp in
                          // hour:minute:sec.usec format.
                  {
                    ACE_TCHAR day_and_time[27];
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                    ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif
                    // Did we find the flag indicating a time value argument
                    if (format[1] == ACE_TEXT('#'))
                    {
                      ACE_Time_Value* time_value = va_arg (argp, ACE_Time_Value*);
                      if (can_check)
                        this_len = ACE_OS::snprintf
                          (bp, bspace, format,
                          ACE::timestamp (*time_value,
                                         day_and_time,
                                         sizeof day_and_time / sizeof (ACE_TCHAR),
                                         true));
                      else
                        this_len = ACE_OS::sprintf
                          (bp, format, ACE::timestamp (*time_value,
                                                      day_and_time,
                                                      sizeof day_and_time / sizeof (ACE_TCHAR),
                                                      true));
                    }
                    else
                    {
                      if (can_check)
                        this_len = ACE_OS::snprintf
                          (bp, bspace, format,
                          ACE::timestamp (day_and_time, sizeof day_and_time / sizeof (ACE_TCHAR), true));
                      else
                        this_len = ACE_OS::sprintf
                          (bp, format, ACE::timestamp (day_and_time,
                                                      sizeof day_and_time / sizeof (ACE_TCHAR), true));
                    }
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }

                case 't': // Format thread id.
#if defined (ACE_WIN32)
                  ACE_OS::strcpy (fp, ACE_TEXT ("u"));
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format,
                       static_cast<unsigned> (ACE_Thread::self ()));
                  else
                    this_len =
                      ACE_OS::sprintf (bp,
                                       format,
                                       static_cast <unsigned> (ACE_Thread::self ()));
#else

#  ifdef ACE_HAS_GETTID
#    define ACE_LOG_MSG_GET_THREAD_ID ACE_OS::thr_gettid
#    define ACE_LOG_MSG_GET_THREAD_ID_BUFFER_SIZE 12
#  else
#    define ACE_LOG_MSG_GET_THREAD_ID ACE_OS::thr_id
#    define ACE_LOG_MSG_GET_THREAD_ID_BUFFER_SIZE 32
#  endif

#  if defined ACE_USES_WCHAR
                  {
                    char tid_buf[ACE_LOG_MSG_GET_THREAD_ID_BUFFER_SIZE] = {};
                    ACE_LOG_MSG_GET_THREAD_ID (tid_buf, sizeof tid_buf);
                    this_len = ACE_OS::strlen (tid_buf);
                    ACE_OS::strncpy (bp, ACE_TEXT_CHAR_TO_TCHAR (tid_buf),
                                     bspace);
                  }
#  else
                  this_len = ACE_LOG_MSG_GET_THREAD_ID (bp, bspace);
#  endif /* ACE_USES_WCHAR */
#endif /* ACE_WIN32 */
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 's':                       // String
                  {
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                    wchar_t *str = va_arg (argp, wchar_t *);
                    ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
#else /* ACE_WIN32 && ACE_USES_WCHAR */
                    ACE_TCHAR *str = va_arg (argp, ACE_TCHAR *);
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif /* ACE_WIN32 && ACE_USES_WCHAR */
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, str ? str : ACE_TEXT ("(null)"));
                    else
                      this_len = ACE_OS::sprintf
                        (bp, format, str ? str : ACE_TEXT ("(null)"));
                    ACE_UPDATE_COUNT (bspace, this_len);
                  }
                  break;

                case 'C':         // Narrow-char string
                  {
                    char *cstr = va_arg (argp, char *);
#if defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                    ACE_OS::strcpy (fp, ACE_TEXT ("S"));
#else /* ACE_WIN32 && ACE_USES_WCHAR */
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif /* ACE_WIN32 && ACE_USES_WCHAR */
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, cstr ? cstr : "(null)");
                    else
                      this_len = ACE_OS::sprintf
                        (bp, format, cstr ? cstr : "(null)");
                    ACE_UPDATE_COUNT (bspace, this_len);
                  }
                  break;

                case 'W':
                  {
#if defined (ACE_HAS_WCHAR)
                    wchar_t *wchar_str = va_arg (argp, wchar_t *);
# if defined (HPUX)
                    ACE_OS::strcpy (fp, ACE_TEXT ("S"));
# elif defined (ACE_WIN32)
#   if defined (ACE_USES_WCHAR)
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#   else /* ACE_USES_WCHAR */
                    ACE_OS::strcpy (fp, ACE_TEXT ("S"));
#   endif /* ACE_USES_WCHAR */
# else
                    ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
# endif /* HPUX */
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, wchar_str ? wchar_str : ACE_TEXT_WIDE("(null)"));
                    else
                      this_len = ACE_OS::sprintf
                        (bp, format, wchar_str ? wchar_str : ACE_TEXT_WIDE("(null)"));
#endif /* ACE_HAS_WCHAR */
                    ACE_UPDATE_COUNT (bspace, this_len);
                  }
                  break;

                case 'w':              // Wide character
#if defined (ACE_WIN32)
# if defined (ACE_USES_WCHAR)
                  ACE_OS::strcpy (fp, ACE_TEXT ("c"));
# else /* ACE_USES_WCHAR */
                  ACE_OS::strcpy (fp, ACE_TEXT ("C"));
# endif /* ACE_USES_WCHAR */
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, va_arg (argp, int));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, va_arg (argp, int));
#elif defined (ACE_USES_WCHAR)
# if defined (HPUX)
                  ACE_OS::strcpy (fp, ACE_TEXT ("C"));
# else
                  ACE_OS::strcpy (fp, ACE_TEXT ("lc"));
# endif /* HPUX */
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, va_arg (argp, wint_t));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, va_arg (argp, wint_t));
#else /* ACE_WIN32 */
                  ACE_OS::strcpy (fp, ACE_TEXT ("u"));
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, va_arg (argp, int));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, va_arg (argp, int));
#endif /* ACE_WIN32 */
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'z':              // ACE_OS::WChar character
                  {
                    // On some platforms sizeof (wchar_t) can be 2
                    // on the others 4 ...
                    wchar_t wtchar =
                      static_cast<wchar_t> (va_arg (argp, int));
#if defined (ACE_WIN32)
# if defined (ACE_USES_WCHAR)
                    ACE_OS::strcpy (fp, ACE_TEXT ("c"));
# else /* ACE_USES_WCHAR */
                    ACE_OS::strcpy (fp, ACE_TEXT ("C"));
# endif /* ACE_USES_WCHAR */
#elif defined (ACE_USES_WCHAR)
# if defined (HPUX)
                    ACE_OS::strcpy (fp, ACE_TEXT ("C"));
# else
                    ACE_OS::strcpy (fp, ACE_TEXT ("lc"));
# endif /* HPUX */
#else /* ACE_WIN32 */
                    ACE_OS::strcpy (fp, ACE_TEXT ("u"));
#endif /* ACE_WIN32 */
                    if (can_check)
                      this_len = ACE_OS::snprintf (bp, bspace, format, wtchar);
                    else
                      this_len = ACE_OS::sprintf (bp, format, wtchar);
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }

                 case 'Z':              // ACE_OS::WChar character string
                  {
                    ACE_OS::WChar *wchar_str = va_arg (argp, ACE_OS::WChar*);
                    if (wchar_str == 0)
                      break;

                    wchar_t *wchar_t_str = 0;
                    if (sizeof (ACE_OS::WChar) != sizeof (wchar_t))
                      {
                        size_t len = ACE_OS::wslen (wchar_str) + 1;
                        ACE_NEW_NORETURN(wchar_t_str, wchar_t[len]);
                        if (wchar_t_str == 0)
                          break;

                        for (size_t i = 0; i < len; ++i)
                          {
                            wchar_t_str[i] = wchar_str[i];
                          }
                      }

                    if (wchar_t_str == 0)
                      {
                        wchar_t_str = reinterpret_cast<wchar_t*> (wchar_str);
                      }
#if defined (ACE_WIN32)
# if defined (ACE_USES_WCHAR)
                  ACE_OS::strcpy (fp, ACE_TEXT ("s"));
# else /* ACE_USES_WCHAR */
                  ACE_OS::strcpy (fp, ACE_TEXT ("S"));
# endif /* ACE_USES_WCHAR */
#elif defined (ACE_HAS_WCHAR)
# if defined (HPUX)
                  ACE_OS::strcpy (fp, ACE_TEXT ("S"));
# else
                  ACE_OS::strcpy (fp, ACE_TEXT ("ls"));
# endif /* HPUX */
#endif /* ACE_WIN32 / ACE_HAS_WCHAR */
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, wchar_t_str);
                  else
                    this_len = ACE_OS::sprintf (bp, format, wchar_t_str);
                  if(sizeof(ACE_OS::WChar) != sizeof(wchar_t))
                    {
                      delete [] wchar_t_str;
                    }
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;
                  }

                case 'c':
#if defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                  ACE_OS::strcpy (fp, ACE_TEXT ("C"));
#else
                  ACE_OS::strcpy (fp, ACE_TEXT ("c"));
#endif /* ACE_WIN32 && ACE_USES_WCHAR */
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, va_arg (argp, int));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, va_arg (argp, int));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'd': case 'i': case 'o':
                case 'u': case 'x': case 'X':
                  fp[0] = *format_str;
                  fp[1] = '\0';
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, va_arg (argp, int));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, va_arg (argp, int));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'F': case 'f': case 'e': case 'E':
                case 'g': case 'G':
                  fp[0] = *format_str;
                  fp[1] = '\0';
                  if (can_check)
                    this_len = ACE_OS::snprintf
                      (bp, bspace, format, va_arg (argp, double));
                  else
                    this_len = ACE_OS::sprintf
                      (bp, format, va_arg (argp, double));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'Q':
                  {
                    const ACE_TCHAR *fmt = ACE_UINT64_FORMAT_SPECIFIER;
                    ACE_OS::strcpy (fp, &fmt[1]);    // Skip leading %
                    if (can_check)
                      this_len = ACE_OS::snprintf (bp, bspace,
                                                   format,
                                                   va_arg (argp, ACE_UINT64));
                    else
                      this_len = ACE_OS::sprintf (bp,
                                                  format,
                                                  va_arg (argp, ACE_UINT64));
                  }
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'q':
                   {
                     const ACE_TCHAR *fmt = ACE_INT64_FORMAT_SPECIFIER;
                     ACE_OS::strcpy (fp, &fmt[1]);    // Skip leading %
                     if (can_check)
                       this_len = ACE_OS::snprintf (bp, bspace,
                                                    format,
                                                    va_arg (argp, ACE_INT64));
                     else
                       this_len = ACE_OS::sprintf (bp,
                                                   format,
                                                   va_arg (argp, ACE_INT64));
                   }
                   ACE_UPDATE_COUNT (bspace, this_len);
                   break;

                case 'b':
                  {
                    const ACE_TCHAR *fmt = ACE_SSIZE_T_FORMAT_SPECIFIER;
                    ACE_OS::strcpy (fp, &fmt[1]);    // Skip leading %
                  }
                  if (can_check)
                    this_len = ACE_OS::snprintf (bp, bspace,
                                                 format,
                                                 va_arg (argp, ssize_t));
                  else
                    this_len = ACE_OS::sprintf (bp,
                                                format,
                                                va_arg (argp, ssize_t));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case 'B':
                  {
                    const ACE_TCHAR *fmt = ACE_SIZE_T_FORMAT_SPECIFIER;
                    ACE_OS::strcpy (fp, &fmt[1]);    // Skip leading %
                  }
                  if (can_check)
                    this_len = ACE_OS::snprintf (bp, bspace,
                                                 format,
                                                 va_arg (argp, size_t));
                  else
                    this_len = ACE_OS::sprintf (bp,
                                                format,
                                                va_arg (argp, size_t));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case ':':
                  {
                    // Assume a 32 bit time_t and change if needed.
                    const ACE_TCHAR *fmt = ACE_TEXT ("%d");
                    if (sizeof (time_t) == 8)
                      fmt = ACE_INT64_FORMAT_SPECIFIER;

                    ACE_OS::strcpy (fp, &fmt[1]);    // Skip leading %
                  }
                  if (can_check)
                    this_len = ACE_OS::snprintf (bp, bspace,
                                                 format,
                                                 va_arg (argp, time_t));
                  else
                    this_len = ACE_OS::sprintf (bp,
                                                format,
                                                va_arg (argp, time_t));
                  ACE_UPDATE_COUNT (bspace, this_len);
                  break;

                case '@':
                    ACE_OS::strcpy (fp, ACE_TEXT ("p"));
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, va_arg (argp, void*));
                    else
                      this_len = ACE_OS::sprintf
                        (bp, format, va_arg (argp, void*));
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;

                case '?':
                  // Stack trace up to this point
                  {
                    // skip the frame that we're currently in
                    ACE_Stack_Trace t(2);
#if defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                    ACE_OS::strcpy (fp, ACE_TEXT ("S"));
#else /* ACE_WIN32 && ACE_USES_WCHAR */
                    ACE_OS::strcpy (fp, ACE_TEXT ("s"));
#endif /* ACE_WIN32 && ACE_USES_WCHAR */
                    if (can_check)
                      this_len = ACE_OS::snprintf
                        (bp, bspace, format, t.c_str ());
                    else
                      this_len = ACE_OS::sprintf
                        (bp, format, t.c_str ());
                    ACE_UPDATE_COUNT (bspace, this_len);
                    break;
                  }


                default:
                  // So, it's not a legit format specifier after all...
                  // Copy from the original % to where we are now, then
                  // continue with whatever comes next.
                  while (start_format != format_str && bspace > 0)
                    {
                      *bp++ = *start_format++;
                      --bspace;
                    }
                  if (bspace > 0)
                    {
                      *bp++ = *format_str;
                      --bspace;
                    }
                  break;
                }

              // Bump to the next char in the caller's format_str
              ++format_str;
            }

          if (!skip_nul_locate)
            while (*bp != '\0') // Locate end of bp.
              ++bp;
        }
    }

  *bp = '\0'; // Terminate bp, but don't auto-increment this!

  ssize_t result = 0;

  // Check that memory was not corrupted, if it corrupted we can't log anything
  // anymore because all our members could be corrupted.
  if (bp >= (this->msg_ + ACE_MAXLOGMSGLEN+1))
    {
      abort_prog = true;
      ACE_OS::fprintf (stderr,
                       "The following logged message is too long!\n");
    }
  else
    {
      // Copy the message from thread-specific storage into the transfer
      // buffer (this can be optimized away by changing other code...).
      log_record.msg_data (this->msg ());

      // Write the <log_record> to the appropriate location.
      result = this->log (log_record,
                          abort_prog);
    }

  if (abort_prog)
    {
      // Since we are now calling abort instead of exit, this value is
      // not used.
      ACE_UNUSED_ARG (exit_value);

      // *Always* print a message to stderr if we're aborting.  We
      // don't use verbose, however, to avoid recursive aborts if
      // something is hosed.
      log_record.print (ACE_Log_Msg::local_host_, 0, stderr);
      ACE_OS::abort ();
    }

   return result;
#endif /* ACE_LACKS_VA_FUNCTIONS */
}

#ifdef ACE_LACKS_VA_FUNCTIONS
ACE_Log_Formatter operator, (ACE_Log_Priority prio, const char *fmt)
{
  return ACE_Log_Formatter (prio, fmt);
}

ACE_Log_Formatter::ACE_Log_Formatter (ACE_Log_Priority prio, const char *fmt)
  : saved_errno_ (errno)
  , priority_ (prio)
  , format_ (fmt)
  , logger_ (ACE_LOG_MSG)
  , abort_ (ABRT_NONE)
  , in_prog_ (' ')
  , last_star_ (0)
{
  const bool conditional_values = this->logger_->conditional_values_.is_set_;
  this->logger_->conditional_values_.is_set_ = false;

  this->enabled_ = this->logger_->log_priority_enabled (prio);
  if (!this->enabled_) return;

  if (conditional_values)
    this->logger_->set (this->logger_->conditional_values_.file_,
                        this->logger_->conditional_values_.line_,
                        this->logger_->conditional_values_.op_status_,
                        this->logger_->conditional_values_.errnum_,
                        this->logger_->restart (),
                        this->logger_->msg_ostream (),
                        this->logger_->msg_callback ());
  this->bp_ = this->logger_->msg_ + ACE_Log_Msg::msg_off_;
  this->bspace_ = ACE_Log_Record::MAXLOGMSGLEN;
  if (ACE_Log_Msg::msg_off_ <= ACE_Log_Record::MAXLOGMSGLEN)
    this->bspace_ -= static_cast<size_t> (ACE_Log_Msg::msg_off_);

  if (ACE_BIT_ENABLED (ACE_Log_Msg::flags_, ACE_Log_Msg::VERBOSE)
      && ACE_Log_Msg::program_name_ != 0)
    {
      const int n = ACE_OS::snprintf (this->bp_, this->bspace_, "%s|",
                                      ACE_Log_Msg::program_name_);
      ACE_UPDATE_COUNT (this->bspace_, n);
      this->bp_ += n;
    }

  if (this->logger_->timestamp_)
    {
      ACE_TCHAR day_and_time[27];
      const bool time_only = this->logger_->timestamp_ == 1;
      const ACE_TCHAR *const time =
        ACE::timestamp (day_and_time,
                        sizeof day_and_time / sizeof (ACE_TCHAR),
                        time_only);
      const int n = ACE_OS::snprintf (this->bp_, this->bspace_, "%s|",
                                      time_only ? time : day_and_time);
      ACE_UPDATE_COUNT (this->bspace_, n);
      this->bp_ += n;
    }
}

int ACE_Log_Formatter::copy_trunc (const char *str, int limit)
{
  const int n = std::min (static_cast<int> (this->bspace_), limit);
  ACE_OS::memcpy (this->bp_, str, n);
  ACE_UPDATE_COUNT (this->bspace_, n);
  this->bp_ += n;
  return n;
}

void ACE_Log_Formatter::prepare_format ()
{
  const char in_progress = this->in_prog_;
  this->in_prog_ = ' ';
  switch (in_progress)
    {
    case '*':
      if (!this->process_conversion ()) return;
      break;
    case 'p':
      {
        // continuation of the '%p' format after the user's message
        const int mapped = ACE::map_errno (this->logger_->errnum ());
#ifdef ACE_LOG_MSG_USE_STRERROR_R
        char strerror_buf[128]; // always narrow chars
        ACE_OS::strcpy (strerror_buf, "strerror_r failed");
        const char *const msg = ACE_OS::strerror_r (mapped, strerror_buf,
                                                    sizeof strerror_buf);
#else
        const char *const msg = ACE_OS::strerror (mapped);
#endif
        this->copy_trunc (": ", 2);
        this->copy_trunc (msg, ACE_OS::strlen (msg));
        break;
      }
    case 'r':
      if (ACE_BIT_ENABLED (ACE_Log_Msg::flags_, ACE_Log_Msg::SILENT))
        {
          const size_t len = ACE_OS::strlen (this->bp_);
          this->bspace_ -= len + 1;
          this->bp_ += len;
          this->copy_trunc ("}", 1);
        }
      *this->bp_ = 0;
      ACE_Log_Msg::msg_off_ = this->offset_;
      break;
    }

  *this->fmt_out_ = 0;

  while (const char *const pct = ACE_OS::strchr (this->format_, '%'))
    {
      const bool escaped = pct[1] == '%';
      this->format_ += 1 + this->copy_trunc (this->format_,
                                             pct - this->format_ + escaped);
      if (!this->bspace_) return;
      if (!escaped)
        {
          ACE_OS::strcpy (this->fmt_out_, "%");
          this->fp_ = this->fmt_out_ + 1;
          this->last_star_ = 0;
          if (!this->process_conversion ()) return;
        }
    }

  this->copy_trunc (this->format_, ACE_OS::strlen (this->format_));
}

bool ACE_Log_Formatter::process_conversion ()
{
  const size_t n = ACE_OS::strspn (this->format_, "-+ #0123456789.Lh");
  const size_t fspace = sizeof this->fmt_out_ - (this->fp_ - this->fmt_out_);
  if (n >= fspace || !this->format_[n]) return true;

  // when copying to fmt_out_, convert L (used by ACE) to l (used by std)
  for (size_t i = 0; i < n; ++i)
    if (this->format_[i] == 'L') this->fp_[i] = 'l';
    else this->fp_[i] = this->format_[i];

  this->fp_ += n;
  *this->fp_ = 0;
  this->in_prog_ = this->format_[n];
  const char *const format_start = this->format_;
  this->format_ += n + (this->in_prog_ ? 1 : 0);
  int len;

  switch (this->in_prog_)
    {
    // the following formatters (here through '?') take no argument
    // from the "varags" list so they will end up returning true (keep parsing)
    case '$':
      this->copy_trunc ("\n", 1);
      // fall-through
    case 'I':
      len = std::min (static_cast<int> (this->bspace_),
                      this->logger_->trace_depth_ *
                      (this->last_star_ ? this->last_star_ :
#ifdef ACE_HAS_TRACE
                       ACE_Trace::get_nesting_indent ()));
#else
                       4));
#endif
      ACE_OS::memset (this->bp_, ' ', len);
      ACE_UPDATE_COUNT (this->bspace_, len);
      this->bp_ += len;
      break;

    case 'l':
      ACE_OS::strcpy (this->fp_, "d");
      len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                              this->logger_->linenum ());
      ACE_UPDATE_COUNT (this->bspace_, len);
      this->bp_ += len;
      break;

    case 'm':
      {
        const int mapped = ACE::map_errno (this->logger_->errnum ());
#ifdef ACE_LOG_MSG_USE_STRERROR_R
        char strerror_buf[128]; // always narrow chars
        ACE_OS::strcpy (strerror_buf, "strerror_r failed");
        const char *const msg = ACE_OS::strerror_r (mapped, strerror_buf,
                                                    sizeof strerror_buf);
#else
        const char *const msg = ACE_OS::strerror (mapped);
#endif
        ACE_OS::strcpy (this->fp_, "s");
        len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_, msg);
        ACE_UPDATE_COUNT (this->bspace_, len);
        this->bp_ += len;
      }
      break;

    case 'M':
      {
        const char *const pri = ACE_Log_Record::priority_name (this->priority_);

        // special case for %.1M: unique 1-char abbreviation for log priority
        if (this->fp_ == this->fmt_out_ + 3 &&
            this->fmt_out_[1] == '.' && this->fmt_out_[2] == '1')
          {
            const char abbrev =
              this->priority_ == LM_STARTUP ? 'U' :
              this->priority_ == LM_EMERGENCY ? '!' :
              (ACE_OS::strlen (pri) < 4) ? '?' : pri[3];
            this->copy_trunc (&abbrev, 1);
          }
        else
          {
            ACE_OS::strcpy (this->fp_, "s");
            len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                                    pri);
            ACE_UPDATE_COUNT (this->bspace_, len);
            this->bp_ += len;
          }
      }
      break;

    case 'n':
      ACE_OS::strcpy (this->fp_, "s");
      len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                              ACE_Log_Msg::program_name_ ?
                              ACE_Log_Msg::program_name_ : "<unknown>");
      ACE_UPDATE_COUNT (this->bspace_, len);
      this->bp_ += len;
      break;

    case 'N':
      ACE_OS::strcpy (this->fp_, "s");
      len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                              this->logger_->file () ?
                              this->logger_->file () : "<unknown file>");
      ACE_UPDATE_COUNT (this->bspace_, len);
      this->bp_ += len;
      break;

    case 'P':
      ACE_OS::strcpy (this->fp_, "d");
      len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                              static_cast<int> (this->logger_->getpid ()));
      ACE_UPDATE_COUNT (this->bspace_, len);
      this->bp_ += len;
      break;

    case 't':
      ACE_OS::strcpy (this->fp_, "u");
      len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                              ACE_OS::thr_self ());
      ACE_UPDATE_COUNT (this->bspace_, len);
      this->bp_ += len;
      break;

    // %D and %T with # in the conversion spec do take an arg (ACE_Time_Value*)
    case 'D': case 'T':
      ACE_OS::strcpy (this->fp_, "s");
      if (ACE_OS::memchr (this->fmt_out_, '#', this->fp_ - this->fmt_out_))
        return false;
      {
        char day_and_time[27];
        const char *const time =
          ACE::timestamp (day_and_time, sizeof day_and_time, true);
        len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                                this->in_prog_ == 'T' ? time : day_and_time);
        ACE_UPDATE_COUNT (this->bspace_, len);
        this->bp_ += len;
      }
      break;

    case '{':
      this->logger_->inc ();
      break;
    case '}':
      this->logger_->dec ();
      break;

    case '?':
      {
        ACE_Stack_Trace trc(3); // 3 stack frames between here and user code
        ACE_OS::strcpy (this->fp_, "s");
        len = ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                                trc.c_str ());
        ACE_UPDATE_COUNT (this->bspace_, len);
        this->bp_ += len;
      }
      break;

    case '*':
      // * requires an argument from the "varags" but doesn't complete
      // the current conversion specification (for example, %*s):
      return false;

    // these require an argument from the "varags" list:
    case 'a':
      this->abort_ = ABRT_NEED_ARG;
      this->copy_trunc ("Aborting...", 11);
      return false;
    case 'A': // ACE_timer_t is a typedef for double on all platforms
      ACE_OS::strcpy (this->fp_, "f");
      return false;

    case 'b':
      ACE_OS::strcpy (this->fp_, ACE_SSIZE_T_FORMAT_SPECIFIER + 1); // skip %
      return false;
    case 'B':
      ACE_OS::strcpy (this->fp_, ACE_SIZE_T_FORMAT_SPECIFIER + 1); // skip %
      return false;

    case 'C': case 'p': case 'S':
      ACE_OS::strcpy (this->fp_, "s");
      // the remaining parts of case 'p' are handled in prepare_format
      return false;

    case 'q':
      ACE_OS::strcpy (this->fp_, ACE_INT64_FORMAT_SPECIFIER + 1); // skip %
      return false;
    case 'Q':
      ACE_OS::strcpy (this->fp_, ACE_UINT64_FORMAT_SPECIFIER + 1); // skip %
      return false;

    case 'r':
      this->offset_ = ACE_Log_Msg::msg_off_;
      if (ACE_BIT_ENABLED (ACE_Log_Msg::flags_, ACE_Log_Msg::SILENT))
        this->copy_trunc ("{", 1);
      ACE_Log_Msg::msg_off_ = this->bp_ - this->logger_->msg_;
      return false;

    case 'R':
      ACE_OS::strcpy (this->fp_, "d");
      return false;

    case 'w': case 'z':
      ACE_OS::strcpy (this->fp_, "u");
      return false;
    case 'W':
      ACE_OS::strcpy (this->fp_, "ls");
      return false;
    case 'Z':
#if (defined ACE_WIN32 && !defined ACE_USES_WCHAR) || defined HPUX
      ACE_OS::strcpy (this->fp_, "S");
#elif defined ACE_WIN32
      ACE_OS::strcpy (this->fp_, "s");
#else
      ACE_OS::strcpy (this->fp_, "ls");
#endif
      return false;

    case '@':
      ACE_OS::strcpy (this->fp_, "p");
      return false;
    case ':':
      if (sizeof (time_t) == 8)
        ACE_OS::strcpy (this->fp_, ACE_INT64_FORMAT_SPECIFIER + 1); // skip %
      else
        ACE_OS::strcpy (this->fp_, "d");
      return false;

    case 'd': case 'i': case 'o': case 'u': case 'x': case 'X': // <- ints
    case 'e': case 'E': case 'f': case 'F': case 'g': case 'G': // <- doubles
    case 'c': case 's': // <- char / const char*
      *this->fp_++ = this->in_prog_;
      *this->fp_ = 0;
      return false;

    default:
      // not actually a format specifier: copy verbatim to output
      this->copy_trunc (format_start - 1 /* start at % */, n + 2);
      this->in_prog_ = ' ';
      break;
    }
  return true;
}

void ACE_Log_Formatter::insert_pct_S (int sig)
{
  const int n = ACE_OS::snprintf (this->bp_, this->bspace_,
                                  this->fmt_out_, ACE_OS::strsignal (sig));
  ACE_UPDATE_COUNT (this->bspace_, n);
  this->bp_ += n;
}

template <typename ArgT>
void ACE_Log_Formatter::insert_arg (ArgT arg, bool allow_star)
{
  if (!this->enabled_) return;

  this->prepare_format ();

  const int intArg = static_cast<int> (arg);
  switch (this->in_prog_)
    {
    case 'R':
      this->logger_->op_status (intArg);
      break;
    case 'S':
      this->insert_pct_S (intArg);
      return;
    case '*':
      if (allow_star)
        {
          this->last_star_ = intArg;
          this->fp_ +=
            ACE_OS::snprintf (this->fp_,
                              sizeof fmt_out_ - (this->fp_ - this->fmt_out_),
                              "%d", intArg);
          return;
        }
      break;
    }

  insert_arg_i (arg);
}

template <typename ArgT>
void ACE_Log_Formatter::insert_arg (ArgT *arg)
{
  if (!this->enabled_) return;

  this->prepare_format ();

  insert_arg_i (arg);
}

template <typename ArgT>
void ACE_Log_Formatter::insert_arg_i (ArgT arg)
{
  if (this->abort_ == ABRT_NEED_ARG)
    {
      // arg is ignored
      this->abort_ = ABRT_AFTER_FORMAT;
    }
  else if (*this->fmt_out_)
    {
      const int n = ACE_OS::snprintf (this->bp_, this->bspace_,
                                      this->fmt_out_, arg);
      ACE_UPDATE_COUNT (this->bspace_, n);
      this->bp_ += n;
    }
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (int pct_adiRS)
{
  this->insert_arg (pct_adiRS, true);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (unsigned int pct_ouxX)
{
  this->insert_arg (pct_ouxX, true);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (double pct_AeEfFgG)
{
  this->insert_arg (pct_AeEfFgG);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (long double pct_AeEfFgG)
{
  this->insert_arg (pct_AeEfFgG);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (char pct_c)
{
  this->insert_arg (pct_c);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (const char *pct_Cps)
{
  this->insert_arg (pct_Cps ? pct_Cps : "(null)");
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (ACE_INT64 pct_q)
{
  this->insert_arg (pct_q);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (ACE_UINT64 pct_Q)
{
  this->insert_arg (pct_Q);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (void (*pct_r) ())
{
  if (this->enabled_)
    {
      this->prepare_format ();
      pct_r ();
    }
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (ACE_WCHAR_T pct_wz)
{
  this->insert_arg (pct_wz);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (const ACE_WCHAR_T *pct_WZ)
{
  this->insert_arg (pct_WZ ? pct_WZ : (const ACE_WCHAR_T *) L"(null)");
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (const void *pct_at)
{
  this->insert_arg (pct_at);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (const ACE_Time_Value *pct_DT)
{
  if (!this->enabled_) return *this;

  this->prepare_format ();

  char day_and_time[27];
  const char *const time =
    ACE::timestamp (*pct_DT, day_and_time, sizeof day_and_time, true);
  const int len =
    ACE_OS::snprintf (this->bp_, this->bspace_, this->fmt_out_,
                      this->in_prog_ == 'T' ? time : day_and_time);
  ACE_UPDATE_COUNT (this->bspace_, len);
  this->bp_ += len;

  return *this;
}

#if ACE_SIZEOF_LONG == 4
ACE_Log_Formatter &ACE_Log_Formatter::operator, (long pct_Lmodifier)
{
  this->insert_arg (pct_Lmodifier, true);
  return *this;
}

ACE_Log_Formatter &ACE_Log_Formatter::operator, (unsigned long pct_Lmodifier)
{
  this->insert_arg (pct_Lmodifier, true);
  return *this;
}
#endif

bool ACE_Log_Formatter::to_record (ACE_Log_Record &record)
{
  if (!this->enabled_) return false;

  this->prepare_format ();
  if (this->bspace_) *this->bp_ = 0;

  record.priority (this->priority_);
  record.time_stamp (ACE_OS::gettimeofday ());
  record.pid (this->logger_->getpid ());
  record.msg_data (this->logger_->msg ());
  return true;
}

ssize_t ACE_Log_Msg::log (const ACE_Log_Formatter &formatter)
{
  ACE_Log_Record record;
  if (const_cast<ACE_Log_Formatter &> (formatter).to_record (record))
    {
      const ssize_t result = this->log (record, formatter.abort ());
      if (formatter.abort ())
        {
#ifndef ACE_LACKS_STDERR
          record.print (local_host_, 0, stderr);
#endif
          ACE_OS::abort ();
        }
      errno = formatter.saved_errno ();
      return result;
    }
  return 0;
}

#endif /* ACE_LACKS_VA_FUNCTIONS */


#if !defined (ACE_WIN32)
/**
 * @class ACE_Log_Msg_Sig_Guard
 *
 * @brief For use only by ACE_Log_Msg.
 *
 * Doesn't require the use of global variables or global
 * functions in an application).
 */
class ACE_Log_Msg_Sig_Guard
{
private:
  ACE_Log_Msg_Sig_Guard (void);
  ~ACE_Log_Msg_Sig_Guard (void);

  /// Original signal mask.
  sigset_t omask_;

  friend ssize_t ACE_Log_Msg::log (ACE_Log_Record &log_record,
                                   int suppress_stderr);
};

ACE_Log_Msg_Sig_Guard::ACE_Log_Msg_Sig_Guard (void)
{
#if !defined (ACE_LACKS_UNIX_SIGNALS)
  ACE_OS::sigemptyset (&this->omask_);

#  if defined (ACE_LACKS_PTHREAD_THR_SIGSETMASK)
  ACE_OS::sigprocmask (SIG_BLOCK,
                       ACE_OS_Object_Manager::default_mask (),
                       &this->omask_);
#  else
  ACE_OS::thr_sigsetmask (SIG_BLOCK,
                          ACE_OS_Object_Manager::default_mask (),
                          &this->omask_);
#  endif /* ACE_LACKS_PTHREAD_THR_SIGSETMASK */
#endif /* ACE_LACKS_UNIX_SIGNALS */
}

ACE_Log_Msg_Sig_Guard::~ACE_Log_Msg_Sig_Guard (void)
{
#if !defined (ACE_LACKS_UNIX_SIGNALS)
# if defined (ACE_LACKS_PTHREAD_THR_SIGSETMASK)
  ACE_OS::sigprocmask (SIG_SETMASK,
                       &this->omask_,
                       0);
# else
  ACE_OS::thr_sigsetmask (SIG_SETMASK,
                          &this->omask_,
                          0);
# endif /* ACE_LACKS_PTHREAD_THR_SIGSETMASK */
#endif /* ! ACE_LACKS_UNIX_SIGNALS */
}
#endif /* ! ACE_WIN32 */

ssize_t
ACE_Log_Msg::log (ACE_Log_Record &log_record,
                  int suppress_stderr)
{
  ssize_t result = 0;

  // Retrieve the flags in a local variable on the stack, it is
  // accessed by multiple threads and within this operation we
  // check it several times, so this way we only lock once
  u_long flags = this->flags ();

  // Format the message and print it to stderr and/or ship it off to
  // the log_client daemon, and/or print it to the ostream.  Of
  // course, only print the message if "SILENT" mode is disabled.
  if (ACE_BIT_DISABLED (flags, ACE_Log_Msg::SILENT))
    {
      bool tracing = this->tracing_enabled ();
      this->stop_tracing ();

#if !defined (ACE_WIN32)
      // Make this block signal-safe.
      ACE_Log_Msg_Sig_Guard sb;
#endif /* !ACE_WIN32 */

      // Do the callback, if needed, before acquiring the lock
      // to avoid holding the lock during the callback so we don't
      // have deadlock if the callback uses the logger.
      if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::MSG_CALLBACK)
          && this->msg_callback () != 0)
        {
          this->msg_callback ()->log (log_record);
        }

      // Make sure that the lock is held during all this.
      ACE_MT (ACE_GUARD_RETURN (ACE_Recursive_Thread_Mutex, ace_mon,
                                *ACE_Log_Msg_Manager::get_lock (),
                                -1));

#if !defined ACE_LACKS_STDERR || defined ACE_FACE_DEV
      if (ACE_BIT_ENABLED (flags,
                           ACE_Log_Msg::STDERR)
          && !suppress_stderr) // This is taken care of by our caller.
        log_record.print (ACE_Log_Msg::local_host_,
                          flags,
                          stderr);
#else
      ACE_UNUSED_ARG (suppress_stderr);
#endif

      if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::CUSTOM) ||
          ACE_BIT_ENABLED (flags, ACE_Log_Msg::SYSLOG) ||
          ACE_BIT_ENABLED (flags, ACE_Log_Msg::LOGGER))
        {
          // Be sure that there is a message_queue_, with multiple threads.
          ACE_MT (ACE_Log_Msg_Manager::init_backend ());
        }

      if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::LOGGER) ||
          ACE_BIT_ENABLED (flags, ACE_Log_Msg::SYSLOG))
        {
          result =
            ACE_Log_Msg_Manager::log_backend_->log (log_record);
        }

      if (ACE_BIT_ENABLED (flags, ACE_Log_Msg::CUSTOM) &&
          ACE_Log_Msg_Manager::custom_backend_ != 0)
        {
          result =
            ACE_Log_Msg_Manager::custom_backend_->log (log_record);
        }

      // This must come last, after the other two print operations
      // (see the <ACE_Log_Record::print> method for details).
      if (ACE_BIT_ENABLED (flags,
                           ACE_Log_Msg::OSTREAM)
          && this->msg_ostream () != 0)
        log_record.print (ACE_Log_Msg::local_host_,
                          flags,
#if defined (ACE_LACKS_IOSTREAM_TOTALLY)
                          static_cast<FILE *> (this->msg_ostream ())
#else  /* ! ACE_LACKS_IOSTREAM_TOTALLY */
                          *this->msg_ostream ()
#endif /* ! ACE_LACKS_IOSTREAM_TOTALLY */
                          );

      if (tracing)
        this->start_tracing ();
   }

  return result;
}

// Calls log to do the actual print, but formats first.

int
ACE_Log_Msg::log_hexdump (ACE_Log_Priority log_priority,
                          const char *buffer,
                          size_t size,
                          const ACE_TCHAR *text,
                          ACE_Log_Category_TSS* category)
{
  // Only print the message if <priority_mask_> hasn't been reset to
  // exclude this logging priority.
  if (this->log_priority_enabled (log_priority) == 0)
    return 0;

  size_t text_sz = 0;
  if (text)
    text_sz = ACE_OS::strlen (text);

  size_t const total_buffer_size =
    ACE_Log_Record::MAXLOGMSGLEN - ACE_Log_Record::VERBOSE_LEN + text_sz;

  ACE_Array<ACE_TCHAR> msg_buf(total_buffer_size);
  if (msg_buf.size() == 0)
    return -1;

  ACE_TCHAR* end_ptr = &msg_buf[0] + total_buffer_size;
  ACE_TCHAR* wr_ptr = &msg_buf[0];
  msg_buf[0] = 0; // in case size = 0

  if (text)
    wr_ptr += ACE_OS::snprintf (wr_ptr,
                                  end_ptr - wr_ptr,
#if !defined (ACE_WIN32) && defined (ACE_USES_WCHAR)
                                  ACE_TEXT ("%ls - "),
#else
                                  ACE_TEXT ("%s - "),
#endif
                                  text);

  wr_ptr += ACE_OS::snprintf (wr_ptr,
                            end_ptr - wr_ptr,
                            ACE_TEXT ("HEXDUMP ")
                            ACE_SIZE_T_FORMAT_SPECIFIER
                            ACE_TEXT (" bytes"),
                            size);

  // estimate how many bytes can be output
  // We can fit 16 bytes output in text mode per line, 4 chars per byte;
  // i.e. we need 68 bytes of buffer per line.
  size_t hexdump_size = (end_ptr - wr_ptr -58)/68*16;

  if (hexdump_size < size)
    {
      wr_ptr += ACE_OS::snprintf (wr_ptr,
                                  end_ptr - wr_ptr,
                                  ACE_TEXT (" (showing first ")
                                  ACE_SIZE_T_FORMAT_SPECIFIER
                                  ACE_TEXT (" bytes)"),
                                  hexdump_size);
      size = hexdump_size;
    }

  *wr_ptr++ = '\n';
  ACE::format_hexdump(buffer, size, wr_ptr, end_ptr - wr_ptr);

  // Now print out the formatted buffer.
  ACE_Log_Record log_record (log_priority,
                             ACE_OS::gettimeofday (),
                             this->getpid ());

  log_record.category(category);
  log_record.msg_data(&msg_buf[0]);

  this->log (log_record, false);
  return 0;
}

void
ACE_Log_Msg::set (const char *file,
                  int line,
                  int op_status,
                  int errnum,
                  bool restart,
                  ACE_OSTREAM_TYPE *os,
                  ACE_Log_Msg_Callback *c)
{
  ACE_TRACE ("ACE_Log_Msg::set");
  this->file (file);
  this->linenum (line);
  this->op_status (op_status);
  this->errnum (errnum);
  this->restart (restart);
  this->msg_ostream (os);
  this->msg_callback (c);
}

void
ACE_Log_Msg::conditional_set (const char *filename,
                              int line,
                              int status,
                              int err)
{
  this->conditional_values_.is_set_ = true;
  this->conditional_values_.file_ = filename;
  this->conditional_values_.line_ = line;
  this->conditional_values_.op_status_ = status;
  this->conditional_values_.errnum_ = err;
}

void
ACE_Log_Msg::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_Log_Msg::dump");

  ACELIB_DEBUG ((LM_DEBUG, ACE_BEGIN_DUMP, this));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("status_ = %d\n"), this->status_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nerrnum_ = %d\n"), this->errnum_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nlinenum_ = %d\n"), this->linenum_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nfile_ = %C\n"), this->file_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nmsg_ = %s\n"), this->msg_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nrestart_ = %d\n"), this->restart_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nostream_ = %@\n"), this->ostream_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nmsg_callback_ = %@\n"),
              this->msg_callback_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nprogram_name_ = %s\n"),
              this->program_name_ ? this->program_name_
                                  : ACE_TEXT ("<unknown>")));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nlocal_host_ = %s\n"),
              this->local_host_ ? this->local_host_
                                : ACE_TEXT ("<unknown>")));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nflags_ = 0x%x\n"), this->flags_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\ntrace_depth_ = %d\n"),
              this->trace_depth_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\ntrace_active_ = %d\n"),
              this->trace_active_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\ntracing_enabled_ = %d\n"),
              this->tracing_enabled_));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\npriority_mask_ = 0x%x\n"),
              this->priority_mask_));
  if (this->thr_desc_ != 0 && this->thr_desc_->state () != 0)
    ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nthr_state_ = %d\n"),
                this->thr_desc_->state ()));
  ACELIB_DEBUG ((LM_DEBUG, ACE_TEXT ("\nmsg_off_ = %d\n"), this->msg_off_));

  // Be sure that there is a message_queue_, with multiple threads.
  ACE_MT (ACE_Log_Msg_Manager::init_backend ());

  ACE_MT (ACE_Log_Msg_Manager::get_lock ()->dump ());
  // Synchronize output operations.

  ACELIB_DEBUG ((LM_DEBUG, ACE_END_DUMP));
#endif /* ACE_HAS_DUMP */
}

void
ACE_Log_Msg::thr_desc (ACE_Thread_Descriptor *td)
{
  this->thr_desc_ = td;

  if (td != 0)
    td->acquire_release ();
}

ACE_Log_Msg_Backend *
ACE_Log_Msg::msg_backend (ACE_Log_Msg_Backend *b)
{
  ACE_TRACE ("ACE_Log_Msg::msg_backend");
  ACE_MT (ACE_GUARD_RETURN (ACE_Recursive_Thread_Mutex, ace_mon,
                            *ACE_Log_Msg_Manager::get_lock (), 0));

  ACE_Log_Msg_Backend *tmp  = ACE_Log_Msg_Manager::custom_backend_;
  ACE_Log_Msg_Manager::custom_backend_ = b;
  return tmp;
}

ACE_Log_Msg_Backend *
ACE_Log_Msg::msg_backend (void)
{
  ACE_TRACE ("ACE_Log_Msg::msg_backend");
  ACE_MT (ACE_GUARD_RETURN (ACE_Recursive_Thread_Mutex, ace_mon,
                            *ACE_Log_Msg_Manager::get_lock (), 0));

  return ACE_Log_Msg_Manager::custom_backend_;
}

void
ACE_Log_Msg::msg_ostream (ACE_OSTREAM_TYPE *m, bool delete_ostream)
{
  if (this->ostream_ == m)
    {
      // Same stream, allow user to change the delete_ostream "flag"
      if (delete_ostream && !this->ostream_refcount_)
        {
#if defined (ACE_HAS_ALLOC_HOOKS)
          ACE_NEW_MALLOC (this->ostream_refcount_, static_cast<Atomic_ULong*>(ACE_Allocator::instance()->malloc(sizeof(Atomic_ULong))), Atomic_ULong (1));
#else
          ACE_NEW (this->ostream_refcount_, Atomic_ULong (1));
#endif /* ACE_HAS_ALLOC_HOOKS */
        }
      else if (!delete_ostream && this->ostream_refcount_)
        {
          if (--*this->ostream_refcount_ == 0)
            {
#if defined (ACE_HAS_ALLOC_HOOKS)
              this->ostream_refcount_->~Atomic_ULong();
              ACE_Allocator::instance()->free(this->ostream_refcount_);
#else
              delete this->ostream_refcount_;
#endif /* ACE_HAS_ALLOC_HOOKS */
            }
          this->ostream_refcount_ = 0;
        }
      // The other two cases are no-ops, the user has requested the same
      // state that's already present.
      return;
    }

  this->cleanup_ostream ();

  if (delete_ostream)
    {
#if defined (ACE_HAS_ALLOC_HOOKS)
      ACE_NEW_MALLOC (this->ostream_refcount_, static_cast<Atomic_ULong*>(ACE_Allocator::instance()->malloc(sizeof(Atomic_ULong))), Atomic_ULong (1));
#else
      ACE_NEW (this->ostream_refcount_, Atomic_ULong (1));
#endif /* ACE_HAS_ALLOC_HOOKS */
    }

  this->ostream_ = m;
}

void
ACE_Log_Msg::local_host (const ACE_TCHAR *s)
{
  if (s)
    {
#if defined (ACE_HAS_ALLOC_HOOKS)
      ACE_Allocator::instance()->free ((void *) ACE_Log_Msg::local_host_);
#else
      ACE_OS::free ((void *) ACE_Log_Msg::local_host_);
#endif /* ACE_HAS_ALLOC_HOOKS */

      ACE_ALLOCATOR (ACE_Log_Msg::local_host_, ACE_OS::strdup (s));
    }
}

#ifndef ACE_LACKS_VA_FUNCTIONS
int
ACE_Log_Msg::log_priority_enabled (ACE_Log_Priority log_priority,
                                   const char *,
                                   ...)
{
  return this->log_priority_enabled (log_priority);
}

#if defined (ACE_USES_WCHAR)
int
ACE_Log_Msg::log_priority_enabled (ACE_Log_Priority log_priority,
                                   const wchar_t *,
                                   ...)
{
  return this->log_priority_enabled (log_priority);
}
#endif /* ACE_USES_WCHAR */

#endif /* ACE_LACKS_VA_FUNCTIONS */

// ****************************************************************

void
ACE_Log_Msg::init_hook (ACE_OS_Log_Msg_Attributes &attributes
# if defined (ACE_HAS_WIN32_STRUCTURAL_EXCEPTIONS)
                        , ACE_SEH_EXCEPT_HANDLER selector
                        , ACE_SEH_EXCEPT_HANDLER handler
# endif /* ACE_HAS_WIN32_STRUCTURAL_EXCEPTIONS */
                                   )
{
# if defined (ACE_HAS_WIN32_STRUCTURAL_EXCEPTIONS)
  attributes.seh_except_selector_ = selector;
  attributes.seh_except_handler_ = handler;
# endif /* ACE_HAS_WIN32_STRUCTURAL_EXCEPTIONS */
  if (ACE_Log_Msg::exists ())
    {
      ACE_Log_Msg *inherit_log = ACE_LOG_MSG;
      attributes.ostream_ = inherit_log->msg_ostream ();
      if (attributes.ostream_ && inherit_log->ostream_refcount_)
        {
          ++*inherit_log->ostream_refcount_;
          attributes.ostream_refcount_ = inherit_log->ostream_refcount_;
        }
      else
        {
          attributes.ostream_refcount_ = 0;
        }
      attributes.priority_mask_ = inherit_log->priority_mask ();
      attributes.tracing_enabled_ = inherit_log->tracing_enabled ();
      attributes.restart_ = inherit_log->restart ();
      attributes.trace_depth_ = inherit_log->trace_depth ();
    }
}

void
ACE_Log_Msg::inherit_hook (ACE_OS_Thread_Descriptor *thr_desc,
                           ACE_OS_Log_Msg_Attributes &attributes)
{
#if !defined (ACE_THREADS_DONT_INHERIT_LOG_MSG)  && \
    !defined (ACE_HAS_MINIMAL_ACE_OS)
  // Inherit the logging features if the parent thread has an
  // <ACE_Log_Msg>.  Note that all of the following operations occur
  // within thread-specific storage.
  ACE_Log_Msg *new_log = ACE_LOG_MSG;

  // Note that we do not inherit the callback because this might have
  // been allocated off of the stack of the original thread, in which
  // case all hell would break loose...

  if (attributes.ostream_)
    {
      new_log->ostream_ = attributes.ostream_;
      new_log->ostream_refcount_ =
        static_cast<Atomic_ULong *> (attributes.ostream_refcount_);

      new_log->priority_mask (attributes.priority_mask_);

      if (attributes.tracing_enabled_)
        new_log->start_tracing ();

      new_log->restart (attributes.restart_);
      new_log->trace_depth (attributes.trace_depth_);
    }

  // @@ Now the TSS Log_Msg has been created, cache my thread
  // descriptor in.

  if (thr_desc != 0)
    // This downcast is safe.  We do it to avoid having to #include
    // ace/Thread_Manager.h.
    new_log->thr_desc (static_cast<ACE_Thread_Descriptor *> (thr_desc));
  // Block the thread from proceeding until
  // thread manager has thread descriptor ready.
#endif /* ! ACE_THREADS_DONT_INHERIT_LOG_MSG  &&  ! ACE_HAS_MINIMAL_ACE_OS */
}

ACE_END_VERSIONED_NAMESPACE_DECL
