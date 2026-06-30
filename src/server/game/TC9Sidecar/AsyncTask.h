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
                // Invoke the callback with the result of the asynchronous task
                callbackFunc(asyncTask.get());
                isReady = true;
                return true;
            }
        }
        return false;
    }

    void ExecuteAsync()
    {
        // Execute the asynchronous task
        asyncTask = std::async(std::launch::async, [this]
        {
            return asyncFunc();
        });
    }

private:
    AsyncFunction asyncFunc;
    CallbackFunction callbackFunc;
    std::shared_future<T> asyncTask;
    bool isReady;
};

#endif // _ASYNC_TASK_H
