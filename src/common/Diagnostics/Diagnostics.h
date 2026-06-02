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

#ifndef ACORE_DIAGNOSTICS_H
#define ACORE_DIAGNOSTICS_H

#include "Define.h"
#include "DiagnosticBuffer.h"
#include "DiagnosticReader.h"
#include "DiagnosticWriter.h"

#include <cstddef>
#include <mutex>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

class AC_COMMON_API Diagnostics
{
public:
    /**
     * @brief Return the singleton diagnostics registry.
     *
     * @return The singleton diagnostics registry.
     */
    static Diagnostics* instance();

    /**
     * @brief Return the writer for the specified @p name.
     *
     * @param name The name of the diagnostic buffer.
     * @return The writer for the specified @p name.
     *
     * The behavior is undefined unless @p name is non-empty.
     */
    [[nodiscard]] DiagnosticWriter GetWriter(std::string_view name);

    /**
     * @brief Return a reader owning a cloned snapshot of the buffer having the
     *        specified @p name.
     *
     * @param name The name of the diagnostic buffer.
     * @return A reader owning a cloned snapshot of the specified buffer.
     *
     * The behavior is undefined unless @p name is non-empty.  This function is
     * not thread-safe with respect to the named buffer: the behavior is
     * undefined if any writer for the same buffer is used concurrently, since
     * snapshotting reads the buffer without synchronizing against writes.
     */
    [[nodiscard]] DiagnosticReader GetReader(std::string_view name);

private:
    Diagnostics() = default;
    ~Diagnostics() = default;

    Diagnostics(Diagnostics const&) = delete;
    Diagnostics& operator=(Diagnostics const&) = delete;

    struct TransparentStringHash
    {
        using is_transparent = void;

        std::size_t operator()(std::string_view value) const noexcept;
    };

    DiagnosticBuffer& GetOrCreate(std::string_view name);
    static std::vector<DiagnosticRecord> Clone(DiagnosticBuffer const& buffer);

    static constexpr std::size_t DefaultBufferBytes = 1024 * 1024;
    static constexpr std::size_t DefaultBufferRecords = DefaultBufferBytes / sizeof(DiagnosticRecord);
    static_assert(DefaultBufferRecords > 0);

    // Protects _buffers invariants and entry lifetime only.  Individual
    // diagnostic buffers are single-threaded: a given buffer's writer handles
    // and any reader snapshot of it must all run on the same thread.
    std::mutex _buffersLock;
    std::unordered_map<std::string, DiagnosticBuffer, TransparentStringHash, std::equal_to<>> _buffers;
};

#define sDiagnostics Diagnostics::instance()

#endif // ACORE_DIAGNOSTICS_H
