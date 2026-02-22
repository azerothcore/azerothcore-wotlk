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

#ifndef AZEROTHCORE_SPELL_INFO_TEST_HELPER_H
#define AZEROTHCORE_SPELL_INFO_TEST_HELPER_H

#include "SpellInfo.h"
#include "SharedDefines.h"
#include <memory>

/**
 * @brief Helper class to create SpellEntry test instances
 *
 * This creates a SpellEntry with sensible defaults for unit testing.
 */
class TestSpellEntryHelper
{
public:
    TestSpellEntryHelper()
    {
        // Zero initialize all fields
        std::memset(&_entry, 0, sizeof(_entry));

        // Set safe defaults
        _entry.EquippedItemClass = -1;
        _entry.SchoolMask = SPELL_SCHOOL_MASK_NORMAL;

        // Initialize empty strings
        for (auto& name : _entry.SpellName)
            name = "";
        for (auto& rank : _entry.Rank)
            rank = "";
    }

    TestSpellEntryHelper& WithId(uint32 id)
    {
        _entry.Id = id;
        return *this;
    }

    TestSpellEntryHelper& WithSpellFamilyName(uint32 familyName)
    {
        _entry.SpellFamilyName = familyName;
        return *this;
    }

    TestSpellEntryHelper& WithSpellFamilyFlags(uint32 flag0, uint32 flag1 = 0, uint32 flag2 = 0)
    {
        _entry.SpellFamilyFlags[0] = flag0;
        _entry.SpellFamilyFlags[1] = flag1;
        _entry.SpellFamilyFlags[2] = flag2;
        return *this;
    }

    TestSpellEntryHelper& WithSchoolMask(uint32 schoolMask)
    {
        _entry.SchoolMask = schoolMask;
        return *this;
    }

    TestSpellEntryHelper& WithProcFlags(uint32 procFlags)
    {
        _entry.ProcFlags = procFlags;
        return *this;
    }

    TestSpellEntryHelper& WithProcChance(uint32 procChance)
    {
        _entry.ProcChance = procChance;
        return *this;
    }

    TestSpellEntryHelper& WithProcCharges(uint32 procCharges)
    {
        _entry.ProcCharges = procCharges;
        return *this;
    }

    TestSpellEntryHelper& WithDmgClass(uint32 dmgClass)
    {
        _entry.DmgClass = dmgClass;
        return *this;
    }

    TestSpellEntryHelper& WithEffect(uint8 effIndex, uint32 effect, uint32 auraType = 0)
    {
        if (effIndex < MAX_SPELL_EFFECTS)
        {
            _entry.Effect[effIndex] = effect;
            _entry.EffectApplyAuraName[effIndex] = auraType;
        }
        return *this;
    }

    TestSpellEntryHelper& WithEffectTriggerSpell(uint8 effIndex, uint32 triggerSpell)
    {
        if (effIndex < MAX_SPELL_EFFECTS)
        {
            _entry.EffectTriggerSpell[effIndex] = triggerSpell;
        }
        return *this;
    }

    SpellEntry const* Get() const
    {
        return &_entry;
    }

private:
    SpellEntry _entry;
};

/**
 * @brief Builder class for creating SpellInfo test instances
 *
 * This helper allows easy construction of SpellInfo objects for unit testing
 * without requiring DBC data.
 */
class SpellInfoBuilder
{
public:
    SpellInfoBuilder() : _entryHelper() {}

    SpellInfoBuilder& WithId(uint32 id)
    {
        _entryHelper.WithId(id);
        return *this;
    }

    SpellInfoBuilder& WithSpellFamilyName(uint32 familyName)
    {
        _entryHelper.WithSpellFamilyName(familyName);
        return *this;
    }

    SpellInfoBuilder& WithSpellFamilyFlags(uint32 flag0, uint32 flag1 = 0, uint32 flag2 = 0)
    {
        _entryHelper.WithSpellFamilyFlags(flag0, flag1, flag2);
        return *this;
    }

    SpellInfoBuilder& WithSchoolMask(uint32 schoolMask)
    {
        _entryHelper.WithSchoolMask(schoolMask);
        return *this;
    }

    SpellInfoBuilder& WithProcFlags(uint32 procFlags)
    {
        _entryHelper.WithProcFlags(procFlags);
        return *this;
    }

    SpellInfoBuilder& WithProcChance(uint32 procChance)
    {
        _entryHelper.WithProcChance(procChance);
        return *this;
    }

    SpellInfoBuilder& WithProcCharges(uint32 procCharges)
    {
        _entryHelper.WithProcCharges(procCharges);
        return *this;
    }

    SpellInfoBuilder& WithDmgClass(uint32 dmgClass)
    {
        _entryHelper.WithDmgClass(dmgClass);
        return *this;
    }

    SpellInfoBuilder& WithEffect(uint8 effIndex, uint32 effect, uint32 auraType = 0)
    {
        _entryHelper.WithEffect(effIndex, effect, auraType);
        return *this;
    }

    SpellInfoBuilder& WithEffectTriggerSpell(uint8 effIndex, uint32 triggerSpell)
    {
        _entryHelper.WithEffectTriggerSpell(effIndex, triggerSpell);
        return *this;
    }

    // Builds and returns a SpellInfo pointer
    // Note: Caller is responsible for lifetime management
    SpellInfo* Build()
    {
        return new SpellInfo(_entryHelper.Get());
    }

    // Builds and returns a managed SpellInfo pointer
    std::unique_ptr<SpellInfo> BuildUnique()
    {
        return std::unique_ptr<SpellInfo>(new SpellInfo(_entryHelper.Get()));
    }

private:
    TestSpellEntryHelper _entryHelper;
};

#endif //AZEROTHCORE_SPELL_INFO_TEST_HELPER_H
