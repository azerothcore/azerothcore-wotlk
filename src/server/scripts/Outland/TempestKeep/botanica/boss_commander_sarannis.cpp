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
#include "SpellScript.h"
#include "the_botanica.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_ARCANE_RESONANCE        = 2,
    SAY_ARCANE_DEVASTATION      = 3,
    EMOTE_SUMMON                = 4,
    SAY_SUMMON                  = 5,
    SAY_DEATH                   = 6
};

enum Spells
{
    SPELL_ARCANE_RESONANCE      = 34794,
    SPELL_ARCANE_DEVASTATION    = 34799,
    SPELL_SUMMON_REINFORCEMENTS = 34803,
    SPELL_SUMMON_MENDER_1       = 34810,
    SPELL_SUMMON_RESERVIST_1    = 34817,
    SPELL_SUMMON_RESERVIST_2    = 34818,
    SPELL_SUMMON_RESERVIST_3    = 34819
};

struct boss_commander_sarannis : public BossAI
{
    boss_commander_sarannis(Creature* creature) : BossAI(creature, DATA_COMMANDER_SARANNIS), _summoned(false) { }

    void Reset() override
    {
        _Reset();
        _summoned = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(20s, [this](TaskContext context)
        {
            if (roll_chance_i(50))
                Talk(SAY_ARCANE_RESONANCE);
            DoCastVictim(SPELL_ARCANE_RESONANCE);
            context.Repeat(27s);
        }).Schedule(10s, [this](TaskContext context)
        {
            if (roll_chance_i(50))
                Talk(SAY_ARCANE_DEVASTATION);
            DoCastVictim(SPELL_ARCANE_DEVASTATION);
            context.Repeat(17s);
        });

        if (IsHeroic())
        {
            ScheduleReinforcements();
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (!_summoned && me->HealthBelowPctDamaged(55, damage) && !IsHeroic())
        {
            _summoned = true;
            ScheduleReinforcements();
        }
    }

    void ScheduleReinforcements()
    {
        scheduler.Schedule(IsHeroic() ? 1min : 1s, [this](TaskContext context)
        {
            Talk(EMOTE_SUMMON);
            Talk(SAY_SUMMON);
            DoCast(SPELL_SUMMON_REINFORCEMENTS);

            if (IsHeroic())
            {
                context.Repeat();
            }
        });
    }

    private:
        bool _summoned;
};

// 34799 - Arcane Devastation
class spell_commander_sarannis_arcane_devastation : public AuraScript
{
    PrepareAuraScript(spell_commander_sarannis_arcane_devastation);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ARCANE_RESONANCE });
    }

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_ARCANE_RESONANCE);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_commander_sarannis_arcane_devastation::AfterApply, EFFECT_2, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 34803 - Summon Reinforcements
 class spell_commander_sarannis_summon_reinforcements : public SpellScript
 {
     PrepareSpellScript(spell_commander_sarannis_summon_reinforcements);

     bool Validate(SpellInfo const* /*spellInfo*/) override
     {
         return ValidateSpellInfo({ SPELL_SUMMON_MENDER_1, SPELL_SUMMON_RESERVIST_1, SPELL_SUMMON_RESERVIST_2, SPELL_SUMMON_RESERVIST_3 });
     }

     void HandleCast(SpellEffIndex /*effIndex*/)
     {
         std::vector<uint32> reinforcementSpells = { SPELL_SUMMON_MENDER_1, SPELL_SUMMON_RESERVIST_1, SPELL_SUMMON_RESERVIST_2, SPELL_SUMMON_RESERVIST_3 };
         for (uint32 spellId : reinforcementSpells)
         {
             GetCaster()->CastSpell((Unit*)nullptr, spellId, true);
         }
     }

     void Register() override
     {
         OnEffectHitTarget += SpellEffectFn(spell_commander_sarannis_summon_reinforcements::HandleCast, EFFECT_0, SPELL_EFFECT_DUMMY);
     }
 };

void AddSC_boss_commander_sarannis()
{
    RegisterTheBotanicaCreatureAI(boss_commander_sarannis);
    RegisterSpellScript(spell_commander_sarannis_arcane_devastation);
    RegisterSpellScript(spell_commander_sarannis_summon_reinforcements);
}
