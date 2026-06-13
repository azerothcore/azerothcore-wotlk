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
#include "the_botanica.h"

enum Says
{
    SAY_AGGRO               = 0,
    SAY_SLAY                = 1,
    SAY_SUMMON              = 2,
    SAY_DEATH               = 3
};

enum Spells
{
    SPELL_WAR_STOMP                 = 34716,
    SPELL_SUMMON_TREANTS            = 34730, // 34727, 34730 - 34737, 34739
    SPELL_ARCANE_VOLLEY             = 36705,

    SPELL_SUMMON_SAPLINGS_SUMMON    = 34730,
    SPELL_SUMMON_SAPLINGS_PERIODIC  = 34741
};

struct boss_warp_splinter : public BossAI
{
    boss_warp_splinter(Creature* creature) : BossAI(creature, DATA_WARP_SPLINTER) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(8s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ARCANE_VOLLEY);
            context.Repeat(20s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_WAR_STOMP);
            context.Repeat(30s);
        }).Schedule(20s, [this](TaskContext context)
        {
            Talk(SAY_SUMMON);
            DoCastAOE(SPELL_SUMMON_SAPLINGS_PERIODIC, true);
            for (uint8 i = 0; i < 6; ++i)
            {
                DoCastAOE(SPELL_SUMMON_SAPLINGS_SUMMON + i, true);
            }
            context.Repeat(40s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_warp_splinter()
{
    RegisterTheBotanicaCreatureAI(boss_warp_splinter);
}
