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

#ifndef DBUpdater_h__
#define DBUpdater_h__

#include "DatabaseEnv.h"
#include "DatabaseUpdatePool.h"
#include "Define.h"
#include "QueryResult.h"
#include <filesystem>
#include <string>
#include <string_view>
#include <vector>

namespace boost
{
    namespace filesystem
    {
        class path;
    }
}

class AC_DATABASE_API UpdateException : public std::exception
{
public:
    UpdateException(std::string const& msg) : _msg(msg) { }
    ~UpdateException() throw() { }

    char const* what() const throw() override { return _msg.c_str(); }

private:
    std::string const _msg;
};

enum BaseLocation
{
    LOCATION_REPOSITORY,
    LOCATION_DOWNLOAD
};

class AC_DATABASE_API DBUpdaterUtil
{
public:
    static std::string GetCorrectedMySQLExecutable();

    static bool CheckExecutable();

    // Counts every update file that failed to apply, in any mode. A dry run does not throw
    // on a bad file, so it keeps going and a single run reports all of them; whoever ends
    // the run must check this and exit non-zero, otherwise CI goes green on a failed import.
    static void MarkUpdateFailed();
    static uint32 GetFailedUpdateCount();

private:
    static std::string& corrected_path();
    static uint32& failed_updates();
};

template <class T>
class AC_DATABASE_API DBUpdater
{
public:
    using Path = std::filesystem::path;

    static inline std::string GetConfigEntry();
    static inline std::string GetTableName();
    static std::string GetSourceDirectory();
    static std::string GetBaseFilesDirectory();
    static bool IsEnabled(uint32 const updateMask);
    static BaseLocation GetBaseLocationType();
    static bool Create(DatabaseWorkerPool<T>& pool);
    static bool Update(DatabaseWorkerPool<T>& pool, std::string_view modulesList = {});
    static bool Update(DatabaseWorkerPool<T>& pool, std::vector<std::string> const* setDirectories);
    static bool Populate(DatabaseWorkerPool<T>& pool);

    // module
    static std::string GetDBModuleName();

};

// Runtime metadata describing a module-owned database for the updater.
struct ModuleDBUpdaterInfo
{
    std::string tableName;          // display name used in log output, e.g. "Playerbots"
    std::string sourceDirectory;    // root directory holding the module's sql tree
    std::string baseFilesDirectory; // directory containing the base *.sql files
    std::string dbModuleName;       // update-fetcher module name, must be lowercase
};

// Non-template updater entry points for module-owned pools (see ModuleDatabasePool).
// Mirrors the DBUpdater<T> flow: Create the schema when missing, Populate an empty
// database from the base files, then apply pending updates through the UpdateFetcher.
class AC_DATABASE_API ModuleDBUpdater
{
public:
    static bool Create(DatabaseUpdatePool& pool);
    static bool Update(DatabaseUpdatePool& pool, ModuleDBUpdaterInfo const& info, std::string_view modulesList = {});
    static bool Populate(DatabaseUpdatePool& pool, ModuleDBUpdaterInfo const& info);
};

#endif // DBUpdater_h__
