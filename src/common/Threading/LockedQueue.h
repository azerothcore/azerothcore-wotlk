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

#ifndef LOCKEDQUEUE_H
#define LOCKEDQUEUE_H

#include <atomic>
#include <deque>
#include <memory>
#include <mutex>

template <class T, typename StorageType = std::deque<T>>
class LockedQueue
{
    mutable std::mutex _lock;

    std::atomic<bool> _canceled{false};

    StorageType _queue;

public:

    // Create a LockedQueue.
    LockedQueue() = default;

    // Destroy a LockedQueue.
    virtual ~LockedQueue() = default;

    // Adds an item to the queue.
    void add(const T& item)
    {
        std::lock_guard<std::mutex> lock(_lock);
        _queue.push_back(std::move(item));
    }

    // Adds items back to front of the queue
    template<class Iterator>
    void readd(Iterator begin, Iterator end)
    {
        std::lock_guard<std::mutex> lock(_lock);
        _queue.insert(_queue.begin(), begin, end);
    }

    // Gets the next result in the queue, if any.
    bool next(T& result)
    {
        std::lock_guard<std::mutex> lock(_lock);
        if (_queue.empty())
        {
            return false;
        }

        result = std::move(_queue.front());
        _queue.pop_front();
        return true;
    }

    template<class Checker>
    bool next(T& result, Checker& check)
    {
        std::lock_guard<std::mutex> lock(_lock);
        if (_queue.empty())
        {
            return false;
        }

        result = std::move(_queue.front());
        if (!check.Process(result))
        {
            return false;
        }

        _queue.pop_front();
        return true;
    }

    // Peeks at the top of the queue.
    T& peek()
    {
        std::lock_guard<std::mutex> lock(_lock);
        return std::move(_queue.front());
    }

    // Cancels the queue.
    void cancel()
    {
        _canceled.store(true, std::memory_order_release);
    }

    // Checks if the queue is cancelled.
    bool cancelled() const
    {
        return _canceled.load(std::memory_order_acquire);
    }

    // Checks if the queue is empty.
    bool empty() const
    {
        std::lock_guard<std::mutex> lock(_lock);
        return _queue.empty();
    }

    // Calls pop_front of the queue.
    void pop_front()
    {
        std::lock_guard<std::mutex> lock(_lock);
        _queue.pop_front();
    }
};

#endif
