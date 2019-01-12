/*
 * Copyright (C) 
 *
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _WORKERTHREAD_H
#define _WORKERTHREAD_H

#include "Define.h"
#include "ProducerConsumerQueue.h"

class MySQLConnection;

class DatabaseWorker
{
    public:
        DatabaseWorker(ProducerConsumerQueue<SQLOperation*>* newQueue, MySQLConnection* connection);
        ~DatabaseWorker();

    private:
        ProducerConsumerQueue<SQLOperation*>* _queue;
        MySQLConnection* _connection;

        void WorkerThread();
        std::thread _workerThread;

        std::atomic_bool _cancelationToken;
};

#endif
