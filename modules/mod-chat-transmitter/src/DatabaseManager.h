#ifndef _MOD_CHAT_TRANSMITTER_DATABASE_MANAGER_H_
#define _MOD_CHAT_TRANSMITTER_DATABASE_MANAGER_H_

#include "PCQueue.h"
#include "Requests/RequestQueryResult.h"
#include "ChatTransmitterDatabaseConnection.h"

namespace ModChatTransmitter
{
    enum QueryDatabase
    {
        Auth = 0,
        Characters = 1,
        World = 2,
        Eluna = 3,
    };

    class DatabaseManager
    {
    public:
        DatabaseManager();
        void Start();
        void QueueQuery(const std::string& id, const std::string& query, QueryDatabase dbType);
        bool GetResult(Requests::QueryResult*& outResult);
        void Stop();

    private:
        void HandleQuery(const std::string& id, const std::string& query, QueryDatabase dbType);
        void InitializeDatabase(const std::string& connectionString, MySQLConnectionInfo** connInfo, ProducerConsumerQueue<SQLOperation*>** sqlQueue, ChatTransmitterDatabaseConnection** database);
        void InitializeDatabase(const MySQLConnectionInfo* srcConnInfo, MySQLConnectionInfo** connInfo, ProducerConsumerQueue<SQLOperation*>** sqlQueue, ChatTransmitterDatabaseConnection** database);
        void CleanupDatabase(MySQLConnectionInfo* connInfo, ProducerConsumerQueue<SQLOperation*>* sqlQueue, ChatTransmitterDatabaseConnection** database);
        bool IsValidUtf8(const Binary& data);
        void Cleanup();

        struct WorkItem
        {
            std::string id;
            std::string query;
            QueryDatabase dbType;

            WorkItem(const std::string& id, const std::string& query, QueryDatabase dbType)
                : id(id),
                query(query),
                dbType(dbType)
            { }
        };

        ProducerConsumerQueue<WorkItem*> workQueue;
        ProducerConsumerQueue<Requests::QueryResult*> results;

        uint32 dbPingInterval;
        long long nextDbPingTime;

        MySQLConnectionInfo* authConnInfo;
        ProducerConsumerQueue<SQLOperation*>* authSqlQueue;
        ChatTransmitterDatabaseConnection* authDatabase;

        MySQLConnectionInfo* charsConnInfo;
        ProducerConsumerQueue<SQLOperation*>* charsSqlQueue;
        ChatTransmitterDatabaseConnection* charsDatabase;

        MySQLConnectionInfo* worldConnInfo;
        ProducerConsumerQueue<SQLOperation*>* worldSqlQueue;
        ChatTransmitterDatabaseConnection* worldDatabase;

        MySQLConnectionInfo* elunaConnInfo;
        ProducerConsumerQueue<SQLOperation*>* elunaSqlQueue;
        ChatTransmitterDatabaseConnection* elunaDatabase;

        std::atomic_bool stop;
    };
}

#endif // _MOD_CHAT_TRANSMITTER_DATABASE_MANAGER_H_
