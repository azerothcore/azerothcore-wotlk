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
 * @file CascadeProcSuppressionTest.cpp
 * @brief Unit tests for cascade proc suppression via SPELL_ATTR3_INSTANT_TARGET_PROCS
 *
 * Tests the logic from Unit.cpp TriggerAurasProcOnEvent:
 * - Outer check: Spell::IsProcDisabled() (TRIGGERED_DISALLOW_PROC_EVENTS) suppresses all cascade procs
 * - Per-aura check: SPELL_ATTR3_INSTANT_TARGET_PROCS (0x80000) suppresses cascade for that aura
 * - Normal spells/auras without these flags allow cascading
 * - Both flags set simultaneously still suppresses correctly
 */

#include "ProcChanceTestHelper.h"
#include "SpellInfoTestHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class CascadeProcSuppressionTest : public ::testing::Test
{
protected:
    ProcChanceTestHelper::CascadeProcConfig MakeConfig(
        bool isProcDisabled, bool hasDisableProcAttr)
    {
        ProcChanceTestHelper::CascadeProcConfig config;
        config.triggeringSpellIsProcDisabled = isProcDisabled;
        config.auraHasDisableProcAttr = hasDisableProcAttr;
        return config;
    }
};

// =============================================================================
// Normal behavior (no suppression)
// =============================================================================

TEST_F(CascadeProcSuppressionTest, NormalSpellNormalAura_NotSuppressed)
{
    auto config = MakeConfig(false, false);

    EXPECT_FALSE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Normal spell + normal aura should not suppress cascading procs";
}

// =============================================================================
// IsProcDisabled (outer check - TRIGGERED_DISALLOW_PROC_EVENTS)
// =============================================================================

TEST_F(CascadeProcSuppressionTest, ProcDisabledSpell_NormalAura_Suppressed)
{
    auto config = MakeConfig(true, false);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Triggered spell with DISALLOW_PROC_EVENTS should suppress all cascading procs";
}

TEST_F(CascadeProcSuppressionTest, ProcDisabledSpell_WithAttr_Suppressed)
{
    auto config = MakeConfig(true, true);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Both flags set should still suppress (double-suppress doesn't break)";
}

// =============================================================================
// SPELL_ATTR3_INSTANT_TARGET_PROCS (per-aura check)
// =============================================================================

TEST_F(CascadeProcSuppressionTest, NormalSpell_AuraWithAttr_Suppressed)
{
    auto config = MakeConfig(false, true);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Aura with SPELL_ATTR3_INSTANT_TARGET_PROCS should suppress cascading procs";
}

// =============================================================================
// SpellInfo attribute verification via SpellInfoBuilder
// =============================================================================

TEST_F(CascadeProcSuppressionTest, SpellInfo_WithAttr_HasAttributeReturnsTrue)
{
    auto spellInfo = SpellInfoBuilder()
        .WithId(99001)
        .WithAttributesEx3(SPELL_ATTR3_INSTANT_TARGET_PROCS)
        .BuildUnique();

    EXPECT_TRUE(spellInfo->HasAttribute(SPELL_ATTR3_INSTANT_TARGET_PROCS))
        << "SpellInfo built with 0x80000 should report HasAttribute true";
}

TEST_F(CascadeProcSuppressionTest, SpellInfo_WithoutAttr_HasAttributeReturnsFalse)
{
    auto spellInfo = SpellInfoBuilder()
        .WithId(99002)
        .WithAttributesEx3(0)
        .BuildUnique();

    EXPECT_FALSE(spellInfo->HasAttribute(SPELL_ATTR3_INSTANT_TARGET_PROCS))
        << "SpellInfo built with 0 should report HasAttribute false";
}

TEST_F(CascadeProcSuppressionTest, SpellInfo_WithMixedBits_HasAttributeReturnsTrue)
{
    // 0x80001 = SPELL_ATTR3_INSTANT_TARGET_PROCS | SPELL_ATTR3_PVP_ENABLING (bit 0)
    auto spellInfo = SpellInfoBuilder()
        .WithId(99003)
        .WithAttributesEx3(0x00080001)
        .BuildUnique();

    EXPECT_TRUE(spellInfo->HasAttribute(SPELL_ATTR3_INSTANT_TARGET_PROCS))
        << "Other bits in AttributesEx3 should not interfere with attribute detection";
}

// =============================================================================
// Real spell scenarios (data-driven)
// These spells have SPELL_ATTR3_INSTANT_TARGET_PROCS (0x80000) in DBC
// =============================================================================

struct RealSpellTestCase
{
    const char* name;
    uint32 spellId;
    bool hasAttr;  // Whether the spell has SPELL_ATTR3_INSTANT_TARGET_PROCS
};

class CascadeProcRealSpellTest : public ::testing::TestWithParam<RealSpellTestCase> {};

TEST_P(CascadeProcRealSpellTest, VerifySuppressionForRealSpell)
{
    auto const& tc = GetParam();

    // Build a SpellInfo mimicking the real spell's AttributesEx3
    auto spellInfo = SpellInfoBuilder()
        .WithId(tc.spellId)
        .WithAttributesEx3(tc.hasAttr ? SPELL_ATTR3_INSTANT_TARGET_PROCS : 0)
        .BuildUnique();

    // Verify attribute detection matches expectation
    EXPECT_EQ(spellInfo->HasAttribute(SPELL_ATTR3_INSTANT_TARGET_PROCS), tc.hasAttr)
        << tc.name << " (spell " << tc.spellId << ") attribute detection mismatch";

    // Verify cascade suppression matches attribute presence
    ProcChanceTestHelper::CascadeProcConfig config;
    config.triggeringSpellIsProcDisabled = false;
    config.auraHasDisableProcAttr = tc.hasAttr;

    EXPECT_EQ(ProcChanceTestHelper::ShouldSuppressCascadingProc(config), tc.hasAttr)
        << tc.name << " (spell " << tc.spellId << ") cascade suppression mismatch";
}

INSTANTIATE_TEST_SUITE_P(
    CascadeProcSuppression,
    CascadeProcRealSpellTest,
    ::testing::Values(
        // Spells WITH SPELL_ATTR3_INSTANT_TARGET_PROCS
        RealSpellTestCase{"Seal Fate",             14195, true},
        RealSpellTestCase{"Sword Specialization",  12281, true},
        RealSpellTestCase{"Reckoning",             20178, true},
        RealSpellTestCase{"Flurry",                16257, true},
        // Counter-example: spell WITHOUT the attribute
        RealSpellTestCase{"Eviscerate",            26865, false}
    ),
    [](testing::TestParamInfo<RealSpellTestCase> const& info) {
        // Generate readable test name from spell name (replace spaces)
        std::string name = info.param.name;
        std::replace(name.begin(), name.end(), ' ', '_');
        return name;
    }
);

// =============================================================================
// Nesting behavior - both flags simultaneously
// =============================================================================

TEST_F(CascadeProcSuppressionTest, BothFlagsSet_StillSuppressed)
{
    auto config = MakeConfig(true, true);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Both IsProcDisabled and INSTANT_TARGET_PROCS set should still suppress";
}

TEST_F(CascadeProcSuppressionTest, OnlyOuterFlag_Suppressed)
{
    auto config = MakeConfig(true, false);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Only IsProcDisabled should be sufficient to suppress";
}

TEST_F(CascadeProcSuppressionTest, OnlyPerAuraFlag_Suppressed)
{
    auto config = MakeConfig(false, true);

    EXPECT_TRUE(ProcChanceTestHelper::ShouldSuppressCascadingProc(config))
        << "Only INSTANT_TARGET_PROCS should be sufficient to suppress";
}
