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

#ifndef DBUpdater_h__
#define DBUpdater_h__

#include "DatabaseEnv.h"
#include "Define.h"
#include <filesystem>
#include <string>

class DatabaseWorkerPool;

class AC_DATABASE_API UpdateException : public std::exception
{
public:
    explicit UpdateException(std::string_view msg) : _msg(msg) { }
    ~UpdateException() noexcept override = default;

    [[nodiscard]] char const* what() const noexcept override { return _msg.c_str(); }
    [[nodiscard]] std::string_view GetMessage() const noexcept { return _msg; }

private:
    std::string _msg;
};

class AC_DATABASE_API DBUpdaterUtil
{
public:
    static std::string GetCorrectedMySQLExecutable();
    static bool CheckExecutable();

private:
    static std::string& corrected_path();
};

class AC_DATABASE_API DBUpdater
{
public:
    using Path = std::filesystem::path;

    static std::string GetConfigEntry(DatabaseWorkerPool const& pool);
    static std::string GetTableName(DatabaseWorkerPool const& pool);
    static std::string GetBaseFilesDirectory(DatabaseWorkerPool const& pool);
    static bool IsEnabled(DatabaseWorkerPool& pool, uint32 updateMask);
    static bool Create(DatabaseWorkerPool& pool);
    static bool Update(DatabaseWorkerPool& pool, std::string_view modulesList = {});
    static bool Update(DatabaseWorkerPool& pool, std::vector<std::string> const* setDirectories);
    static bool Populate(DatabaseWorkerPool& pool);

    // module
    static std::string GetDBModuleName(DatabaseWorkerPool const& pool);

private:
    static QueryResult Retrieve(DatabaseWorkerPool& pool, std::string_view query);
    static void Apply(DatabaseWorkerPool& pool, std::string_view query);
    static void ApplyFile(DatabaseWorkerPool& pool, Path const& path);
    static void ApplyFile(DatabaseWorkerPool& pool, std::string_view host, std::string_view user,
        std::string_view password, std::string_view port_or_socket, std::string_view database, std::string_view ssl, Path const& path);
};

#endif // DBUpdater_h__
