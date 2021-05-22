/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "MySQLThreading.h"
#include "Log.h"

/*! Create a thread on the MySQL server to mirrior the calling thread,
    initializes thread-specific variables and allows thread-specific
    operations without concurrence from other threads.
    This should only be called if multiple core threads are running
    on the same MySQL connection. Seperate MySQL connections implicitly
    create a mirror thread.
*/
void Thread_Init()
{
    mysql_thread_init();
}

/*! Shuts down MySQL thread and frees resources, should only be called
    when we terminate. MySQL threads and connections are not configurable
    during runtime.
*/
void Thread_End()
{
    mysql_thread_end();
}

void MySQL::Library_Init()
{
    mysql_library_init(-1, nullptr, nullptr);
}

void MySQL::Library_End()
{
    mysql_library_end();
}

uint32 MySQL::GetLibraryVersion()
{
    return MYSQL_VERSION_ID;
}
