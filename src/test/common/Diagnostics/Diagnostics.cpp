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
#include "Diagnostics.h"
#include "gtest/gtest.h"

#include <string>
#include <string_view>
#include <variant>
#include <vector>

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

    std::vector<DiagnosticRecord> records = sDiagnostics->Snapshot(name);

    ASSERT_EQ(records.size(), 4u);
    EXPECT_EQ(static_cast<std::string_view>(records[1].name), "value");
    EXPECT_EQ(std::get<int64>(records[1].value), 1);
    EXPECT_EQ(static_cast<std::string_view>(records[3].name), "value");
    EXPECT_EQ(std::get<int64>(records[3].value), 2);
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

    std::vector<DiagnosticRecord> firstRecords = sDiagnostics->Snapshot(firstName);
    std::vector<DiagnosticRecord> secondRecords = sDiagnostics->Snapshot(secondName);

    ASSERT_FALSE(firstRecords.empty());
    ASSERT_FALSE(secondRecords.empty());
    EXPECT_EQ(static_cast<std::string_view>(firstRecords.back().name), "value");
    EXPECT_EQ(std::get<int64>(firstRecords.back().value), 1);
    EXPECT_EQ(static_cast<std::string_view>(secondRecords.back().name), "value");
    EXPECT_EQ(std::get<int64>(secondRecords.back().value), 2);
}

TEST(DiagnosticsTest, ClonedSnapshotIsIndependent)
{
    std::string name = "diagnostics_test_snapshot";

    {
        DiagnosticGuard guard(sDiagnostics->GetWriter(name), "Before");
        guard.Arg("value", 1);
    }

    std::vector<DiagnosticRecord> records = sDiagnostics->Snapshot(name);

    {
        DiagnosticGuard guard(sDiagnostics->GetWriter(name), "After");
        guard.Arg("value", 2);
    }

    ASSERT_FALSE(records.empty());
    EXPECT_EQ(static_cast<std::string_view>(records.back().name), "value");
    EXPECT_EQ(std::get<int64>(records.back().value), 1);
}
