/*
 * Copyright (C) 
 * Copyright (C) 
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TRINITY_TOTEMAI_H
#define TRINITY_TOTEMAI_H

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
        bool Execute(uint64 e_time, uint32 p_time)
        {
            _self.setDeathState(JUST_DIED);
            return true;
        }

    protected:
        Unit& _self;
};

#endif

