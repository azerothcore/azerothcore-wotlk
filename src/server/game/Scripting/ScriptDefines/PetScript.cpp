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

#include "PetScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnInitStatsForLevel(Guardian* guardian, uint8 petlevel)
{
    CALL_ENABLED_HOOKS(PetScript, PETHOOK_ON_INIT_STATS_FOR_LEVEL, script->OnInitStatsForLevel(guardian, petlevel));
}

void ScriptMgr::OnCalculateMaxTalentPointsForLevel(Pet* pet, uint8 level, uint8& points)
{
    CALL_ENABLED_HOOKS(PetScript, PETHOOK_ON_CALCULATE_MAX_TALENT_POINTS_FOR_LEVEL, script->OnCalculateMaxTalentPointsForLevel(pet, level, points));
}

bool ScriptMgr::CanUnlearnSpellSet(Pet* pet, uint32 level, uint32 spell)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PetScript, PETHOOK_CAN_UNLEARN_SPELL_SET, !script->CanUnlearnSpellSet(pet, level, spell));
}

bool ScriptMgr::CanUnlearnSpellDefault(Pet* pet, SpellInfo const* spellInfo)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PetScript, PETHOOK_CAN_UNLEARN_SPELL_DEFAULT, !script->CanUnlearnSpellDefault(pet, spellInfo));
}

bool ScriptMgr::CanResetTalents(Pet* pet)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PetScript, PETHOOK_CAN_RESET_TALENTS, !script->CanResetTalents(pet));
}

void ScriptMgr::OnPetAddToWorld(Pet* pet)
{
    ASSERT(pet);

    CALL_ENABLED_HOOKS(PetScript, PETHOOK_ON_PET_ADD_TO_WORLD, script->OnPetAddToWorld(pet));
}

PetScript::PetScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, PETHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < PETHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<PetScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<PetScript>;
