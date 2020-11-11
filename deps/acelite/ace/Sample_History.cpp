#include "ace/Sample_History.h"

#if !defined (__ACE_INLINE__)
#include "ace/Sample_History.inl"
#endif /* __ACE_INLINE__ */

#include "ace/Basic_Stats.h"
#include "ace/Log_Category.h"
#include "ace/OS_Memory.h"

#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_Sample_History::ACE_Sample_History (size_t max_samples)
  : max_samples_ (max_samples)
  , sample_count_ (0)
{
#if defined (ACE_HAS_ALLOC_HOOKS)
  ACE_ALLOCATOR(this->samples_, static_cast<ACE_UINT64*>(ACE_Allocator::instance()->malloc(sizeof(ACE_UINT64) * this->max_samples_)));
#else
  ACE_NEW(this->samples_, ACE_UINT64[this->max_samples_]);
#endif /* ACE_HAS_ALLOC_HOOKS */
}

ACE_Sample_History::~ACE_Sample_History (void)
{
#if defined (ACE_HAS_ALLOC_HOOKS)
  ACE_Allocator::instance()->free(this->samples_);
#else
  delete[] this->samples_;
#endif /* ACE_HAS_ALLOC_HOOKS */
}

void
ACE_Sample_History::dump_samples (
    const ACE_TCHAR *msg,
    ACE_Sample_History::scale_factor_type scale_factor) const
{
#ifndef ACE_NLOGGING
  for (size_t i = 0; i != this->sample_count_; ++i)
    {
      ACE_UINT64 const val = this->samples_[i] / scale_factor;
      ACELIB_DEBUG ((LM_DEBUG,
                  ACE_TEXT ("%s: ")
                  ACE_SIZE_T_FORMAT_SPECIFIER
                  ACE_TEXT ("\t%Q\n"),
                  msg,
                  i,
                  val));
    }
#else
  ACE_UNUSED_ARG (msg);
  ACE_UNUSED_ARG (scale_factor);
#endif /* ACE_NLOGGING */
}

void
ACE_Sample_History::collect_basic_stats (ACE_Basic_Stats &stats) const
{
  for (size_t i = 0; i != this->sample_count_; ++i)
    {
      stats.sample (this->samples_[i]);
    }
}

ACE_END_VERSIONED_NAMESPACE_DECL
