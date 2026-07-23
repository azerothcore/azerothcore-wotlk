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

#ifndef _ASYNC_TASK_H
#define _ASYNC_TASK_H

#include "Errors.h"
#include "Log.h"
#include <chrono>
#include <functional>
#include <future>

template <typename T>
class AsyncTask
{
public:
    using AsyncFunction = std::function<T()>;
    using CallbackFunction = std::function<void(T)>;

    AsyncTask(AsyncFunction asyncFunc, CallbackFunction callbackFunc)
        : asyncFunc(std::move(asyncFunc)), callbackFunc(std::move(callbackFunc)), isReady(false)
    {
    }

    ~AsyncTask()
    {
        // Ensure that the asynchronous task has completed before destruction
        if (asyncTask.valid() && asyncTask.wait_for(std::chrono::seconds(0)) != std::future_status::ready)
        {
            asyncTask.wait(); // Wait for the task to complete
        }
    }

    bool InvokeIfReady()
    {
        if (!isReady)
        {
            // Check if the asynchronous task is ready
            if (asyncTask.valid() && asyncTask.wait_for(std::chrono::seconds(0)) == std::future_status::ready)
            {
                // get() rethrows anything the async function threw. Swallowing it
                // would wedge the cluster handoff (the completion callback signals
                // map readiness to the registry), so fail fast with context and let
                // the registry's crash recovery rebalance this node.
                try
                {
                    callbackFunc(asyncTask.get());
                }
                catch (std::exception const& e)
                {
                    LOG_ERROR("server.tc9", "AsyncTask failed: {}", e.what());
                    ABORT("AsyncTask failed: {}", e.what());
                }
                isReady = true;
                return true;
            }
        }
        return false;
    }

    void ExecuteAsync()
    {
        // Capture the function by value so a moved AsyncTask does not leave
        // the in-flight async holding a dangling this pointer.
        AsyncFunction fn = asyncFunc;
        asyncTask = std::async(std::launch::async, [fn = std::move(fn)]() mutable
        {
            return fn();
        });
    }

private:
    AsyncFunction asyncFunc;
    CallbackFunction callbackFunc;
    std::shared_future<T> asyncTask;
    bool isReady;
};

#endif // _ASYNC_TASK_H
