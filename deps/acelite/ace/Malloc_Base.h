// -*- C++ -*-

//=============================================================================
/**
 *  @file    Malloc_Base.h
 *
 *  @author Doug Schmidt and Irfan Pyarali
 */
//=============================================================================


#ifndef ACE_MALLOC_BASE_H
#define ACE_MALLOC_BASE_H
#include /**/ "ace/pre.h"

#include /**/ "ace/ACE_export.h"

#if !defined (ACE_LACKS_PRAGMA_ONCE)
# pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "ace/os_include/sys/os_types.h"
#include "ace/os_include/sys/os_mman.h"
#include "ace/os_include/sys/os_types.h"
#include <limits>
#include <new>

ACE_BEGIN_VERSIONED_NAMESPACE_DECL

// The definition of this class is located in Malloc.cpp.

/**
 * @class ACE_Allocator
 *
 * @brief Interface for a dynamic memory allocator that uses inheritance
 * and dynamic binding to provide extensible mechanisms for
 * allocating and deallocating memory.
 */
class ACE_Export ACE_Allocator
{
public:
  /// Unsigned integer type used for specifying memory block lengths.
  typedef size_t size_type;

  // = Memory Management

  /// Get pointer to a default ACE_Allocator.
  static ACE_Allocator *instance (void);

  /// Set pointer to a process-wide ACE_Allocator and return existing
  /// pointer.
  static ACE_Allocator *instance (ACE_Allocator *);

  /// Delete the dynamically allocated Singleton
  static void close_singleton (void);

  /// "No-op" constructor (needed to make certain compilers happy).
  ACE_Allocator (void);

  /// Virtual destructor
  virtual ~ACE_Allocator (void);

  /// Allocate @a nbytes, but don't give them any initial value.
  virtual void *malloc (size_type nbytes) = 0;

  /// Allocate @a nbytes, giving them @a initial_value.
  virtual void *calloc (size_type nbytes, char initial_value = '\0') = 0;

  /// Allocate @a n_elem each of size @a elem_size, giving them
  /// @a initial_value.
  virtual void *calloc (size_type n_elem,
                        size_type elem_size,
                        char initial_value = '\0') = 0;

  /// Free @a ptr (must have been allocated by ACE_Allocator::malloc()).
  virtual void free (void *ptr) = 0;

  /// Remove any resources associated with this memory manager.
  virtual int remove (void) = 0;

  // = Map manager like functions

  /**
   * Associate @a name with @a pointer.  If @a duplicates == 0 then do
   * not allow duplicate @a name/@a pointer associations, else if
   * @a duplicates != 0 then allow duplicate @a name/@a pointer
   * associations.  Returns 0 if successfully binds (1) a previously
   * unbound @a name or (2) @a duplicates != 0, returns 1 if trying to
   * bind a previously bound @a name and @a duplicates == 0, else
   * returns -1 if a resource failure occurs.
   */
  virtual int bind (const char *name, void *pointer, int duplicates = 0) = 0;

  /**
   * Associate @a name with @a pointer.  Does not allow duplicate
   * @a name/@a pointer associations.  Returns 0 if successfully binds
   * (1) a previously unbound @a name, 1 if trying to bind a previously
   * bound @a name, or returns -1 if a resource failure occurs.  When
   * this call returns @a pointer's value will always reference the
   * void * that @a name is associated with.  Thus, if the caller needs
   * to use @a pointer (e.g., to free it) a copy must be maintained by
   * the caller.
   */
  virtual int trybind (const char *name, void *&pointer) = 0;

  /// Locate @a name and pass out parameter via pointer.  If found,
  /// return 0, returns -1 if failure occurs.
  virtual int find (const char *name, void *&pointer) = 0;

  /// Returns 0 if the name is in the mapping. -1, otherwise.
  virtual int find (const char *name) = 0;

  /// Unbind (remove) the name from the map.  Don't return the pointer
  /// to the caller
  virtual int unbind (const char *name) = 0;

  /// Break any association of name.  Returns the value of pointer in
  /// case the caller needs to deallocate memory.
  virtual int unbind (const char *name, void *&pointer) = 0;

  // = Protection and "sync" (i.e., flushing memory to persistent
  // backing store).

  /**
   * Sync @a len bytes of the memory region to the backing store
   * starting at @c this->base_addr_.  If @a len == -1 then sync the
   * whole region.
   */
  virtual int sync (ssize_t len = -1, int flags = MS_SYNC) = 0;

  /// Sync @a len bytes of the memory region to the backing store
  /// starting at @a addr.
  virtual int sync (void *addr, size_type len, int flags = MS_SYNC) = 0;

  /**
   * Change the protection of the pages of the mapped region to @a prot
   * starting at <this->base_addr_> up to @a len bytes.  If @a len == -1
   * then change protection of all pages in the mapped region.
   */
  virtual int protect (ssize_t len = -1, int prot = PROT_RDWR) = 0;

  /// Change the protection of the pages of the mapped region to @a prot
  /// starting at @a addr up to @a len bytes.
  virtual int protect (void *addr, size_type len, int prot = PROT_RDWR) = 0;

#if defined (ACE_HAS_MALLOC_STATS)
  /// Dump statistics of how malloc is behaving.
  virtual void print_stats (void) const = 0;
#endif /* ACE_HAS_MALLOC_STATS */

  /// Dump the state of the object.
  virtual void dump (void) const = 0;
private:
  // DO NOT ADD ANY STATE (DATA MEMBERS) TO THIS CLASS!!!!  See the
  // <ACE_Allocator::instance> implementation for explanation.

  /// Pointer to a process-wide ACE_Allocator instance.
  static ACE_Allocator *allocator_;
};

/**
 * @class ACE_Allocator_Std_Adapter
 *
 * @brief Model of std::allocator that forwards requests to
#  ACE_Allocator::instance.  To be used with STL containers.
 */

template <typename T>
class ACE_Export ACE_Allocator_Std_Adapter
{
public:
  typedef T value_type;
  typedef T* pointer;
  typedef const T* const_pointer;
  typedef T& reference;
  typedef const T& const_reference;
  typedef std::size_t size_type;
  typedef std::ptrdiff_t difference_type;
  template <typename U> struct rebind { typedef ACE_Allocator_Std_Adapter<U> other; };

  ACE_Allocator_Std_Adapter() {}

  template <typename U>
  ACE_Allocator_Std_Adapter(const ACE_Allocator_Std_Adapter<U>&) {}

  static T* allocate(std::size_t n)
  {
    void* raw_mem = ACE_Allocator::instance()->malloc(n * sizeof(T));
    if (!raw_mem) throw std::bad_alloc();
    return static_cast<T*>(raw_mem);
  }

  static void deallocate(T* ptr, std::size_t)
  {
    ACE_Allocator::instance()->free(ptr);
  }

  static void construct(T* ptr, const T& value)
  {
    new (static_cast<void*>(ptr)) T(value);
  }

  static void destroy(T* ptr)
  {
    ptr->~T();
  }

  static size_type max_size()
  {
    return (std::numeric_limits<size_type>::max)();
  }
};

template <typename T, typename U>
bool operator==(const ACE_Allocator_Std_Adapter<T>&, const ACE_Allocator_Std_Adapter<U>&)
{
  return true;
}

template <typename T, typename U>
bool operator!=(const ACE_Allocator_Std_Adapter<T>&, const ACE_Allocator_Std_Adapter<U>&)
{
  return false;
}

ACE_END_VERSIONED_NAMESPACE_DECL

#include /**/ "ace/post.h"
#endif /* ACE_MALLOC_BASE_H */
