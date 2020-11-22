// -*- C++ -*-

//=============================================================================
/**
 *  @file    Static_Object_Lock.h
 *
 *  @author David L. Levine <levine@cs.wustl.edu>
 *  @author Matthias Kerkhoff
 *  @author Per Andersson
 */
//=============================================================================

#ifndef ACE_STATIC_OBJECT_LOCK_H
#define ACE_STATIC_OBJECT_LOCK_H
#include /**/ "ace/pre.h"

#include /**/ "ace/ACE_export.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#if defined (ACE_HAS_THREADS)

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

class ACE_Recursive_Thread_Mutex;

/**
 * @class ACE_Static_Object_Lock
 *
 * @brief Provide an interface to access a global lock.
 *
 * This class is used to serialize the creation of static
 * singleton objects.  It really isn't needed any more, because
 * anyone can access ACE_STATIC_OBJECT_LOCK directly.  But, it
 * is retained for backward compatibility.
 */
class ACE_Export ACE_Static_Object_Lock
{
public:
  /// Static lock access point.
  static ACE_Recursive_Thread_Mutex *instance (void);

  /// For use only by ACE_Object_Manager to clean up lock if it
  /// what dynamically allocated.
  static void cleanup_lock (void);
};

ACE_END_VERSIONED_NAMESPACE_DECL

#endif /* ACE_HAS_THREADS */

#include /**/ "ace/post.h"
#endif /* ACE_STATIC_OBJECT_LOCK_H */
