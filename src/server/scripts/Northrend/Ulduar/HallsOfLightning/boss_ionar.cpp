/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "halls_of_lightning.h"
#include "SpellInfo.h"
#include "Player.h"

enum IonarSpells
{
    SPELL_BALL_LIGHTNING_N          = 52780,
    SPELL_BALL_LIGHTNING_H          = 59800,
    SPELL_STATIC_OVERLOAD_N         = 52658,
    SPELL_STATIC_OVERLOAD_H         = 59795,

    SPELL_DISPERSE                  = 52770,
    SPELL_SUMMON_SPARK              = 52746,
    SPELL_SPARK_DESPAWN             = 52776,

    //Spark of Ionar
    SPELL_SPARK_VISUAL_TRIGGER_N    = 52667,
    SPELL_SPARK_VISUAL_TRIGGER_H    = 59833,
    SPELL_RANDOM_LIGHTNING          = 52663,
};

enum IonarOther
{
    // NPCs
    NPC_SPARK_OF_IONAR              = 28926,

    // Actions
    ACTION_CALLBACK                 = 1,
    ACTION_SPARK_DESPAWN            = 2,
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_SPLIT                       = 1,
    SAY_SLAY                        = 2,
    SAY_DEATH                       = 3
};

enum IonarEvents
{
    EVENT_BALL_LIGHTNING            = 1,
    EVENT_STATIC_OVERLOAD           = 2,
    EVENT_CHECK_HEALTH              = 3,
    EVENT_CALL_SPARKS               = 4,
    EVENT_RESTORE                   = 5,
};

class boss_ionar : public CreatureScript
{
public:
    boss_ionar() : CreatureScript("boss_ionar") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ionarAI (creature);
    }

    struct boss_ionarAI : public ScriptedAI
    {
        boss_ionarAI(Creature* creature) : ScriptedAI(creature), summons(creature)
        {
            m_pInstance = creature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        uint8 HealthCheck;

        void Reset()
        {
            HealthCheck = 50;
            events.Reset();
            summons.DespawnAll();

            me->SetVisible(true);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_IONAR, NOT_STARTED);

            // Ionar is immune to nature damage
            me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NATURE, true);
        }

        void ScheduleEvents(bool spark)
        {
            events.SetPhase(1);
            if (!spark)
                events.RescheduleEvent(EVENT_CHECK_HEALTH, 1000, 0, 1);

            events.RescheduleEvent(EVENT_BALL_LIGHTNING, 10000, 0, 1);
            events.RescheduleEvent(EVENT_STATIC_OVERLOAD, 5000, 0, 1);
        }

        void EnterCombat(Unit*)
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_IONAR, IN_PROGRESS);

            ScheduleEvents(false);
        }

        void JustDied(Unit*)
        {
            Talk(SAY_DEATH);

            summons.DespawnAll();

            if (m_pInstance)
                m_pInstance->SetData(TYPE_IONAR, DONE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_DISPERSE)
                Split();
        }

        void Split()
        {
            Talk(SAY_SPLIT);

            Creature* spark;
            for (uint8 i = 0; i < 5; ++i)
            {
                if ((spark = me->SummonCreature(NPC_SPARK_OF_IONAR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 20000)))
                {
                    summons.Summon(spark);
                    spark->CastSpell(spark, me->GetMap()->IsHeroic() ? SPELL_SPARK_VISUAL_TRIGGER_H : SPELL_SPARK_VISUAL_TRIGGER_N, true);
                    spark->CastSpell(spark, SPELL_RANDOM_LIGHTNING, true);
                    spark->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED|UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                    spark->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0);

                    if (Player* tgt = SelectTargetFromPlayerList(100))
                        spark->GetMotionMaster()->MoveFollow(tgt, 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
                }
            }
            
            me->SetVisible(false);
            me->SetControlled(true, UNIT_STATE_STUNNED);

            events.SetPhase(2);
            events.ScheduleEvent(EVENT_CALL_SPARKS, 15000, 0, 2);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_BALL_LIGHTNING:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, me->GetMap()->IsHeroic() ? SPELL_BALL_LIGHTNING_H : SPELL_BALL_LIGHTNING_N, false);
                    
                    events.RepeatEvent(10000 + rand()%1000);
                    break;
                case EVENT_STATIC_OVERLOAD:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        me->CastSpell(target, me->GetMap()->IsHeroic() ? SPELL_STATIC_OVERLOAD_H : SPELL_STATIC_OVERLOAD_N, false);

                    events.RepeatEvent(5000 + rand()%1000);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(HealthCheck))
                        me->CastSpell(me, SPELL_DISPERSE, false);

                    events.RepeatEvent(1000);
                    return;
                case EVENT_CALL_SPARKS:
                {
                    EntryCheckPredicate pred(NPC_SPARK_OF_IONAR);
                    summons.DoAction(ACTION_CALLBACK, pred);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_RESTORE, 2000, 0, 2);
                    return;
                }
                case EVENT_RESTORE:
                    EntryCheckPredicate pred(NPC_SPARK_OF_IONAR);
                    summons.DoAction(ACTION_SPARK_DESPAWN, pred);
                    events.PopEvent();

                    me->SetVisible(true);
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    ScheduleEvents(true);
                    return;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_spark_of_ionar : public CreatureScript
{
public:
    npc_spark_of_ionar() : CreatureScript("npc_spark_of_ionar") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_spark_of_ionarAI (creature);
    }

    struct npc_spark_of_ionarAI : public ScriptedAI
    {
        npc_spark_of_ionarAI(Creature* creature) : ScriptedAI(creature) { }

        bool returning;

        void MoveInLineOfSight(Unit*) { }
        void UpdateAI(uint32) { }
        void AttackStart(Unit*  /*who*/) { }

        void Reset() { returning = false; }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            damage = 0;
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_CALLBACK)
            {
                me->SetSpeed(MOVE_RUN, 2.5f);
                me->DeleteThreatList();
                me->CombatStop(true);
                me->GetMotionMaster()->MoveTargetedHome();
                returning = true;
            }
            else if (param == ACTION_SPARK_DESPAWN)
            {
                me->GetMotionMaster()->MoveIdle();

                me->RemoveAllAuras();
                me->CastSpell(me, SPELL_SPARK_DESPAWN, true);
                me->DespawnOrUnsummon(1000);
            }
        }
    };
};

void AddSC_boss_ionar()
{
    new boss_ionar();
    new npc_spark_of_ionar();
}
