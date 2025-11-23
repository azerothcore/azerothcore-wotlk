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
    SPELL_LIGHTNING_BOLT        = 35010,
    SPELL_HEALING_WARD          = 34980,
    SPELL_EARTHGRAB_TOTEM       = 31981,
    SPELL_STONESKIN_TOTEM       = 31985,
    SPELL_NOVA_TOTEM            = 31991
};

enum Text
{
    SAY_AGGRO       = 1,
    SAY_KILL        = 2,
    SAY_JUST_DIED   = 3
};

struct boss_mennu_the_betrayer : public BossAI
{
    boss_mennu_the_betrayer(Creature* creature) : BossAI(creature, DATA_MENNU_THE_BETRAYER)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();

        ScheduleHealthCheckEvent(60, [&] {
            DoCastSelf(SPELL_HEALING_WARD);
        });
    }

    void JustSummoned(Creature* summon) override
    {
        summon->GetMotionMaster()->Clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(5s, 8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_LIGHTNING_BOLT);
            context.Repeat(7s, 10s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_NOVA_TOTEM);
            context.Repeat(26s);
        }).Schedule(19200ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_EARTHGRAB_TOTEM);
            context.Repeat(26s);
        }).Schedule(18s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_STONESKIN_TOTEM);
            context.Repeat(26s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_JUST_DIED);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_KILL);
    }
};

void AddSC_boss_mennu_the_betrayer()
{
    RegisterTheSlavePensCreatureAI(boss_mennu_the_betrayer);
}
