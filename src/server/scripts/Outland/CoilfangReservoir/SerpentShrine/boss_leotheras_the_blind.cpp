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

#include "CreatureGroups.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "serpent_shrine.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

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
    NPC_SHADOW_OF_LEOTHERAS             = 21875,
    NPC_GREYHEART_SPELLBINDER           = 21806,

    ACTION_CHECK_SPELLBINDERS           = 1
};

enum Groups
{
    GROUP_COMBAT                        = 1,
    GROUP_DEMON                         = 2
};

struct boss_leotheras_the_blind : public BossAI
{
    boss_leotheras_the_blind(Creature* creature) : BossAI(creature, DATA_LEOTHERAS_THE_BLIND) { }

    void Reset() override
    {
        BossAI::Reset();
        DoCastSelf(SPELL_CLEAR_CONSUMING_MADNESS, true);
        DoCastSelf(SPELL_DUAL_WIELD, true);
        me->SetReactState(REACT_PASSIVE);
        _recentlySpoken = false;

        ScheduleHealthCheckEvent(15, [&]{
            me->RemoveAurasDueToSpell(SPELL_WHIRLWIND);

            if (me->GetDisplayId() != me->GetNativeDisplayId())
            {
                //is currently in metamorphosis
                me->LoadEquipment();
                me->RemoveAurasDueToSpell(SPELL_METAMORPHOSIS);
                scheduler.RescheduleGroup(GROUP_COMBAT, 10s);
            }

            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->ClearTarget();
            me->SendMeleeAttackStop();
            scheduler.CancelGroup(GROUP_DEMON);
            scheduler.DelayAll(10s);

            me->SetReactState(REACT_PASSIVE);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            me->GetMotionMaster()->Clear();
            me->StopMoving();
            Talk(SAY_FINAL_FORM);

            scheduler.Schedule(4s, [this](TaskContext)
            {
                DoCastSelf(SPELL_SUMMON_SHADOW_OF_LEOTHERAS);
            }).Schedule(6s, [this](TaskContext)
            {
                DoResetThreatList();
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->SetReactState(REACT_AGGRESSIVE);
                me->ResumeChasingVictim();

                if (me->GetVictim())
                {
                    me->SetTarget(me->GetVictim()->GetGUID());
                    me->SendMeleeAttackStart(me->GetVictim());
                }
            });
        });
    }

    void AttackStart(Unit* who) override
    {
        if (me->HasAura(SPELL_METAMORPHOSIS))
            AttackStartCaster(who, 40.0f);
        else
            ScriptedAI::AttackStart(who);
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_CHECK_SPELLBINDERS)
        {
            if (CreatureGroup* formation = me->GetFormation())
            {
                if (!formation->IsAnyMemberAlive(true))
                {
                    me->RemoveAllAuras();
                    me->LoadEquipment();
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetInCombatWithZone();
                    Talk(SAY_AGGRO);

                    scheduler.Schedule(10min, [this](TaskContext)
                    {
                        DoCastSelf(SPELL_BERSERK);
                    });

                    ElfTime();
                }
            }
        }
    }

    void ElfTime()
    {
        DoResetThreatList();
        me->InterruptNonMeleeSpells(false);
        scheduler.Schedule(25050ms, 32550ms, GROUP_COMBAT, [this](TaskContext context)
        {
            DoCastSelf(SPELL_WHIRLWIND);
            context.Repeat(30250ms, 34900ms);
        }).Schedule(60350ms, GROUP_DEMON, [this](TaskContext)
        {
            DoResetThreatList();
            Talk(SAY_SWITCH_TO_DEMON);
            DemonTime();
        });
    }

    void MoveToTargetIfOutOfRange(Unit* target)
    {
        if (!me->IsWithinDistInMap(target, 40.0f))
        {
            me->GetMotionMaster()->MoveChase(target, 40.0f, 0);
            me->AddThreat(target, 0.0f);
        }
        else
            me->GetMotionMaster()->Clear();
    }

    void DemonTime()
    {
        DoResetThreatList();
        me->RemoveAurasDueToSpell(SPELL_WHIRLWIND);
        me->InterruptNonMeleeSpells(false);
        me->LoadEquipment(0, true);
        DoCastSelf(SPELL_METAMORPHOSIS, true);

        scheduler.CancelGroup(GROUP_COMBAT);
        scheduler.Schedule(1s, GROUP_DEMON, [this](TaskContext context)
        {
            MoveToTargetIfOutOfRange(me->GetVictim());
            context.Repeat(1s);
        }).Schedule(24250ms, GROUP_DEMON, [this](TaskContext)
        {
            Talk(SAY_INNER_DEMONS);
            me->CastCustomSpell(SPELL_INSIDIOUS_WHISPER, SPELLVALUE_MAX_TARGETS, 5, me, false);
        }).Schedule(60s, [this](TaskContext)
        {
            DoResetThreatList();
            me->LoadEquipment();
            me->ResumeChasingVictim();
            me->RemoveAurasDueToSpell(SPELL_METAMORPHOSIS);
            scheduler.CancelGroup(GROUP_DEMON);
            ElfTime();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (me->GetDisplayId() == me->GetNativeDisplayId())
        {
            if (me->GetReactState() != REACT_PASSIVE)
                DoMeleeAttackIfReady();
        }
        else if (me->isAttackReady(BASE_ATTACK))
        {
            if (DoCastVictim(SPELL_CHAOS_BLAST) != SPELL_CAST_OK)
            {
                // Auto-attacks if there are no valid targets to cast his spell on f.e pet taunted.
                DoMeleeAttackIfReady();
            }
            else
                me->setAttackTimer(BASE_ATTACK, 2000);
        }
    }
private:
    bool _recentlySpoken;
};

struct npc_inner_demon : public ScriptedAI
{
    npc_inner_demon(Creature* creature) : ScriptedAI(creature)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (!summoner)
            return;

        scheduler.CancelAll();
        scheduler.Schedule(4s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SHADOW_BOLT);
            context.Repeat(6s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Unit* affectedPlayer = ObjectAccessor::GetUnit(*me, me->GetSummonerGUID()))
        {
            affectedPlayer->RemoveAurasDueToSpell(SPELL_INSIDIOUS_WHISPER);
        }
    }

    bool CanBeSeen(Player const* player) override
    {
        return player && player->GetGUID() == me->GetSummonerGUID();
    }

    bool CanReceiveDamage(Unit* attacker)
    {
        return attacker && attacker->GetGUID() == me->GetSummonerGUID();
    }

    void OnCalculateMeleeDamageReceived(uint32& damage, Unit* attacker) override
    {
        if (!CanReceiveDamage(attacker))
        {
            damage = 0;
        }
    }

    void OnCalculateSpellDamageReceived(int32& damage, Unit* attacker) override
    {
        if (!CanReceiveDamage(attacker))
        {
            damage = 0;
        }
    }

    void OnCalculatePeriodicTickReceived(uint32& damage, Unit* attacker) override
    {
        if (!CanReceiveDamage(attacker))
        {
            damage = 0;
        }
    }

    bool CanAIAttack(Unit const* who) const override
    {
        return who->GetGUID() == me->GetSummonerGUID();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
};

class spell_leotheras_whirlwind : public SpellScript
{
    PrepareSpellScript(spell_leotheras_whirlwind);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->GetThreatMgr().ResetAllThreat();

        if (roll_chance_i(33))
            if (Unit* target = GetCaster()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                target->CastSpell(GetCaster(), SPELL_TAUNT, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_leotheras_whirlwind::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_leotheras_chaos_blast : public SpellScript
{
    PrepareSpellScript(spell_leotheras_chaos_blast);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_CHAOS_BLAST_TRIGGER, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_leotheras_chaos_blast::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_leotheras_insidious_whisper : public SpellScript
{
    PrepareSpellScript(spell_leotheras_insidious_whisper);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        if (Unit* victim = GetCaster()->GetVictim())
        {
            unitList.remove_if(Acore::ObjectGUIDCheck(victim->GetGUID(), true));
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_leotheras_insidious_whisper::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_leotheras_insidious_whisper_aura : public AuraScript
{
    PrepareAuraScript(spell_leotheras_insidious_whisper_aura);

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_INNER_DEMON, true);
    }

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEFAULT)
        {
            if (InstanceScript* instance = GetUnitOwner()->GetInstanceScript())
            {
                if (Creature* leotheras = instance->GetCreature(DATA_LEOTHERAS_THE_BLIND))
                {
                    leotheras->CastSpell(GetUnitOwner(), SPELL_CONSUMING_MADNESS, true);
                }
            }
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_leotheras_insidious_whisper_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_leotheras_insidious_whisper_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_leotheras_demon_link : public AuraScript
{
    PrepareAuraScript(spell_leotheras_demon_link);

    void OnPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* victim = GetUnitOwner()->GetVictim())
        {
            GetUnitOwner()->CastSpell(victim, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_leotheras_demon_link::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_leotheras_clear_consuming_madness : public SpellScript
{
    PrepareSpellScript(spell_leotheras_clear_consuming_madness);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            Unit::Kill(GetCaster(), target);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_leotheras_clear_consuming_madness::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_leotheras_the_blind()
{
    RegisterSerpentShrineAI(boss_leotheras_the_blind);
    RegisterSerpentShrineAI(npc_inner_demon);
    RegisterSpellScript(spell_leotheras_whirlwind);
    RegisterSpellScript(spell_leotheras_chaos_blast);
    RegisterSpellAndAuraScriptPair(spell_leotheras_insidious_whisper, spell_leotheras_insidious_whisper_aura);
    RegisterSpellScript(spell_leotheras_demon_link);
    RegisterSpellScript(spell_leotheras_clear_consuming_madness);
}
