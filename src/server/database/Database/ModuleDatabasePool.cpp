#include "ModuleDatabasePool.h"
#include "MySQLConnection.h"
#include "QueryResult.h"

ModuleDatabasePool::ModuleDatabasePool()
    : _connectionInfo(""), _asyncThreads(0), _synchThreads(0)
{
}

ModuleDatabasePool::~ModuleDatabasePool()
{
    Close();
}

void ModuleDatabasePool::SetConnectionInfo(std::string_view infoString, uint8 asyncThreads, uint8 synchThreads)
{
    _connectionInfo = MySQLConnectionInfo(infoString);
    _asyncThreads = asyncThreads;
    _synchThreads = synchThreads;
}

uint32 ModuleDatabasePool::Open()
{
    for (uint8 i = 0; i < _synchThreads; ++i)
    {
        auto conn = std::unique_ptr<MySQLConnection>(CreateConnection(_connectionInfo));
        uint32 result = conn->Open();
        if (result == 0)
        {
            conn->PrepareStatements();
            _connections.push_back(std::move(conn));
        }
    }

    return _connections.size();
}

void ModuleDatabasePool::Close()
{
    _connections.clear();
}

void ModuleDatabasePool::Execute(std::string const& sql)
{
    if (_connections.empty())
        return;

    MySQLConnection* conn = GetFreeConnection();
    conn->Execute(sql.c_str());
    conn->Unlock();
}

void ModuleDatabasePool::DirectExecute(std::string const& sql)
{
    if (_connections.empty())
        return;

    MySQLConnection* conn = GetFreeConnection();
    conn->Execute(sql.c_str());
    conn->Unlock();
}

QueryResult ModuleDatabasePool::Query(std::string const& sql)
{
    if (_connections.empty())
        return QueryResult(nullptr);

    MySQLConnection* conn = GetFreeConnection();
    ResultSet* result = conn->Query(sql.c_str());
    conn->Unlock();
    return QueryResult(result);
}

MySQLConnection* ModuleDatabasePool::GetFreeConnection()
{
    uint8 i = 0;
    auto const num_cons = _connections.size();
    MySQLConnection* connection = nullptr;

    //! Block forever until a connection is free
    for (;;)
    {
        connection = _connections[++i % num_cons].get();
        //! Must be matched with connection->Unlock() or you will get deadlocks
        if (connection->LockIfReady())
            break;
    }

    return connection;
}

MySQLConnectionInfo const* ModuleDatabasePool::GetConnectionInfo() const
{
    return &_connectionInfo;
}

