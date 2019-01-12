/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include <mutex>
#include <condition_variable>

#include "MapUpdater.h"
#include "DelayExecutor.h"
#include "Map.h"
#include "DatabaseEnv.h"
#include "LFGMgr.h"
#include "AvgDiffTracker.h"

class WDBThreadStartReq1 : public ACE_Method_Request
{
    public:

        WDBThreadStartReq1()
        {
        }

        virtual int call()
        {
            return 0;
        }
};

class WDBThreadEndReq1 : public ACE_Method_Request
{
    public:

        WDBThreadEndReq1()
        {
        }

        virtual int call()
        {
            return 0;
        }
};

class MapUpdateRequest : public ACE_Method_Request
{
    private:

        Map& m_map;
        MapUpdater& m_updater;
        ACE_UINT32 m_diff;
        ACE_UINT32 s_diff;

    public:

        MapUpdateRequest(Map& m, MapUpdater& u, ACE_UINT32 d, ACE_UINT32 sd)
            : m_map(m), m_updater(u), m_diff(d), s_diff(sd)
        {
        }

        virtual int call()
        {
            m_map.Update (m_diff, s_diff);
            m_updater.update_finished();
            return 0;
        }
};

class LFGUpdateRequest : public ACE_Method_Request
{
    private:

        MapUpdater& m_updater;
        ACE_UINT32 m_diff;

    public:
        LFGUpdateRequest(MapUpdater& u, ACE_UINT32 d) : m_updater(u), m_diff(d) {}

        virtual int call()
        {
            uint32 startTime = getMSTime();
            sLFGMgr->Update(m_diff, 1);
            uint32 totalTime = getMSTimeDiff(startTime, getMSTime());
            lfgDiffTracker.Update(totalTime);
            m_updater.update_finished();
            return 0;
        }
};

MapUpdater::MapUpdater(): m_executor(), pending_requests(0) { }
{
}

MapUpdater::~MapUpdater()
{
    deactivate();
}

int MapUpdater::activate(size_t num_threads)
{
    return m_executor.start((int)num_threads, new WDBThreadStartReq1, new WDBThreadEndReq1);
}

int MapUpdater::deactivate()
{
    wait();

    return m_executor.deactivate();
}

int MapUpdater::wait()
{
    std::lock_guard<std::mutex> lock(m_mutex);

    while (pending_requests > 0)
        _condition.wait(lock);

    lock.unlock();

    return 0;
}

int MapUpdater::schedule_update(Map& map, ACE_UINT32 diff, ACE_UINT32 s_diff)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    ++pending_requests;

    if (m_executor.execute(new MapUpdateRequest(map, *this, diff, s_diff)) == -1)
    {
        ACE_DEBUG((LM_ERROR, ACE_TEXT("(%t) \n"), ACE_TEXT("Failed to schedule Map Update")));

        --pending_requests;
        return -1;
    }

    return 0;
}

int MapUpdater::schedule_lfg_update(ACE_UINT32 diff)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    ++pending_requests;

    if (m_executor.execute(new LFGUpdateRequest(*this, diff)) == -1)
    {
        ACE_DEBUG((LM_ERROR, ACE_TEXT("(%t) \n"), ACE_TEXT("Failed to schedule LFG Update")));

        --pending_requests;
        return -1;
    }

    return 0;
}

bool MapUpdater::activated()
{
    return m_executor.activated();
}

void MapUpdater::update_finished()
{
    std::lock_guard<std::mutex> lock(m_mutex);

    if (pending_requests == 0)
    {
        ACE_ERROR((LM_ERROR, ACE_TEXT("(%t)\n"), ACE_TEXT("MapUpdater::update_finished BUG, report to devs")));
        sLog->outMisc("WOOT! pending_requests == 0 before decrement!");
        _condition.notify_all();
        return;
    }

    --pending_requests;

   _condition.notify_all();
}
