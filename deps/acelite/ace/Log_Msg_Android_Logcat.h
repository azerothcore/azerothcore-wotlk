/**
 * @file Log_Msg_Android_Logcat.h
 *
 * @author Frederick Hornsey <hornseyf@objectcomputing.com>
 */

#ifndef ACE_LOG_MSG_ANDROID_LOGCAT_H
#define ACE_LOG_MSG_ANDROID_LOGCAT_H

#include /**/ "ace/pre.h"

#include /**/ "ace/config-all.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#ifdef ACE_ANDROID

#include "ace/Log_Msg_Backend.h"
#include "ace/Basic_Types.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

/**
 * @class ACE_Log_Msg_Android_Logcat
 *
 * @brief Implements an ACE_Log_Msg_Backend that logs messages to Android's
 * logging system, called Logcat. On Android this is the default output for ACE
 * and the only convenient way of logging.
 *
 * Reference to the Logging part of Android's NDK API can be found here:
 * https://developer.android.com/ndk/reference/group/logging
 */
class ACE_Export ACE_Log_Msg_Android_Logcat : public ACE_Log_Msg_Backend
{
public:
  ACE_Log_Msg_Android_Logcat ();
  virtual ~ACE_Log_Msg_Android_Logcat ();

  /// Initialize the event logging facility. NOP in this class.
  virtual int open (const ACE_TCHAR *);

  /// Reset the backend. NOP in this class.
  virtual int reset ();

  /// Close the backend completely. NOP in this class.
  virtual int close ();

  /// This is called when we want to log a message.
  virtual ssize_t log (ACE_Log_Record &log_record);
};

ACE_END_VERSIONED_NAMESPACE_DECL

#endif

#include /**/ "ace/post.h"
#endif /* ACE_LOG_MSG_ANDROID_LOGCAT */
