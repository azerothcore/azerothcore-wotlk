/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _TRANSACTION_H
#define _TRANSACTION_H

#include "Define.h"
#include "DatabaseEnvFwd.h"
#include "SQLOperation.h"
#include "StringFormat.h"
#include <mutex>
#include <vector>

/*! Transactions, high level class. */
class Transaction
{
    friend class TransactionTask;
    friend class MySQLConnection;

    template <typename T>
    friend class DatabaseWorkerPool;

    public:
        Transaction() : _cleanedUp(false) { }
        ~Transaction() { Cleanup(); }

        void Append(PreparedStatement* statement);
        void Append(char const* sql);
        template<typename Format, typename... Args>
        void PAppend(Format&& sql, Args&&... args)
        {
            Append(acore::StringFormat(std::forward<Format>(sql), std::forward<Args>(args)...).c_str());
        }

        std::size_t GetSize() const { return m_queries.size(); }

    protected:
        void Cleanup();
        std::vector<SQLElementData> m_queries;

    private:
        bool _cleanedUp;

};

/*! Low level class*/
class TransactionTask : public SQLOperation
{
    template <class T> friend class DatabaseWorkerPool;
    friend class DatabaseWorker;

    public:
        TransactionTask(SQLTransaction trans) : m_trans(trans) { }
        ~TransactionTask() { }

    protected:
        bool Execute() override;

        SQLTransaction m_trans;
        static std::mutex _deadlockLock;
};

#endif
