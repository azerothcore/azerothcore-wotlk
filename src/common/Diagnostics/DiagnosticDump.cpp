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

#include <fstream>
#include <iomanip>
#include <stdexcept>
#include <type_traits>

namespace
{
    void WriteEscapedText(std::ostream& output, std::string_view value)
    {
        output << '"';

        for (unsigned char ch : value)
        {
            switch (ch)
            {
                case '\\':
                    output << "\\\\";
                    break;
                case '"':
                    output << "\\\"";
                    break;
                case '\n':
                    output << "\\n";
                    break;
                case '\r':
                    output << "\\r";
                    break;
                case '\t':
                    output << "\\t";
                    break;
                default:
                    if (ch < 0x20 || ch == 0x7F)
                    {
                        output << "\\x"
                            << std::hex
                            << std::setw(2)
                            << std::setfill('0')
                            << static_cast<uint32>(ch)
                            << std::dec
                            << std::setfill(' ');
                    }
                    else
                        output << static_cast<char>(ch);
                    break;
            }
        }

        output << '"';
    }

    void WriteDiagnosticValue(std::ostream& output, DiagnosticValue const& value)
    {
        std::visit([&output](auto const& v)
        {
            using T = std::decay_t<decltype(v)>;

            if constexpr (std::is_same_v<T, bool>)
                output << (v ? "true" : "false");
            else if constexpr (std::is_same_v<T, std::string_view>)
                WriteEscapedText(output, v);
            else
                output << v;
        }, value);
    }

    void WriteDiagnosticIndent(std::ostream& output, std::size_t depth)
    {
        for (std::size_t i = 0; i < depth; ++i)
            output << "  ";
    }

    void WriteDiagnosticEvent(std::ostream& output, DiagnosticEvent const& event, std::size_t depth)
    {
        WriteDiagnosticIndent(output, depth);
        output << "event ";
        WriteEscapedText(output, event.name);
        output << '\n';

        for (DiagnosticArg const& arg : event.args)
        {
            WriteDiagnosticIndent(output, depth + 1);
            output << "arg ";
            WriteEscapedText(output, arg.name);
            output << " = ";
            WriteDiagnosticValue(output, arg.value);
            output << '\n';
        }

        for (DiagnosticEvent const& child : event.children)
            WriteDiagnosticEvent(output, child, depth + 1);
    }
}

std::size_t WriteDiagnosticDump(std::string_view name, std::filesystem::path const& path, DiagnosticReader& reader)
{
    DiagnosticReadResult result = reader.ReadEvents();
    std::size_t const rootEventCount = result.events.size();

    if (!path.parent_path().empty())
        std::filesystem::create_directories(path.parent_path());

    std::ofstream output(path, std::ios::binary | std::ios::trunc);
    if (!output)
        throw std::runtime_error("failed to open diagnostics dump file");

    output << "diagnostics ";
    WriteEscapedText(output, name);
    output << '\n';
    output << "events " << rootEventCount << "\n\n";

    for (DiagnosticEvent const& event : result.events)
        WriteDiagnosticEvent(output, event, 0);

    if (!output)
        throw std::runtime_error("failed to write diagnostics dump file");

    return rootEventCount;
}
