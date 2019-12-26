#ifndef _MAP_UPDATER_H_INCLUDED
#define _MAP_UPDATER_H_INCLUDED

#include "Define.h"
#include <mutex>
#include <thread>
#include <condition_variable>
#include "ProducerConsumerQueue.h"

class MapUpdateRequest;
class Map;

class MapUpdater
{
    public:

        MapUpdater() : _cancelationToken(false), pending_requests(0) {}
        ~MapUpdater() { };

        friend class MapUpdateRequest;

        void schedule_update(Map& map, uint32 diff);

        void wait();

        void activate(size_t num_threads);

        void deactivate();

        bool activated();

    private:

        ProducerConsumerQueue<MapUpdateRequest*> _queue;

        std::vector<std::thread> _workerThreads;
        std::atomic<bool> _cancelationToken;

        std::mutex _lock;
        std::condition_variable _condition;
        size_t pending_requests;

        void update_finished();

        void WorkerThread();
};

#endif //_MAP_UPDATER_H_INCLUDED
