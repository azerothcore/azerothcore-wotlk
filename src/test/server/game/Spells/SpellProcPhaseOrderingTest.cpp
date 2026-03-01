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
 * @file SpellProcPhaseOrderingTest.cpp
 * @brief Tests for proc phase ordering: CAST -> HIT -> FINISH
 *
 * Validates that CAST-phase procs are isolated from HIT-phase events
 * and vice versa. This is critical for correct behavior of spells like
 * Arcane Potency (consumed on CAST) not being affected by HIT events
 * from the same spell cast.
 *
 * Related fix: Non-channeled immediate spells fire CAST procs before
 * handle_immediate() to ensure CAST -> HIT -> FINISH ordering.
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "AuraStub.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcPhaseOrderingTest : public ::testing::Test
{
protected:
    void SetUp() override {}

    void TearDown() override
    {
        for (auto* si : _spellInfos)
            delete si;
        _spellInfos.clear();
    }

    SpellInfo* CreateSpellInfo(uint32 id)
    {
        auto* si = SpellInfoBuilder().WithId(id).Build();
        _spellInfos.push_back(si);
        return si;
    }

    std::vector<SpellInfo*> _spellInfos;
};

// =============================================================================
// Phase Isolation: CAST-only procs must not trigger on HIT events
// =============================================================================

TEST_F(SpellProcPhaseOrderingTest, CastPhaseProc_TriggersOnCastEvent)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    auto castEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, castEvent));
}

TEST_F(SpellProcPhaseOrderingTest, CastPhaseProc_DoesNotTriggerOnHitEvent)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    auto hitEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, hitEvent));
}

TEST_F(SpellProcPhaseOrderingTest, CastPhaseProc_DoesNotTriggerOnFinishEvent)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    auto finishEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_FINISH)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, finishEvent));
}

// =============================================================================
// Phase Isolation: HIT-only procs must not trigger on CAST events
// =============================================================================

TEST_F(SpellProcPhaseOrderingTest, HitPhaseProc_DoesNotTriggerOnCastEvent)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto castEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, castEvent));
}

// =============================================================================
// Charge consumption respects phase isolation
// Simulates the Arcane Potency scenario: charges consumed on CAST phase
// should not be consumed again when HIT phase fires later.
// =============================================================================

TEST_F(SpellProcPhaseOrderingTest, ChargeConsumedOnCast_NotConsumedAgainOnHit)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    // Proc entry configured for CAST phase only (like Arcane Potency)
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithChance(100.0f)
        .Build();

    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(2)
        .Build();

    // CAST phase event fires first (correct ordering)
    auto castEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    // CAST phase matches -> proc triggers, charge consumed
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, castEvent));
    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 1);

    // HIT phase event fires second
    auto hitEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    // HIT phase does NOT match CAST-only proc -> no trigger, no charge consumed
    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, hitEvent));
    EXPECT_EQ(aura->GetCharges(), 1); // Still 1, not consumed
}

TEST_F(SpellProcPhaseOrderingTest, ChargeConsumedOnCast_AvailableForNextSpell)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithChance(100.0f)
        .Build();

    auto aura = AuraStubBuilder()
        .WithId(12345)
        .WithCharges(2)
        .Build();

    auto castEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    // First spell cast consumes one charge
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, castEvent));
    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 1);
    EXPECT_FALSE(aura->IsRemoved());

    // Second spell cast consumes last charge
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, castEvent));
    ProcChanceTestHelper::SimulateConsumeProcCharges(aura.get(), procEntry);
    EXPECT_EQ(aura->GetCharges(), 0);
    EXPECT_TRUE(aura->IsRemoved());
}

// =============================================================================
// Multi-phase procs (CAST | HIT) trigger on both phases
// =============================================================================

TEST_F(SpellProcPhaseOrderingTest, MultiPhaseProc_TriggersOnBothCastAndHit)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST | PROC_SPELL_PHASE_HIT)
        .Build();

    auto castEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    auto hitEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, castEvent));
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, hitEvent));
}

// =============================================================================
// All three phases are distinct
// =============================================================================

TEST_F(SpellProcPhaseOrderingTest, AllThreePhases_MutuallyExclusive)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_ARCANE, SPELL_DIRECT_DAMAGE);

    uint32 phases[] = { PROC_SPELL_PHASE_CAST, PROC_SPELL_PHASE_HIT, PROC_SPELL_PHASE_FINISH };

    for (uint32 procPhase : phases)
    {
        auto procEntry = SpellProcEntryBuilder()
            .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
            .WithSpellPhaseMask(procPhase)
            .Build();

        for (uint32 eventPhase : phases)
        {
            auto event = ProcEventInfoBuilder()
                .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
                .WithSpellPhaseMask(eventPhase)
                .WithHitMask(PROC_HIT_NORMAL)
                .WithDamageInfo(&damageInfo)
                .Build();

            if (procPhase == eventPhase)
                EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, event))
                    << "Phase " << procPhase << " should match itself";
            else
                EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, event))
                    << "Phase " << procPhase << " should not match phase " << eventPhase;
        }
    }
}
