/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef _QUERY_CALLBACK_H
#define _QUERY_CALLBACK_H

#include "Define.h"
#include "DatabaseEnvFwd.h"
#include <functional>
#include <future>
#include <list>
#include <queue>
#include <utility>

class QueryCallback
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

    enum Status
    {
        NotReady,
        NextStep,
        Completed
    };

    Status InvokeIfReady();

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
