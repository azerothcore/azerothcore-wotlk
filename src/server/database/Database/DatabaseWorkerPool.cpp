/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DatabaseWorkerPool.h"
#include "DatabaseEnv.h"

#include <mysqld_error.h>

#define MIN_MYSQL_SERVER_VERSION 50700u
#define MIN_MYSQL_CLIENT_VERSION 50700u

template <class T> DatabaseWorkerPool<T>::DatabaseWorkerPool() :
    _mqueue(new ACE_Message_Queue<ACE_SYNCH>(2 * 1024 * 1024, 2 * 1024 * 1024)),
    _queue(new ACE_Activation_Queue(_mqueue)),
    _async_threads(0),
    _synch_threads(0)
{
    memset(_connectionCount, 0, sizeof(_connectionCount));
    _connections.resize(IDX_SIZE);

    WPFatal(mysql_thread_safe(), "Used MySQL library isn't thread-safe.");
    WPFatal(mysql_get_client_version() >= MIN_MYSQL_CLIENT_VERSION, "AzerothCore does not support MySQL versions below 5.7");
}

template <class T>
void DatabaseWorkerPool<T>::SetConnectionInfo(std::string const& infoString,
        uint8 const asyncThreads, uint8 const synchThreads)
{
    _connectionInfo = std::make_unique<MySQLConnectionInfo>(infoString);

    _async_threads = asyncThreads;
    _synch_threads = synchThreads;
}

template <class T>
uint32 DatabaseWorkerPool<T>::Open()
{
    WPFatal(_connectionInfo.get(), "Connection info was not set!");

    LOG_INFO("sql.driver", "Opening DatabasePool '%s'. Asynchronous connections: %u, synchronous connections: %u.",
        GetDatabaseName(), _async_threads, _synch_threads);

    uint32 error = OpenConnections(IDX_ASYNC, _async_threads);

    if (error)
    {
        return error;
    }

    error = OpenConnections(IDX_SYNCH, _synch_threads);

    if (!error)
    {
        LOG_INFO("sql.driver", "DatabasePool '%s' opened successfully. %u total connections running.",
            GetDatabaseName(), (_connectionCount[IDX_SYNCH] + _connectionCount[IDX_ASYNC]));
    }

    LOG_INFO("sql.driver", " ");

    return error;
}

template <class T>
void DatabaseWorkerPool<T>::Close()
{
    LOG_INFO("sql.driver", "Closing down DatabasePool '%s'.", GetDatabaseName());

    //! Shuts down delaythreads for this connection pool by underlying deactivate().
    //! The next dequeue attempt in the worker thread tasks will result in an error,
    //! ultimately ending the worker thread task.
    _queue->queue()->close();

    for (uint8 i = 0; i < _connectionCount[IDX_ASYNC]; ++i)
    {
        T* t = _connections[IDX_ASYNC][i];
        DatabaseWorker* worker = t->m_worker;
        worker->wait();     //! Block until no more threads are running this task.
        delete worker;
        t->Close();         //! Closes the actualy MySQL connection.
    }

    LOG_INFO("sql.driver", "Asynchronous connections on DatabasePool '%s' terminated. Proceeding with synchronous connections.",
        GetDatabaseName());

    //! Shut down the synchronous connections
    //! There's no need for locking the connection, because DatabaseWorkerPool<>::Close
    //! should only be called after any other thread tasks in the core have exited,
    //! meaning there can be no concurrent access at this point.
    for (uint8 i = 0; i < _connectionCount[IDX_SYNCH]; ++i)
        _connections[IDX_SYNCH][i]->Close();

    //! Deletes the ACE_Activation_Queue object and its underlying ACE_Message_Queue
    delete _queue;
    delete _mqueue;

    LOG_INFO("sql.driver", "All connections on DatabasePool '%s' closed.", GetDatabaseName());
}

template <class T>
uint32 DatabaseWorkerPool<T>::OpenConnections(InternalIndex type, uint8 numConnections)
{
    _connections[type].resize(numConnections);
    for (uint8 i = 0; i < numConnections; ++i)
    {
        T* t;

        if (type == IDX_ASYNC)
        {
            t = new T(_queue, *_connectionInfo);
        }
        else if (type == IDX_SYNCH)
        {
            t = new T(*_connectionInfo);
        }
        else
        {
            ASSERT(false, "> Incorrect InternalIndex (%u)", static_cast<uint32>(type));
        }

        _connections[type][i] = t;
        ++_connectionCount[type];

        uint32 error = t->Open();

        if (!error)
        {
            if (mysql_get_server_version(t->GetHandle()) < MIN_MYSQL_SERVER_VERSION)
            {
                LOG_ERROR("sql.driver", "Not support MySQL versions below 5.7");
                error = 1;
            }
        }

        // Failed to open a connection or invalid version, abort and cleanup
        if (error)
        {
            while (_connectionCount[type] != 0)
            {
                T* t = _connections[type][i--];
                delete t;
                --_connectionCount[type];
            }

            return error;
        }
    }

    // Everything is fine
    return 0;
}

template <class T>
bool DatabaseWorkerPool<T>::PrepareStatements()
{
    for (uint8 i = 0; i < IDX_SIZE; ++i)
    {
        for (uint32 c = 0; c < _connectionCount[i]; ++c)
        {
            T* t = _connections[i][c];
            t->LockIfReady();

            if (!t->PrepareStatements())
            {
                t->Unlock();
                Close();
                return false;
            }
            else
            {
                t->Unlock();
            }
        }
    }

    return true;
}

template <class T>
char const* DatabaseWorkerPool<T>::GetDatabaseName() const
{
    return _connectionInfo->database.c_str();
}

template <class T>
void DatabaseWorkerPool<T>::Execute(const char* sql)
{
    if (!sql)
        return;

    BasicStatementTask* task = new BasicStatementTask(sql);
    Enqueue(task);
}

template <class T>
void DatabaseWorkerPool<T>::Execute(PreparedStatement* stmt)
{
    PreparedStatementTask* task = new PreparedStatementTask(stmt);
    Enqueue(task);
}

template <class T>
void DatabaseWorkerPool<T>::DirectExecute(const char* sql)
{
    if (!sql)
        return;

    T* t = GetFreeConnection();
    t->Execute(sql);
    t->Unlock();
}

template <class T>
void DatabaseWorkerPool<T>::DirectExecute(PreparedStatement* stmt)
{
    T* t = GetFreeConnection();
    t->Execute(stmt);
    t->Unlock();

    //! Delete proxy-class. Not needed anymore
    delete stmt;
}

template <class T>
QueryResult DatabaseWorkerPool<T>::Query(const char* sql, T* conn /* = nullptr*/)
{
    if (!conn)
        conn = GetFreeConnection();

    ResultSet* result = conn->Query(sql);
    conn->Unlock();
    if (!result || !result->GetRowCount())
    {
        delete result;
        return QueryResult(nullptr);
    }

    result->NextRow();
    return QueryResult(result);
}

template <class T>
PreparedQueryResult DatabaseWorkerPool<T>::Query(PreparedStatement* stmt)
{
    T* t = GetFreeConnection();
    PreparedResultSet* ret = t->Query(stmt);
    t->Unlock();

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
QueryResultFuture DatabaseWorkerPool<T>::AsyncQuery(const char* sql)
{
    QueryResultFuture res;
    BasicStatementTask* task = new BasicStatementTask(sql, res);
    Enqueue(task);
    return res;         //! Actual return value has no use yet
}

template <class T>
PreparedQueryResultFuture DatabaseWorkerPool<T>::AsyncQuery(PreparedStatement* stmt)
{
    PreparedQueryResultFuture res;
    PreparedStatementTask* task = new PreparedStatementTask(stmt, res);
    Enqueue(task);
    return res;
}

template <class T>
QueryResultHolderFuture DatabaseWorkerPool<T>::DelayQueryHolder(SQLQueryHolder* holder)
{
    QueryResultHolderFuture res;
    SQLQueryHolderTask* task = new SQLQueryHolderTask(holder, res);
    Enqueue(task);
    return res;     //! Fool compiler, has no use yet
}

template <class T>
SQLTransaction DatabaseWorkerPool<T>::BeginTransaction()
{
    return SQLTransaction(new Transaction);
}

template <class T>
void DatabaseWorkerPool<T>::CommitTransaction(SQLTransaction transaction)
{
#ifdef ACORE_DEBUG
    //! Only analyze transaction weaknesses in Debug mode.
    //! Ideally we catch the faults in Debug mode and then correct them,
    //! so there's no need to waste these CPU cycles in Release mode.
    switch (transaction->GetSize())
    {
        case 0:
            LOG_INFO("sql.driver", "Transaction contains 0 queries. Not executing.");
            return;
        case 1:
            LOG_INFO("sql.driver", "Warning: Transaction only holds 1 query, consider removing Transaction context in code.");
            break;
        default:
            break;
    }
#endif // ACORE_DEBUG

    Enqueue(new TransactionTask(transaction));
}

template <class T>
void DatabaseWorkerPool<T>::DirectCommitTransaction(SQLTransaction& transaction)
{
    T* con = GetFreeConnection();
    int errorCode = con->ExecuteTransaction(transaction);
    if (!errorCode)
    {
        con->Unlock();      // OK, operation succesful
        return;
    }

    //! Handle MySQL Errno 1213 without extending deadlock to the core itself
    //! TODO: More elegant way
    if (errorCode == ER_LOCK_DEADLOCK)
    {
        uint8 loopBreaker = 5;
        for (uint8 i = 0; i < loopBreaker; ++i)
        {
            if (!con->ExecuteTransaction(transaction))
                break;
        }
    }

    //! Clean up now.
    transaction->Cleanup();

    con->Unlock();
}

template <class T>
void DatabaseWorkerPool<T>::ExecuteOrAppend(SQLTransaction& trans, PreparedStatement* stmt)
{
    if (!trans)
        Execute(stmt);
    else
        trans->Append(stmt);
}

template <class T>
void DatabaseWorkerPool<T>::ExecuteOrAppend(SQLTransaction& trans, const char* sql)
{
    if (!trans)
        Execute(sql);
    else
        trans->Append(sql);
}

template <class T>
PreparedStatement* DatabaseWorkerPool<T>::GetPreparedStatement(uint32 index)
{
    return new PreparedStatement(index);
}

template <class T>
void DatabaseWorkerPool<T>::KeepAlive()
{
    //! Ping synchronous connections
    for (uint8 i = 0; i < _connectionCount[IDX_SYNCH]; ++i)
    {
        T* t = _connections[IDX_SYNCH][i];
        if (t->LockIfReady())
        {
            t->Ping();
            t->Unlock();
        }
    }

    //! Assuming all worker threads are free, every worker thread will receive 1 ping operation request
    //! If one or more worker threads are busy, the ping operations will not be split evenly, but this doesn't matter
    //! as the sole purpose is to prevent connections from idling.
    for (size_t i = 0; i < _connections[IDX_ASYNC].size(); ++i)
        Enqueue(new PingOperation);
}

template <class T>
T* DatabaseWorkerPool<T>::GetFreeConnection()
{
    uint8 i = 0;
    size_t num_cons = _connectionCount[IDX_SYNCH];
    T* t = nullptr;

    //! Block forever until a connection is free
    for (;;)
    {
        t = _connections[IDX_SYNCH][++i % num_cons];
        //! Must be matched with t->Unlock() or you will get deadlocks
        if (t->LockIfReady())
            break;
    }

    return t;
}

template class DatabaseWorkerPool<LoginDatabaseConnection>;
template class DatabaseWorkerPool<WorldDatabaseConnection>;
template class DatabaseWorkerPool<CharacterDatabaseConnection>;
