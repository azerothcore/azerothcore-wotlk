#ifndef ACE_CONFIG_MACOSX_MOJAVE_H
#define ACE_CONFIG_MACOSX_MOJAVE_H

// Get access to IPV6_RECVPKTINFO
// See http://lxr.nginx.org/ident?_i=__APPLE_USE_RFC_3542
#ifndef __APPLE_USE_RFC_3542
#define __APPLE_USE_RFC_3542
#endif

#include "ace/config-macosx-highsierra.h"

#endif // ACE_CONFIG_MACOSX_MOJAVE_H
