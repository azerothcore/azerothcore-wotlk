/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _WORKERTHREAD_H
#define _WORKERTHREAD_H

#include <thread>
#include <atomic>

#include "Threading/LockedQueue.h"

class MySQLConnection;
class SQLOperation;

class DatabaseWorker
{
public:
    DatabaseWorker() = delete;
    DatabaseWorker(LockedQueue<SQLOperation*>* new_queue, MySQLConnection* con);

    void shutdown();

private:
    void work();

    std::atomic_bool m_shutdown;
    std::thread m_thread;

    LockedQueue<SQLOperation*>* const m_queue;
    MySQLConnection* const m_conn;
};

#endif
