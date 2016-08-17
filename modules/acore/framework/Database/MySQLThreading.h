/*
 * Copyright (C) 
 *
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MYSQLTHREADING_H
#define _MYSQLTHREADING_H

#include "Log.h"

class MySQL
{
    public:
        /*! Create a thread on the MySQL server to mirrior the calling thread,
            initializes thread-specific variables and allows thread-specific
            operations without concurrence from other threads.
            This should only be called if multiple core threads are running
            on the same MySQL connection. Seperate MySQL connections implicitly
            create a mirror thread.
        */
        static void Thread_Init()
        {
            mysql_thread_init();
            sLog->outSQLDriver("Core thread with ID [" UI64FMTD "] initializing MySQL thread.",
                    (uint64)ACE_Based::Thread::currentId());
        }

        /*! Shuts down MySQL thread and frees resources, should only be called
            when we terminate. MySQL threads and connections are not configurable
            during runtime.
        */
        static void Thread_End()
        {
            mysql_thread_end();
            sLog->outSQLDriver("Core thread with ID [" UI64FMTD "] shutting down MySQL thread.",
                (uint64)ACE_Based::Thread::currentId());
        }

        static void Library_Init()
        {
            mysql_library_init(-1, NULL, NULL);
        }

        static void Library_End()
        {
            mysql_library_end();
        }
};

#endif