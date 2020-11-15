#ifndef ACE_CONFIG_MACOSX_IPHONE_H
#define ACE_CONFIG_MACOSX_IPHONE_H

#define ACE_HAS_IPHONE
#define ACE_LACKS_SYSTEM

#include "ace/config-macosx-mojave.h"

#ifdef ACE_HAS_SYSV_IPC
#undef ACE_HAS_SYSV_IPC
#endif

#endif /* ACE_CONFIG_MACOSX_IPHONE_H */
