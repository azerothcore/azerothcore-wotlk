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
#include "SpellInfoTestHelper.h"
#include "SpellMgr.h"
#include "WorldMock.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace testing;

/**
 * @brief Test fixture for SpellMgr proc tests
 *
 * Tests the CanSpellTriggerProcOnEvent function and related proc logic.
 */
class SpellProcTest : public ::testing::Test
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

        // Clean up any SpellInfo objects we created
        for (auto* spellInfo : _spellInfos)
            delete spellInfo;
        _spellInfos.clear();
    }

    // Helper to create and track SpellInfo objects for cleanup
    SpellInfo* CreateSpellInfo(uint32 id = 1, uint32 familyName = 0,
                                uint32 familyFlag0 = 0, uint32 familyFlag1 = 0, uint32 familyFlag2 = 0)
    {
        auto* spellInfo = SpellInfoBuilder()
            .WithId(id)
            .WithSpellFamilyName(familyName)
            .WithSpellFamilyFlags(familyFlag0, familyFlag1, familyFlag2)
            .Build();
        _spellInfos.push_back(spellInfo);
        return spellInfo;
    }

    IWorld* _originalWorld = nullptr;
    NiceMock<WorldMock>* _worldMock = nullptr;
    std::vector<SpellInfo*> _spellInfos;
};

// =============================================================================
// ProcFlags Tests - Basic proc flag matching
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_ProcFlagsMatch)
{
    // Setup: Create a proc entry that triggers on melee auto attacks
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .Build();

    // Create ProcEventInfo with matching type mask
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    // Should match
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_ProcFlagsNoMatch)
{
    // Setup: Create a proc entry that triggers on melee auto attacks
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .Build();

    // Create ProcEventInfo with different type mask (ranged instead of melee)
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_RANGED_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    // Should not match
    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_MultipleProcFlagsPartialMatch)
{
    // Setup: Create a proc entry that triggers on melee OR ranged
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_RANGED_AUTO_ATTACK)
        .Build();

    // Create ProcEventInfo with only melee
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    // Should match (partial match is OK - it's an OR relationship)
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// Kill/Death Event Tests - These always trigger regardless of other conditions
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_KillEventAlwaysProcs)
{
    // Setup: Create a proc entry for kill events
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_KILL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_KILL)
        .Build();

    // Kill events should always trigger
    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_KilledEventAlwaysProcs)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_KILLED)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_KILLED)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_DeathEventAlwaysProcs)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DEATH)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DEATH)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// HitMask Tests - Test hit type filtering
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskCriticalMatch)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskCriticalNoMatch)
{
    // Proc entry requires critical hit
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    // Event is a normal hit
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskDefaultForDone)
{
    // When HitMask is 0, default for DONE procs is NORMAL | CRITICAL | ABSORB
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(0) // Default
        .Build();

    // Normal hit should work with default mask
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskDefaultForTaken)
{
    // When HitMask is 0, default for TAKEN procs is NORMAL | CRITICAL
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(0) // Default
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskMissNoMatch)
{
    // Miss should not trigger default hit mask
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(0) // Default allows NORMAL | CRITICAL | ABSORB
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_MISS)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskDodge)
{
    // Explicitly require dodge
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_DODGE)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_DODGE)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskParry)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_PARRY)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_PARRY)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HitMaskBlock)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_BLOCK)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_BLOCK)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// SpellTypeMask Tests - Damage vs Heal vs Other
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellTypeMaskDamage)
{
    auto* spellInfo = CreateSpellInfo(1);

    // Create DamageInfo for the test
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellTypeMaskHeal)
{
    auto* spellInfo = CreateSpellInfo(1);

    // Create HealInfo with the spell info so GetSpellInfo() works
    HealInfo healInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_HOLY);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithHealInfo(&healInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellTypeMaskNoMatch)
{
    // Proc requires heal but event is damage
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE) // Mismatch
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// SpellPhaseMask Tests - Cast vs Hit vs Finish
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellPhaseMaskCast)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellPhaseMaskHit)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellPhaseMaskNoMatch)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    // Proc requires cast phase
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    // Event is hit phase
    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_CastPhaseWithExplicitHitMaskCrit)
{
    // Nature's Grace scenario: CAST phase + explicit HitMask for crit
    // Crit is pre-calculated for travel-time spells
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_NATURE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_CRITICAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_CastPhaseWithExplicitHitMaskNoCrit)
{
    // CAST phase + explicit HitMask requires crit, but spell didn't crit
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_NATURE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL) // No crit
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_CastPhaseWithDefaultHitMask)
{
    // CAST phase + HitMask=0 should skip HitMask check (old behavior)
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_NATURE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(0) // Default - no explicit HitMask
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithHitMask(PROC_HIT_NORMAL) // Doesn't matter - HitMask check skipped
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// Combined Condition Tests
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_AllConditionsMatch)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_OneConditionFails)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL) // Requires crit
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL) // But we got normal hit
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_ZeroProcFlags)
{
    // Zero proc flags should never match anything
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(0)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_PeriodicDamage)
{
    auto* spellInfo = CreateSpellInfo(1);
    DamageInfo damageInfo(nullptr, nullptr, 50, spellInfo, SPELL_SCHOOL_MASK_SHADOW, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_TakenDamage)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_DAMAGE)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_DAMAGE)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// SpellFamilyName/SpellFamilyFlags Tests - Class-specific proc matching
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellFamilyNameMatch)
{
    // Create a Mage spell (SpellFamilyName = SPELLFAMILY_MAGE = 3)
    auto* spellInfo = SpellInfoBuilder()
        .WithId(133) // Fireball
        .WithSpellFamilyName(SPELLFAMILY_MAGE)
        .Build();
    _spellInfos.push_back(spellInfo);

    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    // Proc entry requires Mage spells
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellFamilyName(SPELLFAMILY_MAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellFamilyNameNoMatch)
{
    // Create a Warlock spell but proc requires Mage
    auto* spellInfo = SpellInfoBuilder()
        .WithId(686) // Shadow Bolt
        .WithSpellFamilyName(SPELLFAMILY_WARLOCK)
        .Build();
    _spellInfos.push_back(spellInfo);

    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_SHADOW, SPELL_DIRECT_DAMAGE);

    // Proc entry requires Mage spells
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellFamilyName(SPELLFAMILY_MAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellFamilyFlagsMatch)
{
    // Create a Paladin Holy Light spell with specific family flags
    auto* spellInfo = SpellInfoBuilder()
        .WithId(635) // Holy Light
        .WithSpellFamilyName(SPELLFAMILY_PALADIN)
        .WithSpellFamilyFlags(0x80000000, 0, 0) // Example flag for Holy Light
        .Build();
    _spellInfos.push_back(spellInfo);

    HealInfo healInfo(nullptr, nullptr, 500, spellInfo, SPELL_SCHOOL_MASK_HOLY);

    // Proc entry requires specific Paladin family flag
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellFamilyName(SPELLFAMILY_PALADIN)
        .WithSpellFamilyMask(flag96(0x80000000, 0, 0))
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithHealInfo(&healInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellFamilyFlagsNoMatch)
{
    // Create a Paladin spell with different family flags
    auto* spellInfo = SpellInfoBuilder()
        .WithId(19750) // Flash of Light
        .WithSpellFamilyName(SPELLFAMILY_PALADIN)
        .WithSpellFamilyFlags(0x40000000, 0, 0) // Different flag
        .Build();
    _spellInfos.push_back(spellInfo);

    HealInfo healInfo(nullptr, nullptr, 300, spellInfo, SPELL_SCHOOL_MASK_HOLY);

    // Proc entry requires different family flag
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellFamilyName(SPELLFAMILY_PALADIN)
        .WithSpellFamilyMask(flag96(0x80000000, 0, 0)) // Wants Holy Light flag
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithHealInfo(&healInfo)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellFamilyNameZeroAcceptsAll)
{
    // When SpellFamilyName is 0, it should accept any spell family
    auto* spellInfo = SpellInfoBuilder()
        .WithId(100)
        .WithSpellFamilyName(SPELLFAMILY_DRUID)
        .Build();
    _spellInfos.push_back(spellInfo);

    DamageInfo damageInfo(nullptr, nullptr, 100, spellInfo, SPELL_SCHOOL_MASK_NATURE, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellFamilyName(0) // Accept any family
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SpellFamilyFlagsZeroAcceptsAll)
{
    // When SpellFamilyMask is 0, it should accept any flags within the family
    auto* spellInfo = SpellInfoBuilder()
        .WithId(100)
        .WithSpellFamilyName(SPELLFAMILY_PRIEST)
        .WithSpellFamilyFlags(0x12345678, 0xABCDEF01, 0x87654321) // Any flags
        .Build();
    _spellInfos.push_back(spellInfo);

    HealInfo healInfo(nullptr, nullptr, 200, spellInfo, SPELL_SCHOOL_MASK_HOLY);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellFamilyName(SPELLFAMILY_PRIEST)
        .WithSpellFamilyMask(flag96(0, 0, 0)) // Accept any flags
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithHealInfo(&healInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

// =============================================================================
// Real-world Spell Proc Examples
// =============================================================================

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_HotStreakScenario)
{
    // Hot Streak: Proc on critical damage spell from Mage
    auto* fireballSpell = SpellInfoBuilder()
        .WithId(133)
        .WithSpellFamilyName(SPELLFAMILY_MAGE)
        .WithSpellFamilyFlags(0x00000001, 0, 0) // Fireball flag
        .Build();
    _spellInfos.push_back(fireballSpell);

    DamageInfo damageInfo(nullptr, nullptr, 1000, fireballSpell, SPELL_SCHOOL_MASK_FIRE, SPELL_DIRECT_DAMAGE);

    // Hot Streak proc entry - triggers on fire spell crits
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellFamilyName(SPELLFAMILY_MAGE)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_IlluminationScenario)
{
    // Illumination: Proc on critical heals from Paladin
    auto* holyLightSpell = SpellInfoBuilder()
        .WithId(635)
        .WithSpellFamilyName(SPELLFAMILY_PALADIN)
        .WithSpellFamilyFlags(0x80000000, 0, 0)
        .Build();
    _spellInfos.push_back(holyLightSpell);

    HealInfo healInfo(nullptr, nullptr, 2000, holyLightSpell, SPELL_SCHOOL_MASK_HOLY);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellFamilyName(SPELLFAMILY_PALADIN)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_CRITICAL)
        .WithHealInfo(&healInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SecondWindScenario)
{
    // Second Wind: Proc when stunned/immobilized (taken hit with dodge/parry)
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK | PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS)
        .WithHitMask(PROC_HIT_DODGE | PROC_HIT_PARRY)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_DODGE)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}

TEST_F(SpellProcTest, CanSpellTriggerProcOnEvent_SwordAndBoardScenario)
{
    // Sword and Board: Proc on Devastate/Revenge (block effects)
    auto* devastateSpell = SpellInfoBuilder()
        .WithId(20243) // Devastate
        .WithSpellFamilyName(SPELLFAMILY_WARRIOR)
        .WithSpellFamilyFlags(0x00000000, 0x00000000, 0x00000100) // Devastate flag
        .Build();
    _spellInfos.push_back(devastateSpell);

    DamageInfo damageInfo(nullptr, nullptr, 500, devastateSpell, SPELL_SCHOOL_MASK_NORMAL, SPELL_DIRECT_DAMAGE);

    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS)
        .WithSpellFamilyName(SPELLFAMILY_WARRIOR)
        .WithSpellFamilyMask(flag96(0, 0, 0x100)) // Devastate flag
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    auto eventInfo = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithDamageInfo(&damageInfo)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, eventInfo));
}
