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
    mutable std::mutex _lock; ///< Mutex to protect access to the queue

    std::atomic<bool> _canceled{false}; ///< Flag indicating if the queue is canceled

    StorageType _queue; ///< Storage container for the queue

public:

    /**
     * @brief Default constructor to create an empty LockedQueue.
     */
    LockedQueue() = default;

    /**
     * @brief Destructor for LockedQueue.
     */
    virtual ~LockedQueue() = default;

    /**
     * @brief Adds an item to the back of the queue.
     *
     * @param item The item to be added to the queue.
     */
    void add(const T& item)
    {
        std::lock_guard<std::mutex> lock(_lock);
        _queue.push_back(std::move(item));
    }

    /**
     * @brief Adds a range of items to the front of the queue.
     *
     * @param begin Iterator pointing to the beginning of the range of items to be added.
     * @param end Iterator pointing to the end of the range of items to be added.
     */
    template<class Iterator>
    void readd(Iterator begin, Iterator end)
    {
        std::lock_guard<std::mutex> lock(_lock);
        _queue.insert(_queue.begin(), begin, end);
    }

    /**
     * @brief Gets the next item in the queue and removes it.
     *
     * @param result The variable where the next item will be stored.
     * @return true if an item was retrieved and removed, false if the queue is empty.
     */
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

    /**
     * @brief Retrieves the next item from the queue if it satisfies the provided checker.
     *
     * @param result The variable where the next item will be stored.
     * @param check A checker object that will be used to validate the item.
     * @return true if an item was retrieved, checked, and removed; false otherwise.
     */
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

    /**
     * @brief Peeks at the top of the queue without removing it.
     *
     * @return A reference to the item at the front of the queue, assuming there's an item in the queue (as per previous implementation)
     */
    T& peek()
    {
        std::lock_guard<std::mutex> lock(_lock);
        return _queue.front();
    }

    /**
     * @brief Cancels the queue, preventing further processing of items.
     */
    void cancel()
    {
        _canceled.store(true, std::memory_order_release);
    }

    /**
     * @brief Checks if the queue has been canceled.
     *
     * @return true if the queue is canceled, false otherwise.
     */
    bool cancelled() const
    {
        return _canceled.load(std::memory_order_acquire);
    }

    /**
     * @brief Checks if the queue is empty.
     *
     * @return true if the queue is empty, false otherwise.
     */
    bool empty() const
    {
        std::lock_guard<std::mutex> lock(_lock);
        return _queue.empty();
    }

    /**
     * @brief Removes the item at the front of the queue.
     */
    void pop_front()
    {
        std::lock_guard<std::mutex> lock(_lock);
        _queue.pop_front();
    }
};

#endif
