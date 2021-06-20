// -*- C++ -*-

//=============================================================================
/**
 *  @file    Reactor_Timer_Interface.h
 *
 *  @author Irfan Pyarali <irfan@oomworks.com>
 */
//=============================================================================

#ifndef ACE_REACTOR_TIMER_INTERFACE_H
#define ACE_REACTOR_TIMER_INTERFACE_H

#include /**/ "ace/pre.h"

#include "ace/Time_Value.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

class ACE_Event_Handler;

/**
 * @class ACE_Reactor_Timer_Interface
 *
 * @brief Interface for timer related methods on the Reactor.
 */
class ACE_Export ACE_Reactor_Timer_Interface
{
public:
  virtual ~ACE_Reactor_Timer_Interface (void);

  virtual long schedule_timer (ACE_Event_Handler *event_handler,
                               const void *arg,
                               const ACE_Time_Value &delay,
                               const ACE_Time_Value &interval = ACE_Time_Value::zero) = 0;

#if defined (ACE_HAS_CPP11)
  template<class Rep1, class Period1, class Rep2 = int, class Period2 = std::ratio<1>>
  long schedule_timer (ACE_Event_Handler *event_handler,
                       const void *arg,
                       const std::chrono::duration<Rep1, Period1>& delay,
                       const std::chrono::duration<Rep2, Period2>& interval = std::chrono::duration<Rep2, Period2>::zero ())
  {
    ACE_Time_Value const tv_delay (delay);
    ACE_Time_Value const tv_interval (interval);
    return this->schedule_timer (event_handler, arg, tv_delay, tv_interval);
  }
#endif

  virtual int reset_timer_interval (long timer_id,
                                    const ACE_Time_Value &interval) = 0;
#if defined (ACE_HAS_CPP11)
  template<class Rep, class Period>
  int reset_timer_interval (long timer_id,
                            const std::chrono::duration<Rep, Period>& interval)
  {
    ACE_Time_Value const tv_interval (interval);
    return this->reset_timer_interval (timer_id, tv_interval);
  }
#endif

  virtual int cancel_timer (long timer_id,
                            const void **arg = 0,
                            int dont_call_handle_close = 1) = 0;

  virtual int cancel_timer (ACE_Event_Handler *event_handler,
                            int dont_call_handle_close = 1) = 0;

};

ACE_END_VERSIONED_NAMESPACE_DECL

#include /**/ "ace/post.h"

#endif /* ACE_REACTOR_TIMER_INTERFACE_H */
