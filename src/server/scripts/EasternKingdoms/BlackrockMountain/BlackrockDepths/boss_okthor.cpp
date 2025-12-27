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
    SPELL_ARCANE_BOLT       = 13748,
    SPELL_ARCANE_EXPLOSION  = 1467,
    SPELL_POLYMORPH         = 15534,
    SPELL_SLOW              = 19137
};

constexpr Milliseconds TIMER_ARCANE_BOLT = 7s;
constexpr Milliseconds TIMER_ARCANE_EXPLOSION = 24s;
constexpr Milliseconds TIMER_POLYMORPH = 12s;
constexpr Milliseconds TIMER_SLOW = 15s;

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

        Milliseconds nextArcaneExplosionTime;

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(SPELL_ARCANE_BOLT, TIMER_ARCANE_BOLT / 5);
            events.ScheduleEvent(SPELL_ARCANE_EXPLOSION, TIMER_ARCANE_EXPLOSION / 5);
            events.ScheduleEvent(SPELL_POLYMORPH, TIMER_POLYMORPH / 5);
            events.ScheduleEvent(SPELL_SLOW, 500ms);
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
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_ARCANE_BOLT);
                    }
                    events.ScheduleEvent(SPELL_ARCANE_BOLT, TIMER_ARCANE_BOLT - 2s, TIMER_ARCANE_BOLT + 2s);
                    break;
                case SPELL_ARCANE_EXPLOSION:
                    if (me->GetDistance2d(me->GetVictim()) < 50.0f)
                    {
                        DoCast(SPELL_ARCANE_EXPLOSION);
                        nextArcaneExplosionTime = randtime(TIMER_ARCANE_EXPLOSION - 2s, TIMER_ARCANE_EXPLOSION + 2s);
                    }
                    else
                    {
                        nextArcaneExplosionTime = randtime(TIMER_ARCANE_EXPLOSION - 2s, TIMER_ARCANE_EXPLOSION + 2s) / 3;
                    }
                    events.ScheduleEvent(SPELL_ARCANE_EXPLOSION, nextArcaneExplosionTime);
                    break;
                case SPELL_POLYMORPH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_POLYMORPH);
                    }
                    events.ScheduleEvent(SPELL_POLYMORPH, TIMER_POLYMORPH - 2s, TIMER_POLYMORPH + 2s);
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
