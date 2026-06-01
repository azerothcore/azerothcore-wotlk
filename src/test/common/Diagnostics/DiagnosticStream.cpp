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
#include "DiagnosticGuard.h"
#include "DiagnosticReader.h"
#include "DiagnosticWriter.h"
#include "RingBuffer.h"
#include "gtest/gtest.h"

#include <cerrno>
#include <chrono>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <limits>
#include <memory>
#include <span>
#include <string>
#include <string_view>
#include <system_error>
#include <variant>

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

    class DiagnosticStreamTest : public testing::Test
    {
    protected:
        void SetUp() override
        {
            try
            {
                _buffer = std::make_unique<RingBuffer>(4096);
                _writer = std::make_unique<DiagnosticWriter>(*_buffer);
            }
            catch (std::system_error const& error)
            {
                if (IsUnsupportedPlatformError(error))
                    GTEST_SKIP() << error.what();

                throw;
            }
        }

        DiagnosticWriter& Writer() { return *_writer; }
        RingBuffer& Buffer() { return *_buffer; }

    private:
        std::unique_ptr<RingBuffer> _buffer;
        std::unique_ptr<DiagnosticWriter> _writer;
    };

    bool PointsInto(std::string_view value, std::span<uint8 const> bytes)
    {
        char const* const begin = reinterpret_cast<char const*>(bytes.data());
        char const* const end = begin + bytes.size();

        return value.data() >= begin && value.data() + value.size() <= end;
    }

    std::vector<DiagnosticEvent> RecoverFrom(RingBuffer& snapshot)
    {
        return RecoverRecords(snapshot.ReadSpan());
    }

    RingBuffer Snapshot(RingBuffer const& buffer)
    {
        std::span<uint8 const> source = buffer.ReadSpan();
        RingBuffer snapshot(source.size());

        std::memcpy(snapshot.WriteSpan().data(), source.data(), source.size());

        return snapshot;
    }
}

TEST_F(DiagnosticStreamTest, EmptySnapshotRecoversNoEvents)
{
    RingBuffer snapshot = Snapshot(Buffer());

    EXPECT_TRUE(RecoverFrom(snapshot).empty());
}

TEST_F(DiagnosticStreamTest, RecoversNestedSections)
{
    {
        DiagnosticGuard foo(Writer(), "Foo");
        foo.Arg("arg1", 11);

        {
            DiagnosticGuard bar(Writer(), "Bar");
            bar.Arg("arg2", "child");
        }

        foo.Arg("arg3", true);
    }

    RingBuffer snapshot = Snapshot(Buffer());
    std::span<uint8 const> snapshotBytes = snapshot.ReadSpan();
    std::vector<DiagnosticEvent> events = RecoverFrom(snapshot);

    ASSERT_EQ(events.size(), 1u);
    EXPECT_EQ(events[0].name, "Foo");
    EXPECT_TRUE(PointsInto(events[0].name, snapshotBytes));

    ASSERT_EQ(events[0].args.size(), 2u);
    EXPECT_EQ(events[0].args[0].name, "arg1");
    EXPECT_EQ(std::get<int64>(events[0].args[0].value), 11);
    EXPECT_EQ(events[0].args[1].name, "arg3");
    EXPECT_EQ(std::get<bool>(events[0].args[1].value), true);

    ASSERT_EQ(events[0].children.size(), 1u);
    EXPECT_EQ(events[0].children[0].name, "Bar");
    EXPECT_TRUE(PointsInto(events[0].children[0].name, snapshotBytes));

    ASSERT_EQ(events[0].children[0].args.size(), 1u);
    EXPECT_EQ(events[0].children[0].args[0].name, "arg2");
    std::string_view childValue = std::get<std::string_view>(events[0].children[0].args[0].value);
    EXPECT_EQ(childValue, "child");
    EXPECT_TRUE(PointsInto(childValue, snapshotBytes));
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
    }

    RingBuffer snapshot = Snapshot(Buffer());
    std::span<uint8 const> snapshotBytes = snapshot.ReadSpan();
    std::vector<DiagnosticEvent> events = RecoverFrom(snapshot);

    ASSERT_EQ(events.size(), 1u);
    ASSERT_EQ(events[0].args.size(), 5u);

    EXPECT_EQ(events[0].args[0].name, "false");
    EXPECT_EQ(std::get<bool>(events[0].args[0].value), false);

    EXPECT_EQ(events[0].args[1].name, "signed");
    EXPECT_EQ(std::get<int64>(events[0].args[1].value), -17);

    EXPECT_EQ(events[0].args[2].name, "unsigned");
    EXPECT_EQ(std::get<uint64>(events[0].args[2].value), std::numeric_limits<uint64>::max());

    EXPECT_EQ(events[0].args[3].name, "double");
    EXPECT_EQ(std::get<double>(events[0].args[3].value), 1.25);

    EXPECT_EQ(events[0].args[4].name, "view");
    std::string_view value = std::get<std::string_view>(events[0].args[4].value);
    EXPECT_EQ(value, "view-value");
    EXPECT_TRUE(PointsInto(value, snapshotBytes));
}

TEST_F(DiagnosticStreamTest, ReturnsTopLevelSectionsInForwardOrder)
{
    {
        DiagnosticGuard first(Writer(), "First");
        first.Arg("value", 1);
    }

    {
        DiagnosticGuard second(Writer(), "Second");
        second.Arg("value", 2);
    }

    RingBuffer snapshot = Snapshot(Buffer());
    std::vector<DiagnosticEvent> events = RecoverFrom(snapshot);

    ASSERT_EQ(events.size(), 2u);
    EXPECT_EQ(events[0].name, "First");
    EXPECT_EQ(std::get<int64>(events[0].args[0].value), 1);
    EXPECT_EQ(events[1].name, "Second");
    EXPECT_EQ(std::get<int64>(events[1].args[0].value), 2);
}

TEST_F(DiagnosticStreamTest, SnapshotIsIndependent)
{
    {
        DiagnosticGuard first(Writer(), "First");
        first.Arg("value", 1);
    }

    RingBuffer snapshot = Snapshot(Buffer());

    {
        DiagnosticGuard second(Writer(), "Second");
        second.Arg("value", 2);
    }

    std::vector<DiagnosticEvent> events = RecoverFrom(snapshot);

    ASSERT_EQ(events.size(), 1u);
    EXPECT_EQ(events[0].name, "First");
    EXPECT_EQ(std::get<int64>(events[0].args[0].value), 1);
}

TEST_F(DiagnosticStreamTest, OversizedArgumentIsDropped)
{
    std::string largeValue(1024 * 1024, 'x');

    {
        DiagnosticGuard parent(Writer(), "Parent");
        parent.Arg("before", 1);

        {
            DiagnosticGuard child(Writer(), "Child");
            child.Arg("too_large", std::string_view(largeValue));
        }

        parent.Arg("after", 2);

        {
            DiagnosticGuard sibling(Writer(), "Sibling");
            sibling.Arg("value", 3);
        }
    }

    RingBuffer snapshot = Snapshot(Buffer());
    std::vector<DiagnosticEvent> events = RecoverFrom(snapshot);

    ASSERT_EQ(events.size(), 1u);
    EXPECT_EQ(events[0].name, "Parent");

    ASSERT_EQ(events[0].args.size(), 2u);
    EXPECT_EQ(events[0].args[0].name, "before");
    EXPECT_EQ(std::get<int64>(events[0].args[0].value), 1);
    EXPECT_EQ(events[0].args[1].name, "after");
    EXPECT_EQ(std::get<int64>(events[0].args[1].value), 2);

    ASSERT_EQ(events[0].children.size(), 2u);
    EXPECT_EQ(events[0].children[0].name, "Child");
    EXPECT_TRUE(events[0].children[0].args.empty());
    EXPECT_EQ(events[0].children[1].name, "Sibling");
    ASSERT_EQ(events[0].children[1].args.size(), 1u);
    EXPECT_EQ(std::get<int64>(events[0].children[1].args[0].value), 3);
}

TEST_F(DiagnosticStreamTest, WritesTextDump)
{
    {
        DiagnosticGuard guard(Writer(), "Dump");
        guard.Arg("answer", 42);
        guard.Arg("text", "hello\nthere");
    }

    RingBuffer snapshot = Snapshot(Buffer());
    DiagnosticReader reader(std::move(snapshot));

    std::filesystem::path path = std::filesystem::temp_directory_path() /
        ("acore-diagnostic-dump-" + std::to_string(std::chrono::steady_clock::now().time_since_epoch().count()) + ".txt");

    std::error_code error;
    std::filesystem::remove(path, error);

    EXPECT_EQ(WriteDiagnosticDump("test_stream", path, reader), 1u);

    std::ifstream input(path, std::ios::binary);
    ASSERT_TRUE(input);

    std::string dump((std::istreambuf_iterator<char>(input)), std::istreambuf_iterator<char>());

    EXPECT_NE(dump.find("diagnostics \"test_stream\""), std::string::npos);
    EXPECT_NE(dump.find("events 1"), std::string::npos);
    EXPECT_NE(dump.find("event \"Dump\""), std::string::npos);
    EXPECT_NE(dump.find("arg \"answer\" = 42"), std::string::npos);
    EXPECT_NE(dump.find("arg \"text\" = \"hello\\nthere\""), std::string::npos);

    std::filesystem::remove(path, error);
}
