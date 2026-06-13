/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
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

// 53111 - Devour Humanoid (casted by the devoured creature)
class spell_q12779_an_end_to_all_things_devour_aura : public AuraScript
{
    PrepareAuraScript(spell_q12779_an_end_to_all_things_devour_aura);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetTarget();
        if (!caster || !target)
            return;

        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
        {
            caster->SetDisableGravity(true);
            Unit::Kill(target, caster);
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_q12779_an_end_to_all_things_devour_aura::OnRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_the_scarlet_enclave_c3()
{
    RegisterSpellScript(spell_q12779_an_end_to_all_things);
    RegisterSpellScript(spell_q12779_an_end_to_all_things_devour_aura);
}
