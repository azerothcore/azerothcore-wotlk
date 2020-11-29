/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DatabaseEnv.h"
#include "DatabaseWorker.h"
#include "SQLOperation.h"
#include "MySQLConnection.h"
#include "MySQLThreading.h"

#include <queue>

DatabaseWorker::DatabaseWorker(ACE_Based::LockedQueue<SQLOperation*>* new_queue, MySQLConnection* con) :
    m_queue(new_queue),
    m_conn(con),
    m_thread(&DatabaseWorker::work, this)
{}

void DatabaseWorker::work()
{
    if (!m_queue)
        return;

    while (!m_shutdown)
    {
        SQLOperation* request;

        if (!m_queue->next(request))
            break;

        request->SetConnection(m_conn);
        request->call();

        delete request;
    }
}

void DatabaseWorker::shutdown()
{
    m_shutdown = true;
    m_thread.join();
}
