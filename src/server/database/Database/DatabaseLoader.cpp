/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "DatabaseLoader.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Duration.h"
#include <errmsg.h>
#include <thread>

template <class T>
DatabaseLoader& DatabaseLoader::AddDatabase(DatabaseWorkerPool<T>& pool, std::string const& name)
{
    _open.push([this, name, &pool]() -> bool
    {
        std::string const dbString = sConfigMgr->GetOption<std::string>(name + "DatabaseInfo", "");
        if (dbString.empty())
        {
            LOG_INFO("sql.driver", "Database %s not specified in configuration file!", name.c_str());
            return false;
        }

        uint8 const asyncThreads = sConfigMgr->GetOption<uint8>(name + "Database.WorkerThreads", 1);
        if (asyncThreads < 1 || asyncThreads > 32)
        {
            LOG_INFO("sql.driver", "%s database: invalid number of worker threads specified. Please pick a value between 1 and 32.", name.c_str());
            return false;
        }

        uint8 const synchThreads = sConfigMgr->GetOption<uint8>(name + "Database.SynchThreads", 1);

        pool.SetConnectionInfo(dbString, asyncThreads, synchThreads);

        if (uint32 error = pool.Open())
        {
            // Try reconnect
            if (error == CR_CONNECTION_ERROR)
            {
                uint8 const ATTEMPTS = sConfigMgr->GetOption<uint8>("Database.Reconnect.Attempts", 20);
                Seconds RECONNECT_SECONDS = Seconds(sConfigMgr->GetOption<uint8>("Database.Reconnect.Seconds", 15));
                uint8 count = 0;

                while (count < ATTEMPTS)
                {
                    LOG_INFO("sql.driver", "> Retrying after %u seconds", static_cast<uint32>(RECONNECT_SECONDS.count()));
                    std::this_thread::sleep_for(RECONNECT_SECONDS);
                    error = pool.Open();

                    if (error == CR_CONNECTION_ERROR)
                    {
                        count++;
                    }
                    else
                    {
                        break;
                    }

                }
            }

            // If the error wasn't handled quit
            if (error)
            {
                LOG_ERROR("sql.driver", "DatabasePool %s NOT opened. There were errors opening the MySQL connections. Check your SQLDriverLogFile for specific errors", name.c_str());
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
            LOG_ERROR("sql.driver", "Could not prepare statements of the %s database, see log for details.", name.c_str());
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
