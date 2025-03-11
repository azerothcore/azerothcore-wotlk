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

#ifndef SCRIPT_OBJECT_WORLD_SCRIPT_H_
#define SCRIPT_OBJECT_WORLD_SCRIPT_H_

#include "Common.h"
#include "ScriptObject.h"
#include <vector>

enum WorldHook
{
    WORLDHOOK_ON_OPEN_STATE_CHANGE,
    WORLDHOOK_ON_AFTER_CONFIG_LOAD,
    WORLDHOOK_ON_LOAD_CUSTOM_DATABASE_TABLE,
    WORLDHOOK_ON_BEFORE_CONFIG_LOAD,
    WORLDHOOK_ON_MOTD_CHANGE,
    WORLDHOOK_ON_SHUTDOWN_INITIATE,
    WORLDHOOK_ON_SHUTDOWN_CANCEL,
    WORLDHOOK_ON_UPDATE,
    WORLDHOOK_ON_STARTUP,
    WORLDHOOK_ON_SHUTDOWN,
    WORLDHOOK_ON_AFTER_UNLOAD_ALL_MAPS,
    WORLDHOOK_ON_BEFORE_FINALIZE_PLAYER_WORLD_SESSION,
    WORLDHOOK_ON_BEFORE_WORLD_INITIALIZED,
    WORLDHOOK_END
};

class WorldScript : public ScriptObject
{
protected:
    WorldScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Called when the open/closed state of the world changes.
    virtual void OnOpenStateChange(bool /*open*/) { }

    // Called after the world configuration is (re)loaded.
    virtual void OnAfterConfigLoad(bool /*reload*/) { }

    // Called when loading custom database tables
    virtual void OnLoadCustomDatabaseTable() { }

    // Called before the world configuration is (re)loaded.
    virtual void OnBeforeConfigLoad(bool /*reload*/) { }

    // Called before the message of the day is changed.
    virtual void OnMotdChange(std::string& /*newMotd*/, LocaleConstant& /*locale*/) { }

    // Called when a world shutdown is initiated.
    virtual void OnShutdownInitiate(ShutdownExitCode /*code*/, ShutdownMask /*mask*/) { }

    // Called when a world shutdown is cancelled.
    virtual void OnShutdownCancel() { }

    // Called on every world tick (don't execute too heavy code here).
    virtual void OnUpdate(uint32 /*diff*/) { }

    // Called when the world is started.
    virtual void OnStartup() { }

    // Called when the world is actually shut down.
    virtual void OnShutdown() { }

    /**
     * @brief Called after all maps are unloaded from core
     */
    virtual void OnAfterUnloadAllMaps() { }

    /**
     * @brief This hook runs before finalizing the player world session. Can be also used to mutate the cache version of the Client.
     *
     * @param version The cache version that we will be sending to the Client.
     */
    virtual void OnBeforeFinalizePlayerWorldSession(uint32& /*cacheVersion*/) { }

    /**
     * @brief This hook runs after all scripts loading and before itialized
     */
    virtual void OnBeforeWorldInitialized() { }
};

#endif
