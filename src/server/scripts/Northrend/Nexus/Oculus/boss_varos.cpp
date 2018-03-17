/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "oculus.h"

enum Spells
{
    SPELL_CORE_AURA_PASSIVE             = 50798,

    SPELL_AMPLIFY_MAGIC_N               = 51054,
    SPELL_AMPLIFY_MAGIC_H               = 59371,

    SPELL_ENERGIZE_CORES_N              = 50785,
    SPELL_ENERGIZE_CORES_H              = 59372,
    SPELL_ENERGIZE_CORES_THIN_N         = 61407,
    SPELL_ENERGIZE_CORES_THIN_H         = 62136,
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

#define SPELL_AMPLIFY_MAGIC             DUNGEON_MODE(SPELL_AMPLIFY_MAGIC_N, SPELL_AMPLIFY_MAGIC_H)
#define SPELL_ENERGIZE_CORES            DUNGEON_MODE(SPELL_ENERGIZE_CORES_N, SPELL_ENERGIZE_CORES_H)
#define SPELL_ENERGIZE_CORES_THIN       DUNGEON_MODE(SPELL_ENERGIZE_CORES_THIN_N, SPELL_ENERGIZE_CORES_THIN_H)

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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_varosAI (pCreature);
    }
    struct boss_varosAI : public ScriptedAI
    {
        boss_varosAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }
        
        InstanceScript* pInstance;
        EventMap events;
        float ZapAngle;

        void Reset()
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_VAROS, NOT_STARTED);
                if( pInstance->GetData(DATA_CC_COUNT) < 10 )
                {
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->CastSpell(me, 50053, true);
                }
                else
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
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

        void EnterCombat(Unit*  /*who*/)
        {
            Talk(SAY_AGGRO);

            if (pInstance)
                pInstance->SetData(DATA_VAROS, IN_PROGRESS);

            me->SetInCombatWithZone();

            events.RescheduleEvent(EVENT_AMPLIFY_MAGIC, urand(5000, 10000));
            events.RescheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_1, 5000);
            events.RescheduleEvent(EVENT_ENERGIZE_CORES_THIN, 0);
        }

        void JustDied(Unit*  /*killer*/)
        {
            Talk(SAY_DEATH);

            if (pInstance)
            {
                pInstance->SetData(DATA_VAROS, DONE);
                pInstance->instance->SummonCreature(NPC_IMAGE_OF_BELGARISTRASZ, *me);
            }
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->DisableRotate(false);
            ScriptedAI::EnterEvadeMode();
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void JustSummoned(Creature*  /*summon*/) {}

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            DoMeleeAttackIfReady();

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_AMPLIFY_MAGIC:
                    {
                        if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true) )
                            me->CastSpell(target, SPELL_AMPLIFY_MAGIC, false);
                        events.RepeatEvent(urand(17500, 22500));
                    }
                    break;
                case EVENT_CALL_AZURE_RING_CAPTAIN_1:
                case EVENT_CALL_AZURE_RING_CAPTAIN_2:
                case EVENT_CALL_AZURE_RING_CAPTAIN_3:
                case EVENT_CALL_AZURE_RING_CAPTAIN_4:
                    {
                        Talk(SAY_AZURE);
                        Talk(SAY_AZURE_EMOTE);
                        switch( events.GetEvent() )
                        {
                            case EVENT_CALL_AZURE_RING_CAPTAIN_1:
                                me->CastSpell(me, SPELL_CALL_AZURE_RING_CAPTAIN_1, true);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_2, 16000);
                                break;
                            case EVENT_CALL_AZURE_RING_CAPTAIN_2:
                                me->CastSpell(me, SPELL_CALL_AZURE_RING_CAPTAIN_2, true);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_3, 16000);
                                break;
                            case EVENT_CALL_AZURE_RING_CAPTAIN_3:
                                me->CastSpell(me, SPELL_CALL_AZURE_RING_CAPTAIN_3, true);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_4, 16000);
                                break;
                            case EVENT_CALL_AZURE_RING_CAPTAIN_4:
                                me->CastSpell(me, SPELL_CALL_AZURE_RING_CAPTAIN_4, true);
                                events.ScheduleEvent(EVENT_CALL_AZURE_RING_CAPTAIN_1, 16000);
                                break;
                        }
                        if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true) )
                        {
                            if( Creature* trigger = me->SummonCreature(NPC_ARCANE_BEAM, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 13000) )
                            {
                                if( Creature* c = me->FindNearestCreature(NPC_AZURE_RING_CAPTAIN, 500.0f, true) )
                                    c->CastSpell(trigger, SPELL_ARCANE_BEAM_VISUAL, true);
                                trigger->GetMotionMaster()->MoveChase(target, 0.1f);
                                trigger->CastSpell(me, SPELL_ARCANE_BEAM_PERIODIC_DAMAGE, true);
                            }
                        }
                        events.PopEvent();
                    }
                    break;
                case EVENT_ENERGIZE_CORES_THIN:
                    {
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        me->DisableRotate(false);
                        me->SetOrientation(ZapAngle);
                        me->CastSpell(me, SPELL_ENERGIZE_CORES_THIN, true);
                        events.PopEvent();
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES_DAMAGE, 4500);
                    }
                    break;
                case EVENT_ENERGIZE_CORES_DAMAGE:
                    {
                        me->SetOrientation(ZapAngle);
                        me->DisableRotate(true);
                        me->DisableSpline();
                        me->SetFacingTo(ZapAngle);
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->CastSpell((Unit*)NULL, SPELL_ENERGIZE_CORES, false);
                        ZapAngle += M_PI/2;
                        if( ZapAngle >= 2*M_PI )
                            ZapAngle -= 2*M_PI;
                        events.PopEvent();
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES_THIN, 2000);
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
