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

#include "blackrock_depths.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_ARCANE_BOLT       = 13748,
    SPELL_ARCANE_EXPLOSION  = 1467,
    SPELL_POLYMORPH         = 15534,
    SPELL_SLOW              = 19137
};

enum Timers
{
    TIMER_ARCANE_BOLT        = 7000,
    TIMER_ARCANE_EXPLOSION  = 24000,
    TIMER_POLYMORPH         = 12000,
    TIMER_SLOW              = 15000
};

class boss_okthor : public CreatureScript
{
public:
    boss_okthor() : CreatureScript("boss_okthor") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_okthorAI>(creature);
    }

    struct boss_okthorAI : public BossAI
    {
        boss_okthorAI(Creature* creature) : BossAI(creature, DATA_OKTHOR) {}

        uint32 nextArcaneExplosionTime;

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(SPELL_ARCANE_BOLT, 0.2 * (int) TIMER_ARCANE_BOLT);
            events.ScheduleEvent(SPELL_ARCANE_EXPLOSION, 0.2 * (int) TIMER_ARCANE_EXPLOSION);
            events.ScheduleEvent(SPELL_POLYMORPH, 0.2 * (int) TIMER_POLYMORPH);
            events.ScheduleEvent(SPELL_SLOW, 500);
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
                case SPELL_ARCANE_BOLT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                        DoCast(target, SPELL_ARCANE_BOLT);
                    }
                    events.ScheduleEvent(SPELL_ARCANE_BOLT, urand(TIMER_ARCANE_BOLT - 2000, TIMER_ARCANE_BOLT + 2000));
                    break;
                case SPELL_ARCANE_EXPLOSION:
                    if (me->GetDistance2d(me->GetVictim()) < 50.0f)
                    {
                        DoCast(SPELL_ARCANE_EXPLOSION);
                        nextArcaneExplosionTime = urand(TIMER_ARCANE_EXPLOSION - 2000, TIMER_ARCANE_EXPLOSION + 2000);
                    }
                    else
                    {
                        nextArcaneExplosionTime = 0.3*urand(TIMER_ARCANE_EXPLOSION - 2000, TIMER_ARCANE_EXPLOSION + 2000);
                    }
                    events.ScheduleEvent(SPELL_ARCANE_EXPLOSION, nextArcaneExplosionTime);
                    break;
                case SPELL_POLYMORPH:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                        DoCast(target, SPELL_POLYMORPH);
                    }
                    events.ScheduleEvent(SPELL_POLYMORPH, urand(TIMER_POLYMORPH - 2000, TIMER_POLYMORPH + 2000));
                    break;
                case SPELL_SLOW:
                    if (me->GetDistance2d(me->GetVictim()) < 50.0f)
                    {
                        DoCast(SPELL_SLOW);
                    }
                    events.ScheduleEvent(SPELL_SLOW, TIMER_SLOW);
                    break;

                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_okthor()
{
    new boss_okthor();
}
