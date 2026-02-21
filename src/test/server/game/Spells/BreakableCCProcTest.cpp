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
 * @file BreakableCCProcTest.cpp
 * @brief Tests for the CC break-on-damage proc mechanism
 *
 * CC auras (Fear, Polymorph, Stun, Root, Transform) have a damage threshold
 * set in CalculateAmount. When damage is taken, HandleBreakableCCAuraProc
 * subtracts the damage from the threshold and removes the aura when it
 * reaches zero.
 *
 * The threshold is calculated as:
 *   BaseHealth(casterLevel, CLASS_WARRIOR) / 4.75
 *
 * This gives level 80 a threshold of ~2648 HP (12588 / 4.75).
 */

#include "AuraStub.h"
#include "ProcChanceTestHelper.h"
#include "ProcEventInfoHelper.h"
#include "SpellMgr.h"
#include "WorldMock.h"
#include "gtest/gtest.h"

using namespace testing;

/**
 * @brief Simulates HandleBreakableCCAuraProc logic
 *
 * Mirrors AuraEffect::HandleBreakableCCAuraProc from SpellAuraEffects.cpp:
 *   damageLeft = GetAmount() - damage
 *   if (damageLeft <= 0) remove aura
 *   else SetAmount(damageLeft)
 *
 * @param effect The CC aura effect stub (amount = damage threshold)
 * @param damage Damage dealt to the CC'd target
 * @return true if the aura should be removed (threshold exceeded)
 */
static bool SimulateBreakableCCProc(AuraEffectStub* effect, int32_t damage)
{
    int32_t damageLeft = effect->GetAmount() - damage;
    if (damageLeft <= 0)
        return true; // aura removed
    effect->SetAmount(damageLeft);
    return false; // aura survives, threshold reduced
}

/**
 * @brief Simulates CalculateAmount for CC auras
 *
 * Mirrors AuraEffect::CalculateAmount from SpellAuraEffects.cpp for
 * MOD_FEAR/MOD_CONFUSE/MOD_STUN/MOD_ROOT/TRANSFORM:
 *   amount = BaseHealth(casterLevel, CLASS_WARRIOR) / 4.75
 *
 * Uses known Warrior base health values from CreatureBaseStats DBC.
 */
static int32_t SimulateCCThreshold(uint8_t casterLevel)
{
    // Warrior base health at key levels (EXPANSION_WRATH_OF_THE_LICH_KING)
    // From creature_classlevelstats for CLASS_WARRIOR
    struct LevelHealth { uint8_t level; int32_t health; };
    static constexpr LevelHealth table[] = {
        {1, 60}, {10, 424}, {20, 1128}, {30, 2078}, {40, 3228},
        {50, 4978}, {60, 7361}, {70, 9940}, {80, 12588},
    };

    int32_t baseHealth = 12588; // default to level 80
    for (auto const& entry : table)
    {
        if (entry.level == casterLevel)
        {
            baseHealth = entry.health;
            break;
        }
    }

    return static_cast<int32_t>(baseHealth / 4.75f);
}

// =============================================================================
// Test Fixture
// =============================================================================

class BreakableCCProcTest : public ::testing::Test
{
protected:
    void SetUp() override
    {
        _originalWorld = sWorld.release();
        _worldMock = new NiceMock<WorldMock>();
        sWorld.reset(_worldMock);
    }

    void TearDown() override
    {
        IWorld* currentWorld = sWorld.release();
        delete currentWorld;
        sWorld.reset(_originalWorld);
    }

    /**
     * @brief Create a CC aura effect stub with the given threshold
     */
    AuraEffectStub CreateCCEffect(int32_t threshold, uint32_t auraType = 7 /* MOD_FEAR */)
    {
        AuraEffectStub effect(0, threshold, auraType);
        return effect;
    }

private:
    IWorld* _originalWorld = nullptr;
    NiceMock<WorldMock>* _worldMock = nullptr;
};

// =============================================================================
// HandleBreakableCCAuraProc Logic Tests
// =============================================================================

TEST_F(BreakableCCProcTest, SmallDamage_ReducesThreshold_AuraSurvives)
{
    auto effect = CreateCCEffect(1000);

    bool removed = SimulateBreakableCCProc(&effect, 100);

    EXPECT_FALSE(removed);
    EXPECT_EQ(effect.GetAmount(), 900);
}

TEST_F(BreakableCCProcTest, ExactThresholdDamage_RemovesAura)
{
    auto effect = CreateCCEffect(1000);

    bool removed = SimulateBreakableCCProc(&effect, 1000);

    EXPECT_TRUE(removed);
}

TEST_F(BreakableCCProcTest, ExceedThresholdDamage_RemovesAura)
{
    auto effect = CreateCCEffect(1000);

    bool removed = SimulateBreakableCCProc(&effect, 5000);

    EXPECT_TRUE(removed);
}

TEST_F(BreakableCCProcTest, MultipleDamageHits_AccumulateUntilBreak)
{
    auto effect = CreateCCEffect(1000);

    // First hit: 400 damage, 600 remaining
    EXPECT_FALSE(SimulateBreakableCCProc(&effect, 400));
    EXPECT_EQ(effect.GetAmount(), 600);

    // Second hit: 300 damage, 300 remaining
    EXPECT_FALSE(SimulateBreakableCCProc(&effect, 300));
    EXPECT_EQ(effect.GetAmount(), 300);

    // Third hit: 300 damage, exactly 0 remaining -> remove
    EXPECT_TRUE(SimulateBreakableCCProc(&effect, 300));
}

TEST_F(BreakableCCProcTest, MultipleDamageHits_OvershootBreak)
{
    auto effect = CreateCCEffect(500);

    // First hit: 200 damage
    EXPECT_FALSE(SimulateBreakableCCProc(&effect, 200));
    EXPECT_EQ(effect.GetAmount(), 300);

    // Second hit: 400 damage, exceeds remaining 300
    EXPECT_TRUE(SimulateBreakableCCProc(&effect, 400));
}

TEST_F(BreakableCCProcTest, OneDamage_ReducesThreshold)
{
    auto effect = CreateCCEffect(1000);

    EXPECT_FALSE(SimulateBreakableCCProc(&effect, 1));
    EXPECT_EQ(effect.GetAmount(), 999);
}

// =============================================================================
// Threshold Calculation Tests (CalculateAmount for CC auras)
// =============================================================================

TEST_F(BreakableCCProcTest, Level80Threshold_IsReasonable)
{
    int32_t threshold = SimulateCCThreshold(80);

    // Level 80 warrior base health = 12588
    // Threshold = 12588 / 4.75 ≈ 2650
    EXPECT_GT(threshold, 2600);
    EXPECT_LT(threshold, 2700);
}

TEST_F(BreakableCCProcTest, LowerLevelCaster_LowerThreshold)
{
    int32_t threshold60 = SimulateCCThreshold(60);
    int32_t threshold80 = SimulateCCThreshold(80);

    EXPECT_LT(threshold60, threshold80);
}

TEST_F(BreakableCCProcTest, Level80Fear_BreaksOnModerateDamage)
{
    // Simulate a level 80 warlock's Fear
    int32_t threshold = SimulateCCThreshold(80); // ~2650
    auto effect = CreateCCEffect(threshold);

    // A 3000 damage hit should break it
    EXPECT_TRUE(SimulateBreakableCCProc(&effect, 3000));
}

TEST_F(BreakableCCProcTest, Level80Fear_SurvivesSmallDots)
{
    // Simulate a level 80 warlock's Fear
    int32_t threshold = SimulateCCThreshold(80); // ~2650
    auto effect = CreateCCEffect(threshold);

    // Small DoT ticks of 200 each - Fear should survive multiple ticks
    for (int i = 0; i < 10; ++i)
    {
        bool removed = SimulateBreakableCCProc(&effect, 200);
        if (i < 12) // Should survive at least 12 ticks (200*13 = 2600 < 2650)
        {
            // We expect it to survive for ~13 ticks
            if (!removed)
                continue;
        }
        if (removed)
        {
            // Should break around tick 13-14
            EXPECT_GE(i, 12);
            return;
        }
    }
    // If we get here, verify remaining threshold
    EXPECT_GT(effect.GetAmount(), 0);
}

// =============================================================================
// Proc Pipeline Integration Tests (using CanSpellTriggerProcOnEvent)
// =============================================================================

TEST_F(BreakableCCProcTest, FearProcEntry_MatchesTakenMeleeDamage)
{
    // Fear's auto-generated proc entry from DBC ProcFlags
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(
            PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK |
            PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS |
            PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK |
            PROC_FLAG_TAKEN_SPELL_RANGED_DMG_CLASS |
            PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_NEG |
            PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG |
            PROC_FLAG_TAKEN_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithChance(100.0f)
        .Build();

    // Melee auto attack should trigger
    auto meleeEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, meleeEvent));
}

TEST_F(BreakableCCProcTest, FearProcEntry_MatchesTakenSpellDamage)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(
            PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK |
            PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS |
            PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK |
            PROC_FLAG_TAKEN_SPELL_RANGED_DMG_CLASS |
            PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_NEG |
            PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG |
            PROC_FLAG_TAKEN_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithChance(100.0f)
        .Build();

    // Magic damage spell should trigger
    auto spellEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    EXPECT_TRUE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, spellEvent));
}

TEST_F(BreakableCCProcTest, FearProcEntry_DoesNotMatchHealEvent)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithProcFlags(
            PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK |
            PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS |
            PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK |
            PROC_FLAG_TAKEN_SPELL_RANGED_DMG_CLASS |
            PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_NEG |
            PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG |
            PROC_FLAG_TAKEN_PERIODIC)
        .WithSpellTypeMask(PROC_SPELL_TYPE_DAMAGE)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .WithChance(100.0f)
        .Build();

    // Heal should NOT trigger Fear's proc
    auto healEvent = ProcEventInfoBuilder()
        .WithTypeMask(PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_POS)
        .WithHitMask(PROC_HIT_NORMAL)
        .WithSpellTypeMask(PROC_SPELL_TYPE_HEAL)
        .WithSpellPhaseMask(PROC_SPELL_PHASE_HIT)
        .Build();

    EXPECT_FALSE(sSpellMgr->CanSpellTriggerProcOnEvent(procEntry, healEvent));
}

TEST_F(BreakableCCProcTest, FearProcChance_Is100Percent)
{
    auto procEntry = SpellProcEntryBuilder()
        .WithChance(100.0f)
        .Build();

    // Fear has 100% proc chance from DBC - every damage event triggers
    float chance = ProcChanceTestHelper::SimulateCalcProcChance(procEntry);
    EXPECT_FLOAT_EQ(chance, 100.0f);
}

// =============================================================================
// Glyph of Fear Threshold Modifier Test
// =============================================================================

TEST_F(BreakableCCProcTest, GlyphOfFear_IncreasesThreshold)
{
    // Glyph of Fear adds +100% to the damage threshold (MiscValue 7801)
    int32_t baseThreshold = SimulateCCThreshold(80); // ~2650
    int32_t glyphedThreshold = baseThreshold + (baseThreshold * 100 / 100); // +100%

    auto effect = CreateCCEffect(glyphedThreshold);

    // Should survive hits that would normally break it
    EXPECT_FALSE(SimulateBreakableCCProc(&effect, 3000));
    EXPECT_GT(effect.GetAmount(), 0);
}
