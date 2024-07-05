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
#include "SpellInfo.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CURSE_OF_EXERTION                     = 52772,
    SPELL_WOUNDING_STRIKE_N                     = 52771,
    SPELL_WOUNDING_STRIKE_H                     = 58830,
    SPELL_TIME_STOP                             = 58848,
    SPELL_TIME_WARP                             = 52766,
    SPELL_TIME_STEP_N                           = 52737,
    SPELL_TIME_STEP_H                           = 58829,
};

enum Events
{
    EVENT_SPELL_CURSE_OF_EXERTION               = 1,
    EVENT_SPELL_WOUNDING_STRIKE                 = 2,
    EVENT_SPELL_TIME_STOP                       = 3,
    EVENT_SPELL_TIME_WARP                       = 4,
    EVENT_TIME_WARP                             = 5,
};

enum Yells
{
    SAY_INTRO                                   = 0,
    SAY_AGGRO                                   = 1,
    SAY_TIME_WARP                               = 2,
    SAY_SLAY                                    = 3,
    SAY_DEATH                                   = 4
};

class boss_epoch : public CreatureScript
{
public:
    boss_epoch() : CreatureScript("boss_epoch") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<boss_epochAI>(creature);
    }

    struct boss_epochAI : public ScriptedAI
    {
        boss_epochAI(Creature* c) : ScriptedAI(c)
        {
        }

        EventMap events;
        uint8 warps;
        void Reset() override
        {
            events.Reset();
            warps = 0;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_SPELL_CURSE_OF_EXERTION, 9000);
            events.ScheduleEvent(EVENT_SPELL_WOUNDING_STRIKE, 3000);
            events.ScheduleEvent(EVENT_SPELL_TIME_WARP, 25000);

            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_TIME_STOP, 20000);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_TIME_STEP_H || spellInfo->Id == SPELL_TIME_STEP_N)
            {
                if (target == me)
                    return;

                if (warps >= 2)
                {
                    warps = 0;
                    return;
                }
                warps++;
                me->CastSpell(target, DUNGEON_MODE(SPELL_TIME_STEP_N, SPELL_TIME_STEP_H), true);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_CURSE_OF_EXERTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_CURSE_OF_EXERTION, false);
                    events.RepeatEvent(9000);
                    break;
                case EVENT_SPELL_WOUNDING_STRIKE:
                    me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_WOUNDING_STRIKE_N, SPELL_WOUNDING_STRIKE_H), false);
                    events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_TIME_STOP:
                    me->CastSpell(me, SPELL_TIME_STOP, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_TIME_WARP:
                    Talk(SAY_TIME_WARP);
                    me->CastSpell(me, SPELL_TIME_WARP, false);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_TIME_STEP_N, SPELL_TIME_STEP_H), true);

                    events.RepeatEvent(25000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (!urand(0, 1))
                return;

            Talk(SAY_SLAY);
        }
    };
};

void AddSC_boss_epoch()
{
    new boss_epoch();
}
