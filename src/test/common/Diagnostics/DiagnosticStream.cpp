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

#include "DiagnosticDump.h"
#include "DiagnosticBuffer.h"
#include "DiagnosticGuard.h"
#include "DiagnosticReader.h"
#include "DiagnosticWriter.h"
#include "gtest/gtest.h"

#include <chrono>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <limits>
#include <memory>
#include <span>
#include <string>
#include <string_view>
#include <variant>

namespace
{
    class DiagnosticStreamTest : public testing::Test
    {
    protected:
        void SetUp() override
        {
            _buffer = std::make_unique<DiagnosticBuffer>(4096);
            _writer = std::make_unique<DiagnosticWriter>(*_buffer);
        }

        DiagnosticWriter& Writer() { return *_writer; }
        DiagnosticBuffer& Buffer() { return *_buffer; }

    private:
        std::unique_ptr<DiagnosticBuffer> _buffer;
        std::unique_ptr<DiagnosticWriter> _writer;
    };

    bool PointsInto(std::string_view value, std::span<DiagnosticRecord const> records)
    {
        char const* const begin = reinterpret_cast<char const*>(records.data());
        char const* const end = begin + records.size_bytes();

        return value.data() >= begin && value.data() + value.size() <= end;
    }

    std::vector<DiagnosticArg> RecoverFrom(std::vector<DiagnosticRecord> const& snapshot)
    {
        return RecoverRecords(snapshot);
    }

    std::vector<DiagnosticRecord> Snapshot(DiagnosticBuffer const& buffer)
    {
        return buffer.Snapshot();
    }
}

TEST_F(DiagnosticStreamTest, EmptySnapshotRecoversNoEntries)
{
    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());

    EXPECT_TRUE(RecoverFrom(snapshot).empty());
}

TEST_F(DiagnosticStreamTest, GuardStampsFunctionEntry)
{
    {
        DiagnosticGuard guard(Writer(), "Scope");
        guard.Arg("answer", 11);
    }

    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());
    std::span<DiagnosticRecord const> snapshotRecords = snapshot;
    std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

    ASSERT_EQ(entries.size(), 2u);

    EXPECT_EQ(entries[0].name, "function");
    std::string_view function = std::get<std::string_view>(entries[0].value);
    EXPECT_EQ(function, "Scope");
    // The name is a string literal, so it is viewed in place and never copied
    // into the snapshot records.
    EXPECT_FALSE(PointsInto(function, snapshotRecords));

    EXPECT_EQ(entries[1].name, "answer");
    EXPECT_EQ(std::get<int64>(entries[1].value), 11);
}

TEST_F(DiagnosticStreamTest, RecoversSupportedArgumentValues)
{
    {
        DiagnosticGuard guard(Writer(), "Values");
        guard.Arg("false", false);
        guard.Arg("signed", -17);
        guard.Arg("unsigned", std::numeric_limits<uint64>::max());
        guard.Arg("double", 1.25);

        std::string_view view = "view-value";
        guard.Arg("view", view);
        guard.Arg("literal", StringLiteralView("literal-value"));
    }

    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());
    std::span<DiagnosticRecord const> snapshotRecords = snapshot;
    std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

    ASSERT_EQ(entries.size(), 7u);
    EXPECT_EQ(entries[0].name, "function");
    EXPECT_EQ(std::get<std::string_view>(entries[0].value), "Values");

    EXPECT_EQ(entries[1].name, "false");
    EXPECT_FALSE(PointsInto(entries[1].name, snapshotRecords));
    EXPECT_EQ(std::get<bool>(entries[1].value), false);

    EXPECT_EQ(entries[2].name, "signed");
    EXPECT_EQ(std::get<int64>(entries[2].value), -17);

    EXPECT_EQ(entries[3].name, "unsigned");
    EXPECT_EQ(std::get<uint64>(entries[3].value), std::numeric_limits<uint64>::max());

    EXPECT_EQ(entries[4].name, "double");
    EXPECT_EQ(std::get<double>(entries[4].value), 1.25);

    EXPECT_EQ(entries[5].name, "view");
    std::string_view value = std::get<std::string_view>(entries[5].value);
    EXPECT_EQ(value, "view-value");
    EXPECT_TRUE(PointsInto(value, snapshotRecords));

    EXPECT_EQ(entries[6].name, "literal");
    std::string_view literalValue = std::get<std::string_view>(entries[6].value);
    EXPECT_EQ(literalValue, "literal-value");
    EXPECT_FALSE(PointsInto(literalValue, snapshotRecords));
}

TEST_F(DiagnosticStreamTest, ReturnsEntriesInForwardOrder)
{
    {
        DiagnosticGuard first(Writer(), "First");
        first.Arg("value", 1);
    }

    {
        DiagnosticGuard second(Writer(), "Second");
        second.Arg("value", 2);
    }

    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());
    std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

    ASSERT_EQ(entries.size(), 4u);
    EXPECT_EQ(entries[0].name, "function");
    EXPECT_EQ(std::get<std::string_view>(entries[0].value), "First");
    EXPECT_EQ(entries[1].name, "value");
    EXPECT_EQ(std::get<int64>(entries[1].value), 1);
    EXPECT_EQ(entries[2].name, "function");
    EXPECT_EQ(std::get<std::string_view>(entries[2].value), "Second");
    EXPECT_EQ(entries[3].name, "value");
    EXPECT_EQ(std::get<int64>(entries[3].value), 2);
}

TEST_F(DiagnosticStreamTest, SnapshotIsIndependent)
{
    {
        DiagnosticGuard first(Writer(), "First");
        first.Arg("value", 1);
    }

    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());

    {
        DiagnosticGuard second(Writer(), "Second");
        second.Arg("value", 2);
    }

    std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

    ASSERT_EQ(entries.size(), 2u);
    EXPECT_EQ(std::get<std::string_view>(entries[0].value), "First");
    EXPECT_EQ(entries[1].name, "value");
    EXPECT_EQ(std::get<int64>(entries[1].value), 1);
}

TEST_F(DiagnosticStreamTest, OversizedArgumentIsTruncated)
{
    std::string largeValue(1024, 'x');

    {
        DiagnosticGuard guard(Writer(), "Parent");
        guard.Arg("before", 1);
        guard.Arg("too_large", std::string_view(largeValue));
        guard.Arg("after", 2);
    }

    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());
    std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

    ASSERT_EQ(entries.size(), 4u);
    EXPECT_EQ(entries[0].name, "function");
    EXPECT_EQ(entries[1].name, "before");
    EXPECT_EQ(std::get<int64>(entries[1].value), 1);

    EXPECT_EQ(entries[2].name, "too_large");
    std::string_view truncated = std::get<std::string_view>(entries[2].value);
    EXPECT_EQ(truncated, std::string(DiagnosticStaticStringCapacity, 'x'));

    EXPECT_EQ(entries[3].name, "after");
    EXPECT_EQ(std::get<int64>(entries[3].value), 2);
}

TEST_F(DiagnosticStreamTest, WritesTextDump)
{
    {
        DiagnosticGuard guard(Writer(), "Dump");
        guard.Arg("answer", 42);
        guard.Arg("text", "hello\nthere");
    }

    std::vector<DiagnosticRecord> snapshot = Snapshot(Buffer());
    DiagnosticReader reader(std::move(snapshot));

    std::filesystem::path path = std::filesystem::temp_directory_path() /
        ("acore-diagnostic-dump-" + std::to_string(std::chrono::steady_clock::now().time_since_epoch().count()) + ".txt");

    std::error_code error;
    std::filesystem::remove(path, error);

    EXPECT_EQ(WriteDiagnosticDump("test_stream", path, reader), 3u);

    std::ifstream input(path, std::ios::binary);
    ASSERT_TRUE(input);

    std::string dump((std::istreambuf_iterator<char>(input)), std::istreambuf_iterator<char>());

    EXPECT_NE(dump.find("diagnostics \"test_stream\""), std::string::npos);
    EXPECT_NE(dump.find("entries 3"), std::string::npos);
    EXPECT_NE(dump.find("arg \"function\" = \"Dump\""), std::string::npos);
    EXPECT_NE(dump.find("arg \"answer\" = 42"), std::string::npos);
    EXPECT_NE(dump.find("arg \"text\" = \"hello\\nthere\""), std::string::npos);

    std::filesystem::remove(path, error);
}
