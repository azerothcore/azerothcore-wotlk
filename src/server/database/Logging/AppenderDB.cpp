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

#include "AppenderDB.h"
#include "DatabaseEnv.h"
#include "LogMessage.h"
#include "PreparedStatement.h"
#include <vector>

AppenderDB::AppenderDB(uint8 id, std::string const& name, LogLevel level, AppenderFlags /*flags*/, std::vector<std::string_view> const& /*args*/)
    : Appender(id, name, level), realmId(0), enabled(false) { }

AppenderDB::~AppenderDB() { }

void AppenderDB::_write(LogMessage const* message)
{
    // Avoid infinite loop, Execute triggers Logging with "sql.sql" type
    if (!enabled || (message->type.find("sql") != std::string::npos))
        return;

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_LOG);
    stmt->SetData(0, message->mtime.count());
    stmt->SetData(1, realmId);
    stmt->SetData(2, message->type);
    stmt->SetData(3, uint8(message->level));
    stmt->SetData(4, message->text);
    LoginDatabase.Execute(stmt);
}

void AppenderDB::setRealmId(uint32 _realmId)
{
    enabled = true;
    realmId = _realmId;
}
