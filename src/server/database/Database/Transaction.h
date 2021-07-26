/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _TRANSACTION_H
#define _TRANSACTION_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include "SQLOperation.h"
#include "StringFormat.h"
#include <functional>
#include <mutex>
#include <vector>

/*! Transactions, high level class. */
class AC_DATABASE_API TransactionBase
{
friend class TransactionTask;
friend class MySQLConnection;

template <typename T>
friend class DatabaseWorkerPool;

public:
    TransactionBase() : _cleanedUp(false) { }
    virtual ~TransactionBase() { Cleanup(); }

    void Append(char const* sql);
    template<typename Format, typename... Args>
    void PAppend(Format&& sql, Args&&... args)
    {
        Append(Acore::StringFormat(std::forward<Format>(sql), std::forward<Args>(args)...).c_str());
    }

    std::size_t GetSize() const { return m_queries.size(); }

protected:
    void AppendPreparedStatement(PreparedStatementBase* statement);
    void Cleanup();
    std::vector<SQLElementData> m_queries;

private:
    bool _cleanedUp;
};

template<typename T>
class Transaction : public TransactionBase
{
public:
    using TransactionBase::Append;
    void Append(PreparedStatement<T>* statement)
    {
        AppendPreparedStatement(statement);
    }
};

/*! Low level class*/
class AC_DATABASE_API TransactionTask : public SQLOperation
{
template <class T> friend class DatabaseWorkerPool;
friend class DatabaseWorker;
friend class TransactionCallback;

public:
    TransactionTask(std::shared_ptr<TransactionBase> trans) : m_trans(trans) { }
    ~TransactionTask() { }

protected:
    bool Execute() override;
    int TryExecute();
    void CleanupOnFailure();

    std::shared_ptr<TransactionBase> m_trans;
    static std::mutex _deadlockLock;
};

class AC_DATABASE_API TransactionWithResultTask : public TransactionTask
{
public:
    TransactionWithResultTask(std::shared_ptr<TransactionBase> trans) : TransactionTask(trans) { }

    TransactionFuture GetFuture() { return m_result.get_future(); }

protected:
    bool Execute() override;

    TransactionPromise m_result;
};

class AC_DATABASE_API TransactionCallback
{
public:
    TransactionCallback(TransactionFuture&& future) : m_future(std::move(future)) { }
    TransactionCallback(TransactionCallback&&) = default;

    TransactionCallback& operator=(TransactionCallback&&) = default;

    void AfterComplete(std::function<void(bool)> callback) &
    {
        m_callback = std::move(callback);
    }

    bool InvokeIfReady();

    TransactionFuture m_future;
    std::function<void(bool)> m_callback;
};

#endif
