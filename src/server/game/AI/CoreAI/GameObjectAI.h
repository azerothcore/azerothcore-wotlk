/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_GAMEOBJECTAI_H
#define ACORE_GAMEOBJECTAI_H

#include "CreatureAI.h"
#include "Define.h"
#include "GameObject.h"
#include "Object.h"
#include "QuestDef.h"
#include <list>

class GameObjectAI
{
protected:
    GameObject* const go;
public:
    explicit GameObjectAI(GameObject* g) : go(g) {}
    virtual ~GameObjectAI() {}

    virtual void UpdateAI(uint32 /*diff*/) {}

    virtual void InitializeAI() { Reset(); }

    virtual void Reset() { }

    // Pass parameters between AI
    virtual void DoAction(int32 /*param = 0 */) {}
    virtual void SetGUID(ObjectGuid /*guid*/, int32 /*id = 0 */) {}
    virtual ObjectGuid GetGUID(int32 /*id = 0 */) const { return ObjectGuid::Empty; }

    static int Permissible(GameObject const* go);

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
    virtual void SpellHit(Unit* /*unit*/, const SpellInfo* /*spellInfo*/) {}
};

class NullGameObjectAI : public GameObjectAI
{
public:
    explicit NullGameObjectAI(GameObject* g);

    void UpdateAI(uint32 /*diff*/) override {}

    static int Permissible(GameObject const* /*go*/) { return PERMIT_BASE_IDLE; }
};
#endif
