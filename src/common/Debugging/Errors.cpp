/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Errors.h"
#include "Duration.h"
#include <cstdio>
#include <cstdlib>
#include <thread>

/**
    @file Errors.cpp

    @brief This file contains definitions of functions used for reporting critical application errors

    It is very important that (std::)abort is NEVER called in place of *((volatile int*)nullptr) = 0;
    Calling abort() on Windows does not invoke unhandled exception filters - a mechanism used by WheatyExceptionReport
    to log crashes. exit(1) calls here are for static analysis tools to indicate that calling functions defined in this file
    terminates the application.
 */

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#include <Windows.h>
#define Crash(message) \
    ULONG_PTR execeptionArgs[] = { reinterpret_cast<ULONG_PTR>(strdup(message)), reinterpret_cast<ULONG_PTR>(_ReturnAddress()) }; \
    RaiseException(EXCEPTION_ASSERTION_FAILURE, 0, 2, execeptionArgs);
#else
// should be easily accessible in gdb
extern "C" { char const* AcoreAssertionFailedMessage = nullptr; }
#define Crash(message) \
    AcoreAssertionFailedMessage = strdup(message); \
    *((volatile int*)nullptr) = 0; \
    exit(1);
#endif

namespace
{
    /**
    * @name MakeMessage
    * @brief Make message for display erros
    * @param messageType Message type (ASSERTION FAILED, FATAL ERROR, ERROR) end etc
    * @param file Path to file
    * @param line Line number in file
    * @param function Functionn name
    * @param message Condition to string format
    * @param fmtMessage [optional] Display format message after condition
    * @param debugInfo [optional] Display debug info
    */
    inline std::string MakeMessage(std::string_view messageType, std::string_view file, uint32 line, std::string_view function,
        std::string_view message, std::string_view fmtMessage = {}, std::string_view debugInfo = {})
    {
        std::string msg = Acore::StringFormat("\n>> {}\n\n# Location: {}:{}\n# Function: {}\n# Condition: {}\n", messageType, file, line, function, message);

        if (!fmtMessage.empty())
        {
            msg.append(Acore::StringFormat("# Message: {}\n", fmtMessage));
        }

        if (!debugInfo.empty())
        {
            msg.append(Acore::StringFormat("\n# Debug info: {}\n", debugInfo));
        }

        return Acore::StringFormat(
            "#{0:-^{2}}#\n"
            " {1: ^{2}} \n"
            "#{0:-^{2}}#\n", "", msg, 70);
    }

    /**
    * @name MakeAbortMessage
    * @brief Make message for display erros
    * @param file Path to file
    * @param line Line number in file
    * @param function Functionn name
    * @param fmtMessage [optional] Display format message after condition
    */
    inline std::string MakeAbortMessage(std::string_view file, uint32 line, std::string_view function, std::string_view fmtMessage = {})
    {
        std::string msg = Acore::StringFormat("\n>> ABORTED\n\n# Location '{}:{}'\n# Function '{}'\n", file, line, function);

        if (!fmtMessage.empty())
        {
            msg.append(Acore::StringFormat("# Message '{}'\n", fmtMessage));
        }

        return Acore::StringFormat(
            "\n#{0:-^{2}}#\n"
            " {1: ^{2}} \n"
            "#{0:-^{2}}#\n", "", msg, 70);
    }
}

void Acore::Assert(std::string_view file, uint32 line, std::string_view function, std::string_view debugInfo, std::string_view message, std::string_view fmtMessage /*= {}*/)
{
    std::string formattedMessage = MakeMessage("ASSERTION FAILED", file, line, function, message, fmtMessage, debugInfo);
    fmt::print(stderr, "{}", formattedMessage);
    fflush(stderr);
    Crash(formattedMessage.c_str());
}

void Acore::Fatal(std::string_view file, uint32 line, std::string_view function, std::string_view message, std::string_view fmtMessage /*= {}*/)
{
    std::string formattedMessage = MakeMessage("FATAL ERROR", file, line, function, message, fmtMessage);
    fmt::print(stderr, "{}", formattedMessage);
    fflush(stderr);
    std::this_thread::sleep_for(10s);
    Crash(formattedMessage.c_str());
}

void Acore::Error(std::string_view file, uint32 line, std::string_view function, std::string_view message)
{
    std::string formattedMessage = MakeMessage("ERROR", file, line, function, message);
    fmt::print(stderr, "{}", formattedMessage);
    fflush(stderr);
    std::this_thread::sleep_for(10s);
    Crash(formattedMessage.c_str());
}

void Acore::Warning(std::string_view file, uint32 line, std::string_view function, std::string_view message)
{
    std::string formattedMessage = MakeMessage("WARNING", file, line, function, message);
    fmt::print(stderr, "{}", formattedMessage);
}

void Acore::Abort(std::string_view file, uint32 line, std::string_view function, std::string_view fmtMessage /*= {}*/)
{
    std::string formattedMessage = MakeAbortMessage(file, line, function, fmtMessage);
    fmt::print(stderr, "{}", formattedMessage);
    fflush(stderr);
    std::this_thread::sleep_for(10s);
    Crash(formattedMessage.c_str());
}

void Acore::AbortHandler(int sigval)
{
    // nothing useful to log here, no way to pass args
    std::string formattedMessage = StringFormat("Caught signal {}\n", sigval);
    fmt::print(stderr, "{}", formattedMessage);
    fflush(stderr);
    Crash(formattedMessage.c_str());
}

std::string GetDebugInfo()
{
    return "";
}
