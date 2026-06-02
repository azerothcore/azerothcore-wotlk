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

#include "DiagnosticGuard.h"
#include "DiagnosticReader.h"
#include "Diagnostics.h"
#include "gtest/gtest.h"

#include <cerrno>
#include <string>
#include <system_error>

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#include <winerror.h>
#endif

namespace
{
    bool IsUnsupportedPlatformError(std::system_error const& error)
    {
        if (error.code() == std::make_error_code(std::errc::function_not_supported))
            return true;

#if AC_PLATFORM == AC_PLATFORM_UNIX && defined(__linux__)
        if (error.code().category() == std::generic_category() && error.code().value() == ENOSYS)
            return true;
#endif

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
        if (error.code().category() == std::system_category() && error.code().value() == ERROR_PROC_NOT_FOUND)
            return true;
#endif

        return false;
    }

    void SkipIfUnsupported(std::system_error const& error)
    {
        if (IsUnsupportedPlatformError(error))
            GTEST_SKIP() << error.what();

        throw error;
    }

}

TEST(DiagnosticsTest, WritersForSameNameUseSameBuffer)
{
    try
    {
        std::string name = "diagnostics_test_same_writer";

        DiagnosticWriter firstWriter = sDiagnostics->GetWriter(name);
        DiagnosticWriter secondWriter = sDiagnostics->GetWriter(std::string_view(name));

        {
            DiagnosticGuard guard(firstWriter, "First");
            guard.Arg("value", 1);
        }

        {
            DiagnosticGuard guard(secondWriter, "Second");
            guard.Arg("value", 2);
        }

        DiagnosticReadResult result = sDiagnostics->GetReader(name).ReadEvents();
        std::vector<DiagnosticEvent> const& events = result.events;

        ASSERT_GE(events.size(), 2u);
        EXPECT_EQ(events[events.size() - 2].name, "First");
        EXPECT_EQ(events[events.size() - 1].name, "Second");
    }
    catch (std::system_error const& error)
    {
        SkipIfUnsupported(error);
    }
}

TEST(DiagnosticsTest, KeepsNamesIsolated)
{
    try
    {
        std::string firstName = "diagnostics_test_isolated_first";
        std::string secondName = "diagnostics_test_isolated_second";

        {
            DiagnosticGuard guard(sDiagnostics->GetWriter(firstName), "FirstOnly");
            guard.Arg("value", 1);
        }

        {
            DiagnosticGuard guard(sDiagnostics->GetWriter(secondName), "SecondOnly");
            guard.Arg("value", 2);
        }

        DiagnosticReadResult firstResult = sDiagnostics->GetReader(firstName).ReadEvents();
        DiagnosticReadResult secondResult = sDiagnostics->GetReader(secondName).ReadEvents();
        std::vector<DiagnosticEvent> const& firstEvents = firstResult.events;
        std::vector<DiagnosticEvent> const& secondEvents = secondResult.events;

        ASSERT_FALSE(firstEvents.empty());
        ASSERT_FALSE(secondEvents.empty());
        EXPECT_EQ(firstEvents.back().name, "FirstOnly");
        EXPECT_EQ(secondEvents.back().name, "SecondOnly");
    }
    catch (std::system_error const& error)
    {
        SkipIfUnsupported(error);
    }
}

TEST(DiagnosticsTest, ClonedReaderIsIndependent)
{
    try
    {
        std::string name = "diagnostics_test_snapshot";

        {
            DiagnosticGuard guard(sDiagnostics->GetWriter(name), "Before");
            guard.Arg("value", 1);
        }

        DiagnosticReadResult result = sDiagnostics->GetReader(name).ReadEvents();

        {
            DiagnosticGuard guard(sDiagnostics->GetWriter(name), "After");
            guard.Arg("value", 2);
        }

        std::vector<DiagnosticEvent> const& events = result.events;

        ASSERT_FALSE(events.empty());
        EXPECT_EQ(events.back().name, "Before");
    }
    catch (std::system_error const& error)
    {
        SkipIfUnsupported(error);
    }
}

TEST(DiagnosticsTest, RecoversMultipleEventsInForwardOrder)
{
    try
    {
        std::string name = "diagnostics_test_forward_order";

        {
            DiagnosticGuard guard(sDiagnostics->GetWriter(name), "First");
            guard.Arg("value", 1);
        }

        {
            DiagnosticGuard guard(sDiagnostics->GetWriter(name), "Second");
            guard.Arg("value", 2);
        }

        DiagnosticReadResult result = sDiagnostics->GetReader(name).ReadEvents();
        std::vector<DiagnosticEvent> const& events = result.events;

        ASSERT_GE(events.size(), 2u);
        EXPECT_EQ(events[events.size() - 2].name, "First");
        EXPECT_EQ(events[events.size() - 1].name, "Second");
    }
    catch (std::system_error const& error)
    {
        SkipIfUnsupported(error);
    }
}
