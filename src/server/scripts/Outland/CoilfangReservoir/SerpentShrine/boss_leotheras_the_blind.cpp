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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "serpent_shrine.h"

enum Talk
{
    SAY_AGGRO                           = 0,
    SAY_SWITCH_TO_DEMON                 = 1,
    SAY_INNER_DEMONS                    = 2,
    SAY_DEMON_SLAY                      = 3,
    SAY_NIGHTELF_SLAY                   = 4,
    SAY_FINAL_FORM                      = 5,
    SAY_DEATH                           = 6
};

enum Spells
{
    SPELL_DUAL_WIELD                    = 42459,
    SPELL_BANISH                        = 37546,
    SPELL_TAUNT                         = 37548,
    SPELL_BERSERK                       = 26662,
    SPELL_WHIRLWIND                     = 37640,
    SPELL_SUMMON_SHADOW_OF_LEOTHERAS    = 37781,

    // Demon Form
    SPELL_CHAOS_BLAST                   = 37674,
    SPELL_CHAOS_BLAST_TRIGGER           = 37675,
    SPELL_INSIDIOUS_WHISPER             = 37676,
    SPELL_METAMORPHOSIS                 = 37673,
    SPELL_SUMMON_INNER_DEMON            = 37735,
    SPELL_CONSUMING_MADNESS             = 37749,

    // Other
    SPELL_CLEAR_CONSUMING_MADNESS       = 37750,
    SPELL_SHADOW_BOLT                   = 39309
};

enum Misc
{
    MAX_CHANNELERS                      = 3,

    NPC_GREYHEART_SPELLBINDER           = 21806,
    NPC_SHADOW_OF_LEOTHERAS             = 21875,

    EVENT_SPELL_BERSERK                 = 1,
    EVENT_HEALTH_CHECK                  = 2,
    EVENT_SWITCH_TO_DEMON               = 3,
    EVENT_SPELL_WHIRLWIND               = 4,
    EVENT_KILL_TALK                     = 5,
    EVENT_SWITCH_TO_ELF                 = 6,
    EVENT_SPELL_INSIDIOUS_WHISPER       = 7,
    EVENT_SUMMON_DEMON                  = 8,
    EVENT_RESTORE_FIGHT                 = 9,

    EVENT_SPELL_SHADOW_BOLT             = 20
};

const Position channelersPos[MAX_CHANNELERS] =
{
    {367.11f, -421.48f, 29.52f, 5.0f},
    {380.11f, -435.48f, 29.52f, 2.5f},
    {362.11f, -437.48f, 29.52f, 0.9f}
};

class boss_leotheras_the_blind : public CreatureScript
{
public:
    boss_leotheras_the_blind() : CreatureScript("boss_leotheras_the_blind") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSerpentShrineAI<boss_leotheras_the_blindAI>(creature);
    }

    struct boss_leotheras_the_blindAI : public BossAI
    {
        boss_leotheras_the_blindAI(Creature* creature) : BossAI(creature, DATA_LEOTHERAS_THE_BLIND)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            me->CastSpell(me, SPELL_CLEAR_CONSUMING_MADNESS, true);
            me->CastSpell(me, SPELL_DUAL_WIELD, true);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            me->LoadEquipment(0, true);
            me->SetReactState(REACT_PASSIVE);
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            SummonChannelers();
        }

        void JustReachedHome() override
        {
            BossAI::JustReachedHome();
            SummonChannelers();
        }

        void SummonChannelers()
        {
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_BANISH, false);
            me->CastSpell(me, SPELL_BANISH, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_BANISH, true);

            summons.DespawnAll();
            for (uint8 i = 0; i < MAX_CHANNELERS; ++i)
                me->SummonCreature(NPC_GREYHEART_SPELLBINDER, channelersPos[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override { }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            me->SetInCombatWithZone();
            summons.Despawn(summon);
            if (summon->GetEntry() == NPC_GREYHEART_SPELLBINDER)
                if (!summons.HasEntry(NPC_GREYHEART_SPELLBINDER))
                {
                    me->RemoveAllAuras();
                    me->LoadEquipment();
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    Talk(SAY_AGGRO);

                    events.ScheduleEvent(EVENT_SPELL_BERSERK, 600000);
                    events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                    events.ScheduleEvent(EVENT_SWITCH_TO_DEMON, 55000);
                    events.ScheduleEvent(EVENT_SPELL_WHIRLWIND, 10000);
                }
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(me->GetDisplayId() != me->GetNativeDisplayId() ? SAY_DEMON_SLAY : SAY_NIGHTELF_SLAY);
                events.ScheduleEvent(EVENT_KILL_TALK, 6000);
            }
        }

        void JustDied(Unit* killer) override
        {
            me->CastSpell(me, SPELL_CLEAR_CONSUMING_MADNESS, true);
            Talk(SAY_DEATH);
            BossAI::JustDied(killer);
        }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
        }

        void AttackStart(Unit* who) override
        {
            if (who && me->Attack(who, true))
                me->GetMotionMaster()->MoveChase(who, me->GetDisplayId() == me->GetNativeDisplayId() ? 0.0f : 25.0f);
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
                case EVENT_SPELL_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_HEALTH_CHECK:
                    if (me->HealthBelowPct(15))
                    {
                        if (me->GetDisplayId() != me->GetNativeDisplayId())
                        {
                            DoResetThreat();
                            me->LoadEquipment();
                            me->RemoveAurasDueToSpell(SPELL_METAMORPHOSIS);
                            events.ScheduleEvent(EVENT_SPELL_WHIRLWIND, 10000);
                        }
                        events.CancelEvent(EVENT_SWITCH_TO_DEMON);
                        events.CancelEvent(EVENT_SPELL_INSIDIOUS_WHISPER);
                        events.DelayEvents(10000);
                        events.ScheduleEvent(EVENT_SUMMON_DEMON, 4000);
                        events.ScheduleEvent(EVENT_RESTORE_FIGHT, 6000);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->SetReactState(REACT_PASSIVE);
                        me->GetMotionMaster()->Clear();
                        me->StopMoving();
                        Talk(SAY_FINAL_FORM);
                        break;
                    }
                    events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                    break;
                case EVENT_SWITCH_TO_DEMON:
                    DoResetThreat();
                    Talk(SAY_SWITCH_TO_DEMON);
                    me->LoadEquipment(0, true);
                    me->GetMotionMaster()->MoveChase(me->GetVictim(), 25.0f);
                    me->CastSpell(me, SPELL_METAMORPHOSIS, true);

                    events.CancelEvent(EVENT_SPELL_WHIRLWIND);
                    events.ScheduleEvent(EVENT_SPELL_INSIDIOUS_WHISPER, 25000);
                    events.ScheduleEvent(EVENT_SWITCH_TO_ELF, 60000);
                    break;
                case EVENT_SWITCH_TO_ELF:
                    DoResetThreat();
                    me->LoadEquipment();
                    me->GetMotionMaster()->MoveChase(me->GetVictim(), 0.0f);
                    me->RemoveAurasDueToSpell(SPELL_METAMORPHOSIS);
                    events.ScheduleEvent(EVENT_SWITCH_TO_DEMON, 55000);
                    events.ScheduleEvent(EVENT_SPELL_WHIRLWIND, 10000);
                    break;
                case EVENT_SPELL_WHIRLWIND:
                    me->CastSpell(me, SPELL_WHIRLWIND, false);
                    events.ScheduleEvent(EVENT_SPELL_WHIRLWIND, 27000);
                    break;
                case EVENT_SPELL_INSIDIOUS_WHISPER:
                    Talk(SAY_INNER_DEMONS);
                    me->CastCustomSpell(SPELL_INSIDIOUS_WHISPER, SPELLVALUE_MAX_TARGETS, 5, me, false);
                    break;
                case EVENT_SUMMON_DEMON:
                    me->CastSpell(me, SPELL_SUMMON_SHADOW_OF_LEOTHERAS, true);
                    break;
                case EVENT_RESTORE_FIGHT:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    break;
            }

            if (me->GetDisplayId() == me->GetNativeDisplayId())
                DoMeleeAttackIfReady();
            else if (me->isAttackReady(BASE_ATTACK))
            {
                me->CastSpell(me->GetVictim(), SPELL_CHAOS_BLAST, false);
                me->setAttackTimer(BASE_ATTACK, 2000);
            }
        }
    };
};

class npc_inner_demon : public CreatureScript
{
public:
    npc_inner_demon() : CreatureScript("npc_inner_demon") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSerpentShrineAI<npc_inner_demonAI>(creature);
    }

    struct npc_inner_demonAI : public ScriptedAI
    {
        npc_inner_demonAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        ObjectGuid ownerGUID;
        EventMap events;

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->DespawnOrUnsummon(1);
        }

        void IsSummonedBy(Unit* summoner) override
        {
            if (!summoner)
                return;

            ownerGUID = summoner->GetGUID();
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 4000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Unit* unit = ObjectAccessor::GetUnit(*me, ownerGUID))
                unit->RemoveAurasDueToSpell(SPELL_INSIDIOUS_WHISPER);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!who || who->GetGUID() != ownerGUID)
                damage = 0;
        }

        bool CanAIAttack(Unit const* who) const override
        {
            return who->GetGUID() == ownerGUID;
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
                case EVENT_SPELL_SHADOW_BOLT:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 6000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_leotheras_whirlwind : public SpellScriptLoader
{
public:
    spell_leotheras_whirlwind() : SpellScriptLoader("spell_leotheras_whirlwind") { }

    class spell_leotheras_whirlwind_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_leotheras_whirlwind_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            GetCaster()->GetThreatMgr().resetAllAggro();

            if (roll_chance_i(33))
                if (Unit* target = GetCaster()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                    target->CastSpell(GetCaster(), SPELL_TAUNT, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_leotheras_whirlwind_SpellScript::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_leotheras_whirlwind_SpellScript();
    }
};

class spell_leotheras_chaos_blast : public SpellScriptLoader
{
public:
    spell_leotheras_chaos_blast() : SpellScriptLoader("spell_leotheras_chaos_blast") { }

    class spell_leotheras_chaos_blast_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_leotheras_chaos_blast_SpellScript);

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
                GetCaster()->CastSpell(target, SPELL_CHAOS_BLAST_TRIGGER, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_leotheras_chaos_blast_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_leotheras_chaos_blast_SpellScript();
    }
};

class spell_leotheras_insidious_whisper : public SpellScriptLoader
{
public:
    spell_leotheras_insidious_whisper() : SpellScriptLoader("spell_leotheras_insidious_whisper") { }

    class spell_leotheras_insidious_whisper_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_leotheras_insidious_whisper_SpellScript);

        void FilterTargets(std::list<WorldObject*>& unitList)
        {
            if (Unit* victim = GetCaster()->GetVictim())
                unitList.remove_if(Acore::ObjectGUIDCheck(victim->GetGUID(), true));
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_leotheras_insidious_whisper_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_leotheras_insidious_whisper_SpellScript();
    }

    class spell_leotheras_insidious_whisper_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_leotheras_insidious_whisper_AuraScript)

        void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_INNER_DEMON, true);
        }

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEFAULT)
                if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
                    if (Creature* leotheras = ObjectAccessor::GetCreature(*GetUnitOwner(), instance->GetGuidData(NPC_LEOTHERAS_THE_BLIND)))
                        leotheras->CastSpell(GetUnitOwner(), SPELL_CONSUMING_MADNESS, true);
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_leotheras_insidious_whisper_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_leotheras_insidious_whisper_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_leotheras_insidious_whisper_AuraScript();
    }
};

class spell_leotheras_demon_link : public SpellScriptLoader
{
public:
    spell_leotheras_demon_link() : SpellScriptLoader("spell_leotheras_demon_link") { }

    class spell_leotheras_demon_link_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_leotheras_demon_link_AuraScript);

        void OnPeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            if (Unit* victim = GetUnitOwner()->GetVictim())
                GetUnitOwner()->CastSpell(victim, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_leotheras_demon_link_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_leotheras_demon_link_AuraScript();
    }
};

class spell_leotheras_clear_consuming_madness : public SpellScriptLoader
{
public:
    spell_leotheras_clear_consuming_madness() : SpellScriptLoader("spell_leotheras_clear_consuming_madness") { }

    class spell_leotheras_clear_consuming_madness_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_leotheras_clear_consuming_madness_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
                Unit::Kill(GetCaster(), target);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_leotheras_clear_consuming_madness_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_leotheras_clear_consuming_madness_SpellScript();
    }
};

void AddSC_boss_leotheras_the_blind()
{
    new boss_leotheras_the_blind();
    new npc_inner_demon();
    new spell_leotheras_whirlwind();
    new spell_leotheras_chaos_blast();
    new spell_leotheras_insidious_whisper();
    new spell_leotheras_demon_link();
    new spell_leotheras_clear_consuming_madness();
}
