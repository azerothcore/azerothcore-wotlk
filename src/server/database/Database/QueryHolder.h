/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _QUERYHOLDER_H
#define _QUERYHOLDER_H

#include "SQLOperation.h"
#include <vector>

class AC_DATABASE_API SQLQueryHolderBase
{
friend class SQLQueryHolderTask;
private:
    std::vector<std::pair<PreparedStatementBase*, PreparedQueryResult>> m_queries;
public:
    SQLQueryHolderBase() = default;
    virtual ~SQLQueryHolderBase();
    void SetSize(size_t size);
    PreparedQueryResult GetPreparedResult(size_t index) const;
    void SetPreparedResult(size_t index, PreparedResultSet* result);

protected:
    bool SetPreparedQueryImpl(size_t index, PreparedStatementBase* stmt);
};

template<typename T>
class SQLQueryHolder : public SQLQueryHolderBase
{
public:
    bool SetPreparedQuery(size_t index, PreparedStatement<T>* stmt)
    {
        return SetPreparedQueryImpl(index, stmt);
    }
};

class AC_DATABASE_API SQLQueryHolderTask : public SQLOperation
{
private:
    std::shared_ptr<SQLQueryHolderBase> m_holder;
    QueryResultHolderPromise m_result;

public:
    explicit SQLQueryHolderTask(std::shared_ptr<SQLQueryHolderBase> holder)
        : m_holder(std::move(holder)) { }

    ~SQLQueryHolderTask();

    bool Execute() override;
    QueryResultHolderFuture GetFuture() { return m_result.get_future(); }
};

class AC_DATABASE_API SQLQueryHolderCallback
{
public:
    SQLQueryHolderCallback(std::shared_ptr<SQLQueryHolderBase>&& holder, QueryResultHolderFuture&& future)
        : m_holder(std::move(holder)), m_future(std::move(future)) { }

    SQLQueryHolderCallback(SQLQueryHolderCallback&&) = default;

    SQLQueryHolderCallback& operator=(SQLQueryHolderCallback&&) = default;

    void AfterComplete(std::function<void(SQLQueryHolderBase const&)> callback) &
    {
        m_callback = std::move(callback);
    }

    bool InvokeIfReady();

    std::shared_ptr<SQLQueryHolderBase> m_holder;
    QueryResultHolderFuture m_future;
    std::function<void(SQLQueryHolderBase const&)> m_callback;
};

#endif
