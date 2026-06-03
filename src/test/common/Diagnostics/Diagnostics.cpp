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

#include <string>
#include <string_view>
#include <variant>
#include <vector>

namespace
{
    std::vector<DiagnosticArg> Collect(DiagnosticReader const& reader)
    {
        std::vector<DiagnosticArg> entries;
        reader.Visit([&entries](DiagnosticArg const& entry) { entries.push_back(entry); });
        return entries;
    }
}

TEST(DiagnosticsTest, WritersForSameNameUseSameBuffer)
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

    DiagnosticReader reader = sDiagnostics->GetReader(name);
    std::vector<DiagnosticArg> entries = Collect(reader);

    ASSERT_EQ(entries.size(), 4u);
    EXPECT_EQ(entries[1].name, "value");
    EXPECT_EQ(std::get<int64>(entries[1].value), 1);
    EXPECT_EQ(entries[3].name, "value");
    EXPECT_EQ(std::get<int64>(entries[3].value), 2);
}

TEST(DiagnosticsTest, KeepsNamesIsolated)
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

    DiagnosticReader firstReader = sDiagnostics->GetReader(firstName);
    DiagnosticReader secondReader = sDiagnostics->GetReader(secondName);
    std::vector<DiagnosticArg> firstEntries = Collect(firstReader);
    std::vector<DiagnosticArg> secondEntries = Collect(secondReader);

    ASSERT_FALSE(firstEntries.empty());
    ASSERT_FALSE(secondEntries.empty());
    EXPECT_EQ(firstEntries.back().name, "value");
    EXPECT_EQ(std::get<int64>(firstEntries.back().value), 1);
    EXPECT_EQ(secondEntries.back().name, "value");
    EXPECT_EQ(std::get<int64>(secondEntries.back().value), 2);
}

TEST(DiagnosticsTest, ClonedReaderIsIndependent)
{
    std::string name = "diagnostics_test_snapshot";

    {
        DiagnosticGuard guard(sDiagnostics->GetWriter(name), "Before");
        guard.Arg("value", 1);
    }

    DiagnosticReader reader = sDiagnostics->GetReader(name);

    {
        DiagnosticGuard guard(sDiagnostics->GetWriter(name), "After");
        guard.Arg("value", 2);
    }

    std::vector<DiagnosticArg> entries = Collect(reader);

    ASSERT_FALSE(entries.empty());
    EXPECT_EQ(entries.back().name, "value");
    EXPECT_EQ(std::get<int64>(entries.back().value), 1);
}
