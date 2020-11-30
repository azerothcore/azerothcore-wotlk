/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ADHOCSTATEMENT_H
#define _ADHOCSTATEMENT_H

#include "SQLOperation.h"

#include <future>

typedef std::promise<QueryResult> QueryResultPromise;

/*! Raw, ad-hoc query. */
class BasicStatementTask : public SQLOperation
{
public:
    BasicStatementTask(const char* sql);
    BasicStatementTask(const char* sql, QueryResultPromise *result);
    ~BasicStatementTask();

    bool Execute();

private:
    const char* m_sql;      //- Raw query to be executed
    const bool m_has_result;
    QueryResultPromise * const m_result;
};

#endif
