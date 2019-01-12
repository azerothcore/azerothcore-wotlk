#ifndef _MAP_UPDATER_H_INCLUDED
#define _MAP_UPDATER_H_INCLUDED

#include "Define.h"
#include "World.h"
#include "ProducerConsumerQueue.h"
#include <thread>
#include <mutex>
#include <condition_variable>

class Map;

class MapUpdater
{
    public:

        MapUpdater::MapUpdater() : _cancelationToken(false), pending_requests(0) {}
        ~MapUpdater() { };

        friend class MapUpdateRequest;
        friend class LFGUpdateRequest;

        void schedule_update(Map& map, uint32 diff, uint32 s_diff);
        void schedule_lfg_update(uint32 diff);

        void schedule_update(Map& map, uint32 diff);

        void wait();

        void activate(size_t num_threads);

        void deactivate();

        bool activated();

    private:

        ProducerConsumerQueue <MapUpdateRequest*> _queue;

        std::vector<std::thread> _workerThreads;
        std::atomic<bool> _cancelationToken;

        std::mutex m_mutex;
        std::condition_variable _condition;
        size_t pending_requests;

        void update_finished();
        
        void WorkerThread();
};

#endif //_MAP_UPDATER_H_INCLUDED
