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

#include "Group.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/* ScriptData
SDName: Feralas
SD%Complete: 100
SDComment: Quest support: 3520 Special vendor Gregan Brewspewer
SDCategory: Feralas
EndScriptData */

enum GordunniTrap
{
    GO_GORDUNNI_DIRT_MOUND = 144064,
};

class spell_gordunni_trap : public SpellScript
{
    PrepareSpellScript(spell_gordunni_trap);

    void HandleDummy()
    {
        if (Unit* caster = GetCaster())
            if (GameObject* chest = caster->SummonGameObject(GO_GORDUNNI_DIRT_MOUND, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
            {
                chest->SetSpellId(GetSpellInfo()->Id);
                caster->RemoveGameObject(chest, false);
            }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_gordunni_trap::HandleDummy);
    }
};

enum ZAPPED_GIANTS
{
    NPC_SHORE_STRIDER = 5359,
    NPC_DEEP_STRIDER = 5360,
    NPC_LAND_WALKER = 5357,
    NPC_WAVE_STRIDER = 5361,
    NPC_CLIFF_GIANT = 5358
};

class spell_transmogrify : public SpellScript
{
    PrepareSpellScript(spell_transmogrify);

    SpellCastResult CheckTarget()
    {
        Unit* target = GetExplTargetUnit(); // Explicit target selected by the caster

        // List of valid creature IDs
        std::set<uint32> validCreatureIds = { NPC_SHORE_STRIDER, NPC_DEEP_STRIDER, NPC_LAND_WALKER, NPC_WAVE_STRIDER, NPC_CLIFF_GIANT };

        // Validate the target
        if (!target || validCreatureIds.find(target->GetEntry()) == validCreatureIds.end())
            return SPELL_FAILED_BAD_TARGETS; // Prevent the spell cast with an error

        return SPELL_CAST_OK; // Allow the spell cast
    }

    void Register() override
    {
        // Register the check cast hook
        OnCheckCast += SpellCheckCastFn(spell_transmogrify::CheckTarget);
    }
};

void AddSC_feralas()
{
    RegisterSpellScript(spell_gordunni_trap);
    RegisterSpellScript(spell_transmogrify);
}
