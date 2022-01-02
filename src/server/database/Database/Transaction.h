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

#ifndef _TRANSACTION_H
#define _TRANSACTION_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include "SQLOperation.h"
#include "StringFormat.h"
#include <functional>
#include <mutex>
#include <utility>
#include <vector>

/*! Transactions, high level class. */
class AC_DATABASE_API TransactionBase
{
friend class TransactionTask;
friend class MySQLConnection;

template <typename T>
friend class DatabaseWorkerPool;

public:
    TransactionBase()  = default;
    virtual ~TransactionBase() { Cleanup(); }

    void Append(char const* sql);
    template<typename Format, typename... Args>
    void PAppend(Format&& sql, Args&&... args)
    {
        Append(Acore::StringFormat(std::forward<Format>(sql), std::forward<Args>(args)...).c_str());
    }

    [[nodiscard]] auto GetSize() const -> std::size_t { return m_queries.size(); }

protected:
    void AppendPreparedStatement(PreparedStatementBase* statement);
    void Cleanup();
    std::vector<SQLElementData> m_queries;

private:
    bool _cleanedUp{false};
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
    TransactionTask(std::shared_ptr<TransactionBase> trans) : m_trans(std::move(trans)) { }
    ~TransactionTask() override = default;

protected:
    auto Execute() -> bool override;
    auto TryExecute() -> int;
    void CleanupOnFailure();

    std::shared_ptr<TransactionBase> m_trans;
    static std::mutex _deadlockLock;
};

class AC_DATABASE_API TransactionWithResultTask : public TransactionTask
{
public:
    TransactionWithResultTask(std::shared_ptr<TransactionBase> trans) : TransactionTask(trans) { }

    auto GetFuture() -> TransactionFuture { return m_result.get_future(); }

protected:
    auto Execute() -> bool override;

    TransactionPromise m_result;
};

class AC_DATABASE_API TransactionCallback
{
public:
    TransactionCallback(TransactionFuture&& future) : m_future(std::move(future)) { }
    TransactionCallback(TransactionCallback&&) = default;

    auto operator=(TransactionCallback&&) -> TransactionCallback& = default;

    void AfterComplete(std::function<void(bool)> callback) &
    {
        m_callback = std::move(callback);
    }

    auto InvokeIfReady() -> bool;

    TransactionFuture m_future;
    std::function<void(bool)> m_callback;
};

#endif
