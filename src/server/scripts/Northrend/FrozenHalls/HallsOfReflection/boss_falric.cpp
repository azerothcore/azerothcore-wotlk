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
#include "halls_of_reflection.h"
#include "ScriptedCreature.h"

enum Yells
{
    SAY_AGGRO                                     = 0,
    SAY_SLAY                                      = 1,
    SAY_DEATH                                     = 2,
    SAY_IMPENDING_DESPAIR                         = 3,
    SAY_DEFILING_HORROR                           = 4,
};

enum Spells
{
    SPELL_QUIVERING_STRIKE                        = 72422,
    SPELL_IMPENDING_DESPAIR                       = 72426,
    SPELL_DEFILING_HORROR                         = 72435,
};

enum Events
{
    EVENT_NONE,
    EVENT_QUIVERING_STRIKE,
    EVENT_IMPENDING_DESPAIR,
    EVENT_DEFILING_HORROR,
    EVENT_UNROOT,
};

const uint32 hopelessnessId[3][2] = { {72395, 72390}, {72396, 72391}, {72397, 72393} };

class boss_falric : public CreatureScript
{
public:
    boss_falric() : CreatureScript("boss_falric") { }

    struct boss_falricAI : public ScriptedAI
    {
        boss_falricAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 uiHopelessnessCount;
        uint16 startFightTimer;

        void Reset() override
        {
            startFightTimer = 0;
            uiHopelessnessCount = 0;
            me->SetImmuneToAll(true);
            me->SetControlled(false, UNIT_STATE_ROOT);
            events.Reset();
            if (pInstance)
                pInstance->SetData(DATA_FALRIC, NOT_STARTED);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->SetImmuneToAll(false);

            events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 5s);
            events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 11s);
            events.ScheduleEvent(EVENT_DEFILING_HORROR, 20s);
        }

        void DoAction(int32 a) override
        {
            if (a == 1)
            {
                Talk(SAY_AGGRO);
                startFightTimer = 8000;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (startFightTimer)
            {
                if (startFightTimer <= diff)
                {
                    startFightTimer = 0;
                    me->SetInCombatWithZone();
                }
                else
                    startFightTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_QUIVERING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_QUIVERING_STRIKE, false);
                    events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 5s);
                    break;
                case EVENT_IMPENDING_DESPAIR:
                    if (Unit* target = SelectTargetFromPlayerList(45.0f, 0, true))
                    {
                        Talk(SAY_IMPENDING_DESPAIR);
                        me->CastSpell(target, SPELL_IMPENDING_DESPAIR, false);
                    }
                    events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 12s);
                    break;
                case EVENT_DEFILING_HORROR:
                    Talk(SAY_DEFILING_HORROR);
                    me->CastSpell((Unit*)nullptr, SPELL_DEFILING_HORROR, false);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    events.DelayEventsToMax(5000, 0);
                    events.ScheduleEvent(EVENT_UNROOT, 4s);
                    events.ScheduleEvent(EVENT_DEFILING_HORROR, 20s);
                    break;
                case EVENT_UNROOT:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    break;
            }

            if ((uiHopelessnessCount == 0 && HealthBelowPct(67)) || (uiHopelessnessCount == 1 && HealthBelowPct(34)) || (uiHopelessnessCount == 2 && HealthBelowPct(11)))
            {
                if (uiHopelessnessCount)
                    me->RemoveOwnedAura(hopelessnessId[uiHopelessnessCount - 1][DUNGEON_MODE(0, 1)]);
                me->CastSpell((Unit*)nullptr, hopelessnessId[uiHopelessnessCount][DUNGEON_MODE(0, 1)], true);
                ++uiHopelessnessCount;
            }

            if (!me->HasUnitState(UNIT_STATE_ROOT))
                DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_FALRIC, DONE);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode(why);
            if (startFightTimer)
                Reset();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHallsOfReflectionAI<boss_falricAI>(creature);
    }
};

void AddSC_boss_falric()
{
    new boss_falric();
}

