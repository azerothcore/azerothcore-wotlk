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

#ifndef MPSCQueue_h__
#define MPSCQueue_h__

#include <atomic>
#include <memory>

namespace Acore::Impl
{
    /**
     * @brief C++ implementation of Dmitry Vyukov's lock-free MPSC queue (Non-Intrusive).
     *
     * This queue allows multiple producers to enqueue items concurrently, but only one consumer
     * can dequeue items. The queue is lock-free and non-intrusive, meaning it does not modify
     * the data types that are enqueued.
     *
     * @tparam T The type of data that is being enqueued in the queue.
     */
    template<typename T>
    class MPSCQueueNonIntrusive
    {
    public:
        /**
         * @brief Constructs a new MPSCQueueNonIntrusive object.
         *
         * Initializes the queue with a dummy node and sets up atomic pointers to the head and tail.
         */
        MPSCQueueNonIntrusive()
            : _head(new Node(nullptr)), _tail(_head.load(std::memory_order_acquire))
        {
            Node* front = _head.load(std::memory_order_acquire);
            front->Next.store(nullptr, std::memory_order_release);  ///< Store with release to ensure visibility
        }

        /**
         * @brief Destroys the MPSCQueueNonIntrusive object.
         *
         * Dequeues all items and deletes them, followed by proper cleanup of remaining nodes in the queue.
         */
        ~MPSCQueueNonIntrusive()
        {
            T* output;
            while (Dequeue(output))
                delete output;

            // Properly delete remaining nodes
            Node* front = _head.load(std::memory_order_acquire);
            while (front)
            {
                Node* next = front->Next.load(std::memory_order_acquire);
                delete front;
                front = next;
            }
        }

        /**
         * @brief Enqueues a new item in the queue.
         *
         * This function adds a new item at the head of the queue.
         *
         * @param input Pointer to the item to be enqueued.
         */
        void Enqueue(T* input)
        {
            Node* node = new Node(input);
            Node* prevHead = _head.exchange(node, std::memory_order_acq_rel);  ///< Exchange with acquire-release semantics
            prevHead->Next.store(node, std::memory_order_release);
        }

        /**
         * @brief Dequeues an item from the queue.
         *
         * This function removes the item at the front of the queue and returns it.
         *
         * @param result Reference to a pointer where the dequeued item will be stored.
         * @return True if an item was successfully dequeued, false if the queue was empty.
         */
        bool Dequeue(T*& result)
        {
            Node* tail = _tail.load(std::memory_order_acquire);
            Node* next = tail->Next.load(std::memory_order_acquire);
            if (!next)
                return false;

            result = next->Data;
            _tail.store(next, std::memory_order_release);
            delete tail;
            return true;
        }

    private:
        /**
         * @brief A structure representing a node in the queue.
         *
         * Each node holds a pointer to data and an atomic pointer to the next node in the queue.
         */
        struct Node
        {
            Node() = default;
            explicit Node(T* data) : Data(data)
            {
                Next.store(nullptr, std::memory_order_release);
            }

            T* Data; ///< Data stored in the node
            std::atomic<Node*> Next; ///< Atomic pointer to the next node
        };

        std::atomic<Node*> _head; ///< Atomic pointer to the head node of the queue
        std::atomic<Node*> _tail; ///< Atomic pointer to the tail node of the queue

        MPSCQueueNonIntrusive(MPSCQueueNonIntrusive const&) = delete; ///< Deleted copy constructor
        MPSCQueueNonIntrusive& operator=(MPSCQueueNonIntrusive const&) = delete; ///< Deleted copy assignment operator
    };

    /**
     * @brief C++ implementation of Dmitry Vyukov's lock-free MPSC queue (Intrusive).
     *
     * This queue allows multiple producers to enqueue items concurrently, but only one consumer
     * can dequeue items. The queue is lock-free and intrusive, meaning that the enqueued objects
     * must have an atomic link to the next item in the queue.
     *
     * @tparam T The type of data that is being enqueued in the queue.
     * @tparam IntrusiveLink A member pointer to the atomic link used for linking the nodes.
     */
    template<typename T, std::atomic<T*> T::* IntrusiveLink>
    class MPSCQueueIntrusive
    {
    public:
        /**
         * @brief Constructs a new MPSCQueueIntrusive object.
         *
         * Initializes the queue with a dummy node and sets up atomic pointers to the head and tail.
         * The dummy node's atomic link is initialized.
         */
        MPSCQueueIntrusive()
            : _dummyPtr(reinterpret_cast<T*>(std::addressof(_dummy))), _head(_dummyPtr), _tail(_dummyPtr)
        {
            // Initialize the intrusive link in the dummy node
            std::atomic<T*>* dummyNext = new (&(_dummyPtr->*IntrusiveLink)) std::atomic<T*>();
            dummyNext->store(nullptr, std::memory_order_release);
        }

        /**
         * @brief Destroys the MPSCQueueIntrusive object.
         *
         * Dequeues all items and deletes them.
         */
        ~MPSCQueueIntrusive()
        {
            T* output;
            while (Dequeue(output))
                delete output;
        }

        /**
         * @brief Enqueues a new item in the queue.
         *
         * This function adds a new item at the head of the queue.
         *
         * @param input Pointer to the item to be enqueued.
         */
        void Enqueue(T* input)
        {
            // Set the next link to nullptr initially
            (input->*IntrusiveLink).store(nullptr, std::memory_order_release);
            T* prevHead = _head.exchange(input, std::memory_order_acq_rel);  ///< Exchange with acquire-release semantics
            (prevHead->*IntrusiveLink).store(input, std::memory_order_release);
        }

        /**
         * @brief Dequeues an item from the queue.
         *
         * This function removes the item at the front of the queue and returns it.
         *
         * @param result Reference to a pointer where the dequeued item will be stored.
         * @return True if an item was successfully dequeued, false if the queue was empty.
         */
        bool Dequeue(T*& result)
        {
            T* tail = _tail.load(std::memory_order_acquire);
            T* next = (tail->*IntrusiveLink).load(std::memory_order_acquire);
            if (tail == _dummyPtr)
            {
                if (!next)
                    return false;

                _tail.store(next, std::memory_order_release);
                tail = next;
                next = (next->*IntrusiveLink).load(std::memory_order_acquire);
            }

            if (next)
            {
                _tail.store(next, std::memory_order_release);
                result = tail;
                return true;
            }

            T* head = _head.load(std::memory_order_acquire);
            if (tail != head)
                return false;

            Enqueue(_dummyPtr);
            next = (tail->*IntrusiveLink).load(std::memory_order_acquire);
            if (next)
            {
                _tail.store(next, std::memory_order_release);
                result = tail;
                return true;
            }
            return false;
        }

    private:
        std::aligned_storage_t<sizeof(T), alignof(T)> _dummy;  ///< Storage for the dummy object
        T* _dummyPtr; ///< Pointer to the dummy object
        std::atomic<T*> _head; ///< Atomic pointer to the head node of the queue
        std::atomic<T*> _tail; ///< Atomic pointer to the tail node of the queue

        MPSCQueueIntrusive(MPSCQueueIntrusive const&) = delete; ///< Deleted copy constructor
        MPSCQueueIntrusive& operator=(MPSCQueueIntrusive const&) = delete; ///< Deleted copy assignment operator
    };
}

/**
 * @brief Conditional type alias for MPSCQueue.
 *
 * This alias provides the appropriate type of MPSCQueue based on whether the queue is intrusive
 * or non-intrusive.
 *
 * @tparam T The type of data that is being enqueued in the queue.
 * @tparam IntrusiveLink If provided, the queue will be intrusive, otherwise, it will be non-intrusive.
 */
template<typename T, std::atomic<T*> T::* IntrusiveLink = nullptr>
using MPSCQueue = std::conditional_t<IntrusiveLink != nullptr, Acore::Impl::MPSCQueueIntrusive<T, IntrusiveLink>, Acore::Impl::MPSCQueueNonIntrusive<T>>;

#endif // MPSCQueue_h__
