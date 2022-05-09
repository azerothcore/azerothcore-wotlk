/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
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
#include <mutex>
#include <thread>

class Map;
class UpdateRequest;

class MapUpdater
{
public:
    MapUpdater();
    ~MapUpdater() = default;

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
