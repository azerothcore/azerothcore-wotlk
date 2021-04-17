#ifndef _MAP_UPDATER_H_INCLUDED
#define _MAP_UPDATER_H_INCLUDED

#include "Define.h"
#include "PCQueue.h"
#include <condition_variable>
#include <mutex>
#include <thread>

class Map;
class UpdateRequest;

class MapUpdater
{
public:
    MapUpdater();
    virtual ~MapUpdater();

    void schedule_update(Map& map, uint32 diff, uint32 s_diff);
    void schedule_lfg_update(uint32 diff);
    void wait();
    void activate(size_t num_threads);
    void deactivate();
    bool activated();
    void update_finished();

private:
    void WorkerThread();

    ProducerConsumerQueue<UpdateRequest*> _queue;

    std::vector<std::thread> _workerThreads;
    std::atomic<bool> _cancelationToken;

    std::mutex _lock;
    std::condition_variable _condition;
    size_t pending_requests;
};

#endif //_MAP_UPDATER_H_INCLUDED
