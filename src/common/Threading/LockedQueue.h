/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef LOCKEDQUEUE_H
#define LOCKEDQUEUE_H

#include <deque>
#include <assert.h>
#include <mutex>
#include "Debugging/Errors.h"
#include "Policies/Lock.h"

namespace ACORE
{
    template <class T, typename StorageType=std::deque<T> >
        class LockedQueue
    {
        //! Lock access to the queue.
        std::mutex _lock;

        //! Storage backing the queue.
        StorageType _queue;

        //! Cancellation flag.
        volatile bool _canceled;

        public:

            //! Create a LockedQueue.
            LockedQueue()
                : _canceled(false)
            {
            }

            //! Destroy a LockedQueue.
            virtual ~LockedQueue()
            {
            }

            //! Adds an item to the queue.
            void add(const T& item)
            {
                lock();

                //ASSERT(!this->_canceled);
                // throw Cancellation_Exception();

                _queue.push_back(item);

                unlock();
            }

            //! Gets the next result in the queue, if any.
            bool next(T& result)
            {
                GUARD_RETURN(_lock, false);

                if (_queue.empty())
                    return false;

                //ASSERT (!_queue.empty() || !this->_canceled);
                // throw Cancellation_Exception();
                result = _queue.front();
                _queue.pop_front();

                return true;
            }

            template<class Checker>
            bool next(T& result, Checker& check)
            {
                std::lock_guard<decltype(_lock)> g(_lock);

                if (_queue.empty())
                    return false;

                result = _queue.front();
                if (!check.Process(result))
                    return false;

                _queue.pop_front();
                return true;
            }

            //! Peeks at the top of the queue. Check if the queue is empty before calling! Remember to unlock after use if autoUnlock == false.
            T& peek(bool autoUnlock = false)
            {
                lock();

                T& result = _queue.front();

                if (autoUnlock)
                    unlock();

                return result;
            }

            //! Cancels the queue.
            void cancel()
            {
                lock();

                _canceled = true;

                unlock();
            }

            //! Checks if the queue is cancelled.
            bool cancelled()
            {
                std::lock_guard<decltype(_lock)> g(_lock);
                return _canceled;
            }

            //! Locks the queue for access.
            void lock()
            {
                _lock.lock();
            }

            //! Unlocks the queue.
            void unlock()
            {
                _lock.unlock();
            }

            ///! Calls pop_front of the queue
            void pop_front()
            {
                std::lock_guard<decltype(_lock)> g(_lock);
                _queue.pop_front();
            }

            ///! Checks if we're empty or not with locks held
            bool empty()
            {
                GUARD_RETURN(_lock, false);
                return _queue.empty();
            }
    };
}
#endif
