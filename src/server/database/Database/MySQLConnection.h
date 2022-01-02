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

#ifndef _MYSQLCONNECTION_H
#define _MYSQLCONNECTION_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

template <typename T>
class ProducerConsumerQueue;

class DatabaseWorker;
class MySQLPreparedStatement;
class SQLOperation;

enum ConnectionFlags
{
    CONNECTION_ASYNC = 0x1,
    CONNECTION_SYNCH = 0x2,
    CONNECTION_BOTH = CONNECTION_ASYNC | CONNECTION_SYNCH
};

struct AC_DATABASE_API MySQLConnectionInfo
{
    explicit MySQLConnectionInfo(std::string const& infoString);

    std::string user;
    std::string password;
    std::string database;
    std::string host;
    std::string port_or_socket;
    std::string ssl;
};

class AC_DATABASE_API MySQLConnection
{
template <class T> friend class DatabaseWorkerPool;
friend class PingOperation;

public:
    MySQLConnection(MySQLConnectionInfo& connInfo);                               //! Constructor for synchronous connections.
    MySQLConnection(ProducerConsumerQueue<SQLOperation*>* queue, MySQLConnectionInfo& connInfo);  //! Constructor for asynchronous connections.
    virtual ~MySQLConnection();

    virtual auto Open() -> uint32;
    void Close();

    auto PrepareStatements() -> bool;

    auto Execute(char const* sql) -> bool;
    auto Execute(PreparedStatementBase* stmt) -> bool;
    auto Query(char const* sql) -> ResultSet*;
    auto Query(PreparedStatementBase* stmt) -> PreparedResultSet*;
    auto _Query(char const* sql, MySQLResult** pResult, MySQLField** pFields, uint64* pRowCount, uint32* pFieldCount) -> bool;
    auto _Query(PreparedStatementBase* stmt, MySQLPreparedStatement** mysqlStmt, MySQLResult** pResult, uint64* pRowCount, uint32* pFieldCount) -> bool;

    void BeginTransaction();
    void RollbackTransaction();
    void CommitTransaction();
    auto ExecuteTransaction(std::shared_ptr<TransactionBase> transaction) -> int;
    auto EscapeString(char* to, const char* from, size_t length) -> size_t;
    void Ping();

    auto GetLastError() -> uint32;

protected:
    /// Tries to acquire lock. If lock is acquired by another thread
    /// the calling parent will just try another connection
    auto LockIfReady() -> bool;

    /// Called by parent databasepool. Will let other threads access this connection
    void Unlock();

    [[nodiscard]] auto GetServerVersion() const -> uint32;
    auto GetPreparedStatement(uint32 index) -> MySQLPreparedStatement*;
    void PrepareStatement(uint32 index, std::string const& sql, ConnectionFlags flags);

    virtual void DoPrepareStatements() = 0;

    typedef std::vector<std::unique_ptr<MySQLPreparedStatement>> PreparedStatementContainer;

    PreparedStatementContainer           m_stmts;         //! PreparedStatements storage
    bool                                 m_reconnecting;  //! Are we reconnecting?
    bool                                 m_prepareError;  //! Was there any error while preparing statements?

private:
    auto _HandleMySQLErrno(uint32 errNo, uint8 attempts = 5) -> bool;

    ProducerConsumerQueue<SQLOperation*>* m_queue;      //! Queue shared with other asynchronous connections.
    std::unique_ptr<DatabaseWorker> m_worker;           //! Core worker task.
    MySQLHandle*          m_Mysql;                      //! MySQL Handle.
    MySQLConnectionInfo&  m_connectionInfo;             //! Connection info (used for logging)
    ConnectionFlags       m_connectionFlags;            //! Connection flags (for preparing relevant statements)
    std::mutex            m_Mutex;

    MySQLConnection(MySQLConnection const& right) = delete;
    auto operator=(MySQLConnection const& right) -> MySQLConnection& = delete;
};

#endif
