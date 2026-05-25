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

#ifndef AZEROTHCORE_AURA_SCRIPT_TEST_FRAMEWORK_H
#define AZEROTHCORE_AURA_SCRIPT_TEST_FRAMEWORK_H

#include "AuraStub.h"
#include "DamageHealInfoStub.h"
#include "ProcEventInfoHelper.h"
#include "SpellInfoTestHelper.h"
#include "UnitStub.h"
#include "SpellMgr.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"
#include <memory>
#include <vector>

/**
 * @brief Simulated proc result for testing
 */
struct ProcTestResult
{
    bool shouldProc = false;
    uint8_t effectMask = 0;
    float procChance = 100.0f;
    std::vector<uint32_t> spellsCast;
    bool chargeConsumed = false;
    bool cooldownSet = false;
};

/**
 * @brief Context for a proc test scenario
 */
class ProcTestContext
{
public:
    ProcTestContext() = default;

    // Actor (the one doing something that triggers the proc)
    UnitStub& GetActor() { return _actor; }
    UnitStub const& GetActor() const { return _actor; }

    // Target (the one being affected)
    UnitStub& GetTarget() { return _target; }
    UnitStub const& GetTarget() const { return _target; }

    // The aura that might proc
    AuraStub& GetAura() { return _aura; }
    AuraStub const& GetAura() const { return _aura; }

    // Damage info for damage-based procs
    DamageInfoStub& GetDamageInfo() { return _damageInfo; }
    DamageInfoStub const& GetDamageInfo() const { return _damageInfo; }

    // Heal info for heal-based procs
    HealInfoStub& GetHealInfo() { return _healInfo; }
    HealInfoStub const& GetHealInfo() const { return _healInfo; }

    // Setup methods
    ProcTestContext& WithAuraId(uint32_t auraId)
    {
        _aura.SetId(auraId);
        return *this;
    }

    ProcTestContext& WithAuraSpellFamily(uint32_t familyName)
    {
        _aura.SetSpellFamilyName(familyName);
        return *this;
    }

    ProcTestContext& WithAuraCharges(uint8_t charges)
    {
        _aura.SetCharges(charges);
        _aura.SetUsingCharges(charges > 0);
        return *this;
    }

    ProcTestContext& WithActorAsPlayer(bool isPlayer = true)
    {
        _actor.SetIsPlayer(isPlayer);
        return *this;
    }

    ProcTestContext& WithDamage(uint32_t damage, uint32_t schoolMask = 1)
    {
        _damageInfo.SetDamage(damage);
        _damageInfo.SetOriginalDamage(damage);
        _damageInfo.SetSchoolMask(schoolMask);
        return *this;
    }

    ProcTestContext& WithHeal(uint32_t heal, uint32_t effectiveHeal = 0)
    {
        _healInfo.SetHeal(heal);
        _healInfo.SetEffectiveHeal(effectiveHeal > 0 ? effectiveHeal : heal);
        return *this;
    }

    ProcTestContext& WithCriticalHit()
    {
        _damageInfo.SetHitMask(PROC_HIT_CRITICAL);
        _healInfo.SetHitMask(PROC_HIT_CRITICAL);
        return *this;
    }

    ProcTestContext& WithNormalHit()
    {
        _damageInfo.SetHitMask(PROC_HIT_NORMAL);
        _healInfo.SetHitMask(PROC_HIT_NORMAL);
        return *this;
    }

private:
    UnitStub _actor;
    UnitStub _target;
    AuraStub _aura;
    DamageInfoStub _damageInfo;
    HealInfoStub _healInfo;
};

/**
 * @brief Base fixture for AuraScript proc testing
 *
 * This provides infrastructure for testing proc behavior at the unit level
 * without requiring full game objects.
 */
class AuraScriptProcTestFixture : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _context = std::make_unique<ProcTestContext>();
        _spellInfos.clear();
    }

    void TearDown() override
    {
        for (auto* spellInfo : _spellInfos)
        {
            delete spellInfo;
        }
        _spellInfos.clear();
    }

    // Access the test context
    ProcTestContext& Context() { return *_context; }

    // Create and track a test SpellInfo
    SpellInfo* CreateSpellInfo(uint32_t id, uint32_t familyName = 0,
                               uint32_t familyFlags0 = 0, uint32_t familyFlags1 = 0,
                               uint32_t familyFlags2 = 0)
    {
        auto* spellInfo = SpellInfoBuilder()
            .WithId(id)
            .WithSpellFamilyName(familyName)
            .WithSpellFamilyFlags(familyFlags0, familyFlags1, familyFlags2)
            .Build();
        _spellInfos.push_back(spellInfo);
        return spellInfo;
    }

    // Create a test SpellProcEntry
    SpellProcEntry CreateProcEntry()
    {
        return SpellProcEntryBuilder().Build();
    }

    // Create a test ProcEventInfo
    ProcEventInfo CreateEventInfo(uint32_t typeMask, uint32_t hitMask,
                                  uint32_t spellTypeMask = PROC_SPELL_TYPE_MASK_ALL,
                                  uint32_t spellPhaseMask = PROC_SPELL_PHASE_HIT)
    {
        return ProcEventInfoBuilder()
            .WithTypeMask(typeMask)
            .WithHitMask(hitMask)
            .WithSpellTypeMask(spellTypeMask)
            .WithSpellPhaseMask(spellPhaseMask)
            .Build();
    }

    // Test if a proc entry would trigger with given event info
    bool TestCanProc(SpellProcEntry const& procEntry, uint32_t typeMask,
                     uint32_t hitMask, SpellInfo const* triggerSpell = nullptr)
    {
        DamageInfo* damageInfoPtr = nullptr;
        HealInfo* healInfoPtr = nullptr;

        // Create real DamageInfo/HealInfo if we have a trigger spell
        // Note: This requires the actual game classes, which may need adjustment
        // For now, we use the stub approach

        auto eventInfo = ProcEventInfoBuilder()
            .WithTypeMask(typeMask)
            .WithHitMask(hitMask)
            .WithSpellTypeMask(PROC_SPELL_TYPE_MASK_ALL)
            .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
            .Build();

        return sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo);
    }

    // Check if spell family matches
    bool TestSpellFamilyMatch(uint32_t procFamilyName, flag96 const& procFamilyMask,
                              SpellInfo const* triggerSpell)
    {
        if (procFamilyName && triggerSpell)
        {
            if (procFamilyName != triggerSpell->SpellFamilyName)
                return false;

            if (procFamilyMask)
            {
                flag96 triggerMask;
                triggerMask[0] = triggerSpell->SpellFamilyFlags[0];
                triggerMask[1] = triggerSpell->SpellFamilyFlags[1];
                triggerMask[2] = triggerSpell->SpellFamilyFlags[2];

                if (!(triggerMask & procFamilyMask))
                    return false;
            }
        }
        return true;
    }

private:
    std::unique_ptr<ProcTestContext> _context;
    std::vector<SpellInfo*> _spellInfos;
};

/**
 * @brief Helper class for testing specific proc scenarios
 *
 * Uses shared_ptr for resource management to allow safe copying
 * in fluent builder pattern usage.
 */
class ProcScenarioBuilder
{
public:
    ProcScenarioBuilder()
    {
        // Create a default SpellInfo for spell-type procs using shared_ptr
        _defaultSpellInfo = std::shared_ptr<SpellInfo>(
            SpellInfoBuilder()
                .WithId(99999)
                .WithSpellFamilyName(0)
                .Build()
        );
    }

    ~ProcScenarioBuilder() = default;

    // Configure the triggering action
    ProcScenarioBuilder& OnMeleeAutoAttack()
    {
        _typeMask = PROC_FLAG_DONE_MELEE_AUTO_ATTACK;
        _needsSpellInfo = false;
        return *this;
    }

    ProcScenarioBuilder& OnTakenMeleeAutoAttack()
    {
        _typeMask = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
        _needsSpellInfo = false;
        return *this;
    }

    ProcScenarioBuilder& OnSpellDamage()
    {
        _typeMask = PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG;
        _spellTypeMask = PROC_SPELL_TYPE_DAMAGE;
        _needsSpellInfo = true;
        _usesDamageInfo = true;
        return *this;
    }

    ProcScenarioBuilder& OnTakenSpellDamage()
    {
        _typeMask = PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG;
        _spellTypeMask = PROC_SPELL_TYPE_DAMAGE;
        _needsSpellInfo = true;
        _usesDamageInfo = true;
        return *this;
    }

    ProcScenarioBuilder& OnHeal()
    {
        _typeMask = PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS;
        _spellTypeMask = PROC_SPELL_TYPE_HEAL;
        _needsSpellInfo = true;
        _usesHealInfo = true;
        return *this;
    }

    ProcScenarioBuilder& OnTakenHeal()
    {
        _typeMask = PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_POS;
        _spellTypeMask = PROC_SPELL_TYPE_HEAL;
        _needsSpellInfo = true;
        _usesHealInfo = true;
        return *this;
    }

    ProcScenarioBuilder& OnPeriodicDamage()
    {
        _typeMask = PROC_FLAG_DONE_PERIODIC;
        _spellTypeMask = PROC_SPELL_TYPE_DAMAGE;
        _needsSpellInfo = true;
        _usesDamageInfo = true;
        return *this;
    }

    ProcScenarioBuilder& OnPeriodicHeal()
    {
        _typeMask = PROC_FLAG_DONE_PERIODIC;
        _spellTypeMask = PROC_SPELL_TYPE_HEAL;
        _needsSpellInfo = true;
        _usesHealInfo = true;
        return *this;
    }

    ProcScenarioBuilder& OnKill()
    {
        _typeMask = PROC_FLAG_KILL;
        _needsSpellInfo = false;
        return *this;
    }

    ProcScenarioBuilder& OnDeath()
    {
        _typeMask = PROC_FLAG_DEATH;
        _needsSpellInfo = false;
        return *this;
    }

    // Configure hit result
    ProcScenarioBuilder& WithCrit()
    {
        _hitMask = PROC_HIT_CRITICAL;
        return *this;
    }

    ProcScenarioBuilder& WithNormalHit()
    {
        _hitMask = PROC_HIT_NORMAL;
        return *this;
    }

    ProcScenarioBuilder& WithMiss()
    {
        _hitMask = PROC_HIT_MISS;
        return *this;
    }

    ProcScenarioBuilder& WithDodge()
    {
        _hitMask = PROC_HIT_DODGE;
        return *this;
    }

    ProcScenarioBuilder& WithParry()
    {
        _hitMask = PROC_HIT_PARRY;
        return *this;
    }

    ProcScenarioBuilder& WithBlock()
    {
        _hitMask = PROC_HIT_BLOCK;
        return *this;
    }

    ProcScenarioBuilder& WithFullBlock()
    {
        _hitMask = PROC_HIT_FULL_BLOCK;
        return *this;
    }

    ProcScenarioBuilder& WithAbsorb()
    {
        _hitMask = PROC_HIT_ABSORB;
        return *this;
    }

    // Note: PROC_HIT_ABSORB covers both partial and full absorb
    // There is no separate PROC_HIT_FULL_ABSORB flag in AzerothCore

    // Configure spell phase
    ProcScenarioBuilder& OnCast()
    {
        _spellPhaseMask = PROC_SPELL_PHASE_CAST;
        return *this;
    }

    ProcScenarioBuilder& OnHit()
    {
        _spellPhaseMask = PROC_SPELL_PHASE_HIT;
        return *this;
    }

    ProcScenarioBuilder& OnFinish()
    {
        _spellPhaseMask = PROC_SPELL_PHASE_FINISH;
        return *this;
    }

    // Build the scenario into a ProcEventInfo
    ProcEventInfo Build()
    {
        auto builder = ProcEventInfoBuilder()
            .WithTypeMask(_typeMask)
            .WithHitMask(_hitMask)
            .WithSpellTypeMask(_spellTypeMask)
            .WithSpellPhaseMask(_spellPhaseMask);

        // Create DamageInfo or HealInfo with SpellInfo for spell-type procs
        if (_needsSpellInfo)
        {
            if (_usesDamageInfo)
            {
                // Create new DamageInfo if needed
                if (!_damageInfo)
                    _damageInfo = std::make_shared<DamageInfo>(nullptr, nullptr, 100, _defaultSpellInfo.get(), SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);
                builder.WithDamageInfo(_damageInfo.get());
            }
            else if (_usesHealInfo)
            {
                // Create new HealInfo if needed
                if (!_healInfo)
                    _healInfo = std::make_shared<HealInfo>(nullptr, nullptr, 100, _defaultSpellInfo.get(), SPELL_SCHOOL_MASK_HOLY);
                builder.WithHealInfo(_healInfo.get());
            }
        }

        return builder.Build();
    }

    // Get individual values
    [[nodiscard]] uint32_t GetTypeMask() const { return _typeMask; }
    [[nodiscard]] uint32_t GetHitMask() const { return _hitMask; }
    [[nodiscard]] uint32_t GetSpellTypeMask() const { return _spellTypeMask; }
    [[nodiscard]] uint32_t GetSpellPhaseMask() const { return _spellPhaseMask; }

private:
    uint32_t _typeMask = 0;
    uint32_t _hitMask = PROC_HIT_NORMAL;
    uint32_t _spellTypeMask = PROC_SPELL_TYPE_MASK_ALL;
    uint32_t _spellPhaseMask = PROC_SPELL_PHASE_HIT;
    bool _needsSpellInfo = false;
    bool _usesDamageInfo = false;
    bool _usesHealInfo = false;
    std::shared_ptr<SpellInfo> _defaultSpellInfo;
    std::shared_ptr<DamageInfo> _damageInfo;
    std::shared_ptr<HealInfo> _healInfo;
};

// Convenience macros for proc testing
#define EXPECT_PROC_TRIGGERS(procEntry, scenario) \
    do { \
        auto _eventInfo = (scenario).Build(); \
        EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, _eventInfo)); \
    } while(0)

#define EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, scenario) \
    do { \
        auto _eventInfo = (scenario).Build(); \
        EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, _eventInfo)); \
    } while(0)

#endif //AZEROTHCORE_AURA_SCRIPT_TEST_FRAMEWORK_H
