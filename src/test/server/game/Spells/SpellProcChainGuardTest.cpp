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
 * @file SpellProcChainGuardTest.cpp
 * @brief Unit tests for proc chain guard and TAKEN auto-trigger logic
 *
 * Tests two fixes ported from TrinityCore:
 *
 * 1. Proc chain guard (Unit::TriggerAurasProcOnEvent):
 *    - TRIGGERED_DISALLOW_PROC_EVENTS on triggering spell blocks all
 *      cascading procs during the proc event
 *    - SPELL_ATTR3_INSTANT_TARGET_PROCS on individual auras blocks
 *      cascading procs during that specific aura's proc trigger
 *    - Prevents infinite proc loops between reactive damage auras
 *      (e.g. Molten Armor <-> Eye for an Eye)
 *
 * 2. TAKEN auto-trigger (SpellMgr::LoadSpellProcs auto-generation):
 *    - TAKEN-proc auras with SPELL_AURA_PROC_TRIGGER_SPELL or
 *      SPELL_AURA_PROC_TRIGGER_DAMAGE automatically get
 *      PROC_ATTR_TRIGGERED_CAN_PROC so they can proc from
 *      triggered spells (e.g. Mage Armor proccing from Judgement)
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

// =============================================================================
// TAKEN Auto-Trigger Logic Tests
// Simulates SpellMgr.cpp:2033-2049 auto-generation
// =============================================================================

class TakenAutoTriggerTest : public ::testing::Test
{
protected:
    void SetUp() override {}
};

TEST_F(TakenAutoTriggerTest, TakenProcTriggerSpell_SetsTriggeredCanProc)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "TAKEN proc + PROC_TRIGGER_SPELL should auto-add TRIGGERED_CAN_PROC";
}

TEST_F(TakenAutoTriggerTest, TakenProcTriggerDamage_SetsTriggeredCanProc)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG;
    config.auraName = SPELL_AURA_PROC_TRIGGER_DAMAGE;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "TAKEN proc + PROC_TRIGGER_DAMAGE should auto-add TRIGGERED_CAN_PROC";
}

TEST_F(TakenAutoTriggerTest, TakenProcOtherAura_DoesNotSetTriggeredCanProc)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_DUMMY;
    config.isAlwaysTriggeredAura = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "TAKEN proc + DUMMY aura should NOT auto-add TRIGGERED_CAN_PROC";
}

TEST_F(TakenAutoTriggerTest, DoneProcTriggerSpell_DoesNotSetTriggeredCanProc)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_DONE_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "DONE-only proc flags should NOT trigger TAKEN auto-add logic";
}

TEST_F(TakenAutoTriggerTest, NoProcFlags_DoesNotSetTriggeredCanProc)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = 0;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "Zero proc flags should NOT auto-add TRIGGERED_CAN_PROC";
}

TEST_F(TakenAutoTriggerTest, AlwaysTriggeredAura_StaysTrue)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = 0;  // No TAKEN flags
    config.auraName = SPELL_AURA_DUMMY;
    config.isAlwaysTriggeredAura = true;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "isAlwaysTriggeredAura should keep addTriggerFlag = true";
}

TEST_F(TakenAutoTriggerTest, TakenDamage_WithProcTriggerSpell_SetsFlag)
{
    // PROC_FLAG_TAKEN_DAMAGE is in TAKEN_HIT_PROC_FLAG_MASK
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_DAMAGE;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "PROC_FLAG_TAKEN_DAMAGE + PROC_TRIGGER_SPELL should set flag";
}

TEST_F(TakenAutoTriggerTest, TakenPeriodic_WithProcTriggerDamage_SetsFlag)
{
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_PERIODIC;
    config.auraName = SPELL_AURA_PROC_TRIGGER_DAMAGE;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "PROC_FLAG_TAKEN_PERIODIC + PROC_TRIGGER_DAMAGE should set flag";
}

TEST_F(TakenAutoTriggerTest, MixedDoneAndTaken_WithProcTriggerSpell_SetsFlag)
{
    // Both DONE and TAKEN flags present - TAKEN mask still matches
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_DONE_MELEE_AUTO_ATTACK
                     | PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "Mixed DONE+TAKEN flags should still trigger TAKEN auto-add";
}

TEST_F(TakenAutoTriggerTest, TakenProcModAura_DoesNotSetTriggeredCanProc)
{
    // SPELL_AURA_ADD_FLAT_MODIFIER is not PROC_TRIGGER_SPELL/DAMAGE
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_ADD_FLAT_MODIFIER;
    config.isAlwaysTriggeredAura = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "TAKEN proc + modifier aura should NOT auto-add TRIGGERED_CAN_PROC";
}

// =============================================================================
// Real spell scenarios for TAKEN auto-trigger
// =============================================================================

TEST_F(TakenAutoTriggerTest, Scenario_MoltenArmor_TakenAutoTrigger)
{
    // Molten Armor (30482): TAKEN_MELEE_AUTO_ATTACK + PROC_TRIGGER_DAMAGE
    // Note: Molten Armor has an explicit spell_proc entry so auto-gen
    // is skipped, but the logic should still apply if it didn't
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK
                     | PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS;
    config.auraName = SPELL_AURA_PROC_TRIGGER_DAMAGE;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "Molten Armor-like aura should auto-add TRIGGERED_CAN_PROC";
}

TEST_F(TakenAutoTriggerTest, Scenario_Reckoning_TakenAutoTrigger)
{
    // Reckoning (20177): TAKEN_MELEE_AUTO_ATTACK + PROC_TRIGGER_SPELL
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "Reckoning-like aura should auto-add TRIGGERED_CAN_PROC";
}

TEST_F(TakenAutoTriggerTest, Scenario_Redoubt_TakenAutoTrigger)
{
    // Redoubt (20127): TAKEN_MELEE_AUTO_ATTACK + PROC_TRIGGER_SPELL
    ProcChanceTestHelper::TakenAutoTriggerConfig config;
    config.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    config.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    config.isAlwaysTriggeredAura = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(config))
        << "Redoubt-like aura should auto-add TRIGGERED_CAN_PROC";
}

// =============================================================================
// Integration: TAKEN auto-trigger affects triggered spell filtering
// =============================================================================

TEST_F(TakenAutoTriggerTest, AutoGenTriggeredCanProc_AllowsTriggeredSpells)
{
    // Verify that when TAKEN auto-trigger sets addTriggerFlag,
    // the resulting proc entry with PROC_ATTR_TRIGGERED_CAN_PROC
    // allows triggered spells through the filter

    // Step 1: Auto-trigger logic says yes
    ProcChanceTestHelper::TakenAutoTriggerConfig autoConfig;
    autoConfig.procFlags = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    autoConfig.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    ASSERT_TRUE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(autoConfig));

    // Step 2: Build proc entry with the auto-added attribute
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithAttributesMask(PROC_ATTR_TRIGGERED_CAN_PROC)
        .WithChance(100.0f)
        .Build();

    // Step 3: Verify triggered spells pass through the filter
    ProcChanceTestHelper::TriggeredSpellConfig trigConfig;
    trigConfig.isTriggered = true;  // e.g. Judgement damage is triggered
    trigConfig.auraHasCanProcFromProcs = false;
    trigConfig.spellHasNotAProc = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        trigConfig, procEntry, PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK))
        << "Auto-generated TRIGGERED_CAN_PROC should allow triggered spells";
}

TEST_F(TakenAutoTriggerTest, WithoutAutoTrigger_TriggeredSpellsBlocked)
{
    // Without the TAKEN auto-trigger, DONE-only proc auras would block
    // triggered spells (no TRIGGERED_CAN_PROC set)

    ProcChanceTestHelper::TakenAutoTriggerConfig autoConfig;
    autoConfig.procFlags = PROC_FLAG_DONE_MELEE_AUTO_ATTACK;  // DONE only
    autoConfig.auraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    ASSERT_FALSE(ProcChanceTestHelper::ShouldAutoAddTriggeredCanProc(autoConfig));

    // Build proc entry WITHOUT TRIGGERED_CAN_PROC
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithAttributesMask(0)  // No TRIGGERED_CAN_PROC
        .WithChance(100.0f)
        .Build();

    // Triggered spells should be blocked
    ProcChanceTestHelper::TriggeredSpellConfig trigConfig;
    trigConfig.isTriggered = true;
    trigConfig.auraHasCanProcFromProcs = false;
    trigConfig.spellHasNotAProc = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockTriggeredSpell(
        trigConfig, procEntry, PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG))
        << "Without TRIGGERED_CAN_PROC, triggered spells should be blocked";
}

// =============================================================================
// Proc Chain Guard Tests - simulates Unit::TriggerAurasProcOnEvent
// =============================================================================

class ProcChainGuardTest : public ::testing::Test
{
protected:
    void SetUp() override {}

    ProcChainGuardSimulator _sim;
};

// -----------------------------------------------------------------------------
// TRIGGERED_DISALLOW_PROC_EVENTS behavior
// -----------------------------------------------------------------------------

TEST_F(ProcChainGuardTest, DisallowProcEvents_BlocksAllAuras)
{
    // When triggering spell has TRIGGERED_DISALLOW_PROC_EVENTS,
    // all auras should fire with CanProc() == false
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = false},
        {.spellId = 200, .hasInstantTargetProcs = false},
        {.spellId = 300, .hasInstantTargetProcs = false},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/true, auras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 3u);

    for (auto const& rec : records)
    {
        EXPECT_FALSE(rec.canProcDuringTrigger)
            << "Aura " << rec.spellId
            << " should have CanProc()=false with DISALLOW_PROC_EVENTS";
        EXPECT_EQ(rec.procDeepDuringTrigger, 1)
            << "m_procDeep should be 1 for all auras";
    }
}

TEST_F(ProcChainGuardTest, DisallowProcEvents_CounterBalanced)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/true, auras);

    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "m_procDeep should return to 0 after function exits";
    EXPECT_TRUE(_sim.CanProc())
        << "CanProc() should be true after function exits";
}

TEST_F(ProcChainGuardTest, NoDisallowProcEvents_AllAurasCanProc)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = false},
        {.spellId = 200, .hasInstantTargetProcs = false},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 2u);

    for (auto const& rec : records)
    {
        EXPECT_TRUE(rec.canProcDuringTrigger)
            << "Aura " << rec.spellId
            << " should have CanProc()=true without DISALLOW_PROC_EVENTS";
        EXPECT_EQ(rec.procDeepDuringTrigger, 0);
    }
}

// -----------------------------------------------------------------------------
// SPELL_ATTR3_INSTANT_TARGET_PROCS per-aura behavior
// -----------------------------------------------------------------------------

TEST_F(ProcChainGuardTest, InstantTargetProcs_BlocksDuringSpecificAura)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = false},
        {.spellId = 200, .hasInstantTargetProcs = true},   // This one blocks
        {.spellId = 300, .hasInstantTargetProcs = false},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 3u);

    // Aura 100: normal, can proc
    EXPECT_TRUE(records[0].canProcDuringTrigger)
        << "First aura (no INSTANT_TARGET_PROCS) should allow procs";
    EXPECT_EQ(records[0].procDeepDuringTrigger, 0);

    // Aura 200: has INSTANT_TARGET_PROCS, blocked
    EXPECT_FALSE(records[1].canProcDuringTrigger)
        << "Aura with INSTANT_TARGET_PROCS should block procs during its trigger";
    EXPECT_EQ(records[1].procDeepDuringTrigger, 1);

    // Aura 300: normal again, can proc (counter was decremented)
    EXPECT_TRUE(records[2].canProcDuringTrigger)
        << "Next aura after INSTANT_TARGET_PROCS should allow procs again";
    EXPECT_EQ(records[2].procDeepDuringTrigger, 0);
}

TEST_F(ProcChainGuardTest, InstantTargetProcs_CounterBalanced)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = true},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "m_procDeep should return to 0 after INSTANT_TARGET_PROCS aura";
    EXPECT_TRUE(_sim.CanProc());
}

TEST_F(ProcChainGuardTest, MultipleInstantTargetProcs_EachIndependent)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = true},
        {.spellId = 200, .hasInstantTargetProcs = true},
        {.spellId = 300, .hasInstantTargetProcs = true},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 3u);

    // Each aura should independently block during its own trigger
    for (auto const& rec : records)
    {
        EXPECT_FALSE(rec.canProcDuringTrigger)
            << "Aura " << rec.spellId
            << " with INSTANT_TARGET_PROCS should block during trigger";
        EXPECT_EQ(rec.procDeepDuringTrigger, 1)
            << "Each aura should increment to exactly 1 (not accumulate)";
    }

    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "Counter should be balanced after all auras processed";
}

// -----------------------------------------------------------------------------
// Combined: DISALLOW_PROC_EVENTS + INSTANT_TARGET_PROCS
// -----------------------------------------------------------------------------

TEST_F(ProcChainGuardTest, Combined_DisallowAndInstantTarget_StackCorrectly)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = false},
        {.spellId = 200, .hasInstantTargetProcs = true},
        {.spellId = 300, .hasInstantTargetProcs = false},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/true, auras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 3u);

    // Aura 100: disableProcs active, procDeep=1
    EXPECT_FALSE(records[0].canProcDuringTrigger);
    EXPECT_EQ(records[0].procDeepDuringTrigger, 1);

    // Aura 200: disableProcs + INSTANT_TARGET_PROCS, procDeep=2
    EXPECT_FALSE(records[1].canProcDuringTrigger);
    EXPECT_EQ(records[1].procDeepDuringTrigger, 2)
        << "DISALLOW_PROC_EVENTS + INSTANT_TARGET_PROCS should stack to 2";

    // Aura 300: back to just disableProcs, procDeep=1
    EXPECT_FALSE(records[2].canProcDuringTrigger);
    EXPECT_EQ(records[2].procDeepDuringTrigger, 1);

    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "Counter should be balanced after combined scenario";
}

// -----------------------------------------------------------------------------
// Removed aura handling
// -----------------------------------------------------------------------------

TEST_F(ProcChainGuardTest, RemovedAura_SkippedInLoop)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = false, .isRemoved = false},
        {.spellId = 200, .hasInstantTargetProcs = true,  .isRemoved = true},
        {.spellId = 300, .hasInstantTargetProcs = false, .isRemoved = false},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 2u)
        << "Removed aura should be skipped";

    EXPECT_EQ(records[0].spellId, 100u);
    EXPECT_EQ(records[1].spellId, 300u);

    // The INSTANT_TARGET_PROCS aura was removed, so it shouldn't affect
    // the counter for the next aura
    EXPECT_TRUE(records[1].canProcDuringTrigger);
}

TEST_F(ProcChainGuardTest, RemovedAuraWithInstantProcs_DoesNotAffectCounter)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras = {
        {.spellId = 100, .hasInstantTargetProcs = true, .isRemoved = true},
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    EXPECT_EQ(_sim.GetRecords().size(), 0u);
    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "Removed aura should not touch the proc deep counter";
}

// -----------------------------------------------------------------------------
// Empty container
// -----------------------------------------------------------------------------

TEST_F(ProcChainGuardTest, EmptyContainer_NoEffect)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras;

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, auras);

    EXPECT_EQ(_sim.GetRecords().size(), 0u);
    EXPECT_EQ(_sim.GetProcDeep(), 0);
}

TEST_F(ProcChainGuardTest, EmptyContainer_WithDisallowProc_StillBalanced)
{
    std::vector<ProcChainGuardSimulator::AuraConfig> auras;

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/true, auras);

    EXPECT_EQ(_sim.GetRecords().size(), 0u);
    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "Even with disableProcs and empty container, counter should balance";
}

// =============================================================================
// Real spell scenarios for proc chain guard
// =============================================================================

TEST_F(ProcChainGuardTest, Scenario_MoltenArmorVsEyeForAnEye)
{
    // Molten Armor (43046) has SPELL_ATTR3_INSTANT_TARGET_PROCS
    // When Molten Armor deals fire damage to an attacker, that damage
    // should not trigger the attacker's reactive procs (Eye for an Eye)
    // back on the mage, preventing infinite ping-pong

    // Mage's perspective: paladin hits mage, mage's auras proc
    std::vector<ProcChainGuardSimulator::AuraConfig> mageAuras = {
        {.spellId = 43046, .hasInstantTargetProcs = true},  // Molten Armor
    };

    // The paladin's melee hit is NOT TRIGGERED_DISALLOW_PROC_EVENTS
    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, mageAuras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 1u);

    // During Molten Armor's proc trigger, CanProc() is false
    // This means the fire damage it deals cannot trigger further procs
    EXPECT_FALSE(records[0].canProcDuringTrigger)
        << "Molten Armor proc should block cascading procs (prevents EfaE loop)";

    EXPECT_EQ(_sim.GetProcDeep(), 0)
        << "Counter balanced after Molten Armor scenario";
}

TEST_F(ProcChainGuardTest, Scenario_SealOfRighteousness_TriggeredDamage)
{
    // SoR bonus damage is triggered with TRIGGERED_DISALLOW_PROC_EVENTS
    // It should not trigger the target's reactive damage auras back

    std::vector<ProcChainGuardSimulator::AuraConfig> targetAuras = {
        {.spellId = 43046, .hasInstantTargetProcs = true},  // Molten Armor
        {.spellId = 12345, .hasInstantTargetProcs = false}, // Some other aura
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/true, targetAuras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 2u);

    // All auras should see CanProc() = false
    for (auto const& rec : records)
    {
        EXPECT_FALSE(rec.canProcDuringTrigger)
            << "All target auras should be blocked when SoR damage"
            << " has DISALLOW_PROC_EVENTS";
    }
}

TEST_F(ProcChainGuardTest, Scenario_NormalMeleeHit_AurasCanProc)
{
    // A normal melee swing should allow all auras to proc normally
    // (no DISALLOW_PROC_EVENTS, no INSTANT_TARGET_PROCS)

    std::vector<ProcChainGuardSimulator::AuraConfig> targetAuras = {
        {.spellId = 20177, .hasInstantTargetProcs = false}, // Reckoning
        {.spellId = 20127, .hasInstantTargetProcs = false}, // Redoubt
        {.spellId = 16958, .hasInstantTargetProcs = false}, // Blood Craze
    };

    _sim.SimulateTriggerAurasProc(/*disallowProcEvents=*/false, targetAuras);

    auto const& records = _sim.GetRecords();
    ASSERT_EQ(records.size(), 3u);

    for (auto const& rec : records)
    {
        EXPECT_TRUE(rec.canProcDuringTrigger)
            << "Aura " << rec.spellId
            << " should proc normally from a regular melee hit";
        EXPECT_EQ(rec.procDeepDuringTrigger, 0);
    }
}
