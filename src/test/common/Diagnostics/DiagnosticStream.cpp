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

#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <limits>
#include <memory>
#include <random>
#include <span>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
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
        std::vector<DiagnosticArg> entries;
        VisitDiagnosticRecords(snapshot, [&entries](DiagnosticArg const& entry) { entries.push_back(entry); });
        return entries;
    }

    std::vector<DiagnosticRecord> Snapshot(DiagnosticBuffer const& buffer)
    {
        return buffer.Snapshot();
    }

    // Returns whether a recovered value equals the originally stored value,
    // mapping the stored string types onto the recovered string view.
    bool ValueMatches(DiagnosticValue const& recovered, DiagnosticStoredValue const& stored)
    {
        return std::visit([&recovered](auto const& value) -> bool
        {
            using T = std::decay_t<decltype(value)>;

            if constexpr (std::is_same_v<T, StringLiteralView> || std::is_same_v<T, DiagnosticStaticString>)
                return std::holds_alternative<std::string_view>(recovered)
                    && std::get<std::string_view>(recovered) == DiagnosticStringView(value);
            else
                return std::holds_alternative<T>(recovered) && std::get<T>(recovered) == value;
        }, stored);
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

TEST_F(DiagnosticStreamTest, OverrunKeepsMostRecentRecordsInOrder)
{
    constexpr std::size_t Capacity = 4;
    constexpr std::uint64_t PushCount = 10;

    DiagnosticBuffer buffer(Capacity);

    for (std::uint64_t i = 0; i < PushCount; ++i)
        buffer.Push(DiagnosticRecord("v", DiagnosticStoredValue(static_cast<uint64>(i))));

    std::vector<DiagnosticRecord> snapshot = Snapshot(buffer);
    std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

    // The buffer wrapped, so only the most recent Capacity records survive,
    // and they must still read back in forward order.
    ASSERT_EQ(entries.size(), Capacity);
    for (std::size_t k = 0; k < entries.size(); ++k)
    {
        EXPECT_EQ(entries[k].name, "v");
        EXPECT_EQ(std::get<uint64>(entries[k].value), PushCount - Capacity + k);
    }
}

// Randomised round-trip: across many wrapping buffers of random capacity and
// random record streams, the recovered entries must always equal the most
// recent min(pushed, capacity) records in forward order.  Uses <random> rather
// than the project RNG so the run is reproducible from a printed seed; export
// DIAGNOSTIC_FUZZ_SEED=<value> to replay a specific failure.
TEST(DiagnosticFuzzTest, OverrunRoundTripsMostRecentRecords)
{
    char const* const seedEnv = std::getenv("DIAGNOSTIC_FUZZ_SEED");
    unsigned const seed = seedEnv ? static_cast<unsigned>(std::strtoul(seedEnv, nullptr, 10)) : std::random_device{}();
    std::printf("[ RUN      ] DiagnosticFuzzTest.OverrunRoundTripsMostRecentRecords seed = %u\n", seed);
    std::fflush(stdout);

    std::mt19937 rng(seed);

    auto pickName = [](int index) -> StringLiteralView
    {
        switch (index)
        {
            case 0: return "alpha";
            case 1: return "beta";
            default: return "gamma";
        }
    };

    auto pickLiteral = [](int index) -> StringLiteralView
    {
        switch (index)
        {
            case 0: return "lit-a";
            case 1: return "lit-bb";
            default: return "lit-ccc";
        }
    };

    constexpr int Iterations = 512;

    for (int iteration = 0; iteration < Iterations; ++iteration)
    {
        SCOPED_TRACE("seed=" + std::to_string(seed) + " iteration=" + std::to_string(iteration));

        std::size_t const capacity = std::uniform_int_distribution<std::size_t>(1, 16)(rng);
        std::size_t const pushCount = std::uniform_int_distribution<std::size_t>(0, 80)(rng);

        DiagnosticBuffer buffer(capacity);
        std::vector<std::pair<StringLiteralView, DiagnosticStoredValue>> pushed;
        pushed.reserve(pushCount);

        for (std::size_t i = 0; i < pushCount; ++i)
        {
            StringLiteralView const name = pickName(std::uniform_int_distribution<int>(0, 2)(rng));

            DiagnosticStoredValue value(false);
            switch (std::uniform_int_distribution<int>(0, 5)(rng))
            {
                case 0:
                    value = DiagnosticStoredValue(std::uniform_int_distribution<int>(0, 1)(rng) != 0);
                    break;
                case 1:
                    value = DiagnosticStoredValue(static_cast<int64>(
                        std::uniform_int_distribution<std::int64_t>(std::numeric_limits<std::int64_t>::min(), std::numeric_limits<std::int64_t>::max())(rng)));
                    break;
                case 2:
                    value = DiagnosticStoredValue(static_cast<uint64>(
                        std::uniform_int_distribution<std::uint64_t>(0, std::numeric_limits<std::uint64_t>::max())(rng)));
                    break;
                case 3:
                    // Finite doubles only, so the stored bits round-trip exactly.
                    value = DiagnosticStoredValue(std::uniform_real_distribution<double>(-1.0e9, 1.0e9)(rng));
                    break;
                case 4:
                    value = DiagnosticStoredValue(pickLiteral(std::uniform_int_distribution<int>(0, 2)(rng)));
                    break;
                default:
                {
                    std::size_t const length = std::uniform_int_distribution<std::size_t>(0, DiagnosticStaticStringCapacity)(rng);
                    DiagnosticStaticString stored;
                    for (std::size_t c = 0; c < length; ++c)
                        stored.push_back(static_cast<char>('a' + std::uniform_int_distribution<int>(0, 25)(rng)));

                    value = DiagnosticStoredValue(stored);
                    break;
                }
            }

            buffer.Push(DiagnosticRecord(name, value));
            pushed.emplace_back(name, value);
        }

        std::vector<DiagnosticRecord> snapshot = Snapshot(buffer);
        std::vector<DiagnosticArg> entries = RecoverFrom(snapshot);

        std::size_t const expectedCount = std::min(pushCount, capacity);
        ASSERT_EQ(entries.size(), expectedCount);

        std::size_t const offset = pushCount - expectedCount;
        for (std::size_t k = 0; k < expectedCount; ++k)
        {
            auto const& [name, value] = pushed[offset + k];
            EXPECT_EQ(entries[k].name, static_cast<std::string_view>(name));
            EXPECT_TRUE(ValueMatches(entries[k].value, value));
        }
    }
}
