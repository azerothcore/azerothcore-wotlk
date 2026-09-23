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

#include "ModuleDatabasePool.h"
#include "AdhocStatement.h"
#include "Errors.h"
#include "Log.h"
#include "MySQLConnection.h"
#include "MySQLPreparedStatement.h"
#include "PCQueue.h"
#include "QueryCallback.h"
#include "QueryHolder.h"
#include "QueryResult.h"
#include "SQLOperation.h"
#include "Transaction.h"
#include <errmsg.h>
#include <limits>
#include <mysqld_error.h>
#include <string>
#include <thread>

#ifdef ACORE_DEBUG
#include <boost/stacktrace.hpp>
#include <sstream>

namespace
{
    //! Not a member: MSVC rejects a thread_local with dll interface.
    thread_local bool _warnSyncQueries = false;
}
#endif

ModuleDatabasePool::ModuleDatabasePool() :
    _connectionInfo(""),
    _queue(std::make_unique<ProducerConsumerQueue<SQLOperation*>>()),
    _asyncThreads(0),
    _synchThreads(0)
{
}

ModuleDatabasePool::~ModuleDatabasePool()
{
    Close();

    _queue->Cancel();
}

void ModuleDatabasePool::SetConnectionInfo(std::string_view infoString, uint8 synchThreads)
{
    SetConnectionInfo(infoString, 0, synchThreads);
}

void ModuleDatabasePool::SetConnectionInfo(std::string_view infoString, uint8 asyncThreads, uint8 synchThreads)
{
    _connectionInfo = MySQLConnectionInfo(infoString);
    _asyncThreads = asyncThreads;
    _synchThreads = synchThreads;
}

MySQLConnection* ModuleDatabasePool::CreateConnection(ProducerConsumerQueue<SQLOperation*>* /*queue*/,
    MySQLConnectionInfo& /*connInfo*/)
{
    return nullptr;
}

uint32 ModuleDatabasePool::Open()
{
    if (!_synchThreads)
    {
        LOG_ERROR("sql.driver", "ModuleDatabasePool: database `{}` was configured with 0 synchronous connections, "
            "at least one is required.", _connectionInfo.database);
        return CR_UNKNOWN_ERROR;
    }

    LOG_INFO("sql.driver", "Opening DatabasePool '{}'. Asynchronous connections: {}, synchronous connections: {}.",
        _connectionInfo.database, _asyncThreads, _synchThreads);

    _queue->Cancel();
    _connections[IDX_ASYNC].clear();
    _connections[IDX_SYNCH].clear();
    _preparedStatementSize.clear();
    _queue->Reset();

    if (uint32 error = OpenConnections(IDX_ASYNC, _asyncThreads))
    {
        Close();
        return error;
    }

    if (uint32 error = OpenConnections(IDX_SYNCH, _synchThreads))
    {
        Close();
        return error;
    }

    return 0;
}

uint32 ModuleDatabasePool::OpenConnections(InternalIndex type, uint8 numConnections)
{
    for (uint8 i = 0; i < numConnections; ++i)
    {
        std::unique_ptr<MySQLConnection> conn(type == IDX_ASYNC ? CreateConnection(_queue.get(), _connectionInfo)
            : CreateConnection(_connectionInfo));

        if (!conn)
        {
            if (type == IDX_ASYNC)
            {
                LOG_ERROR("sql.driver", "ModuleDatabasePool: database `{}` was configured with {} asynchronous "
                    "connections, but the module does not override the queue-taking CreateConnection overload.",
                    _connectionInfo.database, numConnections);
            }
            else
            {
                LOG_ERROR("sql.driver", "ModuleDatabasePool: CreateConnection returned no synchronous connection "
                    "for database `{}`.", _connectionInfo.database);
            }

            _queue->Cancel();
            _connections[type].clear();
            return CR_UNKNOWN_ERROR;
        }

        uint32 result = conn->Open();
        if (result != 0)
        {
            LOG_ERROR("sql.driver", "ModuleDatabasePool: could not open {} connection {}/{} to database `{}`, error {}",
                type == IDX_ASYNC ? "asynchronous" : "synchronous", i + 1, numConnections,
                _connectionInfo.database, result);

            _queue->Cancel();
            _connections[type].clear();
            return result;
        }

        _connections[type].push_back(std::move(conn));
    }

    return 0;
}

bool ModuleDatabasePool::PrepareStatements()
{
    for (auto const& connections : _connections)
    {
        for (auto const& conn : connections)
        {
            conn->LockIfReady();
            if (!conn->PrepareStatements())
            {
                conn->Unlock();
                Close();
                return false;
            }

            conn->Unlock();

            std::size_t const preparedSize = conn->m_stmts.size();
            if (_preparedStatementSize.size() < preparedSize)
                _preparedStatementSize.resize(preparedSize);

            for (std::size_t i = 0; i < preparedSize; ++i)
            {
                if (_preparedStatementSize[i] > 0)
                    continue;

                if (MySQLPreparedStatement* stmt = conn->m_stmts[i].get())
                {
                    uint32 const paramCount = stmt->GetParameterCount();

                    // Only uint8 indices are supported.
                    ASSERT(paramCount < std::numeric_limits<uint8>::max());

                    _preparedStatementSize[i] = static_cast<uint8>(paramCount);
                }
            }
        }
    }

    //! Without async connections every statement runs on a synchronous one, so CONNECTION_ASYNC-only ones fail.
    if (_connections[IDX_ASYNC].empty())
    {
        MySQLConnection const* conn = _connections[IDX_SYNCH].front().get();
        std::string missing;

        for (std::size_t i = 0; i < conn->m_stmts.size(); ++i)
        {
            if (conn->m_stmts[i])
                continue;

            if (!missing.empty())
                missing += ", ";

            missing += std::to_string(i);
        }

        if (!missing.empty())
        {
            LOG_ERROR("sql.driver", "DatabasePool '{}' has no asynchronous connections, statements [{}] are not "
                "prepared on the synchronous ones. Flag them CONNECTION_BOTH.", _connectionInfo.database, missing);
        }
    }

    return true;
}

void ModuleDatabasePool::Close()
{
    _queue->Shutdown();

    _connections[IDX_ASYNC].clear();
    _connections[IDX_SYNCH].clear();

    _preparedStatementSize.clear();
}

void ModuleDatabasePool::Execute(std::string_view sql)
{
    if (sql.empty())
        return;

    if (_connections[IDX_ASYNC].empty())
    {
        DirectExecute(sql);
        return;
    }

    Enqueue(new BasicStatementTask(sql));
}

void ModuleDatabasePool::Execute(PreparedStatementBase* stmt)
{
    if (_connections[IDX_ASYNC].empty())
    {
        DirectExecute(stmt);
        return;
    }

    Enqueue(new PreparedStatementTask(stmt));
}

void ModuleDatabasePool::DirectExecute(std::string_view sql)
{
    if (sql.empty())
        return;

    if (_connections[IDX_SYNCH].empty())
        return;

    MySQLConnection* conn = GetFreeConnection();
    conn->Execute(sql);
    conn->Unlock();
}

void ModuleDatabasePool::DirectExecute(PreparedStatementBase* stmt)
{
    if (_connections[IDX_SYNCH].empty())
    {
        delete stmt;
        return;
    }

    MySQLConnection* conn = GetFreeConnection();
    conn->Execute(stmt);
    conn->Unlock();

    delete stmt;
}

QueryResult ModuleDatabasePool::Query(std::string_view sql)
{
    if (_connections[IDX_SYNCH].empty())
        return QueryResult(nullptr);

    MySQLConnection* conn = GetFreeConnection();
    ResultSet* result = conn->Query(sql);
    conn->Unlock();

    // Mirror DatabaseWorkerPool<T>::Query semantics: nullptr for empty results,
    // and the first row loaded before the result is handed out.
    if (!result || !result->GetRowCount() || !result->NextRow())
    {
        delete result;
        return QueryResult(nullptr);
    }

    return QueryResult(result);
}

PreparedQueryResult ModuleDatabasePool::Query(PreparedStatementBase* stmt)
{
    if (_connections[IDX_SYNCH].empty())
    {
        delete stmt;
        return PreparedQueryResult(nullptr);
    }

    MySQLConnection* conn = GetFreeConnection();
    PreparedResultSet* result = conn->Query(stmt);
    conn->Unlock();

    //! Delete proxy-class. Not needed anymore
    delete stmt;

    if (!result || !result->GetRowCount())
    {
        delete result;
        return PreparedQueryResult(nullptr);
    }

    return PreparedQueryResult(result);
}

QueryCallback ModuleDatabasePool::AsyncQuery(std::string_view sql)
{
    if (_connections[IDX_ASYNC].empty())
    {
        QueryResultPromise result;
        result.set_value(Query(sql));
        return QueryCallback(result.get_future());
    }

    BasicStatementTask* task = new BasicStatementTask(sql, true);
    QueryResultFuture result = task->GetFuture();
    Enqueue(task);
    return QueryCallback(std::move(result));
}

QueryCallback ModuleDatabasePool::AsyncQuery(PreparedStatementBase* stmt)
{
    if (_connections[IDX_ASYNC].empty())
    {
        PreparedQueryResultPromise result;
        result.set_value(Query(stmt));
        return QueryCallback(result.get_future());
    }

    PreparedStatementTask* task = new PreparedStatementTask(stmt, true);
    PreparedQueryResultFuture result = task->GetFuture();
    Enqueue(task);
    return QueryCallback(std::move(result));
}

SQLQueryHolderCallback ModuleDatabasePool::DelayQueryHolder(std::shared_ptr<SQLQueryHolderBase> holder)
{
    if (!_connections[IDX_ASYNC].empty())
    {
        SQLQueryHolderTask* task = new SQLQueryHolderTask(holder);
        QueryResultHolderFuture result = task->GetFuture();
        Enqueue(task);
        return { std::move(holder), std::move(result) };
    }

    if (!_connections[IDX_SYNCH].empty())
    {
        SQLQueryHolderTask task(holder);
        QueryResultHolderFuture result = task.GetFuture();

        MySQLConnection* conn = GetFreeConnection();
        task.SetConnection(conn);
        task.Execute();
        conn->Unlock();

        return { std::move(holder), std::move(result) };
    }

    QueryResultHolderPromise result;
    result.set_value();
    return { std::move(holder), result.get_future() };
}

uint8 ModuleDatabasePool::GetPreparedStatementParamCount(uint32 index) const
{
    return index < _preparedStatementSize.size() ? _preparedStatementSize[index] : 0;
}

void ModuleDatabasePool::CommitTransaction(std::shared_ptr<TransactionBase> transaction)
{
#ifdef ACORE_DEBUG
    switch (transaction->GetSize())
    {
    case 0:
        LOG_DEBUG("sql.driver", "Transaction contains 0 queries. Not executing.");
        return;
    case 1:
        LOG_DEBUG("sql.driver",
            "Warning: Transaction only holds 1 query, consider removing Transaction context in code.");
        break;
    default:
        break;
    }
#endif
    if (_connections[IDX_ASYNC].empty())
    {
        DirectCommitTransaction(transaction);
        return;
    }

    Enqueue(new TransactionTask(transaction));
}

TransactionCallback ModuleDatabasePool::AsyncCommitTransaction(std::shared_ptr<TransactionBase> transaction)
{
#ifdef ACORE_DEBUG
    switch (transaction->GetSize())
    {
    case 0:
        LOG_DEBUG("sql.driver", "Transaction contains 0 queries. Not executing.");
        break;
    case 1:
        LOG_DEBUG("sql.driver",
            "Warning: Transaction only holds 1 query, consider removing Transaction context in code.");
        break;
    default:
        break;
    }
#endif

    if (_connections[IDX_ASYNC].empty())
    {
        TransactionPromise result;
        result.set_value(TryDirectCommitTransaction(transaction));
        return TransactionCallback(result.get_future());
    }

    TransactionWithResultTask* task = new TransactionWithResultTask(transaction);
    TransactionFuture result = task->GetFuture();
    Enqueue(task);
    return TransactionCallback(std::move(result));
}

void ModuleDatabasePool::DirectCommitTransaction(std::shared_ptr<TransactionBase> transaction)
{
    TryDirectCommitTransaction(transaction);
}

bool ModuleDatabasePool::TryDirectCommitTransaction(std::shared_ptr<TransactionBase> transaction)
{
    if (_connections[IDX_SYNCH].empty())
        return false;

    MySQLConnection* conn = GetFreeConnection();
    int errorCode = conn->ExecuteTransaction(transaction);
    if (!errorCode)
    {
        conn->Unlock();
        return true;
    }

    bool committed = false;

    //! Handle MySQL Errno 1213 without extending deadlock to the core itself
    if (errorCode == ER_LOCK_DEADLOCK)
    {
        uint8 constexpr loopBreaker = 5;
        for (uint8 i = 0; i < loopBreaker; ++i)
        {
            if (!conn->ExecuteTransaction(transaction))
            {
                committed = true;
                break;
            }
        }
    }

    transaction->Cleanup();
    conn->Unlock();
    return committed;
}

void ModuleDatabasePool::KeepAlive()
{
    for (auto const& conn : _connections[IDX_SYNCH])
    {
        if (conn->LockIfReady())
        {
            conn->Ping();
            conn->Unlock();
        }
    }

    auto const count = _connections[IDX_ASYNC].size();

    for (std::size_t i = 0; i < count; ++i)
        Enqueue(new PingOperation);
}

std::size_t ModuleDatabasePool::QueueSize() const
{
    return _queue->Size();
}

void ModuleDatabasePool::WarnAboutSyncQueries([[maybe_unused]] bool warn)
{
#ifdef ACORE_DEBUG
    _warnSyncQueries = warn;
#endif
}

void ModuleDatabasePool::Enqueue(SQLOperation* op)
{
    _queue->Push(op);
}

MySQLConnection* ModuleDatabasePool::GetFreeConnection()
{
#ifdef ACORE_DEBUG
    if (_warnSyncQueries)
    {
        std::ostringstream ss;
        ss << boost::stacktrace::stacktrace();
        LOG_WARN("sql.performances", "Sync query at:\n{}", ss.str());
    }
#endif

    uint8 i = 0;
    auto const num_cons = _connections[IDX_SYNCH].size();
    MySQLConnection* connection = nullptr;

    //! Block forever until a connection is free
    for (;;)
    {
        connection = _connections[IDX_SYNCH][++i % num_cons].get();
        //! Must be matched with connection->Unlock() or you will get deadlocks
        if (connection->LockIfReady())
            break;

        if (i % num_cons == 0)
            std::this_thread::yield();
    }

    return connection;
}

MySQLConnectionInfo const* ModuleDatabasePool::GetConnectionInfo() const
{
    return &_connectionInfo;
}
