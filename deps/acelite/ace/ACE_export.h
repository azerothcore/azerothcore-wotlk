// -*- C++ -*-
// Definition for Win32 Export directives.
// This file is generated automatically by
// generate_export_file.pl
// ------------------------------

#ifndef ACE_EXPORT_H
#define ACE_EXPORT_H

#include /**/ "ace/config-lite.h"

#if defined (ACE_AS_STATIC_LIBS)

# if !defined (ACE_HAS_DLL)
#   define ACE_HAS_DLL 0
# endif /* ! ACE_HAS_DLL */
#else
# if !defined (ACE_HAS_DLL)
#   define ACE_HAS_DLL 1
# endif /* ! ACE_HAS_DLL */
#endif /* ACE_AS_STATIC_LIB */

#if defined (ACE_HAS_DLL)
#  if (ACE_HAS_DLL == 1)
#    if defined (ACE_BUILD_DLL)
#      define ACE_Export ACE_Proper_Export_Flag
#      define ACE_SINGLETON_DECLARATION(T) ACE_EXPORT_SINGLETON_DECLARATION (T)
#      define ACE_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK) ACE_EXPORT_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK)
#    else
#      define ACE_Export ACE_Proper_Import_Flag
#      define ACE_SINGLETON_DECLARATION(T) ACE_IMPORT_SINGLETON_DECLARATION (T)
#      define ACE_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK) ACE_IMPORT_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK)
#    endif /* ACE_BUILD_DLL */
#  else
#    define ACE_Export
#    define ACE_SINGLETON_DECLARATION(T)
#    define ACE_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK)
#  endif   /* ! ACE_HAS_DLL == 1 */
#else
#  define ACE_Export
#  define ACE_SINGLETON_DECLARATION(T)
#  define ACE_SINGLETON_DECLARE(SINGLETON_TYPE, CLASS, LOCK)
#endif     /* ACE_HAS_DLL */

#define ACE_NAMESPACE_STORAGE_CLASS extern ACE_EXPORT_MACRO

#if defined (__ACE_INLINE__)
#  define ACE_NAMESPACE_INLINE_FUNCTION inline
#  define ACE_INLINE_TEMPLATE_FUNCTION inline
#else
#  define ACE_NAMESPACE_INLINE_FUNCTION ACE_NAMESPACE_STORAGE_CLASS
// Microsoft Visual C++ will accept 'extern'; others refuse.
#  if defined (_MSC_VER) || defined (__BORLANDC__)
#    define ACE_INLINE_TEMPLATE_FUNCTION ACE_Export
#  else
#    define ACE_INLINE_TEMPLATE_FUNCTION
#  endif
#endif

#endif     /* ACE_EXPORT_H */

// End of auto generated file.
