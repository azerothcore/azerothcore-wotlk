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

#include <fmt/format.h>

#include <fstream>
#include <iterator>
#include <stdexcept>
#include <string>
#include <type_traits>
#include <variant>

namespace
{
    // Returns @p value as a double-quoted, escaped string literal.
    std::string EscapeText(std::string_view value)
    {
        std::string result;
        result.reserve(value.size() + 2);
        result += '"';

        for (unsigned char ch : value)
        {
            switch (ch)
            {
                case '\\': result += "\\\\"; break;
                case '"':  result += "\\\""; break;
                case '\n': result += "\\n"; break;
                case '\r': result += "\\r"; break;
                case '\t': result += "\\t"; break;
                default:
                    if (ch < 0x20 || ch == 0x7F)
                        fmt::format_to(std::back_inserter(result), "\\x{:02x}", ch);
                    else
                        result += static_cast<char>(ch);
                    break;
            }
        }

        result += '"';
        return result;
    }

    std::string FormatValue(DiagnosticStoredValue const& value)
    {
        return std::visit([](auto const& v) -> std::string
        {
            using T = std::decay_t<decltype(v)>;

            if constexpr (std::is_same_v<T, bool>)
                return v ? "true" : "false";
            else if constexpr (std::is_same_v<T, StringLiteralView>)
                return EscapeText(v);
            else if constexpr (std::is_same_v<T, DiagnosticStaticString>)
                return EscapeText({ v.data(), v.size() });
            else
                return fmt::format("{}", v);
        }, value);
    }
}

std::size_t WriteDiagnosticDump(std::string_view name, std::filesystem::path const& path, std::span<DiagnosticRecord const> records)
{
    std::size_t const entryCount = records.size();

    if (!path.parent_path().empty())
        std::filesystem::create_directories(path.parent_path());

    std::ofstream output(path, std::ios::binary | std::ios::trunc);
    if (!output)
        throw std::runtime_error("failed to open diagnostics dump file");

    auto out = std::ostreambuf_iterator<char>(output);
    fmt::format_to(out, "diagnostics {}\nentries {}\n\n", EscapeText(name), entryCount);

    for (DiagnosticRecord const& record : records)
        fmt::format_to(out, "arg {} = {}\n", EscapeText(record.name), FormatValue(record.value));

    if (!output)
        throw std::runtime_error("failed to write diagnostics dump file");

    return entryCount;
}
