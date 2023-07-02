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

#include "QueryHolder.h"
#include "Containers.h"
#include "Log.h"
#include "MySQLConnection.h"
#include "PreparedStatement.h"
#include "QueryResult.h"
#include <utility>

QueryResult SQLQueryHolderBase::GetResult(std::size_t index) const
{
    auto const& itr = _queries.find(index);
    if (itr == _queries.end())
    {
        LOG_ERROR("db.query", "Query holder result tried to access non exist index {}. Holder name: {}. Type: QueryResult", index, _name);
        return nullptr;
    }

    try
    {
        auto result{ std::get<QueryResult>(itr->second.HolderResult) };
        if (!result || !result->GetRowCount() || !result->NextRow())
            return nullptr;

        return result;
    }
    catch (...) {  }

    return nullptr;
}

PreparedQueryResult SQLQueryHolderBase::GetPreparedResult(std::size_t index) const
{
    auto const& itr = _queries.find(index);
    if (itr == _queries.end())
    {
        LOG_ERROR("db.query", "Query holder result tried to access non exist index {}. Holder name: {}. Type: PreparedQueryResult", index, _name);
        return nullptr;
    }

    try
    {
        auto result{ std::get<PreparedQueryResult>(itr->second.HolderResult) };
        if (!result || !result->GetRowCount())
            return nullptr;

        return result;
    }
    catch (...) {  }

    return nullptr;
}

void SQLQueryHolderBase::SetResult(std::size_t index, QueryResult result)
{
    if (result && !result->GetRowCount())
        result.reset();

    /// store the result in the holder
    if (auto query = Acore::Containers::MapGetValuePtr(_queries, index))
        query->HolderResult = std::move(result);
}

void SQLQueryHolderBase::SetPreparedResult(std::size_t index, PreparedQueryResult result)
{
    if (result && !result->GetRowCount())
        result.reset();

    /// store the result in the holder
    if (auto query = Acore::Containers::MapGetValuePtr(_queries, index))
        query->HolderResult = std::move(result);
}

bool SQLQueryHolderBase::AddQuery(std::size_t index, std::string_view sql)
{
    if (_queries.contains(index))
    {
        LOG_ERROR("db.query", "Trying add query holder with index {} exist. Holder name: {}. Type: QueryResult", index, _name);
        return false;
    }

    SQLQueryHolderQuery query{};
    query.HolderQuery.emplace<std::string>(sql);

    _queries.emplace(index, std::move(query));
    return true;
}

bool SQLQueryHolderBase::AddPreparedQuery(std::size_t index, PreparedStatement stmt)
{
    if (_queries.contains(index))
    {
        LOG_ERROR("db.query", "Trying add query holder with index {} exist. Holder name: {}. Type: PreparedQueryResult", index, _name);
        return false;
    }

    SQLQueryHolderQuery query{};
    query.HolderQuery = std::move(stmt);

    _queries.emplace(index, std::move(query));
    return true;
}

void SQLQueryHolderTask::ExecuteQuery()
{
    /// execute all queries in the holder and pass the results
    for (auto const& [index, query] : _holder->_queries)
    {
        if (std::holds_alternative<std::string>(query.HolderQuery))
            _holder->SetResult(index, _connection->Query(std::get<std::string>(query.HolderQuery)));
        else
            _holder->SetPreparedResult(index, _connection->Query(std::get<PreparedStatement>(query.HolderQuery)));
    }

    _result.set_value();
}

bool SQLQueryHolderCallback::InvokeIfReady()
{
    if (_future.valid() && _future.wait_for(0s) == std::future_status::ready)
    {
        _callback(*_holder);
        return true;
    }

    return false;
}
