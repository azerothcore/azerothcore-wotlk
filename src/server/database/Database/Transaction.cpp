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

#include "Transaction.h"
#include "Errors.h"
#include "Log.h"
#include "MySQLConnection.h"
#include "PreparedStatement.h"
#include "Timer.h"
#include <mysqld_error.h>
#include <sstream>
#include <thread>

std::mutex TransactionTask::_deadlockLock;
constexpr Milliseconds DEADLOCK_MAX_RETRY_TIME_MS = 1min;

//- Append a raw ad-hoc query to the transaction
void Transaction::Append(std::string_view sql)
{
    SQLElementData data{};
    data.type = SQL_ELEMENT_RAW;
    data.element = std::string{ sql };
    _queries.emplace_back(data);
}

//- Append a prepared statement to the transaction
void Transaction::Append(PreparedStatement stmt)
{
    SQLElementData data{};
    data.type = SQL_ELEMENT_PREPARED;
    data.element = stmt;
    _queries.emplace_back(data);
}

void Transaction::Cleanup()
{
    // This might be called by explicit calls to Clean up or by the auto-destructor
    if (_cleanedUp)
        return;

    for (SQLElementData& data : _queries)
    {
        switch (data.type)
        {
            case SQL_ELEMENT_PREPARED:
            {
                try
                {
                    auto stmt = std::get<PreparedStatement>(data.element);
                    ASSERT(stmt);
                }
                catch (const std::bad_variant_access& ex)
                {
                    LOG_FATAL("db.query", "> PreparedStatementBase not found in SQLElementData. {}", ex.what());
                    ABORT("");
                }
            }
            break;
            case SQL_ELEMENT_RAW:
            {
                try
                {
                    std::get<std::string>(data.element).clear();
                }
                catch (const std::bad_variant_access& ex)
                {
                    LOG_FATAL("db.query", "> std::string not found in SQLElementData. {}", ex.what());
                    ABORT("");
                }
            }
            break;
        }
    }

    _queries.clear();
    _cleanedUp = true;
}

void TransactionTask::ExecuteQuery()
{
    int errorCode = TryExecute();
    if (!errorCode)
        return;

    if (errorCode == ER_LOCK_DEADLOCK)
    {
        std::ostringstream threadIdStream;
        threadIdStream << std::this_thread::get_id();
        std::string threadId = threadIdStream.str();

        {
            // Make sure only 1 async thread retries a transaction, so they don't keep deadlocking each other
            std::lock_guard<std::mutex> lock(_deadlockLock);

            for (Milliseconds loopDuration = 0s, startMSTime = GetTimeMS(); loopDuration <= DEADLOCK_MAX_RETRY_TIME_MS; loopDuration = GetMSTimeDiffToNow(startMSTime))
            {
                if (!TryExecute())
                    return;

                LOG_WARN("db.query", "Deadlocked SQL Transaction, retrying. Loop timer: {} ms, Thread Id: {}", loopDuration.count(), threadId);
            }
        }

        LOG_ERROR("db.query", "Fatal deadlocked SQL Transaction, it will not be retried anymore. Thread Id: {}", threadId);
    }

    // Clean up now.
    CleanupOnFailure();
}

int32 TransactionTask::TryExecute()
{
    return _connection->ExecuteTransaction(_trans);
}

void TransactionTask::CleanupOnFailure()
{
    _trans->Cleanup();
}

void TransactionWithResultTask::ExecuteQuery()
{
    int errorCode = TryExecute();
    if (!errorCode)
    {
        _result.set_value(true);
        return;
    }

    if (errorCode == ER_LOCK_DEADLOCK)
    {
        std::ostringstream threadIdStream;
        threadIdStream << std::this_thread::get_id();
        std::string threadId = threadIdStream.str();

        {
            // Make sure only 1 async thread retries a transaction, so they don't keep deadlocking each other
            std::lock_guard<std::mutex> lock(_deadlockLock);

            for (Milliseconds loopDuration = 0s, startMSTime = GetTimeMS(); loopDuration <= DEADLOCK_MAX_RETRY_TIME_MS; loopDuration = GetMSTimeDiffToNow(startMSTime))
            {
                if (!TryExecute())
                {
                    _result.set_value(true);
                    return;
                }

                LOG_WARN("db.query", "Deadlocked SQL Transaction, retrying. Loop timer: {} ms, Thread Id: {}", loopDuration.count(), threadId);
            }
        }

        LOG_ERROR("db.query", "Fatal deadlocked SQL Transaction, it will not be retried anymore. Thread Id: {}", threadId);
    }

    // Clean up now.
    CleanupOnFailure();
    _result.set_value(false);
}

bool TransactionCallback::InvokeIfReady()
{
    if (_future.valid() && _future.wait_for(0s) == std::future_status::ready)
    {
        _callback(_future.get());
        return true;
    }

    return false;
}
