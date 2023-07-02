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

#include "DatabaseAsyncOperation.h"
#include "DatabaseWorkerPool.h"
#include "MySQLConnection.h"
#include "QueryResult.h"
#include <utility>

BasicStatementTask::BasicStatementTask(std::string_view sql, bool isAsync /*= false*/) :
    AsyncOperation(isAsync), _sql(sql)
{
    if (_hasResult)
        _result = std::make_unique<QueryResultPromise>();
}

void BasicStatementTask::ExecuteQuery()
{
    if (_hasResult)
    {
        auto result = _connection->Query(_sql);
        if (!result || !result->GetRowCount() || !result->NextRow())
        {
            _result->set_value(QueryResult(nullptr));
            return;
        }

        _result->set_value(result);
        return;
    }

    _connection->Execute(_sql);
}

PreparedStatementTask::PreparedStatementTask(PreparedStatement stmt, bool isAsync /*= false*/) :
    AsyncOperation(isAsync), _stmt(std::move(stmt))
{
    if (_hasResult)
        _result = std::make_unique<PreparedQueryResultPromise>();
}

void PreparedStatementTask::ExecuteQuery()
{
    if (_hasResult)
    {
        auto result = _connection->Query(_stmt);
        if (!result || !result->GetRowCount())
        {
            _result->set_value({ nullptr });
            return;
        }

        _result->set_value(result);
        return;
    }

    _connection->Execute(_stmt);
}

void CheckAsyncQueueTask::Execute()
{
    _dbPool->CheckAsyncQueue();
}
