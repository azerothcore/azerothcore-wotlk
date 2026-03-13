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
#include "halls_of_stone.h"

enum spells
{
    SPELL_PARTING_SORROW    = 59723,
    SPELL_PILLAR_OF_WOE     = 50761,
    SPELL_SHOCK_OF_SORROW   = 50760,
    SPELL_STORM_OF_GRIEF    = 50752,

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
            events.ScheduleEvent(EVENT_STORM, 6s, 10s);
            events.ScheduleEvent(EVENT_SHOCK, 14s, 29s);
            events.ScheduleEvent(EVENT_PILLAR, 7s, 15s);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_PARTING, 27s, 45s);

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
                        me->CastSpell(me->GetVictim(), SPELL_STORM_OF_GRIEF, true);
                        events.Repeat(16s, 20s);
                        break;
                    }
                case EVENT_SHOCK:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_SHOCK_OF_SORROW, false);
                        Talk(SAY_STUN);

                        events.Repeat(19s, 33s);
                        break;
                    }
                case EVENT_PILLAR:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true, 0))
                            me->CastSpell(target, SPELL_PILLAR_OF_WOE, false);

                        events.Repeat(8s, 31s);
                        break;
                    }
                case EVENT_PARTING:
                    {
                        Unit* target = nullptr;
                        std::list<Unit*> targetList;

                        SelectTargetList(targetList, 10, SelectTargetMethod::Random, 0, 50.0f, true);
                        for (Unit* possibleTarget : targetList)
                        {
                            if (possibleTarget && possibleTarget->IsPlayer() && possibleTarget->getPowerType() == POWER_MANA)
                            {
                                target = possibleTarget;
                                break;
                            }
                        }

                        if (target)
                            me->CastSpell(target, SPELL_PARTING_SORROW, false);

                        events.Repeat(27s, 45s);
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
