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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "SpellAuraEffects.h"
#include "sunwell_plateau.h"

enum Quotes
{
    YELL_INTRO_SAC              = 0,
    YELL_SAC_DEAD               = 4,
    EMOTE_SHADOW_NOVA           = 5,
    YELL_ENRAGE                 = 6,
    YELL_SISTER_ALYTHESS_DEAD   = 7,
    YELL_SAC_KILL               = 8,
    YELL_SHADOW_NOVA            = 9,

    YELL_INTRO_ALY              = 0,
    EMOTE_CONFLAGRATION         = 4,
    YELL_ALY_KILL               = 5,
    YELL_ALY_DEAD               = 6,
    YELL_SISTER_SACROLASH_DEAD  = 7,
    YELL_CANFLAGRATION          = 8,
    YELL_BERSERK                = 9
};

enum Spells
{
    //Shared spells
    SPELL_ENRAGE                = 46587,
    SPELL_EMPOWER               = 45366,
    SPELL_DARK_FLAME            = 45345,

    //Lady Sacrolash spells
    SPELL_SHADOWFORM            = 45455,
    SPELL_DARK_TOUCHED          = 45347,
    SPELL_SHADOW_BLADES         = 45248,
    SPELL_SHADOW_NOVA           = 45329,
    SPELL_CONFOUNDING_BLOW      = 45256,

    //Grand Warlock Alythess spells
    SPELL_FIREFORM              = 45457,
    SPELL_FLAME_TOUCHED         = 45348,
    SPELL_PYROGENICS            = 45230,
    SPELL_CONFLAGRATION         = 45342,
    SPELL_FLAME_SEAR            = 46771,
    SPELL_BLAZE                 = 45235,
    SPELL_BLAZE_SUMMON          = 45236
};

enum Misc
{
    ACTION_SISTER_DIED          = 1,
    GROUP_SPECIAL_ABILITY       = 1
};

struct boss_sacrolash : public BossAI
{
    boss_sacrolash(Creature* creature) : BossAI(creature, DATA_EREDAR_TWINS), _isSisterDead(false) {}

    void Reset() override
    {
        DoCastSelf(SPELL_SHADOWFORM, true);
        _isSisterDead = false;
        BossAI::Reset();
        me->SetLootMode(0);

        if (Creature* alythess = instance->GetCreature(DATA_ALYTHESS))
            if (!alythess->IsAlive())
                alythess->Respawn(true);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_SISTER_DIED)
        {
            me->ResetLootMode();
            _isSisterDead = true;
            Talk(YELL_SISTER_ALYTHESS_DEAD);
            me->CastSpell(me, SPELL_EMPOWER, true);

            scheduler.CancelGroup(GROUP_SPECIAL_ABILITY);
            ScheduleTimedEvent(20s, [&] {
                Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 100.0f);
                if (!target)
                    target = me->GetVictim();
                me->CastSpell(target, SPELL_CONFLAGRATION, false);
            }, 30s, 35s);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        if (Creature* alythess = instance->GetCreature(DATA_ALYTHESS))
            if (alythess->IsAlive() && !alythess->IsInCombat())
                alythess->AI()->AttackStart(who);

        ScheduleEnrageTimer(SPELL_ENRAGE, 6min, YELL_BERSERK);

        ScheduleTimedEvent(10s, [&] {
            DoCastSelf(SPELL_SHADOW_BLADES);
        }, 10s);

        ScheduleTimedEvent(25s, [&] {
            DoCastVictim(SPELL_CONFOUNDING_BLOW);
        }, 20s, 25s);

        ScheduleTimedEvent(20s, [&] {
            me->SummonCreature(NPC_SHADOW_IMAGE, me->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 12000);
        }, 6s);

        scheduler.Schedule(36s, GROUP_SPECIAL_ABILITY, [this](TaskContext context) {
            Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 100.0f);
            if (!target)
                target = me->GetVictim();
            Talk(EMOTE_SHADOW_NOVA, target);
            Talk(YELL_SHADOW_NOVA);
            DoCast(target, SPELL_SHADOW_NOVA);
            context.Repeat(30s, 35s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && urand(0, 1))
            Talk(YELL_SAC_KILL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        summons.DespawnAll();

        if (_isSisterDead)
        {
            Talk(YELL_SAC_DEAD);
            instance->SetBossState(DATA_EREDAR_TWINS, DONE);
        }
        else if (Creature* alythess = instance->GetCreature(DATA_ALYTHESS))
            alythess->AI()->DoAction(ACTION_SISTER_DIED);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
        {
            summon->AI()->AttackStart(target);
            summon->AddThreat(target, 10000000);
        }
    }

    private:
        bool _isSisterDead;
};

struct boss_alythess : public BossAI
{
    boss_alythess(Creature* creature) : BossAI(creature, DATA_EREDAR_TWINS), _isSisterDead(false) { }

    void Reset() override
    {
        DoCastSelf(SPELL_FIREFORM, true);
        _isSisterDead = false;
        BossAI::Reset();
        me->SetLootMode(0);

        if (Creature* sacrolash = instance->GetCreature(DATA_SACROLASH))
            if (!sacrolash->IsAlive())
                sacrolash->Respawn(true);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_SISTER_DIED)
        {
            me->ResetLootMode();
            _isSisterDead = true;
            Talk(YELL_SISTER_SACROLASH_DEAD);
            me->CastSpell(me, SPELL_EMPOWER, true);

            scheduler.CancelGroup(GROUP_SPECIAL_ABILITY);
            ScheduleTimedEvent(20s, [&] {
                Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 100.0f);
                if (!target)
                    target = me->GetVictim();
                DoCast(target, SPELL_SHADOW_NOVA);
            }, 30s, 35s);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        if (Creature* sacrolash = instance->GetCreature(DATA_SACROLASH))
            if (sacrolash->IsAlive() && !sacrolash->IsInCombat())
                sacrolash->AI()->AttackStart(who);

        ScheduleEnrageTimer(SPELL_ENRAGE, 6min, YELL_BERSERK);

        ScheduleTimedEvent(1s, [&] {
            DoCastVictim(SPELL_BLAZE);
        }, 3800ms);

        ScheduleTimedEvent(15s, [&] {
            DoCastSelf(SPELL_PYROGENICS);
        }, 15s);

        ScheduleTimedEvent(20s, [&] {
            me->CastCustomSpell(SPELL_FLAME_SEAR, SPELLVALUE_MAX_TARGETS, 5, me, TRIGGERED_NONE);
        }, 15s);

        scheduler.Schedule(20s, GROUP_SPECIAL_ABILITY, [this](TaskContext context) {
            Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 100.0f);
            if (!target)
                target = me->GetVictim();
            Talk(EMOTE_CONFLAGRATION, target);
            Talk(YELL_CANFLAGRATION);
            DoCast(target, SPELL_CONFLAGRATION);
            context.Repeat(30s, 35s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && urand(0, 1))
            Talk(YELL_SAC_KILL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        summons.DespawnAll();

        if (_isSisterDead)
        {
            Talk(YELL_SAC_DEAD);
            instance->SetBossState(DATA_EREDAR_TWINS, DONE);
        }
        else if (Creature* sacrolash = instance->GetCreature(DATA_SACROLASH))
            sacrolash->AI()->DoAction(ACTION_SISTER_DIED);
    }

    private:
        bool _isSisterDead;
};

class spell_eredar_twins_apply_touch : public SpellScript
{
    PrepareSpellScript(spell_eredar_twins_apply_touch);

public:
    spell_eredar_twins_apply_touch(uint32 touchSpell) : SpellScript(), _touchSpell(touchSpell) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _touchSpell });
    }

    void HandleApplyTouch()
    {
        if (Player* target = GetHitPlayer())
            target->CastSpell(target, _touchSpell, true);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_eredar_twins_apply_touch::HandleApplyTouch);
    }

private:
    uint32 _touchSpell;
};

class spell_eredar_twins_handle_touch : public SpellScript
{
    PrepareSpellScript(spell_eredar_twins_handle_touch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DARK_FLAME, SPELL_FLAME_TOUCHED, SPELL_DARK_TOUCHED });
    }

    SpellCastResult CheckCast()
    {
        if (GetCaster()->HasAura(SPELL_DARK_FLAME))
            return SPELL_FAILED_DONT_REPORT;

        if (GetSpellInfo()->Id == SPELL_DARK_TOUCHED)
        {
            if (GetCaster()->HasAura(SPELL_FLAME_TOUCHED))
            {
                GetCaster()->RemoveAurasDueToSpell(SPELL_FLAME_TOUCHED);
                GetCaster()->CastSpell(GetCaster(), SPELL_DARK_FLAME, true);
                return SPELL_FAILED_DONT_REPORT;
            }
        }
        else // if (m_spellInfo->Id == SPELL_FLAME_TOUCHED)
        {
            if (GetCaster()->HasAura(SPELL_DARK_TOUCHED))
            {
                GetCaster()->RemoveAurasDueToSpell(SPELL_DARK_TOUCHED);
                GetCaster()->CastSpell(GetCaster(), SPELL_DARK_FLAME, true);
                return SPELL_FAILED_DONT_REPORT;
            }
        }
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_eredar_twins_handle_touch::CheckCast);
    }
};

class spell_eredar_twins_blaze : public SpellScript
{
    PrepareSpellScript(spell_eredar_twins_blaze);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLAZE_SUMMON });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_BLAZE_SUMMON, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_eredar_twins_blaze::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_eredar_twins_handle_touch_periodic : public AuraScript
{
    PrepareAuraScript(spell_eredar_twins_handle_touch_periodic);

public:
    spell_eredar_twins_handle_touch_periodic(uint32 touchSpell, uint8 effIndex, uint8 aura) : AuraScript(), _touchSpell(touchSpell), _effectIndex(effIndex), _aura(aura) {}

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _touchSpell });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetId() == SPELL_FLAME_SEAR)
        {
            uint32 tick = aurEff->GetTickNumber();
            if (tick % 2 != 0 || tick > 10)
                return;
        }

        if (Unit* owner = GetOwner()->ToUnit())
            owner->CastSpell(owner, _touchSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_eredar_twins_handle_touch_periodic::OnPeriodic, _effectIndex, _aura);
    }

private:
    uint32 _touchSpell;
    uint8 _effectIndex;
    uint8 _aura;
};

class at_sunwell_eredar_twins : public OnlyOnceAreaTriggerScript
{
public:
    at_sunwell_eredar_twins() : OnlyOnceAreaTriggerScript("at_sunwell_eredar_twins") {}

    bool _OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* creature = instance->GetCreature(DATA_SACROLASH))
                creature->AI()->Talk(YELL_INTRO_SAC);
            if (Creature* creature = instance->GetCreature(DATA_ALYTHESS))
                creature->AI()->Talk(YELL_INTRO_ALY);
        }

        return true;
    }
};

void AddSC_boss_eredar_twins()
{
    RegisterSunwellPlateauCreatureAI(boss_sacrolash);
    RegisterSunwellPlateauCreatureAI(boss_alythess);
    RegisterSpellScriptWithArgs(spell_eredar_twins_apply_touch, "spell_eredar_twins_apply_dark_touched", SPELL_DARK_TOUCHED);
    RegisterSpellScriptWithArgs(spell_eredar_twins_apply_touch, "spell_eredar_twins_apply_flame_touched", SPELL_FLAME_TOUCHED);
    RegisterSpellScript(spell_eredar_twins_handle_touch);
    RegisterSpellScript(spell_eredar_twins_blaze);
    RegisterSpellScriptWithArgs(spell_eredar_twins_handle_touch_periodic, "spell_eredar_twins_handle_dark_touched_periodic", SPELL_DARK_TOUCHED, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    RegisterSpellScriptWithArgs(spell_eredar_twins_handle_touch_periodic, "spell_eredar_twins_handle_flame_touched_periodic", SPELL_FLAME_TOUCHED, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    RegisterSpellScriptWithArgs(spell_eredar_twins_handle_touch_periodic, "spell_eredar_twins_handle_flame_touched_flame_sear", SPELL_FLAME_TOUCHED, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    new at_sunwell_eredar_twins();
}
