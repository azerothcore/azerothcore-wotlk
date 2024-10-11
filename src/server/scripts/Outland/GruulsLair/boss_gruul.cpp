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
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "gruuls_lair.h"
#include "SpellAuraEffects.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_SLAM                    = 1,
    SAY_SHATTER                 = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    EMOTE_GROW                  = 5
};

enum Spells
{
    SPELL_GROWTH                        = 36300,
    SPELL_CAVE_IN                       = 36240,
    SPELL_GROUND_SLAM                   = 33525,
    SPELL_REVERBERATION                 = 36297,
    SPELL_HURTFUL_STRIKE                = 33813,
    SPELL_SHATTER                       = 33654,
    SPELL_LOOK_AROUND                   = 33965,

    // Ground Slam spells
    SPELL_SUMMON_TRACTOR_BEAM_CREATOR   = 33496,
    SPELL_TRACTOR_BEAM_PULL             = 33497,
    SPELL_SUMMON_TRACTOR_BEAM_1         = 33495,
    SPELL_SUMMON_TRACTOR_BEAM_2         = 33514,
    SPELL_SUMMON_TRACTOR_BEAM_3         = 33515,
    SPELL_SUMMON_TRACTOR_BEAM_4         = 33516,
    SPELL_SUMMON_TRACTOR_BEAM_5         = 33517,
    SPELL_SUMMON_TRACTOR_BEAM_6         = 33518,
    SPELL_SUMMON_TRACTOR_BEAM_7         = 33519,
    SPELL_SUMMON_TRACTOR_BEAM_8         = 33520,

    SPELL_SHATTER_EFFECT                = 33671,
    SPELL_STONED                        = 33652,
};

struct boss_gruul : public BossAI
{
    boss_gruul(Creature* creature) : BossAI(creature, DATA_GRUUL) { }

    void Reset() override
    {
        _Reset();
        _recentlySpoken = false;
        _caveInTimer = 29000ms;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(30300ms, [this](TaskContext context)
        {
            Talk(EMOTE_GROW);
            DoCastSelf(SPELL_GROWTH);
            context.Repeat(30300ms);
        }).Schedule(_caveInTimer, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_CAVE_IN);
            if (_caveInTimer > 4000ms)
            {
                _caveInTimer = _caveInTimer - 1500ms;
            }
            context.Repeat(_caveInTimer);
        }).Schedule(39900ms, 55700ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_REVERBERATION);
            context.Repeat(39900ms, 55700ms);
        }).Schedule(5600ms, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 5.0f))
            {
                DoCast(target, SPELL_HURTFUL_STRIKE);
            }
            else
            {
                DoCastVictim(SPELL_HURTFUL_STRIKE);
            }
            context.Repeat(8400ms);
        }).Schedule(35s, [this](TaskContext context)
        {
            Talk(SAY_SLAM);
            DoCastSelf(SPELL_GROUND_SLAM);
            scheduler.DelayAll(9701ms);
            scheduler.Schedule(9700ms, [this](TaskContext)
            {
                Talk(SAY_SHATTER);
                me->RemoveAurasDueToSpell(SPELL_LOOK_AROUND);
                DoCastSelf(SPELL_SHATTER);
            });
            context.Repeat(60s);
        });
    }

    void KilledUnit(Unit* /*who*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;
        }

        scheduler.Schedule(5s, [this](TaskContext)
        {
            _recentlySpoken = false;
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (!me->HasUnitState(UNIT_STATE_ROOT))
        {
            DoMeleeAttackIfReady();
        }
    }

private:
    std::chrono::milliseconds _caveInTimer;
    bool _recentlySpoken;
};

struct npc_invisible_tractor_beam_source : public NullCreatureAI
{
    npc_invisible_tractor_beam_source(Creature* creature) : NullCreatureAI(creature) { }

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (Unit* summonerUnit = summoner->ToUnit())
        {
            DoCast(summonerUnit, SPELL_TRACTOR_BEAM_PULL, true);
        }
    }
};

class spell_gruul_ground_slam : public SpellScript
{
    PrepareSpellScript(spell_gruul_ground_slam);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_TRACTOR_BEAM_CREATOR });
    }

    void ApplyStun()
    {
        if (Unit* caster = GetCaster())
        {
            caster->CastSpell(caster, SPELL_LOOK_AROUND, true);
        }
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SUMMON_TRACTOR_BEAM_CREATOR, true);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_gruul_ground_slam::ApplyStun);
        OnEffectHitTarget += SpellEffectFn(spell_gruul_ground_slam::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_tractor_beam_creator : public SpellScript
{
    PrepareSpellScript(spell_tractor_beam_creator);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            std::vector<uint32> tractorBeamSummons = { SPELL_SUMMON_TRACTOR_BEAM_1, SPELL_SUMMON_TRACTOR_BEAM_2, SPELL_SUMMON_TRACTOR_BEAM_3, SPELL_SUMMON_TRACTOR_BEAM_4,
                SPELL_SUMMON_TRACTOR_BEAM_5, SPELL_SUMMON_TRACTOR_BEAM_6, SPELL_SUMMON_TRACTOR_BEAM_7, SPELL_SUMMON_TRACTOR_BEAM_8 };
            uint32 randomTractorSpellID = Acore::Containers::SelectRandomContainerElement(tractorBeamSummons);
            caster->CastSpell(caster, randomTractorSpellID, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_tractor_beam_creator::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_gruul_ground_slam_trigger : public AuraScript
{
    PrepareAuraScript(spell_gruul_ground_slam_trigger);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_STONED });
    }

    void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetUnitOwner()->GetAuraCount(GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell) == 5)
        {
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_STONED, true);
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_gruul_ground_slam_trigger::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_gruul_shatter : public SpellScript
{
    PrepareSpellScript(spell_gruul_shatter);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHATTER_EFFECT });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->RemoveAurasDueToSpell(SPELL_STONED);

            if (target->IsPlayer())
            {
                target->CastSpell((Unit*)nullptr, SPELL_SHATTER_EFFECT, true);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gruul_shatter::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_gruul_shatter_effect : public SpellScript
{
    PrepareSpellScript(spell_gruul_shatter_effect);

    void CalculateDamage()
    {
        if (!GetHitUnit())
        {
            return;
        }

        float radius = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster());
        if (!radius)
        {
            return;
        }

        float distance = GetCaster()->GetDistance2d(GetHitUnit());
        if (distance > 1.0f)
        {
            SetHitDamage(int32(GetHitDamage() * ((radius - distance) / radius)));
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_gruul_shatter_effect::CalculateDamage);
    }
};

void AddSC_boss_gruul()
{
    RegisterGruulsLairAI(boss_gruul);
    RegisterGruulsLairAI(npc_invisible_tractor_beam_source);

    RegisterSpellScript(spell_gruul_ground_slam);
    RegisterSpellScript(spell_tractor_beam_creator);
    RegisterSpellScript(spell_gruul_ground_slam_trigger);
    RegisterSpellScript(spell_gruul_shatter);
    RegisterSpellScript(spell_gruul_shatter_effect);
}
