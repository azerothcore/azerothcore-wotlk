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

#ifndef ACORE_DIAGNOSTIC_DUMP_H
#define ACORE_DIAGNOSTIC_DUMP_H

#include "Define.h"
#include "DiagnosticReader.h"

#include <cstddef>
#include <filesystem>
#include <string_view>

/**
 * @brief Write a text dump of the specified diagnostic stream.
 *
 * @param name The diagnostic stream name to write in the dump header.
 * @param path The target dump file path.
 * @param reader The reader to drain into the dump.
 *
 * The behavior is undefined unless @p name is non-empty.
 */
[[nodiscard]] AC_COMMON_API std::size_t WriteDiagnosticDump(std::string_view name, std::filesystem::path const& path, DiagnosticReader& reader);

#endif // ACORE_DIAGNOSTIC_DUMP_H
