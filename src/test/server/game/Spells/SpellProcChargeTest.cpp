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
 * @file SpellProcChargeTest.cpp
 * @brief Unit tests for proc charge and stack consumption
 *
 * Tests ConsumeProcCharges() behavior including:
 * - Charge decrement on proc
 * - Aura removal when charges exhausted
 * - PROC_ATTR_USE_STACKS_FOR_CHARGES stack decrement
 * - Multiple charge consumption scenarios
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "AuraStub.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcChargeTest : public ::testing::Test
{
protected:
    void SetUp() override {}
};

// =============================================================================
// Basic Charge Consumption Tests
// =============================================================================

TEST_F(SpellProcChargeTest, ChargeDecrement_SingleCharge)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(1)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // Consume the single charge
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);

    EXPECT_EQ(aura->GetCharges(), 0);
    EXPECT_TRUE(removed);
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, ChargeDecrement_MultipleCharges)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // First consumption
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 4);
    EXPECT_FALSE(removed);
    EXPECT_FALSE(aura->IsRemoved());

    // Second consumption
    removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 3);
    EXPECT_FALSE(removed);

    // Third consumption
    removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 2);
    EXPECT_FALSE(removed);

    // Fourth consumption
    removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 1);
    EXPECT_FALSE(removed);

    // Final consumption - should remove aura
    removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 0);
    EXPECT_TRUE(removed);
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, NoCharges_NoConsumption)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(0)
        .Build();

    aura->SetUsingCharges(false);

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);

    EXPECT_EQ(aura->GetCharges(), 0);
    EXPECT_FALSE(removed);
    EXPECT_FALSE(aura->IsRemoved());
}

// =============================================================================
// PROC_ATTR_USE_STACKS_FOR_CHARGES Tests
// =============================================================================

TEST_F(SpellProcChargeTest, UseStacksForCharges_SingleStack)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithStackAmount(1)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);

    EXPECT_EQ(aura->GetStackAmount(), 0);
    EXPECT_TRUE(removed);
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, UseStacksForCharges_MultipleStacks)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithStackAmount(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // First consumption - 5 -> 4
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetStackAmount(), 4);
    EXPECT_FALSE(removed);
    EXPECT_FALSE(aura->IsRemoved());

    // Second consumption - 4 -> 3
    removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetStackAmount(), 3);
    EXPECT_FALSE(removed);

    // Consume remaining stacks
    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry); // 3 -> 2
    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry); // 2 -> 1

    // Final consumption - should remove aura
    removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetStackAmount(), 0);
    EXPECT_TRUE(removed);
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, UseStacksForCharges_IgnoresCharges)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(10)  // Has charges
        .WithStackAmount(2)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // Should decrement stacks, not charges
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);

    EXPECT_EQ(aura->GetStackAmount(), 1);
    EXPECT_EQ(aura->GetCharges(), 10);  // Charges unchanged
    EXPECT_FALSE(removed);
}

// =============================================================================
// Real Spell Scenario Tests
// =============================================================================

TEST_F(SpellProcChargeTest, Scenario_HotStreak_3Charges)
{
    // Hot Streak (Fire Mage) - 3 charges, consumed on each instant Pyroblast
    auto aura = AuraStubBuilder()
        .WithId(48108)  // Hot Streak
        .WithCharges(3)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // First Pyroblast
    EXPECT_FALSE(ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry));
    EXPECT_EQ(aura->GetCharges(), 2);

    // Second Pyroblast
    EXPECT_FALSE(ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry));
    EXPECT_EQ(aura->GetCharges(), 1);

    // Third Pyroblast - aura removed
    EXPECT_TRUE(ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry));
    EXPECT_EQ(aura->GetCharges(), 0);
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, Scenario_BladeBarrier_5Stacks)
{
    // Blade Barrier (Death Knight) - 5 stacks, consumed over time
    auto aura = AuraStubBuilder()
        .WithId(55226)  // Blade Barrier
        .WithStackAmount(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // Simulate stacks being consumed
    for (int i = 5; i > 1; --i)
    {
        EXPECT_EQ(aura->GetStackAmount(), i);
        EXPECT_FALSE(ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry));
    }

    // Last stack removal
    EXPECT_EQ(aura->GetStackAmount(), 1);
    EXPECT_TRUE(ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry));
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, Scenario_Maelstrom_5Stacks)
{
    // Maelstrom Weapon (Enhancement Shaman) - 5 stacks
    auto aura = AuraStubBuilder()
        .WithId(53817)  // Maelstrom Weapon
        .WithStackAmount(5)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // At 5 stacks, cast instant Lightning Bolt consumes all stacks
    // Simulate consuming all 5 stacks at once
    for (int i = 0; i < 5; ++i)
    {
        ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    }

    EXPECT_EQ(aura->GetStackAmount(), 0);
    EXPECT_TRUE(aura->IsRemoved());
}

// =============================================================================
// Edge Case Tests
// =============================================================================

TEST_F(SpellProcChargeTest, NullAura_SafeHandling)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // Should not crash
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(nullptr, procEntry);
    EXPECT_FALSE(removed);
}

TEST_F(SpellProcChargeTest, ZeroStacks_WithUseStacksAttribute)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithStackAmount(0)
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // Should handle gracefully and remove aura
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_TRUE(removed);
    EXPECT_TRUE(aura->IsRemoved());
}

TEST_F(SpellProcChargeTest, HighChargeCount)
{
    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(255)  // Max uint8
        .Build();

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // Consume one charge from max
    bool removed = ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 254);
    EXPECT_FALSE(removed);
}

// =============================================================================
// ProcTestScenario Integration Tests
// =============================================================================

TEST_F(SpellProcChargeTest, ProcTestScenario_ChargeConsumption)
{
    ProcTestScenario scenario;
    scenario.WithAura(12345, 3);  // 3 charges

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // First proc - consumes charge
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetCharges(), 2);

    // Second proc - consumes charge
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetCharges(), 1);

    // Third proc - consumes last charge and removes aura
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetCharges(), 0);
    EXPECT_TRUE(scenario.GetAura()->IsRemoved());
}

TEST_F(SpellProcChargeTest, ProcTestScenario_StackConsumption)
{
    ProcTestScenario scenario;
    scenario.WithAura(12345, 0, 3);  // 3 stacks

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithAttributesMask(PROC_ATTR_USE_STACKS_FOR_CHARGES)
        .Build();

    // First proc - consumes stack
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetStackAmount(), 2);

    // Second proc - consumes stack
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetStackAmount(), 1);

    // Third proc - consumes last stack and removes aura
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetStackAmount(), 0);
    EXPECT_TRUE(scenario.GetAura()->IsRemoved());
}

TEST_F(SpellProcChargeTest, ProcTestScenario_ChargesWithCooldown)
{
    using namespace std::chrono_literals;

    ProcTestScenario scenario;
    scenario.WithAura(12345, 3);  // 3 charges

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithCooldown(1000ms)  // 1 second cooldown
        .Build();

    // First proc at t=0 - should work
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetCharges(), 2);

    // Immediate second proc - blocked by cooldown
    EXPECT_FALSE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetCharges(), 2);  // No charge consumed

    // Wait for cooldown
    scenario.AdvanceTime(1100ms);

    // Third proc - should work
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
    EXPECT_EQ(scenario.GetAura()->GetCharges(), 1);
}
