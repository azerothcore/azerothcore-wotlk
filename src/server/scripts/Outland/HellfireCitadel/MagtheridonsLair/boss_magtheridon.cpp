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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
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
    SPELL_SHADOW_GRASP_VISUAL   = 30166,
    SPELL_MIND_EXHAUSTION       = 44032,
    SPELL_QUAKE                 = 30657,
    SPELL_QUAKE_KNOCKBACK       = 30571,
    SPELL_COLLAPSE_DAMAGE       = 36449,
    SPELL_CAMERA_SHAKE          = 36455,
    SPELL_DEBRIS_VISUAL         = 30632,
    SPELL_DEBRIS_DAMAGE         = 30631
};

enum Groups
{
    GROUP_INTERRUPT_CHECK       = 0,
    GROUP_EARLY_RELEASE_CHECK   = 1
};

enum Actions
{
    ACTION_INCREASE_HELLFIRE_CHANNELER_DEATH_COUNT  = 1
};

class DealDebrisDamage : public BasicEvent
{
public:
    DealDebrisDamage(Creature& creature, ObjectGuid targetGUID) : _owner(creature), _targetGUID(targetGUID) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        if (Unit* target = ObjectAccessor::GetUnit(_owner, _targetGUID))
            target->CastSpell(target, SPELL_DEBRIS_DAMAGE, true, nullptr, nullptr, _owner.GetGUID());
        return true;
    }

private:
    Creature& _owner;
    ObjectGuid _targetGUID;
};

struct boss_magtheridon : public BossAI
{
    boss_magtheridon(Creature* creature) : BossAI(creature, TYPE_MAGTHERIDON)
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
        _recentlySpoken = false;
        _magReleased = false;
        _interruptScheduler.CancelAll();
        scheduler.Schedule(90s, [this](TaskContext context)
        {
            Talk(SAY_TAUNT);
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
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                    {
                        target->CastSpell(target, SPELL_DEBRIS_VISUAL, true, nullptr, nullptr, me->GetGUID());
                        me->m_Events.AddEvent(new DealDebrisDamage(*me, target->GetGUID()), me->m_Events.CalculateTime(5000));
                    }
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
        }).Schedule(40s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_QUAKE); //needs fixes with custom spell
            scheduler.Schedule(7s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_BLAST_NOVA);

                _interruptScheduler.Schedule(50ms, GROUP_INTERRUPT_CHECK, [this](TaskContext context)
                {
                    if (me->GetAuraCount(SPELL_SHADOW_GRASP_VISUAL) == 5)
                    {
                        Talk(SAY_BANISH);
                        me->InterruptNonMeleeSpells(true);
                        scheduler.CancelGroup(GROUP_INTERRUPT_CHECK);
                    }
                    else
                        context.Repeat(50ms);
                }).Schedule(12s, GROUP_INTERRUPT_CHECK, [this](TaskContext /*context*/)
                {
                    _interruptScheduler.CancelGroup(GROUP_INTERRUPT_CHECK);
                });
            });
            context.Repeat(53s, 56s);
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
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_EMOTE_BEGIN);

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

        if (_currentPhase != 1)
        {
            DoMeleeAttackIfReady();
        }
    }

private:
    bool _recentlySpoken;
    bool _magReleased;
    uint8 _currentPhase;
    uint8 _channelersKilled;
    TaskScheduler _interruptScheduler;
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

void AddSC_boss_magtheridon()
{
    RegisterMagtheridonsLairCreatureAI(boss_magtheridon);
    RegisterSpellScript(spell_magtheridon_blaze);
    RegisterSpellScript(spell_magtheridon_shadow_grasp);
    RegisterSpellScript(spell_magtheridon_quake);
}
