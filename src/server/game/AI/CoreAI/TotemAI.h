/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
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

    void MoveInLineOfSight(Unit* who) override;
    void AttackStart(Unit* victim) override;
    void EnterEvadeMode() override;
    void SpellHit(Unit* /*caster*/, const SpellInfo* /*spellInfo*/) override;
    void DoAction(int32 param) override;

    void UpdateAI(uint32 diff) override;
    static int Permissible(Creature const* creature);

private:
    ObjectGuid i_victimGuid;
};

class KillMagnetEvent : public BasicEvent
{
public:
    KillMagnetEvent(Unit& self) : _self(self) { }
    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override
    {
        _self.setDeathState(JUST_DIED);
        return true;
    }

protected:
    Unit& _self;
};

#endif
