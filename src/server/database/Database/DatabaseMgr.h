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

#ifndef _DATABASE_MGR_H_
#define _DATABASE_MGR_H_

#include "DatabaseEnvFwd.h"
#include "Duration.h"
#include <atomic>
#include <functional>
#include <queue>
#include <stack>
#include <vector>

class DatabaseWorkerPool;

class AC_DATABASE_API DatabaseMgr
{
public:
    DatabaseMgr();
    ~DatabaseMgr();

    static DatabaseMgr* instance();

    void AddDatabase(DatabaseWorkerPool& pool, std::string_view name);
    void Update(Milliseconds diff);
    bool Load();
    void CloseAllConnections();

    [[nodiscard]] uint32 GetUpdateFlags() const { return _updateFlags; }

    static uint32 GetDatabaseLibraryVersion();
    static std::string_view GetClientInfo();
    static std::string_view GetServerVersion();

    void SetModuleList(std::string_view modulesList) { _modulesList = modulesList; }

private:
    using Predicate = std::function<bool()>;
    using Closer = std::function<void()>;

    bool OpenDatabases();
    bool PopulateDatabases();
    bool UpdateDatabases();
    bool PrepareStatements();

    // Invokes all functions in the given queue and closes the databases on errors.
    // Returns false when there was an error.
    bool Process(std::queue<Predicate>& queue);

    std::string _modulesList;
    bool _autoSetup{};
    uint32 _updateFlags{};

    std::queue<Predicate> _open, _populate, _update, _prepare;
    std::stack<Closer> _close;
    std::vector<DatabaseWorkerPool*> _poolList;

    DatabaseMgr(DatabaseMgr const&) = delete;
    DatabaseMgr(DatabaseMgr&&) = delete;
    DatabaseMgr& operator=(DatabaseMgr const&) = delete;
    DatabaseMgr& operator=(DatabaseMgr&&) = delete;
};

#define sDatabaseMgr DatabaseMgr::instance()

#endif
