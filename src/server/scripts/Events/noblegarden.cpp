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

#include "Player.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum eNoblegarden
{
    SPELL_NOBLEGARDEN_BUNNY = 61734
};

// 61712 Summon Noblegarden Bunny Controller
class spell_summon_noblegarden_bunny_controller : public SpellScript
{
    PrepareSpellScript(spell_summon_noblegarden_bunny_controller);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_NOBLEGARDEN_BUNNY });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitPlayer())
            player->CastSpell(player, SPELL_NOBLEGARDEN_BUNNY, true);
    }

    SpellCastResult CheckCast()
    {
        if (roll_chance_i(5))
            return SPELL_CAST_OK;

        return SPELL_FAILED_UNKNOWN;
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_summon_noblegarden_bunny_controller::HandleDummy, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        OnCheckCast += SpellCheckCastFn(spell_summon_noblegarden_bunny_controller::CheckCast);
    }
};

void AddSC_event_noblegarden_scripts()
{
    RegisterSpellScript(spell_summon_noblegarden_bunny_controller);
}
