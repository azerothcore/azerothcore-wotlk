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
#include "ScriptMgrMacros.h"

void ScriptMgr::OnInitStatsForLevel(Guardian* guardian, uint8 petlevel)
{
    ExecuteScript<PetScript>([&](PetScript* script)
    {
        script->OnInitStatsForLevel(guardian, petlevel);
    });
}

void ScriptMgr::OnCalculateMaxTalentPointsForLevel(Pet* pet, uint8 level, uint8& points)
{
    ExecuteScript<PetScript>([&](PetScript* script)
    {
        script->OnCalculateMaxTalentPointsForLevel(pet, level, points);
    });
}

bool ScriptMgr::CanUnlearnSpellSet(Pet* pet, uint32 level, uint32 spell)
{
    auto ret = IsValidBoolScript<PetScript>([&](PetScript* script)
    {
        return !script->CanUnlearnSpellSet(pet, level, spell);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanUnlearnSpellDefault(Pet* pet, SpellInfo const* spellEntry)
{
    auto ret = IsValidBoolScript<PetScript>([&](PetScript* script)
    {
        return !script->CanUnlearnSpellDefault(pet, spellEntry);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanResetTalents(Pet* pet)
{
    auto ret = IsValidBoolScript<PetScript>([&](PetScript* script)
    {
        return !script->CanResetTalents(pet);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPetAddToWorld(Pet* pet)
{
    ASSERT(pet);

    ExecuteScript<PetScript>([&](PetScript* script)
    {
        script->OnPetAddToWorld(pet);
    });
}
