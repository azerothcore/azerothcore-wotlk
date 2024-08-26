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
#include "SpellScriptLoader.h"
#include "black_temple.h"
#include "PassiveAI.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"

enum Says
{
    SAY_INTRO                       = 0,
    SAY_AGGRO                       = 1,
    SAY_SLAY                        = 2,
    SAY_BLOSSOM                     = 3,
    SAY_INCINERATE                  = 4,
    SAY_CRUSHING                    = 5,
    SAY_DEATH                       = 6
};

enum Spells
{
    SPELL_INCINERATE                = 40239,
    SPELL_SUMMON_DOOM_BLOSSOM       = 40188,
    SPELL_CRUSHING_SHADOWS          = 40243,
    SPELL_SHADOW_OF_DEATH           = 40251,
    SPELL_SHADOW_OF_DEATH_REMOVE    = 41999,
    SPELL_SUMMON_SPIRIT             = 40266,
    SPELL_SUMMON_SKELETON1          = 40270,
    SPELL_SUMMON_SKELETON2          = 41948,
    SPELL_SUMMON_SKELETON3          = 41949,
    SPELL_SUMMON_SKELETON4          = 41950,
    SPELL_POSSESS_SPIRIT_IMMUNE     = 40282,
    SPELL_SPIRITUAL_VENGEANCE       = 40268,
    SPELL_BRIEF_STUN                = 41421,
    SPELL_BERSERK                   = 45078,

    SPELL_SPIRIT_LANCE              = 40157,
    SPELL_SPIRIT_CHAINS             = 40175,
    SPELL_SPIRIT_VOLLEY             = 40314
};

enum Misc
{
    SET_DATA_INTRO                  = 1
};

struct ShadowOfDeathSelector
{
    bool operator()(Unit const* target) const
    {
        return target && !target->HasAura(SPELL_SHADOW_OF_DEATH) && !target->HasAura(SPELL_POSSESS_SPIRIT_IMMUNE);
    }
};

struct boss_teron_gorefiend : public BossAI
{
    boss_teron_gorefiend(Creature* creature) : BossAI(creature, DATA_TERON_GOREFIEND)
    {
        _recentlySpoken = false;
        _intro = false;
    }

    void Reset() override
    {
        BossAI::Reset();
        DoCastSelf(SPELL_SHADOW_OF_DEATH_REMOVE, true);
    }

    void JustEngagedWith(Unit* who) override
    {
        ScheduleTimedEvent(20s, 30s, [&]
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            {
                if (roll_chance_i(50))
                    Talk(SAY_INCINERATE);
                me->CastSpell(target, SPELL_INCINERATE, false);
            }
        }, 20s, 50s);

        ScheduleTimedEvent(5s, 10s, [&]
        {
            if (roll_chance_i(50))
                Talk(SAY_BLOSSOM);
            me->CastSpell(me, SPELL_SUMMON_DOOM_BLOSSOM, false);
        }, 35s);

        ScheduleTimedEvent(17s, 22s, [&]
        {
            if (roll_chance_i(20))
                Talk(SAY_CRUSHING);
            me->CastCustomSpell(SPELL_CRUSHING_SHADOWS, SPELLVALUE_MAX_TARGETS, 5, me, false);
        }, 10s, 26s);

        ScheduleTimedEvent(10s, [&]
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, ShadowOfDeathSelector()))
                me->CastSpell(target, SPELL_SHADOW_OF_DEATH, false);
        }, 30s, 50s);

        ScheduleTimedEvent(10min, [&]
        {
            DoCastSelf(SPELL_BERSERK);
        }, 5min);

        BossAI::JustEngagedWith(who);
    }

    void KilledUnit(Unit*  victim) override
    {
        if (!_recentlySpoken && victim->IsPlayer())
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;

            ScheduleUniqueTimedEvent(6s, [&]
            {
                _recentlySpoken = false;
            }, 1);
        }
    }

    void SetData(uint32 type, uint32 id) override
    {
        if (type || !me->IsAlive())
            return;

        if (id == SET_DATA_INTRO && !_intro)
        {
            _intro = true;
            Talk(SAY_INTRO);
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
        DoCastSelf(SPELL_SHADOW_OF_DEATH_REMOVE, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        DoMeleeAttackIfReady();
    }

    private:
        bool _recentlySpoken;
        bool _intro;
};

struct npc_vengeful_spirit : public NullCreatureAI
{
    npc_vengeful_spirit(Creature* creature) : NullCreatureAI(creature) { }

    void OnCharmed(bool apply)
    {
        if (!apply)
            me->DespawnOnEvade();
    }
};

class spell_teron_gorefiend_shadow_of_death : public AuraScript
{
    PrepareAuraScript(spell_teron_gorefiend_shadow_of_death);

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo&   /*dmgInfo*/, uint32&   /*absorbAmount*/)
    {
        PreventDefaultAction();
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        InstanceScript* instance = GetTarget()->GetInstanceScript();
        if (!GetCaster() || !instance || !instance->IsEncounterInProgress())
            return;

        GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SPIRIT, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_POSSESS_SPIRIT_IMMUNE, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_SPIRITUAL_VENGEANCE, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON1, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON2, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON3, true);
        GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_SKELETON4, true);
    }

    void Register() override
    {
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_teron_gorefiend_shadow_of_death::Absorb, EFFECT_0);
        AfterEffectRemove += AuraEffectRemoveFn(spell_teron_gorefiend_shadow_of_death::HandleEffectRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_teron_gorefiend_spirit_lance : public AuraScript
{
    PrepareAuraScript(spell_teron_gorefiend_spirit_lance);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_2))
            amount -= (amount / effect->GetTotalTicks()) * effect->GetTickNumber();
    }

    void Update(AuraEffect const*  /*effect*/)
    {
        PreventDefaultAction();
        if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
            effect->RecalculateAmount();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_teron_gorefiend_spirit_lance::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_DECREASE_SPEED);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_teron_gorefiend_spirit_lance::Update, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_teron_gorefiend_spiritual_vengeance : public AuraScript
{
    PrepareAuraScript(spell_teron_gorefiend_spiritual_vengeance);

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit::Kill(nullptr, GetTarget());
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_teron_gorefiend_spiritual_vengeance::HandleEffectRemove, EFFECT_2, SPELL_AURA_MOD_PACIFY_SILENCE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_teron_gorefiend_shadowy_construct : public AuraScript
{
    PrepareAuraScript(spell_teron_gorefiend_shadowy_construct);

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NORMAL, true);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_ALLOW_ID, SPELL_SPIRIT_LANCE, true);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_ALLOW_ID, SPELL_SPIRIT_CHAINS, true);
        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_ALLOW_ID, SPELL_SPIRIT_VOLLEY, true);

        GetUnitOwner()->ToCreature()->SetInCombatWithZone();
        Map::PlayerList const& playerList = GetUnitOwner()->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator i = playerList.begin(); i != playerList.end(); ++i)
            if (Player* player = i->GetSource())
            {
                if (GetUnitOwner()->IsValidAttackTarget(player))
                    GetUnitOwner()->AddThreat(player, 1000000.0f);
            }

        GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_BRIEF_STUN, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_teron_gorefiend_shadowy_construct::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_teron_gorefiend_shadow_of_death_remove : public SpellScript
{
    PrepareSpellScript(spell_teron_gorefiend_shadow_of_death_remove);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_SHADOW_OF_DEATH,
            SPELL_POSSESS_SPIRIT_IMMUNE,
            SPELL_SPIRITUAL_VENGEANCE
        });
    }

    void HandleOnHit()
    {
        if (Unit* target = GetHitUnit())
        {
            target->RemoveAurasDueToSpell(SPELL_POSSESS_SPIRIT_IMMUNE);
            target->RemoveAurasDueToSpell(SPELL_SPIRITUAL_VENGEANCE);
            target->RemoveAurasDueToSpell(SPELL_SHADOW_OF_DEATH);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_teron_gorefiend_shadow_of_death_remove::HandleOnHit);
    }
};

void AddSC_boss_teron_gorefiend()
{
    RegisterBlackTempleCreatureAI(boss_teron_gorefiend);
    RegisterBlackTempleCreatureAI(npc_vengeful_spirit);
    RegisterSpellScript(spell_teron_gorefiend_shadow_of_death);
    RegisterSpellScript(spell_teron_gorefiend_spirit_lance);
    RegisterSpellScript(spell_teron_gorefiend_spiritual_vengeance);
    RegisterSpellScript(spell_teron_gorefiend_shadowy_construct);
    RegisterSpellScript(spell_teron_gorefiend_shadow_of_death_remove);
}
