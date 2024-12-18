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

#ifndef ACORE_TOTEMAI_H
#define ACORE_TOTEMAI_H

#include "CreatureAI.h"

class Creature;
class Totem;

class TotemAI : public CreatureAI
{
public:
    explicit TotemAI(Creature* c);

    void MoveInLineOfSight(Unit* who) override;
    void AttackStart(Unit* victim) override;

    void EnterEvadeMode(EvadeReason /*why*/) override;
    void SpellHit(Unit* /*caster*/, SpellInfo const* /*spellInfo*/) override;

    void DoAction(int32 param) override;

    void UpdateAI(uint32 diff) override;
    static int32 Permissible(Creature const* creature);

private:
    ObjectGuid i_victimGuid;
};

class KillMagnetEvent : public BasicEvent
{
public:
    KillMagnetEvent(Unit& self) : _self(self) { }
    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override
    {
        _self.setDeathState(DeathState::JustDied);
        return true;
    }

protected:
    Unit& _self;
};

#endif
