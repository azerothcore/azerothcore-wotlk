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

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnOpenStateChange(bool open)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnOpenStateChange(open);
    });
}

void ScriptMgr::OnLoadCustomDatabaseTable()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnLoadCustomDatabaseTable();
    });
}

void ScriptMgr::OnBeforeConfigLoad(bool reload)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnBeforeConfigLoad(reload);
    });
}

void ScriptMgr::OnAfterConfigLoad(bool reload)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnAfterConfigLoad(reload);
    });
}

void ScriptMgr::OnBeforeFinalizePlayerWorldSession(uint32& cacheVersion)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnBeforeFinalizePlayerWorldSession(cacheVersion);
    });
}

void ScriptMgr::OnMotdChange(std::string& newMotd)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnMotdChange(newMotd);
    });
}

void ScriptMgr::OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnShutdownInitiate(code, mask);
    });
}

void ScriptMgr::OnShutdownCancel()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnShutdownCancel();
    });
}

void ScriptMgr::OnWorldUpdate(uint32 diff)
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnUpdate(diff);
    });
}

void ScriptMgr::OnStartup()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnStartup();
    });
}

void ScriptMgr::OnShutdown()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnShutdown();
    });
}

void ScriptMgr::OnBeforeWorldInitialized()
{
    ExecuteScript<WorldScript>([&](WorldScript* script)
    {
        script->OnBeforeWorldInitialized();
    });
}

void ScriptMgr::OnAfterUnloadAllMaps()
{
    ExecuteScript<WorldScript>([](WorldScript* script)
    {
        script->OnAfterUnloadAllMaps();
    });
}
