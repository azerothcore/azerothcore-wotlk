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

#ifndef AZEROTHCORE_UNIT_STUB_H
#define AZEROTHCORE_UNIT_STUB_H

#include "gmock/gmock.h"
#include <cstdint>
#include <functional>
#include <map>
#include <vector>

class SpellInfo;
class Aura;
class AuraEffect;
class Item;

/**
 * @brief Lightweight stub for Unit proc-related functionality
 *
 * This stub provides controlled behavior for testing proc scripts
 * without requiring the full Unit hierarchy.
 */
class UnitStub
{
public:
    UnitStub() = default;
    virtual ~UnitStub() = default;

    // Identity
    virtual bool IsPlayer() const { return _isPlayer; }
    virtual bool IsAlive() const { return _isAlive; }
    virtual bool IsFriendlyTo(UnitStub const* unit) const { return _isFriendly; }

    void SetIsPlayer(bool isPlayer) { _isPlayer = isPlayer; }
    void SetIsAlive(bool isAlive) { _isAlive = isAlive; }
    void SetIsFriendly(bool isFriendly) { _isFriendly = isFriendly; }

    // Aura management
    virtual bool HasAura(uint32_t spellId) const
    {
        return _auras.find(spellId) != _auras.end();
    }

    virtual void AddAuraStub(uint32_t spellId)
    {
        _auras[spellId] = true;
    }

    virtual void RemoveAuraStub(uint32_t spellId)
    {
        _auras.erase(spellId);
    }

    // Spell casting tracking
    struct CastRecord
    {
        uint32_t spellId;
        bool triggered;
        int32_t bp0;
        int32_t bp1;
        int32_t bp2;
    };

    virtual void RecordCast(uint32_t spellId, bool triggered = true,
                           int32_t bp0 = 0, int32_t bp1 = 0, int32_t bp2 = 0)
    {
        _castHistory.push_back({spellId, triggered, bp0, bp1, bp2});
    }

    [[nodiscard]] std::vector<CastRecord> const& GetCastHistory() const { return _castHistory; }

    [[nodiscard]] bool WasCast(uint32_t spellId) const
    {
        for (auto const& record : _castHistory)
        {
            if (record.spellId == spellId)
                return true;
        }
        return false;
    }

    [[nodiscard]] size_t CountCasts(uint32_t spellId) const
    {
        size_t count = 0;
        for (auto const& record : _castHistory)
        {
            if (record.spellId == spellId)
                ++count;
        }
        return count;
    }

    void ClearCastHistory() { _castHistory.clear(); }

    // Health/Power
    virtual uint32_t GetMaxHealth() const { return _maxHealth; }
    virtual uint32_t GetHealth() const { return _health; }
    virtual uint32_t CountPctFromMaxHealth(int32_t pct) const
    {
        return (_maxHealth * static_cast<uint32_t>(pct)) / 100;
    }

    void SetMaxHealth(uint32_t maxHealth) { _maxHealth = maxHealth; }
    void SetHealth(uint32_t health) { _health = health; }

    // Weapon speed for PPM calculations
    virtual uint32_t GetAttackTime(uint8_t attType) const
    {
        return _attackTimes.count(attType) ? _attackTimes.at(attType) : 2000;
    }

    void SetAttackTime(uint8_t attType, uint32_t time)
    {
        _attackTimes[attType] = time;
    }

    // PPM modifier tracking for proc tests
    // Simulates Player::ApplySpellMod(spellId, SPELLMOD_PROC_PER_MINUTE, ppm)
    void SetPPMModifier(uint32_t spellId, float modifier)
    {
        _ppmModifiers[spellId] = modifier;
    }

    void ClearPPMModifiers()
    {
        _ppmModifiers.clear();
    }

    /**
     * @brief Calculate PPM proc chance with modifiers
     * Mimics Unit::GetPPMProcChance() formula: (WeaponSpeed * PPM) / 600.0f
     */
    virtual float GetPPMProcChance(uint32_t weaponSpeed, float ppm, uint32_t spellId = 0) const
    {
        if (ppm <= 0.0f)
            return 0.0f;

        // Apply PPM modifier if set for this spell
        float modifiedPPM = ppm;
        if (spellId > 0 && _ppmModifiers.count(spellId))
            modifiedPPM += _ppmModifiers.at(spellId);

        return (static_cast<float>(weaponSpeed) * modifiedPPM) / 600.0f;
    }

    // Chance modifier tracking for proc tests
    // Simulates Player::ApplySpellMod(spellId, SPELLMOD_CHANCE_OF_SUCCESS, chance)
    void SetChanceModifier(uint32_t spellId, float modifier)
    {
        _chanceModifiers[spellId] = modifier;
    }

    void ClearChanceModifiers()
    {
        _chanceModifiers.clear();
    }

    /**
     * @brief Apply chance modifier for a spell
     */
    float ApplyChanceModifier(uint32_t spellId, float baseChance) const
    {
        if (spellId > 0 && _chanceModifiers.count(spellId))
            return baseChance + _chanceModifiers.at(spellId);
        return baseChance;
    }

    // Cooldowns
    virtual bool HasSpellCooldown(uint32_t spellId) const
    {
        return _cooldowns.find(spellId) != _cooldowns.end();
    }

    virtual void AddSpellCooldown(uint32_t spellId)
    {
        _cooldowns[spellId] = true;
    }

    virtual void RemoveSpellCooldown(uint32_t spellId)
    {
        _cooldowns.erase(spellId);
    }

    // Class/Level
    virtual uint8_t GetClass() const { return _class; }
    virtual uint8_t GetLevel() const { return _level; }

    void SetClass(uint8_t unitClass) { _class = unitClass; }
    void SetLevel(uint8_t level) { _level = level; }

private:
    bool _isPlayer = false;
    bool _isAlive = true;
    bool _isFriendly = false;

    std::map<uint32_t, bool> _auras;
    std::vector<CastRecord> _castHistory;
    std::map<uint32_t, bool> _cooldowns;
    std::map<uint8_t, uint32_t> _attackTimes;
    std::map<uint32_t, float> _ppmModifiers;      // PPM modifiers by spell ID
    std::map<uint32_t, float> _chanceModifiers;   // Chance modifiers by spell ID

    uint32_t _maxHealth = 10000;
    uint32_t _health = 10000;
    uint8_t _class = 1; // Warrior by default
    uint8_t _level = 80;
};

/**
 * @brief GMock-enabled Unit stub for verification
 */
class MockUnitStub : public UnitStub
{
public:
    MOCK_METHOD(bool, IsPlayer, (), (const, override));
    MOCK_METHOD(bool, IsAlive, (), (const, override));
    MOCK_METHOD(bool, IsFriendlyTo, (UnitStub const* unit), (const, override));
    MOCK_METHOD(bool, HasAura, (uint32_t spellId), (const, override));
    MOCK_METHOD(uint32_t, GetMaxHealth, (), (const, override));
    MOCK_METHOD(uint32_t, GetHealth, (), (const, override));
    MOCK_METHOD(uint32_t, CountPctFromMaxHealth, (int32_t pct), (const, override));
    MOCK_METHOD(uint32_t, GetAttackTime, (uint8_t attType), (const, override));
    MOCK_METHOD(bool, HasSpellCooldown, (uint32_t spellId), (const, override));
    MOCK_METHOD(uint8_t, GetClass, (), (const, override));
    MOCK_METHOD(uint8_t, GetLevel, (), (const, override));
    MOCK_METHOD(float, GetPPMProcChance, (uint32_t weaponSpeed, float ppm, uint32_t spellId), (const, override));
};

#endif //AZEROTHCORE_UNIT_STUB_H
