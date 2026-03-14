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
#include "blackrock_depths.h"

enum Spells
{
    SPELL_PARALYZING    = 3609,
    SPELL_BANEFUL       = 15475,
    SPELL_WEB_EXPLOSION = 15474
};

constexpr Milliseconds TIMER_PARALYZING = 20s;
constexpr Milliseconds TIMER_BANEFUL = 24s;
constexpr Milliseconds TIMER_WEB_EXPLOSION = 20s;

class boss_hedrum : public CreatureScript
{
public:
    boss_hedrum() : CreatureScript("boss_hedrum") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_hedrumAI>(creature);
    }

    struct boss_hedrumAI : public BossAI
    {
        boss_hedrumAI(Creature* creature) : BossAI(creature, DATA_HEDRUM) {}

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(SPELL_PARALYZING, TIMER_PARALYZING / 5);
            events.ScheduleEvent(SPELL_BANEFUL, TIMER_BANEFUL / 5);
            events.ScheduleEvent(SPELL_WEB_EXPLOSION, TIMER_WEB_EXPLOSION / 5);
        }

        void UpdateAI(uint32 diff) override
        {
            // Return since we have no target
            if (!UpdateVictim())
            {
                return;
            }
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }
            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_PARALYZING:
                    DoCastVictim(SPELL_PARALYZING);
                    events.ScheduleEvent(SPELL_PARALYZING, TIMER_PARALYZING - 2s, TIMER_PARALYZING + 2s);
                    break;
                case SPELL_BANEFUL:
                    DoCastVictim(SPELL_BANEFUL);
                    events.ScheduleEvent(SPELL_BANEFUL, TIMER_BANEFUL - 2s, TIMER_BANEFUL + 2s);
                    break;
                case SPELL_WEB_EXPLOSION:
                    if (me->GetDistance2d(me->GetVictim()) < 100.0f)
                    {
                        DoCast(SPELL_WEB_EXPLOSION);
                    }
                    events.ScheduleEvent(SPELL_WEB_EXPLOSION, TIMER_WEB_EXPLOSION - 2s, TIMER_WEB_EXPLOSION + 2s);
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_hedrum()
{
    new boss_hedrum();
}
