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

#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

class spell_q12779_an_end_to_all_things : public SpellScript
{
    PrepareSpellScript(spell_q12779_an_end_to_all_things);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit())
            GetHitUnit()->CastSpell(GetCaster(), GetEffectValue(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12779_an_end_to_all_things::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_the_scarlet_enclave_c3()
{
    RegisterSpellScript(spell_q12779_an_end_to_all_things);
}

