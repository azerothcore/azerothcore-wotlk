#ifndef __ACE_CONFIG_H__
#define __ACE_CONFIG_H__

#if defined(_WIN32)
#  include "ace/config-win32.h"
#elif defined(__linux) || defined(__linux__)
#  include "ace/config-linux.h"
#elif defined(__FreeBSD__)
#  include "ace/config-freebsd.h"
#elif defined(__APPLE__)
#  include "ace/config-macosx.h"
#endif

#endif