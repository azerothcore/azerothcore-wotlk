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

#include "ScriptObject.h"

class WorldScript : public ScriptObject
{
protected:
    WorldScript(const char* name);

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
    virtual void OnMotdChange(std::string& /*newMotd*/) { }

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
