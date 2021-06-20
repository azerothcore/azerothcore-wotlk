/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_TOTEMAI_H
#define ACORE_TOTEMAI_H

#include "CreatureAI.h"
#include "Timer.h"

class Creature;
class Totem;

class TotemAI : public CreatureAI
{
    public:

        explicit TotemAI(Creature* c);

        void MoveInLineOfSight(Unit* who);
        void AttackStart(Unit* victim);
        void EnterEvadeMode();
        void SpellHit(Unit* /*caster*/, const SpellInfo* /*spellInfo*/);
        void DoAction(int32 param);

        void UpdateAI(uint32 diff);
        static int Permissible(Creature const* creature);

    private:
        uint64 i_victimGuid;
};

class KillMagnetEvent : public BasicEvent
{
    public:
        KillMagnetEvent(Unit& self) : _self(self) { }
        bool Execute(uint64 /*e_time*/, uint32 /*p_time*/)
        {
            _self.setDeathState(JUST_DIED);
            return true;
        }

    protected:
        Unit& _self;
};

#endif

