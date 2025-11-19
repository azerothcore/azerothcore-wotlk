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
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "drak_tharon_keep.h"
#include "SpellScript.h"

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_KILL                        = 1,
    SAY_FLESH                       = 2,
    SAY_SKELETON                    = 3,
    SAY_DEATH                       = 4
};

enum Spells
{
    SPELL_CURSE_OF_LIFE                 = 49527,
    SPELL_SHADOW_VOLLEY                 = 49528,

    // flesh spells
    SPELL_EYE_BEAM                      = 49544,
    SPELL_LIGHTNING_BREATH              = 49537,
    SPELL_POISON_CLOUD                  = 49548,

    SPELL_TURN_FLESH                    = 49356,
    SPELL_TURN_BONES                    = 53463,
    SPELL_GIFT_OF_THARON_JA             = 52509,
    SPELL_DUMMY                         = 49551,
    SPELL_FLESH_VISUAL                  = 52582,
    SPELL_CLEAR_GIFT                    = 53242,

    SPELL_ACHIEVEMENT_CHECK             = 61863
};

enum Misc
{
    ACTION_TURN_BONES                   = 1,

    EVENT_SPELL_CURSE_OF_LIFE           = 1,
    EVENT_SPELL_SHADOW_VOLLEY           = 3,
    EVENT_SPELL_EYE_BEAM                = 4,
    EVENT_SPELL_LIGHTNING_BREATH        = 5,
    EVENT_SPELL_POISON_CLOUD            = 6,
    EVENT_TURN_FLESH_REAL               = 9,
    EVENT_TURN_BONES_REAL               = 10,
    EVENT_KILL_TALK                     = 11
};

class boss_tharon_ja : public CreatureScript
{
public:
    boss_tharon_ja() : CreatureScript("boss_tharon_ja") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetDraktharonKeepAI<boss_tharon_jaAI>(creature);
    }

    struct boss_tharon_jaAI : public BossAI
    {
        boss_tharon_jaAI(Creature* creature) : BossAI(creature, DATA_THARON_JA) { }

        void Reset() override
        {
            BossAI::Reset();
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
            me->SetDisplayId(me->GetNativeDisplayId());
            me->CastSpell(me, SPELL_CLEAR_GIFT, true);

            ScheduleHealthCheckEvent(55, [&] {
                Talk(SAY_FLESH);
                me->GetThreatMgr().ResetAllThreat();
                me->CastSpell((Unit*)nullptr, SPELL_TURN_FLESH, false);

                events.Reset();
                events.ScheduleEvent(EVENT_TURN_FLESH_REAL, 3s);
            }, false);
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_AGGRO);
            BossAI::JustEngagedWith(who);
            events.ScheduleEvent(EVENT_SPELL_CURSE_OF_LIFE, 13s, 24s);
            events.ScheduleEvent(EVENT_SPELL_SHADOW_VOLLEY, 6s, 29s);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (!events.HasTimeUntilEvent(EVENT_KILL_TALK))
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_TURN_BONES && me->IsAlive())
            {
                Talk(SAY_SKELETON);
                events.Reset();
                events.ScheduleEvent(EVENT_TURN_BONES_REAL, 3s);
            }
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DEATH);
            BossAI::JustDied(killer);
            me->CastSpell(me, SPELL_ACHIEVEMENT_CHECK, true);
            me->CastSpell(me, SPELL_CLEAR_GIFT, true);
            if (me->GetDisplayId() != me->GetNativeDisplayId())
            {
                me->SetDisplayId(me->GetNativeDisplayId());
                me->CastSpell(me, SPELL_FLESH_VISUAL, true);
            }
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
                case EVENT_SPELL_CURSE_OF_LIFE:
                    DoCastRandomTarget(SPELL_CURSE_OF_LIFE, 0, 30.0f, false);
                    events.ScheduleEvent(EVENT_SPELL_CURSE_OF_LIFE, 11s, 28s);
                    break;
                case EVENT_SPELL_SHADOW_VOLLEY:
                    DoCastAOE(SPELL_SHADOW_VOLLEY);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_VOLLEY, 6s, 29s);
                    break;
                case EVENT_TURN_FLESH_REAL:
                    DoCastSelf(SPELL_DUMMY, true);
                    me->ResumeChasingVictim();
                    events.ScheduleEvent(EVENT_SPELL_EYE_BEAM, 11s);
                    events.ScheduleEvent(EVENT_SPELL_LIGHTNING_BREATH, 3s);
                    events.ScheduleEvent(EVENT_SPELL_POISON_CLOUD, 6s);
                    break;
                case EVENT_SPELL_EYE_BEAM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 35.0f, true))
                        me->CastSpell(target, SPELL_EYE_BEAM, false);
                    break;
                case EVENT_SPELL_LIGHTNING_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_LIGHTNING_BREATH, false);
                    events.ScheduleEvent(EVENT_SPELL_LIGHTNING_BREATH, 8s);
                    break;
                case EVENT_SPELL_POISON_CLOUD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 35.0f, true))
                        me->CastSpell(target, SPELL_POISON_CLOUD, false);
                    events.ScheduleEvent(EVENT_SPELL_POISON_CLOUD, 10s);
                    break;
                case EVENT_TURN_BONES_REAL:
                    me->SetDisplayId(me->GetNativeDisplayId());
                    me->CastSpell(me, SPELL_FLESH_VISUAL, true);
                    me->CastSpell(me, SPELL_CLEAR_GIFT, true);
                    events.Reset();
                    events.ScheduleEvent(EVENT_SPELL_CURSE_OF_LIFE, 1s);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_VOLLEY, 8s, 10s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_tharon_ja_curse_of_life_aura : public AuraScript
{
    PrepareAuraScript(spell_tharon_ja_curse_of_life_aura);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (GetUnitOwner()->HealthBelowPct(50))
        {
            PreventDefaultAction();
            SetDuration(0);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_tharon_ja_curse_of_life_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_tharon_ja_dummy_aura : public AuraScript
{
    PrepareAuraScript(spell_tharon_ja_dummy_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLESH_VISUAL, SPELL_GIFT_OF_THARON_JA, SPELL_TURN_BONES });
    }

    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        PreventDefaultAction();
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FLESH_VISUAL, true);
        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_GIFT_OF_THARON_JA, true);
        GetUnitOwner()->SetDisplayId(GetUnitOwner()->GetNativeDisplayId() + 1);
    }

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        PreventDefaultAction();
        GetUnitOwner()->GetThreatMgr().ResetAllThreat();
        GetUnitOwner()->CastSpell((Unit*)nullptr, SPELL_TURN_BONES, false);
        GetUnitOwner()->GetAI()->DoAction(ACTION_TURN_BONES);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_tharon_ja_dummy_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_tharon_ja_dummy_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_tharon_ja_clear_gift_of_tharon_ja : public SpellScript
{
    PrepareSpellScript(spell_tharon_ja_clear_gift_of_tharon_ja);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->RemoveAura(SPELL_GIFT_OF_THARON_JA);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_tharon_ja_clear_gift_of_tharon_ja::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_tharon_ja()
{
    new boss_tharon_ja();
    RegisterSpellScript(spell_tharon_ja_curse_of_life_aura);
    RegisterSpellScript(spell_tharon_ja_dummy_aura);
    RegisterSpellScript(spell_tharon_ja_clear_gift_of_tharon_ja);
}
