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
 * @file SpellProcConditionsTest.cpp
 * @brief Unit tests for conditions system integration in proc system
 *
 * Tests the logic from SpellAuras.cpp:2232-2236:
 * - CONDITION_SOURCE_TYPE_SPELL_PROC (24) lookup
 * - Condition met allows proc
 * - Condition not met blocks proc
 * - Empty conditions allow proc
 * - Multiple conditions (AND logic within ElseGroup)
 * - ElseGroup OR logic
 *
 * ============================================================================
 * TEST DESIGN: Configuration-Based Testing
 * ============================================================================
 *
 * These tests use ConditionsConfig structs to simulate the result of
 * condition evaluation without requiring actual ConditionMgr queries.
 * Each test configures:
 * - sourceType: The condition source type (24 = CONDITION_SOURCE_TYPE_SPELL_PROC)
 * - hasConditions: Whether any conditions are registered for this spell
 * - conditionsMet: The result of ConditionMgr::IsObjectMeetToConditions()
 *
 * The actual condition types (CONDITION_AURA, CONDITION_HP_PCT, etc.) are
 * not evaluated here - we test the proc system's response to condition
 * evaluation results. Individual condition types are tested in the
 * conditions system unit tests.
 *
 * No GTEST_SKIP() is used in this file - all tests run with their configured
 * scenarios, testing both positive and negative cases explicitly.
 * ============================================================================
 */

#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "gtest/gtest.h"

using namespace testing;

class SpellProcConditionsTest : public ::testing::Test
{
protected:
    void SetUp() override {}
};

// =============================================================================
// Basic Condition Tests
// =============================================================================

TEST_F(SpellProcConditionsTest, NoConditions_AllowsProc)
{
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = false;  // No conditions registered

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "No conditions should allow proc";
}

TEST_F(SpellProcConditionsTest, ConditionsMet_AllowsProc)
{
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "Conditions met should allow proc";
}

TEST_F(SpellProcConditionsTest, ConditionsNotMet_BlocksProc)
{
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "Conditions not met should block proc";
}

// =============================================================================
// Source Type Tests - CONDITION_SOURCE_TYPE_SPELL_PROC = 24
// =============================================================================

TEST_F(SpellProcConditionsTest, SourceType_SpellProc)
{
    ProcChanceTestHelper::ConditionsConfig config;
    config.sourceType = 24;  // CONDITION_SOURCE_TYPE_SPELL_PROC
    config.hasConditions = true;
    config.conditionsMet = true;

    EXPECT_EQ(config.sourceType, 24u)
        << "Source type should be CONDITION_SOURCE_TYPE_SPELL_PROC (24)";
    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

// =============================================================================
// Multiple Conditions Scenarios (AND Logic)
// =============================================================================

TEST_F(SpellProcConditionsTest, MultipleConditions_AllMet_AllowsProc)
{
    // Simulating multiple conditions in same ElseGroup (AND)
    // In reality, ConditionMgr evaluates all - we just test the result
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;  // All conditions passed

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "All conditions met (AND) should allow proc";
}

TEST_F(SpellProcConditionsTest, MultipleConditions_OneFails_BlocksProc)
{
    // One condition in the group fails
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = false;  // At least one condition failed

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "One failed condition (AND) should block proc";
}

// =============================================================================
// ElseGroup OR Logic Scenarios
// =============================================================================

TEST_F(SpellProcConditionsTest, ElseGroup_OneGroupPasses_AllowsProc)
{
    // ElseGroup logic: any group passing means conditions met
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;  // At least one group passed

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "At least one ElseGroup passing should allow proc";
}

TEST_F(SpellProcConditionsTest, ElseGroup_AllGroupsFail_BlocksProc)
{
    // All ElseGroups fail
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = false;  // No groups passed

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "All ElseGroups failing should block proc";
}

// =============================================================================
// Real Spell Scenarios
// =============================================================================

TEST_F(SpellProcConditionsTest, Scenario_ProcOnlyInCombat)
{
    // Condition: Player must be in combat
    ProcChanceTestHelper::ConditionsConfig inCombat;
    inCombat.hasConditions = true;
    inCombat.conditionsMet = true;  // In combat

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(inCombat))
        << "Proc should work when in combat";

    ProcChanceTestHelper::ConditionsConfig outOfCombat;
    outOfCombat.hasConditions = true;
    outOfCombat.conditionsMet = false;  // Out of combat

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(outOfCombat))
        << "Proc should be blocked when out of combat";
}

TEST_F(SpellProcConditionsTest, Scenario_ProcOnlyVsUndead)
{
    // Condition: Target must be undead creature type
    ProcChanceTestHelper::ConditionsConfig vsUndead;
    vsUndead.hasConditions = true;
    vsUndead.conditionsMet = true;  // Target is undead

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(vsUndead))
        << "Proc should work against undead";

    ProcChanceTestHelper::ConditionsConfig vsHumanoid;
    vsHumanoid.hasConditions = true;
    vsHumanoid.conditionsMet = false;  // Target is humanoid

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(vsHumanoid))
        << "Proc should be blocked against non-undead";
}

TEST_F(SpellProcConditionsTest, Scenario_ProcRequiresAura)
{
    // Condition: Actor must have specific aura
    ProcChanceTestHelper::ConditionsConfig hasAura;
    hasAura.hasConditions = true;
    hasAura.conditionsMet = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(hasAura))
        << "Proc should work when required aura is present";

    ProcChanceTestHelper::ConditionsConfig noAura;
    noAura.hasConditions = true;
    noAura.conditionsMet = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(noAura))
        << "Proc should be blocked when required aura is missing";
}

TEST_F(SpellProcConditionsTest, Scenario_ProcRequiresHealthBelow)
{
    // Condition: Actor health must be below threshold
    ProcChanceTestHelper::ConditionsConfig lowHealth;
    lowHealth.hasConditions = true;
    lowHealth.conditionsMet = true;  // Health below 35%

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(lowHealth))
        << "Proc should work when health is below threshold";

    ProcChanceTestHelper::ConditionsConfig highHealth;
    highHealth.hasConditions = true;
    highHealth.conditionsMet = false;  // Health above 35%

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(highHealth))
        << "Proc should be blocked when health is above threshold";
}

TEST_F(SpellProcConditionsTest, Scenario_ProcInAreaOnly)
{
    // Condition: Must be in specific zone/area
    ProcChanceTestHelper::ConditionsConfig inArea;
    inArea.hasConditions = true;
    inArea.conditionsMet = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(inArea))
        << "Proc should work when in required area";

    ProcChanceTestHelper::ConditionsConfig notInArea;
    notInArea.hasConditions = true;
    notInArea.conditionsMet = false;

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(notInArea))
        << "Proc should be blocked when not in required area";
}

// =============================================================================
// Condition Type Scenarios (Common CONDITION_* types used with procs)
// =============================================================================

TEST_F(SpellProcConditionsTest, ConditionType_Aura)
{
    // CONDITION_AURA = 1
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

TEST_F(SpellProcConditionsTest, ConditionType_Item)
{
    // CONDITION_ITEM = 2
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

TEST_F(SpellProcConditionsTest, ConditionType_ItemEquipped)
{
    // CONDITION_ITEM_EQUIPPED = 3
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = false;  // Required item not equipped

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "Proc blocked when required item not equipped";
}

TEST_F(SpellProcConditionsTest, ConditionType_QuestRewarded)
{
    // CONDITION_QUESTREWARDED = 8
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;  // Required quest completed

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "Proc allowed when quest completed";
}

TEST_F(SpellProcConditionsTest, ConditionType_CreatureType)
{
    // CONDITION_CREATURE_TYPE = 18
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = false;  // Wrong creature type

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "Proc blocked when creature type doesn't match";
}

TEST_F(SpellProcConditionsTest, ConditionType_HPVal)
{
    // CONDITION_HP_VAL = 23
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;  // HP threshold met

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

TEST_F(SpellProcConditionsTest, ConditionType_HPPct)
{
    // CONDITION_HP_PCT = 25
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = false;  // HP percent threshold not met

    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

TEST_F(SpellProcConditionsTest, ConditionType_InCombat)
{
    // CONDITION_IN_COMBAT = 36
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;  // In combat

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

// =============================================================================
// Edge Cases
// =============================================================================

TEST_F(SpellProcConditionsTest, EdgeCase_EmptyConditionList)
{
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = false;
    config.conditionsMet = false;  // Doesn't matter when no conditions

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config))
        << "Empty condition list should allow proc";
}

TEST_F(SpellProcConditionsTest, EdgeCase_ConditionsButAlwaysTrue)
{
    // Conditions exist but are always satisfied (e.g., always-true condition)
    ProcChanceTestHelper::ConditionsConfig config;
    config.hasConditions = true;
    config.conditionsMet = true;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(config));
}

TEST_F(SpellProcConditionsTest, EdgeCase_MultipleSourceTypes)
{
    // Different source types shouldn't interfere
    // Each spell proc has its own conditions by spell ID
    ProcChanceTestHelper::ConditionsConfig spell1;
    spell1.sourceType = 24;
    spell1.hasConditions = true;
    spell1.conditionsMet = true;

    ProcChanceTestHelper::ConditionsConfig spell2;
    spell2.sourceType = 24;
    spell2.hasConditions = true;
    spell2.conditionsMet = false;

    EXPECT_FALSE(ProcChanceTestHelper::ShouldBlockDueToConditions(spell1));
    EXPECT_TRUE(ProcChanceTestHelper::ShouldBlockDueToConditions(spell2));
}
