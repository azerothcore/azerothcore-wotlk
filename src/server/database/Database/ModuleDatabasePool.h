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

#ifndef MODULE_DATABASE_POOL_H
#define MODULE_DATABASE_POOL_H

#include "DatabaseEnvFwd.h"
#include "DatabaseUpdatePool.h"
#include "Define.h"
#include "MySQLConnection.h"
#include "PreparedStatement.h"
#include "StringFormat.h"
#include <array>
#include <memory>
#include <string_view>
#include <vector>

template <typename T>
class ProducerConsumerQueue;

class SQLOperation;
class TransactionBase;

// Base class for module-owned database pools: a module implements CreateConnection
// with its own MySQLConnection subclass and gets the DatabaseWorkerPool API plus
// DBUpdater compatibility. Statement flags route like the core pools (async entry
// points need CONNECTION_ASYNC, direct ones CONNECTION_SYNCH). With no asynchronous
// connections every async entry point runs synchronously.
class AC_DATABASE_API ModuleDatabasePool : public DatabaseUpdatePool
{
private:
    enum InternalIndex
    {
        IDX_ASYNC,
        IDX_SYNCH,
        IDX_SIZE
    };

public:
    ModuleDatabasePool();
    virtual ~ModuleDatabasePool();

    //! Synchronous-only configuration.
    void SetConnectionInfo(std::string_view infoString, uint8 synchThreads);

    //! Same argument order as DatabaseWorkerPool; async threads need the queue-taking CreateConnection.
    void SetConnectionInfo(std::string_view infoString, uint8 asyncThreads, uint8 synchThreads);

    //! Returns 0 on success, or the MySQL error code of the first failed connection.
    uint32 Open();

    //! Prepares the connection statements. Call after the schema exists
    //! (post create/populate/update), mirroring DatabaseLoader's ordering.
    bool PrepareStatements();

    void Close();

    void Execute(std::string_view sql);
    void DirectExecute(std::string_view sql) override;
    QueryResult Query(std::string_view sql) override;
    MySQLConnectionInfo const* GetConnectionInfo() const override;

    //! Format variants, mirroring DatabaseWorkerPool.
    template<typename... Args>
    void Execute(std::string_view sql, Args&&... args)
    {
        if (sql.empty())
            return;

        Execute(std::string_view(Acore::StringFormat(sql, std::forward<Args>(args)...)));
    }

    template<typename... Args>
    void DirectExecute(std::string_view sql, Args&&... args)
    {
        if (sql.empty())
            return;

        DirectExecute(std::string_view(Acore::StringFormat(sql, std::forward<Args>(args)...)));
    }

    template<typename... Args>
    QueryResult Query(std::string_view sql, Args&&... args)
    {
        if (sql.empty())
            return QueryResult(nullptr);

        return Query(std::string_view(Acore::StringFormat(sql, std::forward<Args>(args)...)));
    }

    //! All of these consume (delete) the statement, mirroring DatabaseWorkerPool.
    void Execute(PreparedStatementBase* stmt);
    void DirectExecute(PreparedStatementBase* stmt);
    PreparedQueryResult Query(PreparedStatementBase* stmt);

    QueryCallback AsyncQuery(std::string_view sql);
    QueryCallback AsyncQuery(PreparedStatementBase* stmt);

    template<typename... Args>
    QueryCallback AsyncQuery(std::string_view sql, Args&&... args)
    {
        return AsyncQuery(std::string_view(Acore::StringFormat(sql, std::forward<Args>(args)...)));
    }

    SQLQueryHolderCallback DelayQueryHolder(std::shared_ptr<SQLQueryHolderBase> holder);

    //! Parameter count of a prepared statement, recorded by PrepareStatements().
    [[nodiscard]] uint8 GetPreparedStatementParamCount(uint32 index) const;

    void CommitTransaction(std::shared_ptr<TransactionBase> transaction);
    TransactionCallback AsyncCommitTransaction(std::shared_ptr<TransactionBase> transaction);
    void DirectCommitTransaction(std::shared_ptr<TransactionBase> transaction);

    void KeepAlive();
    [[nodiscard]] std::size_t QueueSize() const;

    //! Debug builds only: logs a stack trace for every synchronous query of the calling thread.
    void WarnAboutSyncQueries(bool warn);

protected:
    virtual MySQLConnection* CreateConnection(MySQLConnectionInfo& connInfo) = 0;

    //! Asynchronous connection factory; the default returns nullptr and Open() fails.
    virtual MySQLConnection* CreateConnection(ProducerConsumerQueue<SQLOperation*>* queue,
        MySQLConnectionInfo& connInfo);

private:
    uint32 OpenConnections(InternalIndex type, uint8 numConnections);

    void Enqueue(SQLOperation* op);

    //! Caller must Unlock() the returned synchronous connection.
    MySQLConnection* GetFreeConnection();

    MySQLConnectionInfo _connectionInfo;
    std::unique_ptr<ProducerConsumerQueue<SQLOperation*>> _queue;
    std::array<std::vector<std::unique_ptr<MySQLConnection>>, IDX_SIZE> _connections;
    std::vector<uint8> _preparedStatementSize;
    uint8 _asyncThreads;
    uint8 _synchThreads;
};

#endif
