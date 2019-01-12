/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <mutex>
#include <condition_variable>

#include "MapUpdater.h"
#include "Map.h"
#include "LFGMgr.h"
#include "AvgDiffTracker.h"

class MapUpdateRequest
{
    private:

        Map& m_map;
        MapUpdater& m_updater;
        uint32 m_diff;
        uint32 s_diff;

    public:

        MapUpdateRequest(Map& m, MapUpdater& u, uint32 d, uint32 sd)
            : m_map(m), m_updater(u), m_diff(d), s_diff(sd)
        {
        }

        void call()
        {
            m_map.Update (m_diff, s_diff);
            m_updater.update_finished();
        }
};

class LFGUpdateRequest
{
    private:

        MapUpdater& m_updater;
        uint32 m_diff;

    public:
        LFGUpdateRequest(MapUpdater& u, uint32 d) : m_updater(u), m_diff(d) {}

        void call()
        {
            uint32 startTime = getMSTime();
            sLFGMgr->Update(m_diff, 1);
            uint32 totalTime = getMSTimeDiff(startTime, getMSTime());
            lfgDiffTracker.Update(totalTime);
            m_updater.update_finished();
            return 0;
        }
};

void MapUpdater::activate(size_t num_threads)
{
    for (size_t i = 0; i < num_threads; ++i)
    {
        _workerThreads.push_back(std::thread(&MapUpdater::WorkerThread, this));
    }
}

void MapUpdater::deactivate()
{
    cancelationToken = true;
    
    wait();

    queue.Cancel();

    for (auto& thread : _workerThreads)
    {
        thread.join();
    }
}

void MapUpdater::wait()
{
    std::lock_guard<std::mutex> lock(m_mutex);

    while (pending_requests > 0)
        _condition.wait(lock);

    lock.unlock();
}

void MapUpdater::schedule_update(Map& map, uint32 diff, uint32 s_diff)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    ++pending_requests;
    
    _queue.Push(new MapUpdateRequest(map, *this, diff, s_diff));
}

void MapUpdater::schedule_lfg_update(ACE_UINT32 diff)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    ++pending_requests;
   
    _queue.Push(new LFGUpdateRequest(map, *this, diff));
}

bool MapUpdater::activated()
{
    return m_executor.activated();
}

void MapUpdater::WorkerThread()
{
    while (1)
    {
        MapUpdateRequest* request = nullptr;

        _queue.WaitAndPop(request);

        if (_cancelationToken)
            return;

        request->call();

        delete request;
    }
}

void MapUpdater::update_finished()
{
    std::lock_guard<std::mutex> lock(m_mutex);
    
    --pending_requests;

   _condition.notify_all();
}
