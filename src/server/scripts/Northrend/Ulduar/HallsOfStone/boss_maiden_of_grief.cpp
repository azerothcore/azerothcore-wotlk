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
#include "halls_of_stone.h"

enum spells
{
    PARTING_SORROW          = 59723,
    PILLAR_OF_WOE           = 50761,
    PILLAR_OF_WOE_H         = 59727,
    SHOCK_OF_SORROW         = 50760,
    SHOCK_OF_SORROW_H       = 59726,
    STORM_OF_GRIEF          = 50752,
    STORM_OF_GRIEF_H        = 59772,

    ACHIEVEMENT_GOOD_GRIEF  = 20383,
};
enum maidenEvents
{
    EVENT_NONE,
    EVENT_STORM,
    EVENT_SHOCK,
    EVENT_PILLAR,
    EVENT_PARTING,
};

enum Yells
{
    SAY_AGGRO                                     = 0,
    SAY_SLAY                                      = 1,
    SAY_DEATH                                     = 2,
    SAY_STUN                                      = 3
};

class boss_maiden_of_grief : public CreatureScript
{
public:
    boss_maiden_of_grief() : CreatureScript("boss_maiden_of_grief") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetHallsOfStoneAI<boss_maiden_of_griefAI>(pCreature);
    }

    struct boss_maiden_of_griefAI : public ScriptedAI
    {
        boss_maiden_of_griefAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            if (pInstance)
            {
                pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_GOOD_GRIEF);
                pInstance->SetData(BOSS_MAIDEN_OF_GRIEF, NOT_STARTED);
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            events.ScheduleEvent(EVENT_STORM, 5s);
            events.ScheduleEvent(EVENT_SHOCK, 26s, 32s);
            events.ScheduleEvent(EVENT_PILLAR, 12s, 20s);
            events.ScheduleEvent(EVENT_PARTING, 8s);

            Talk(SAY_AGGRO);
            if (pInstance)
            {
                pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_GOOD_GRIEF);
                pInstance->SetData(BOSS_MAIDEN_OF_GRIEF, IN_PROGRESS);
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
                case EVENT_STORM:
                    {
                        me->CastSpell(me->GetVictim(), DUNGEON_MODE(STORM_OF_GRIEF, STORM_OF_GRIEF_H), true);
                        events.Repeat(10s);
                        break;
                    }
                case EVENT_SHOCK:
                    {
                        me->CastSpell(me->GetVictim(), DUNGEON_MODE(SHOCK_OF_SORROW, SHOCK_OF_SORROW_H), false);
                        Talk(SAY_STUN);

                        events.Repeat(16s, 22s);
                        break;
                    }
                case EVENT_PILLAR:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true, 0))
                            me->CastSpell(target, DUNGEON_MODE(PILLAR_OF_WOE, PILLAR_OF_WOE_H), false);

                        events.Repeat(12s, 20s);
                        break;
                    }
                case EVENT_PARTING:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true, 0))
                            me->CastSpell(target, PARTING_SORROW, false);

                        events.Repeat(6s, 16s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/) override
        {
            Talk(SAY_DEATH);

            if (pInstance)
                pInstance->SetData(BOSS_MAIDEN_OF_GRIEF, DONE);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_SLAY);
        }
    };
};

void AddSC_boss_maiden_of_grief()
{
    new boss_maiden_of_grief();
}
