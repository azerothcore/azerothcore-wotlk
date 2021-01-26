/* -*- C++ -*- */
// The following configuration file is designed to work for VxWorks
// 7.0 platforms using one of these compilers:
// 1) The GNU g++ compiler that is shipped with VxWorks 7.0
// (other compilers not yet tested)

#ifndef ACE_CONFIG_VXWORKS_7_0_H
#define ACE_CONFIG_VXWORKS_7_0_H
#include /**/ "ace/pre.h"

#if !defined (ACE_VXWORKS)
# define ACE_VXWORKS 0x700
#endif /* ! ACE_VXWORKS */

#include "ace/config-vxworks6.9.h"

#define ACE_HAS_AUTOMATIC_INIT_FINI

#if defined ACE_HAS_PTHREADS && !defined __RTP__
# define ACE_HAS_RECURSIVE_THR_EXIT_SEMANTICS
#endif

#ifndef ACE_LACKS_REGEX_H
# define ACE_LACKS_REGEX_H
#endif

#ifndef __RTP__
# define ACE_LACKS_ALARM
#endif

#include /**/ "ace/post.h"
#endif /* ACE_CONFIG_VXWORKS_7_0_H */

