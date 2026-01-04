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

#ifndef AZEROTHCORE_DAMAGE_HEAL_INFO_STUB_H
#define AZEROTHCORE_DAMAGE_HEAL_INFO_STUB_H

#include <cstdint>

class SpellInfo;
class UnitStub;

/**
 * @brief Lightweight stub for DamageInfo
 *
 * Mirrors the key fields of DamageInfo for proc testing without
 * requiring actual Unit objects.
 */
class DamageInfoStub
{
public:
    DamageInfoStub() = default;

    DamageInfoStub(uint32_t damage, uint32_t originalDamage, uint32_t schoolMask,
                   uint8_t attackType, SpellInfo const* spellInfo = nullptr)
        : _damage(damage)
        , _originalDamage(originalDamage)
        , _schoolMask(schoolMask)
        , _attackType(attackType)
        , _spellInfo(spellInfo)
    {}

    virtual ~DamageInfoStub() = default;

    // Damage values
    [[nodiscard]] uint32_t GetDamage() const { return _damage; }
    [[nodiscard]] uint32_t GetOriginalDamage() const { return _originalDamage; }
    [[nodiscard]] uint32_t GetAbsorb() const { return _absorb; }
    [[nodiscard]] uint32_t GetResist() const { return _resist; }
    [[nodiscard]] uint32_t GetBlock() const { return _block; }

    void SetDamage(uint32_t damage) { _damage = damage; }
    void SetOriginalDamage(uint32_t damage) { _originalDamage = damage; }
    void SetAbsorb(uint32_t absorb) { _absorb = absorb; }
    void SetResist(uint32_t resist) { _resist = resist; }
    void SetBlock(uint32_t block) { _block = block; }

    // School and attack type
    [[nodiscard]] uint32_t GetSchoolMask() const { return _schoolMask; }
    [[nodiscard]] uint8_t GetAttackType() const { return _attackType; }

    void SetSchoolMask(uint32_t schoolMask) { _schoolMask = schoolMask; }
    void SetAttackType(uint8_t attackType) { _attackType = attackType; }

    // Spell info
    [[nodiscard]] SpellInfo const* GetSpellInfo() const { return _spellInfo; }
    void SetSpellInfo(SpellInfo const* spellInfo) { _spellInfo = spellInfo; }

    // Hit result flags
    [[nodiscard]] uint32_t GetHitMask() const { return _hitMask; }
    void SetHitMask(uint32_t hitMask) { _hitMask = hitMask; }

private:
    uint32_t _damage = 0;
    uint32_t _originalDamage = 0;
    uint32_t _absorb = 0;
    uint32_t _resist = 0;
    uint32_t _block = 0;
    uint32_t _schoolMask = 1; // SPELL_SCHOOL_MASK_NORMAL
    uint8_t _attackType = 0;  // BASE_ATTACK
    uint32_t _hitMask = 0;
    SpellInfo const* _spellInfo = nullptr;
};

/**
 * @brief Lightweight stub for HealInfo
 *
 * Mirrors the key fields of HealInfo for proc testing.
 */
class HealInfoStub
{
public:
    HealInfoStub() = default;

    HealInfoStub(uint32_t heal, uint32_t effectiveHeal, uint32_t absorb,
                 SpellInfo const* spellInfo = nullptr)
        : _heal(heal)
        , _effectiveHeal(effectiveHeal)
        , _absorb(absorb)
        , _spellInfo(spellInfo)
    {}

    virtual ~HealInfoStub() = default;

    // Heal values
    [[nodiscard]] uint32_t GetHeal() const { return _heal; }
    [[nodiscard]] uint32_t GetEffectiveHeal() const { return _effectiveHeal; }
    [[nodiscard]] uint32_t GetAbsorb() const { return _absorb; }
    [[nodiscard]] uint32_t GetOverheal() const { return _heal > _effectiveHeal ? _heal - _effectiveHeal : 0; }

    void SetHeal(uint32_t heal) { _heal = heal; }
    void SetEffectiveHeal(uint32_t effectiveHeal) { _effectiveHeal = effectiveHeal; }
    void SetAbsorb(uint32_t absorb) { _absorb = absorb; }

    // Spell info
    [[nodiscard]] SpellInfo const* GetSpellInfo() const { return _spellInfo; }
    void SetSpellInfo(SpellInfo const* spellInfo) { _spellInfo = spellInfo; }

    // Hit result flags
    [[nodiscard]] uint32_t GetHitMask() const { return _hitMask; }
    void SetHitMask(uint32_t hitMask) { _hitMask = hitMask; }

private:
    uint32_t _heal = 0;
    uint32_t _effectiveHeal = 0;
    uint32_t _absorb = 0;
    uint32_t _hitMask = 0;
    SpellInfo const* _spellInfo = nullptr;
};

/**
 * @brief Builder for creating DamageInfoStub instances with fluent API
 */
class DamageInfoStubBuilder
{
public:
    DamageInfoStubBuilder() = default;

    DamageInfoStubBuilder& WithDamage(uint32_t damage)
    {
        _stub.SetDamage(damage);
        _stub.SetOriginalDamage(damage);
        return *this;
    }

    DamageInfoStubBuilder& WithOriginalDamage(uint32_t damage)
    {
        _stub.SetOriginalDamage(damage);
        return *this;
    }

    DamageInfoStubBuilder& WithSchoolMask(uint32_t schoolMask)
    {
        _stub.SetSchoolMask(schoolMask);
        return *this;
    }

    DamageInfoStubBuilder& WithAttackType(uint8_t attackType)
    {
        _stub.SetAttackType(attackType);
        return *this;
    }

    DamageInfoStubBuilder& WithSpellInfo(SpellInfo const* spellInfo)
    {
        _stub.SetSpellInfo(spellInfo);
        return *this;
    }

    DamageInfoStubBuilder& WithAbsorb(uint32_t absorb)
    {
        _stub.SetAbsorb(absorb);
        return *this;
    }

    DamageInfoStubBuilder& WithResist(uint32_t resist)
    {
        _stub.SetResist(resist);
        return *this;
    }

    DamageInfoStubBuilder& WithBlock(uint32_t block)
    {
        _stub.SetBlock(block);
        return *this;
    }

    DamageInfoStubBuilder& WithHitMask(uint32_t hitMask)
    {
        _stub.SetHitMask(hitMask);
        return *this;
    }

    DamageInfoStub Build() { return _stub; }

private:
    DamageInfoStub _stub;
};

/**
 * @brief Builder for creating HealInfoStub instances with fluent API
 */
class HealInfoStubBuilder
{
public:
    HealInfoStubBuilder() = default;

    HealInfoStubBuilder& WithHeal(uint32_t heal)
    {
        _stub.SetHeal(heal);
        _stub.SetEffectiveHeal(heal); // Assume all effective unless overridden
        return *this;
    }

    HealInfoStubBuilder& WithEffectiveHeal(uint32_t effectiveHeal)
    {
        _stub.SetEffectiveHeal(effectiveHeal);
        return *this;
    }

    HealInfoStubBuilder& WithOverheal(uint32_t overheal)
    {
        // Overheal = Heal - EffectiveHeal
        // So EffectiveHeal = Heal - Overheal
        if (_stub.GetHeal() >= overheal)
        {
            _stub.SetEffectiveHeal(_stub.GetHeal() - overheal);
        }
        return *this;
    }

    HealInfoStubBuilder& WithAbsorb(uint32_t absorb)
    {
        _stub.SetAbsorb(absorb);
        return *this;
    }

    HealInfoStubBuilder& WithSpellInfo(SpellInfo const* spellInfo)
    {
        _stub.SetSpellInfo(spellInfo);
        return *this;
    }

    HealInfoStubBuilder& WithHitMask(uint32_t hitMask)
    {
        _stub.SetHitMask(hitMask);
        return *this;
    }

    HealInfoStub Build() { return _stub; }

private:
    HealInfoStub _stub;
};

#endif //AZEROTHCORE_DAMAGE_HEAL_INFO_STUB_H
