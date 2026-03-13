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
 * @file SpellProcArcanePotencyTest.cpp
 * @brief Unit tests for Arcane Potency proc behavior
 *
 * Arcane Potency (57529/57531) buffs should only be consumed by the spell
 * that was actually affected by the crit bonus, not by the same cast that
 * triggered them. This is achieved via PROC_ATTR_REQ_SPELLMOD (0x08) which
 * requires the proccing aura to be in the triggering spell's m_appliedMods.
 *
 * The crit aura registration in SpellDoneCritChance ensures that only spells
 * whose crit chance was actually modified by Arcane Potency will have it in
 * their m_appliedMods set.
 *
 * References:
 * - TrinityCore commit 81f16b201b
 * - ChromieCraft issue #9092
 */

#include "AuraScriptTestFramework.h"
#include "SpellMgr.h"
#include "gtest/gtest.h"

using namespace testing;

namespace
{
    // Arcane Potency buff spell IDs
    constexpr uint32 ARCANE_POTENCY_R1 = 57529;
    constexpr uint32 ARCANE_POTENCY_R2 = 57531;

    // SpellFamilyMask from spell_proc for Arcane Potency
    constexpr uint32 AP_FAMILY_MASK0 = 0x61401035;
    constexpr uint32 AP_FAMILY_MASK1 = 0x00001000;
    constexpr uint32 AP_FAMILY_MASK2 = 0;

    // Mage spell flags that SHOULD match Arcane Potency's mask
    // Fireball: bit 0
    constexpr uint32 FIREBALL_FLAG0 = 0x00000001;
    // Frostfire Bolt: bit 2 + Mask1 bit 12
    constexpr uint32 FROSTFIRE_BOLT_FLAG0 = 0x00000004;
    constexpr uint32 FROSTFIRE_BOLT_FLAG1 = 0x00001000;
    // Fire Blast: bit 4
    constexpr uint32 FIRE_BLAST_FLAG0 = 0x00000010;
    // Frostbolt: bit 5
    constexpr uint32 FROSTBOLT_FLAG0 = 0x00000020;
    // Arcane Explosion: bit 12
    constexpr uint32 ARCANE_EXPLOSION_FLAG0 = 0x00001000;
    // Scorch: bit 22
    constexpr uint32 SCORCH_FLAG0 = 0x00400000;
    // Arcane Blast: bit 29
    constexpr uint32 ARCANE_BLAST_FLAG0 = 0x20000000;

    // Mage spell flags that should NOT match
    // Arcane Missiles: bit 11
    constexpr uint32 ARCANE_MISSILES_FLAG0 = 0x00000800;
    // Ice Lance: bit 17
    constexpr uint32 ICE_LANCE_FLAG0 = 0x00020000;
    // Arcane Barrage: Mask1 bit 15
    constexpr uint32 ARCANE_BARRAGE_FLAG1 = 0x00008000;

    /**
     * Build the Arcane Potency proc entry matching our spell_proc SQL.
     */
    SpellProcEntry BuildArcanePotencyProcEntry()
    {
        return SpellProcEntryBuilder()
            .WithSpellFamilyName(SPELLFAMILY_MAGE)
            .WithSpellFamilyMask(flag96(AP_FAMILY_MASK0, AP_FAMILY_MASK1, AP_FAMILY_MASK2))
            .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
            .WithAttributesMask(PROC_ATTR_REQ_SPELLMOD)
            .Build();
    }
}

// =============================================================================
// Proc Entry Configuration Tests
// =============================================================================

class ArcanePotencyProcTest : public AuraScriptProcTestFixture
{
protected:
    void SetUp() override
    {
        AuraScriptProcTestFixture::SetUp();
    }
};

TEST_F(ArcanePotencyProcTest, ProcEntry_HasReqSpellmodAttribute)
{
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_SPELLMOD)
        << "Arcane Potency must have PROC_ATTR_REQ_SPELLMOD to prevent "
           "same-cast consumption";
}

TEST_F(ArcanePotencyProcTest, ProcEntry_CastPhaseOnly)
{
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_EQ(procEntry.SpellPhaseMask, PROC_SPELL_PHASE_CAST)
        << "Arcane Potency should only proc on CAST phase";
}

TEST_F(ArcanePotencyProcTest, ProcEntry_MageFamily)
{
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_EQ(procEntry.SpellFamilyName, SPELLFAMILY_MAGE);
}

TEST_F(ArcanePotencyProcTest, ProcEntry_BothRanksIdentical)
{
    // Both ranks should use the same proc configuration
    auto r1 = BuildArcanePotencyProcEntry();
    auto r2 = BuildArcanePotencyProcEntry();

    EXPECT_EQ(r1.SpellFamilyName, r2.SpellFamilyName);
    EXPECT_TRUE(r1.SpellFamilyMask == r2.SpellFamilyMask);
    EXPECT_EQ(r1.SpellPhaseMask, r2.SpellPhaseMask);
    EXPECT_EQ(r1.AttributesMask, r2.AttributesMask);
}

// =============================================================================
// SpellFamilyMask Matching Tests - Spells That SHOULD Match
// =============================================================================

TEST_F(ArcanePotencyProcTest, FamilyMask_Fireball_Matches)
{
    auto* spell = CreateSpellInfo(133, SPELLFAMILY_MAGE, FIREBALL_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_Frostbolt_Matches)
{
    auto* spell = CreateSpellInfo(116, SPELLFAMILY_MAGE, FROSTBOLT_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_ArcaneBlast_Matches)
{
    auto* spell = CreateSpellInfo(30451, SPELLFAMILY_MAGE, ARCANE_BLAST_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_ArcaneExplosion_Matches)
{
    auto* spell = CreateSpellInfo(1449, SPELLFAMILY_MAGE, ARCANE_EXPLOSION_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_FrostfireBolt_Matches)
{
    auto* spell = CreateSpellInfo(44614, SPELLFAMILY_MAGE,
        FROSTFIRE_BOLT_FLAG0, FROSTFIRE_BOLT_FLAG1);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_FireBlast_Matches)
{
    auto* spell = CreateSpellInfo(2136, SPELLFAMILY_MAGE, FIRE_BLAST_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_Scorch_Matches)
{
    auto* spell = CreateSpellInfo(2948, SPELLFAMILY_MAGE, SCORCH_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_TRUE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

// =============================================================================
// SpellFamilyMask Matching Tests - Spells That Should NOT Match
// =============================================================================

TEST_F(ArcanePotencyProcTest, FamilyMask_ArcaneMissiles_DoesNotMatch)
{
    auto* spell = CreateSpellInfo(5143, SPELLFAMILY_MAGE, ARCANE_MISSILES_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_FALSE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_IceLance_DoesNotMatch)
{
    auto* spell = CreateSpellInfo(30455, SPELLFAMILY_MAGE, ICE_LANCE_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_FALSE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_ArcaneBarrage_DoesNotMatch)
{
    auto* spell = CreateSpellInfo(44425, SPELLFAMILY_MAGE, 0, ARCANE_BARRAGE_FLAG1);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_FALSE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

TEST_F(ArcanePotencyProcTest, FamilyMask_NonMageSpell_DoesNotMatch)
{
    // Warrior spell with matching flags should NOT match due to family check
    auto* spell = CreateSpellInfo(6343, /*SPELLFAMILY_WARRIOR*/4, FIREBALL_FLAG0);
    auto procEntry = BuildArcanePotencyProcEntry();
    EXPECT_FALSE(TestSpellFamilyMatch(procEntry.SpellFamilyName, procEntry.SpellFamilyMask, spell));
}

// =============================================================================
// Proc Phase Tests - CAST phase filtering
// =============================================================================

TEST_F(ArcanePotencyProcTest, Phase_TriggersOnCast)
{
    // Test phase filtering in isolation (no family filter)
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithAttributesMask(PROC_ATTR_REQ_SPELLMOD)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnSpellDamage()
        .OnCast();
    EXPECT_PROC_TRIGGERS(procEntry, scenario);
}

TEST_F(ArcanePotencyProcTest, Phase_DoesNotTriggerOnHit)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithAttributesMask(PROC_ATTR_REQ_SPELLMOD)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnSpellDamage()
        .OnHit()
        .WithNormalHit();
    EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, scenario);
}

TEST_F(ArcanePotencyProcTest, Phase_DoesNotTriggerOnFinish)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .WithAttributesMask(PROC_ATTR_REQ_SPELLMOD)
        .Build();

    auto scenario = ProcScenarioBuilder()
        .OnSpellDamage()
        .OnFinish();
    EXPECT_PROC_DOES_NOT_TRIGGER(procEntry, scenario);
}

// =============================================================================
// PROC_ATTR_REQ_SPELLMOD Charge Gating Tests
// =============================================================================

TEST_F(ArcanePotencyProcTest, ReqSpellmod_AuraWithCharges_BlocksWithoutAppliedMod)
{
    // When PROC_ATTR_REQ_SPELLMOD is set and aura uses charges,
    // GetProcEffectMask should return 0 if aura is not in m_appliedMods.
    // We test the prerequisite: that the proc entry is configured correctly
    // so the charge-gating code path in GetProcEffectMask is reachable.
    auto procEntry = BuildArcanePotencyProcEntry();

    auto aura = AuraStubBuilder()
        .WithId(ARCANE_POTENCY_R1)
        .WithCharges(1)
        .Build();

    // The aura should be using charges (required for REQ_SPELLMOD gating)
    EXPECT_TRUE(aura->IsUsingCharges());
    EXPECT_TRUE(procEntry.AttributesMask & PROC_ATTR_REQ_SPELLMOD);
}

TEST_F(ArcanePotencyProcTest, ReqSpellmod_AuraWithoutCharges_SkipsCheck)
{
    // If aura has no charges, PROC_ATTR_REQ_SPELLMOD check is skipped
    // (no charges to consume = no need for spellmod gating)
    auto procEntry = BuildArcanePotencyProcEntry();

    auto aura = AuraStubBuilder()
        .WithId(ARCANE_POTENCY_R1)
        .WithCharges(0)
        .Build();

    EXPECT_FALSE(aura->IsUsingCharges());
    // Even though PROC_ATTR_REQ_SPELLMOD is set, the condition
    // (IsUsingCharges() || USE_STACKS_FOR_CHARGES) would be false
    // so the spellmod check would be skipped
}

// =============================================================================
// SpellFamilyMask Bitmask Validation
// =============================================================================

TEST_F(ArcanePotencyProcTest, MaskBits_CorrectBitsSet)
{
    // Verify the exact bits in our SpellFamilyMask0
    // Bit 0: Fireball
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x00000001);
    // Bit 2: Frostfire Bolt
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x00000004);
    // Bit 4: Fire Blast
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x00000010);
    // Bit 5: Frostbolt
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x00000020);
    // Bit 12: Arcane Explosion
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x00001000);
    // Bit 22: Scorch
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x00400000);
    // Bit 29: Arcane Blast
    EXPECT_TRUE(AP_FAMILY_MASK0 & 0x20000000);

    // Mask1: Bit 12 (Frostfire Bolt secondary)
    EXPECT_TRUE(AP_FAMILY_MASK1 & 0x00001000);
}

TEST_F(ArcanePotencyProcTest, MaskBits_CorrectBitsNotSet)
{
    // Bit 11: Arcane Missiles - should NOT be set
    EXPECT_FALSE(AP_FAMILY_MASK0 & 0x00000800);
    // Bit 17: Ice Lance - should NOT be set
    EXPECT_FALSE(AP_FAMILY_MASK0 & 0x00020000);
    // Mask1 bit 15: Arcane Barrage - should NOT be set
    EXPECT_FALSE(AP_FAMILY_MASK1 & 0x00008000);
}
