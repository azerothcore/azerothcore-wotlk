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

#include "GridNotifiers.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Spells
{
    SPELL_AXE_FLURRY_STUN   = 24020
};

class spell_axe_flurry : public SpellScript
{
    PrepareSpellScript(spell_axe_flurry);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_AXE_FLURRY_STUN));
        Acore::Containers::RandomResize(targets, 1);
    }

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetHitUnit())
            {
                caster->CastSpell(target, SPELL_AXE_FLURRY_STUN, true);
            }
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_axe_flurry::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_axe_flurry::HandleEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_zulgurub()
{
    RegisterSpellScript(spell_axe_flurry);
}
