/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _QUERYHOLDER_H
#define _QUERYHOLDER_H

#include "SQLOperation.h"

class SQLQueryHolder
{
    friend class SQLQueryHolderTask;
    private:
        std::vector<std::pair<PreparedStatement*, PreparedQueryResult>> m_queries;
    public:
        SQLQueryHolder() { }
        virtual ~SQLQueryHolder();
        bool SetPreparedQuery(size_t index, PreparedStatement* stmt);
        void SetSize(size_t size);
        PreparedQueryResult GetPreparedResult(size_t index);
        void SetPreparedResult(size_t index, PreparedResultSet* result);
};

class SQLQueryHolderTask : public SQLOperation
{
    private:
        SQLQueryHolder* m_holder;
        QueryResultHolderPromise m_result;
        bool m_executed;

    public:
        SQLQueryHolderTask(SQLQueryHolder* holder)
            : m_holder(holder), m_executed(false) { }

        ~SQLQueryHolderTask();

        bool Execute() override;
        QueryResultHolderFuture GetFuture() { return m_result.get_future(); }
};

#endif
