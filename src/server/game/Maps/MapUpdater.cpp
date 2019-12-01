#include "MapUpdater.h"
#include "DelayExecutor.h"
#include "Map.h"
#include "DatabaseEnv.h"
#include "LFGMgr.h"
#include "AvgDiffTracker.h"

#include <ace/Guard_T.h>
#include <ace/Method_Request.h>

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
        uint32 m_diff;
        uint32 s_diff;

    public:

        MapUpdateRequest(Map& m, MapUpdater& u, uint32 d, uint32 sd)
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
        uint32 m_diff;

    public:
        LFGUpdateRequest(MapUpdater& u, uint32 d) : m_updater(u), m_diff(d) {}

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

MapUpdater::MapUpdater():
m_executor(), m_mutex(), m_condition(m_mutex), pending_requests(0)
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
    ACORE_GUARD(ACE_Thread_Mutex, m_mutex);

    while (pending_requests > 0)
        m_condition.wait();

    return 0;
}

int MapUpdater::schedule_update(Map& map, uint32 diff, uint32 s_diff)
{
    ACORE_GUARD(ACE_Thread_Mutex, m_mutex);

    ++pending_requests;

    if (m_executor.execute(new MapUpdateRequest(map, *this, diff, s_diff)) == -1)
    {
        ACE_DEBUG((LM_ERROR, ACE_TEXT("(%t) \n"), ACE_TEXT("Failed to schedule Map Update")));

        --pending_requests;
        return -1;
    }

    return 0;
}

int MapUpdater::schedule_lfg_update(uint32 diff)
{
    ACORE_GUARD(ACE_Thread_Mutex, m_mutex);

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
    ACORE_GUARD(ACE_Thread_Mutex, m_mutex);

    if (pending_requests == 0)
    {
        ACE_ERROR((LM_ERROR, ACE_TEXT("(%t)\n"), ACE_TEXT("MapUpdater::update_finished BUG, report to devs")));
        sLog->outMisc("WOOT! pending_requests == 0 before decrement!");
        m_condition.broadcast();
        return;
    }

    --pending_requests;

    m_condition.broadcast();
}
