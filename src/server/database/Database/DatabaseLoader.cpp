/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "DatabaseLoader.h"
#include "Config.h"
#include "DBUpdater.h"
#include "DatabaseEnv.h"
#include "Duration.h"
#include "Log.h"
#include <errmsg.h>
#include <mysqld_error.h>
#include <thread>

DatabaseLoader::DatabaseLoader(std::string const& logger, uint32 const defaultUpdateMask)
    : _logger(logger), _autoSetup(sConfigMgr->GetOption<bool>("Updates.AutoSetup", true)),
    _updateFlags(sConfigMgr->GetOption<uint32>("Updates.EnableDatabases", defaultUpdateMask))
{
}

template <class T>
DatabaseLoader& DatabaseLoader::AddDatabase(DatabaseWorkerPool<T>& pool, std::string const& name)
{
    bool const updatesEnabledForThis = DBUpdater<T>::IsEnabled(_updateFlags);

    _open.push([this, name, updatesEnabledForThis, &pool]() -> bool
    {
        std::string const dbString = sConfigMgr->GetOption<std::string>(name + "DatabaseInfo", "");
        if (dbString.empty())
        {
            LOG_ERROR(_logger, "Database %s not specified in configuration file!", name.c_str());
            return false;
        }

        uint8 const asyncThreads = sConfigMgr->GetOption<uint8>(name + "Database.WorkerThreads", 1);
        if (asyncThreads < 1 || asyncThreads > 32)
        {
            LOG_ERROR(_logger, "%s database: invalid number of worker threads specified. "
                      "Please pick a value between 1 and 32.", name.c_str());
            return false;
        }

        uint8 const synchThreads = sConfigMgr->GetOption<uint8>(name + "Database.SynchThreads", 1);

        pool.SetConnectionInfo(dbString, asyncThreads, synchThreads);

        if (uint32 error = pool.Open())
        {
            // Try reconnect
            if (error == CR_CONNECTION_ERROR)
            {
                uint8 const attempts = sConfigMgr->GetOption<uint8>("Database.Reconnect.Attempts", 20);
                Seconds reconnectSeconds = Seconds(sConfigMgr->GetOption<uint8>("Database.Reconnect.Seconds", 15));
                uint8 reconnectCount = 0;

                while (reconnectCount < attempts)
                {
                    LOG_INFO(_logger, "> Retrying after %u seconds", static_cast<uint32>(reconnectSeconds.count()));
                    std::this_thread::sleep_for(reconnectSeconds);
                    error = pool.Open();

                    if (error == CR_CONNECTION_ERROR)
                    {
                        reconnectCount++;
                    }
                    else
                    {
                        break;
                    }
                }
            }

            // Database does not exist
            if ((error == ER_BAD_DB_ERROR) && updatesEnabledForThis && _autoSetup && !sConfigMgr->isDryRun())
            {
                // Try to create the database and connect again if auto setup is enabled
                if (DBUpdater<T>::Create(pool) && (!pool.Open()))
                {
                    error = 0;
                }
            }

            // If the error wasn't handled quit
            if (error)
            {
                LOG_ERROR(_logger, "DatabasePool %s NOT opened. There were errors opening the MySQL connections. "
                          "Check your log file for specific errors", name.c_str());

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

    // Populate and update only if updates are enabled for this pool
    if (updatesEnabledForThis && !sConfigMgr->isDryRun())
    {
        _populate.push([this, name, &pool]() -> bool
        {
            if (!DBUpdater<T>::Populate(pool))
            {
                LOG_ERROR(_logger, "Could not populate the %s database, see log for details.", name.c_str());
                return false;
            }

            return true;
        });

        _update.push([this, name, &pool]() -> bool
        {
            if (!DBUpdater<T>::Update(pool))
            {
                LOG_ERROR(_logger, "Could not update the %s database, see log for details.", name.c_str());
                return false;
            }

            return true;
        });
    }

    _prepare.push([this, name, &pool]() -> bool
    {
        if (!pool.PrepareStatements())
        {
            LOG_ERROR(_logger, "Could not prepare statements of the %s database, see log for details.", name.c_str());
            return false;
        }

        return true;
    });

    return *this;
}

bool DatabaseLoader::Load()
{
    return OpenDatabases() && PopulateDatabases() && UpdateDatabases() && PrepareStatements();
}

bool DatabaseLoader::OpenDatabases()
{
    return Process(_open);
}

bool DatabaseLoader::PopulateDatabases()
{
    return Process(_populate);
}

bool DatabaseLoader::UpdateDatabases()
{
    return Process(_update);
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

template AC_DATABASE_API
DatabaseLoader& DatabaseLoader::AddDatabase<LoginDatabaseConnection>(DatabaseWorkerPool<LoginDatabaseConnection>&, std::string const&);
template AC_DATABASE_API
DatabaseLoader& DatabaseLoader::AddDatabase<CharacterDatabaseConnection>(DatabaseWorkerPool<CharacterDatabaseConnection>&, std::string const&);
template AC_DATABASE_API
DatabaseLoader& DatabaseLoader::AddDatabase<WorldDatabaseConnection>(DatabaseWorkerPool<WorldDatabaseConnection>&, std::string const&);
