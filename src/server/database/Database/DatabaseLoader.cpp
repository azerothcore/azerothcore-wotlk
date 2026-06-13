/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
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
#include <string_view>
namespace
{
    std::string const EMPTY_DATABASE_INFO;
    std::string const LOGIN_DATABASE_INFO_DEFAULT = "127.0.0.1;3306;acore;acore;acore_auth";
    std::string const WORLD_DATABASE_INFO_DEFAULT = "127.0.0.1;3306;acore;acore;acore_world";
    std::string const CHARACTER_DATABASE_INFO_DEFAULT = "127.0.0.1;3306;acore;acore;acore_characters";
    std::string const& GetDefaultDatabaseInfo(std::string_view name)
    {
        if (name == "Login")
            return LOGIN_DATABASE_INFO_DEFAULT;
        if (name == "World")
            return WORLD_DATABASE_INFO_DEFAULT;
        if (name == "Character")
            return CHARACTER_DATABASE_INFO_DEFAULT;
        return EMPTY_DATABASE_INFO;
    }
}

DatabaseLoader::DatabaseLoader(std::string const& logger, uint32 const defaultUpdateMask, std::string_view modulesList)
    : _logger(logger),
    _modulesList(modulesList),
    _autoSetup(sConfigMgr->GetOption<bool>("Updates.AutoSetup", true)),
    _updateFlags(sConfigMgr->GetOption<uint32>("Updates.EnableDatabases", defaultUpdateMask)) { }

template <class T>
DatabaseLoader& DatabaseLoader::AddDatabase(DatabaseWorkerPool<T>& pool, std::string const& name)
{
    bool const updatesEnabledForThis = DBUpdater<T>::IsEnabled(_updateFlags);

    _open.push([this, name, updatesEnabledForThis, &pool]() -> bool
    {
        std::string const& defaultDatabaseInfo = GetDefaultDatabaseInfo(name);
        std::string const dbString = sConfigMgr->GetOption<std::string>(name + "DatabaseInfo", defaultDatabaseInfo);
        if (dbString.empty())
        {
            LOG_ERROR(_logger, "Database {} not specified in configuration file!", name);
            return false;
        }

        uint8 const asyncThreads = sConfigMgr->GetOption<uint8>(name + "Database.WorkerThreads", 1);
        if (asyncThreads < 1 || asyncThreads > 32)
        {
            LOG_ERROR(_logger, "{} database: invalid number of worker threads specified. "
                      "Please pick a value between 1 and 32.", name);
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
                    LOG_WARN(_logger, "> Retrying after {} seconds", static_cast<uint32>(reconnectSeconds.count()));
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
            if ((error == ER_BAD_DB_ERROR) && updatesEnabledForThis && _autoSetup)
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
                LOG_ERROR(_logger, "DatabasePool {} NOT opened. There were errors opening the MySQL connections. "
                          "Check your log file for specific errors", name);

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
    if (updatesEnabledForThis)
    {
        _populate.push([this, name, &pool]() -> bool
        {
            if (!DBUpdater<T>::Populate(pool))
            {
                LOG_ERROR(_logger, "Could not populate the {} database, see log for details.", name);
                return false;
            }

            return true;
        });

        _update.push([this, name, &pool]() -> bool
        {
            if (!DBUpdater<T>::Update(pool, _modulesList))
            {
                LOG_ERROR(_logger, "Could not update the {} database, see log for details.", name);
                return false;
            }

            return true;
        });
    }

    _prepare.push([this, name, &pool]() -> bool
    {
        if (!pool.PrepareStatements())
        {
            LOG_ERROR(_logger, "Could not prepare statements of the {} database, see log for details.", name);
            return false;
        }

        return true;
    });

    return *this;
}

bool DatabaseLoader::Load()
{
    if (!_updateFlags)
        LOG_WARN("sql.updates", "> AUTOUPDATER: Automatic database updates are disabled for all databases in the config! This is not recommended!");

    if (!OpenDatabases())
        return false;

    if (!PopulateDatabases())
        return false;

    if (!UpdateDatabases())
        return false;

    if (!PrepareStatements())
        return false;

    return true;
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
