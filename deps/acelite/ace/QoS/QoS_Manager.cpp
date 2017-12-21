// QoS_Manager.cpp
#include "QoS_Manager.h"
#include "ace/Log_Category.h"

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

ACE_ALLOC_HOOK_DEFINE(ACE_QOS_MANAGER)

ACE_QoS_Manager::ACE_QoS_Manager (void)
{}

ACE_QoS_Manager::~ACE_QoS_Manager (void)
{}

// Adds the given session to the list of session objects joined by
// this socket.

int
ACE_QoS_Manager::join_qos_session (ACE_QoS_Session *qos_session)
{
  if (this->qos_session_set ().insert (qos_session) != 0)
    ACELIB_ERROR_RETURN ((LM_ERROR,
                       ACE_TEXT ("Error in adding a new session to the ")
                       ACE_TEXT ("socket session set\n")),
                      -1);
  return 0;
}

// Returns the QoS session set for this socket.

ACE_Unbounded_Set <ACE_QoS_Session *>
ACE_QoS_Manager::qos_session_set (void)
{
  return this->qos_session_set_;
}

ACE_END_VERSIONED_NAMESPACE_DECL
