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

#include "gtest/gtest.h"
#include <algorithm>
#include <cstdint>

/**
 * Tests for Unit::resetAttackTimer arithmetic.
 *
 * Unit::resetAttackTimer resets the swing timer after an attack lands.
 * The timer value determines when the next attack can occur.
 *
 * Old (buggy) formula:
 *   int32 time = int32(GetAttackTime(type) * m_modAttackSpeedPct[type]);
 *   m_attackTimer[type] = std::min(m_attackTimer[type] + time, time);
 *
 * New (fixed) formula:
 *   m_attackTimer[type] = int32(GetAttackTime(type) * m_modAttackSpeedPct[type]);
 *
 * The old formula carried forward negative timer debt, allowing burst
 * attacks after lag spikes or parry-haste timer reductions.
 */

namespace
{
    // Simulates the old (buggy) resetAttackTimer formula
    int32_t OldResetFormula(int32_t currentTimer, int32_t fullTime)
    {
        return std::min(currentTimer + fullTime, fullTime);
    }

    // Simulates the new (fixed) resetAttackTimer formula
    int32_t NewResetFormula(int32_t /*currentTimer*/, int32_t fullTime)
    {
        return fullTime;
    }

    // Calculate effective attack time: GetAttackTime(type) * m_modAttackSpeedPct[type]
    int32_t CalcFullTime(uint32_t baseAttackTime, float modSpeedPct)
    {
        return static_cast<int32_t>(baseAttackTime * modSpeedPct);
    }
}

// Normal case: timer at 0 (attack just became ready)
TEST(ResetAttackTimerTest, NormalReset_TimerAtZero)
{
    int32_t fullTime = CalcFullTime(2000, 1.0f); // 2.0s base, no haste
    int32_t currentTimer = 0;

    // Both formulas produce the same result when timer is exactly 0
    EXPECT_EQ(OldResetFormula(currentTimer, fullTime), 2000);
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 2000);
}

// Normal case: timer slightly negative (typical single-tick overshoot)
TEST(ResetAttackTimerTest, NormalReset_SmallNegativeTimer)
{
    int32_t fullTime = CalcFullTime(2000, 1.0f);
    int32_t currentTimer = -50; // 50ms overshoot

    // Old formula: min(-50 + 2000, 2000) = min(1950, 2000) = 1950
    // Carries 50ms debt — next attack 50ms sooner
    EXPECT_EQ(OldResetFormula(currentTimer, fullTime), 1950);

    // New formula: always 2000 — clean reset
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 2000);
}

// Bug scenario: large negative timer from lag spike
TEST(ResetAttackTimerTest, LagSpike_LargeNegativeTimer)
{
    int32_t fullTime = CalcFullTime(2000, 1.0f);
    int32_t currentTimer = -3000; // 3 second lag spike

    // Old formula: min(-3000 + 2000, 2000) = min(-1000, 2000) = -1000
    // Timer is STILL negative — attack fires immediately again!
    EXPECT_LT(OldResetFormula(currentTimer, fullTime), 0);

    // New formula: always 2000 — no burst
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 2000);
}

// Gluth scenario: parry-haste with enrage
TEST(ResetAttackTimerTest, GluthParryHaste_BurstAttack)
{
    // Gluth: 1600ms base, 25% enrage haste
    // GetAttackTime returns base (1600), modSpeedPct = 0.8 (25% haste)
    int32_t fullTime = CalcFullTime(1600, 0.8f); // = 1280ms
    EXPECT_EQ(fullTime, 1280);

    // After parry-haste reduces timer to near-zero and a lag spike
    // causes 2+ seconds of unprocessed time
    int32_t currentTimer = -2000;

    // Old formula: min(-2000 + 1280, 1280) = min(-720, 1280) = -720
    // Timer deeply negative — immediate burst attack
    EXPECT_LT(OldResetFormula(currentTimer, fullTime), 0);

    // New formula: 1280ms — proper cooldown before next swing
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 1280);
}

// Parry-haste floor scenario: timer at minimum (20% of base)
TEST(ResetAttackTimerTest, ParryHasteFloor_MultipleParries)
{
    // Creature with 1600ms base, no haste
    int32_t fullTime = CalcFullTime(1600, 1.0f);

    // Parry-haste can reduce timer to 20% of base = 320ms
    // If server tick is 200ms and timer was at 320ms, after tick: 120ms
    // Attack fires, resetAttackTimer called with timer = 120 - 200 = -80
    // (timer went from 120 to -80 during the next tick)
    int32_t currentTimer = -80;

    // Old formula: min(-80 + 1600, 1600) = min(1520, 1600) = 1520
    // Small debt is carried — minor issue
    EXPECT_EQ(OldResetFormula(currentTimer, fullTime), 1520);

    // Now consider two rapid parries reducing timer to 320ms,
    // followed by a 500ms server hiccup
    currentTimer = 320 - 500; // = -180
    // Old formula: min(-180 + 1600, 1600) = min(1420, 1600) = 1420
    EXPECT_EQ(OldResetFormula(currentTimer, fullTime), 1420);

    // New formula: always full time
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 1600);
}

// Multiple consecutive burst attacks (worst case)
TEST(ResetAttackTimerTest, ConsecutiveBursts_OldFormulaChainAttacks)
{
    int32_t fullTime = CalcFullTime(1600, 0.8f); // Gluth enraged: 1280ms
    int32_t timer = -2500; // Large lag spike

    int attackCount = 0;
    // Simulate old formula: how many attacks fire before timer > 0?
    while (timer <= 0)
    {
        attackCount++;
        timer = OldResetFormula(timer, fullTime);
    }

    // Old formula allows multiple attacks in burst
    EXPECT_GT(attackCount, 1);

    // New formula: always exactly 1 attack then timer is positive
    timer = -2500;
    int newAttackCount = 0;
    // Only one attack fires (the one that triggered the reset)
    timer = NewResetFormula(timer, fullTime);
    if (timer > 0)
        newAttackCount = 1;

    EXPECT_EQ(newAttackCount, 1);
    EXPECT_GT(timer, 0);
}

// Haste modifier correctness
TEST(ResetAttackTimerTest, HasteModifier_CorrectCalculation)
{
    // No haste: 2000ms base
    EXPECT_EQ(CalcFullTime(2000, 1.0f), 2000);

    // 25% haste (modSpeedPct = 0.8)
    EXPECT_EQ(CalcFullTime(2000, 0.8f), 1600);

    // 50% slow (modSpeedPct = 1.5)
    EXPECT_EQ(CalcFullTime(2000, 1.5f), 3000);

    // Enrage (25% haste on 1600ms base)
    EXPECT_EQ(CalcFullTime(1600, 0.8f), 1280);
}

// Edge case: timer exactly equals negative of full time
TEST(ResetAttackTimerTest, EdgeCase_TimerEqualsNegativeFullTime)
{
    int32_t fullTime = CalcFullTime(2000, 1.0f);
    int32_t currentTimer = -2000;

    // Old formula: min(-2000 + 2000, 2000) = min(0, 2000) = 0
    // Timer exactly 0 — attack is immediately ready again
    EXPECT_EQ(OldResetFormula(currentTimer, fullTime), 0);

    // New formula: 2000 — proper delay
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 2000);
}

// Edge case: positive timer (reset called before attack was ready)
TEST(ResetAttackTimerTest, EdgeCase_PositiveTimer)
{
    int32_t fullTime = CalcFullTime(2000, 1.0f);
    int32_t currentTimer = 500; // 500ms remaining

    // Old formula: min(500 + 2000, 2000) = min(2500, 2000) = 2000
    // Capped at full time — correct behavior
    EXPECT_EQ(OldResetFormula(currentTimer, fullTime), 2000);

    // New formula: same result
    EXPECT_EQ(NewResetFormula(currentTimer, fullTime), 2000);
}

// Invariant: new formula always returns exactly fullTime
TEST(ResetAttackTimerTest, Invariant_AlwaysReturnsFullTime)
{
    int32_t fullTime = CalcFullTime(1600, 1.0f);

    // Test a wide range of current timer values
    for (int32_t timer = -10000; timer <= 10000; timer += 100)
        EXPECT_EQ(NewResetFormula(timer, fullTime), fullTime);
}
