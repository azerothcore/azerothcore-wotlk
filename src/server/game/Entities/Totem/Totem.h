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

#ifndef AZEROTHCORE_TOTEM_H
#define AZEROTHCORE_TOTEM_H

#include "TemporarySummon.h"

enum TotemType
{
    TOTEM_PASSIVE    = 0,
    TOTEM_ACTIVE     = 1,
    TOTEM_STATUE     = 2 // copied straight from moongose, may need more implementation to work
};
// Some Totems cast spells that are not in creature DB

enum class TotemSpellIds : uint32
{
    SentryTotemSpell = 6495,
    FireTotemSpell   = 32062
};

#define SENTRY_TOTEM_ENTRY    3968
#define EARTHBIND_TOTEM_ENTRY 2630

enum TotemImmunitySpells
{
    // Immune
    SPELL_CYCLONE    = 33786,
    // Not Immune
    SPELL_STONECLAW  = 55277,
    SPELL_BIND_SIGHT = 6277,
    SPELL_INTERVENE  = 3411
};

class Totem : public Minion
{
public:
    explicit Totem(SummonPropertiesEntry const* properties, ObjectGuid owner);
    ~Totem() override {};
    void Update(uint32 time) override;
    void InitStats(uint32 duration) override;
    void InitSummon() override;
    void UnSummon(Milliseconds msTime = 0ms) override;
    uint32 GetSpell(uint8 slot = 0) const { return m_spells[slot]; }
    uint32 GetTotemDuration() const { return m_duration; }
    void SetTotemDuration(uint32 duration) { m_duration = duration; }
    TotemType GetTotemType() const { return m_type; }

    bool UpdateStats(Stats /*stat*/) override { return true; }
    bool UpdateAllStats() override { return true; }
    void UpdateResistances(uint32 /*school*/) override {}
    void UpdateArmor() override {}
    void UpdateMaxHealth() override {}
    void UpdateMaxPower(Powers /*power*/) override {}
    void UpdateAttackPowerAndDamage(bool /*ranged*/) override {}
    void UpdateDamagePhysical(WeaponAttackType /*attType*/) override {}

    bool IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const override;

protected:
    TotemType m_type;
    uint32 m_duration;
};
#endif
