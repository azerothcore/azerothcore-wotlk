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

#include "ProcEventInfoHelper.h"
#include "SpellMgr.h"
#include "WorldMock.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace testing;

/**
 * @brief Tests for fully absorbed periodic damage not triggering TAKEN procs
 *
 * When periodic damage (e.g. Consecration ticks) is fully absorbed by an
 * absorb shield (e.g. Power Word: Shield), the hit mask should only contain
 * PROC_HIT_ABSORB (no PROC_HIT_NORMAL/CRITICAL). Since TAKEN procs default
 * to requiring PROC_HIT_NORMAL | PROC_HIT_CRITICAL, fully absorbed ticks
 * should not trigger victim procs like stealth charge consumption.
 *
 * This aligns with TrinityCore behavior where hitMask only gets NORMAL/CRITICAL
 * added when damage > 0 in HandlePeriodicDamageAurasTick.
 */
class PeriodicAbsorbStealthProcTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _originalWorld = sWorld.release();
        _worldMock = new NiceMock<WorldMock>();
        sWorld.reset(_worldMock);

        static std::string emptyString;
        ON_CALL(*_worldMock, GetDataPath()).WillByDefault(ReturnRef(emptyString));
    }

    void TearDown() override
    {
        IWorld* currentWorld = sWorld.release();
        delete currentWorld;
        _worldMock = nullptr;

        sWorld.reset(_originalWorld);
        _originalWorld = nullptr;
    }

    IWorld* _originalWorld = nullptr;
    NiceMock<WorldMock>* _worldMock = nullptr;
};

// Stealth-like TAKEN periodic proc with default HitMask (0) should NOT
// trigger when the only hit flag is PROC_HIT_ABSORB (fully absorbed tick)
TEST_F(PeriodicAbsorbStealthProcTest, FullyAbsorbedPeriodicDoesNotTriggerTakenProc)
{
    // Stealth has ProcFlags including PROC_FLAG_TAKEN_PERIODIC, HitMask=0
    // Default TAKEN HitMask = PROC_HIT_NORMAL | PROC_HIT_CRITICAL (no ABSORB)
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(0)
        .Build();

    // Fully absorbed periodic tick: hitMask = PROC_HIT_ABSORB only
    // (damage=0 so PROC_EX_NORMAL_HIT is NOT set)
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(PROC_HIT_ABSORB)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// Non-absorbed periodic tick (damage > 0) SHOULD trigger TAKEN procs
TEST_F(PeriodicAbsorbStealthProcTest, NonAbsorbedPeriodicTriggersTakenProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(0)
        .Build();

    // Normal periodic tick: hitMask includes PROC_HIT_NORMAL
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// Critical periodic tick SHOULD trigger TAKEN procs
TEST_F(PeriodicAbsorbStealthProcTest, CriticalPeriodicTriggersTakenProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(0)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// Partially absorbed periodic tick (damage > 0, some absorbed) SHOULD trigger
// because PROC_HIT_NORMAL is set alongside PROC_HIT_ABSORB
TEST_F(PeriodicAbsorbStealthProcTest, PartiallyAbsorbedPeriodicTriggersTakenProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(0)
        .Build();

    // Partial absorb: both NORMAL and ABSORB flags set
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_PERIODIC)
        .WithHitMask(PROC_HIT_NORMAL | PROC_HIT_ABSORB)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// DONE procs (attacker side) SHOULD trigger on fully absorbed damage
// because DONE default HitMask includes PROC_HIT_ABSORB
TEST_F(PeriodicAbsorbStealthProcTest, FullyAbsorbedPeriodicTriggersDoneProc)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_PERIODIC)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(0)
        .Build();

    // Fully absorbed: only PROC_HIT_ABSORB
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_PERIODIC)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_ABSORB)
        .Build();

    // DONE default includes ABSORB, so this SHOULD trigger
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}
