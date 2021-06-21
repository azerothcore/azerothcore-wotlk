/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AvgDiffTracker.h"
#include "LFGMgr.h"
#include "Map.h"
#include "MapUpdater.h"

class UpdateRequest
{
public:
    UpdateRequest() = default;
    virtual ~UpdateRequest() = default;

    virtual void call() = 0;
};

class MapUpdateRequest : public UpdateRequest
{
public:
    MapUpdateRequest(Map& m, MapUpdater& u, uint32 d, uint32 sd)
        : m_map(m), m_updater(u), m_diff(d), s_diff(sd)
    {
    }

    void call() override
    {
        m_map.Update(m_diff, s_diff);
        m_updater.update_finished();
    }
private:
    Map& m_map;
    MapUpdater& m_updater;
    uint32 m_diff;
    uint32 s_diff;
};

class LFGUpdateRequest : public UpdateRequest
{
public:
    LFGUpdateRequest(MapUpdater& u, uint32 d) : m_updater(u), m_diff(d) {}

    void call() override
    {
        uint32 startTime = getMSTime();
        sLFGMgr->Update(m_diff, 1);
        uint32 totalTime = getMSTimeDiff(startTime, getMSTime());
        lfgDiffTracker.Update(totalTime);
        m_updater.update_finished();
    }
private:
    MapUpdater& m_updater;
    uint32 m_diff;
};

MapUpdater::MapUpdater(): pending_requests(0)
{
}

MapUpdater::~MapUpdater()
{
    deactivate();
}

void MapUpdater::activate(size_t num_threads)
{
    for (size_t i = 0; i < num_threads; ++i)
    {
        _workerThreads.push_back(std::thread(&MapUpdater::WorkerThread, this));
    }
}

void MapUpdater::deactivate()
{
    _cancelationToken = true;

    wait();

    _queue.Cancel();

    for (auto& thread : _workerThreads)
    {
        thread.join();
    }
}

void MapUpdater::wait()
{
    std::unique_lock<std::mutex> guard(_lock);

    while (pending_requests > 0)
        _condition.wait(guard);

    guard.unlock();
}

void MapUpdater::schedule_update(Map& map, uint32 diff, uint32 s_diff)
{
    std::lock_guard<std::mutex> guard(_lock);

    ++pending_requests;

    _queue.Push(new MapUpdateRequest(map, *this, diff, s_diff));
}

void MapUpdater::schedule_lfg_update(uint32 diff)
{
    std::lock_guard<std::mutex> guard(_lock);

    ++pending_requests;

    _queue.Push(new LFGUpdateRequest(*this, diff));
}

bool MapUpdater::activated()
{
    return _workerThreads.size() > 0;
}

void MapUpdater::update_finished()
{
    std::lock_guard<std::mutex> lock(_lock);

    --pending_requests;

    _condition.notify_all();
}

void MapUpdater::WorkerThread()
{
    while (1)
    {
        UpdateRequest* request = nullptr;

        _queue.WaitAndPop(request);
        if (_cancelationToken)
            return;

        request->call();

        delete request;
    }
}
