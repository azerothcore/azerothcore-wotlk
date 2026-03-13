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

#ifndef AZEROTHCORE_AURA_STUB_H
#define AZEROTHCORE_AURA_STUB_H

#include "gmock/gmock.h"
#include <cstdint>
#include <chrono>
#include <memory>
#include <vector>

class SpellInfo;
class UnitStub;

/**
 * @brief Lightweight stub for AuraEffect proc-related functionality
 */
class AuraEffectStub
{
public:
    AuraEffectStub(uint8_t effIndex = 0, int32_t amount = 0, uint32_t auraType = 0)
        : _effIndex(effIndex), _amount(amount), _auraType(auraType) {}

    virtual ~AuraEffectStub() = default;

    [[nodiscard]] uint8_t GetEffIndex() const { return _effIndex; }
    [[nodiscard]] int32_t GetAmount() const { return _amount; }
    [[nodiscard]] uint32_t GetAuraType() const { return _auraType; }
    [[nodiscard]] int32_t GetBaseAmount() const { return _baseAmount; }
    [[nodiscard]] float GetCritChance() const { return _critChance; }

    void SetEffIndex(uint8_t effIndex) { _effIndex = effIndex; }
    void SetAmount(int32_t amount) { _amount = amount; }
    void SetAuraType(uint32_t auraType) { _auraType = auraType; }
    void SetBaseAmount(int32_t baseAmount) { _baseAmount = baseAmount; }
    void SetCritChance(float critChance) { _critChance = critChance; }

    // Periodic tracking
    [[nodiscard]] bool IsPeriodic() const { return _isPeriodic; }
    [[nodiscard]] int32_t GetTotalTicks() const { return _totalTicks; }
    [[nodiscard]] uint32_t GetTickNumber() const { return _tickNumber; }

    void SetPeriodic(bool isPeriodic) { _isPeriodic = isPeriodic; }
    void SetTotalTicks(int32_t totalTicks) { _totalTicks = totalTicks; }
    void SetTickNumber(uint32_t tickNumber) { _tickNumber = tickNumber; }

private:
    uint8_t _effIndex = 0;
    int32_t _amount = 0;
    int32_t _baseAmount = 0;
    uint32_t _auraType = 0;
    float _critChance = 0.0f;
    bool _isPeriodic = false;
    int32_t _totalTicks = 0;
    uint32_t _tickNumber = 0;
};

/**
 * @brief Lightweight stub for AuraApplication functionality
 */
class AuraApplicationStub
{
public:
    AuraApplicationStub() = default;
    virtual ~AuraApplicationStub() = default;

    [[nodiscard]] uint8_t GetEffectMask() const { return _effectMask; }
    [[nodiscard]] bool HasEffect(uint8_t effIndex) const
    {
        return (_effectMask & (1 << effIndex)) != 0;
    }
    [[nodiscard]] bool IsPositive() const { return _isPositive; }
    [[nodiscard]] uint8_t GetSlot() const { return _slot; }

    void SetEffectMask(uint8_t mask) { _effectMask = mask; }
    void SetEffect(uint8_t effIndex, bool enabled)
    {
        if (enabled)
            _effectMask |= (1 << effIndex);
        else
            _effectMask &= ~(1 << effIndex);
    }
    void SetPositive(bool isPositive) { _isPositive = isPositive; }
    void SetSlot(uint8_t slot) { _slot = slot; }

private:
    uint8_t _effectMask = 0x07; // All 3 effects by default
    bool _isPositive = true;
    uint8_t _slot = 0;
};

/**
 * @brief Lightweight stub for Aura proc-related functionality
 */
class AuraStub
{
public:
    AuraStub(uint32_t id = 0, uint32_t spellFamilyName = 0)
        : _id(id), _spellFamilyName(spellFamilyName)
    {
        // Create 3 effect slots by default
        for (int i = 0; i < 3; ++i)
        {
            _effects[i] = std::make_unique<AuraEffectStub>(static_cast<uint8_t>(i));
        }
    }

    virtual ~AuraStub() = default;

    // Basic identification
    [[nodiscard]] uint32_t GetId() const { return _id; }
    [[nodiscard]] uint32_t GetSpellFamilyName() const { return _spellFamilyName; }

    void SetId(uint32_t id) { _id = id; }
    void SetSpellFamilyName(uint32_t familyName) { _spellFamilyName = familyName; }

    // Effect access
    [[nodiscard]] AuraEffectStub* GetEffect(uint8_t effIndex) const
    {
        return (effIndex < 3) ? _effects[effIndex].get() : nullptr;
    }

    [[nodiscard]] bool HasEffect(uint8_t effIndex) const
    {
        return effIndex < 3 && _effects[effIndex] != nullptr;
    }

    [[nodiscard]] uint8_t GetEffectMask() const
    {
        uint8_t mask = 0;
        for (uint8_t i = 0; i < 3; ++i)
        {
            if (_effects[i])
                mask |= (1 << i);
        }
        return mask;
    }

    // Charges management
    [[nodiscard]] uint8_t GetCharges() const { return _charges; }
    [[nodiscard]] bool IsUsingCharges() const { return _isUsingCharges; }

    void SetCharges(uint8_t charges) { _charges = charges; }
    void SetUsingCharges(bool usingCharges) { _isUsingCharges = usingCharges; }

    virtual bool DropCharge()
    {
        if (_charges > 0)
        {
            --_charges;
            _chargeDropped = true;
            return true;
        }
        return false;
    }

    [[nodiscard]] bool WasChargeDropped() const { return _chargeDropped; }
    void ResetChargeDropped() { _chargeDropped = false; }

    // Duration
    [[nodiscard]] int32_t GetDuration() const { return _duration; }
    [[nodiscard]] int32_t GetMaxDuration() const { return _maxDuration; }
    [[nodiscard]] bool IsPermanent() const { return _maxDuration == -1; }

    void SetDuration(int32_t duration) { _duration = duration; }
    void SetMaxDuration(int32_t maxDuration) { _maxDuration = maxDuration; }

    // Cooldown tracking
    using TimePoint = std::chrono::steady_clock::time_point;

    [[nodiscard]] bool IsProcOnCooldown(TimePoint now) const
    {
        return now < _procCooldown;
    }

    void AddProcCooldown(TimePoint cooldownEnd)
    {
        _procCooldown = cooldownEnd;
    }

    void ResetProcCooldown()
    {
        _procCooldown = TimePoint::min();
    }

    // Stack amount
    [[nodiscard]] uint8_t GetStackAmount() const { return _stackAmount; }
    void SetStackAmount(uint8_t amount) { _stackAmount = amount; }

    /**
     * @brief Modify stack amount (for PROC_ATTR_USE_STACKS_FOR_CHARGES)
     * Mimics Aura::ModStackAmount() - removes aura if stacks reach 0
     */
    virtual bool ModStackAmount(int32_t amount, bool /* resetPeriodicTimer */ = true)
    {
        int32_t newAmount = static_cast<int32_t>(_stackAmount) + amount;
        if (newAmount <= 0)
        {
            _stackAmount = 0;
            Remove();
            return true; // Aura removed
        }
        _stackAmount = static_cast<uint8_t>(newAmount);
        return false;
    }

    // Aura flags
    [[nodiscard]] bool IsPassive() const { return _isPassive; }
    [[nodiscard]] bool IsRemoved() const { return _isRemoved; }

    void SetPassive(bool isPassive) { _isPassive = isPassive; }
    void SetRemoved(bool isRemoved) { _isRemoved = isRemoved; }

    /**
     * @brief Mark aura as removed (for charge exhaustion)
     * Mimics Aura::Remove()
     */
    virtual void Remove()
    {
        _isRemoved = true;
    }

    // Application management
    AuraApplicationStub& GetOrCreateApplication()
    {
        if (!_application)
            _application = std::make_unique<AuraApplicationStub>();
        return *_application;
    }

    [[nodiscard]] AuraApplicationStub* GetApplication() const
    {
        return _application.get();
    }

private:
    uint32_t _id = 0;
    uint32_t _spellFamilyName = 0;

    std::unique_ptr<AuraEffectStub> _effects[3];
    std::unique_ptr<AuraApplicationStub> _application;

    uint8_t _charges = 0;
    bool _isUsingCharges = false;
    bool _chargeDropped = false;

    int32_t _duration = -1;
    int32_t _maxDuration = -1;

    TimePoint _procCooldown = TimePoint::min();

    uint8_t _stackAmount = 1;
    bool _isPassive = false;
    bool _isRemoved = false;
};

/**
 * @brief GMock-enabled Aura stub for verification
 */
class MockAuraStub : public AuraStub
{
public:
    MockAuraStub(uint32_t id = 0, uint32_t spellFamilyName = 0)
        : AuraStub(id, spellFamilyName) {}

    MOCK_METHOD(bool, DropCharge, (), (override));
    MOCK_METHOD(bool, ModStackAmount, (int32_t amount, bool resetPeriodicTimer), (override));
    MOCK_METHOD(void, Remove, (), (override));
};

/**
 * @brief Builder for creating AuraStub instances with fluent API
 */
class AuraStubBuilder
{
public:
    AuraStubBuilder() : _stub(std::make_unique<AuraStub>()) {}

    AuraStubBuilder& WithId(uint32_t id)
    {
        _stub->SetId(id);
        return *this;
    }

    AuraStubBuilder& WithSpellFamilyName(uint32_t familyName)
    {
        _stub->SetSpellFamilyName(familyName);
        return *this;
    }

    AuraStubBuilder& WithCharges(uint8_t charges)
    {
        _stub->SetCharges(charges);
        _stub->SetUsingCharges(charges > 0);
        return *this;
    }

    AuraStubBuilder& WithDuration(int32_t duration)
    {
        _stub->SetDuration(duration);
        _stub->SetMaxDuration(duration);
        return *this;
    }

    AuraStubBuilder& WithStackAmount(uint8_t amount)
    {
        _stub->SetStackAmount(amount);
        return *this;
    }

    AuraStubBuilder& WithPassive(bool isPassive)
    {
        _stub->SetPassive(isPassive);
        return *this;
    }

    AuraStubBuilder& WithEffect(uint8_t effIndex, int32_t amount, uint32_t auraType = 0)
    {
        if (AuraEffectStub* eff = _stub->GetEffect(effIndex))
        {
            eff->SetAmount(amount);
            eff->SetAuraType(auraType);
        }
        return *this;
    }

    AuraStubBuilder& WithPeriodicEffect(uint8_t effIndex, int32_t amount, int32_t totalTicks)
    {
        if (AuraEffectStub* eff = _stub->GetEffect(effIndex))
        {
            eff->SetAmount(amount);
            eff->SetPeriodic(true);
            eff->SetTotalTicks(totalTicks);
        }
        return *this;
    }

    std::unique_ptr<AuraStub> Build()
    {
        return std::move(_stub);
    }

    AuraStub* BuildRaw()
    {
        return _stub.release();
    }

private:
    std::unique_ptr<AuraStub> _stub;
};

#endif //AZEROTHCORE_AURA_STUB_H
