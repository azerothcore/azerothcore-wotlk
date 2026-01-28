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

#ifndef AZEROTHCORE_PROC_EVENT_INFO_HELPER_H
#define AZEROTHCORE_PROC_EVENT_INFO_HELPER_H

#include "SpellMgr.h"
#include "Unit.h"

/**
 * @brief Builder class for creating ProcEventInfo test instances
 *
 * This helper allows easy construction of ProcEventInfo objects for unit testing
 * the proc system without requiring full game objects.
 */
class ProcEventInfoBuilder
{
public:
    ProcEventInfoBuilder()
        : _actor(nullptr), _actionTarget(nullptr), _procTarget(nullptr),
          _typeMask(0), _spellTypeMask(0), _spellPhaseMask(0), _hitMask(0),
          _spell(nullptr), _damageInfo(nullptr), _healInfo(nullptr),
          _triggeredByAuraSpell(nullptr), _procAuraEffectIndex(-1) {}

    ProcEventInfoBuilder& WithActor(Unit* actor)
    {
        _actor = actor;
        return *this;
    }

    ProcEventInfoBuilder& WithActionTarget(Unit* target)
    {
        _actionTarget = target;
        return *this;
    }

    ProcEventInfoBuilder& WithProcTarget(Unit* target)
    {
        _procTarget = target;
        return *this;
    }

    ProcEventInfoBuilder& WithTypeMask(uint32 typeMask)
    {
        _typeMask = typeMask;
        return *this;
    }

    ProcEventInfoBuilder& WithSpellTypeMask(uint32 spellTypeMask)
    {
        _spellTypeMask = spellTypeMask;
        return *this;
    }

    ProcEventInfoBuilder& WithSpellPhaseMask(uint32 spellPhaseMask)
    {
        _spellPhaseMask = spellPhaseMask;
        return *this;
    }

    ProcEventInfoBuilder& WithHitMask(uint32 hitMask)
    {
        _hitMask = hitMask;
        return *this;
    }

    ProcEventInfoBuilder& WithSpell(Spell const* spell)
    {
        _spell = spell;
        return *this;
    }

    ProcEventInfoBuilder& WithDamageInfo(DamageInfo* damageInfo)
    {
        _damageInfo = damageInfo;
        return *this;
    }

    ProcEventInfoBuilder& WithHealInfo(HealInfo* healInfo)
    {
        _healInfo = healInfo;
        return *this;
    }

    ProcEventInfoBuilder& WithTriggeredByAuraSpell(SpellInfo const* spellInfo)
    {
        _triggeredByAuraSpell = spellInfo;
        return *this;
    }

    ProcEventInfoBuilder& WithProcAuraEffectIndex(int8 index)
    {
        _procAuraEffectIndex = index;
        return *this;
    }

    ProcEventInfo Build()
    {
        return ProcEventInfo(_actor, _actionTarget, _procTarget, _typeMask,
                             _spellTypeMask, _spellPhaseMask, _hitMask,
                             _spell, _damageInfo, _healInfo,
                             _triggeredByAuraSpell, _procAuraEffectIndex);
    }

private:
    Unit* _actor;
    Unit* _actionTarget;
    Unit* _procTarget;
    uint32 _typeMask;
    uint32 _spellTypeMask;
    uint32 _spellPhaseMask;
    uint32 _hitMask;
    Spell const* _spell;
    DamageInfo* _damageInfo;
    HealInfo* _healInfo;
    SpellInfo const* _triggeredByAuraSpell;
    int8 _procAuraEffectIndex;
};

/**
 * @brief Builder class for creating SpellProcEntry test instances
 *
 * This helper allows easy construction of SpellProcEntry objects for unit testing
 * the proc system.
 */
class SpellProcEntryBuilder
{
public:
    SpellProcEntryBuilder()
    {
        _entry = {};
    }

    SpellProcEntryBuilder& WithSchoolMask(uint32 schoolMask)
    {
        _entry.SchoolMask = schoolMask;
        return *this;
    }

    SpellProcEntryBuilder& WithSpellFamilyName(uint32 familyName)
    {
        _entry.SpellFamilyName = familyName;
        return *this;
    }

    SpellProcEntryBuilder& WithSpellFamilyMask(flag96 familyMask)
    {
        _entry.SpellFamilyMask = familyMask;
        return *this;
    }

    SpellProcEntryBuilder& WithProcFlags(uint32 procFlags)
    {
        _entry.ProcFlags = procFlags;
        return *this;
    }

    SpellProcEntryBuilder& WithSpellTypeMask(uint32 spellTypeMask)
    {
        _entry.SpellTypeMask = spellTypeMask;
        return *this;
    }

    SpellProcEntryBuilder& WithSpellPhaseMask(uint32 spellPhaseMask)
    {
        _entry.SpellPhaseMask = spellPhaseMask;
        return *this;
    }

    SpellProcEntryBuilder& WithHitMask(uint32 hitMask)
    {
        _entry.HitMask = hitMask;
        return *this;
    }

    SpellProcEntryBuilder& WithAttributesMask(uint32 attributesMask)
    {
        _entry.AttributesMask = attributesMask;
        return *this;
    }

    SpellProcEntryBuilder& WithDisableEffectsMask(uint32 disableEffectsMask)
    {
        _entry.DisableEffectsMask = disableEffectsMask;
        return *this;
    }

    SpellProcEntryBuilder& WithProcsPerMinute(float ppm)
    {
        _entry.ProcsPerMinute = ppm;
        return *this;
    }

    SpellProcEntryBuilder& WithChance(float chance)
    {
        _entry.Chance = chance;
        return *this;
    }

    SpellProcEntryBuilder& WithCooldown(Milliseconds cooldown)
    {
        _entry.Cooldown = cooldown;
        return *this;
    }

    SpellProcEntryBuilder& WithCharges(uint32 charges)
    {
        _entry.Charges = charges;
        return *this;
    }

    SpellProcEntry Build() const
    {
        return _entry;
    }

private:
    SpellProcEntry _entry;
};

#endif //AZEROTHCORE_PROC_EVENT_INFO_HELPER_H
