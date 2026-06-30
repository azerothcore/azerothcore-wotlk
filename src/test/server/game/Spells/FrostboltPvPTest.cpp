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

#include "IntegrationTestFixture.h"
#include "SpellInfoTestHelper.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "gtest/gtest.h"

#ifndef TEST_F
#define TEST_F(fixture, name) void fixture##_##name()
#endif

/*
 * Integration test: Mage casts Frostbolt at a Warrior in PvP.
 *
 * What we test:
 *   1. The Frostbolt slow aura (SPELL_AURA_MOD_DECREASE_SPEED) is applied
 *   2. The warrior's run speed is reduced by the correct percentage
 *   3. The spell damage matches expected base points
 *
 * What we simulate vs. what's real:
 *   ┌──────────────────────────────────────────────────────┐
 *   │  REAL (actual game code)                             │
 *   │  - SpellInfo built from SpellEntry (same as DBC)     │
 *   │  - Aura::TryRefreshStackOrCreate                     │
 *   │  - AuraEffect with SPELL_AURA_MOD_DECREASE_SPEED     │
 *   │  - Unit::UpdateSpeed applies the slow modifier       │
 *   │  - SpellNonMeleeDamage struct for damage bookkeeping │
 *   │  - Unit::GetSpeedRate / GetSpeed for verification    │
 *   ├──────────────────────────────────────────────────────┤
 *   │  SIMULATED (bypassed for test isolation)             │
 *   │  - No full Spell::prepare → cast pipeline            │
 *   │  - No target selection / LoS / range checks          │
 *   │  - Aura applied directly via Unit::AddAura           │
 *   │  - Damage dealt directly, no resist/absorb rolls     │
 *   └──────────────────────────────────────────────────────┘
 */

namespace
{

// Frostbolt Rank 14 (level 79) reference values
static constexpr uint32 FROSTBOLT_SPELL_ID     = 42842;
static constexpr int32  FROSTBOLT_BASE_DAMAGE   = 799;  // base points for effect 0
static constexpr int32  FROSTBOLT_SLOW_PCT      = -40;  // 40% speed reduction
static constexpr int32  FROSTBOLT_DURATION_MS   = 9000; // 9 seconds

class FrostboltPvPTest : public IntegrationTestFixture
{
protected:
    void SetUp() override
    {
        IntegrationTestFixture::SetUp();

        // Build a SpellInfo mimicking Frostbolt Rank 14:
        //   Effect[0]: SPELL_EFFECT_SCHOOL_DAMAGE — base 799 frost damage
        //   Effect[1]: SPELL_EFFECT_APPLY_AURA / SPELL_AURA_MOD_DECREASE_SPEED — -40%
        _frostboltInfo = SpellInfoBuilder()
            .WithId(FROSTBOLT_SPELL_ID)
            .WithSpellFamilyName(SPELLFAMILY_MAGE)
            .WithSpellFamilyFlags(0x20)          // Frostbolt family flag
            .WithSchoolMask(SPELL_SCHOOL_MASK_FROST)
            .WithDmgClass(SPELL_DAMAGE_CLASS_MAGIC)
            .WithEffect(0, SPELL_EFFECT_SCHOOL_DAMAGE)
            .WithEffectBasePoints(0, FROSTBOLT_BASE_DAMAGE)
            .WithEffect(1, SPELL_EFFECT_APPLY_AURA, SPELL_AURA_MOD_DECREASE_SPEED)
            .WithEffectBasePoints(1, FROSTBOLT_SLOW_PCT)
            .BuildUnique();

        // Create a SpellDurationEntry so the aura has a real duration
        _durationEntry = {};
        _durationEntry.ID = 1;
        _durationEntry.Duration[0] = FROSTBOLT_DURATION_MS;
        _durationEntry.Duration[1] = FROSTBOLT_DURATION_MS;
        _durationEntry.Duration[2] = FROSTBOLT_DURATION_MS;
        // Patch the SpellInfo's DurationEntry pointer
        const_cast<SpellInfo*>(_frostboltInfo.get())->DurationEntry = &_durationEntry;
    }

    std::unique_ptr<SpellInfo> _frostboltInfo;
    SpellDurationEntry _durationEntry;
};

// ─────────────────────────────────────────────────────────
// TEST: Frostbolt slow aura is applied and reduces speed
// ─────────────────────────────────────────────────────────
//
//   ┌───────────┐   Frostbolt   ┌───────────┐
//   │   Mage    │ ────────────► │  Warrior  │
//   │ (player)  │               │ (player)  │
//   └───────────┘               └───────────┘
//                                     │
//                               ┌─────▼─────┐
//                               │ Slow Aura  │
//                               │  -40% spd  │
//                               └───────────┘
//
TEST_F(FrostboltPvPTest, SlowAuraAppliedAndReducesSpeed)
{
    auto* mage    = CreateTestPlayer(1, "Frostmage");
    auto* warrior = CreateTestPlayer(2, "Berserker");

    // Record the warrior's baseline run speed rate (should be 1.0)
    float baseSpeedRate = warrior->GetSpeedRate(MOVE_RUN);
    ASSERT_FLOAT_EQ(baseSpeedRate, 1.0f)
        << "Warrior should start at 100% run speed";

    // Mage applies the Frostbolt aura (effect index 1 = slow) on the warrior.
    // effMask 0x2 = only effect[1] (the APPLY_AURA slow), skipping effect[0] (damage).
    Aura* slowAura = mage->AddAura(_frostboltInfo.get(), 0x2, warrior);
    ASSERT_NE(slowAura, nullptr) << "Frostbolt slow aura should be created";

    // Verify the aura is on the warrior
    EXPECT_TRUE(warrior->HasAura(FROSTBOLT_SPELL_ID))
        << "Warrior should have the Frostbolt aura";

    // Verify aura duration
    EXPECT_EQ(slowAura->GetMaxDuration(), FROSTBOLT_DURATION_MS);

    // Verify the slow amount on the aura effect
    AuraEffect const* slowEffect = slowAura->GetEffect(1);
    ASSERT_NE(slowEffect, nullptr);
    EXPECT_EQ(slowEffect->GetAmount(), FROSTBOLT_SLOW_PCT)
        << "Slow effect should be -40%";

    // Verify the warrior's run speed is actually reduced.
    // UpdateSpeed was called by HandleAuraModDecreaseSpeed.
    // Formula: speed = max(non_stack_bonus, stack_bonus) → 1.0
    //          then AddPct(speed, -40) → 1.0 * (1 + (-40/100)) = 0.60
    float expectedSpeedRate = 0.60f;
    EXPECT_NEAR(warrior->GetSpeedRate(MOVE_RUN), expectedSpeedRate, 0.01f)
        << "Warrior run speed should be 60% (slowed by 40%)";

    // Walk speed should also be reduced
    EXPECT_NEAR(warrior->GetSpeedRate(MOVE_WALK), expectedSpeedRate, 0.01f)
        << "Warrior walk speed should also be reduced by 40%";
}

// ─────────────────────────────────────────────────────────
// TEST: Frostbolt damage matches expected base points
// ─────────────────────────────────────────────────────────
TEST_F(FrostboltPvPTest, DamageMatchesBasePoints)
{
    auto* mage    = CreateTestPlayer(1, "Frostmage");
    auto* warrior = CreateTestPlayer(2, "Berserker");

    // Set warrior health high enough to survive
    warrior->SetMaxHealth(50000);
    warrior->SetHealth(50000);

    // The SpellInfo's effect[0] base damage
    int32 baseDamage = _frostboltInfo->Effects[0].CalcValue(mage);
    EXPECT_EQ(baseDamage, FROSTBOLT_BASE_DAMAGE)
        << "Base damage should match Frostbolt Rank 14";

    // Simulate the damage using SpellNonMeleeDamage (same struct the real
    // spell pipeline uses to track damage/absorb/resist per hit).
    SpellNonMeleeDamage dmgInfo(mage, warrior, _frostboltInfo.get(),
        SPELL_SCHOOL_MASK_FROST);
    dmgInfo.damage = baseDamage;

    // Record health before
    uint32 healthBefore = warrior->GetHealth();

    // Deal the damage through the real DealDamage path
    Unit::DealDamage(mage, warrior, dmgInfo.damage, nullptr,
        SPELL_DIRECT_DAMAGE, SPELL_SCHOOL_MASK_FROST, _frostboltInfo.get());

    uint32 healthAfter = warrior->GetHealth();
    uint32 actualDamage = healthBefore - healthAfter;

    // With no spell power, no resilience, no armor (frost is magic),
    // and no absorb shields, the damage dealt equals base damage.
    EXPECT_EQ(actualDamage, uint32(FROSTBOLT_BASE_DAMAGE))
        << "Damage dealt should equal base points with no modifiers";
}

// ─────────────────────────────────────────────────────────
// TEST: Removing the aura restores full speed
// ─────────────────────────────────────────────────────────
TEST_F(FrostboltPvPTest, RemovingSlowRestoresSpeed)
{
    auto* mage    = CreateTestPlayer(1, "Frostmage");
    auto* warrior = CreateTestPlayer(2, "Berserker");

    // Apply slow
    mage->AddAura(_frostboltInfo.get(), 0x2, warrior);
    ASSERT_NEAR(warrior->GetSpeedRate(MOVE_RUN), 0.60f, 0.01f);

    // Remove the aura (dispel / expiry)
    warrior->RemoveAurasDueToSpell(FROSTBOLT_SPELL_ID);

    // Speed should be back to normal
    EXPECT_FLOAT_EQ(warrior->GetSpeedRate(MOVE_RUN), 1.0f)
        << "Speed should return to 100% after slow is removed";
}

// ─────────────────────────────────────────────────────────
// TEST: Full scenario — slow + damage in sequence
// ─────────────────────────────────────────────────────────
//
//   Timeline:
//   ┌─────────┬──────────────┬──────────────┬────────────┐
//   │  Start  │ Apply slow   │ Deal damage  │  Verify    │
//   │ 100%spd │ → 60% speed  │ → HP reduced │ slow+dmg   │
//   └─────────┴──────────────┴──────────────┴────────────┘
//
TEST_F(FrostboltPvPTest, FullFrostboltScenario)
{
    auto* mage    = CreateTestPlayer(1, "Frostmage");
    auto* warrior = CreateTestPlayer(2, "Berserker");

    warrior->SetMaxHealth(50000);
    warrior->SetHealth(50000);

    // Verify pre-conditions
    ASSERT_FLOAT_EQ(warrior->GetSpeedRate(MOVE_RUN), 1.0f);
    ASSERT_EQ(warrior->GetHealth(), 50000u);

    // Step 1: Apply the slow aura (effect[1] only)
    Aura* aura = mage->AddAura(_frostboltInfo.get(), 0x2, warrior);
    ASSERT_NE(aura, nullptr);

    // Step 2: Deal the damage (effect[0] simulated)
    int32 damage = _frostboltInfo->Effects[0].CalcValue(mage);
    Unit::DealDamage(mage, warrior, damage, nullptr,
        SPELL_DIRECT_DAMAGE, SPELL_SCHOOL_MASK_FROST, _frostboltInfo.get());

    // Verify both effects landed
    EXPECT_NEAR(warrior->GetSpeedRate(MOVE_RUN), 0.60f, 0.01f)
        << "Warrior should be slowed to 60%";
    EXPECT_EQ(warrior->GetHealth(), 50000u - FROSTBOLT_BASE_DAMAGE)
        << "Warrior HP should be reduced by Frostbolt base damage";
    EXPECT_TRUE(warrior->HasAura(FROSTBOLT_SPELL_ID))
        << "Warrior should still have the Frostbolt debuff";
}

} // namespace
