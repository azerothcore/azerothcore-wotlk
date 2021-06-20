#ifndef _MAP_UPDATER_H_INCLUDED
#define _MAP_UPDATER_H_INCLUDED

#include <ace/Thread_Mutex.h>
#include <ace/Condition_Thread_Mutex.h>

#include "DelayExecutor.h"
#include "World.h"

class Map;

class MapUpdater
{
    public:

        MapUpdater();
        virtual ~MapUpdater();

        friend class MapUpdateRequest;
        friend class LFGUpdateRequest;

        int schedule_update(Map& map, uint32 diff, uint32 s_diff);
        int schedule_lfg_update(uint32 diff);

        int wait();

        int activate(size_t num_threads);

        int deactivate();

        bool activated();

    private:

        DelayExecutor m_executor;
        ACE_Thread_Mutex m_mutex;
        ACE_Condition_Thread_Mutex m_condition;
        size_t pending_requests;

        void update_finished();
};

#endif //_MAP_UPDATER_H_INCLUDED
