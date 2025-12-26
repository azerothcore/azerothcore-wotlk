/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _MAP_UPDATER_H_INCLUDED
#define _MAP_UPDATER_H_INCLUDED

#include "Define.h"
#include "PCQueue.h"
#include <condition_variable>
#include <thread>
#include <atomic>

class Map;
class UpdateRequest;

class MapUpdater
{
public:
    MapUpdater();
    ~MapUpdater() = default;

    void schedule_task(UpdateRequest* request);
    void schedule_update(Map& map, uint32 diff, uint32 s_diff);
    void schedule_map_preload(uint32 mapid);
    void schedule_lfg_update(uint32 diff);
    void wait();
    void activate(std::size_t num_threads);
    void deactivate();
    bool activated();
    void update_finished();

private:
    void WorkerThread();
    ProducerConsumerQueue<UpdateRequest*> _queue;
    std::atomic<int> pending_requests;  // Use std::atomic for pending_requests to avoid lock contention
    std::atomic<bool> _cancelationToken;  // Atomic flag for cancellation to avoid race conditions
    std::vector<std::thread> _workerThreads;
    std::mutex _lock; // Mutex and condition variable for synchronization
    std::condition_variable _condition;
};

#endif //_MAP_UPDATER_H_INCLUDED
