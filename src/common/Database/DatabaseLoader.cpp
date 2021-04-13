/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "DatabaseLoader.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Duration.h"
#include <mysqld_error.h>
#include <errmsg.h>

template <class T>
DatabaseLoader& DatabaseLoader::AddDatabase(DatabaseWorkerPool<T>& pool, std::string const& name)
{
    _open.push([this, name, &pool]() -> bool
    {
        std::string const dbString = sConfigMgr->GetOption<std::string>(name + "DatabaseInfo", "");
        if (dbString.empty())
        {
            sLog->outSQLDriver("Database %s not specified in configuration file!", name.c_str());
            return false;
        }

        uint8 const asyncThreads = sConfigMgr->GetOption<uint8>(name + "Database.WorkerThreads", 1);
        if (asyncThreads < 1 || asyncThreads > 32)
        {
            sLog->outSQLDriver("%s database: invalid number of worker threads specified. Please pick a value between 1 and 32.", name.c_str());
            return false;
        }

        uint8 const synchThreads = sConfigMgr->GetOption<uint8>(name + "Database.SynchThreads", 1);

        pool.SetConnectionInfo(dbString, asyncThreads, synchThreads);

        if (uint32 error = pool.Open())
        {
            // Try reconnect
            if (error == CR_CONNECTION_ERROR)
            {
                // Possible improvement for future: make ATTEMPTS and SECONDS configurable values
                uint32 const ATTEMPTS = 5;
                Seconds durationSecs = 5s;
                uint32 count = 1;

                auto sleepThread = [&]()
                {
                    sLog->outSQLDriver("> Retrying after %u seconds", durationSecs.count());
                    std::this_thread::sleep_for(durationSecs);
                };

                sleepThread();

                do
                {
                    error = pool.Open();

                    if (error == CR_CONNECTION_ERROR)
                    {
                        sleepThread();
                        count++;
                    }
                    else
                    {
                        break;
                    }

                } while (count < ATTEMPTS);
            }

            // If the error wasn't handled quit
            if (error)
            {
                sLog->outSQLDriver("DatabasePool %s NOT opened. There were errors opening the MySQL connections. Check your SQLDriverLogFile for specific errors", name.c_str());
                return false;
            }
        }

        // Add the close operation
        _close.push([&pool]
        {
            pool.Close();
        });

        return true;
    });

    _prepare.push([name, &pool]() -> bool
    {
        if (!pool.PrepareStatements())
        {
            sLog->outSQLDriver("Could not prepare statements of the %s database, see log for details.", name.c_str());
            return false;
        }

        return true;
    });

    return *this;
}

bool DatabaseLoader::Load()
{
    return OpenDatabases() && PrepareStatements();
}

bool DatabaseLoader::OpenDatabases()
{
    return Process(_open);
}

bool DatabaseLoader::PrepareStatements()
{
    return Process(_prepare);
}

bool DatabaseLoader::Process(std::queue<Predicate>& queue)
{
    while (!queue.empty())
    {
        if (!queue.front()())
        {
            // Close all open databases which have a registered close operation
            while (!_close.empty())
            {
                _close.top()();
                _close.pop();
            }

            return false;
        }

        queue.pop();
    }

    return true;
}

template DatabaseLoader& DatabaseLoader::AddDatabase<LoginDatabaseConnection>(DatabaseWorkerPool<LoginDatabaseConnection>&, std::string const&);
template DatabaseLoader& DatabaseLoader::AddDatabase<CharacterDatabaseConnection>(DatabaseWorkerPool<CharacterDatabaseConnection>&, std::string const&);
template DatabaseLoader& DatabaseLoader::AddDatabase<WorldDatabaseConnection>(DatabaseWorkerPool<WorldDatabaseConnection>&, std::string const&);
