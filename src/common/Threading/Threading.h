/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef THREADING_H
#define THREADING_H

#include <thread>
#include <atomic>

#include <thread>
#include <atomic>

namespace acore
{
    class Runnable
    {
        public:
            virtual ~Runnable() {}
            virtual void run() = 0;

            void incReference() { ++m_refs; }
            void decReference()
            {
                if (!--m_refs)
                    delete this;
            }
        private:
            std::atomic_long m_refs;
    };

    enum Priority
    {
        Priority_Idle,
        Priority_Lowest,
        Priority_Low,
        Priority_Normal,
        Priority_High,
        Priority_Highest,
        Priority_Realtime,
    };

    class Thread
    {
        public:
            Thread();
            explicit Thread(Runnable* instance);
            ~Thread();

            bool wait();
            void destroy();

            void setPriority(Priority type);

            static void Sleep(unsigned long msecs);
            static std::thread::id currentId();

        private:
            Thread(const Thread&);
            Thread& operator=(const Thread&);

            static void ThreadTask(void* param);

            Runnable* const m_task;
            std::thread::id m_iThreadId;
            std::thread m_ThreadImp;
    };
}
#endif
