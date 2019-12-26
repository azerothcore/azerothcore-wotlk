/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MySQLConnection.h"
#include "QueryHolder.h"
#include "PreparedStatement.h"
#include "Log.h"
#include "QueryResult.h"

bool SQLQueryHolder::SetPreparedQuery(size_t index, PreparedStatement* stmt)
{
    if (m_queries.size() <= index)
    {
        sLog->outSQLDriver("Query index (%u) out of range (size: %u) for prepared statement", uint32(index), (uint32)m_queries.size());
        return false;
    }

    m_queries[index].first = stmt;
    return true;
}

PreparedQueryResult SQLQueryHolder::GetPreparedResult(size_t index)
{
    // Don't call to this function if the index is of a prepared statement
    if (index < m_queries.size())
        return m_queries[index].second;
    else
        return PreparedQueryResult(nullptr);
}

void SQLQueryHolder::SetPreparedResult(size_t index, PreparedResultSet* result)
{
    if (result && !result->GetRowCount())
    {
        delete result;
        result = nullptr;
    }

    /// store the result in the holder
    if (index < m_queries.size())
        m_queries[index].second = PreparedQueryResult(result);
}

SQLQueryHolder::~SQLQueryHolder()
{
    for (size_t i = 0; i < m_queries.size(); i++)
    {
        /// if the result was never used, free the resources
        /// results used already (getresult called) are expected to be deleted
        delete m_queries[i].first;
    }
}

void SQLQueryHolder::SetSize(size_t size)
{
    /// to optimize push_back, reserve the number of queries about to be executed
    m_queries.resize(size);
}

SQLQueryHolderTask::~SQLQueryHolderTask()
{
    if (!m_executed)
        delete m_holder;
}

bool SQLQueryHolderTask::Execute()
{
    m_executed = true;

    if (!m_holder)
        return false;

    /// execute all queries in the holder and pass the results
    for (size_t i = 0; i < m_holder->m_queries.size(); ++i)
        if (PreparedStatement* stmt = m_holder->m_queries[i].first)
            m_holder->SetPreparedResult(i, m_conn->Query(stmt));

    m_result.set_value(m_holder);
    return true;
}
