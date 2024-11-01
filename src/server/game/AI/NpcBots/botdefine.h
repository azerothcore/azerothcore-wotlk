#ifndef BOTDEFINE_H_
#define BOTDEFINE_H_

#include "Define.h"

#ifdef _MSC_VER
# define __PRAGMA_STR2__(x) #x
# define __PRAGMA_STR1__(x) __PRAGMA_STR2__(x)
# define __PRAGMA_LOC__ __FILE__ "("__PRAGMA_STR1__(__LINE__)") "
# define PRAGMA_WARN(x) __pragma(message(__PRAGMA_LOC__ ": warning: " #x))
#else
# define PRAGMA_WARN(x)
#endif

#ifdef TRINITY_COMPILER
# define Bcore Trinity
# define BOT_LOG_TRACE TC_LOG_TRACE
# define BOT_LOG_DEBUG TC_LOG_DEBUG
# define BOT_LOG_INFO TC_LOG_INFO
# define BOT_LOG_WARN TC_LOG_WARN
# define BOT_LOG_ERROR TC_LOG_ERROR
# define BOT_LOG_FATAL TC_LOG_FATAL
#else
# define Bcore Acore
# define BOT_LOG_TRACE LOG_TRACE
# define BOT_LOG_DEBUG LOG_DEBUG
# define BOT_LOG_INFO LOG_INFO
# define BOT_LOG_WARN LOG_WARN
# define BOT_LOG_ERROR LOG_ERROR
# define BOT_LOG_FATAL LOG_FATAL
#endif

#endif
