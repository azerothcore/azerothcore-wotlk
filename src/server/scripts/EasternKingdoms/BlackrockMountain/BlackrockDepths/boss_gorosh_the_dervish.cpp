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
#include "blackrock_depths.h"

enum Spells
{
    SPELL_WHIRLWIND    = 15589,
    SPELL_MORTALSTRIKE = 15708,
    SPELL_BLOODLUST    = 21049
};

enum Timers
{
    TIMER_WHIRLWIND = 12000,
    TIMER_MORTAL    = 22000,
    TIMER_BLOODLUST = 30000
};

class boss_gorosh_the_dervish : public CreatureScript
{
public:
    boss_gorosh_the_dervish() : CreatureScript("boss_gorosh_the_dervish") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_gorosh_the_dervishAI>(creature);
    }

    struct boss_gorosh_the_dervishAI : public BossAI
    {
        boss_gorosh_the_dervishAI(Creature* creature) : BossAI(creature, DATA_GOROSH) { }

        uint32 nextWhirlwindTime;

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(SPELL_WHIRLWIND, 0.2 * (int) TIMER_WHIRLWIND);
            events.ScheduleEvent(SPELL_MORTALSTRIKE, 0.2 * (int) TIMER_MORTAL);
            events.ScheduleEvent(SPELL_BLOODLUST, 0.2 * (int) TIMER_BLOODLUST);
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
                case SPELL_WHIRLWIND:
                    if (me->GetDistance2d(me->GetVictim()) < 10.0f)
                    {
                        DoCastVictim(SPELL_WHIRLWIND);
                        nextWhirlwindTime = urand(TIMER_WHIRLWIND - 2000, TIMER_WHIRLWIND + 2000);
                    }
                    else
                    {
                        // reschedule sooner
                        nextWhirlwindTime = 0.3 * urand(TIMER_WHIRLWIND - 2000, TIMER_WHIRLWIND + 2000);
                    }
                    events.ScheduleEvent(SPELL_WHIRLWIND, nextWhirlwindTime);
                    break;
                case SPELL_MORTALSTRIKE:
                    DoCastVictim(SPELL_MORTALSTRIKE);
                    events.ScheduleEvent(SPELL_MORTALSTRIKE, urand(TIMER_MORTAL - 2000, TIMER_MORTAL + 2000));
                    break;
                case SPELL_BLOODLUST:
                    DoCastSelf(SPELL_BLOODLUST);
                    events.ScheduleEvent(SPELL_BLOODLUST, urand(TIMER_BLOODLUST - 2000, TIMER_BLOODLUST + 2000));
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_gorosh_the_dervish()
{
    new boss_gorosh_the_dervish();
}
