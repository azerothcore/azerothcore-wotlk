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

#include "DatabaseAsyncOperation.h"
#include "StringFormat.h"
#include <functional>
#include <mutex>
#include <variant>
#include <vector>

//- Type specifier of our element data
enum SQLElementDataType
{
    SQL_ELEMENT_RAW,
    SQL_ELEMENT_PREPARED
};

//- The element
struct SQLElementData
{
    std::variant<PreparedStatement, std::string> element;
    SQLElementDataType type;
};

class AC_DATABASE_API Transaction
{
public:
    Transaction() = default;
    virtual ~Transaction() { Cleanup(); }

    void Append(std::string_view sql);

    template<typename... Args>
    void Append(std::string_view sql, Args&&... args)
    {
        Append(Acore::StringFormatFmt(sql, std::forward<Args>(args)...));
    }

    void Append(PreparedStatement stmt);

    [[nodiscard]] std::size_t GetSize() const { return _queries.size(); }
    auto GetQueries() { return &_queries; }

    void Cleanup();

private:
    std::vector<SQLElementData> _queries;
    bool _cleanedUp{false};
};

class AC_DATABASE_API TransactionTask : public AsyncOperation
{
public:
    explicit TransactionTask(SQLTransaction trans) :
        AsyncOperation(), _trans(std::move(trans)) { }

    ~TransactionTask() override = default;

protected:
    void ExecuteQuery() override;
    int32 TryExecute();
    void CleanupOnFailure();

    std::shared_ptr<Transaction> _trans;
    static std::mutex _deadlockLock;
};

class AC_DATABASE_API TransactionWithResultTask : public TransactionTask
{
public:
    explicit TransactionWithResultTask(SQLTransaction trans) : TransactionTask(trans) { }

    TransactionFuture GetFuture() { return _result.get_future(); }

protected:
    void ExecuteQuery() override;

    TransactionPromise _result;
};

class AC_DATABASE_API TransactionCallback
{
public:
    TransactionCallback(TransactionFuture&& future) : _future(std::move(future)) { }
    TransactionCallback(TransactionCallback&&) = default;

    TransactionCallback& operator=(TransactionCallback&&) = default;

    void AfterComplete(std::function<void(bool)>&& callback)
    {
        _callback = std::move(callback);
    }

    bool InvokeIfReady();

    TransactionFuture _future;
    std::function<void(bool)> _callback;
};

#endif
