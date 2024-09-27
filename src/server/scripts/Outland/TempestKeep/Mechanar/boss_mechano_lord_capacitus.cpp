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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "mechanar.h"

enum Spells
{
    SPELL_HEADCRACK                 = 35161,
    SPELL_REFLECTIVE_MAGIC_SHIELD   = 35158,
    SPELL_REFLECTIVE_DAMAGE_SHIELD  = 35159,
    SPELL_POLARITY_SHIFT            = 39096,
    SPELL_BERSERK                   = 26662,

    SPELL_NETHER_CHARGE_PASSIVE     = 35150,

    SPELL_SUMMON_NETHER_CHARGE_NE   = 35153,
    SPELL_SUMMON_NETHER_CHARGE_NW   = 35904,
    SPELL_SUMMON_NETHER_CHARGE_SE   = 35905,
    SPELL_SUMMON_NETHER_CHARGE_SW   = 35906,
};

enum Yells
{
    SAY_AGGRO                      = 0,
    SAY_REFLECTIVE_MAGIC_SHIELD    = 1,
    SAY_REFLECTIVE_DAMAGE_SHIELD   = 2,
    SAY_KILL                       = 3,
    SAY_DEATH                      = 4
};

struct boss_mechano_lord_capacitus : public BossAI
{
    boss_mechano_lord_capacitus(Creature* creature) : BossAI(creature, DATA_MECHANOLORD_CAPACITUS) { }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_HEADCRACK);
            context.Repeat(20s);
        }).Schedule(10s, [this](TaskContext context)
        {
            uint32 spellId = RAND(SPELL_SUMMON_NETHER_CHARGE_NE,
                SPELL_SUMMON_NETHER_CHARGE_NW,
                SPELL_SUMMON_NETHER_CHARGE_SE,
                SPELL_SUMMON_NETHER_CHARGE_SW);
            DoCastAOE(spellId);
            context.Repeat(2400ms, 3600ms);
        }).Schedule(3min, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_BERSERK, true);
        });

        if (IsHeroic())
        {
            scheduler.Schedule(15s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_POLARITY_SHIFT, true);
                context.Repeat(30s);
            });
        }
        else
        {
            scheduler.Schedule(15s, [this](TaskContext context)
            {
                if (IsEvenNumber(context.GetRepeatCounter()))
                {
                    Talk(SAY_REFLECTIVE_DAMAGE_SHIELD);
                    DoCastSelf(SPELL_REFLECTIVE_DAMAGE_SHIELD);
                }
                else
                {
                    Talk(SAY_REFLECTIVE_MAGIC_SHIELD);
                    DoCastSelf(SPELL_REFLECTIVE_MAGIC_SHIELD);
                }

                context.Repeat(20s);
            });
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

    void JustSummoned(Creature* summon) override
    {
        summon->GetMotionMaster()->MoveRandom(30.0f);
    }
};

enum polarityShift
{
    SPELL_POSITIVE_POLARITY         = 39088,
    SPELL_POSITIVE_CHARGE_STACK     = 39089,
    SPELL_POSITIVE_CHARGE           = 39090,

    SPELL_NEGATIVE_POLARITY         = 39091,
    SPELL_NEGATIVE_CHARGE_STACK     = 39092,
    SPELL_NEGATIVE_CHARGE           = 39093
};

class spell_capacitus_polarity_charge : public SpellScript
{
    PrepareSpellScript(spell_capacitus_polarity_charge);

    void HandleTargets(std::list<WorldObject*>& targetList)
    {
        uint8 count = 0;
        for (auto& ihit : targetList)
            if (ihit->GetGUID() != GetCaster()->GetGUID())
                if (Player* target = ihit->ToPlayer())
                    if (target->HasAura(GetTriggeringSpell()->Id))
                        ++count;

        uint32 spellId = GetSpellInfo()->Id == SPELL_POSITIVE_CHARGE ? SPELL_POSITIVE_CHARGE_STACK : SPELL_NEGATIVE_CHARGE_STACK;
        if (count)
        {
            GetCaster()->SetAuraStack(spellId, GetCaster(), count);
        }
        else
        {
            GetCaster()->RemoveAurasDueToSpell(spellId);
        }
    }

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        if (!GetTriggeringSpell())
            return;

        Unit* target = GetHitUnit();
        if (target->HasAura(GetTriggeringSpell()->Id))
            SetHitDamage(0);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_capacitus_polarity_charge::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_capacitus_polarity_charge::HandleTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

class spell_capacitus_polarity_charge_aura : public AuraScript
{
    PrepareAuraScript(spell_capacitus_polarity_charge_aura);

    void HandleAfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
        {
            Unit* target = GetTarget();
            if (!target)
                return;

            target->RemoveAurasDueToSpell(SPELL_POSITIVE_CHARGE_STACK);
            target->RemoveAurasDueToSpell(SPELL_NEGATIVE_CHARGE_STACK);
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_capacitus_polarity_charge_aura::HandleAfterRemove, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_capacitus_polarity_shift : public SpellScript
{
    PrepareSpellScript(spell_capacitus_polarity_shift);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->RemoveAurasDueToSpell(SPELL_POSITIVE_CHARGE_STACK);
            target->RemoveAurasDueToSpell(SPELL_NEGATIVE_CHARGE_STACK);
            target->CastSpell(target, roll_chance_i(50) ? SPELL_POSITIVE_POLARITY : SPELL_NEGATIVE_POLARITY, true, nullptr, nullptr, GetCaster()->GetGUID());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_capacitus_polarity_shift::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_mechano_lord_capacitus()
{
    RegisterMechanarCreatureAI(boss_mechano_lord_capacitus);
    RegisterSpellScript(spell_capacitus_polarity_charge);
    RegisterSpellScript(spell_capacitus_polarity_charge_aura);
    RegisterSpellScript(spell_capacitus_polarity_shift);
}
