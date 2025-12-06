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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "SpellInfo.h"
#include "halls_of_lightning.h"

enum IonarSpells
{
    SPELL_BALL_LIGHTNING            = 52780,
    SPELL_STATIC_OVERLOAD           = 52658,
    SPELL_STATIC_OVERLOAD_KNOCK     = 53337,

    SPELL_DISPERSE                  = 52770,
    SPELL_SUMMON_SPARK              = 52746,
    SPELL_SPARK_DESPAWN             = 52776,

    //Spark of Ionar
    SPELL_SPARK_VISUAL_TRIGGER      = 52667,
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
    EVENT_CHANGE_TARGET             = 6,
};

struct boss_ionar : public BossAI
{
    boss_ionar(Creature* creature) : BossAI(creature, DATA_IONAR) { }

    void Reset() override
    {
        _Reset();
        me->SetVisible(true);

        ScheduleHealthCheckEvent(50, [&] {
            DoCastSelf(SPELL_DISPERSE);
        });
    }

    void ScheduleEvents(bool spark)
    {
        events.SetPhase(1);
        if (!spark)
            events.RescheduleEvent(EVENT_CHECK_HEALTH, 1s, 0, 1);

        events.RescheduleEvent(EVENT_BALL_LIGHTNING, 7s, 11s, 0, 1);
        events.RescheduleEvent(EVENT_STATIC_OVERLOAD, 6s, 12s, 0, 1);
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        ScheduleEvents(false);
    }

    void JustDied(Unit*) override
    {
        _JustDied();
        Talk(SAY_DEATH);
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

        for (uint8 i = 0; i < 5; ++i)
        {
            if (Creature* spark = me->SummonCreature(NPC_SPARK_OF_IONAR, me->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 20000))
            {
                spark->CastSpell(spark, SPELL_SPARK_VISUAL_TRIGGER, true);
                spark->CastSpell(spark, SPELL_RANDOM_LIGHTNING, true);
                spark->SetUnitFlag(UNIT_FLAG_PACIFIED | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                spark->SetHomePosition(me->GetPosition());

                if (Player* tgt = SelectTargetFromPlayerList(100))
                    spark->GetMotionMaster()->MoveFollow(tgt, 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
            }
        }

        me->SetVisible(false);
        me->SetControlled(true, UNIT_STATE_STUNNED);

        events.SetPhase(2);
        events.ScheduleEvent(EVENT_CALL_SPARKS, 20s, 0, 2);
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
                DoCastRandomTarget(SPELL_BALL_LIGHTNING, 1, 0.0f, false);
                events.Repeat(8s, 18s);
                break;
            case EVENT_STATIC_OVERLOAD:
                DoCastRandomTarget(SPELL_STATIC_OVERLOAD);
                events.Repeat(9s, 14s);
                break;
            case EVENT_CALL_SPARKS:
                {
                    EntryCheckPredicate pred(NPC_SPARK_OF_IONAR);
                    summons.DoAction(ACTION_CALLBACK, pred);
                    events.ScheduleEvent(EVENT_RESTORE, 5s, 0, 2);
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

struct npc_spark_of_ionar : public ScriptedAI
{
    npc_spark_of_ionar(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit*) override { }
    void AttackStart(Unit*  /*who*/) override { }

    void Reset() override
    {
        returning = false;
        _events.ScheduleEvent(EVENT_CHANGE_TARGET, 3s);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

    void UpdateAI(uint32 diff) override
    {
        if (returning)
            return;

        _events.Update(diff);

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_CHANGE_TARGET:
                    if (Player* tgt = SelectTargetFromPlayerList(100))
                    {
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MoveFollow(tgt, 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
                    }
                    _events.Repeat(3s);
                    break;
            }
        }
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_CALLBACK)
        {
            _events.Reset();
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
            me->DespawnOrUnsummon(1s);
        }
    }

    private:
        EventMap _events;
        bool returning;
};

// 52658, 59795 - Static Overload
class spell_ionar_static_overload : public AuraScript
{
    PrepareAuraScript(spell_ionar_static_overload);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_STATIC_OVERLOAD_KNOCK });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        if (Unit* target = GetTarget())
            if (target->GetMap() && !target->GetMap()->IsHeroic())
                target->CastSpell(target, SPELL_STATIC_OVERLOAD_KNOCK, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_ionar_static_overload::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_ionar()
{
    RegisterHallOfLightningCreatureAI(boss_ionar);
    RegisterHallOfLightningCreatureAI(npc_spark_of_ionar);
    RegisterSpellScript(spell_ionar_static_overload);
}
