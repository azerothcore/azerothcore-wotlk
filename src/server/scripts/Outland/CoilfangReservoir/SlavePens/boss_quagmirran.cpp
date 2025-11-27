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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "the_slave_pens.h"

enum Spells
{
    SPELL_ACID_SPRAY            = 38153,
    SPELL_CLEAVE                = 40504,
    SPELL_POISON_BOLT_VOLLEY    = 34780,
    SPELL_UPPERCUT              = 32055
};

struct boss_quagmirran : public BossAI
{
    boss_quagmirran(Creature* creature) : BossAI(creature, DATA_QUAGMIRRAN)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(9100ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(18800ms, 24800ms);
        }).Schedule(20300ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_UPPERCUT);
            context.Repeat(21800ms);
        }).Schedule(25200ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_ACID_SPRAY);
            context.Repeat(25s);
        }).Schedule(31800ms, [this](TaskContext context)
        {
            DoCastAOE(SPELL_POISON_BOLT_VOLLEY);
            context.Repeat(24400ms);
        });
    }
};

void AddSC_boss_quagmirran()
{
    RegisterTheSlavePensCreatureAI(boss_quagmirran);
}
