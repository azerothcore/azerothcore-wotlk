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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "halls_of_lightning.h"

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

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHallsOfLightningAI<boss_ionarAI>(creature);
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

        void Reset() override
        {
            HealthCheck = 50;
            events.Reset();
            summons.DespawnAll();

            me->SetVisible(true);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_IONAR, NOT_STARTED);
        }

        void ScheduleEvents(bool spark)
        {
            events.SetPhase(1);
            if (!spark)
                events.RescheduleEvent(EVENT_CHECK_HEALTH, 1s, 0, 1);

            events.RescheduleEvent(EVENT_BALL_LIGHTNING, 10s, 0, 1);
            events.RescheduleEvent(EVENT_STATIC_OVERLOAD, 5s, 0, 1);
        }

        void JustEngagedWith(Unit*) override
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_IONAR, IN_PROGRESS);

            ScheduleEvents(false);
        }

        void JustDied(Unit*) override
        {
            Talk(SAY_DEATH);

            summons.DespawnAll();

            if (m_pInstance)
                m_pInstance->SetData(TYPE_IONAR, DONE);
        }

        void KilledUnit(Unit* victim) override
        {
            if (!victim->IsPlayer())
                return;

            Talk(SAY_SLAY);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
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
                    spark->SetUnitFlag(UNIT_FLAG_PACIFIED | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    spark->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0);

                    if (Player* tgt = SelectTargetFromPlayerList(100))
                        spark->GetMotionMaster()->MoveFollow(tgt, 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
                }
            }

            me->SetVisible(false);
            me->SetControlled(true, UNIT_STATE_STUNNED);

            events.SetPhase(2);
            events.ScheduleEvent(EVENT_CALL_SPARKS, 15s, 0, 2);
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
                case EVENT_BALL_LIGHTNING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(target, me->GetMap()->IsHeroic() ? SPELL_BALL_LIGHTNING_H : SPELL_BALL_LIGHTNING_N, false);

                    events.Repeat(10s, 11s);
                    break;
                case EVENT_STATIC_OVERLOAD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(target, me->GetMap()->IsHeroic() ? SPELL_STATIC_OVERLOAD_H : SPELL_STATIC_OVERLOAD_N, false);

                    events.Repeat(5s, 6s);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(HealthCheck))
                        me->CastSpell(me, SPELL_DISPERSE, false);

                    events.Repeat(1s);
                    return;
                case EVENT_CALL_SPARKS:
                    {
                        EntryCheckPredicate pred(NPC_SPARK_OF_IONAR);
                        summons.DoAction(ACTION_CALLBACK, pred);
                        events.ScheduleEvent(EVENT_RESTORE, 2s, 0, 2);
                        return;
                    }
                case EVENT_RESTORE:
                    EntryCheckPredicate pred(NPC_SPARK_OF_IONAR);
                    summons.DoAction(ACTION_SPARK_DESPAWN, pred);

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

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHallsOfLightningAI<npc_spark_of_ionarAI>(creature);
    }

    struct npc_spark_of_ionarAI : public ScriptedAI
    {
        npc_spark_of_ionarAI(Creature* creature) : ScriptedAI(creature) { }

        bool returning;

        void MoveInLineOfSight(Unit*) override { }
        void UpdateAI(uint32) override { }
        void AttackStart(Unit*  /*who*/) override { }

        void Reset() override { returning = false; }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_CALLBACK)
            {
                me->SetSpeed(MOVE_RUN, 2.5f);
                me->GetThreatMgr().ClearAllThreat();
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
