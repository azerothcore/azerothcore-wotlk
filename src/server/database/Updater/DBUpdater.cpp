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

#include "DBUpdater.h"
#include "BuiltInConfig.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DatabaseLoader.h"
#include "GitRevision.h"
#include "Log.h"
#include "StartProcess.h"
#include "UpdateFetcher.h"
#include <filesystem>
#include <fstream>
#include <iostream>

std::string DBUpdaterUtil::GetCorrectedMySQLExecutable()
{
    if (!corrected_path().empty())
        return corrected_path();
    else
        return BuiltInConfig::GetMySQLExecutable();
}

bool DBUpdaterUtil::CheckExecutable()
{
    std::filesystem::path exe(GetCorrectedMySQLExecutable());
    if (!is_regular_file(exe))
    {
        exe = Acore::SearchExecutableInPath("mysql");
        if (!exe.empty() && is_regular_file(exe))
        {
            // Correct the path to the cli
            corrected_path() = absolute(exe).generic_string();
            return true;
        }

        LOG_FATAL("sql.updates", "Didn't find any executable MySQL binary at \'{}\' or in path, correct the path in the *.conf (\"MySQLExecutable\").",
            absolute(exe).generic_string());

        return false;
    }
    return true;
}

std::string& DBUpdaterUtil::corrected_path()
{
    static std::string path;
    return path;
}

// Auth Database
template<>
std::string DBUpdater<LoginDatabaseConnection>::GetConfigEntry()
{
    return "Updates.Auth";
}

template<>
std::string DBUpdater<LoginDatabaseConnection>::GetTableName()
{
    return "Auth";
}

template<>
std::string DBUpdater<LoginDatabaseConnection>::GetBaseFilesDirectory()
{
    return BuiltInConfig::GetSourceDirectory() + "/data/sql/base/db_auth/";
}

template<>
bool DBUpdater<LoginDatabaseConnection>::IsEnabled(uint32 const updateMask)
{
    // This way silences warnings under msvc
    return (updateMask & DatabaseLoader::DATABASE_LOGIN) ? true : false;
}

template<>
std::string DBUpdater<LoginDatabaseConnection>::GetDBModuleName()
{
    return "db-auth";
}

// World Database
template<>
std::string DBUpdater<WorldDatabaseConnection>::GetConfigEntry()
{
    return "Updates.World";
}

template<>
std::string DBUpdater<WorldDatabaseConnection>::GetTableName()
{
    return "World";
}

template<>
std::string DBUpdater<WorldDatabaseConnection>::GetBaseFilesDirectory()
{
    return BuiltInConfig::GetSourceDirectory() + "/data/sql/base/db_world/";
}

template<>
bool DBUpdater<WorldDatabaseConnection>::IsEnabled(uint32 const updateMask)
{
    // This way silences warnings under msvc
    return (updateMask & DatabaseLoader::DATABASE_WORLD) ? true : false;
}

template<>
std::string DBUpdater<WorldDatabaseConnection>::GetDBModuleName()
{
    return "db-world";
}

// Character Database
template<>
std::string DBUpdater<CharacterDatabaseConnection>::GetConfigEntry()
{
    return "Updates.Character";
}

template<>
std::string DBUpdater<CharacterDatabaseConnection>::GetTableName()
{
    return "Character";
}

template<>
std::string DBUpdater<CharacterDatabaseConnection>::GetBaseFilesDirectory()
{
    return BuiltInConfig::GetSourceDirectory() + "/data/sql/base/db_characters/";
}

template<>
bool DBUpdater<CharacterDatabaseConnection>::IsEnabled(uint32 const updateMask)
{
    // This way silences warnings under msvc
    return (updateMask & DatabaseLoader::DATABASE_CHARACTER) ? true : false;
}

template<>
std::string DBUpdater<CharacterDatabaseConnection>::GetDBModuleName()
{
    return "db-characters";
}

// All
template<class T>
BaseLocation DBUpdater<T>::GetBaseLocationType()
{
    return LOCATION_REPOSITORY;
}

template<class T>
bool DBUpdater<T>::Create(DatabaseWorkerPool<T>& pool)
{
    LOG_WARN("sql.updates", "Database \"{}\" does not exist", pool.GetConnectionInfo()->database);

    const char* disableInteractive = std::getenv("AC_DISABLE_INTERACTIVE");

    if (!sConfigMgr->isDryRun() && (disableInteractive == nullptr || std::strcmp(disableInteractive, "1") != 0))
    {
        std::cout << "Do you want to create it? [yes (default) / no]:" << std::endl;
        std::string answer;
        std::getline(std::cin, answer);
        if (!answer.empty() && !(answer.substr(0, 1) == "y"))
            return false;
    }

    LOG_INFO("sql.updates", "Creating database \"{}\"...", pool.GetConnectionInfo()->database);

    // Path of temp file
    static Path const temp("create_table.sql");

    // Create temporary query to use external MySQL CLi
    std::ofstream file(temp.generic_string());
    if (!file.is_open())
    {
        LOG_FATAL("sql.updates", "Failed to create temporary query file \"{}\"!", temp.generic_string());
        return false;
    }

    file << "CREATE DATABASE `" << pool.GetConnectionInfo()->database << "` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci;\n\n";
    file.close();

    try
    {
        DBUpdater<T>::ApplyFile(pool, pool.GetConnectionInfo()->host, pool.GetConnectionInfo()->user, pool.GetConnectionInfo()->password,
                                pool.GetConnectionInfo()->port_or_socket, "", pool.GetConnectionInfo()->ssl, temp);
    }
    catch (UpdateException&)
    {
        LOG_FATAL("sql.updates", "Failed to create database {}! Does the user (named in *.conf) have `CREATE`, `ALTER`, `DROP`, `INSERT` and `DELETE` privileges on the MySQL server?", pool.GetConnectionInfo()->database);
        std::filesystem::remove(temp);
        return false;
    }

    LOG_INFO("sql.updates", "Done.");
    LOG_INFO("sql.updates", " ");
    std::filesystem::remove(temp);
    return true;
}

template<class T>
bool DBUpdater<T>::Update(DatabaseWorkerPool<T>& pool, std::string_view modulesList /*= {}*/)
{
    if (!DBUpdaterUtil::CheckExecutable())
        return false;

    LOG_INFO("sql.updates", "Updating {} database...", DBUpdater<T>::GetTableName());

    Path const sourceDirectory(BuiltInConfig::GetSourceDirectory());

    if (!is_directory(sourceDirectory))
    {
        LOG_ERROR("sql.updates", "DBUpdater: The given source directory {} does not exist, change the path to the directory where your sql directory exists (for example c:\\source\\azerothcore). Shutting down.",
                  sourceDirectory.generic_string());
        return false;
    }

    auto CheckUpdateTable = [&](std::string const& tableName)
    {
        auto checkTable = DBUpdater<T>::Retrieve(pool, Acore::StringFormat("SHOW TABLES LIKE '{}'", tableName));
        if (!checkTable)
        {
            LOG_WARN("sql.updates", "> Table '{}' not exist! Try add based table", tableName);

            Path const temp(GetBaseFilesDirectory() + tableName + ".sql");

            try
            {
                DBUpdater<T>::ApplyFile(pool, temp);
            }
            catch (UpdateException&)
            {
                LOG_FATAL("sql.updates", "Failed apply file to database {}! Does the user (named in *.conf) have `INSERT` and `DELETE` privileges on the MySQL server?", pool.GetConnectionInfo()->database);
                return false;
            }

            return true;
        }

        return true;
    };

    if (!CheckUpdateTable("updates") || !CheckUpdateTable("updates_include"))
        return false;

    UpdateFetcher updateFetcher(sourceDirectory, [&](std::string const & query) { DBUpdater<T>::Apply(pool, query); },
    [&](Path const & file) { DBUpdater<T>::ApplyFile(pool, file); },
    [&](std::string const & query) -> QueryResult { return DBUpdater<T>::Retrieve(pool, query); }, DBUpdater<T>::GetDBModuleName(), modulesList);

    UpdateResult result;
    try
    {
        result = updateFetcher.Update(
                     sConfigMgr->GetOption<bool>("Updates.Redundancy", true),
                     sConfigMgr->GetOption<bool>("Updates.AllowRehash", true),
                     sConfigMgr->GetOption<bool>("Updates.ArchivedRedundancy", false),
                     sConfigMgr->GetOption<int32>("Updates.CleanDeadRefMaxCount", 3));
    }
    catch (UpdateException&)
    {
        return false;
    }

    std::string const info = Acore::StringFormat("Containing {} new and {} archived updates.", result.recent, result.archived);

    if (!result.updated)
        LOG_INFO("sql.updates", ">> {} database is up-to-date! {}", DBUpdater<T>::GetTableName(), info);
    else
        LOG_INFO("sql.updates", ">> Applied {} {}. {}", result.updated, result.updated == 1 ? "query" : "queries", info);

    LOG_INFO("sql.updates", " ");

    return true;
}

template<class T>
bool DBUpdater<T>::Update(DatabaseWorkerPool<T>& pool, std::vector<std::string> const* setDirectories)
{
    if (!DBUpdaterUtil::CheckExecutable())
    {
        return false;
    }

    Path const sourceDirectory(BuiltInConfig::GetSourceDirectory());
    if (!is_directory(sourceDirectory))
    {
        return false;
    }

    auto CheckUpdateTable = [&](std::string const& tableName)
    {
        auto checkTable = DBUpdater<T>::Retrieve(pool, Acore::StringFormat("SHOW TABLES LIKE '{}'", tableName));
        if (!checkTable)
        {
            Path const temp(GetBaseFilesDirectory() + tableName + ".sql");
            try
            {
                DBUpdater<T>::ApplyFile(pool, temp);
            }
            catch (UpdateException&)
            {
                return false;
            }

            return true;
        }

        return true;
    };

    if (!CheckUpdateTable("updates") || !CheckUpdateTable("updates_include"))
    {
        return false;
    }

    UpdateFetcher updateFetcher(sourceDirectory, [&](std::string const & query) { DBUpdater<T>::Apply(pool, query); },
    [&](Path const & file) { DBUpdater<T>::ApplyFile(pool, file); },
    [&](std::string const & query) -> QueryResult { return DBUpdater<T>::Retrieve(pool, query); }, DBUpdater<T>::GetDBModuleName(), setDirectories);

    UpdateResult result;
    try
    {
        result = updateFetcher.Update(
                     sConfigMgr->GetOption<bool>("Updates.Redundancy", true),
                     sConfigMgr->GetOption<bool>("Updates.AllowRehash", true),
                     sConfigMgr->GetOption<bool>("Updates.ArchivedRedundancy", false),
                     sConfigMgr->GetOption<int32>("Updates.CleanDeadRefMaxCount", 3));
    }
    catch (UpdateException&)
    {
        return false;
    }

    return true;
}

template<class T>
bool DBUpdater<T>::Populate(DatabaseWorkerPool<T>& pool)
{
    {
        QueryResult const result = Retrieve(pool, "SHOW TABLES");
        if (result && (result->GetRowCount() > 0))
            return true;
    }

    if (!DBUpdaterUtil::CheckExecutable())
        return false;

    LOG_INFO("sql.updates", "Database {} is empty, auto populating it...", DBUpdater<T>::GetTableName());

    std::string const DirPathStr = DBUpdater<T>::GetBaseFilesDirectory();

    Path const DirPath(DirPathStr);
    if (!std::filesystem::is_directory(DirPath))
    {
        LOG_ERROR("sql.updates", ">> Directory \"{}\" not exist", DirPath.generic_string());
        return false;
    }

    if (DirPath.empty())
    {
        LOG_ERROR("sql.updates", ">> Directory \"{}\" is empty", DirPath.generic_string());
        return false;
    }

    std::filesystem::directory_iterator const DirItr;
    uint32 FilesCount = 0;

    for (std::filesystem::directory_iterator itr(DirPath); itr != DirItr; ++itr)
    {
        if (itr->path().extension() == ".sql")
            FilesCount++;
    }

    if (!FilesCount)
    {
        LOG_ERROR("sql.updates", ">> In directory \"{}\" not exist '*.sql' files", DirPath.generic_string());
        return false;
    }

    for (std::filesystem::directory_iterator itr(DirPath); itr != DirItr; ++itr)
    {
        if (itr->path().extension() != ".sql")
            continue;

        LOG_INFO("sql.updates", ">> Applying \'{}\'...", itr->path().filename().generic_string());

        try
        {
            ApplyFile(pool, itr->path());
        }
        catch (UpdateException&)
        {
            return false;
        }
    }

    LOG_INFO("sql.updates", ">> Done!");
    LOG_INFO("sql.updates", " ");
    return true;
}

template<class T>
QueryResult DBUpdater<T>::Retrieve(DatabaseWorkerPool<T>& pool, std::string const& query)
{
    return pool.Query(query.c_str());
}

template<class T>
void DBUpdater<T>::Apply(DatabaseWorkerPool<T>& pool, std::string const& query)
{
    pool.DirectExecute(query.c_str());
}

template<class T>
void DBUpdater<T>::ApplyFile(DatabaseWorkerPool<T>& pool, Path const& path)
{
    DBUpdater<T>::ApplyFile(pool, pool.GetConnectionInfo()->host, pool.GetConnectionInfo()->user, pool.GetConnectionInfo()->password,
                            pool.GetConnectionInfo()->port_or_socket, pool.GetConnectionInfo()->database, pool.GetConnectionInfo()->ssl, path);
}

template<class T>
void DBUpdater<T>::ApplyFile(DatabaseWorkerPool<T>& pool, std::string const& host, std::string const& user,
                             std::string const& password, std::string const& port_or_socket, std::string const& database, std::string const& ssl, Path const& path)
{
    std::string configTempDir = sConfigMgr->GetOption<std::string>("TempDir", "");

    auto tempDir = configTempDir.empty() ? std::filesystem::temp_directory_path().string() : configTempDir;

    tempDir = Acore::String::AddSuffixIfNotExists(tempDir, std::filesystem::path::preferred_separator);

    std::string confFileName = "mysql_ac.conf";

    std::ofstream outfile (tempDir + confFileName);

    outfile << "[client]\npassword = \"" << password << '"' << std::endl;

    outfile.close();

    std::vector<std::string> args;
    args.reserve(9);

    args.emplace_back("--defaults-extra-file="+tempDir + confFileName+"");

    // CLI Client connection info
    args.emplace_back("-h" + host);
    args.emplace_back("-u" + user);

    // Check if we want to connect through ip or socket (Unix only)
#ifdef _WIN32

    if (host == ".")
        args.emplace_back("--protocol=PIPE");
    else
        args.emplace_back("-P" + port_or_socket);

#else

    if (!std::isdigit(port_or_socket[0]))
    {
        // We can't check if host == "." here, because it is named localhost if socket option is enabled
        args.emplace_back("-P0");
        args.emplace_back("--protocol=SOCKET");
        args.emplace_back("-S" + port_or_socket);
    }
    else
        // generic case
        args.emplace_back("-P" + port_or_socket);

#endif

    // Set the default charset to utf8
    args.emplace_back("--default-character-set=utf8");

    // Set max allowed packet to 1 GB
    args.emplace_back("--max-allowed-packet=1GB");

#if !defined(MARIADB_VERSION_ID) && MYSQL_VERSION_ID >= 80000

    if (ssl == "ssl")
        args.emplace_back("--ssl-mode=REQUIRED");

#else

    if (ssl == "ssl")
        args.emplace_back("--ssl");

#endif

    // Execute sql file
    args.emplace_back("-e");
    args.emplace_back(Acore::StringFormat("BEGIN; SOURCE {}; COMMIT;", path.generic_string()));

    // Database
    if (!database.empty())
        args.emplace_back(database);

    // Invokes a mysql process which doesn't leak credentials to logs
    int const ret = Acore::StartProcess(DBUpdaterUtil::GetCorrectedMySQLExecutable(), args,
        "sql.updates", "", true);

    if (ret != EXIT_SUCCESS)
    {
        LOG_FATAL("sql.updates", "Applying of file \'{}\' to database \'{}\' failed!" \
            " If you are a user, please pull the latest revision from the repository. "
            "Also make sure you have not applied any of the databases with your sql client. "
            "You cannot use auto-update system and import sql files from AzerothCore repository with your sql client. "
            "If you are a developer, please fix your sql query.",
            path.generic_string(), pool.GetConnectionInfo()->database);

        throw UpdateException("update failed");
    }
}

template class AC_DATABASE_API DBUpdater<LoginDatabaseConnection>;
template class AC_DATABASE_API DBUpdater<WorldDatabaseConnection>;
template class AC_DATABASE_API DBUpdater<CharacterDatabaseConnection>;
