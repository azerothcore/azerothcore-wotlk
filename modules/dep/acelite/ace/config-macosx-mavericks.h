#ifndef ACE_CONFIG_MACOSX_MAVERICKS_H
#define ACE_CONFIG_MACOSX_MAVERICKS_H

// Mac OS X has broken symbol visibility.  Unless we're told otherwise,
// disable it by default.
#ifndef ACE_HAS_CUSTOM_EXPORT_MACROS
#define ACE_HAS_CUSTOM_EXPORT_MACROS 0
#endif

#ifndef ACE_HAS_SSIZE_T
#define ACE_HAS_SSIZE_T
#endif

#include "ace/config-macosx-mountainlion.h"

#endif // ACE_CONFIG_MAVERICKS_H
