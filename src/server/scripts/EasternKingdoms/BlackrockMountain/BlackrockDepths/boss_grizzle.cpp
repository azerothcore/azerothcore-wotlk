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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_depths.h"

enum Grizzle
{
    SPELL_GROUNDTREMOR      = 6524,
    SPELL_FRENZY            = 8269,
    EMOTE_FRENZY_KILL       = 0
};

enum Timer
{
    TIMER_GROUNDTREMOR  = 10000,
    TIMER_FRENZY        = 15000
};

class boss_grizzle : public CreatureScript
{
public:
    boss_grizzle() : CreatureScript("boss_grizzle") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_grizzleAI>(creature);
    }

    struct boss_grizzleAI : public BossAI
    {
        boss_grizzleAI(Creature* creature) : BossAI(creature, DATA_GRIZZLE) {}

        uint32 nextTremorTime;

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(SPELL_GROUNDTREMOR, 0.2 * (int) TIMER_GROUNDTREMOR);
            events.ScheduleEvent(SPELL_FRENZY, 0.2 * (int) TIMER_FRENZY);
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
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
                case SPELL_GROUNDTREMOR:
                    if (me->GetDistance2d(me->GetVictim()) < 10.0f)
                    {
                        DoCastVictim(SPELL_GROUNDTREMOR);
                        nextTremorTime = urand(TIMER_GROUNDTREMOR - 2000, TIMER_GROUNDTREMOR + 2000);
                    }
                    else
                    {
                        nextTremorTime = 0.3*urand(TIMER_GROUNDTREMOR - 2000, TIMER_GROUNDTREMOR + 2000);
                    }
                    events.ScheduleEvent(SPELL_GROUNDTREMOR, nextTremorTime);
                    break;
                case SPELL_FRENZY:
                    DoCastSelf(SPELL_FRENZY);
                    events.ScheduleEvent(SPELL_FRENZY, urand(TIMER_FRENZY - 2000, TIMER_FRENZY + 2000));
                    Talk(EMOTE_FRENZY_KILL);
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_grizzle()
{
    new boss_grizzle();
}
