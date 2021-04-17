#include "ace/Synch_Options.h"

#include "ace/Global_Macros.h"
#include "ace/config-all.h"

#if defined (ACE_HAS_ALLOC_HOOKS)
# include "ace/Malloc_Base.h"
#endif /* ACE_HAS_ALLOC_HOOKS */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE (ACE_Synch_Options)

void
ACE_Synch_Options::dump (void) const
{
#if defined (ACE_HAS_DUMP)
  ACE_TRACE ("ACE_Synch_Options::dump");
#endif /* ACE_HAS_DUMP */
}

// Static initialization.
// Note: these three objects require static construction and destruction.

/* static */
ACE_Synch_Options ACE_Synch_Options::defaults;

/* static */
ACE_Synch_Options ACE_Synch_Options::synch;

/* static */
ACE_Synch_Options ACE_Synch_Options::asynch (ACE_Synch_Options::USE_REACTOR);

ACE_Synch_Options::ACE_Synch_Options (unsigned long options,
                                      const ACE_Time_Value &timeout,
                                      const void *arg)
{
  // ACE_TRACE ("ACE_Synch_Options::ACE_Synch_Options");
  this->set (options, timeout, arg);
}

void
ACE_Synch_Options::set (unsigned long options,
                        const ACE_Time_Value &timeout,
                        const void *arg)
{
  // ACE_TRACE ("ACE_Synch_Options::set");
  this->options_ = options;
  this->timeout_ = timeout;

  /*
   * Not using ACE_Time_Value::zero because of possible static init order
   * dependence. It would work fine because the memory would all zeros anyways,
   * but ubsan complains about it.
   */
  if (timeout_ != ACE_Time_Value(0))
    ACE_SET_BITS (this->options_, ACE_Synch_Options::USE_TIMEOUT);

  this->arg_ = arg;
}

bool
ACE_Synch_Options::operator[] (unsigned long option) const
{
  ACE_TRACE ("ACE_Synch_Options::operator[]");
  return (this->options_ & option) != 0;
}

void
ACE_Synch_Options::operator= (unsigned long option)
{
  ACE_TRACE ("ACE_Synch_Options::operator=");
  this->options_ |= option;
}

const ACE_Time_Value &
ACE_Synch_Options::timeout (void) const
{
  ACE_TRACE ("ACE_Synch_Options::timeout");
  return this->timeout_;
}

void
ACE_Synch_Options::timeout (const ACE_Time_Value &tv)
{
  ACE_TRACE ("ACE_Synch_Options::timeout");
  this->timeout_ = tv;
}

const ACE_Time_Value *
ACE_Synch_Options::time_value (void) const
{
  ACE_TRACE ("ACE_Synch_Options::time_value");
  return (*this)[USE_TIMEOUT] ? &this->timeout_ : 0;
}

const void *
ACE_Synch_Options::arg (void) const
{
  ACE_TRACE ("ACE_Synch_Options::arg");
  return this->arg_;
}

void
ACE_Synch_Options::arg (const void *a)
{
  ACE_TRACE ("ACE_Synch_Options::arg");
  this->arg_ = a;
}

ACE_END_VERSIONED_NAMESPACE_DECL
