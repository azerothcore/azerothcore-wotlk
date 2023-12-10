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

#ifndef SCRIPT_OBJECT_PET_SCRIPT_H_
#define SCRIPT_OBJECT_PET_SCRIPT_H_

#include "ScriptObject.h"

class PetScript : public ScriptObject
{
protected:
    PetScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    virtual void OnInitStatsForLevel(Guardian* /*guardian*/, uint8 /*petlevel*/) { }

    virtual void OnCalculateMaxTalentPointsForLevel(Pet* /*pet*/, uint8 /*level*/, uint8& /*points*/) { }

    [[nodiscard]] virtual bool CanUnlearnSpellSet(Pet* /*pet*/, uint32 /*level*/, uint32 /*spell*/) { return true; }

    [[nodiscard]] virtual bool CanUnlearnSpellDefault(Pet* /*pet*/, SpellInfo const* /*spellInfo*/) { return true; }

    [[nodiscard]] virtual bool CanResetTalents(Pet* /*pet*/) { return true; }

    /**
     * @brief This hook called after add pet in world
     *
     * @param pet Contains information about the Pet
     */
    virtual void OnPetAddToWorld(Pet* /*pet*/) { }
};

#endif
