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
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "vault_of_archavon.h"

enum Events
{
    // Koralon
    EVENT_BURNING_BREATH            = 1,
    EVENT_FLAME_CINDER              = 2,
    EVENT_METEOR_FISTS              = 3,
};

enum Spells
{
    SPELL_BURNING_FURY                          = 68168,
    SPELL_BURNING_BREATH                        = 66665, // handled by spell_difficulty

    SPELL_FLAMING_CINDER                        = 66681,
    SPELL_FLAMING_CINDER_DUMMY                  = 66690,
    SPELL_FLAMING_CINDER_MISSILE                = 66682, // trigger of missile handled by spell_difficulty

    SPELL_METEOR_FISTS                          = 66725, // handled by spell_difficulty
    SPELL_METEOR_FISTS_DAMAGE                   = 66765,
    SPELL_FW_METEOR_FISTS_DAMAGE                = 66809
};

class boss_koralon : public CreatureScript
{
public:
    boss_koralon() : CreatureScript("boss_koralon") { }

    struct boss_koralonAI : public ScriptedAI
    {
        boss_koralonAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint32 rotateTimer;

        void Reset() override
        {
            rotateTimer = 0;
            events.Reset();
            if (pInstance)
            {
                if (pInstance->GetData(DATA_STONED))
                {
                    if (Aura* aur = me->AddAura(SPELL_STONED_AURA, me))
                    {
                        aur->SetMaxDuration(60 * MINUTE * IN_MILLISECONDS);
                        aur->SetDuration(60 * MINUTE * IN_MILLISECONDS);
                    }
                }
                pInstance->SetData(EVENT_KORALON, NOT_STARTED);
            }
        }

        void AttackStart(Unit* who) override
        {
            if (me->HasAura(SPELL_STONED_AURA))
                return;

            ScriptedAI::AttackStart(who);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->CastSpell(me, SPELL_BURNING_FURY, true);

            events.ScheduleEvent(EVENT_BURNING_BREATH, 10s);
            events.ScheduleEvent(EVENT_METEOR_FISTS, 30s);
            events.ScheduleEvent(EVENT_FLAME_CINDER, 20s);

            if (pInstance)
                pInstance->SetData(EVENT_KORALON, IN_PROGRESS);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                pInstance->SetData(EVENT_KORALON, DONE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (rotateTimer)
            {
                me->SetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT, 0);
                rotateTimer += diff;
                if (rotateTimer >= 3000)
                {
                    if (!me->HasUnitMovementFlag(MOVEMENTFLAG_LEFT))
                    {
                        me->SetUnitMovementFlags(MOVEMENTFLAG_LEFT);
                        me->SendMovementFlagUpdate();
                        rotateTimer = 1;
                        return;
                    }
                    else
                    {
                        me->RemoveUnitMovementFlag(MOVEMENTFLAG_LEFT);
                        me->SendMovementFlagUpdate();
                        rotateTimer = 0;
                        return;
                    }
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BURNING_BREATH:
                    rotateTimer = 1500;
                    me->CastSpell(me, SPELL_BURNING_BREATH, false);
                    events.Repeat(45s);
                    break;
                case EVENT_METEOR_FISTS:
                    me->CastSpell(me, SPELL_METEOR_FISTS, true);
                    events.Repeat(45s);
                    break;
                case EVENT_FLAME_CINDER:
                    me->CastSpell(me, SPELL_FLAMING_CINDER, true);
                    events.Repeat(30s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetVaultOfArchavonAI<boss_koralonAI>(creature);
    }
};

class spell_voa_flaming_cinder : public SpellScriptLoader
{
public:
    spell_voa_flaming_cinder() : SpellScriptLoader("spell_voa_flaming_cinder") { }

    class spell_voa_flaming_cinder_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_voa_flaming_cinder_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
                GetCaster()->CastSpell(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), SPELL_FLAMING_CINDER_MISSILE, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_voa_flaming_cinder_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_voa_flaming_cinder_SpellScript();
    }
};

class spell_koralon_meteor_fists : public SpellScriptLoader
{
public:
    spell_koralon_meteor_fists() : SpellScriptLoader("spell_koralon_meteor_fists") { }

    class spell_koralon_meteor_fists_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_koralon_meteor_fists_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_METEOR_FISTS_DAMAGE });
        }

        void TriggerFists(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
        {
            PreventDefaultAction();
            GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_METEOR_FISTS_DAMAGE, true, nullptr, aurEff);
        }

        void Register() override
        {
            OnEffectProc += AuraEffectProcFn(spell_koralon_meteor_fists_AuraScript::TriggerFists, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_koralon_meteor_fists_AuraScript();
    }
};

class spell_flame_warder_meteor_fists : public SpellScriptLoader
{
public:
    spell_flame_warder_meteor_fists() : SpellScriptLoader("spell_flame_warder_meteor_fists") { }

    class spell_flame_warder_meteor_fists_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_flame_warder_meteor_fists_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_FW_METEOR_FISTS_DAMAGE });
        }

        void TriggerFists(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
        {
            PreventDefaultAction();
            GetTarget()->CastSpell(eventInfo.GetProcTarget(), SPELL_FW_METEOR_FISTS_DAMAGE, true, nullptr, aurEff);
        }

        void Register() override
        {
            OnEffectProc += AuraEffectProcFn(spell_flame_warder_meteor_fists_AuraScript::TriggerFists, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_flame_warder_meteor_fists_AuraScript();
    }
};

void AddSC_boss_koralon()
{
    new boss_koralon();
    new spell_voa_flaming_cinder();
    new spell_koralon_meteor_fists();
    new spell_flame_warder_meteor_fists();
}
