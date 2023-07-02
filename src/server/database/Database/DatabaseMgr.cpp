/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "DatabaseMgr.h"
#include "Config.h"
#include "DBUpdater.h"
#include "DatabaseWorkerPool.h"
#include "Log.h"
#include "Timer.h"
#include <errmsg.h>
#include <mysql.h>
#include <mysqld_error.h>

DatabaseMgr::DatabaseMgr()
{
    mysql_library_init(0, nullptr, nullptr);

    _autoSetup = sConfigMgr->GetOption<bool>("Updates.AutoSetup", true);
    _updateFlags = sConfigMgr->GetOption<uint32>("Updates.EnableDatabases", 0);
}

DatabaseMgr::~DatabaseMgr()
{
    mysql_library_end();
}

/*static*/ DatabaseMgr* DatabaseMgr::instance()
{
    static DatabaseMgr instance;
    return &instance;
}

void DatabaseMgr::AddDatabase(DatabaseWorkerPool& pool, std::string_view name)
{
    // #1. Set name for pool
    pool.SetPoolName(name);

    // #2. Check option for enable auto update this pool
    bool const updatesEnabledForThis = DBUpdater::IsEnabled(pool, _updateFlags);

    _open.emplace([this, name, updatesEnabledForThis, &pool]() -> bool
    {
       auto const dbString = sConfigMgr->GetOption<std::string>(std::string(name) + "DatabaseInfo", "");
       if (dbString.empty())
       {
           LOG_ERROR("db", "Database {} not specified in configuration file!", name);
           return false;
       }

       pool.SetConnectionInfo(dbString);

       if (uint32 error = pool.Open())
       {
           // Try to reconnect
           if (error == CR_CONNECTION_ERROR)
           {
               auto const attempts = sConfigMgr->GetOption<uint8>("Database.Reconnect.Attempts", 20);
               Seconds reconnectSeconds = Seconds(sConfigMgr->GetOption<uint8>("Database.Reconnect.Seconds", 15));
               uint8 reconnectCount = 0;

               while (reconnectCount < attempts)
               {
                   LOG_WARN("db", "> Retrying after {} seconds", reconnectSeconds.count());
                   std::this_thread::sleep_for(reconnectSeconds);
                   error = pool.Open();

                   if (error == CR_CONNECTION_ERROR)
                       reconnectCount++;
                   else
                       break;
               }
           }

           // Database does not exist
           if (error == ER_BAD_DB_ERROR && updatesEnabledForThis && _autoSetup)
           {
               // Try to create the database and connect again if auto setup is enabled
               if (DBUpdater::Create(pool) && !pool.Open())
                   error = 0;
           }

           // If the error wasn't handled quit
           if (error)
           {
               LOG_ERROR("db", "DatabasePool {} NOT opened. There were errors opening the MySQL connections. "
                  "Check your log file for specific errors", name);

               return false;
           }
       }

       // Add the close operation
       _close.emplace([&pool]
       {
           pool.Close();
       });

       return true;
    });

    // Populate and update only if updates are enabled for this pool
    if (updatesEnabledForThis)
    {
        _populate.emplace([this, name, &pool]() -> bool
        {
           if (!DBUpdater::Populate(pool))
           {
               LOG_ERROR("db", "Could not populate the {} database, see log for details.", name);
               return false;
           }

           return true;
        });

        _update.emplace([this, name, &pool]() -> bool
        {
             if (!DBUpdater::Update(pool, _modulesList))
             {
                 LOG_ERROR("db", "Could not update the {} database, see log for details.", name);
                 return false;
             }

             return true;
        });
    }

    _prepare.emplace([this, name, &pool]() -> bool
    {
        if (!pool.PrepareStatements())
        {
            LOG_ERROR("db", "Could not prepare statements of the {} database, see log for details.", name);
            return false;
        }

        _poolList.emplace_back(&pool);
        return true;
    });
}

bool DatabaseMgr::Load()
{
    if (!_updateFlags)
        LOG_INFO("db.update", "Automatic database updates are disabled for all databases!");

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

bool DatabaseMgr::OpenDatabases()
{
    return Process(_open);
}

bool DatabaseMgr::PopulateDatabases()
{
    return Process(_populate);
}

bool DatabaseMgr::UpdateDatabases()
{
    return Process(_update);
}

bool DatabaseMgr::PrepareStatements()
{
    return Process(_prepare);
}

bool DatabaseMgr::Process(std::queue<Predicate>& queue)
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

void DatabaseMgr::CloseAllConnections()
{
    LOG_INFO("db", "> Close all database connections...");

    // Close all open databases which have a registered close operation
    while (!_close.empty())
    {
        _close.top()();
        _close.pop();
    }
}

void DatabaseMgr::Update(Milliseconds diff)
{
    if (_poolList.empty())
        return;

    for (auto const& pool : _poolList)
        if (pool)
            pool->Update(diff);
}

uint32 DatabaseMgr::GetDatabaseLibraryVersion()
{
    return MYSQL_VERSION_ID;
}

/*static*/ std::string_view DatabaseMgr::GetClientInfo()
{
    return { mysql_get_client_info() };
}

/*static*/ std::string_view DatabaseMgr::GetServerVersion()
{
    return { MYSQL_SERVER_VERSION };
}
