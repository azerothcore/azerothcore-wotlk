/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ACORE_ERRORS_H_
#define _ACORE_ERRORS_H_

#include "Define.h"
#include <string>

namespace Acore
{
    [[noreturn]] void Assert(char const* file, int line, char const* function, std::string const& debugInfo, char const* message);
    [[noreturn]] void Assert(char const* file, int line, char const* function, std::string const& debugInfo, char const* message, char const* format, ...) ATTR_PRINTF(6, 7);

    [[noreturn]] void Fatal(char const* file, int line, char const* function, char const* message, ...) ATTR_PRINTF(4, 5);

    [[noreturn]] void Error(char const* file, int line, char const* function, char const* message);

    [[noreturn]] void Abort(char const* file, int line, char const* function);

    [[noreturn]] void Abort(char const* file, int line, char const* function, char const* message, ...);

    void Warning(char const* file, int line, char const* function, char const* message);

    [[noreturn]] void AbortHandler(int sigval);

} // namespace Acore

std::string GetDebugInfo();

#if AC_COMPILER == AC_COMPILER_MICROSOFT
#define ASSERT_BEGIN __pragma(warning(push)) __pragma(warning(disable: 4127))
#define ASSERT_END __pragma(warning(pop))
#else
#define ASSERT_BEGIN
#define ASSERT_END
#endif

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#define EXCEPTION_ASSERTION_FAILURE 0xC0000420L
#endif

#define WPAssert(cond, ...) ASSERT_BEGIN do { if (!(cond)) Acore::Assert(__FILE__, __LINE__, __FUNCTION__, GetDebugInfo(), #cond, ##__VA_ARGS__); } while(0) ASSERT_END
#define WPAssert_NODEBUGINFO(cond, ...) ASSERT_BEGIN do { if (!(cond)) Acore::Assert(__FILE__, __LINE__, __FUNCTION__, "", #cond, ##__VA_ARGS__); } while(0) ASSERT_END
#define WPFatal(cond, ...) ASSERT_BEGIN do { if (!(cond)) Acore::Fatal(__FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__); } while(0) ASSERT_END
#define WPError(cond, msg) ASSERT_BEGIN do { if (!(cond)) Acore::Error(__FILE__, __LINE__, __FUNCTION__, (msg)); } while(0) ASSERT_END
#define WPWarning(cond, msg) ASSERT_BEGIN do { if (!(cond)) Acore::Warning(__FILE__, __LINE__, __FUNCTION__, (msg)); } while(0) ASSERT_END
#define WPAbort() ASSERT_BEGIN do { Acore::Abort(__FILE__, __LINE__, __FUNCTION__); } while(0) ASSERT_END
#define WPAbort_MSG(msg, ...) ASSERT_BEGIN do { Acore::Abort(__FILE__, __LINE__, __FUNCTION__, (msg), ##__VA_ARGS__); } while(0) ASSERT_END

#ifdef PERFORMANCE_PROFILING
#define ASSERT(cond, ...) ((void)0)
#define ASSERT_NODEBUGINFO(cond, ...) ((void)0)
#else
#define ASSERT WPAssert
#define ASSERT_NODEBUGINFO WPAssert_NODEBUGINFO
#endif

#define ABORT WPAbort
#define ABORT_MSG WPAbort_MSG

template <typename T>
inline T* ASSERT_NOTNULL_IMPL(T* pointer, char const* expr)
{
    ASSERT(pointer, "%s", expr);
    return pointer;
}

#define ASSERT_NOTNULL(pointer) ASSERT_NOTNULL_IMPL(pointer, #pointer)

#endif
