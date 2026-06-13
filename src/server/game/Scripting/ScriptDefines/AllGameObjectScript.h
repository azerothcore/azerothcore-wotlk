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

#ifndef SCRIPT_OBJECT_ALL_GAMEOBJECT_SCRIPT_H_
#define SCRIPT_OBJECT_ALL_GAMEOBJECT_SCRIPT_H_

#include "ScriptObject.h"

class AllGameObjectScript : public ScriptObject
{
protected:
    AllGameObjectScript(const char* name);

public:
    /**
     * @brief This hook runs after add game object in world
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectAddWorld(GameObject* /*go*/) { }
    /**
     * @brief This hook runs after the game object iis saved to the database
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectSaveToDB(GameObject* /*go*/) { }
    /**
     * @brief This hook runs after remove game object in world
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectRemoveWorld(GameObject* /*go*/) { }

    /**
     * @brief This hook runs after remove game object in world
     *
     * @param go Contains information about the GameObject
     */
    virtual void OnGameObjectUpdate(GameObject* /*go*/, uint32 /*diff*/) { }

    // Called when a player opens a gossip dialog with the gameobject.
    [[nodiscard]] virtual bool CanGameObjectGossipHello(Player* /*player*/, GameObject* /*go*/) { return false; }

    // Called when a player selects a gossip item in the gameobject's gossip menu.
    [[nodiscard]] virtual bool CanGameObjectGossipSelect(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

    // Called when a player selects a gossip with a code in the gameobject's gossip menu.
    [[nodiscard]] virtual bool CanGameObjectGossipSelectCode(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

    // Called when a player accepts a quest from the gameobject.
    [[nodiscard]] virtual bool CanGameObjectQuestAccept(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual bool CanGameObjectQuestReward(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

    // Called when the game object is destroyed (destructible buildings only).
    virtual void OnGameObjectDestroyed(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object is damaged (destructible buildings only).
    virtual void OnGameObjectDamaged(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the health of a game object is modified (destructible buildings only).
    virtual void OnGameObjectModifyHealth(GameObject* /*go*/, Unit* /*attackerOrHealer*/, int32& /*change*/, SpellInfo const* /*spellInfo*/) { }

    // Called when the game object loot state is changed.
    virtual void OnGameObjectLootStateChanged(GameObject* /*go*/, uint32 /*state*/, Unit* /*unit*/) { }

    // Called when the game object state is changed.
    virtual void OnGameObjectStateChanged(GameObject* /*go*/, uint32 /*state*/) { }

    // Called when a GameObjectAI object is needed for the gameobject.
    virtual GameObjectAI* GetGameObjectAI(GameObject* /*go*/) const { return nullptr; }
};

#endif
