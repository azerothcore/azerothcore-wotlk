/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ACORE_ERRORS_H_
#define _ACORE_ERRORS_H_

#include "Define.h"
#include <string>

namespace acore
{
    DECLSPEC_NORETURN void Assert(char const* file, int line, char const* function, std::string const& debugInfo, char const* message) ATTR_NORETURN;
    DECLSPEC_NORETURN void Assert(char const* file, int line, char const* function, std::string const& debugInfo, char const* message, char const* format, ...) ATTR_NORETURN ATTR_PRINTF(6, 7);

    DECLSPEC_NORETURN void Fatal(char const* file, int line, char const* function, char const* message, ...) ATTR_NORETURN ATTR_PRINTF(4, 5);

    DECLSPEC_NORETURN void Error(char const* file, int line, char const* function, char const* message) ATTR_NORETURN;

    DECLSPEC_NORETURN void Abort(char const* file, int line, char const* function) ATTR_NORETURN;

    void Warning(char const* file, int line, char const* function, char const* message);

    DECLSPEC_NORETURN void AbortHandler(int sigval) ATTR_NORETURN;

} // namespace acore

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

#define WPAssert(cond, ...) ASSERT_BEGIN do { if (!(cond)) acore::Assert(__FILE__, __LINE__, __FUNCTION__, GetDebugInfo(), #cond, ##__VA_ARGS__); } while(0) ASSERT_END
#define WPAssert_NODEBUGINFO(cond, ...) ASSERT_BEGIN do { if (!(cond)) acore::Assert(__FILE__, __LINE__, __FUNCTION__, "", #cond, ##__VA_ARGS__); } while(0) ASSERT_END
#define WPFatal(cond, ...) ASSERT_BEGIN do { if (!(cond)) acore::Fatal(__FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__); } while(0) ASSERT_END
#define WPError(cond, msg) ASSERT_BEGIN do { if (!(cond)) acore::Error(__FILE__, __LINE__, __FUNCTION__, (msg)); } while(0) ASSERT_END
#define WPWarning(cond, msg) ASSERT_BEGIN do { if (!(cond)) acore::Warning(__FILE__, __LINE__, __FUNCTION__, (msg)); } while(0) ASSERT_END
#define WPAbort() ASSERT_BEGIN do { acore::Abort(__FILE__, __LINE__, __FUNCTION__); } while(0) ASSERT_END

#ifdef PERFORMANCE_PROFILING
#define ASSERT(cond, ...) ((void)0)
#define ASSERT_NODEBUGINFO(cond, ...) ((void)0)
#else
#define ASSERT WPAssert
#define ASSERT_NODEBUGINFO WPAssert_NODEBUGINFO
#endif

#define ABORT WPAbort

template <typename T>
inline T* ASSERT_NOTNULL_IMPL(T* pointer, char const* expr)
{
    ASSERT(pointer, "%s", expr);
    return pointer;
}

#define ASSERT_NOTNULL(pointer) ASSERT_NOTNULL_IMPL(pointer, #pointer)

#endif
