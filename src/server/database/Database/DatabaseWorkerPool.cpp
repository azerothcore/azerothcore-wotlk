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

#include "DatabaseWorkerPool.h"
#include "AdhocStatement.h"
#include "CharacterDatabase.h"
#include "Errors.h"
#include "Log.h"
#include "LoginDatabase.h"
#include "MySQLPreparedStatement.h"
#include "MySQLWorkaround.h"
#include "PCQueue.h"
#include "PreparedStatement.h"
#include "QueryCallback.h"
#include "QueryHolder.h"
#include "QueryResult.h"
#include "SQLOperation.h"
#include "Transaction.h"
#include "WorldDatabase.h"
#include <limits>
#include <mysqld_error.h>
#include <sstream>
#include <vector>

#ifdef ACORE_DEBUG
#include <boost/stacktrace.hpp>
#include <sstream>
#endif

#ifdef MOD_PLAYERBOTS
#include "Implementation/PlayerbotsDatabase.h"
#endif

class PingOperation : public SQLOperation
{
    //! Operation for idle delaythreads
    bool Execute() override
    {
        m_conn->Ping();
        return true;
    }
};

template <class T>
DatabaseWorkerPool<T>::DatabaseWorkerPool() :
    _queue(new ProducerConsumerQueue<SQLOperation*>()),
    _async_threads(0),
    _synch_threads(0)
{
    WPFatal(mysql_thread_safe(), "Used MySQL library isn't thread-safe.");

#if !defined(MARIADB_VERSION_ID) || MARIADB_VERSION_ID < 100600
    bool isSupportClientDB = mysql_get_client_version() >= MIN_MYSQL_CLIENT_VERSION;
    bool isSameClientDB = mysql_get_client_version() == MYSQL_VERSION_ID;
#else // MariaDB 10.6+
    bool isSupportClientDB = mysql_get_client_version() >= MIN_MYSQL_CLIENT_VERSION;
    bool isSameClientDB    = true; // Client version 3.2.3?
#endif

    WPFatal(isSupportClientDB, "AzerothCore does not support MySQL versions below 5.7 or MariaDB versions below 10.5.\n\nFound version: {} / {}. Server compiled with: {}.\nSearch the wiki for ACE00043 in Common Errors (https://www.azerothcore.org/wiki/common-errors#ace00043).",
        mysql_get_client_info(), mysql_get_client_version(), MYSQL_VERSION_ID);
    WPFatal(isSameClientDB, "Used MySQL library version ({} id {}) does not match the version id used to compile AzerothCore (id {}).\nSearch the wiki for ACE00046 in Common Errors (https://www.azerothcore.org/wiki/common-errors#ace00046).",
        mysql_get_client_info(), mysql_get_client_version(), MYSQL_VERSION_ID);
}

template <class T>
DatabaseWorkerPool<T>::~DatabaseWorkerPool()
{
    _queue->Cancel();
}

template <class T>
void DatabaseWorkerPool<T>::SetConnectionInfo(std::string_view infoString, uint8 const asyncThreads, uint8 const synchThreads)
{
    _connectionInfo = std::make_unique<MySQLConnectionInfo>(infoString);

    _async_threads = asyncThreads;
    _synch_threads = synchThreads;
}

template <class T>
uint32 DatabaseWorkerPool<T>::Open()
{
    WPFatal(_connectionInfo.get(), "Connection info was not set!");

    LOG_INFO("sql.driver", "Opening DatabasePool '{}'. Asynchronous connections: {}, synchronous connections: {}.",
        GetDatabaseName(), _async_threads, _synch_threads);

    uint32 error = OpenConnections(IDX_ASYNC, _async_threads);

    if (error)
        return error;

    error = OpenConnections(IDX_SYNCH, _synch_threads);

    if (!error)
    {
        LOG_INFO("sql.driver", "DatabasePool '{}' opened successfully. {} total connections running.",
            GetDatabaseName(), (_connections[IDX_SYNCH].size() + _connections[IDX_ASYNC].size()));
    }

    LOG_INFO("sql.driver", " ");

    return error;
}

template <class T>
void DatabaseWorkerPool<T>::Close()
{
    LOG_INFO("sql.driver", "Closing down DatabasePool '{}'.", GetDatabaseName());

    //! Closes the actualy MySQL connection.
    _connections[IDX_ASYNC].clear();

    LOG_INFO("sql.driver", "Asynchronous connections on DatabasePool '{}' terminated. Proceeding with synchronous connections.",
        GetDatabaseName());

    //! Shut down the synchronous connections
    //! There's no need for locking the connection, because DatabaseWorkerPool<>::Close
    //! should only be called after any other thread tasks in the core have exited,
    //! meaning there can be no concurrent access at this point.
    _connections[IDX_SYNCH].clear();

    LOG_INFO("sql.driver", "All connections on DatabasePool '{}' closed.", GetDatabaseName());
}

template <class T>
bool DatabaseWorkerPool<T>::PrepareStatements()
{
    for (auto const& connections : _connections)
    {
        for (auto const& connection : connections)
        {
            connection->LockIfReady();
            if (!connection->PrepareStatements())
            {
                connection->Unlock();
                Close();
                return false;
            }
            else
                connection->Unlock();

            size_t const preparedSize = connection->m_stmts.size();
            if (_preparedStatementSize.size() < preparedSize)
                _preparedStatementSize.resize(preparedSize);

            for (size_t i = 0; i < preparedSize; ++i)
            {
                // already set by another connection
                // (each connection only has prepared statements of it's own type sync/async)
                if (_preparedStatementSize[i] > 0)
                    continue;

                if (MySQLPreparedStatement* stmt = connection->m_stmts[i].get())
                {
                    uint32 const paramCount = stmt->GetParameterCount();

                    // WH only supports uint8 indices.
                    ASSERT(paramCount < std::numeric_limits<uint8>::max());

                    _preparedStatementSize[i] = static_cast<uint8>(paramCount);
                }
            }
        }
    }

    return true;
}

template <class T>
QueryResult DatabaseWorkerPool<T>::Query(std::string_view sql)
{
    auto connection = GetFreeConnection();

    ResultSet* result = connection->Query(sql);
    connection->Unlock();

    if (!result || !result->GetRowCount() || !result->NextRow())
    {
        delete result;
        return QueryResult(nullptr);
    }

    return QueryResult(result);
}

template <class T>
PreparedQueryResult DatabaseWorkerPool<T>::Query(PreparedStatement<T>* stmt)
{
    auto connection = GetFreeConnection();
    PreparedResultSet* ret = connection->Query(stmt);
    connection->Unlock();

    //! Delete proxy-class. Not needed anymore
    delete stmt;

    if (!ret || !ret->GetRowCount())
    {
        delete ret;
        return PreparedQueryResult(nullptr);
    }

    return PreparedQueryResult(ret);
}

template <class T>
QueryCallback DatabaseWorkerPool<T>::AsyncQuery(std::string_view sql)
{
    BasicStatementTask* task = new BasicStatementTask(sql, true);
    // Store future result before enqueueing - task might get already processed and deleted before returning from this method
    QueryResultFuture result = task->GetFuture();
    Enqueue(task);
    return QueryCallback(std::move(result));
}

template <class T>
QueryCallback DatabaseWorkerPool<T>::AsyncQuery(PreparedStatement<T>* stmt)
{
    PreparedStatementTask* task = new PreparedStatementTask(stmt, true);
    // Store future result before enqueueing - task might get already processed and deleted before returning from this method
    PreparedQueryResultFuture result = task->GetFuture();
    Enqueue(task);
    return QueryCallback(std::move(result));
}

template <class T>
SQLQueryHolderCallback DatabaseWorkerPool<T>::DelayQueryHolder(std::shared_ptr<SQLQueryHolder<T>> holder)
{
    SQLQueryHolderTask* task = new SQLQueryHolderTask(holder);
    // Store future result before enqueueing - task might get already processed and deleted before returning from this method
    QueryResultHolderFuture result = task->GetFuture();
    Enqueue(task);
    return { std::move(holder), std::move(result) };
}

template <class T>
SQLTransaction<T> DatabaseWorkerPool<T>::BeginTransaction()
{
    return std::make_shared<Transaction<T>>();
}

template <class T>
void DatabaseWorkerPool<T>::CommitTransaction(SQLTransaction<T> transaction)
{
#ifdef ACORE_DEBUG
    //! Only analyze transaction weaknesses in Debug mode.
    //! Ideally we catch the faults in Debug mode and then correct them,
    //! so there's no need to waste these CPU cycles in Release mode.
    switch (transaction->GetSize())
    {
    case 0:
        LOG_DEBUG("sql.driver", "Transaction contains 0 queries. Not executing.");
        return;
    case 1:
        LOG_DEBUG("sql.driver", "Warning: Transaction only holds 1 query, consider removing Transaction context in code.");
        break;
    default:
        break;
    }
#endif // ACORE_DEBUG

    Enqueue(new TransactionTask(transaction));
}

template <class T>
TransactionCallback DatabaseWorkerPool<T>::AsyncCommitTransaction(SQLTransaction<T> transaction)
{
#ifdef ACORE_DEBUG
    //! Only analyze transaction weaknesses in Debug mode.
    //! Ideally we catch the faults in Debug mode and then correct them,
    //! so there's no need to waste these CPU cycles in Release mode.
    switch (transaction->GetSize())
    {
        case 0:
            LOG_DEBUG("sql.driver", "Transaction contains 0 queries. Not executing.");
            break;
        case 1:
            LOG_DEBUG("sql.driver", "Warning: Transaction only holds 1 query, consider removing Transaction context in code.");
            break;
        default:
            break;
    }
#endif // ACORE_DEBUG

    TransactionWithResultTask* task = new TransactionWithResultTask(transaction);
    TransactionFuture result = task->GetFuture();
    Enqueue(task);
    return TransactionCallback(std::move(result));
}

template <class T>
void DatabaseWorkerPool<T>::DirectCommitTransaction(SQLTransaction<T>& transaction)
{
    T* connection = GetFreeConnection();
    int errorCode = connection->ExecuteTransaction(transaction);

    if (!errorCode)
    {
        connection->Unlock();      // OK, operation succesful
        return;
    }

    //! Handle MySQL Errno 1213 without extending deadlock to the core itself
    /// @todo More elegant way
    if (errorCode == ER_LOCK_DEADLOCK)
    {
        //todo: handle multiple sync threads deadlocking in a similar way as async threads
        uint8 loopBreaker = 5;

        for (uint8 i = 0; i < loopBreaker; ++i)
        {
            if (!connection->ExecuteTransaction(transaction))
                break;
        }
    }

    //! Clean up now.
    transaction->Cleanup();

    connection->Unlock();
}

template <class T>
PreparedStatement<T>* DatabaseWorkerPool<T>::GetPreparedStatement(PreparedStatementIndex index)
{
    return new PreparedStatement<T>(index, _preparedStatementSize[index]);
}

template <class T>
void DatabaseWorkerPool<T>::EscapeString(std::string& str)
{
    if (str.empty())
        return;

    char* buf = new char[str.size() * 2 + 1];
    EscapeString(buf, str.c_str(), uint32(str.size()));
    str = buf;
    delete[] buf;
}

template <class T>
void DatabaseWorkerPool<T>::KeepAlive()
{
    //! Ping synchronous connections
    for (auto& connection : _connections[IDX_SYNCH])
    {
        if (connection->LockIfReady())
        {
            connection->Ping();
            connection->Unlock();
        }
    }

    //! Assuming all worker threads are free, every worker thread will receive 1 ping operation request
    //! If one or more worker threads are busy, the ping operations will not be split evenly, but this doesn't matter
    //! as the sole purpose is to prevent connections from idling.
    auto const count = _connections[IDX_ASYNC].size();

    for (uint8 i = 0; i < count; ++i)
        Enqueue(new PingOperation);
}

/**
* @brief Returns true if the version string given is incompatible
*
* Intended to be used with mysql_get_server_info()'s output as the source
*
* DatabaseIncompatibleVersion("8.0.35") => false
* DatabaseIncompatibleVersion("5.6.6") => true
* DatabaseIncompatibleVersion("5.5.5-10.5.5-MariaDB") => false
* DatabaseIncompatibleVersion("5.5.5-10.4.0-MariaDB") => true
*
* Adapted from stackoverflow response
* https://stackoverflow.com/a/2941508
*
* @param mysqlVersion The output from GetServerInfo()/mysql_get_server_info()
* @return Returns true if the Server version is incompatible
*/
bool DatabaseIncompatibleVersion(std::string const mysqlVersion)
{
    // anon func to turn a version string into an array of uint8
    // "1.2.3" => [1, 2, 3]
    auto parse = [](std::string const& input)
    {
        std::vector<uint8> result;
        std::istringstream parser(input);
        result.push_back(parser.get());
        for (int i = 1; i < 3; i++)
        {
            // Skip period
            parser.get();
            // Append int from parser to output
            result.push_back(parser.get());
        }
        return result;
    };

    // default to values for MySQL
    uint8 offset = 0;
    std::string minVersion = MIN_MYSQL_SERVER_VERSION;

    // If the version string contains "MariaDB", use that
    if (mysqlVersion.find("MariaDB") != std::string::npos)
    {
        // All MariaDB 10.X versions have a prefix of 5.5.5 from the
        // mysql_get_server_info() function. To make matters more
        // annoying, this is removed in MariaDB 11.X
        if (mysqlVersion.rfind("5.5.5-", 0) == 0)
            offset = 6;
        minVersion = MIN_MARIADB_SERVER_VERSION;
    }

    auto parsedMySQLVersion = parse(mysqlVersion.substr(offset));
    auto parsedMinVersion = parse(minVersion);

    return std::lexicographical_compare(parsedMySQLVersion.begin(), parsedMySQLVersion.end(),
                                        parsedMinVersion.begin(), parsedMinVersion.end());
}

template <class T>
uint32 DatabaseWorkerPool<T>::OpenConnections(InternalIndex type, uint8 numConnections)
{
    for (uint8 i = 0; i < numConnections; ++i)
    {
        // Create the connection
        auto connection = [&]
        {
            switch (type)
            {
            case IDX_ASYNC:
                return std::make_unique<T>(_queue.get(), *_connectionInfo);
            case IDX_SYNCH:
                return std::make_unique<T>(*_connectionInfo);
            default:
                ABORT();
            }
        }();

        if (uint32 error = connection->Open())
        {
            // Failed to open a connection or invalid version, abort and cleanup
            _connections[type].clear();
            return error;
        }
        else if (DatabaseIncompatibleVersion(connection->GetServerInfo()))
        {
            LOG_ERROR("sql.driver", "AzerothCore does not support MySQL versions below 5.7 or MariaDB versions below 10.5.\n\nFound server version: {}. Server compiled with: {}.",
                connection->GetServerInfo(), MYSQL_VERSION_ID);
            return 1;
        }
        else
        {
            _connections[type].push_back(std::move(connection));
        }
    }

    // Everything is fine
    return 0;
}

template <class T>
unsigned long DatabaseWorkerPool<T>::EscapeString(char* to, char const* from, unsigned long length)
{
    if (!to || !from || !length)
        return 0;

    return _connections[IDX_SYNCH].front()->EscapeString(to, from, length);
}

template <class T>
void DatabaseWorkerPool<T>::Enqueue(SQLOperation* op)
{
    _queue->Push(op);
}

template <class T>
size_t DatabaseWorkerPool<T>::QueueSize() const
{
    return _queue->Size();
}

template <class T>
T* DatabaseWorkerPool<T>::GetFreeConnection()
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
    T* connection = nullptr;

    //! Block forever until a connection is free
    for (;;)
    {
        connection = _connections[IDX_SYNCH][++i % num_cons].get();
        //! Must be matched with t->Unlock() or you will get deadlocks
        if (connection->LockIfReady())
            break;
    }

    return connection;
}

template <class T>
std::string_view DatabaseWorkerPool<T>::GetDatabaseName() const
{
    return std::string_view{ _connectionInfo->database };
}

template <class T>
void DatabaseWorkerPool<T>::Execute(std::string_view sql)
{
    if (sql.empty())
        return;

    BasicStatementTask* task = new BasicStatementTask(sql);
    Enqueue(task);
}

template <class T>
void DatabaseWorkerPool<T>::Execute(PreparedStatement<T>* stmt)
{
    PreparedStatementTask* task = new PreparedStatementTask(stmt);
    Enqueue(task);
}

template <class T>
void DatabaseWorkerPool<T>::DirectExecute(std::string_view sql)
{
    if (sql.empty())
        return;

    T* connection = GetFreeConnection();
    connection->Execute(sql);
    connection->Unlock();
}

template <class T>
void DatabaseWorkerPool<T>::DirectExecute(PreparedStatement<T>* stmt)
{
    T* connection = GetFreeConnection();
    connection->Execute(stmt);
    connection->Unlock();

    //! Delete proxy-class. Not needed anymore
    delete stmt;
}

template <class T>
void DatabaseWorkerPool<T>::ExecuteOrAppend(SQLTransaction<T>& trans, std::string_view sql)
{
    if (!trans)
        Execute(sql);
    else
        trans->Append(sql);
}

template <class T>
void DatabaseWorkerPool<T>::ExecuteOrAppend(SQLTransaction<T>& trans, PreparedStatement<T>* stmt)
{
    if (!trans)
        Execute(stmt);
    else
        trans->Append(stmt);
}

template class AC_DATABASE_API DatabaseWorkerPool<LoginDatabaseConnection>;
template class AC_DATABASE_API DatabaseWorkerPool<WorldDatabaseConnection>;
template class AC_DATABASE_API DatabaseWorkerPool<CharacterDatabaseConnection>;

#ifdef MOD_PLAYERBOTS
template class AC_DATABASE_API DatabaseWorkerPool<PlayerbotsDatabaseConnection>;
#endif
