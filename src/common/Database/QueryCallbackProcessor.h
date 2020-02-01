/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef QueryCallbackProcessor_h__
#define QueryCallbackProcessor_h__

#include "Define.h"
#include <vector>

class QueryCallback;

class QueryCallbackProcessor
{
public:
    QueryCallbackProcessor();
    ~QueryCallbackProcessor();

    void AddQuery(QueryCallback&& query);
    void ProcessReadyQueries();

private:
    QueryCallbackProcessor(QueryCallbackProcessor const&) = delete;
    QueryCallbackProcessor& operator=(QueryCallbackProcessor const&) = delete;

    std::vector<QueryCallback> _callbacks;
};

#endif // QueryCallbackProcessor_h__
