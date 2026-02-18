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
 * @file SpellProcAttributeTest.cpp
 * @brief Unit tests for PROC_ATTR_* flags
 *
 * Tests all proc attribute flags:
 * - PROC_ATTR_REQ_EXP_OR_HONOR (0x01)
 * - PROC_ATTR_TRIGGERED_CAN_PROC (0x02)
 * - PROC_ATTR_REQ_MANA_COST (0x04)
 * - PROC_ATTR_REQ_SPELLMOD (0x08)
 * - PROC_ATTR_USE_STACKS_FOR_CHARGES (0x10)
 * - PROC_ATTR_REDUCE_PROC_60 (0x80)
 * - PROC_ATTR_CANT_PROC_FROM_ITEM_CAST (0x100)
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "AuraStub.h"
#include "UnitStub.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcAttributeTest : public ::testing::Test
{
protected:
    void SetUp() override {}
};

// =============================================================================
// PROC_ATTR_REQ_EXP_OR_HONOR (0x01) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, ReqExpOrHonor_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_REQ_EXP_OR_HONOR)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_EXP_OR_HONOR);
}

TEST_F(SpellProcAttributeTest, ReqExpOrHonor_AttributeNotSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(0)
        .Build();

    EXPECT_FALSE(procEntry.AttributesMask & PROC_ATTR_REQ_EXP_OR_HONOR);
}

// =============================================================================
// PROC_ATTR_TRIGGERED_CAN_PROC (0x02) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, TriggeredCanProc_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC);
}

TEST_F(SpellProcAttributeTest, TriggeredCanProc_AttributeNotSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(0)
        .Build();

    EXPECT_FALSE(procEntry.AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC);
}

// =============================================================================
// PROC_ATTR_REQ_MANA_COST (0x04) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, ReqManaCost_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_REQ_MANA_COST)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_MANA_COST);
}

TEST_F(SpellProcAttributeTest, ReqManaCost_NullSpell_ShouldNotProc)
{
    // Null spell should never satisfy mana cost requirement
    EXPECT_FALSE(ProcChanceTestHelper::SpellHasManaCost(nullptr));
}

// =============================================================================
// PROC_ATTR_REQ_SPELLMOD (0x08) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, ReqSpellmod_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_REQ_SPELLMOD)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_SPELLMOD);
}

TEST_F(SpellProcAttributeTest, ReqSpellmod_AttributeNotSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(0)
        .Build();

    EXPECT_FALSE(procEntry.AttributesMask & PROC_ATTR_REQ_SPELLMOD);
}

// =============================================================================
// PROC_ATTR_USE_STACKS_FOR_CHARGES (0x10) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, UseStacksForCharges_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_USE_STACKS_FOR_CHARGES);
}

TEST_F(SpellProcAttributeTest, UseStacksForCharges_DecrementStacks)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithStackAmount(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);

    EXPECT_EQ(aura->GetStackAmount(), 4);
}

TEST_F(SpellProcAttributeTest, UseStacksForCharges_NotSet_DecrementCharges)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(5)
        .WithStackAmount(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(0)  // No USE_STACKS_FOR_CHARGES
        .Build();

    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);

    // Charges should decrement, stacks unchanged
    EXPECT_EQ(aura->GetCharges(), 4);
    EXPECT_EQ(aura->GetStackAmount(), 5);
}

// =============================================================================
// PROC_ATTR_REDUCE_PROC_60 (0x80) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, ReduceProc60_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REDUCE_PROC_60);
}

TEST_F(SpellProcAttributeTest, ReduceProc60_Level60_NoReduction)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float chance = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 60);
    EXPECT_NEAR(chance, 30.0f, 0.01f);
}

TEST_F(SpellProcAttributeTest, ReduceProc60_Level70_Reduced)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    // Level 70 = 10 levels above 60
    // Reduction = 10/30 = 33.33%
    // 30% * (1 - 0.333) = 20%
    float chance = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 70);
    EXPECT_NEAR(chance, 20.0f, 0.5f);
}

TEST_F(SpellProcAttributeTest, ReduceProc60_Level80_Reduced)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    // Level 80 = 20 levels above 60
    // Reduction = 20/30 = 66.67%
    // 30% * (1 - 0.667) = 10%
    float chance = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 80);
    EXPECT_NEAR(chance, 10.0f, 0.5f);
}

TEST_F(SpellProcAttributeTest, ReduceProc60_BelowLevel60_NoReduction)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    float chance = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 50);
    EXPECT_NEAR(chance, 30.0f, 0.01f);
}

TEST_F(SpellProcAttributeTest, ReduceProc60_NotSet_NoReduction)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(30.0f)
        .WithAttributesMask(0)  // No REDUCE_PROC_60
        .Build();

    // Even at level 80, no reduction without attribute
    float chance = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 80);
    EXPECT_NEAR(chance, 30.0f, 0.01f);
}

// =============================================================================
// PROC_ATTR_CANT_PROC_FROM_ITEM_CAST (0x100) Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, CantProcFromItemCast_AttributeSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_CANT_PROC_FROM_ITEM_CAST)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_CANT_PROC_FROM_ITEM_CAST);
}

TEST_F(SpellProcAttributeTest, CantProcFromItemCast_AttributeNotSet)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(0)
        .Build();

    EXPECT_FALSE(procEntry.AttributesMask & PROC_ATTR_CANT_PROC_FROM_ITEM_CAST);
}

// =============================================================================
// Combined Attribute Tests
// =============================================================================

TEST_F(SpellProcAttributeTest, CombinedAttributes_MultipleFlags)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(
            PROC_ATTR_TRIGGERED_CAN_PROC |
            PROC_ATTR_REQ_MANA_COST |
            PROC_ATTR_REDUCE_PROC_60)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_MANA_COST);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REDUCE_PROC_60);
    EXPECT_FALSE(procEntry.AttributesMask & PROC_ATTR_REQ_EXP_OR_HONOR);
    EXPECT_FALSE(procEntry.AttributesMask & PROC_ATTR_USE_STACKS_FOR_CHARGES);
}

TEST_F(SpellProcAttributeTest, CombinedAttributes_AllFlags)
{
    uint32 allFlags =
        PROC_ATTR_REQ_EXP_OR_HONOR |
        PROC_ATTR_TRIGGERED_CAN_PROC |
        PROC_ATTR_REQ_MANA_COST |
        PROC_ATTR_REQ_SPELLMOD |
        PROC_ATTR_USE_STACKS_FOR_CHARGES |
        PROC_ATTR_REDUCE_PROC_60 |
        PROC_ATTR_CANT_PROC_FROM_ITEM_CAST;

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(allFlags)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_EXP_OR_HONOR);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_MANA_COST);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_SPELLMOD);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_USE_STACKS_FOR_CHARGES);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REDUCE_PROC_60);
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_CANT_PROC_FROM_ITEM_CAST);
}

// =============================================================================
// Real Spell Attribute Scenarios
// =============================================================================

TEST_F(SpellProcAttributeTest, Scenario_SealOfCommand_TriggeredCanProc)
{
    // Seal of Command (Paladin) can proc from triggered spells
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC);
}

TEST_F(SpellProcAttributeTest, Scenario_ClearCasting_ReqManaCost)
{
    // Clearcasting (Mage/Priest) requires spell to have mana cost
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_REQ_MANA_COST)
        .Build();

    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_MANA_COST);

    // Null spell check - free/costless spells won't trigger
    EXPECT_FALSE(ProcChanceTestHelper::SpellHasManaCost(nullptr));
}

TEST_F(SpellProcAttributeTest, Scenario_MaelstromWeapon_UseStacks)
{
    // Maelstrom Weapon (Shaman) uses stacks
    auto aura = AuraStubBuilder()
        .WithId(53817)
        .WithStackAmount(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // Each proc consumes one stack
    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetStackAmount(), 4);

    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetStackAmount(), 3);
}

TEST_F(SpellProcAttributeTest, Scenario_OldLevelScaling_ReduceProc60)
{
    // Some old vanilla/TBC procs have reduced chance at higher levels
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(50.0f)
        .WithAttributesMask(PROC_ATTR_REDUCE_PROC_60)
        .Build();

    // Level 60: Full chance
    float chanceAt60 = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 60);
    EXPECT_NEAR(chanceAt60, 50.0f, 0.01f);

    // Level 75: 50% reduction (15/30)
    float chanceAt75 = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 75);
    EXPECT_NEAR(chanceAt75, 25.0f, 0.5f);

    // Level 90: 100% reduction (30/30), capped at 0
    float chanceAt90 = ProcChanceTestHelper::SimulateCalcProcChance(procEntry, 90);
    EXPECT_NEAR(chanceAt90, 0.0f, 0.1f);
}

// =============================================================================
// Attribute Value Validation
// =============================================================================

TEST_F(SpellProcAttributeTest, AttributeValues_Correct)
{
    // Verify attribute flag values match expected hex values
    EXPECT_EQ(PROC_ATTR_REQ_EXP_OR_HONOR,        0x0000001u);
    EXPECT_EQ(PROC_ATTR_TRIGGERED_CAN_PROC,     0x0000002u);
    EXPECT_EQ(PROC_ATTR_REQ_MANA_COST,          0x0000004u);
    EXPECT_EQ(PROC_ATTR_REQ_SPELLMOD,           0x0000008u);
    EXPECT_EQ(PROC_ATTR_USE_STACKS_FOR_CHARGES, 0x0000010u);
    EXPECT_EQ(PROC_ATTR_REDUCE_PROC_60,         0x0000080u);
    EXPECT_EQ(PROC_ATTR_CANT_PROC_FROM_ITEM_CAST, 0x0000100u);
}

TEST_F(SpellProcAttributeTest, AttributeFlags_NonOverlapping)
{
    // Verify no two flags share the same bit
    uint32 flags[] = {
        PROC_ATTR_REQ_EXP_OR_HONOR,
        PROC_ATTR_TRIGGERED_CAN_PROC,
        PROC_ATTR_REQ_MANA_COST,
        PROC_ATTR_REQ_SPELLMOD,
        PROC_ATTR_USE_STACKS_FOR_CHARGES,
        PROC_ATTR_REDUCE_PROC_60,
        PROC_ATTR_CANT_PROC_FROM_ITEM_CAST
    };

    for (size_t i = 0; i < sizeof(flags)/sizeof(flags[0]); ++i)
    {
        for (size_t j = i + 1; j < sizeof(flags)/sizeof(flags[0]); ++j)
        {
            EXPECT_EQ(flags[i] & flags[j], 0u)
                << "Flags at index " << i << " and " << j << " overlap";
        }
    }
}
