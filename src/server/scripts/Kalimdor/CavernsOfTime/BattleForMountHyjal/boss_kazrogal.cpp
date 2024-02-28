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
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"

enum Spells
{
    SPELL_CLEAVE        = 31436,
    SPELL_WARSTOMP      = 31480,
    SPELL_MARK          = 31447,
    SPELL_MARK_DAMAGE   = 31463
};

enum Texts
{
    SAY_ONSLAY          = 0,
    SAY_MARK            = 1,
    SAY_ONAGGRO         = 2,
};

enum Sounds
{
    SOUND_ONDEATH       = 11018,
};

enum Misc
{
    PATH_KAZROGAL       = 178880,
    POINT_COMBAT_START  = 7
};

struct boss_kazrogal : public BossAI
{
public:
    boss_kazrogal(Creature* creature) : BossAI(creature, DATA_KAZROGAL) { }

};

class spell_mark_of_kazrogal : public SpellScriptLoader
{
public:
    spell_mark_of_kazrogal() : SpellScriptLoader("spell_mark_of_kazrogal") { }

    class spell_mark_of_kazrogal_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mark_of_kazrogal_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(Acore::PowerCheck(POWER_MANA, false));
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mark_of_kazrogal_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    class spell_mark_of_kazrogal_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mark_of_kazrogal_AuraScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_MARK_DAMAGE });
        }

        void OnPeriodic(AuraEffect const* aurEff)
        {
            Unit* target = GetTarget();

            if (target->GetPower(POWER_MANA) == 0)
            {
                target->CastSpell(target, SPELL_MARK_DAMAGE, true, nullptr, aurEff);
                // Remove aura
                SetDuration(0);
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mark_of_kazrogal_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_MANA_LEECH);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_mark_of_kazrogal_SpellScript();
    }

    AuraScript* GetAuraScript() const override
    {
        return new spell_mark_of_kazrogal_AuraScript();
    }
};

void AddSC_boss_kazrogal()
{
    RegisterHyjalAI(boss_kazrogal);
    RegisterSpellScript(spell_mark_of_kazrogal);
}

