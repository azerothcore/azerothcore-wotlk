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
#include "SpellScript.h"
#include "the_underbog.h"

class spell_fungal_decay : public AuraScript
{
    PrepareAuraScript(spell_fungal_decay);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        ModStackAmount(5);
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        ModStackAmount(-1);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_fungal_decay::OnApply, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_fungal_decay::PeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

enum AllergiesEnum
{
    SPELL_SNEEZE    = 31428
};

class spell_allergies : public AuraScript
{
    PrepareAuraScript(spell_allergies);

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = urand(10 * IN_MILLISECONDS, 60 * IN_MILLISECONDS);
    }

    void Update(AuraEffect* /*effect*/)
    {
        if (Unit* target = GetUnitOwner())
        {
            target->CastSpell(target, SPELL_SNEEZE, true);
        }
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_allergies::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_allergies::Update, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_underbog()
{
    RegisterSpellScript(spell_fungal_decay);
    RegisterSpellScript(spell_allergies);
}
