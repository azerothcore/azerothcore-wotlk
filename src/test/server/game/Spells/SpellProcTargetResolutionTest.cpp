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
 * @file SpellProcTargetResolutionTest.cpp
 * @brief Tests for smart proc trigger target resolution
 *
 * Verifies the targeting expression used in HandleProcTriggerSpellAuraProc
 * and HandleProcTriggerSpellWithValueAuraProc:
 *
 *   triggerTarget = (triggerCaster == actor) ? actionTarget : actor
 *
 * This expression correctly resolves targets for all proc scenarios:
 * - Actor-side HIT phase: triggerCaster==actor, returns enemy (actionTarget)
 * - Actor-side FINISH phase: triggerCaster==actor, returns nullptr (actionTarget
 *   is nullptr because FINISH phase passes no victim)
 * - Victim-side HIT phase: triggerCaster!=actor, returns attacker (actor)
 */

#include "ProcEventInfoHelper.h"
#include "Unit.h"
#include "gtest/gtest.h"

// Use fake Unit* pointers for testing. The smart targeting expression only
// performs pointer comparison (==), never dereferences, so these are safe.
namespace
{
    Unit* const FAKE_ROGUE   = reinterpret_cast<Unit*>(uintptr_t(0x1000));
    Unit* const FAKE_ENEMY   = reinterpret_cast<Unit*>(uintptr_t(0x2000));
}

/**
 * @brief Applies the smart targeting expression from SpellAuraEffects.cpp
 *
 * This mirrors the logic in HandleProcTriggerSpellAuraProc:
 *   Unit* triggerCaster = aurApp->GetTarget();  // the aura owner
 *   Unit* triggerTarget = triggerCaster == eventInfo.GetActor()
 *                         ? eventInfo.GetActionTarget()
 *                         : eventInfo.GetActor();
 */
static Unit* ResolveProcTriggerTarget(Unit* triggerCaster, ProcEventInfo& eventInfo)
{
    return triggerCaster == eventInfo.GetActor()
        ? eventInfo.GetActionTarget()
        : eventInfo.GetActor();
}

class SpellProcTargetResolutionTest : public ::testing::Test {};

// =============================================================================
// Actor-side proc scenarios (aura owner == event actor)
// =============================================================================

TEST_F(SpellProcTargetResolutionTest, ActorSide_HitPhase_TargetsEnemy)
{
    // Scenario: Rogue has Ruthlessness aura, casts Eviscerate on enemy.
    // HIT phase: actor=Rogue, actionTarget=Enemy
    // triggerCaster is the aura owner (Rogue), which == actor
    // Result: returns actionTarget (Enemy)
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(FAKE_ENEMY)
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    Unit* triggerCaster = FAKE_ROGUE; // aura owner
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, FAKE_ENEMY);
}

TEST_F(SpellProcTargetResolutionTest, ActorSide_FinishPhase_ReturnsNullptr)
{
    // Scenario: Rogue has Ruthlessness aura, finishes Eviscerate.
    // FINISH phase: actor=Rogue, actionTarget=nullptr (no victim passed)
    // triggerCaster is the aura owner (Rogue), which == actor
    // Result: returns nullptr (CastSpell handles this via implicit targeting)
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(nullptr)
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_FINISH)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    Unit* triggerCaster = FAKE_ROGUE; // aura owner
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, nullptr);
}

TEST_F(SpellProcTargetResolutionTest, ActorSide_CastPhase_TargetsEnemy)
{
    // Scenario: Actor-side CAST phase proc (e.g., Nature's Grace).
    // actor=Rogue, actionTarget=Enemy
    // triggerCaster == actor, returns actionTarget
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(FAKE_ENEMY)
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_CAST)
        .Build();

    Unit* triggerCaster = FAKE_ROGUE;
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, FAKE_ENEMY);
}

// =============================================================================
// Victim-side proc scenarios (aura owner != event actor)
// =============================================================================

TEST_F(SpellProcTargetResolutionTest, VictimSide_HitPhase_TargetsAttacker)
{
    // Scenario: Enemy has a "when hit" proc aura. Rogue hits Enemy.
    // HIT phase: actor=Rogue (attacker), actionTarget=Enemy (victim)
    // triggerCaster is the aura owner (Enemy), which != actor (Rogue)
    // Result: returns actor (Rogue) — the attacker
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(FAKE_ENEMY)
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    Unit* triggerCaster = FAKE_ENEMY; // aura owner (victim)
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, FAKE_ROGUE);
}

// =============================================================================
// Edge cases
// =============================================================================

TEST_F(SpellProcTargetResolutionTest, ActorSide_NullActionTarget_ReturnsNullptr)
{
    // Generic test: when actor-side proc has nullptr actionTarget,
    // result is nullptr regardless of phase
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(nullptr)
        .WithTypeMask(PROC_FLAG_DONE_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    Unit* triggerCaster = FAKE_ROGUE;
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, nullptr);
}

TEST_F(SpellProcTargetResolutionTest, VictimSide_NullActionTarget_StillReturnsActor)
{
    // When victim-side proc has nullptr actionTarget, the expression
    // still returns actor (the attacker) since triggerCaster != actor
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(nullptr)
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    Unit* triggerCaster = FAKE_ENEMY; // aura owner (victim), != actor
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, FAKE_ROGUE);
}

TEST_F(SpellProcTargetResolutionTest, SelfProc_ActorIsActionTarget)
{
    // Edge case: actor == actionTarget (self-damage/self-heal)
    // triggerCaster == actor, returns actionTarget (which is also actor)
    auto eventInfo = ProcEventInfoBuilder()
        .WithActor(FAKE_ROGUE)
        .WithActionTarget(FAKE_ROGUE)
        .WithTypeMask(PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithHitMask(PROC_HIT_NORMAL)
        .Build();

    Unit* triggerCaster = FAKE_ROGUE;
    Unit* result = ResolveProcTriggerTarget(triggerCaster, eventInfo);

    EXPECT_EQ(result, FAKE_ROGUE);
}
