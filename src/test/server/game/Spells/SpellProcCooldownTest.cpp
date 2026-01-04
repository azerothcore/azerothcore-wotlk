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
 * @file SpellProcCooldownTest.cpp
 * @brief Unit tests for proc internal cooldown system
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "AuraStub.h"
#include "gtest/gtest.h"

using namespace testing;
using namespace std::chrono_literals;

class SpellProcCooldownTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _now = std::chrono::steady_clock::now();
    }

    std::chrono::steady_clock::time_point _now;
};

// =============================================================================
// Basic Cooldown Tests
// =============================================================================

TEST_F(SpellProcCooldownTest, NotOnCooldown_Initially)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now));
}

TEST_F(SpellProcCooldownTest, OnCooldown_AfterProc)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    // Apply 1 second cooldown
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 1000);

    // Should be on cooldown immediately after
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now));
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 500ms));
}

TEST_F(SpellProcCooldownTest, NotOnCooldown_AfterExpiry)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    // Apply 1 second cooldown
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 1000);

    // Should not be on cooldown after 1 second
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 1001ms));
}

TEST_F(SpellProcCooldownTest, ExactCooldownBoundary)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 1000);

    // At exactly cooldown time, should still be on cooldown (< not <=)
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 999ms));
    // One millisecond after should be off cooldown
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 1000ms));
}

// =============================================================================
// Zero Cooldown Tests
// =============================================================================

TEST_F(SpellProcCooldownTest, ZeroCooldown_NeverBlocks)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    // Zero cooldown should not apply any cooldown
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 0);

    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now));
}

// =============================================================================
// Cooldown Reset Tests
// =============================================================================

TEST_F(SpellProcCooldownTest, CooldownCanBeReset)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 5000);
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now));

    aura->ResetProcCooldown();
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now));
}

TEST_F(SpellProcCooldownTest, CooldownCanBeExtended)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();

    // Apply 1 second cooldown
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 1000);

    // Extend to 5 seconds
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 5000);

    // Should still be on cooldown after 2 seconds
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 2000ms));
}

// =============================================================================
// Scenario Tests
// =============================================================================

TEST_F(SpellProcCooldownTest, Scenario_LeaderOfThePack_6SecCooldown)
{
    // Leader of the Pack has a 6 second internal cooldown
    auto aura = AuraStubBuilder().WithId(24932).Build();

    // First proc
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 6000);

    // Blocked at 3 seconds
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 3000ms));

    // Blocked at 5.9 seconds
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 5999ms));

    // Allowed at 6 seconds
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 6000ms));
}

TEST_F(SpellProcCooldownTest, Scenario_WanderingPlague_1SecCooldown)
{
    // Wandering Plague has a 1 second internal cooldown
    auto aura = AuraStubBuilder().WithId(49217).Build();

    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), _now, 1000);

    // Blocked at 0.5 seconds
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 500ms));

    // Allowed at 1 second
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), _now + 1000ms));
}

TEST_F(SpellProcCooldownTest, Scenario_MultipleProcsWithCooldown)
{
    auto aura = AuraStubBuilder().WithId(12345).Build();
    auto time = _now;

    // First proc at t=0
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), time));
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), time, 1000);

    // Second attempt at t=0.5 (blocked)
    time += 500ms;
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), time));

    // Third attempt at t=1.0 (allowed)
    time += 500ms;
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), time));
    ProcChanceTestHelper::ApplyProcCooldown(aura.get(), time, 1000);

    // Fourth attempt at t=1.5 (blocked)
    time += 500ms;
    EXPECT_TRUE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), time));

    // Fifth attempt at t=2.0 (allowed)
    time += 500ms;
    EXPECT_FALSE(ProcChanceTestHelper::IsProcOnCooldown(aura.get(), time));
}

// =============================================================================
// ProcTestScenario Tests
// =============================================================================

TEST_F(SpellProcCooldownTest, ProcTestScenario_CooldownBlocking)
{
    ProcTestScenario scenario;
    scenario.WithAura(12345);

    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .WithCooldown(1000ms)
        .Build();

    // First proc should succeed
    EXPECT_TRUE(scenario.SimulateProc(procEntry));

    // Second proc immediately after should fail (on cooldown)
    EXPECT_FALSE(scenario.SimulateProc(procEntry));

    // Advance time past cooldown
    scenario.AdvanceTime(1100ms);

    // Third proc should succeed
    EXPECT_TRUE(scenario.SimulateProc(procEntry));
}
