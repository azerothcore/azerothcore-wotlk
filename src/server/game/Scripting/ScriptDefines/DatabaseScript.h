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

#ifndef SCRIPT_OBJECT_DATABASE_SCRIPT_H_
#define SCRIPT_OBJECT_DATABASE_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum DatabaseHook
{
    DATABASEHOOK_ON_AFTER_DATABASES_LOADED,
    DATABASEHOOK_ON_AFTER_DATABASE_LOAD_CREATURETEMPLATES,
    DATABASEHOOK_END
};

class DatabaseScript : public ScriptObject
{
protected:

    DatabaseScript(char const* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:

    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    /**
     * @brief Called after all databases are loaded
     *
     * @param updateFlags Update flags from the loader
     */
    virtual void OnAfterDatabasesLoaded(uint32 /*updateFlags*/) { }

    /**
     * @brief Called after all creature template data has been loaded from the database. This hook could be called multiple times, not just at server startup.
     *
     * @param creatureTemplates Pointer to a modifiable vector of creature templates. Indexed by Entry ID.
     */
    virtual void OnAfterDatabaseLoadCreatureTemplates(std::vector<CreatureTemplate*> /*creatureTemplates*/) { }

    /**
     * @brief Called once the core databases are up, so a module can open a database of its own.
     * Runs before the rest of the world loads, unlike OnAfterDatabasesLoaded which reports the
     * finished core load.
     *
     * @return false to abort startup, e.g. when the module's own database failed to open
     */
    [[nodiscard]] virtual bool OnModuleDatabasesLoading() { return true; }

    /**
     * @brief Called on the world's keep-alive tick, alongside the core pools being pinged.
     */
    virtual void OnModuleDatabasesKeepAlive() { }

    /**
     * @brief Called after the core databases are closed, so a module can close its own.
     */
    virtual void OnModuleDatabasesClosing() { }

    /**
     * @brief Called when the core turns its synchronous-query warning on or off.
     *
     * @param apply True when the warning is being enabled
     */
    virtual void OnDatabaseWarnAboutSyncQueries(bool /*apply*/) { }

    /**
     * @brief Called while building the statement that marks a logging-out account offline.
     *
     * @param player The player logging out
     * @param statementIndex Prepared statement index to use instead of the core's
     * @param statementParam Single uint32 parameter bound to that statement
     */
    virtual void OnDatabaseSelectIndexLogout(Player* /*player*/, uint32& /*statementIndex*/, uint32& /*statementParam*/) { }

    /**
     * @brief Called by .server info to collect the revision of a module-owned database.
     *
     * @param revision Revision string to report
     */
    virtual void OnDatabaseGetDBRevision(std::string& /*revision*/) { }

};

#endif
