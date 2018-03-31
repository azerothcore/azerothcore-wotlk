/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef SC_HYJAL_TRASH_AI_H
#define SC_HYJAL_TRASH_AI_H

#include "hyjal.h"
#include "ScriptedEscortAI.h"

#define MINRAIDDAMAGE  700000//minimal damage before trash can drop loot and reputation, resets if faction leader dies

struct hyjal_trashAI : public npc_escortAI
{
    hyjal_trashAI(Creature* creature);

    void UpdateAI(uint32 diff);

    void JustDied(Unit* /*killer*/);

    void DamageTaken(Unit* done_by, uint32 &damage, DamageEffectType, SpellSchoolMask);

    public:
        InstanceScript* instance;
        bool IsEvent;
        uint32 Delay;
        uint32 LastOverronPos;
        bool IsOverrun;
        bool SetupOverrun;
        uint32 OverrunType;
        uint8 faction;
        bool useFlyPath;
        uint32 damageTaken;
        float DummyTarget[3];

    //private:
};
#endif
