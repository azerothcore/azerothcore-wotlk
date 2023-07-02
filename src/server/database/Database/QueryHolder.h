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

#ifndef _QUERYHOLDER_H
#define _QUERYHOLDER_H

#include "DatabaseAsyncOperation.h"
#include "StringFormat.h"
#include <unordered_map>
#include <variant>

struct SQLQueryHolderQuery
{
    std::variant<std::monostate, std::string, PreparedStatement> HolderQuery;
    std::variant<std::monostate, QueryResult, PreparedQueryResult> HolderResult;
};

class AC_DATABASE_API SQLQueryHolderBase
{
    friend class SQLQueryHolderTask;

public:
    SQLQueryHolderBase(std::string_view name) : _name(name) { }
    virtual ~SQLQueryHolderBase() = default;

    [[nodiscard]] PreparedQueryResult GetPreparedResult(std::size_t index) const;
    [[nodiscard]] QueryResult GetResult(std::size_t index) const;

    void SetPreparedResult(std::size_t index, PreparedQueryResult result);
    void SetResult(std::size_t index, QueryResult result);

    bool AddPreparedQuery(std::size_t index, PreparedStatement stmt);
    bool AddQuery(std::size_t index, std::string_view sql);

    template<typename... Args>
    inline bool AddQuery(std::size_t index, std::string_view fmt, Args&&... args)
    {
        return AddQuery(index, Acore::StringFormatFmt(fmt, std::forward<Args>(args)...));
    }

private:
    std::unordered_map<std::size_t, SQLQueryHolderQuery> _queries;
    std::string _name;
};

class AC_DATABASE_API SQLQueryHolderTask : public AsyncOperation
{
public:
    explicit SQLQueryHolderTask(SQLQueryHolder holder) :
        AsyncOperation(), _holder(std::move(holder)) { }

    ~SQLQueryHolderTask() override = default;

    void ExecuteQuery() override;
    QueryResultHolderFuture GetFuture() { return _result.get_future(); }

private:
    std::shared_ptr<SQLQueryHolderBase> _holder;
    QueryResultHolderPromise _result;
};

class AC_DATABASE_API SQLQueryHolderCallback
{
public:
    SQLQueryHolderCallback(SQLQueryHolder&& holder, QueryResultHolderFuture&& future) :
        _holder(std::move(holder)), _future(std::move(future)) { }

    SQLQueryHolderCallback(SQLQueryHolderCallback&&) = default;
    SQLQueryHolderCallback& operator=(SQLQueryHolderCallback&&) = default;

    void AfterComplete(std::function<void(SQLQueryHolderBase const&)>&& callback)
    {
        _callback = std::move(callback);
    }

    bool InvokeIfReady();

    SQLQueryHolder _holder;
    QueryResultHolderFuture _future;
    std::function<void(SQLQueryHolderBase const&)> _callback;
};

#endif
