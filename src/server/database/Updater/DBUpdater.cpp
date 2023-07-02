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
#include "GitRevision.h"
#include "Log.h"
#include "MySQLConnection.h"
#include "StartProcess.h"
#include "UpdateFetcher.h"
#include <fstream>
#include <iostream>

constexpr auto SQL_BASE_DIR = "/data/sql/base/";

std::string DBUpdaterUtil::GetCorrectedMySQLExecutable()
{
    if (!corrected_path().empty())
        return corrected_path();

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

        LOG_FATAL("db.update", "Didn't find any executable MySQL binary at \'{}\' or in path, correct the path in the *.conf (\"MySQLExecutable\").",
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

std::string DBUpdater::GetConfigEntry(DatabaseWorkerPool const& pool)
{
    if (pool.GetType() == DatabaseType::Auth)
        return "Updates.Auth";

    return "Updates." + std::string{ pool.GetPoolName() };
}

std::string DBUpdater::GetTableName(DatabaseWorkerPool const& pool)
{
    return std::string{ pool.GetPoolName() };
}

std::string DBUpdater::GetBaseFilesDirectory(DatabaseWorkerPool const& pool)
{
    std::string folderName{ "db_" };

    if (pool.GetType() == DatabaseType::Auth) // Workaround for AC
        folderName += "auth";
    else if (pool.GetType() == DatabaseType::Character)
        folderName += "characters";
    else
        std::transform(pool.GetPoolName().begin(), pool.GetPoolName().end(), std::back_inserter(folderName), ::tolower);

    folderName += "/";
    return BuiltInConfig::GetSourceDirectory() + SQL_BASE_DIR + folderName;
}

bool DBUpdater::IsEnabled(DatabaseWorkerPool& pool, uint32 updateMask)
{
    // This way silences warnings under msvc
    return (updateMask & (uint32)pool.GetType()) != 0;
}

std::string DBUpdater::GetDBModuleName(DatabaseWorkerPool const& pool)
{
    std::string folderName{ "db_" };

    if (pool.GetType() == DatabaseType::Auth) // Workaround for AC
        folderName += "auth";
    else if (pool.GetType() == DatabaseType::Character)
        folderName += "characters";
    else
        std::transform(pool.GetPoolName().begin(), pool.GetPoolName().end(), std::back_inserter(folderName), ::tolower);

    folderName += "/";
    return folderName;
}

bool DBUpdater::Create(DatabaseWorkerPool& pool)
{
    LOG_WARN("db.update", "Database \"{}\" does not exist, do you want to create it? [yes (default) / no]: ",
             pool.GetConnectionInfo()->Database);

    const char* disableInteractive = std::getenv("AC_DISABLE_INTERACTIVE");

    if (!sConfigMgr->isDryRun() && (disableInteractive == nullptr || std::strcmp(disableInteractive, "1") != 0))
    {
        std::string answer;
        std::getline(std::cin, answer);
        if (!answer.empty() && !(answer.substr(0, 1) == "y"))
            return false;
    }

    LOG_INFO("db.update", "Creating database \"{}\"...", pool.GetConnectionInfo()->Database);

    // Path of temp file
    static Path const temp("create_table.sql");

    // Create temporary query to use external MySQL CLi
    std::ofstream file(temp.generic_string());
    if (!file.is_open())
    {
        LOG_FATAL("db.update", "Failed to create temporary query file \"{}\"!", temp.generic_string());
        return false;
    }

    file << "CREATE DATABASE `" << pool.GetConnectionInfo()->Database << "` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci;\n\n";
    file.close();

    try
    {
        DBUpdater::ApplyFile(pool, pool.GetConnectionInfo()->Host, pool.GetConnectionInfo()->User, pool.GetConnectionInfo()->Password,
            pool.GetConnectionInfo()->PortOrSocket, "", pool.GetConnectionInfo()->SSL, temp);
    }
    catch (UpdateException const&)
    {
        LOG_FATAL("db.update", "Failed to create database {}! Does the user (named in *.conf) have `CREATE`, `ALTER`, `DROP`, `INSERT` and `DELETE` privileges on the MySQL server?", pool.GetConnectionInfo()->Database);
        std::filesystem::remove(temp);
        return false;
    }

    LOG_INFO("db.update", "Done.");
    LOG_INFO("db.update", " ");
    std::filesystem::remove(temp);
    return true;
}

bool DBUpdater::Update(DatabaseWorkerPool& pool, std::string_view modulesList /*= {}*/)
{
    if (!DBUpdaterUtil::CheckExecutable())
        return false;

    LOG_INFO("db.update", "Updating {} database...", DBUpdater::GetTableName(pool));

    Path const sourceDirectory(BuiltInConfig::GetSourceDirectory());

    if (!is_directory(sourceDirectory))
    {
        LOG_ERROR("db.update", "DBUpdater: The given source directory {} does not exist, change the path to the directory where your sql directory exists (for example c:\\source\\trinitycore). Shutting down.",
            sourceDirectory.generic_string());
        return false;
    }

    auto CheckUpdateTable = [&](std::string const& tableName)
    {
        auto checkTable = DBUpdater::Retrieve(pool, Acore::StringFormatFmt("SHOW TABLES LIKE '{}'", tableName));
        if (!checkTable)
        {
            LOG_WARN("db.update", "> Table '{}' not exist! Try add based table", tableName);

            Path const temp(GetBaseFilesDirectory(pool) + tableName + ".sql");

            try
            {
                DBUpdater::ApplyFile(pool, temp);
            }
            catch (UpdateException&)
            {
                LOG_FATAL("db.update", "Failed apply file to database {}! Does the user (named in *.conf) have `INSERT` and `DELETE` privileges on the MySQL server?", pool.GetConnectionInfo()->Database);
                return false;
            }

            return true;
        }

        return true;
    };

    if (!CheckUpdateTable("updates") || !CheckUpdateTable("updates_include"))
        return false;

    UpdateFetcher updateFetcher(sourceDirectory, [&pool](std::string_view query) { DBUpdater::Apply(pool, query); },
    [&pool](Path const& file) { DBUpdater::ApplyFile(pool, file); },
    [&pool](std::string_view query) -> QueryResult { return DBUpdater::Retrieve(pool, query); }, DBUpdater::GetDBModuleName(pool), modulesList);

    UpdateResult result;
    try
    {
        result = updateFetcher.Update();
    }
    catch (UpdateException&)
    {
        return false;
    }

    std::string const info = Acore::StringFormatFmt("Containing {} new and {} archived updates.", result.recent, result.archived);

    if (!result.updated)
        LOG_INFO("db.update", ">> {} database is up-to-date! {}", DBUpdater::GetTableName(pool), info);
    else
        LOG_INFO("db.update", ">> Applied {} {}. {}", result.updated, result.updated == 1 ? "query" : "queries", info);

    LOG_INFO("db.update", " ");
    return true;
}

bool DBUpdater::Update(DatabaseWorkerPool& pool, std::vector<std::string> const* setDirectories)
{
    if (!DBUpdaterUtil::CheckExecutable())
        return false;

    Path const sourceDirectory(BuiltInConfig::GetSourceDirectory());
    if (!is_directory(sourceDirectory))
        return false;

    auto CheckUpdateTable = [&](std::string const& tableName)
    {
        auto checkTable = DBUpdater::Retrieve(pool, Acore::StringFormatFmt("SHOW TABLES LIKE '{}'", tableName));
        if (!checkTable)
        {
            Path const temp(GetBaseFilesDirectory(pool) + tableName + ".sql");
            try
            {
                DBUpdater::ApplyFile(pool, temp);
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

    UpdateFetcher updateFetcher(sourceDirectory, [&pool](std::string_view query) { DBUpdater::Apply(pool, query); },
    [&pool](Path const& file) { DBUpdater::ApplyFile(pool, file); },
    [&pool](std::string_view query) -> QueryResult { return DBUpdater::Retrieve(pool, query); }, DBUpdater::GetDBModuleName(pool), setDirectories);

    UpdateResult result;
    try
    {
        result = updateFetcher.Update();
    }
    catch (UpdateException&)
    {
        return false;
    }

    return true;
}

bool DBUpdater::Populate(DatabaseWorkerPool& pool)
{
    {
        QueryResult const result = Retrieve(pool, "SHOW TABLES");
        if (result && (result->GetRowCount() > 0))
            return true;
    }

    if (!DBUpdaterUtil::CheckExecutable())
        return false;

    LOG_INFO("db.update", "Database {} is empty, auto populating it...", DBUpdater::GetTableName(pool));

    std::string const dirPathStr = DBUpdater::GetBaseFilesDirectory(pool);

    Path const dirPath(dirPathStr);
    if (dirPath.empty())
    {
        LOG_ERROR("db.update", ">> Directory \"{}\" is empty", dirPath.generic_string());
        return false;
    }

    if (!std::filesystem::is_directory(dirPath))
    {
        LOG_ERROR("db.update", ">> Directory \"{}\" not exist", dirPath.generic_string());
        return false;
    }

    std::size_t filesCount{ 0 };

    for (auto const& dirEntry : std::filesystem::directory_iterator(dirPath))
    {
        if (dirEntry.path().extension() == ".sql")
            filesCount++;
    }

    if (!filesCount)
    {
        LOG_ERROR("db.update", ">> In directory \"{}\" not exist '*.sql' files", dirPath.generic_string());
        return false;
    }

    for (auto const& dirEntry : std::filesystem::directory_iterator(dirPath))
    {
        auto const& path = dirEntry.path();
        if (path.extension() != ".sql")
            continue;

        LOG_INFO("db.update", ">> Applying \'{}\'...", path.filename().generic_string());

        try
        {
            ApplyFile(pool, path);
        }
        catch (UpdateException&)
        {
            return false;
        }
    }

    LOG_INFO("db.update", ">> Done!");
    LOG_INFO("db.update", " ");
    return true;
}

QueryResult DBUpdater::Retrieve(DatabaseWorkerPool& pool, std::string_view query)
{
    return pool.Query(query);
}

void DBUpdater::Apply(DatabaseWorkerPool& pool, std::string_view query)
{
    pool.DirectExecute(query);
}

void DBUpdater::ApplyFile(DatabaseWorkerPool& pool, Path const& path)
{
    DBUpdater::ApplyFile(pool, pool.GetConnectionInfo()->Host, pool.GetConnectionInfo()->User, pool.GetConnectionInfo()->Password,
        pool.GetConnectionInfo()->PortOrSocket, pool.GetConnectionInfo()->Database, pool.GetConnectionInfo()->SSL, path);
}

void DBUpdater::ApplyFile(DatabaseWorkerPool& pool, std::string_view host, std::string_view user, std::string_view password,
    std::string_view port_or_socket, std::string_view database, std::string_view ssl, Path const& path)
{
    std::vector<std::string> args;
    args.reserve(9);

    // Add password from extra file
    args.emplace_back(Acore::StringFormatFmt("--defaults-extra-file={}", pool.GetPathToExtraFile()));

    // CLI Client connection info
    args.emplace_back("-h" + std::string{ host });
    args.emplace_back("-u" + std::string{ user });

    // Check if we want to connect through ip or socket (Unix only)
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    if (host == ".")
        args.emplace_back("--protocol=PIPE");
    else
        args.emplace_back("-P" + std::string{ port_or_socket });
#else
    if (!std::isdigit(port_or_socket[0]))
    {
        // We can't check if host == "." here, because it is named localhost if socket option is enabled
        args.emplace_back("-P0");
        args.emplace_back("--protocol=SOCKET");
        args.emplace_back("-S" + std::string{ port_or_socket });
    }
    else
        // generic case
        args.emplace_back("-P" + std::string{ port_or_socket });
#endif

    // Set the default charset to utf8
    args.emplace_back("--default-character-set=utf8mb4");

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
    args.emplace_back(Acore::StringFormatFmt("BEGIN; SOURCE {}; COMMIT;", path.generic_string()));

    // Database
    if (!database.empty())
        args.emplace_back(database);

    // Invokes a mysql process which doesn't leak credentials to logs
    int const ret = Acore::StartProcess(DBUpdaterUtil::GetCorrectedMySQLExecutable(), args, "db.update", "", true);

    if (ret != EXIT_SUCCESS)
    {
        LOG_FATAL("db.update", "Applying of file \'{}\' to database \'{}\' failed!" \
            " If you are a user, please pull the latest revision from the repository. "
            "Also make sure you have not applied any of the databases with your sql client. "
            "You cannot use auto-update system and import sql files from AzerothCore repository with your sql client. "
            "If you are a developer, please fix your sql query.",
            path.generic_string(), pool.GetConnectionInfo()->Database);

        throw UpdateException("update failed");
    }
}
