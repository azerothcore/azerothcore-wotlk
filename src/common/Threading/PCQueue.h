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

#ifndef _PCQ_H
#define _PCQ_H

#include <condition_variable>
#include <queue>
#include <atomic>
#include <mutex>

template <typename T>
class ProducerConsumerQueue
{
private:
    mutable std::mutex _queueLock;
    std::queue<T> _queue;
    std::condition_variable _condition;
    std::atomic<bool> _cancel{};
    std::atomic<bool> _shutdown{};

public:
    ProducerConsumerQueue() = default;

    void Push(const T& value)
    {
        {
            std::lock_guard<std::mutex> lock(_queueLock);
            _queue.push(std::move(value));
        }
        _condition.notify_one();
    }

    bool Empty() const
    {
        std::lock_guard<std::mutex> lock(_queueLock);
        return _queue.empty();
    }

    [[nodiscard]] std::size_t Size() const
    {
        std::lock_guard<std::mutex> lock(_queueLock);
        return _queue.size();
    }

    bool Pop(T& value)
    {
        std::lock_guard<std::mutex> lock(_queueLock);
        if (_queue.empty() || _cancel)
            return false;

        value = std::move(_queue.front());
        _queue.pop();
        return true;
    }

    void WaitAndPop(T& value)
    {
        std::unique_lock<std::mutex> lock(_queueLock);

        // Wait for the queue to have an element or the cancel/shutdown flag
        _condition.wait(lock, [this] { return !_queue.empty() || _cancel || _shutdown; });

        if (_queue.empty() || _cancel)
            return;

        value = std::move(_queue.front());
        _queue.pop();
    }

    // Clears the queue and immediately stops any consumers.
    void Cancel()
    {
        std::lock_guard<std::mutex> lock(_queueLock);
        while (!_queue.empty()) {
            T& value = _queue.front();
            DeleteQueuedObject(value);
            _queue.pop();
        }
        _cancel = true;
        _condition.notify_all();
    }

    // Graceful stop: waits for the queue to become empty before stopping consumers.
    void Shutdown()
    {
        _shutdown = true;
        _condition.notify_all();
    }

private:
    template<typename E = T>
    typename std::enable_if<std::is_pointer<E>::value>::type DeleteQueuedObject(E& obj)
    {
        delete obj;
    }

    template<typename E = T>
    typename std::enable_if<!std::is_pointer<E>::value>::type DeleteQueuedObject(E const& /*obj*/) { }
};

#endif
