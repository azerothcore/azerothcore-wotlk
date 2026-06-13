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

#ifndef SCRIPT_OBJECT_ALL_MAP_SCRIPT_H_
#define SCRIPT_OBJECT_ALL_MAP_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum AllMapHook
{
    ALLMAPHOOK_ON_PLAYER_ENTER_ALL,
    ALLMAPHOOK_ON_PLAYER_LEAVE_ALL,
    ALLMAPHOOK_ON_BEFORE_CREATE_INSTANCE_SCRIPT,
    ALLMAPHOOK_ON_DESTROY_INSTANCE,
    ALLMAPHOOK_ON_CREATE_MAP,
    ALLMAPHOOK_ON_DESTROY_MAP,
    ALLMAPHOOK_ON_MAP_UPDATE,
    ALLMAPHOOK_END
};

class AllMapScript : public ScriptObject
{
protected:
    AllMapScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    /**
     * @brief This hook called when a player enters any Map
     *
     * @param map Contains information about the Map
     * @param player Contains information about the Player
     */
    virtual void OnPlayerEnterAll(Map* /*map*/, Player* /*player*/) { }

    /**
     * @brief This hook called when a player leave any Map
     *
     * @param map Contains information about the Map
     * @param player Contains information about the Player
     */
    virtual void OnPlayerLeaveAll(Map* /*map*/, Player* /*player*/) { }

    /**
     * @brief This hook called before create instance script
     *
     * @param instanceMap Contains information about the WorldSession
     * @param instanceData Contains information about the WorldPacket
     * @param load if true loading instance save data
     * @param data Contains information about the instance save data
     * @param completedEncounterMask Contains information about the completed encouter mask
     */
    virtual void OnBeforeCreateInstanceScript(InstanceMap* /*instanceMap*/, InstanceScript** /*instanceData*/, bool /*load*/, std::string /*data*/, uint32 /*completedEncounterMask*/) { }

    /**
     * @brief This hook called before destroy instance
     *
     * @param mapInstanced Contains information about the MapInstanced
     * @param map Contains information about the Map
     */
    virtual void OnDestroyInstance(MapInstanced* /*mapInstanced*/, Map* /*map*/) { }

    /**
     * @brief This hook called before creating map
     *
     * @param map Contains information about the Map
     */
    virtual void OnCreateMap(Map* /*map*/) { }

    /**
     * @brief This hook called before destroing map
     *
     * @param map Contains information about the Map
     */
    virtual void OnDestroyMap(Map* /*map*/) { }

    /**
     * @brief This hook called before updating map
     *
     * @param map Contains information about the Map
     * @param diff Contains information about the diff time
     */
    virtual void OnMapUpdate(Map* /*map*/, uint32 /*diff*/) { }
};

#endif
