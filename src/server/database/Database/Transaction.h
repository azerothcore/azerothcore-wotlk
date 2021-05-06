/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _TRANSACTION_H
#define _TRANSACTION_H

#include <utility>

#include "SQLOperation.h"

//- Forward declare (don't include header to prevent circular includes)
class PreparedStatement;

/*! Transactions, high level class. */
class Transaction
{
    friend class TransactionTask;
    friend class MySQLConnection;

    template <typename T>
    friend class DatabaseWorkerPool;

public:
    Transaction()  { }
    ~Transaction() { Cleanup(); }

    void Append(PreparedStatement* statement);
    void Append(const char* sql);
    void PAppend(const char* sql, ...);

    [[nodiscard]] size_t GetSize() const { return m_queries.size(); }

protected:
    void Cleanup();
    std::list<SQLElementData> m_queries;

private:
    bool _cleanedUp{false};
};

typedef std::shared_ptr<Transaction> SQLTransaction;

/*! Low level class*/
class TransactionTask : public SQLOperation
{
    template <class T> friend class DatabaseWorkerPool;
    friend class DatabaseWorker;

public:
    TransactionTask(SQLTransaction trans) : m_trans(std::move(trans)) { } ;
    ~TransactionTask() override = default;

protected:
    bool Execute() override;

    SQLTransaction m_trans;
};

#endif
