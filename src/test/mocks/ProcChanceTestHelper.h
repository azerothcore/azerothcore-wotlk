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

#ifndef AZEROTHCORE_PROC_CHANCE_TEST_HELPER_H
#define AZEROTHCORE_PROC_CHANCE_TEST_HELPER_H

#include "SpellMgr.h"
#include "SpellInfo.h"
#include "AuraStub.h"
#include "UnitStub.h"
#include <algorithm>
#include <chrono>

/**
 * @brief Helper class for testing proc chance calculations
 *
 * Provides standalone implementations of proc-related calculations
 * that can be tested without requiring full game objects.
 */
class ProcChanceTestHelper
{
public:
    /**
     * @brief Calculate PPM proc chance
     * Implements the formula: (WeaponSpeed * PPM) / 600.0f
     *
     * @param weaponSpeed Weapon attack speed in milliseconds
     * @param ppm Procs per minute value
     * @param ppmModifier Additional PPM modifier (from talents/auras)
     * @return Proc chance as percentage (0-100+)
     */
    static float CalculatePPMChance(uint32 weaponSpeed, float ppm, float ppmModifier = 0.0f)
    {
        if (ppm <= 0.0f)
            return 0.0f;

        float modifiedPPM = ppm + ppmModifier;
        return (static_cast<float>(weaponSpeed) * modifiedPPM) / 600.0f;
    }

    /**
     * @brief Calculate level 60+ reduction
     * Implements PROC_ATTR_REDUCE_PROC_60: 3.333% reduction per level above 60
     *
     * @param baseChance Base proc chance
     * @param actorLevel Actor's level
     * @return Reduced proc chance
     */
    static float ApplyLevel60Reduction(float baseChance, uint32 actorLevel)
    {
        if (actorLevel <= 60)
            return baseChance;

        // Reduction = (level - 60) / 30, capped at 1.0
        float reduction = static_cast<float>(actorLevel - 60) / 30.0f;
        return std::max(0.0f, (1.0f - reduction) * baseChance);
    }

    /**
     * @brief Simulate CalcProcChance() from SpellAuras.cpp
     *
     * @param procEntry The proc configuration
     * @param actorLevel Actor's level (for PROC_ATTR_REDUCE_PROC_60)
     * @param weaponSpeed Weapon speed (for PPM calculation)
     * @param chanceModifier Talent/aura modifier to chance
     * @param ppmModifier Talent/aura modifier to PPM
     * @param hasDamageInfo Whether a DamageInfo is present (enables PPM)
     * @param hasHealInfo Whether a HealInfo is present (also enables PPM)
     * @return Calculated proc chance
     */
    static float SimulateCalcProcChance(
        SpellProcEntry const& procEntry,
        uint32 actorLevel = 80,
        uint32 weaponSpeed = 2500,
        float chanceModifier = 0.0f,
        float ppmModifier = 0.0f,
        bool hasDamageInfo = true,
        bool hasHealInfo = false)
    {
        float chance = procEntry.Chance;

        // PPM calculation overrides base chance if PPM > 0 and we have DamageInfo or HealInfo
        if ((hasDamageInfo || hasHealInfo) && procEntry.ProcsPerMinute > 0.0f)
        {
            chance = CalculatePPMChance(weaponSpeed, procEntry.ProcsPerMinute, ppmModifier);
        }

        // Apply chance modifier (SPELLMOD_CHANCE_OF_SUCCESS)
        chance += chanceModifier;

        // Apply level 60+ reduction if attribute is set
        if (procEntry.AttributesMask & PROC_ATTR_REDUCE_PROC_60)
        {
            chance = ApplyLevel60Reduction(chance, actorLevel);
        }

        return chance;
    }

    /**
     * @brief Simulate charge consumption from ConsumeProcCharges()
     *
     * @param aura The aura stub to modify
     * @param procEntry The proc configuration
     * @return true if aura was removed (charges/stacks exhausted)
     */
    static bool SimulateConsumeProcCharges(AuraStub* aura, SpellProcEntry const& procEntry)
    {
        if (!aura)
            return false;

        if (procEntry.AttributesMask & PROC_ATTR_USE_STACKS_FOR_CHARGES)
        {
            return aura->ModStackAmount(-1);
        }
        else if (aura->IsUsingCharges())
        {
            aura->DropCharge();
            if (aura->GetCharges() == 0)
            {
                aura->Remove();
                return true;
            }
        }
        return false;
    }

    /**
     * @brief Check if proc is on cooldown
     *
     * @param aura The aura stub
     * @param now Current time point
     * @return true if proc is blocked by cooldown
     */
    static bool IsProcOnCooldown(AuraStub const* aura, std::chrono::steady_clock::time_point now)
    {
        if (!aura)
            return false;
        return aura->IsProcOnCooldown(now);
    }

    /**
     * @brief Apply proc cooldown to aura
     *
     * @param aura The aura stub
     * @param now Current time point
     * @param cooldownMs Cooldown duration in milliseconds
     */
    static void ApplyProcCooldown(AuraStub* aura, std::chrono::steady_clock::time_point now, uint32 cooldownMs)
    {
        if (!aura || cooldownMs == 0)
            return;
        aura->AddProcCooldown(now + std::chrono::milliseconds(cooldownMs));
    }

    /**
     * @brief Check if spell has mana cost (for PROC_ATTR_REQ_MANA_COST)
     *
     * @param spellInfo The spell info to check
     * @return true if spell has mana cost > 0
     */
    static bool SpellHasManaCost(SpellInfo const* spellInfo)
    {
        if (!spellInfo)
            return false;
        return spellInfo->ManaCost > 0 || spellInfo->ManaCostPercentage > 0;
    }

    /**
     * @brief Get common weapon speeds for testing
     */
    static constexpr uint32 WEAPON_SPEED_FAST_DAGGER = 1400;   // 1.4 sec
    static constexpr uint32 WEAPON_SPEED_NORMAL_SWORD = 2500;  // 2.5 sec
    static constexpr uint32 WEAPON_SPEED_SLOW_2H = 3300;       // 3.3 sec
    static constexpr uint32 WEAPON_SPEED_VERY_SLOW = 3800;     // 3.8 sec
    static constexpr uint32 WEAPON_SPEED_STAFF = 3600;         // 3.6 sec (common feral staff)

    /**
     * @brief Shapeshift form base attack speeds (from SpellShapeshiftForm.dbc)
     */
    static constexpr uint32 FORM_SPEED_CAT = 1000;             // Cat Form: 1.0 sec
    static constexpr uint32 FORM_SPEED_BEAR = 2500;            // Bear/Dire Bear: 2.5 sec

    /**
     * @brief Simulate effective procs per minute
     *
     * Given a per-swing chance and the actual swing interval, calculate
     * how many procs occur per minute on average.
     *
     * @param chancePerSwing Proc chance per swing (0-100+)
     * @param actualSwingSpeedMs Actual time between swings in milliseconds
     * @return Average procs per minute
     */
    static float CalculateEffectivePPM(float chancePerSwing, uint32 actualSwingSpeedMs)
    {
        if (actualSwingSpeedMs == 0)
            return 0.0f;
        float swingsPerMinute = 60000.0f / static_cast<float>(actualSwingSpeedMs);
        return swingsPerMinute * (chancePerSwing / 100.0f);
    }

    /**
     * @brief Common PPM values from spell_proc database
     */
    static constexpr float PPM_OMEN_OF_CLARITY = 6.0f;
    static constexpr float PPM_JUDGEMENT_OF_LIGHT = 15.0f;
    static constexpr float PPM_WINDFURY_WEAPON = 2.0f;

    // =============================================================================
    // Triggered Spell Filtering - simulates SpellAuras.cpp:2191-2209
    // =============================================================================

    /**
     * @brief Auto-attack proc flag mask (hunter auto-shot, wands exception)
     * These triggered spells are allowed to proc without TRIGGERED_CAN_PROC
     */
    static constexpr uint32 AUTO_ATTACK_PROC_FLAG_MASK =
        PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK |
        PROC_FLAG_DONE_RANGED_AUTO_ATTACK | PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK;

    /**
     * @brief Configuration for simulating triggered spell filtering
     */
    struct TriggeredSpellConfig
    {
        bool isTriggered = false;               // Spell::IsTriggered()
        bool auraHasCanProcFromProcs = false;   // SPELL_ATTR3_CAN_PROC_FROM_PROCS on proc aura
        bool spellHasNotAProc = false;          // SPELL_ATTR3_NOT_A_PROC on triggering spell
        uint32 triggeredByAuraSpellId = 0;      // GetTriggeredByAuraSpellInfo()->Id
        uint32 procAuraSpellId = 0;             // The aura's spell ID (for self-loop check)
    };

    /**
     * @brief Simulate triggered spell filtering
     * Implements the self-loop prevention and triggered spell blocking from SpellAuras.cpp
     *
     * @param config Configuration for the triggered spell
     * @param procEntry The proc entry being checked
     * @param eventTypeMask The event type mask from ProcEventInfo
     * @return true if proc should be blocked (return 0), false if allowed
     */
    static bool ShouldBlockTriggeredSpell(
        TriggeredSpellConfig const& config,
        SpellProcEntry const& procEntry,
        uint32 eventTypeMask)
    {
        // Self-loop prevention: block if triggered by the same aura
        // SpellAuras.cpp:2191-2192
        if (config.triggeredByAuraSpellId != 0 &&
            config.triggeredByAuraSpellId == config.procAuraSpellId)
        {
            return true; // Block: self-loop detected
        }

        // Check if triggered spell filtering applies
        // SpellAuras.cpp:2195-2208
        if (!config.auraHasCanProcFromProcs &&
            !(procEntry.AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC) &&
            !(eventTypeMask & AUTO_ATTACK_PROC_FLAG_MASK))
        {
            // Filter triggered spells unless they have NOT_A_PROC
            if (config.isTriggered && !config.spellHasNotAProc)
            {
                return true; // Block: triggered spell without exceptions
            }
        }

        return false; // Allow proc
    }

    // =============================================================================
    // Extra Attack Chain-Proc Prevention - simulates SpellAuraEffects.cpp:1245-1261
    // =============================================================================

    /**
     * @brief Configuration for simulating extra attack chain-proc prevention
     */
    struct ExtraAttackProcConfig
    {
        bool triggeredSpellHasExtraAttacks = false; // triggeredSpellInfo->HasEffect(SPELL_EFFECT_ADD_EXTRA_ATTACKS)
        uint32 triggerSpellId = 0;                  // m_spellInfo->Effects[GetEffIndex()].TriggerSpell
        uint32 lastExtraAttackSpell = 0;            // eventInfo.GetActor()->GetLastExtraAttackSpell()
    };

    /**
     * @brief Simulate extra attack chain-proc prevention from CheckEffectProc
     * Returns true if proc should be blocked
     *
     * @param config Extra attack proc configuration
     * @return true if proc should be blocked
     */
    static bool ShouldBlockExtraAttackChainProc(ExtraAttackProcConfig const& config)
    {
        // Only applies when the triggered spell grants extra attacks
        if (!config.triggeredSpellHasExtraAttacks)
            return false;

        // Patch 1.12.0(?) extra attack abilities can no longer chain proc themselves
        if (config.lastExtraAttackSpell == config.triggerSpellId)
            return true;

        // Patch 2.2.0 Sword Specialization (Warrior, Rogue) extra attack can no longer proc additional extra attacks
        // 3.3.5 Sword Specialization (Warrior), Hack and Slash (Rogue)
        if (config.lastExtraAttackSpell == 16459 || config.lastExtraAttackSpell == 66923)
            return true;

        return false;
    }

    // =============================================================================
    // DisableEffectsMask - simulates SpellAuras.cpp:2244-2258
    // =============================================================================

    /**
     * @brief Apply DisableEffectsMask to get final proc effect mask
     *
     * @param initialMask Initial effect mask (usually 0x07 for all 3 effects)
     * @param disableEffectsMask Mask of effects to disable
     * @return Resulting effect mask after applying disable mask
     */
    static uint8 ApplyDisableEffectsMask(uint8 initialMask, uint32 disableEffectsMask)
    {
        uint8 result = initialMask;
        for (uint8 i = 0; i < 3; ++i)
        {
            if (disableEffectsMask & (1u << i))
                result &= ~(1 << i);
        }
        return result;
    }

    /**
     * @brief Check if proc should be blocked due to all effects being disabled
     *
     * @param initialMask Initial effect mask
     * @param disableEffectsMask Mask of effects to disable
     * @return true if all effects disabled (proc blocked), false otherwise
     */
    static bool ShouldBlockDueToDisabledEffects(uint8 initialMask, uint32 disableEffectsMask)
    {
        return ApplyDisableEffectsMask(initialMask, disableEffectsMask) == 0;
    }

    // =============================================================================
    // PPM Modifier Simulation - simulates Unit.cpp:10378-10390
    // =============================================================================

    /**
     * @brief PPM modifier configuration for testing SPELLMOD_PROC_PER_MINUTE
     */
    struct PPMModifierConfig
    {
        float flatModifier = 0.0f;    // Additive PPM modifier
        float pctModifier = 1.0f;     // Multiplicative PPM modifier (1.0 = no change)
        bool hasSpellModOwner = true; // Whether GetSpellModOwner() returns valid player
        bool hasSpellProto = true;    // Whether spellProto is provided
    };

    /**
     * @brief Calculate PPM chance with spell modifiers
     * Simulates GetPPMProcChance() with SPELLMOD_PROC_PER_MINUTE
     */
    static float CalculatePPMChanceWithModifiers(
        uint32 weaponSpeed,
        float basePPM,
        PPMModifierConfig const& modConfig)
    {
        if (basePPM <= 0.0f)
            return 0.0f;

        float ppm = basePPM;

        // Apply modifiers only if we have spell proto and spell mod owner
        if (modConfig.hasSpellProto && modConfig.hasSpellModOwner)
        {
            // Apply flat modifier first (SPELLMOD_FLAT)
            ppm += modConfig.flatModifier;
            // Apply percent modifier (SPELLMOD_PCT)
            ppm *= modConfig.pctModifier;
        }

        return (static_cast<float>(weaponSpeed) * ppm) / 600.0f;
    }

    // =============================================================================
    // Equipment Requirements - simulates SpellAuras.cpp:2260-2298
    // =============================================================================

    /**
     * @brief Item classes for equipment requirement checking
     */
    static constexpr int32 ITEM_CLASS_WEAPON = 2;
    static constexpr int32 ITEM_CLASS_ARMOR = 4;
    static constexpr int32 ITEM_CLASS_ANY = -1;  // No requirement

    /**
     * @brief Attack types for weapon slot mapping
     */
    static constexpr uint8 BASE_ATTACK = 0;
    static constexpr uint8 OFF_ATTACK = 1;
    static constexpr uint8 RANGED_ATTACK = 2;

    /**
     * @brief Configuration for simulating equipment requirements
     */
    struct EquipmentConfig
    {
        bool isPassive = true;                // Aura::IsPassive()
        bool isPlayer = true;                 // Target is player
        int32 equippedItemClass = ITEM_CLASS_ANY;  // SpellInfo::EquippedItemClass
        int32 equippedItemSubClassMask = 0;   // SpellInfo::EquippedItemSubClassMask
        bool hasNoEquipRequirementAttr = false;  // SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT
        uint8 attackType = BASE_ATTACK;       // Attack type for weapon slot mapping
        bool isInFeralForm = false;           // Player::IsInFeralForm()
        bool hasEquippedItem = true;          // Item is equipped in the slot
        bool itemIsBroken = false;            // Item::IsBroken()
        bool itemFitsRequirements = true;     // Item::IsFitToSpellRequirements()
    };

    /**
     * @brief Simulate equipment requirement check
     * Returns true if proc should be blocked due to equipment requirements
     *
     * @param config Equipment configuration
     * @return true if proc should be blocked
     */
    static bool ShouldBlockDueToEquipment(EquipmentConfig const& config)
    {
        // Only check for passive player auras with equipment requirements
        if (!config.isPassive || !config.isPlayer || config.equippedItemClass == ITEM_CLASS_ANY)
            return false;

        // SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT bypasses check
        if (config.hasNoEquipRequirementAttr)
            return false;

        // Feral form blocks weapon procs
        if (config.equippedItemClass == ITEM_CLASS_WEAPON && config.isInFeralForm)
            return true;

        // No item equipped in the required slot
        if (!config.hasEquippedItem)
            return true;

        // Item is broken
        if (config.itemIsBroken)
            return true;

        // Item doesn't fit spell requirements (wrong subclass, etc.)
        if (!config.itemFitsRequirements)
            return true;

        return false;
    }

    /**
     * @brief Get equipment slot for attack type
     *
     * @param attackType Attack type (BASE_ATTACK, OFF_ATTACK, RANGED_ATTACK)
     * @return Equipment slot index (simulated)
     */
    static uint8 GetWeaponSlotForAttackType(uint8 attackType)
    {
        switch (attackType)
        {
            case BASE_ATTACK:
                return 15;  // EQUIPMENT_SLOT_MAINHAND
            case OFF_ATTACK:
                return 16;  // EQUIPMENT_SLOT_OFFHAND
            case RANGED_ATTACK:
                return 17;  // EQUIPMENT_SLOT_RANGED
            default:
                return 15;
        }
    }

    // =============================================================================
    // Conditions System - simulates SpellAuras.cpp:2232-2236
    // =============================================================================

    /**
     * @brief Configuration for simulating conditions system
     */
    struct ConditionsConfig
    {
        bool hasConditions = false;            // ConditionMgr has conditions for this spell
        bool conditionsMet = true;             // All conditions are satisfied
        uint32 sourceType = 24;                // CONDITION_SOURCE_TYPE_SPELL_PROC
    };

    /**
     * @brief Simulate conditions check
     * Returns true if proc should be blocked due to conditions
     *
     * @param config Conditions configuration
     * @return true if proc should be blocked
     */
    static bool ShouldBlockDueToConditions(ConditionsConfig const& config)
    {
        // No conditions configured - allow proc
        if (!config.hasConditions)
            return false;

        // Check if conditions are met
        return !config.conditionsMet;
    }
};

/**
 * @brief Test context for proc simulation scenarios
 */
class ProcTestScenario
{
public:
    ProcTestScenario() : _now(std::chrono::steady_clock::now()) {}

    // Time control
    void AdvanceTime(std::chrono::milliseconds duration)
    {
        _now += duration;
    }

    std::chrono::steady_clock::time_point GetNow() const { return _now; }

    // Actor configuration
    UnitStub& GetActor() { return _actor; }
    UnitStub const& GetActor() const { return _actor; }

    ProcTestScenario& WithActorLevel(uint8_t level)
    {
        _actor.SetLevel(level);
        return *this;
    }

    ProcTestScenario& WithWeaponSpeed(uint8_t attackType, uint32_t speed)
    {
        _actor.SetAttackTime(attackType, speed);
        return *this;
    }

    // Aura configuration
    std::unique_ptr<AuraStub>& GetAura() { return _aura; }

    ProcTestScenario& WithAura(uint32_t spellId, uint8_t charges = 0, uint8_t stacks = 1)
    {
        _aura = std::make_unique<AuraStub>(spellId);
        _aura->SetCharges(charges);
        _aura->SetUsingCharges(charges > 0);
        _aura->SetStackAmount(stacks);
        return *this;
    }

    // Simulate proc and return whether it triggered
    bool SimulateProc(SpellProcEntry const& procEntry, float rollResult = 0.0f)
    {
        if (!_aura)
            return false;

        // Check cooldown
        if (ProcChanceTestHelper::IsProcOnCooldown(_aura.get(), _now))
            return false;

        // Calculate chance
        float chance = ProcChanceTestHelper::SimulateCalcProcChance(
            procEntry,
            _actor.GetLevel(),
            _actor.GetAttackTime(0));

        // Roll check (rollResult of 0 means always pass)
        if (rollResult > 0.0f && rollResult > chance)
            return false;

        // Apply cooldown if set
        if (procEntry.Cooldown.count() > 0)
        {
            ProcChanceTestHelper::ApplyProcCooldown(_aura.get(), _now,
                static_cast<uint32>(procEntry.Cooldown.count()));
        }

        // Consume charges
        ProcChanceTestHelper::SimulateConsumeProcCharges(_aura.get(), procEntry);

        return true;
    }

private:
    std::chrono::steady_clock::time_point _now;
    UnitStub _actor;
    std::unique_ptr<AuraStub> _aura;
};

#endif // AZEROTHCORE_PROC_CHANCE_TEST_HELPER_H
