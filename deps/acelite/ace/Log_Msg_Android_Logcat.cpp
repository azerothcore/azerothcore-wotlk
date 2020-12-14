#include "ace/config-all.h"

#ifdef ACE_ANDROID

#include <android/log.h> // Android Logging Functions

#include "ace/ACE.h"
#include "ace/Log_Category.h"
#include "ace/Log_Msg_Android_Logcat.h"
#include "ace/Log_Record.h"
#include "ace/OS_NS_string.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

/**
 * Convert ACE Log Priority to Android Logcat Priority
 */
static android_LogPriority
convert_log_priority (ACE_Log_Priority lm_priority)
{
  switch (lm_priority) {
  case LM_TRACE:
  case LM_DEBUG:
    return ANDROID_LOG_DEBUG;
  case LM_STARTUP:
  case LM_SHUTDOWN:
  case LM_INFO:
  case LM_NOTICE:
    return ANDROID_LOG_INFO;
  case LM_WARNING:
    return ANDROID_LOG_WARN;
  case LM_CRITICAL:
  case LM_ALERT:
  case LM_EMERGENCY:
    return ANDROID_LOG_FATAL;
  case LM_ERROR:
  default:
    return ANDROID_LOG_ERROR;
  }
}

ACE_Log_Msg_Android_Logcat::ACE_Log_Msg_Android_Logcat ()
{
}

ACE_Log_Msg_Android_Logcat::~ACE_Log_Msg_Android_Logcat (void)
{
  this->close ();
}

int
ACE_Log_Msg_Android_Logcat::open (const ACE_TCHAR *)
{
  return 0;
}

int
ACE_Log_Msg_Android_Logcat::reset (void)
{
  return close ();
}

int
ACE_Log_Msg_Android_Logcat::close (void)
{
  return 0;
}

ssize_t
ACE_Log_Msg_Android_Logcat::log (ACE_Log_Record &log_record)
{
  __android_log_write (
    convert_log_priority (static_cast<ACE_Log_Priority> (log_record.type ())),
    "ACE",
    log_record.msg_data ());
  return 0;
}

ACE_END_VERSIONED_NAMESPACE_DECL

#endif
