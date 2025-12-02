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
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Texts
{
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    SAY_SURPREME                = 2,
    SAY_KILL                    = 3,
    SAY_DEATH                   = 4,
    EMOTE_FRENZY                = 5,
    SAY_RAND                    = 6
};

enum Spells
{
    SPELL_SHADOW_VOLLEY         = 32963,
    SPELL_CLEAVE                = 31779,
    SPELL_THUNDERCLAP           = 36706,
    SPELL_VOID_BOLT             = 39329,
    SPELL_MARK_OF_KAZZAK        = 32960,
    SPELL_MARK_OF_KAZZAK_DAMAGE = 32961,
    SPELL_ENRAGE                = 32964,
    SPELL_CAPTURE_SOUL          = 32966,
    SPELL_TWISTED_REFLECTION    = 21063,
    SPELL_BERSERK               = 32965
};

class boss_doomlord_kazzak : public CreatureScript
{
public:
    boss_doomlord_kazzak() : CreatureScript("boss_doomlord_kazzak") { }

    struct boss_doomlordkazzakAI : public ScriptedAI
    {
        boss_doomlordkazzakAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override
        {
            scheduler.CancelAll();
            _inBerserk = false;
        }

        void JustRespawned() override
        {
            Talk(SAY_INTRO);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            scheduler.Schedule(6s, 10s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SHADOW_VOLLEY);
                context.Repeat(4s, 6s);
            }).Schedule(7s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_CLEAVE);
                context.Repeat(8s, 12s);
            }).Schedule(14s, 18s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_THUNDERCLAP);
                context.Repeat(10s, 14s);
            }).Schedule(30s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_VOID_BOLT);
                context.Repeat(15s, 18s);
            }).Schedule(25s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 100.0f, true)))
                {
                    DoCast(target, SPELL_MARK_OF_KAZZAK);
                }
                context.Repeat(20s);
            }).Schedule(1min, [this](TaskContext context)
            {
                Talk(EMOTE_FRENZY);
                DoCastSelf(SPELL_ENRAGE);
                context.Repeat(30s);
            }).Schedule(33s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                {
                    DoCast(target, SPELL_TWISTED_REFLECTION);
                }
                context.Repeat(15s);
            }).Schedule(3min, [this](TaskContext /*context*/)
            {
                if (!_inBerserk)
                {
                    DoCastSelf(SPELL_BERSERK);
                    _inBerserk = true;
                }
            });
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
            {
                Talk(SAY_KILL);
                DoCastSelf(SPELL_CAPTURE_SOUL);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            scheduler.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();
        }

    private:
        bool _inBerserk;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_doomlordkazzakAI (creature);
    }
};

class spell_mark_of_kazzak_aura : public AuraScript
{
    PrepareAuraScript(spell_mark_of_kazzak_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_MARK_OF_KAZZAK_DAMAGE });
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* owner = GetUnitOwner())
        {
            amount = CalculatePct(owner->GetPower(POWER_MANA), 5);
        }
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        Unit* target = GetTarget();
        if (target->GetPower(POWER_MANA) == 0)
        {
            target->CastSpell(target, SPELL_MARK_OF_KAZZAK_DAMAGE, true, nullptr, aurEff);
            SetDuration(0); // Remove aura
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mark_of_kazzak_aura::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_MANA_LEECH);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mark_of_kazzak_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_MANA_LEECH);
    }
};

void AddSC_boss_doomlordkazzak()
{
    new boss_doomlord_kazzak();
    RegisterSpellScript(spell_mark_of_kazzak_aura);
}
