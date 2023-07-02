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

#include "DatabaseAsyncQueueWorker.h"
#include "DatabaseAsyncOperation.h"
#include "PCQueue.h"

AsyncDBQueueWorker::AsyncDBQueueWorker(ProducerConsumerQueue<AsyncOperation*>* dbQueue, MySQLConnection* connection)
{
    _connection = connection;
    _queue = dbQueue;
    _thread = std::thread(&AsyncDBQueueWorker::ExecuteAsyncQueue, this);
}

AsyncDBQueueWorker::~AsyncDBQueueWorker()
{
    _cancel = true;
    _queue->NotifyAll();

    if (_thread.joinable())
        _thread.join();
}

void AsyncDBQueueWorker::ExecuteAsyncQueue()
{
    if (!_queue)
        return;

    for (;;)
    {
        AsyncOperation* operation{ nullptr };

        _queue->WaitAndPop(operation, _cancel);

        if (_cancel)
            break;

        if (!operation)
            continue;

        operation->SetConnection(_connection);
        operation->ExecuteQuery();
        delete operation;
    }
}

AsyncDBQueueChecker::AsyncDBQueueChecker(ProducerConsumerQueue<CheckAsyncQueueTask*>* dbQueue)
{
    _queue = dbQueue;
    _thread = std::thread(&AsyncDBQueueChecker::ExecuteThread, this);
}

AsyncDBQueueChecker::~AsyncDBQueueChecker()
{
    _cancel = true;
    _queue->Cancel();

    if (_thread.joinable())
        _thread.join();
}

void AsyncDBQueueChecker::ExecuteThread()
{
    if (!_queue)
        return;

    for (;;)
    {
        CheckAsyncQueueTask* operation{ nullptr };

        _queue->WaitAndPop(operation);

        if (!operation || _cancel)
            return;

        operation->Execute();
        delete operation;
    }
}
