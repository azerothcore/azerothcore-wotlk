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
#include "molten_core.h"

enum Emotes
{
    EMOTE_SERVICE                   = 0
};

enum Spells
{
    SPELL_INFERNO                   = 19695,
    SPELL_INFERNO_DUMMY_EFFECT      = 19698, // Server side spell which inflicts damage
    SPELL_IGNITE_MANA               = 19659,
    SPELL_LIVING_BOMB               = 20475,
    SPELL_ARMAGEDDON                = 20478,
};

enum Events
{
    EVENT_INFERNO                   = 1,
    EVENT_IGNITE_MANA,
    EVENT_LIVING_BOMB,
};

class boss_baron_geddon : public CreatureScript
{
public:
    boss_baron_geddon() : CreatureScript("boss_baron_geddon") { }

    struct boss_baron_geddonAI : public BossAI
    {
        boss_baron_geddonAI(Creature* creature) : BossAI(creature, DATA_GEDDON),
            armageddonCasted(false)
        {
        }

        void Reset() override
        {
            _Reset();
            armageddonCasted = false;
        }

        void JustEngagedWith(Unit* /*attacker*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_INFERNO, 13s, 15s);
            events.ScheduleEvent(EVENT_IGNITE_MANA, 7s, 19s);
            events.ScheduleEvent(EVENT_LIVING_BOMB, 11s, 16s);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            // If boss is below 2% hp - cast Armageddon
            if (!armageddonCasted && damage < me->GetHealth() && me->HealthBelowPctDamaged(2, damage))
            {
                me->RemoveAurasDueToSpell(SPELL_INFERNO);
                me->StopMoving();
                if (me->CastSpell(me, SPELL_ARMAGEDDON, TRIGGERED_FULL_MASK) == SPELL_CAST_OK)
                {
                    Talk(EMOTE_SERVICE);
                    armageddonCasted = true;
                }
            }
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_INFERNO:
                {
                    DoCastAOE(SPELL_INFERNO);
                    events.Repeat(21s, 26s);
                    break;
                }
                case EVENT_IGNITE_MANA:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true, -SPELL_IGNITE_MANA))
                    {
                        DoCast(target, SPELL_IGNITE_MANA);
                    }

                    events.Repeat(27s, 32s);
                    break;
                }
                case EVENT_LIVING_BOMB:
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        DoCast(target, SPELL_LIVING_BOMB);
                    }

                    events.Repeat(11s, 16s);
                    break;
                }
            }
        }

    private:
        bool armageddonCasted;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_baron_geddonAI>(creature);
    }
};

// 19695 Inferno
class spell_geddon_inferno_aura : public AuraScript
{
    PrepareAuraScript(spell_geddon_inferno_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_INFERNO_DUMMY_EFFECT });
    }

    void HandleAfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* pCreatureTarget = GetTarget()->ToCreature())
        {
            pCreatureTarget->SetReactState(REACT_PASSIVE);
            pCreatureTarget->AttackStop();
        }
    }

    void HandleAfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* pCreatureTarget = GetTarget()->ToCreature())
        {
            pCreatureTarget->SetReactState(REACT_AGGRESSIVE);
        }
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();

        if (Unit* caster = GetUnitOwner())
        {
            //The pulses come about 1 second apart and last for 10 seconds. Damage starts at 500 damage per pulse and increases by 500 every other pulse (500, 500, 1000, 1000, 1500, etc.). (Source: Wowwiki)
            int32 multiplier = 1;
            switch (aurEff->GetTickNumber())
            {
                case 3:
                case 4:
                    multiplier = 2;
                    break;
                case 5:
                case 6:
                    multiplier = 4;
                    break;
                case 7:
                    multiplier = 6;
                    break;
                case 8:
                    multiplier = 10;
                    break;
            }

            caster->CastCustomSpell(SPELL_INFERNO_DUMMY_EFFECT, SPELLVALUE_BASE_POINT0, 500 * multiplier, (Unit*)nullptr, TRIGGERED_NONE, nullptr, aurEff);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_geddon_inferno_aura::HandleAfterApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_geddon_inferno_aura::HandleAfterRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_geddon_inferno_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 20478 Armageddon
class spell_geddon_armageddon_aura : public AuraScript
{
    PrepareAuraScript(spell_geddon_armageddon_aura);

    void HandleAfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* pCreatureTarget = GetTarget()->ToCreature())
        {
            pCreatureTarget->SetReactState(REACT_PASSIVE);
            pCreatureTarget->AttackStop();
        }
    }

    void HandleAfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* pCreatureTarget = GetTarget()->ToCreature())
        {
            pCreatureTarget->SetReactState(REACT_AGGRESSIVE);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_geddon_armageddon_aura::HandleAfterApply, EFFECT_1, SPELL_AURA_MOD_PACIFY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_geddon_armageddon_aura::HandleAfterRemove, EFFECT_1, SPELL_AURA_MOD_PACIFY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_baron_geddon()
{
    new boss_baron_geddon();

    // Spells
    RegisterSpellScript(spell_geddon_inferno_aura);
    RegisterSpellScript(spell_geddon_armageddon_aura);
}
