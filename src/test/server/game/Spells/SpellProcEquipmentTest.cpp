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

/**
 * @file SpellProcEquipmentTest.cpp
 * @brief Unit tests for equipment requirement validation in proc system
 *
 * Tests the logic from SpellAuras.cpp:2260-2298:
 * - Weapon class requirement validation
 * - Armor class requirement validation
 * - Attack type to slot mapping
 * - Feral form blocking weapon procs
 * - Broken item blocking procs
 * - SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT bypass
 * - Item subclass mask validation
 *
 * ============================================================================
 * TEST DESIGN: Configuration-Based Testing
 * ============================================================================
 *
 * These tests use EquipmentConfig structs to simulate different equipment
 * scenarios without requiring actual game objects. Each test configures:
 * - isPassive: Whether the aura is passive (equipment check only applies to passive)
 * - isPlayer: Whether the target is a player (NPCs skip equipment checks)
 * - equippedItemClass: ITEM_CLASS_WEAPON, ITEM_CLASS_ARMOR, or ITEM_CLASS_ANY
 * - hasEquippedItem: Whether the required item slot has an item
 * - itemIsBroken: Whether the equipped item is broken (0 durability)
 * - itemFitsRequirements: Whether the item matches subclass mask requirements
 * - isInFeralForm: Whether a druid is in cat/bear form (blocks weapon procs)
 * - hasNoEquipRequirementAttr: SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT bypass
 *
 * No GTEST_SKIP() is used in this file - all tests run with their configured
 * scenarios, testing both positive and negative cases explicitly.
 * ============================================================================
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcEquipmentTest : public ::testing::Test
{
protected:
    void SetUp() override {}

    // Create default config for weapon proc
    ProcChanceTestHelper::EquipmentConfig CreateWeaponProcConfig()
    {
        ProcChanceTestHelper::EquipmentConfig config;
        config.isPassive = true;
        config.isPlayer = true;
        config.equippedItemClass = ProcChanceTestHelper::ITEM_CLASS_WEAPON;
        config.hasEquippedItem = true;
        config.itemIsBroken = false;
        config.itemFitsRequirements = true;
        return config;
    }

    // Create default config for armor proc
    ProcChanceTestHelper::EquipmentConfig CreateArmorProcConfig()
    {
        ProcChanceTestHelper::EquipmentConfig config;
        config.isPassive = true;
        config.isPlayer = true;
        config.equippedItemClass = ProcChanceTestHelper::ITEM_CLASS_ARMOR;
        config.hasEquippedItem = true;
        config.itemIsBroken = false;
        config.itemFitsRequirements = true;
        return config;
    }
};

// =============================================================================
// No Equipment Requirement Tests
// =============================================================================

TEST_F(SpellProcEquipmentTest, NoEquipRequirement_AllowsProc)
{
    ProcChanceTestHelper::EquipmentConfig config;
    config.isPassive = true;
    config.isPlayer = true;
    config.equippedItemClass = ProcChanceTestHelper::ITEM_CLASS_ANY;  // No requirement

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "No equipment requirement should allow proc";
}

TEST_F(SpellProcEquipmentTest, NonPassiveAura_SkipsCheck)
{
    ProcChanceTestHelper::EquipmentConfig config;
    config.isPassive = false;  // Not a passive aura
    config.isPlayer = true;
    config.equippedItemClass = ProcChanceTestHelper::ITEM_CLASS_WEAPON;
    config.hasEquippedItem = false;  // Would normally block

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Non-passive aura should skip equipment check";
}

TEST_F(SpellProcEquipmentTest, NonPlayerTarget_SkipsCheck)
{
    ProcChanceTestHelper::EquipmentConfig config;
    config.isPassive = true;
    config.isPlayer = false;  // NPC/creature
    config.equippedItemClass = ProcChanceTestHelper::ITEM_CLASS_WEAPON;
    config.hasEquippedItem = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Non-player target should skip equipment check";
}

// =============================================================================
// Weapon Class Requirement Tests
// =============================================================================

TEST_F(SpellProcEquipmentTest, WeaponRequired_WithWeapon_AllowsProc)
{
    auto config = CreateWeaponProcConfig();

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Weapon requirement met should allow proc";
}

TEST_F(SpellProcEquipmentTest, WeaponRequired_NoWeapon_BlocksProc)
{
    auto config = CreateWeaponProcConfig();
    config.hasEquippedItem = false;  // No weapon equipped

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Missing weapon should block proc";
}

TEST_F(SpellProcEquipmentTest, WeaponRequired_BrokenWeapon_BlocksProc)
{
    auto config = CreateWeaponProcConfig();
    config.itemIsBroken = true;  // Weapon is broken

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Broken weapon should block proc";
}

TEST_F(SpellProcEquipmentTest, WeaponRequired_WrongSubclass_BlocksProc)
{
    auto config = CreateWeaponProcConfig();
    config.itemFitsRequirements = false;  // Wrong weapon type

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Wrong weapon subclass should block proc";
}

// =============================================================================
// Armor Class Requirement Tests
// =============================================================================

TEST_F(SpellProcEquipmentTest, ArmorRequired_WithArmor_AllowsProc)
{
    auto config = CreateArmorProcConfig();

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Armor requirement met should allow proc";
}

TEST_F(SpellProcEquipmentTest, ArmorRequired_NoArmor_BlocksProc)
{
    auto config = CreateArmorProcConfig();
    config.hasEquippedItem = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Missing armor should block proc";
}

TEST_F(SpellProcEquipmentTest, ArmorRequired_BrokenArmor_BlocksProc)
{
    auto config = CreateArmorProcConfig();
    config.itemIsBroken = true;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Broken armor should block proc";
}

// =============================================================================
// Feral Form Tests - SpellAuras.cpp:2266-2267
// =============================================================================

TEST_F(SpellProcEquipmentTest, FeralForm_WeaponProc_BlocksProc)
{
    auto config = CreateWeaponProcConfig();
    config.isInFeralForm = true;  // Druid in cat/bear form

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Feral form should block weapon procs";
}

TEST_F(SpellProcEquipmentTest, FeralForm_ArmorProc_AllowsProc)
{
    auto config = CreateArmorProcConfig();
    config.isInFeralForm = true;  // Druid in cat/bear form

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Feral form should NOT block armor procs";
}

TEST_F(SpellProcEquipmentTest, NotInFeralForm_WeaponProc_AllowsProc)
{
    auto config = CreateWeaponProcConfig();
    config.isInFeralForm = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Non-feral form should allow weapon procs";
}

// =============================================================================
// SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT Bypass Tests
// =============================================================================

TEST_F(SpellProcEquipmentTest, NoEquipRequirementAttr_BypassesMissingItem)
{
    auto config = CreateWeaponProcConfig();
    config.hasEquippedItem = false;  // Would normally block
    config.hasNoEquipRequirementAttr = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "NO_PROC_EQUIP_REQUIREMENT should bypass missing item check";
}

TEST_F(SpellProcEquipmentTest, NoEquipRequirementAttr_BypassesBrokenItem)
{
    auto config = CreateWeaponProcConfig();
    config.itemIsBroken = true;  // Would normally block
    config.hasNoEquipRequirementAttr = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "NO_PROC_EQUIP_REQUIREMENT should bypass broken item check";
}

TEST_F(SpellProcEquipmentTest, NoEquipRequirementAttr_BypassesFeralForm)
{
    auto config = CreateWeaponProcConfig();
    config.isInFeralForm = true;  // Would normally block
    config.hasNoEquipRequirementAttr = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "NO_PROC_EQUIP_REQUIREMENT should bypass feral form check";
}

// =============================================================================
// Attack Type to Slot Mapping Tests - SpellAuras.cpp:2268-2284
// =============================================================================

TEST_F(SpellProcEquipmentTest, SlotMapping_BaseAttack_MainHand)
{
    uint8 slot = ProcChanceTestHelper::GetWeaponSlotForAttackType(ProcChanceTestHelper::BASE_ATTACK);
    EXPECT_EQ(slot, 15)  // EQUIPMENT_SLOT_MAINHAND
        << "BASE_ATTACK should map to main hand slot";
}

TEST_F(SpellProcEquipmentTest, SlotMapping_OffAttack_OffHand)
{
    uint8 slot = ProcChanceTestHelper::GetWeaponSlotForAttackType(ProcChanceTestHelper::OFF_ATTACK);
    EXPECT_EQ(slot, 16)  // EQUIPMENT_SLOT_OFFHAND
        << "OFF_ATTACK should map to off hand slot";
}

TEST_F(SpellProcEquipmentTest, SlotMapping_RangedAttack_Ranged)
{
    uint8 slot = ProcChanceTestHelper::GetWeaponSlotForAttackType(ProcChanceTestHelper::RANGED_ATTACK);
    EXPECT_EQ(slot, 17)  // EQUIPMENT_SLOT_RANGED
        << "RANGED_ATTACK should map to ranged slot";
}

TEST_F(SpellProcEquipmentTest, SlotMapping_InvalidAttack_DefaultsToMainHand)
{
    uint8 slot = ProcChanceTestHelper::GetWeaponSlotForAttackType(255);  // Invalid
    EXPECT_EQ(slot, 15)  // EQUIPMENT_SLOT_MAINHAND
        << "Invalid attack type should default to main hand";
}

// =============================================================================
// Real Spell Scenarios
// =============================================================================

TEST_F(SpellProcEquipmentTest, Scenario_WeaponEnchant_Fiery)
{
    // Fiery Weapon enchant - requires melee weapon
    auto config = CreateWeaponProcConfig();
    config.attackType = ProcChanceTestHelper::BASE_ATTACK;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Fiery Weapon with main hand should proc";
}

TEST_F(SpellProcEquipmentTest, Scenario_WeaponEnchant_FieryOffhand)
{
    // Fiery Weapon on off-hand
    auto config = CreateWeaponProcConfig();
    config.attackType = ProcChanceTestHelper::OFF_ATTACK;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Fiery Weapon with off hand should proc";
}

TEST_F(SpellProcEquipmentTest, Scenario_Hunter_RangedProc)
{
    // Hunter ranged weapon proc
    auto config = CreateWeaponProcConfig();
    config.attackType = ProcChanceTestHelper::RANGED_ATTACK;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Ranged proc with ranged weapon should work";
}

TEST_F(SpellProcEquipmentTest, Scenario_FeralDruid_WeaponEnchant)
{
    // Druid with weapon enchant enters cat form
    auto config = CreateWeaponProcConfig();
    config.isInFeralForm = true;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Feral druid weapon enchant should be blocked";
}

TEST_F(SpellProcEquipmentTest, Scenario_BrokenWeapon_CombatUse)
{
    // Player's weapon breaks during combat
    auto config = CreateWeaponProcConfig();
    config.itemIsBroken = true;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Broken weapon procs should be blocked";
}

TEST_F(SpellProcEquipmentTest, Scenario_WrongWeaponType)
{
    // Enchant requires sword but player has mace
    auto config = CreateWeaponProcConfig();
    config.itemFitsRequirements = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Wrong weapon type should block proc";
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(SpellProcEquipmentTest, EdgeCase_AllConditionsMet)
{
    auto config = CreateWeaponProcConfig();
    // All requirements met
    config.isPassive = true;
    config.isPlayer = true;
    config.hasEquippedItem = true;
    config.itemIsBroken = false;
    config.itemFitsRequirements = true;
    config.isInFeralForm = false;
    config.hasNoEquipRequirementAttr = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "All conditions met should allow proc";
}

TEST_F(SpellProcEquipmentTest, EdgeCase_AllBlockingConditions)
{
    auto config = CreateWeaponProcConfig();
    // Multiple blocking conditions
    config.hasEquippedItem = false;
    config.itemIsBroken = true;
    config.itemFitsRequirements = false;
    config.isInFeralForm = true;

    // Should be blocked (first check that fails)
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Multiple blocking conditions should still block";
}

TEST_F(SpellProcEquipmentTest, EdgeCase_BypassOverridesAll)
{
    auto config = CreateWeaponProcConfig();
    // Multiple blocking conditions BUT bypass is set
    config.hasEquippedItem = false;
    config.itemIsBroken = true;
    config.itemFitsRequirements = false;
    config.isInFeralForm = true;
    config.hasNoEquipRequirementAttr = true;  // Bypass

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToEquipment(config))
        << "Bypass attribute should override all blocking conditions";
}
