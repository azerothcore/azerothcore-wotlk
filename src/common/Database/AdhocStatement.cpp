/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "AdhocStatement.h"
#include "Errors.h"
#include "MySQLConnection.h"
#include "QueryResult.h"
#include <cstdlib>
#include <cstring>

/*! Basic, ad-hoc queries. */
BasicStatementTask::BasicStatementTask(char const* sql, bool async) :
m_result(nullptr)
{
    m_sql = strdup(sql);
    m_has_result = async; // If the operation is async, then there's a result
    if (async)
        m_result = new QueryResultPromise();
}

BasicStatementTask::~BasicStatementTask()
{
    free((void*)m_sql);
    if (m_has_result && m_result != nullptr)
        delete m_result;
}

bool BasicStatementTask::Execute()
{
    if (m_has_result)
    {
        ResultSet* result = m_conn->Query(m_sql);
        if (!result || !result->GetRowCount() || !result->NextRow())
        {
            delete result;
            m_result->set_value(QueryResult(nullptr));
            return false;
        }

        m_result->set_value(QueryResult(result));
        return true;
    }

    return m_conn->Execute(m_sql);
}
