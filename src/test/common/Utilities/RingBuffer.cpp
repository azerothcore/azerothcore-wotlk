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

#include "RingBuffer.h"
#include "gtest/gtest.h"

#include <array>
#include <cerrno>
#include <cstring>
#include <memory>
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

    class RingBufferTest : public testing::Test
    {
    protected:
        void SetUp() override
        {
            try
            {
                _buffer = std::make_unique<RingBuffer>(1);
            }
            catch (std::system_error const& error)
            {
                if (IsUnsupportedPlatformError(error))
                    GTEST_SKIP() << error.what();

                throw;
            }
        }

        RingBuffer& Buffer() { return *_buffer; }

    private:
        std::unique_ptr<RingBuffer> _buffer;
    };
}

TEST_F(RingBufferTest, WriteSpanReflectsThroughMirror)
{
    std::span<uint8> span = Buffer().WriteSpan();
    ASSERT_FALSE(span.empty());

    uint8* data = span.data();
    data[0] = 0x11;
    data[span.size()] = 0x22;

    EXPECT_EQ(data[0], 0x22);
}

TEST_F(RingBufferTest, AdvanceWrapsPosition)
{
    std::span<uint8> span = Buffer().WriteSpan();
    ASSERT_FALSE(span.empty());

    uint8* const base = span.data();
    std::size_t const size = span.size();

    Buffer().Advance(size - 1);
    EXPECT_EQ(Buffer().WriteSpan().data(), base + size - 1);

    Buffer().Advance(1);
    EXPECT_EQ(Buffer().WriteSpan().data(), base);
}

TEST_F(RingBufferTest, CanWriteContiguouslyAcrossEnd)
{
    std::span<uint8> span = Buffer().WriteSpan();
    ASSERT_GE(span.size(), 4u);

    uint8* const base = span.data();
    std::size_t const size = span.size();
    std::array<uint8, 8> const bytes = { 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80 };

    Buffer().Advance(size - 4);
    std::memcpy(Buffer().WriteSpan().data(), bytes.data(), bytes.size());

    EXPECT_EQ(std::memcmp(base + size - 4, bytes.data(), 4), 0);
    EXPECT_EQ(std::memcmp(base, bytes.data() + 4, 4), 0);
}
