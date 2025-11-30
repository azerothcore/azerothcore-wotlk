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
#include "oculus.h"

enum Spells
{
    SPELL_CORE_AURA_PASSIVE             = 50798,

    SPELL_AMPLIFY_MAGIC               = 51054,

    SPELL_ENERGIZE_CORES                = 50785,
    SPELL_ENERGIZE_CORES_THIN           = 61407,
    SPELL_ENERGIZE_CORES_TRIGGER_1      = 54069,
    SPELL_ENERGIZE_CORES_TRIGGER_2      = 56251,

    SPELL_CALL_AZURE_RING_CAPTAIN_1     = 51002,
    SPELL_CALL_AZURE_RING_CAPTAIN_2     = 51006,
    SPELL_CALL_AZURE_RING_CAPTAIN_3     = 51007,
    SPELL_CALL_AZURE_RING_CAPTAIN_4     = 51008,

    SPELL_SUMMON_ARCANE_BEAM_1          = 51014,
    SPELL_SUMMON_ARCANE_BEAM_2          = 51017,
    SPELL_ARCANE_BEAM_SPAWN_TRIGGER     = 51022,
    SPELL_ARCANE_BEAM_VISUAL            = 51024,
    SPELL_ARCANE_BEAM_PERIODIC_DAMAGE   = 51019,
};

enum VarosNPCs
{
    NPC_CENTRIFUGE_CORE                 = 28183,
    NPC_AZURE_RING_CAPTAIN              = 28236,
    NPC_ARCANE_BEAM                     = 28239,
};

enum Events
{
    EVENT_AMPLIFY_MAGIC                 = 1,
    EVENT_CALL_AZURE_RING_CAPTAIN_1     = 2,
    EVENT_CALL_AZURE_RING_CAPTAIN_2     = 3,
    EVENT_CALL_AZURE_RING_CAPTAIN_3     = 4,
    EVENT_CALL_AZURE_RING_CAPTAIN_4     = 5,
    EVENT_ENERGIZE_CORES_THIN           = 6,
    EVENT_ENERGIZE_CORES_DAMAGE         = 7,
};

enum Says
{
    SAY_AGGRO           = 0,
    SAY_AZURE           = 1,
    SAY_AZURE_EMOTE     = 2,
    SAY_DEATH           = 3
};

class boss_varos : public CreatureScript
{
public:
    boss_varos() : CreatureScript("boss_varos") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetOculusAI<boss_varosAI>(pCreature);
    }
    struct boss_varosAI : public ScriptedAI
    {
        boss_varosAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        float ZapAngle;
        uint8 step = 0;

        void Reset() override
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_VAROS, NOT_STARTED);
                if (pInstance->GetData(DATA_CC_COUNT) < 10 )
                {
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->CastSpell(me, 50053, true);
                }
                else
                {
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->InterruptNonMeleeSpells(false);
                    me->RemoveAura(50053);
                }
            }

            events.Reset();
            ZapAngle = 6.20f;
            me->ApplySpellImmune(0, IMMUNITY_ID, 49838, true);
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            Talk(SAY_AGGRO);

            if (pInstance)
                pInstance->SetData(DATA_VAROS, IN_PROGRESS);

            me->SetInCombatWithZone();

            events.RescheduleEvent(EVENT_AMPLIFY_MAGIC, 5s, 10s);
            events.RescheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_1, 5s);
            events.RescheduleEvent(EVENT_ENERGIZE_CORES_THIN, 0ms);
        }

        void JustDied(Unit*  /*killer*/) override
        {
            Talk(SAY_DEATH);

            if (pInstance)
            {
                pInstance->SetData(DATA_VAROS, DONE);
                pInstance->instance->SummonCreature(NPC_IMAGE_OF_BELGARISTRASZ, *me);
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode(why);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void JustSummoned(Creature*  /*summon*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_AMPLIFY_MAGIC:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                            me->CastSpell(target, SPELL_AMPLIFY_MAGIC, false);
                        events.Repeat(17s + 500ms, 22s + 500ms);
                    }
                    break;
                case EVENT_CALL_AZURE_RING_CAPTAIN_1:
                case EVENT_CALL_AZURE_RING_CAPTAIN_2:
                case EVENT_CALL_AZURE_RING_CAPTAIN_3:
                case EVENT_CALL_AZURE_RING_CAPTAIN_4:
                    {
                        Talk(SAY_AZURE);
                        Talk(SAY_AZURE_EMOTE);
                        switch (step)
                        {
                            case 0:
                                DoCast(SPELL_CALL_AZURE_RING_CAPTAIN_1);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_2, 16s);
                                break;
                            case 1:
                                DoCast(SPELL_CALL_AZURE_RING_CAPTAIN_2);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_3, 16s);
                                break;
                            case 2:
                                DoCast(SPELL_CALL_AZURE_RING_CAPTAIN_3);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_4, 16s);
                                break;
                            case 3:
                                DoCast(SPELL_CALL_AZURE_RING_CAPTAIN_4);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_1, 16s);
                                break;
                        }

                        step++;
                        if (step > 3)
                            step = 0;

                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        {
                            if (Creature* trigger = me->SummonCreature(NPC_ARCANE_BEAM, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 13000))
                            {
                                if (Creature* c = me->FindNearestCreature(NPC_AZURE_RING_CAPTAIN, 500.0f, true))
                                    c->CastSpell(trigger, SPELL_ARCANE_BEAM_VISUAL, true);
                                trigger->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f, MOTION_SLOT_ACTIVE, false, false); /// @todo: sniff speed for NPC_ARCANE_BEAM (ID: 28239)
                                trigger->CastSpell(me, SPELL_ARCANE_BEAM_PERIODIC_DAMAGE, true);
                            }
                        }
                    }
                    break;
                case EVENT_ENERGIZE_CORES_THIN:
                    {
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        me->DisableRotate(false);
                        me->SetOrientation(ZapAngle);
                        me->CastSpell(me, SPELL_ENERGIZE_CORES_THIN, true);
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES_DAMAGE, 4500ms);
                    }
                    break;
                case EVENT_ENERGIZE_CORES_DAMAGE:
                    {
                        me->SetOrientation(ZapAngle);
                        me->DisableRotate(true);
                        me->DisableSpline();
                        me->SetFacingTo(ZapAngle);
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->CastSpell((Unit*)nullptr, SPELL_ENERGIZE_CORES, false);
                        ZapAngle += M_PI / 2;
                        if (ZapAngle >= 2 * M_PI)
                            ZapAngle -= 2 * M_PI;
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES_THIN, 2s);
                    }
                    break;
            }
        }
    };
};

void AddSC_boss_varos()
{
    new boss_varos();
}
