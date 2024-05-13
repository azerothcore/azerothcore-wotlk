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

#include "WorldScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnOpenStateChange(bool open)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_OPEN_STATE_CHANGE, script->OnOpenStateChange(open));
}

void ScriptMgr::OnAfterConfigLoad(bool reload)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_AFTER_CONFIG_LOAD, script->OnAfterConfigLoad(reload));
}

void ScriptMgr::OnLoadCustomDatabaseTable()
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_LOAD_CUSTOM_DATABASE_TABLE, script->OnLoadCustomDatabaseTable());
}

void ScriptMgr::OnBeforeConfigLoad(bool reload)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_BEFORE_CONFIG_LOAD, script->OnBeforeConfigLoad(reload));
}

void ScriptMgr::OnMotdChange(std::string& newMotd)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_MOTD_CHANGE, script->OnMotdChange(newMotd));
}

void ScriptMgr::OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_SHUTDOWN_INITIATE, script->OnShutdownInitiate(code, mask));
}

void ScriptMgr::OnShutdownCancel()
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_SHUTDOWN_CANCEL, script->OnShutdownCancel());
}

void ScriptMgr::OnWorldUpdate(uint32 diff)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_UPDATE, script->OnUpdate(diff));
}

void ScriptMgr::OnStartup()
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_STARTUP, script->OnStartup());
}

void ScriptMgr::OnShutdown()
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_SHUTDOWN, script->OnShutdown());
}

void ScriptMgr::OnAfterUnloadAllMaps()
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_AFTER_UNLOAD_ALL_MAPS, script->OnAfterUnloadAllMaps());
}

void ScriptMgr::OnBeforeFinalizePlayerWorldSession(uint32& cacheVersion)
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_BEFORE_FINALIZE_PLAYER_WORLD_SESSION, script->OnBeforeFinalizePlayerWorldSession(cacheVersion));
}

void ScriptMgr::OnBeforeWorldInitialized()
{
    CALL_ENABLED_HOOKS(WorldScript, WORLDHOOK_ON_BEFORE_WORLD_INITIALIZED, script->OnBeforeWorldInitialized());
}

WorldScript::WorldScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, WORLDHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < WORLDHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<WorldScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<WorldScript>;
