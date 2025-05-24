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

enum DevourHumanoid
{
    NPC_HEARTHGLEN_CRUSADER = 29102,
    NPC_TIRISFAL_CRUSADER   = 29103
};

// 53110 - Devour Humanoid
class spell_q12779_an_end_to_all_things : public SpellScript
{
    PrepareSpellScript(spell_q12779_an_end_to_all_things);

    SpellCastResult CheckCast()
    {
        if (Unit* caster = GetCaster())
            if (caster->FindNearestCreature(NPC_HEARTHGLEN_CRUSADER, 15.0f, true) || caster->FindNearestCreature(NPC_TIRISFAL_CRUSADER, 15.0f, true))
                return SPELL_CAST_OK;

        return SPELL_FAILED_BAD_TARGETS;
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Creature* c = GetHitUnit()->ToCreature())
            if (Unit* caster = GetCaster())
            {
                c->AI()->AttackStart(caster);
                c->CastSpell(caster, GetEffectValue(), true); // 53111
            }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q12779_an_end_to_all_things::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_q12779_an_end_to_all_things::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_the_scarlet_enclave_c3()
{
    RegisterSpellScript(spell_q12779_an_end_to_all_things);
}
