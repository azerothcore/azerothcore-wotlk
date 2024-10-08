#include "Config.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "Time/GameTime.h"
#include "DatabaseManager.h"
#include "ChatTransmitter.h"
#include "Requests/RequestQueryResult.h"

namespace ModChatTransmitter
{
    DatabaseManager::DatabaseManager()
        : dbPingInterval(sConfigMgr->GetOption<int32>("MaxPingTime", 30)),
        nextDbPingTime(0),
        authConnInfo(nullptr), authSqlQueue(nullptr), authDatabase(nullptr),
        charsConnInfo(nullptr), charsSqlQueue(nullptr), charsDatabase(nullptr),
        worldConnInfo(nullptr), worldSqlQueue(nullptr), worldDatabase(nullptr),
        elunaConnInfo(nullptr), elunaSqlQueue(nullptr), elunaDatabase(nullptr),
        stop(false)
    { }

    void DatabaseManager::Start()
    {
        stop.store(false);

        InitializeDatabase(LoginDatabase.GetConnectionInfo(), &authConnInfo, &authSqlQueue, &authDatabase);
        InitializeDatabase(CharacterDatabase.GetConnectionInfo(), &charsConnInfo, &charsSqlQueue, &charsDatabase);
        InitializeDatabase(WorldDatabase.GetConnectionInfo(), &worldConnInfo, &worldSqlQueue, &worldDatabase);
        InitializeDatabase(ChatTransmitter::Instance().GetElunaDatabaseInfo(), &elunaConnInfo, &elunaSqlQueue, &elunaDatabase);
        if (!authDatabase || !charsDatabase || !worldDatabase || !elunaDatabase)
        {
            return;
        }

        nextDbPingTime = GameTime::GetGameTimeMS().count() + static_cast<long long>(dbPingInterval * MINUTE * IN_MILLISECONDS);

        while (true)
        {
            WorkItem* item = nullptr;
            workQueue.WaitAndPop(item);
            if (stop.load())
            {
                break;
            }
            if (item)
            {
                HandleQuery(item->id, item->query, item->dbType);
                delete item;
            }
        }

        Cleanup();
    }

    void DatabaseManager::QueueQuery(const std::string& id, const std::string& query, QueryDatabase dbType)
    {
        WorkItem* item = new WorkItem(id, query, dbType);
        workQueue.Push(item);
    }

    void DatabaseManager::HandleQuery(const std::string& id, const std::string& query, QueryDatabase dbType)
    {
        ChatTransmitterDatabaseConnection* db;
        switch (dbType)
        {
        case QueryDatabase::Auth:
            db = authDatabase;
            break;
        case QueryDatabase::Characters:
            db = charsDatabase;
            break;
        case QueryDatabase::World:
            db = worldDatabase;
            break;
        case QueryDatabase::Eluna:
            db = elunaDatabase;
            break;
        default:
            return;
        }

        if (!db)
        {
            results.Push(new Requests::QueryResult(id, false));
            return;
        }

        ResultSet* result = db->Query(query);
        if (!result)
        {
            if (db->GetLastError())
            {
                results.Push(new Requests::QueryResult(id, false, db->GetLastErrorString()));
            }
            else
            {
                results.Push(new Requests::QueryResult(id, db->GetAffectedRows()));
            }
            return;
        }

        std::vector<nlohmann::json> rows;
        std::vector<std::string> columns;

        rows.reserve(static_cast<size_t>(result->GetRowCount()));

        while (result->NextRow())
        {
            Field* row = result->Fetch();
            nlohmann::json jsonRow;
            bool fillColumns = columns.empty();

            for (uint32 col = 0; col < result->GetFieldCount(); ++col)
            {
                DatabaseFieldTypes t = row[col].GetType();
                std::string fieldName = result->GetFieldName(col);
                if (fillColumns)
                {
                    columns.push_back(fieldName);
                }

                switch (t)
                {
                case DatabaseFieldTypes::Null: jsonRow[fieldName] = nullptr; break;
                case DatabaseFieldTypes::Int8: jsonRow[fieldName] = row[col].Get<int8>(); break;
                case DatabaseFieldTypes::Int16: jsonRow[fieldName] = row[col].Get<int16>(); break;
                case DatabaseFieldTypes::Int32: jsonRow[fieldName] = row[col].Get<int32>(); break;
                case DatabaseFieldTypes::Int64: jsonRow[fieldName] = row[col].Get<int64>(); break;
                case DatabaseFieldTypes::Float: jsonRow[fieldName] = row[col].Get<float>(); break;
                case DatabaseFieldTypes::Double:
                case DatabaseFieldTypes::Decimal:
                    jsonRow[fieldName] = row[col].Get<double>();
                    break;
                case DatabaseFieldTypes::Date: jsonRow[fieldName] = row[col].Get<std::string>(); break;
                case DatabaseFieldTypes::Binary:
                    Binary binary = row[col].Get<Binary>();
                    if (IsValidUtf8(binary))
                    {
                        jsonRow[fieldName] = row[col].Get<std::string>();
                    }
                    else
                    {
                        jsonRow[fieldName] = binary;
                    }
                    break;
                }
            }

            rows.push_back(jsonRow);
        }

        results.Push(new Requests::QueryResult(id, rows, columns));
    }

    bool DatabaseManager::GetResult(Requests::QueryResult*& outResult)
    {
        return results.Pop(outResult);
    }

    void DatabaseManager::Stop()
    {
        stop.store(true);

        results.Cancel();
        workQueue.Cancel();
    }

    void DatabaseManager::InitializeDatabase(const MySQLConnectionInfo* srcConnInfo, MySQLConnectionInfo** connInfo, ProducerConsumerQueue<SQLOperation*>** sqlQueue, ChatTransmitterDatabaseConnection** database)
    {
        *connInfo = new MySQLConnectionInfo(*srcConnInfo);
        *sqlQueue = new ProducerConsumerQueue<SQLOperation*>();
        *database = new ChatTransmitterDatabaseConnection(*sqlQueue, **connInfo);

        uint32 res = (*database)->Open();
        if (res)
        {
            LOG_ERROR("module", "[ChatTransmitter] Could not open connection to database: err {}", res);
            *database = nullptr;
        }
    }

    void DatabaseManager::InitializeDatabase(const std::string& connectionString, MySQLConnectionInfo** connInfo, ProducerConsumerQueue<SQLOperation*>** sqlQueue, ChatTransmitterDatabaseConnection** database)
    {
        MySQLConnectionInfo* srcConnInfo = new MySQLConnectionInfo(connectionString);
        InitializeDatabase(srcConnInfo, connInfo, sqlQueue, database);
        delete srcConnInfo;
    }

    void DatabaseManager::CleanupDatabase(MySQLConnectionInfo* connInfo, ProducerConsumerQueue<SQLOperation*>* sqlQueue, ChatTransmitterDatabaseConnection** database)
    {
        (*database)->Close();
        sqlQueue->Cancel();
        delete *database;
        delete sqlQueue;
        delete connInfo;

        *database = nullptr;
    }

    bool DatabaseManager::IsValidUtf8(const Binary& data)
    {
        int cnt = 0;
        for (size_t i = 0; i < data.size(); i++)
        {
            int x = data[i];
            if (!cnt)
            {
                if ((x >> 5) == 0b110)
                {
                    cnt = 1;
                }
                else if ((x >> 4) == 0b1110)
                {
                    cnt = 2;
                }
                else if ((x >> 3) == 0b11110)
                {
                    cnt = 3;
                }
                else if ((x >> 7) != 0)
                {
                    return false;
                }
            }
            else
            {
                if ((x >> 6) != 0b10)
                {
                    return false;
                }
                cnt--;
            }
        }
        return cnt == 0;
    }

    void DatabaseManager::Cleanup()
    {
        CleanupDatabase(authConnInfo, authSqlQueue, &authDatabase);
        CleanupDatabase(charsConnInfo, charsSqlQueue, &charsDatabase);
        CleanupDatabase(worldConnInfo, worldSqlQueue, &worldDatabase);
        CleanupDatabase(elunaConnInfo, elunaSqlQueue, &elunaDatabase);
    }
}
