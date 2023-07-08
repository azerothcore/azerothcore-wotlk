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

#ifndef _WH_MYSQL_CONNECTION_H_
#define _WH_MYSQL_CONNECTION_H_

#include "DatabaseEnvFwd.h"
#include "Duration.h"
#include <mutex>
#include <string>
#include <string_view>
#include <thread>
#include <vector>

template <typename T>
class ProducerConsumerQueue;

class AsyncOperation;
class AsyncDBQueueWorker;

using PreparedStatementList = std::vector<std::unique_ptr<MySQLPreparedStatement>>;

struct AC_DATABASE_API MySQLConnectionInfo
{
    explicit MySQLConnectionInfo(std::string_view infoString);

    std::string User;
    std::string Password;
    std::string Database;
    std::string Host;
    std::string PortOrSocket;
    std::string SSL;
};

class AC_DATABASE_API MySQLConnection
{
public:
    MySQLConnection(MySQLConnectionInfo& connInfo, ProducerConsumerQueue<AsyncOperation*>* dbQueue, bool isDynamic = false);
    virtual ~MySQLConnection();

    virtual uint32 Open();
    void Close();

    [[nodiscard]] bool PrepareStatements() const;

    bool Execute(std::string_view sql);
    bool Execute(PreparedStatement stmt);

    QueryResult Query(std::string_view sql);
    PreparedQueryResult Query(PreparedStatement stmt);

    MySQLPreparedStatement* GetPreparedStatement(uint32 index);
    void PrepareStatement(uint32 index, std::string_view sql, ConnectionFlags flags);

    inline PreparedStatementList* GetPreparedStatementList() { return &_stmtList; }

    void BeginTransaction();
    void RollbackTransaction();
    void CommitTransaction();
    int32 ExecuteTransaction(SQLTransaction transaction);
    std::size_t EscapeString(char* to, const char* from, std::size_t length);
    void Ping();

    int32 GetLastError();

    /// Tries to acquire lock. If lock is acquired by another thread
    /// the calling parent will just try another connection
    inline bool LockIfReady() { return _mutex.try_lock(); }

    /// Called by parent database pool. Will let other threads access this connection
    inline void Unlock() { return _mutex.unlock(); }

    static std::string_view GetClientInfo();
    std::string_view GetServerInfo();
    [[nodiscard]] uint32 GetServerVersion() const;

    [[nodiscard]] inline bool IsDynamic() const { return _isDynamic; }
    [[nodiscard]] bool CanRemoveConnection();
    [[nodiscard]] std::size_t GetQueueSize() const;

protected:
    virtual bool HandleMySQLError(uint32 errNo, uint8 attempts = 5);

    MySQLHandle* _mysqlHandle{ nullptr };

private:
    bool Query(std::string_view sql, MySQLResult** result, MySQLField** fields, uint64* rowCount, uint32* fieldCount);
    bool Query(PreparedStatement stmt, MySQLPreparedStatement** mysqlStmt, MySQLResult** pResult, uint64* pRowCount, uint32* pFieldCount);
    inline void UpdateLastUseTime() { _lastUseTime = std::chrono::system_clock::now(); }

    MySQLConnectionInfo& _connectionInfo;
    ConnectionFlags _connectionFlags{ ConnectionFlags::Sync };
    PreparedStatementList _stmtList;
    std::mutex _mutex;
    bool _isDynamic{};
    bool _prepareError{}; //! Was there any error while preparing statements?
    SystemTimePoint _lastUseTime;
    ProducerConsumerQueue<AsyncOperation*>* _queue{ nullptr };
    std::unique_ptr<AsyncDBQueueWorker> _asyncQueueWorker;

    MySQLConnection(MySQLConnection const& right) = delete;
    MySQLConnection& operator=(MySQLConnection const& right) = delete;
};

#endif
