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

#ifndef _DATABASE_ASYNC_OPERATION_H_
#define _DATABASE_ASYNC_OPERATION_H_

#include "DatabaseEnvFwd.h"

class DatabaseWorkerPool;

class AC_DATABASE_API AsyncOperation
{
public:
    explicit AsyncOperation(bool isAsync = false) :
        _hasResult(isAsync) { }

    virtual ~AsyncOperation() = default;

    virtual void ExecuteQuery() = 0;
    inline void SetConnection(MySQLConnection* connection) { _connection = connection; }

protected:
    MySQLConnection* _connection{ nullptr };
    bool _hasResult{};

private:
    AsyncOperation(AsyncOperation const& right) = delete;
    AsyncOperation& operator=(AsyncOperation const& right) = delete;
};

class AC_DATABASE_API BasicStatementTask : public AsyncOperation
{
public:
    explicit BasicStatementTask(std::string_view sql, bool isAsync = false);
    ~BasicStatementTask() override = default;

    void ExecuteQuery() override;
    [[nodiscard]] QueryResultFuture GetFuture() const { return _result->get_future(); }

private:
    std::string _sql;
    std::unique_ptr<QueryResultPromise> _result;
};

class AC_DATABASE_API PreparedStatementTask : public AsyncOperation
{
public:
    explicit PreparedStatementTask(PreparedStatement stmt, bool isAsync = false);
    ~PreparedStatementTask() override = default;

    void ExecuteQuery() override;
    [[nodiscard]] PreparedQueryResultFuture GetFuture() const { return _result->get_future(); }

private:
    PreparedStatement _stmt;
    std::unique_ptr<PreparedQueryResultPromise> _result;
};

class AC_DATABASE_API CheckAsyncQueueTask
{
public:
    explicit CheckAsyncQueueTask(DatabaseWorkerPool* dbPool) :
        _dbPool(dbPool) { }

    virtual ~CheckAsyncQueueTask() = default;

    void Execute();

private:
    DatabaseWorkerPool* _dbPool;

    CheckAsyncQueueTask(CheckAsyncQueueTask const& right) = delete;
    CheckAsyncQueueTask& operator=(CheckAsyncQueueTask const& right) = delete;
};

#endif // _DATABASE_ASYNC_OPERATION_H_
