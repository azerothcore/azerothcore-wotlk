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
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "magtheridons_lair.h"

enum Yells
{
    SAY_TAUNT                       = 0,
    SAY_FREE                        = 1,
    SAY_SLAY                        = 2,
    SAY_BANISH                      = 3,
    SAY_PHASE3                      = 4,
    SAY_DEATH                       = 5,
};

enum Emotes
{
    SAY_EMOTE_BEGIN                 = 6,
    SAY_EMOTE_NEARLY                = 7,
    SAY_EMOTE_FREE                  = 8,
    SAY_EMOTE_NOVA                  = 9
};

enum Spells
{
    SPELL_SHADOW_CAGE           = 30205,
    SPELL_BLAST_NOVA            = 30616,
    SPELL_CLEAVE                = 30619,
    SPELL_BLAZE                 = 30541,
    SPELL_BLAZE_SUMMON          = 30542,
    SPELL_BERSERK               = 27680,
    SPELL_SHADOW_GRASP          = 30410,
    SPELL_SHADOW_GRASP_VISUAL   = 30166,
    SPELL_SHADOW_CAGE_STUN      = 30168,
    SPELL_MIND_EXHAUSTION       = 44032,
    SPELL_QUAKE                 = 30657,
    SPELL_QUAKE_KNOCKBACK       = 30571,
    SPELL_COLLAPSE_DAMAGE       = 36449,
    SPELL_CAMERA_SHAKE          = 36455,
    SPELL_DEBRIS_TARGET         = 30629,
    SPELL_DEBRIS_SPAWN          = 30630,
    SPELL_DEBRIS_DAMAGE         = 30631,
    SPELL_DEBRIS_VISUAL         = 30632,
};

enum Groups
{
    GROUP_EARLY_RELEASE_CHECK   = 0
};

enum Actions
{
    ACTION_INCREASE_HELLFIRE_CHANNELER_DEATH_COUNT  = 1,
    ACTION_BANISH_SELF = 2
};

struct boss_magtheridon : public BossAI
{
    boss_magtheridon(Creature* creature) : BossAI(creature, DATA_MAGTHERIDON)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        _channelersKilled = 0;
        _currentPhase = 0;
        _castingQuake = false;
        _recentlySpoken = false;
        _magReleased = false;
        _interruptScheduler.CancelAll();
        scheduler.Schedule(90s, [this](TaskContext context)
        {
            if (!me->IsEngaged())
            {
                Talk(SAY_TAUNT);
            }
            context.Repeat(90s);
        });
        DoCastSelf(SPELL_SHADOW_CAGE, true);
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetImmuneToPC(true);

        ScheduleHealthCheckEvent(30, [&]
        {
            _currentPhase = 1;
            Talk(SAY_PHASE3);
            me->GetMotionMaster()->Clear();
            scheduler.DelayAll(18s);
            scheduler.Schedule(8s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_CAMERA_SHAKE, true);
                instance->SetData(DATA_COLLAPSE, GO_STATE_ACTIVE);
            }).Schedule(15s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_COLLAPSE_DAMAGE, true);
                me->resetAttackTimer();
                me->GetMotionMaster()->MoveChase(me->GetVictim());
                _currentPhase = 0;
                scheduler.Schedule(20s, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_DEBRIS_TARGET);
                    context.Repeat(20s);
                });
            });
        });
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;
        }

        scheduler.Schedule(5s, [this](TaskContext /*context*/)
        {
            _recentlySpoken = false;
        });
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void ScheduleCombatEvents()
    {
        DoResetThreatList();
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetImmuneToPC(false);
        me->SetReactState(REACT_AGGRESSIVE);
        instance->SetData(DATA_ACTIVATE_CUBES, 1);
        me->RemoveAurasDueToSpell(SPELL_SHADOW_CAGE);

        scheduler.Schedule(9s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(1200ms, 16300ms);
        }).Schedule(20s, [this](TaskContext context)
        {
            me->CastCustomSpell(SPELL_BLAZE, SPELLVALUE_MAX_TARGETS, 1);
            context.Repeat(11s, 39s);
        }).Schedule(28300ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_QUAKE);
            _castingQuake = true;
            me->GetMotionMaster()->Clear();
            me->SetReactState(REACT_PASSIVE);
            me->SetOrientation(me->GetAngle(me->GetVictim()));
            me->SetTarget(ObjectGuid::Empty);
            scheduler.DelayAll(6999ms);
            scheduler.Schedule(7s, [this](TaskContext)
            {
                _castingQuake = false;
                me->SetReactState(REACT_AGGRESSIVE);
                me->GetMotionMaster()->MoveChase(me->GetVictim());
            });
            context.Repeat(56300ms, 64300ms);
        }).Schedule(55650ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_BLAST_NOVA);
            scheduler.DelayAll(10s);
            context.Repeat(54350ms, 55400ms);
        }).Schedule(22min, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_BERSERK, true);
        });
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_INCREASE_HELLFIRE_CHANNELER_DEATH_COUNT)
        {
            _channelersKilled++;

            if (_channelersKilled >= 5 && !_magReleased)
            {
                Talk(SAY_EMOTE_FREE);
                Talk(SAY_FREE);
                scheduler.CancelGroup(GROUP_EARLY_RELEASE_CHECK); //cancel regular countdown
                _magReleased = true;
                scheduler.Schedule(3s, [this](TaskContext)
                {
                    ScheduleCombatEvents();
                });
            }
        }
        else if (action == ACTION_BANISH_SELF )
        {
            Talk(SAY_BANISH);
            me->CastSpell(me, SPELL_SHADOW_CAGE_STUN, true);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_EMOTE_BEGIN);

        instance->DoForAllMinions(DATA_MAGTHERIDON, [&](Creature* creature) {
            creature->SetInCombatWithZone();
        });

        scheduler.Schedule(60s, GROUP_EARLY_RELEASE_CHECK, [this](TaskContext /*context*/)
        {
            Talk(SAY_EMOTE_NEARLY);
        }).Schedule(120s, GROUP_EARLY_RELEASE_CHECK, [this](TaskContext /*context*/)
        {
            Talk(SAY_EMOTE_FREE);
            Talk(SAY_FREE);
            _magReleased = true;
        }).Schedule(123s, GROUP_EARLY_RELEASE_CHECK, [this](TaskContext /*context*/)
        {
            ScheduleCombatEvents();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        _interruptScheduler.Update(diff);

        if (_currentPhase != 1 && !_castingQuake)
        {
            DoMeleeAttackIfReady();
        }
    }

private:
    bool _castingQuake;
    bool _recentlySpoken;
    bool _magReleased;
    uint8 _currentPhase;
    uint8 _channelersKilled;
    TaskScheduler _interruptScheduler;
};

struct npc_target_trigger : public ScriptedAI
{
    npc_target_trigger(Creature* creature) : ScriptedAI(creature), _cast(false)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    void Reset() override
    {
        if (!_cast)
        {
            DoCastSelf(SPELL_DEBRIS_VISUAL);
            _cast = true;
            _scheduler.Schedule(5s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_DEBRIS_DAMAGE);
                me->DespawnOrUnsummon(6000);
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

protected:
    TaskScheduler _scheduler;
    bool _cast;
};

class spell_magtheridon_blaze : public SpellScript
{
    PrepareSpellScript(spell_magtheridon_blaze);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_BLAZE_SUMMON, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_magtheridon_blaze::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_magtheridon_shadow_grasp : public AuraScript
{
    PrepareAuraScript(spell_magtheridon_shadow_grasp);

    void HandleDummyApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell((Unit*)nullptr, SPELL_SHADOW_GRASP_VISUAL, false);
    }

    void HandleDummyRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->InterruptNonMeleeSpells(true);
    }

    void HandlePeriodicRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_MIND_EXHAUSTION, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_magtheridon_shadow_grasp::HandleDummyApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_magtheridon_shadow_grasp::HandleDummyRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_magtheridon_shadow_grasp::HandlePeriodicRemove, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_magtheridon_shadow_grasp_visual : public AuraScript
{
    PrepareAuraScript(spell_magtheridon_shadow_grasp_visual);

    void HandleDummyApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTarget()->GetAuraCount(SPELL_SHADOW_GRASP_VISUAL) == 5)
        {
            GetTarget()->GetAI()->DoAction(ACTION_BANISH_SELF);
        }
    }

    void HandleDummyRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_SHADOW_CAGE_STUN);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_magtheridon_shadow_grasp_visual::HandleDummyApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_magtheridon_shadow_grasp_visual::HandleDummyRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_magtheridon_quake : public SpellScript
{
    PrepareSpellScript(spell_magtheridon_quake);

    void HandleHit()
    {
        if (urand(0, 3) == 0)
            GetCaster()->CastSpell(GetCaster(), SPELL_QUAKE_KNOCKBACK, true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_magtheridon_quake::HandleHit);
    }
};

class spell_magtheridon_debris_target_selector : public SpellScript
{
    PrepareSpellScript(spell_magtheridon_debris_target_selector);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject* target) -> bool
            {
                return target->GetEntry() != NPC_TARGET_TRIGGER;
            });

        Acore::Containers::RandomResize(targets, 1);
    }

    void HandleHit()
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_DEBRIS_SPAWN);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_magtheridon_debris_target_selector::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnHit += SpellHitFn(spell_magtheridon_debris_target_selector::HandleHit);
    }
};

class go_manticron_cube : public GameObjectScript
{
public:
    go_manticron_cube() : GameObjectScript("go_manticron_cube") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (player->HasAura(SPELL_MIND_EXHAUSTION) || player->HasAura(SPELL_SHADOW_GRASP))
            return true;

        if (Creature* trigger = player->FindNearestCreature(NPC_HELLFIRE_RAID_TRIGGER, 10.0f))
            trigger->CastSpell(nullptr, SPELL_SHADOW_GRASP_VISUAL);

        player->CastSpell((Unit*)nullptr, SPELL_SHADOW_GRASP, true);
        return true;
    }
};

void AddSC_boss_magtheridon()
{
    RegisterMagtheridonsLairCreatureAI(boss_magtheridon);
    RegisterMagtheridonsLairCreatureAI(npc_target_trigger);
    RegisterSpellScript(spell_magtheridon_blaze);
    RegisterSpellScript(spell_magtheridon_shadow_grasp);
    RegisterSpellScript(spell_magtheridon_shadow_grasp_visual);
    RegisterSpellScript(spell_magtheridon_quake);
    RegisterSpellScript(spell_magtheridon_debris_target_selector);
    new go_manticron_cube();
}
