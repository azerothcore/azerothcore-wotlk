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

#ifndef WARHEAD_ASYNC_DB_QUEUE_WORKER_H_
#define WARHEAD_ASYNC_DB_QUEUE_WORKER_H_

#include "Define.h"
#include <atomic>
#include <thread>

template <typename T>
class ProducerConsumerQueue;

class AsyncOperation;
class CheckAsyncQueueTask;
class MySQLConnection;

class AC_DATABASE_API AsyncDBQueueWorker
{
public:
    AsyncDBQueueWorker(ProducerConsumerQueue<AsyncOperation*>* dbQueue, MySQLConnection* connection);
    ~AsyncDBQueueWorker();

private:
    void ExecuteAsyncQueue();

    ProducerConsumerQueue<AsyncOperation*>* _queue;
    MySQLConnection* _connection;

    std::thread _thread;
    std::atomic<bool> _cancel{ false };

    AsyncDBQueueWorker(AsyncDBQueueWorker const& right) = delete;
    AsyncDBQueueWorker& operator=(AsyncDBQueueWorker const& right) = delete;
};

class AC_DATABASE_API AsyncDBQueueChecker
{
public:
    AsyncDBQueueChecker(ProducerConsumerQueue<CheckAsyncQueueTask*>* dbQueue);
    ~AsyncDBQueueChecker();

private:
    void ExecuteThread();

    ProducerConsumerQueue<CheckAsyncQueueTask*>* _queue;

    std::thread _thread;
    std::atomic<bool> _cancel{ false };

    AsyncDBQueueChecker(AsyncDBQueueChecker const& right) = delete;
    AsyncDBQueueChecker& operator=(AsyncDBQueueChecker const& right) = delete;
};

#endif
