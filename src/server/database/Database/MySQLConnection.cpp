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

#include "MySQLConnection.h"
#include "DatabaseAsyncOperation.h"
#include "DatabaseAsyncQueueWorker.h"
#include "Errors.h"
#include "Log.h"
#include "MySQLHacks.h"
#include "MySQLPreparedStatement.h"
#include "PCQueue.h"
#include "PreparedStatement.h"
#include "QueryResult.h"
#include "StopWatch.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Transaction.h"
#include <errmsg.h>
#include <mysql.h>
#include <mysqld_error.h>
#include <utility>

namespace
{
    constexpr auto DB_DEFAULT_CHARSET = "utf8mb4";
    constexpr auto DYNAMIC_CONNECTION_TIMEOUT = 1s;

    std::string GetConnectionFlagString(ConnectionFlags flag)
    {
        switch (flag)
        {
            case ConnectionFlags::Async: return "Async";
            case ConnectionFlags::Sync: return "Sync";
            case ConnectionFlags::Both: return "Both";
            default: return "Unknown";
        }
    }
}

MySQLConnectionInfo::MySQLConnectionInfo(std::string_view infoString)
{
    std::vector<std::string_view> tokens = Acore::Tokenize(infoString, ';', true);

    if (tokens.size() != 5 && tokens.size() != 6)
        return;

    Host.assign(tokens.at(0));
    PortOrSocket.assign(tokens.at(1));
    User.assign(tokens.at(2));
    Password.assign(tokens.at(3));
    Database.assign(tokens.at(4));

    if (tokens.size() == 6)
        SSL.assign(tokens.at(5));
}

MySQLConnection::MySQLConnection(MySQLConnectionInfo& connInfo, ProducerConsumerQueue<AsyncOperation*>* dbQueue, bool isDynamic /*= false*/) :
    _connectionInfo(connInfo),
    _connectionFlags(dbQueue ? ConnectionFlags::Async : ConnectionFlags::Sync),
    _isDynamic(isDynamic),
    _queue(dbQueue)
{
    if (_queue)
        _asyncQueueWorker = std::make_unique<AsyncDBQueueWorker>(_queue, this);

    UpdateLastUseTime();
}

MySQLConnection::~MySQLConnection()
{
    Close();
    LOG_DEBUG("db.connection", "> Close {} connection to '{}' db", GetConnectionFlagString(_connectionFlags), _connectionInfo.Database);
}

void MySQLConnection::Close()
{
    _asyncQueueWorker.reset();

    if (_mysqlHandle)
    {
        mysql_close(_mysqlHandle);
        _mysqlHandle = nullptr;
    }
}

uint32 MySQLConnection::Open()
{
    auto mysqlInit = mysql_init(nullptr);
    if (!mysqlInit)
    {
        LOG_ERROR("db.connection", "Could not initialize Mysql connection to database `{}`", _connectionInfo.Database);
        return CR_UNKNOWN_ERROR;
    }

    uint32 port{};
    char const* unix_socket{ nullptr };

    mysql_options(mysqlInit, MYSQL_SET_CHARSET_NAME, DB_DEFAULT_CHARSET);

    if (_connectionInfo.Host == ".")
    {
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
        unsigned int opt = MYSQL_PROTOCOL_PIPE;
#else
        unsigned int opt = MYSQL_PROTOCOL_SOCKET;
#endif
        mysql_options(mysqlInit, MYSQL_OPT_PROTOCOL, (char const*)&opt);

#if AC_PLATFORM != AC_PLATFORM_WINDOWS
        _connectionInfo.Host = "localhost";
        unix_socket = _connectionInfo.PortOrSocket.c_str();
#endif
    }
    else
        port = *Acore::StringTo<uint32>(_connectionInfo.PortOrSocket);

    if (!_connectionInfo.SSL.empty() && _connectionInfo.SSL == "ssl")
    {
#if !defined(MARIADB_VERSION_ID) && MYSQL_VERSION_ID >= 80000
        mysql_ssl_mode opt_use_ssl = SSL_MODE_DISABLED;
        mysql_options(mysqlInit, MYSQL_OPT_SSL_MODE, (char const*)&opt_use_ssl);
#else
        auto opt_use_ssl = MySQLBool(1);
        mysql_options(mysqlInit, MYSQL_OPT_SSL_ENFORCE, (char const*)&opt_use_ssl);
#endif
    }

    _mysqlHandle = reinterpret_cast<MySQLHandle*>(mysql_real_connect(mysqlInit, _connectionInfo.Host.c_str(), _connectionInfo.User.c_str(),
    _connectionInfo.Password.c_str(), _connectionInfo.Database.c_str(), port, unix_socket, 0));

    if (_mysqlHandle)
    {
        LOG_MESSAGE_BODY("db.connection", _isDynamic ? LOG_LEVEL_DEBUG : LOG_LEVEL_INFO, "Open new {} connect to {} DB at {}", GetConnectionFlagString(_connectionFlags), _connectionInfo.Database, _connectionInfo.Host);
        mysql_autocommit(_mysqlHandle, 1);

        // set connection properties to UTF8 to properly handle locales for different
        // server configs - core sends data in UTF8, so MySQL must expect UTF8 too
        mysql_set_character_set(_mysqlHandle, DB_DEFAULT_CHARSET);
        return 0;
    }
    else
    {
        uint32 errorCode = mysql_errno(mysqlInit);
        LOG_ERROR("db.connection", "[{}]: Could not connect to MySQL database {} at {}: {}", errorCode, _connectionInfo.Database, _connectionInfo.Host, mysql_error(mysqlInit));
        mysql_close(mysqlInit);
        return errorCode;
    }
}

bool MySQLConnection::Execute(std::string_view sql)
{
    if (!_mysqlHandle || sql.empty())
        return false;

    {
        StopWatch sw;

        if (mysql_query(_mysqlHandle, sql.data()))
        {
            uint32 err = mysql_errno(_mysqlHandle);

            LOG_ERROR("db.query", "[{}] {}", err, mysql_error(_mysqlHandle));
            LOG_ERROR("db.query", "Query: {}", sql);

            if (HandleMySQLError(err)) // If it returns true, an error was handled successfully (i.e. reconnection)
                return Execute(sql); // Try again

            return false;
        }
        else
            LOG_DEBUG("db.query", "[{}] Query: {}", sw, sql);
    }

    UpdateLastUseTime();
    return true;
}

bool MySQLConnection::Execute(PreparedStatement stmt)
{
    if (!_mysqlHandle || !stmt)
        return false;

    uint32 index = stmt->GetIndex();

    MySQLPreparedStatement* mStmt = GetPreparedStatement(index);
    ASSERT(mStmt); // Can only be null if preparation failed, server side error or bad query

    mStmt->BindParameters(stmt);

    MYSQL_STMT* msql_STMT = mStmt->GetSTMT();
    MYSQL_BIND* msql_BIND = mStmt->GetBind();

    StopWatch sw;

    if (mysql_stmt_bind_param(msql_STMT, msql_BIND))
    {
        uint32 err = mysql_errno(_mysqlHandle);
        LOG_ERROR("db.query", "[{}] {}", err, mysql_stmt_error(msql_STMT));
        LOG_ERROR("db.query", "Query(p): {}", mStmt->getQueryString());

        if (HandleMySQLError(err)) // If it returns true, an error was handled successfully (i.e. reconnection)
            return Execute(stmt); // Try again

        mStmt->ClearParameters();
        return false;
    }

    if (mysql_stmt_execute(msql_STMT))
    {
        uint32 err = mysql_errno(_mysqlHandle);
        LOG_ERROR("db.query", "[{}] {}", err, mysql_stmt_error(msql_STMT));
        LOG_ERROR("db.query", "Query(p): {}", mStmt->getQueryString());

        if (HandleMySQLError(err))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return Execute(stmt); // Try again

        mStmt->ClearParameters();
        return false;
    }

    LOG_DEBUG("db.query", "[{}] Query(p): {}", sw, mStmt->getQueryString());

    mStmt->ClearParameters();
    UpdateLastUseTime();
    return true;
}

QueryResult MySQLConnection::Query(std::string_view sql)
{
    if (sql.empty())
        return nullptr;

    MySQLResult* result = nullptr;
    MySQLField* fields = nullptr;
    uint64 rowCount = 0;
    uint32 fieldCount = 0;

    if (!Query(sql, &result, &fields, &rowCount, &fieldCount))
        return nullptr;

    UpdateLastUseTime();
    return std::make_shared<ResultSet>(result, fields, rowCount, fieldCount);
}

PreparedQueryResult MySQLConnection::Query(PreparedStatement stmt)
{
    MySQLPreparedStatement* mysqlStmt = nullptr;
    MySQLResult* result = nullptr;
    uint64 rowCount = 0;
    uint32 fieldCount = 0;

    if (!Query(std::move(stmt), &mysqlStmt, &result, &rowCount, &fieldCount))
        return nullptr;

    if (mysql_more_results(_mysqlHandle))
        mysql_next_result(_mysqlHandle);

    UpdateLastUseTime();
    return std::make_shared<PreparedResultSet>(mysqlStmt->GetSTMT(), result, rowCount, fieldCount);
}

bool MySQLConnection::Query(std::string_view sql, MySQLResult** result, MySQLField** fields, uint64* rowCount, uint32* fieldCount)
{
    if (!_mysqlHandle || sql.empty())
        return false;

    {
        StopWatch sw;

        if (mysql_query(_mysqlHandle, sql.data()))
        {
            uint32 err = mysql_errno(_mysqlHandle);
            LOG_ERROR("db.query", "[{}] {}", err, mysql_error(_mysqlHandle));
            LOG_ERROR("db.query", "Query: {}", sql);

            if (HandleMySQLError(err)) // If it returns true, an error was handled successfully (i.e. reconnection)
                return Query(sql, result, fields, rowCount, fieldCount);    // We try again

            return false;
        }
        else
            LOG_DEBUG("db.query", "[{}] Query: {}", sw, sql);

        *result = reinterpret_cast<MySQLResult*>(mysql_store_result(_mysqlHandle));
        *rowCount = mysql_affected_rows(_mysqlHandle);
        *fieldCount = mysql_field_count(_mysqlHandle);
    }

    if (!*result)
        return false;

    if (!*rowCount)
    {
        mysql_free_result(*result);
        return false;
    }

    *fields = reinterpret_cast<MySQLField*>(mysql_fetch_fields(*result));
    return true;
}

bool MySQLConnection::Query(PreparedStatement stmt, MySQLPreparedStatement** mysqlStmt, MySQLResult** result, uint64* rowCount, uint32* fieldCount)
{
    if (!_mysqlHandle)
        return false;

    uint32 index = stmt->GetIndex();

    MySQLPreparedStatement* mStmt = GetPreparedStatement(index);
    ASSERT(mStmt); // Can only be null if preparation failed, server side error or bad query

    mStmt->BindParameters(stmt);
    *mysqlStmt = mStmt;

    MYSQL_STMT* msql_STMT = mStmt->GetSTMT();
    MYSQL_BIND* msql_BIND = mStmt->GetBind();

    StopWatch sw;

    if (mysql_stmt_bind_param(msql_STMT, msql_BIND))
    {
        uint32 err = mysql_errno(_mysqlHandle);
        LOG_ERROR("db.query", "[{}] {}", err, mysql_stmt_error(msql_STMT));
        LOG_ERROR("db.query", "Query: {}", mStmt->getQueryString());

        if (HandleMySQLError(err))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return Query(stmt, mysqlStmt, result, rowCount, fieldCount); // Try again

        mStmt->ClearParameters();
        return false;
    }

    if (mysql_stmt_execute(msql_STMT))
    {
        uint32 err = mysql_errno(_mysqlHandle);
        LOG_ERROR("db.query", "[{}] {}", err, mysql_stmt_error(msql_STMT));
        LOG_ERROR("db.query", "Query: {}", mStmt->getQueryString());

        if (HandleMySQLError(err))  // If it returns true, an error was handled successfully (i.e. reconnection)
            return Query(stmt, mysqlStmt, result, rowCount, fieldCount); // Try again

        mStmt->ClearParameters();
        return false;
    }

    LOG_DEBUG("db.query", "[{}] Query(p): {}", sw, mStmt->getQueryString());

    mStmt->ClearParameters();

    *result = reinterpret_cast<MySQLResult*>(mysql_stmt_result_metadata(msql_STMT));
    *rowCount = mysql_stmt_num_rows(msql_STMT);
    *fieldCount = mysql_stmt_field_count(msql_STMT);
    return true;
}

/*static*/ std::string_view MySQLConnection::GetClientInfo()
{
    return { mysql_get_client_info() };
}

std::string_view MySQLConnection::GetServerInfo()
{
    return { mysql_get_server_info(_mysqlHandle) };
}

bool MySQLConnection::HandleMySQLError(uint32 errNo, uint8 attempts /*= 5*/)
{
    switch (errNo)
    {
        case CR_SERVER_GONE_ERROR:
        case CR_SERVER_LOST:
        case CR_SERVER_LOST_EXTENDED:
        {
            if (_mysqlHandle)
            {
                LOG_ERROR("db.connection", "Lost the connection to the MySQL server!");

                mysql_close(_mysqlHandle);
                _mysqlHandle = nullptr;
            }
            [[fallthrough]];
        }
        case CR_CONN_HOST_ERROR:
        {
            LOG_INFO("db.connection", "Attempting to reconnect to the MySQL server...");

            uint32 const lErrno = Open();
            if (!lErrno)
            {
                if (!this->PrepareStatements())
                {
                    LOG_FATAL("db.connection", "Could not re-prepare statements!");
                    ABORT("Could not re-prepare statements!");
                }

                LOG_INFO("db.connection", "Successfully reconnected to {} @{}:{} Connection flags: {}.",
                    _connectionInfo.Database, _connectionInfo.Host, _connectionInfo.PortOrSocket, (uint8)_connectionFlags);

                return true;
            }

            if ((--attempts) == 0)
            {
                // Shut down the server when the mysql server isn't
                // reachable for some time
                LOG_FATAL("db.connection", "Failed to reconnect to the MySQL server, terminating the server to prevent data corruption!");

                // We could also initiate a shutdown through using std::raise(SIGTERM)
                ABORT("Failed to reconnect to the MySQL server, terminating the server to prevent data corruption!");
            }
            else
            {
                // It's possible this attempted to reconnect throws 2006 at us.
                // To prevent crazy recursive calls, sleep here.
                std::this_thread::sleep_for(3s); // Sleep 3 seconds
                return HandleMySQLError(lErrno, attempts); // Call self (recursive)
            }
        }

        case ER_LOCK_DEADLOCK: // Implemented in TransactionTask::Execute and DatabaseWorkerPool<T>::DirectCommitTransaction
        case ER_WRONG_VALUE_COUNT: // Query related errors - skip query
        case ER_DUP_ENTRY:
            return false;

            // Outdated table or database structure - terminate core
        case ER_BAD_FIELD_ERROR:
        case ER_NO_SUCH_TABLE:
            LOG_ERROR("db.connection", "Your database structure is not up to date. Please make sure you've executed all queries in the sql/updates folders.");
            ABORT("Your database structure is not up to date. Please make sure you've executed all queries in the sql/updates folders.");
            return false;

        case ER_PARSE_ERROR:
            LOG_ERROR("db.connection", "Error while parsing SQL. Core fix required.");
            ABORT("Error while parsing SQL. Core fix required.");
            return false;
        default:
            LOG_ERROR("db.connection", "Unhandled MySQL errno {}. Unexpected behaviour possible.", errNo);
            return false;
    }
}

bool MySQLConnection::PrepareStatements() const
{
    return !_prepareError;
}

MySQLPreparedStatement* MySQLConnection::GetPreparedStatement(uint32 index)
{
    ASSERT(index < _stmtList.size(), "Tried to access invalid prepared statement index {} (max index {}) on database `{}`, connection type: {}",
       index, _stmtList.size(), _connectionInfo.Database, GetConnectionFlagString(_connectionFlags));

    MySQLPreparedStatement* ret = _stmtList[index].get();

    if (!ret)
        LOG_ERROR("db.connection", "Could not fetch prepared statement {} on database `{}`, connection type: {}.",
            index, _connectionInfo.Database, GetConnectionFlagString(_connectionFlags));

    return ret;
}

void MySQLConnection::PrepareStatement(uint32 index, std::string_view sql, ConnectionFlags flags)
{
    // Check if specified query should be prepared on this connection
    // i.e. don't prepare async statements on synchronous connections
    // to save memory that will not be used.
    if (!((uint8)_connectionFlags & (uint8)flags))
    {
        _stmtList[index].reset();
        return;
    }

    MYSQL_STMT* stmt = mysql_stmt_init(_mysqlHandle);
    if (!stmt)
    {
        LOG_ERROR("db.connection", "In mysql_stmt_init() id: {}, sql: \"{}\"", index, sql);
        LOG_ERROR("db.connection", "{}", mysql_error(_mysqlHandle));
        _prepareError = true;
    }
    else
    {
        if (mysql_stmt_prepare(stmt, sql.data(), static_cast<unsigned long>(sql.size())))
        {
            LOG_ERROR("db.connection", "In mysql_stmt_prepare() id: {}, sql: \"{}\"", index, sql);
            LOG_ERROR("db.connection", "{}", mysql_stmt_error(stmt));
            mysql_stmt_close(stmt);
            _prepareError = true;
        }
        else
            _stmtList[index] = std::make_unique<MySQLPreparedStatement>(reinterpret_cast<MySQLStmt*>(stmt), sql);
    }
}

void MySQLConnection::BeginTransaction()
{
    Execute("START TRANSACTION");
}

void MySQLConnection::RollbackTransaction()
{
    Execute("ROLLBACK");
}

void MySQLConnection::CommitTransaction()
{
    Execute("COMMIT");
}

int32 MySQLConnection::ExecuteTransaction(SQLTransaction transaction)
{
    auto const& queries = transaction->GetQueries();
    if (queries->empty())
        return -1;

    BeginTransaction();

    for (auto const& data : *queries)
    {
        switch (data.type)
        {
            case SQL_ELEMENT_PREPARED:
            {
                PreparedStatement stmt;

                try
                {
                    stmt = std::get<PreparedStatement>(data.element);
                }
                catch (const std::bad_variant_access& ex)
                {
                    LOG_FATAL("db.query", "> PreparedStatementBase not found in SQLElementData. {}", ex.what());
                    ABORT("> PreparedStatementBase not found in SQLElementData. {}", ex.what());
                }

                ASSERT(stmt);

                if (!Execute(stmt))
                {
                    LOG_WARN("db.query", "Transaction aborted. {} queries not executed.", queries->size());
                    int32 errorCode = GetLastError();
                    RollbackTransaction();
                    return errorCode;
                }
            }
            break;
            case SQL_ELEMENT_RAW:
            {
                std::string sql;

                try
                {
                    sql = std::get<std::string>(data.element);
                }
                catch (const std::bad_variant_access& ex)
                {
                    LOG_FATAL("db.query", "> std::string not found in SQLElementData. {}", ex.what());
                    ABORT("> std::string not found in SQLElementData. {}", ex.what());
                }

                ASSERT(!sql.empty());

                if (!Execute(sql))
                {
                    LOG_WARN("db.query", "Transaction aborted. {} queries not executed.", queries->size());
                    int32 errorCode = GetLastError();
                    RollbackTransaction();
                    return errorCode;
                }
            }
            break;
        }
    }

    // we might encounter errors during certain queries, and depending on the kind of error
    // we might want to restart the transaction. So to prevent data loss, we only clean up when it's all done.
    // This is done in calling functions DatabaseWorkerPool<T>::DirectCommitTransaction and TransactionTask::Execute,
    // and not while iterating over every element.
    CommitTransaction();
    return 0;
}

std::size_t MySQLConnection::EscapeString(char* to, const char* from, std::size_t length)
{
    return mysql_real_escape_string(_mysqlHandle, to, from, length);
}

void MySQLConnection::Ping()
{
    mysql_ping(_mysqlHandle);
}

int32 MySQLConnection::GetLastError()
{
    return mysql_errno(_mysqlHandle);
}

uint32 MySQLConnection::GetServerVersion() const
{
    return mysql_get_server_version(_mysqlHandle);
}

bool MySQLConnection::CanRemoveConnection()
{
    if (!IsDynamic())
        return false;

    Milliseconds diff = std::chrono::duration_cast<Milliseconds>(std::chrono::system_clock::now() - _lastUseTime);
    return diff >= DYNAMIC_CONNECTION_TIMEOUT;
}

std::size_t MySQLConnection::GetQueueSize() const
{
    if (!_queue)
        return 0;

    return _queue->Size();
}
