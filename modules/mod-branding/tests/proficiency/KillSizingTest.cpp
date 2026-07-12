#include "branding/proficiency/KillSizing.h"
#include "fakes/FakeConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// --- difficultyMul band boundaries (§7.4) ---

// An at/above-level kill (red/orange/yellow -> Full) is worth full effort: multiplier exactly 1.0.
TEST(KillSizing, DifficultyMulFullIsOne)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.25;
    EXPECT_DOUBLE_EQ(DifficultyMul(KillBand::Full, cfg), 1.0);
}

// A grey (trivial) kill floors at cfg.GreyFloor() -- never 0, so ambient kills still pay.
TEST(KillSizing, DifficultyMulGreyEqualsFloor)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.25;
    EXPECT_DOUBLE_EQ(DifficultyMul(KillBand::Grey, cfg), 0.25);
}

// The grey floor is always > 0 for any positive configured floor: "anywhere" earning holds.
TEST(KillSizing, DifficultyMulGreyIsStrictlyPositive)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.05;
    EXPECT_GT(DifficultyMul(KillBand::Grey, cfg), 0.0);
}

// Green is the taper midpoint between the grey floor and full worth -- strictly between the two,
// so "harder = more" holds monotonically across Grey < Green < Full without any grey->0 cliff.
TEST(KillSizing, DifficultyMulGreenIsBetweenFloorAndFull)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.25;

    double const green = DifficultyMul(KillBand::Green, cfg);
    EXPECT_DOUBLE_EQ(green, (1.0 + 0.25) / 2.0);
    EXPECT_GT(green, DifficultyMul(KillBand::Grey, cfg));
    EXPECT_LT(green, DifficultyMul(KillBand::Full, cfg));
}

// A floor of 1.0 collapses the taper: every band pays full (farming becomes neutral, not penalised).
TEST(KillSizing, DifficultyMulFloorOfOneFlattensBands)
{
    FakeConfig cfg;
    cfg.greyFloor = 1.0;
    EXPECT_DOUBLE_EQ(DifficultyMul(KillBand::Grey, cfg), 1.0);
    EXPECT_DOUBLE_EQ(DifficultyMul(KillBand::Green, cfg), 1.0);
    EXPECT_DOUBLE_EQ(DifficultyMul(KillBand::Full, cfg), 1.0);
}

// A negative/out-of-range configured floor is clamped into [0, 1].
TEST(KillSizing, DifficultyMulClampsFloor)
{
    FakeConfig cfg;
    cfg.greyFloor = -0.5;
    EXPECT_DOUBLE_EQ(DifficultyMul(KillBand::Grey, cfg), 0.0);
}

// --- baseUnits sizing (§7.4) ---

// Normal at-level kill: baseUnits == at-level gain (difficultyMul 1.0, class weight 1.0).
TEST(KillSizing, BaseUnitsAtLevelNormalEqualsGain)
{
    FakeConfig cfg;
    EXPECT_EQ(KillBaseUnits(1000, KillBand::Full, KillClassification::Normal, cfg), 1000u);
}

// Grey normal kill is floored to greyFloor * gain (rounded).
TEST(KillSizing, BaseUnitsGreyNormalIsFloored)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.25;
    EXPECT_EQ(KillBaseUnits(1000, KillBand::Grey, KillClassification::Normal, cfg), 250u);
}

// Classification weight scales the reward: an at-level elite pays classWeight[Elite] * gain.
TEST(KillSizing, BaseUnitsAppliesClassWeight)
{
    FakeConfig cfg;
    cfg.classWeight[static_cast<size_t>(KillClassification::Elite)] = 2.0;
    cfg.classWeight[static_cast<size_t>(KillClassification::WorldBoss)] = 5.0;

    EXPECT_EQ(KillBaseUnits(1000, KillBand::Full, KillClassification::Elite, cfg), 2000u);
    EXPECT_EQ(KillBaseUnits(1000, KillBand::Full, KillClassification::WorldBoss, cfg), 5000u);
}

// difficultyMul and classWeight compose multiplicatively.
TEST(KillSizing, BaseUnitsGreyEliteComposesFloorAndWeight)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.25;
    cfg.classWeight[static_cast<size_t>(KillClassification::Elite)] = 2.0;

    // 1000 * 0.25 * 2.0 = 500
    EXPECT_EQ(KillBaseUnits(1000, KillBand::Grey, KillClassification::Elite, cfg), 500u);
}

// Farming trivial mobs is viable but strictly worse per-kill than the at-level equivalent.
TEST(KillSizing, GreyKillPaysLessThanAtLevel)
{
    FakeConfig cfg;
    cfg.greyFloor = 0.25;

    uint32_t const atLevel = KillBaseUnits(1000, KillBand::Full, KillClassification::Normal, cfg);
    uint32_t const grey = KillBaseUnits(1000, KillBand::Grey, KillClassification::Normal, cfg);
    EXPECT_GT(grey, 0u);
    EXPECT_LT(grey, atLevel);
}

// A zero at-level gain yields zero units regardless of band/weight (no phantom reward).
TEST(KillSizing, BaseUnitsZeroGainIsZero)
{
    FakeConfig cfg;
    EXPECT_EQ(KillBaseUnits(0, KillBand::Full, KillClassification::WorldBoss, cfg), 0u);
}
