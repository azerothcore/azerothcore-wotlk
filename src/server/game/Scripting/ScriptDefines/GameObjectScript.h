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

#ifndef SCRIPT_OBJECT_GAMEOBJECT_SCRIPT_H_
#define SCRIPT_OBJECT_GAMEOBJECT_SCRIPT_H_

#include "QuestDef.h"
#include "ScriptObject.h"

class GameObjectScript : public ScriptObject, public UpdatableScript<GameObject>
{
protected:
    GameObjectScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a player opens a gossip dialog with the gameobject.
    [[nodiscard]] virtual bool OnGossipHello(Player* /*player*/, GameObject* /*go*/) { return false; }

    // Called when a player selects a gossip item in the gameobject's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelect(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

    // Called when a player selects a gossip with a code in the gameobject's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelectCode(Player* /*player*/, GameObject* /*go*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

    // Called when a player accepts a quest from the gameobject.
    [[nodiscard]] virtual bool OnQuestAccept(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual bool OnQuestReward(Player* /*player*/, GameObject* /*go*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

    // Called when the dialog status between a player and the gameobject is requested.
    virtual uint32 GetDialogStatus(Player* /*player*/, GameObject* /*go*/) { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }

    // Called when the game object is destroyed (destructible buildings only).
    virtual void OnDestroyed(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the game object is damaged (destructible buildings only).
    virtual void OnDamaged(GameObject* /*go*/, Player* /*player*/) { }

    // Called when the health of a game object is modified (destructible buildings only).
    virtual void OnModifyHealth(GameObject* /*go*/, Unit* /*attackerOrHealer*/, int32& /*change*/, SpellInfo const* /*spellInfo*/) { }

    // Called when the game object loot state is changed.
    virtual void OnLootStateChanged(GameObject* /*go*/, uint32 /*state*/, Unit* /*unit*/) { }

    // Called when the game object state is changed.
    virtual void OnGameObjectStateChanged(GameObject* /*go*/, uint32 /*state*/) { }

    // Called when a GameObjectAI object is needed for the gameobject.
    virtual GameObjectAI* GetAI(GameObject* /*go*/) const { return nullptr; }
};

template <class AI>
class GenericGameObjectScript : public GameObjectScript
{
public:
    GenericGameObjectScript(char const* name) : GameObjectScript(name) { }
    GameObjectAI* GetAI(GameObject* go) const override { return new AI(go); }
};

#define RegisterGameObjectAI(ai_name) new GenericGameObjectScript<ai_name>(#ai_name)

template <class AI, AI* (*AIFactory)(GameObject*)> class FactoryGameObjectScript : public GameObjectScript
{
public:
    FactoryGameObjectScript(char const* name) : GameObjectScript(name) {}
    GameObjectAI* GetAI(GameObject* go) const override { return AIFactory(go); }
};

#define RegisterGameObjectAIWithFactory(ai_name, factory_fn) new FactoryGameObjectScript<ai_name, &factory_fn>(#ai_name)

#endif
