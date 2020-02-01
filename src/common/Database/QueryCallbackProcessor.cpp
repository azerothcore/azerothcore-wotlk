/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "QueryCallbackProcessor.h"
#include "QueryCallback.h"
#include <algorithm>

QueryCallbackProcessor::QueryCallbackProcessor()
{
}

QueryCallbackProcessor::~QueryCallbackProcessor()
{
}

void QueryCallbackProcessor::AddQuery(QueryCallback&& query)
{
    _callbacks.emplace_back(std::move(query));
}

void QueryCallbackProcessor::ProcessReadyQueries()
{
    if (_callbacks.empty())
        return;

    std::vector<QueryCallback> updateCallbacks{ std::move(_callbacks) };

    updateCallbacks.erase(std::remove_if(updateCallbacks.begin(), updateCallbacks.end(), [](QueryCallback& callback)
    {
        return callback.InvokeIfReady() == QueryCallback::Completed;
    }), updateCallbacks.end());

    _callbacks.insert(_callbacks.end(), std::make_move_iterator(updateCallbacks.begin()), std::make_move_iterator(updateCallbacks.end()));
}
