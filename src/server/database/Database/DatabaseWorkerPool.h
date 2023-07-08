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

#ifndef _DATABASEWORKERPOOL_H
#define _DATABASEWORKERPOOL_H

#include "DatabaseEnvFwd.h"
#include "Duration.h"
#include "StringFormat.h"
#include <array>
#include <functional>
#include <mutex>
#include <thread>
#include <unordered_map>
#include <vector>

template <typename T>
class ProducerConsumerQueue;

class AsyncDBQueueChecker;
class AsyncOperation;
class CheckAsyncQueueTask;
class TaskScheduler;

struct StringPreparedStatement
{
    StringPreparedStatement(uint32 index, std::string_view sql, ConnectionFlags flags) :
        Index(index), Query(sql), ConnectionType(flags) { }

    uint32 Index{};
    std::string Query;
    ConnectionFlags ConnectionType{ ConnectionFlags::Sync };
};

class AC_DATABASE_API DatabaseWorkerPool
{
private:
    enum InternalIndex
    {
        IDX_ASYNC,
        IDX_SYNCH,
        IDX_SIZE
    };

public:
    explicit DatabaseWorkerPool(DatabaseType type);
    virtual ~DatabaseWorkerPool();

    void SetConnectionInfo(std::string_view infoString);

    uint32 Open();
    void Close();

    //! Prepares all prepared statements
    bool PrepareStatements();
    virtual void DoPrepareStatements() = 0;

    [[nodiscard]] inline MySQLConnectionInfo const* GetConnectionInfo() const { return _connectionInfo.get(); }

    void Enqueue(AsyncOperation* operation);

    /**
        Delayed one-way statement methods.
    */

    //! Enqueues a one-way SQL operation in string format that will be executed asynchronously.
    //! This method should only be used for queries that are only executed once, e.g during startup.
    void Execute(std::string_view sql);

    //! Enqueues a one-way SQL operation in string format -with variable args- that will be executed asynchronously.
    //! This method should only be used for queries that are only executed once, e.g during startup.
    template<typename... Args>
    void Execute(std::string_view sql, Args&&... args)
    {
        if (sql.empty())
            return;

        Execute(Acore::StringFormatFmt(sql, std::forward<Args>(args)...));
    }

    void Execute(PreparedStatement stmt);

    /**
        Direct synchronous one-way statement methods.
    */

    //! Directly executes a one-way SQL operation in string format, that will block the calling thread until finished.
    //! This method should only be used for queries that are only executed once, e.g during startup.
    void DirectExecute(std::string_view sql);

    //! Directly executes a one-way SQL operation in string format -with variable args-, that will block the calling thread until finished.
    //! This method should only be used for queries that are only executed once, e.g during startup.
    template<typename... Args>
    void DirectExecute(std::string_view sql, Args&&... args)
    {
        if (sql.empty())
            return;

        DirectExecute(Acore::StringFormatFmt(sql, std::forward<Args>(args)...));
    }

    //! Directly executes a one-way SQL operation in prepared statement format, that will block the calling thread until finished.
    //! Statement must be prepared with the CONNECTION_SYNCH flag.
    void DirectExecute(PreparedStatement stmt);

    /**
        Synchronous query (with resultset) methods.
    */

    //! Directly executes an SQL query in string format that will block the calling thread until finished.
    //! Returns reference counted auto pointer, no need for manual memory management in upper level code.
    QueryResult Query(std::string_view sql);

    //! Directly executes an SQL query in string format -with variable args- that will block the calling thread until finished.
    //! Returns reference counted auto pointer, no need for manual memory management in upper level code.
    template<typename... Args>
    QueryResult Query(std::string_view sql, Args&&... args)
    {
        if (sql.empty())
            return { nullptr };

        return Query(Acore::StringFormatFmt(sql, std::forward<Args>(args)...));
    }

    //! Directly executes an SQL query in prepared format that will block the calling thread until finished.
    //! Returns reference counted auto pointer, no need for manual memory management in upper level code.
    //! Statement must be prepared with CONNECTION_SYNCH flag.
    PreparedQueryResult Query(PreparedStatement stmt);

    /**
        Asynchronous query (with resultset) methods.
    */

    //! Enqueues a query in string format that will set the value of the QueryResultFuture return object as soon as the query is executed.
    //! The return value is then processed in ProcessQueryCallback methods.
    QueryCallback AsyncQuery(std::string_view sql);

    //! Enqueues a query in prepared format that will set the value of the PreparedQueryResultFuture return object as soon as the query is executed.
    //! The return value is then processed in ProcessQueryCallback methods.
    //! Statement must be prepared with CONNECTION_ASYNC flag.
    QueryCallback AsyncQuery(PreparedStatement stmt);

    //! Enqueues a vector of SQL operations (can be both adhoc and prepared) that will set the value of the QueryResultHolderFuture
    //! return object as soon as the query is executed.
    //! The return value is then processed in ProcessQueryCallback methods.
    //! Any prepared statements added to this holder need to be prepared with the CONNECTION_ASYNC flag.
    SQLQueryHolderCallback DelayQueryHolder(SQLQueryHolder holder);

    /**
        Transaction context methods.
    */

    //! Begins an automanaged transaction pointer that will automatically rollback if not commited. (Autocommit=0)
    SQLTransaction BeginTransaction();

    //! Enqueues a collection of one-way SQL operations (can be both adhoc and prepared). The order in which these operations
    //! were appended to the transaction will be respected during execution.
    void CommitTransaction(SQLTransaction transaction);

    //! Enqueues a collection of one-way SQL operations (can be both adhoc and prepared). The order in which these operations
    //! were appended to the transaction will be respected during execution.
    TransactionCallback AsyncCommitTransaction(SQLTransaction transaction);

    //! Directly executes a collection of one-way SQL operations (can be both adhoc and prepared). The order in which these operations
    //! were appended to the transaction will be respected during execution.
    void DirectCommitTransaction(SQLTransaction transaction);

    //! Method used to execute ad-hoc statements in a diverse context.
    //! Will be wrapped in a transaction if valid object is present, otherwise executed standalone.
    void ExecuteOrAppend(SQLTransaction trans, std::string_view sql);

    //! Method used to execute prepared statements in a diverse context.
    //! Will be wrapped in a transaction if valid object is present, otherwise executed standalone.
    void ExecuteOrAppend(SQLTransaction trans, PreparedStatement stmt);

    /**
        Other
    */

    //! Auto managed (internally) pointer to a prepared statement object for usage in upper level code.
    //! Pointer is deleted in this->DirectExecute(PreparedStatementBase*), this->Query(PreparedStatementBase*) or PreparedStatementTask::~PreparedStatementTask.
    //! This object is not tied to the prepared statement on the MySQL context yet until execution.
    PreparedStatement GetPreparedStatement(uint32 index);

    void PrepareStatement(uint32 index, std::string_view sql, ConnectionFlags flags);

    // Close dynamic connections if need
    void CleanupConnections();

    //! Apply escape string'ing for current collation. (utf8)
    void EscapeString(std::string& str);

    //! Keeps all our MySQL connections alive, prevent the server from disconnecting us.
    void KeepAlive();

    void WarnAboutSyncQueries([[maybe_unused]] bool warn)
    {
#ifdef ACORE_DEBUG
        _warnSyncQueries = warn;
#endif
    }

    inline std::string_view GetPoolName() const { return _poolName; }
    inline void SetPoolName(std::string_view name) { _poolName = name; }

    inline DatabaseType GetType() const { return _poolType; }
    inline void SetType(DatabaseType type) { _poolType = type; }

    void Update(Milliseconds diff);
    [[nodiscard]] std::size_t GetQueueSize() const;

    void OpenDynamicAsyncConnect();
    void OpenDynamicSyncConnect();

    void GetPoolInfo(std::function<void(std::string_view)> const& info);

    inline std::string_view GetPathToExtraFile() { return _pathToExtraFile; }

    void CheckCleanup();
    void CheckAsyncQueue();

protected:
    inline void SetStatementSize(std::size_t statementSize) { _statementSize = statementSize; }
    inline std::size_t GetStatementSize() const { return _statementSize; }

    std::size_t _statementSize{};

private:
    std::pair<uint32, MySQLConnection*> OpenConnection(InternalIndex type, bool isDynamic = false);
    void InitPrepareStatement(MySQLConnection* connection);

    unsigned long EscapeString(char* to, char const* from, unsigned long length);
    void AddTasks();
    void MakeExtraFile();

    //! Gets a free connection in the synchronous connection pool.
    //! Caller MUST call t->Unlock() after touching the MySQL context to prevent deadlocks.
    MySQLConnection* GetFreeConnection();

    // Get using db name from connection info
    [[nodiscard]] std::string_view GetDatabaseName() const;

    std::unordered_map<uint32, StringPreparedStatement> _stringPreparedStatement;
    std::array<std::vector<std::unique_ptr<MySQLConnection>>, IDX_SIZE> _connections;
    std::unique_ptr<MySQLConnectionInfo> _connectionInfo;
    std::vector<uint8> _preparedStatementSize;
    std::mutex _openSyncConnectMutex;
    std::mutex _openAsyncConnectMutex;
    std::mutex _cleanupMutex;
    std::string _poolName;
    std::string _pathToExtraFile;
    DatabaseType _poolType{ DatabaseType::None };
    std::unique_ptr<TaskScheduler> _scheduler;

    // Async queue
    std::unique_ptr<ProducerConsumerQueue<AsyncOperation*>> _queue;
    std::unique_ptr<ProducerConsumerQueue<CheckAsyncQueueTask*>> _asyncQueueCheckQueue;
    std::unique_ptr<AsyncDBQueueChecker> _asyncQueueChecker;
    std::size_t _maxAsyncQueueSize{ 10 };

#ifdef ACORE_DEBUG
    static inline thread_local bool _warnSyncQueries = false;
#endif

    DatabaseWorkerPool(DatabaseWorkerPool const& right) = delete;
    DatabaseWorkerPool& operator=(DatabaseWorkerPool const& right) = delete;
};

#endif
