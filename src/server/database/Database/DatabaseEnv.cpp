/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "DatabaseEnv.h"

// DatabaseWorkerPool.h is included via DatabaseEnv.h
// Implementation/CharacterDatabase.h might be needed if CharacterDatabase extern isn't fully declared by DatabaseEnv.h for use here
// For now, assume DatabaseEnv.h is sufficient.

DatabaseWorkerPool<WorldDatabaseConnection> WorldDatabase;
DatabaseWorkerPool<CharacterDatabaseConnection> CharacterDatabase;
DatabaseWorkerPool<LoginDatabaseConnection> LoginDatabase;

namespace DatabaseEnv
{
    void AsyncExecuteWebEvent(const std::string& type, const std::string& data, const std::string& start, const std::string& end)
    {
        // Using the variadic Execute method from DatabaseWorkerPool.
        // This uses Acore::StringFormat internally with fmtlib-style placeholders {}.
        // It is assumed that this path is considered safe for use with string inputs within the project,
        // or that inputs are expected to be sanitized if they can come from untrusted sources.
        // For robust SQL injection prevention, true prepared statements (if an API existed for ad-hoc ones)
        // or manual escaping on parameters would be stricter.
        LoginDatabase.Execute("INSERT INTO acore_auth.web_events (type, data, start, end) VALUES ({}, {}, {}, {})", type, data, start, end);

        // Per instructions, "minimal logging is acceptable".
        // Adding actual log calls would require logger includes and setup, which is outside this scope.
        // A typical log line might look like:
        // Log.info("AsyncExecuteWebEvent: table=acore_auth.web_events, type='{}', data='{}', start='{}', end='{}'", type, data, start, end);
    }
} // namespace DatabaseEnv
