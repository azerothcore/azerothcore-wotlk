#include "ace/Log_Msg.h"
#include "ace/Log_Category.h"
#include "ace/Atomic_Op.h"
#include "ace/OS_NS_Thread.h"

#if !defined (__ACE_INLINE__)
#include "ace/Log_Category.inl"
#endif /* __ACE_INLINE__ */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

#if defined (ACE_HAS_THREADS)
extern "C" void
ACE_Log_Category_tss_destroy(void * p)
{
  delete static_cast<ACE_Log_Category_TSS*>(p);
}
#endif // defined (ACE_HAS_THREADS)

ACE_Log_Category::ACE_Log_Category(const char* name)
  : name_(name)
  , id_(0)
/// Default per-process priority mask
/// By default, all priorities are enabled.
  , priority_mask_(LM_SHUTDOWN
                   | LM_TRACE
                   | LM_DEBUG
                   | LM_INFO
                   | LM_NOTICE
                   | LM_WARNING
                   | LM_STARTUP
                   | LM_ERROR
                   | LM_CRITICAL
                   | LM_ALERT
                   | LM_EMERGENCY)
#if defined (ACE_HAS_THREADS)
  , key_(ACE_OS::NULL_key)
#else
  , per_thr_obj_(this, 0)
#endif
{
}

ACE_Log_Category::~ACE_Log_Category()
{
#if defined (ACE_HAS_THREADS)
  ACE_GUARD (ACE_Thread_Mutex, ace_mon, this->keylock_);

  if (this->id_ > 0)
    {
      void *temp = 0;
      if (ACE_OS::thr_getspecific (this->key_, &temp) == -1)
        {
          return; // This should not happen!
        }
      if (temp != 0) {
        delete static_cast <ACE_Log_Category_TSS *> (temp);
        ACE_OS::thr_setspecific (this->key_, 0);
      }
      ACE_OS::thr_keyfree (this->key_);
    }
#endif
}

ACE_Log_Category_TSS::ACE_Log_Category_TSS(ACE_Log_Category* category, ACE_Log_Msg* logger)
  : category_(category)
  , logger_(logger)
  , priority_mask_(0)
{
}

ACE_ALLOC_HOOK_DEFINE(ACE_Log_Category_TSS)

ACE_Log_Category_TSS*
ACE_Log_Category::per_thr_obj()
{
#if defined (ACE_HAS_THREADS)
  {
    // Ensure that we are serialized!
    ACE_GUARD_RETURN (ACE_Thread_Mutex, ace_mon, this->keylock_, 0);

    // make sure we only create the key once!
    if (this->id_ == 0)
      {
        static ACE_Atomic_Op<ACE_Thread_Mutex, unsigned int> log_category_id_assigner(1);
        id_ = log_category_id_assigner++; // for atomic integers, post increment is more efficient

        if (ACE_OS::thr_keycreate (&this->key_,
                                   &ACE_Log_Category_tss_destroy) != 0)
          return 0; // Major problems, this should *never* happen!
      }
  }

  void *temp = 0;
  if (ACE_OS::thr_getspecific (this->key_, &temp) == -1)
    {
      return 0; // This should not happen!
    }
  if (temp != 0)
    return static_cast <ACE_Log_Category_TSS *> (temp);

  ACE_Log_Category_TSS * result;

  ACE_NEW_RETURN(result,
                 ACE_Log_Category_TSS(this, ACE_Log_Msg::instance()),
                 0);

 if (ACE_OS::thr_setspecific (this->key_,
                              result) != 0)
   {
     return 0;
   }

  return result;
#else // defined (ACE_HAS_THREADS)
  if (this->id_ == 0) {
    static unsigned int log_category_id_assigner = 0;
    id_ = log_category_id_assigner++;
    per_thr_obj_.logger_ = ACE_Log_Msg::instance();
  }
  return &per_thr_obj_;
#endif // defined (ACE_HAS_THREADS)
}

ACE_Log_Category&
ACE_Log_Category::ace_lib()
{
  static ACE_Log_Category ace_lib_category("ACE");
  return ace_lib_category;
}

ACE_END_VERSIONED_NAMESPACE_DECL
