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
#include "serpent_shrine.h"

enum Talk
{
    SAY_AGGRO                   = 0,
    SAY_SWITCH_TO_CLEAN         = 1,
    SAY_CLEAN_SLAY              = 2,
    SAY_CLEAN_DEATH             = 3,
    SAY_SWITCH_TO_CORRUPT       = 4,
    SAY_CORRUPT_SLAY            = 5,
    SAY_CORRUPT_DEATH           = 6
};

enum Spells
{
    SPELL_CLEANSING_FIELD_AURA  = 37935,
    SPELL_CLEANSING_FIELD       = 37934,
    SPELL_BLUE_BEAM             = 38015,
    SPELL_ELEMENTAL_SPAWNIN     = 25035,

    SPELL_SUMMON_CORRUPTED1     = 38188,
    SPELL_SUMMON_CORRUPTED2     = 38189,
    SPELL_SUMMON_CORRUPTED3     = 38190,
    SPELL_SUMMON_CORRUPTED4     = 38191,
    SPELL_SUMMON_PURIFIED1      = 38198,
    SPELL_SUMMON_PURIFIED2      = 38199,
    SPELL_SUMMON_PURIFIED3      = 38200,
    SPELL_SUMMON_PURIFIED4      = 38201,

    SPELL_CORRUPTION            = 37961,
    SPELL_WATER_TOMB            = 38235,
    SPELL_VILE_SLUDGE           = 38246,
    SPELL_ENRAGE                = 27680,

    SPELL_MARK_OF_HYDROSS1      = 38215,
    SPELL_MARK_OF_HYDROSS2      = 38216,
    SPELL_MARK_OF_HYDROSS3      = 38217,
    SPELL_MARK_OF_HYDROSS4      = 38218,
    SPELL_MARK_OF_HYDROSS5      = 38231,
    SPELL_MARK_OF_HYDROSS6      = 40584,
    SPELL_MARK_OF_CORRUPTION1   = 38219,
    SPELL_MARK_OF_CORRUPTION2   = 38220,
    SPELL_MARK_OF_CORRUPTION3   = 38221,
    SPELL_MARK_OF_CORRUPTION4   = 38222,
    SPELL_MARK_OF_CORRUPTION5   = 38230,
    SPELL_MARK_OF_CORRUPTION6   = 40583,
};

enum Misc
{
    GROUP_ABILITIES                 = 1,
    NPC_PURE_SPAWN_OF_HYDROSS       = 22035,
};

struct boss_hydross_the_unstable : public BossAI
{
    boss_hydross_the_unstable(Creature* creature) : BossAI(creature, DATA_HYDROSS_THE_UNSTABLE)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();

        _recentlySpoken = false;
    }

    void JustReachedHome() override
    {
        BossAI::JustReachedHome();
        if (!me->HasAura(SPELL_BLUE_BEAM))
        {
            me->RemoveAurasDueToSpell(SPELL_CLEANSING_FIELD_AURA);
        }
    }

    void SetForm(bool corrupt, bool initial)
    {
        scheduler.CancelGroup(GROUP_ABILITIES);
        DoResetThreatList();

        if (corrupt)
        {
            me->SetMeleeDamageSchool(SPELL_SCHOOL_NATURE);
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, false);
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
            DoCastSelf(SPELL_CORRUPTION, true);

            scheduler.Schedule(0s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_CORRUPTION1);
            }).Schedule(15s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_CORRUPTION2);
            }).Schedule(30s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_CORRUPTION3);
            }).Schedule(45s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_CORRUPTION4);
            }).Schedule(60s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_CORRUPTION5);
            }).Schedule(75s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_CORRUPTION6);
            }).Schedule(12150ms, GROUP_ABILITIES, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_VILE_SLUDGE, true);
                context.Repeat(9700ms, 32800ms);
            });
        }
        else
        {
            me->SetMeleeDamageSchool(SPELL_SCHOOL_FROST);
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, true);
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, false);
            me->RemoveAurasDueToSpell(SPELL_CORRUPTION);

            scheduler.Schedule(0s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_HYDROSS1);
            }).Schedule(15s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_HYDROSS2);
            }).Schedule(30s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_HYDROSS3);
            }).Schedule(45s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_HYDROSS4);
            }).Schedule(60s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_HYDROSS5);
            }).Schedule(75s, GROUP_ABILITIES, [this](TaskContext)
            {
                DoCastSelf(SPELL_MARK_OF_HYDROSS6);
            }).Schedule(12150ms, GROUP_ABILITIES, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_WATER_TOMB, true);
                context.Repeat(9700ms, 32800ms);
            });
        }

        if (initial)
        {
            return;
        }

        if (corrupt)
        {
            Talk(SAY_SWITCH_TO_CORRUPT);
            for (uint32 spellId = SPELL_SUMMON_CORRUPTED1; spellId <= SPELL_SUMMON_CORRUPTED4; ++spellId)
            {
                DoCastSelf(spellId, true);
            }
        }
        else
        {
            Talk(SAY_SWITCH_TO_CLEAN);
            for (uint32 spellId = SPELL_SUMMON_PURIFIED1; spellId <= SPELL_SUMMON_PURIFIED4; ++spellId)
            {
                DoCastSelf(spellId, true);
            }
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        SetForm(false, true);

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (me->HasAura(SPELL_BLUE_BEAM) == me->HasAura(SPELL_CORRUPTION))
            {
                SetForm(!me->HasAura(SPELL_BLUE_BEAM), false);
            }
            context.Repeat(1s);
        }).Schedule(10min, [this](TaskContext)
        {
            DoCastSelf(SPELL_ENRAGE, true);
        });
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(me->HasAura(SPELL_CORRUPTION) ? SAY_CORRUPT_SLAY : SAY_CLEAN_SLAY);
            _recentlySpoken = true;
        }
        scheduler.Schedule(6s, [this](TaskContext)
        {
            _recentlySpoken = false;
        });
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        summon->CastSpell(summon, SPELL_ELEMENTAL_SPAWNIN, true);
        summon->SetInCombatWithZone();

        if (summon->GetEntry() == NPC_PURE_SPAWN_OF_HYDROSS)
        {
            summon->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, true);
        }
        else
        {
            summon->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
        }
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        summons.Despawn(summon);
    }

    void JustDied(Unit* killer) override
    {
        Talk(me->HasAura(SPELL_CORRUPTION) ? SAY_CORRUPT_DEATH : SAY_CLEAN_DEATH);
        BossAI::JustDied(killer);
    }
private:
    bool _recentlySpoken;
};

class spell_hydross_cleansing_field_aura : public SpellScriptLoader
{
public:
    spell_hydross_cleansing_field_aura() : SpellScriptLoader("spell_hydross_cleansing_field_aura") { }

    class spell_hydross_cleansing_field_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hydross_cleansing_field_aura_AuraScript)

        void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTarget()->GetEntry() == NPC_HYDROSS_THE_UNSTABLE)
                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, SPELL_CLEANSING_FIELD, true);
        }

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTarget()->GetEntry() == NPC_HYDROSS_THE_UNSTABLE)
                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, SPELL_CLEANSING_FIELD, true);
        }

        void Register() override
        {
            AfterEffectApply += AuraEffectApplyFn(spell_hydross_cleansing_field_aura_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_hydross_cleansing_field_aura_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_hydross_cleansing_field_aura_AuraScript();
    }
};

class spell_hydross_cleansing_field_command : public SpellScriptLoader
{
public:
    spell_hydross_cleansing_field_command() : SpellScriptLoader("spell_hydross_cleansing_field_command") { }

    class spell_hydross_cleansing_field_command_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hydross_cleansing_field_command_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTarget()->HasUnitState(UNIT_STATE_CASTING))
                GetTarget()->InterruptNonMeleeSpells(false);
            else
                GetTarget()->CastSpell(GetTarget(), SPELL_BLUE_BEAM, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectApplyFn(spell_hydross_cleansing_field_command_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_hydross_cleansing_field_command_AuraScript();
    }
};

class spell_hydross_mark_of_hydross : public SpellScriptLoader
{
public:
    spell_hydross_mark_of_hydross() : SpellScriptLoader("spell_hydross_mark_of_hydross") { }

    class spell_hydross_mark_of_hydross_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hydross_mark_of_hydross_AuraScript)

        void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetTarget()->RemoveAurasByType(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, GetCasterGUID(), GetAura());
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_hydross_mark_of_hydross_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_hydross_mark_of_hydross_AuraScript();
    }
};

void AddSC_boss_hydross_the_unstable()
{
    RegisterSerpentShrineAI(boss_hydross_the_unstable);
    new spell_hydross_cleansing_field_aura();
    new spell_hydross_cleansing_field_command();
    new spell_hydross_mark_of_hydross();
}
