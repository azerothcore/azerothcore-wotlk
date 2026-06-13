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

#ifndef ACORE_GAMEOBJECTAI_H
#define ACORE_GAMEOBJECTAI_H

#include "CreatureAI.h"
#include "Define.h"
#include "GameObject.h"
#include "Object.h"
#include "QuestDef.h"

class Creature;
class GameObject;
class Unit;
class SpellInfo;

class AC_GAME_API GameObjectAI
{
protected:
    GameObject* const me;

public:
    explicit GameObjectAI(GameObject* go) : me(go) {}
    virtual ~GameObjectAI() {}

    virtual void UpdateAI(uint32 /*diff*/) {}

    virtual void InitializeAI() { Reset(); }

    virtual void Reset() { }

    // Pass parameters between AI
    virtual void DoAction(int32 /*param = 0 */) {}
    virtual void SetGUID(ObjectGuid const& /*guid*/, int32 /*id = 0 */) {}
    virtual ObjectGuid GetGUID(int32 /*id = 0 */) const { return ObjectGuid::Empty; }

    static int32 Permissible(GameObject const* go);

    virtual bool GossipHello(Player* /*player*/, bool /*reportUse*/) { return false; }
    virtual bool GossipSelect(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/) { return false; }
    virtual bool GossipSelectCode(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/, char const* /*code*/) { return false; }
    virtual bool QuestAccept(Player* /*player*/, Quest const* /*quest*/) { return false; }
    virtual bool QuestReward(Player* /*player*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }
    virtual uint32 GetDialogStatus(Player* /*player*/) { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }
    virtual void Destroyed(Player* /*player*/, uint32 /*eventId*/) {}
    virtual uint32 GetData(uint32 /*id*/) const { return 0; }
    virtual void SetData(uint32 /*id*/, uint32 /*value*/) {}
    virtual void OnGameEvent(bool /*start*/, uint16 /*eventId*/) {}
    virtual void OnStateChanged(uint32 /*state*/, Unit* /*unit*/) {}
    virtual void EventInform(uint32 /*eventId*/) {}
    virtual void SpellHit(Unit* /*unit*/, SpellInfo const* /*spellInfo*/) {}
    virtual bool CanBeSeen(Player const* /*seer*/) { return true; }

    // Called when the gameobject summon successfully other creature
    virtual void JustSummoned(Creature* /*summon*/) {}
    virtual void SummonedCreatureDespawn(Creature* /*summon*/) {}

    virtual void SummonedCreatureDies(Creature* /*summon*/, Unit* /*killer*/) {}

    virtual void SummonedCreatureEvade(Creature* /*summon*/) {}
};

class NullGameObjectAI : public GameObjectAI
{
public:
    explicit NullGameObjectAI(GameObject* go);

    void UpdateAI(uint32 /*diff*/) override {}

    static int32 Permissible(GameObject const* go);
};
#endif
