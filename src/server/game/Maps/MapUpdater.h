#ifndef _MAP_UPDATER_H_INCLUDED
#define _MAP_UPDATER_H_INCLUDED

#include "DelayExecutor.h"
#include "World.h"
#include <mutex>
#include <condition_variable>

class Map;

class MapUpdater
{
    public:

        MapUpdater();
        virtual ~MapUpdater();

        friend class MapUpdateRequest;
        friend class LFGUpdateRequest;

        int schedule_update(Map& map, ACE_UINT32 diff, ACE_UINT32 s_diff);
        int schedule_lfg_update(ACE_UINT32 diff);

        int wait();

        int activate(size_t num_threads);

        int deactivate();

        bool activated();

    private:

        DelayExecutor m_executor;
        std::mutex m_mutex;
        std::condition_variable _condition;
        size_t pending_requests;

        void update_finished();
};

#endif //_MAP_UPDATER_H_INCLUDED
