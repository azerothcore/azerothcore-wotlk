/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _QUERY_CALLBACK_H
#define _QUERY_CALLBACK_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include <functional>
#include <future>
#include <list>
#include <queue>
#include <utility>

class AC_DATABASE_API QueryCallback
{
public:
    explicit QueryCallback(QueryResultFuture&& result);
    explicit QueryCallback(PreparedQueryResultFuture&& result);
    QueryCallback(QueryCallback&& right);
    QueryCallback& operator=(QueryCallback&& right);
    ~QueryCallback();

    QueryCallback&& WithCallback(std::function<void(QueryResult)>&& callback);
    QueryCallback&& WithPreparedCallback(std::function<void(PreparedQueryResult)>&& callback);

    QueryCallback&& WithChainingCallback(std::function<void(QueryCallback&, QueryResult)>&& callback);
    QueryCallback&& WithChainingPreparedCallback(std::function<void(QueryCallback&, PreparedQueryResult)>&& callback);

    // Moves std::future from next to this object
    void SetNextQuery(QueryCallback&& next);

    // returns true when completed
    bool InvokeIfReady();

private:
    QueryCallback(QueryCallback const& right) = delete;
    QueryCallback& operator=(QueryCallback const& right) = delete;

    template<typename T> friend void ConstructActiveMember(T* obj);
    template<typename T> friend void DestroyActiveMember(T* obj);
    template<typename T> friend void MoveFrom(T* to, T&& from);

    union
    {
        QueryResultFuture _string;
        PreparedQueryResultFuture _prepared;
    };
    bool _isPrepared;

    struct QueryCallbackData;
    std::queue<QueryCallbackData, std::list<QueryCallbackData>> _callbacks;
};

#endif // _QUERY_CALLBACK_H
