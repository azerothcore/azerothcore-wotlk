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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "the_botanica.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_20_PERCENT_HP           = 1,
    SAY_KILL                    = 2,
    SAY_CAST_SACRIFICE          = 3,
    SAY_50_PERCENT_HP           = 4,
    SAY_CAST_HELLFIRE           = 5,
    SAY_DEATH                   = 6,
    EMOTE_ENRAGE                = 7,
    SAY_INTRO                   = 8
};

enum Spells
{
    SPELL_SACRIFICE             = 34661,
    SPELL_HELLFIRE              = 34659,
    SPELL_ENRAGE                = 34670
};

struct boss_thorngrin_the_tender : public BossAI
{
    boss_thorngrin_the_tender(Creature* creature) : BossAI(creature, DATA_THORNGRIN_THE_TENDER)
    {
        me->m_SightDistance = 100.0f;
        _intro = false;
    }

    void Reset() override
    {
        _Reset();
        ScheduleHealthCheckEvent(20, [&]() {
            Talk(SAY_20_PERCENT_HP);
        });
        ScheduleHealthCheckEvent(50, [&]() {
            Talk(SAY_50_PERCENT_HP);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_intro && who->IsPlayer())
        {
            _intro = true;
            Talk(SAY_INTRO);
        }
        BossAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_SACRIFICE, 1) == SPELL_CAST_OK)
            {
                Talk(SAY_CAST_SACRIFICE);
            }
            context.Repeat(30s);
        }).Schedule(18s, [this](TaskContext context)
        {
            if (roll_chance_i(50))
                Talk(SAY_CAST_HELLFIRE);
            DoCastAOE(SPELL_HELLFIRE);
            context.Repeat(22s);
        }).Schedule(15s, [this](TaskContext context)
        {
            Talk(EMOTE_ENRAGE);
            DoCastSelf(SPELL_ENRAGE);
            context.Repeat(30s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    private:
        bool _intro;
};

void AddSC_boss_thorngrin_the_tender()
{
    RegisterTheBotanicaCreatureAI(boss_thorngrin_the_tender);
}
