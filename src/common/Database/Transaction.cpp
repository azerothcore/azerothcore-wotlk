/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "Log.h"
#include "Transaction.h"
#include "MySQLConnection.h"
#include "PreparedStatement.h"
#include "Timer.h"
#include <mysqld_error.h>
#include <sstream>
#include <thread>

std::mutex TransactionTask::_deadlockLock;

#define DEADLOCK_MAX_RETRY_TIME_MS 60000

//- Append a raw ad-hoc query to the transaction
void Transaction::Append(char const* sql)
{
    SQLElementData data;
    data.type = SQL_ELEMENT_RAW;
    data.element.query = strdup(sql);
    m_queries.push_back(data);
}

//- Append a prepared statement to the transaction
void Transaction::Append(PreparedStatement* stmt)
{
    SQLElementData data;
    data.type = SQL_ELEMENT_PREPARED;
    data.element.stmt = stmt;
    m_queries.push_back(data);
}

void Transaction::Cleanup()
{
    // This might be called by explicit calls to Cleanup or by the auto-destructor
    if (_cleanedUp)
        return;

    for (SQLElementData const& data : m_queries)
    {
        switch (data.type)
        {
            case SQL_ELEMENT_PREPARED:
                delete data.element.stmt;
            break;
            case SQL_ELEMENT_RAW:
                free((void*)(data.element.query));
            break;
        }
    }

    m_queries.clear();
    _cleanedUp = true;
}

bool TransactionTask::Execute()
{
    int errorCode = m_conn->ExecuteTransaction(m_trans);
    if (!errorCode)
        return true;

    if (errorCode == ER_LOCK_DEADLOCK)
    {
        std::ostringstream threadIdStream;
        threadIdStream << std::this_thread::get_id();
        std::string threadId = threadIdStream.str();

        // Make sure only 1 async thread retries a transaction so they don't keep dead-locking each other
        std::lock_guard<std::mutex> lock(_deadlockLock);

        for (uint32 loopDuration = 0, startMSTime = getMSTime(); loopDuration <= DEADLOCK_MAX_RETRY_TIME_MS; loopDuration = GetMSTimeDiffToNow(startMSTime))
        {
            if (!m_conn->ExecuteTransaction(m_trans))
                return true;

            sLog->outSQLDriver("Deadlocked SQL Transaction, retrying. Loop timer: %u ms, Thread Id: %s", loopDuration, threadId.c_str());
        }

        sLog->outSQLDriver("Fatal deadlocked SQL Transaction, it will not be retried anymore. Thread Id: %s", threadId.c_str());
    }

    // Clean up now.
    m_trans->Cleanup();

    return false;
}