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

#include "DatabaseScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::OnModuleDatabasesLoading()
{
    CALL_ENABLED_BOOLEAN_HOOKS(DatabaseScript, DATABASEHOOK_ON_MODULE_DATABASES_LOADING, !script->OnModuleDatabasesLoading());
}

void ScriptMgr::OnAfterDatabasesLoaded(uint32 updateFlags)
{
    CALL_ENABLED_HOOKS(DatabaseScript, DATABASEHOOK_ON_AFTER_DATABASES_LOADED, script->OnAfterDatabasesLoaded(updateFlags));
}

void ScriptMgr::OnAfterDatabaseLoadCreatureTemplates(std::vector<CreatureTemplate*> creatureTemplates)
{
    CALL_ENABLED_HOOKS(DatabaseScript, DATABASEHOOK_ON_AFTER_DATABASE_LOAD_CREATURETEMPLATES, script->OnAfterDatabaseLoadCreatureTemplates(creatureTemplates));
}

void ScriptMgr::OnModuleDatabasesKeepAlive()
{
    CALL_ENABLED_HOOKS(DatabaseScript, DATABASEHOOK_ON_MODULE_DATABASES_KEEPALIVE, script->OnModuleDatabasesKeepAlive());
}

void ScriptMgr::OnModuleDatabasesClosing()
{
    CALL_ENABLED_HOOKS(DatabaseScript, DATABASEHOOK_ON_MODULE_DATABASES_CLOSING, script->OnModuleDatabasesClosing());
}

void ScriptMgr::OnDatabaseWarnAboutSyncQueries(bool apply)
{
    CALL_ENABLED_HOOKS(DatabaseScript, DATABASEHOOK_ON_DATABASE_WARN_ABOUT_SYNC_QUERIES, script->OnDatabaseWarnAboutSyncQueries(apply));
}

void ScriptMgr::OnDatabaseGetDBRevision(std::string& revision)
{
    CALL_ENABLED_HOOKS(DatabaseScript, DATABASEHOOK_ON_DATABASE_GET_DB_REVISION, script->OnDatabaseGetDBRevision(revision));
}

DatabaseScript::DatabaseScript(char const* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, DATABASEHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < DATABASEHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<DatabaseScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<DatabaseScript>;
