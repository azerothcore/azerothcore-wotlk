/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _WORKERTHREAD_H
#define _WORKERTHREAD_H

#include "Define.h"
#include <atomic>
#include <thread>

template <typename T>
class ProducerConsumerQueue;

class MySQLConnection;
class SQLOperation;

class AC_DATABASE_API DatabaseWorker
{
public:
    DatabaseWorker(ProducerConsumerQueue<SQLOperation*>* newQueue, MySQLConnection* connection);
    ~DatabaseWorker();

private:
    ProducerConsumerQueue<SQLOperation*>* _queue;
    MySQLConnection* _connection;

    void WorkerThread();
    std::thread _workerThread;

    std::atomic<bool> _cancelationToken;

    DatabaseWorker(DatabaseWorker const& right) = delete;
    DatabaseWorker& operator=(DatabaseWorker const& right) = delete;
};

#endif
