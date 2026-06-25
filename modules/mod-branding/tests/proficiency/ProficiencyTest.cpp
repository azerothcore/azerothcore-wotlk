#include "branding/proficiency/Proficiency.h"
#include "fakes/FakeConfig.h"
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// XpForLevel is strictly increasing below the cap
TEST(Proficiency, XpForLevelMonotonic)
{
    FakeConfig cfg;
    for (uint8_t lvl = 1; lvl < cfg.maxLevel; ++lvl)
    {
        EXPECT_GT(XpForLevel(static_cast<uint8_t>(lvl + 1), cfg), XpForLevel(lvl, cfg));
    }
}

// XpForLevel saturates at MaxLevel
TEST(Proficiency, XpForLevelSaturatesAtCap)
{
    FakeConfig cfg;
    uint64_t atCap = XpForLevel(cfg.maxLevel, cfg);
    EXPECT_EQ(XpForLevel(static_cast<uint8_t>(cfg.maxLevel + 10), cfg), atCap);
}

// LevelForXp is the inverse of XpForLevel within each level band
TEST(Proficiency, LevelForXpInvertsXpForLevel)
{
    FakeConfig cfg;
    for (uint8_t lvl = 1; lvl <= cfg.maxLevel; ++lvl)
    {
        EXPECT_EQ(LevelForXp(XpForLevel(lvl, cfg), cfg), lvl);
    }
    // just below a threshold resolves to the lower level
    uint64_t l3 = XpForLevel(3, cfg);
    EXPECT_EQ(LevelForXp(l3 - 1, cfg), 2);
}

// LevelForXp saturates at MaxLevel for arbitrarily large XP
TEST(Proficiency, LevelForXpSaturatesAtCap)
{
    FakeConfig cfg;
    EXPECT_EQ(LevelForXp(1ull << 40, cfg), cfg.maxLevel);
}

// EffectStrength is monotonic, bounded in [0, 1], saturating at the cap
TEST(Proficiency, EffectStrengthBoundedAndMonotonic)
{
    FakeConfig cfg;
    EXPECT_DOUBLE_EQ(EffectStrength(0, cfg), 0.0);
    EXPECT_DOUBLE_EQ(EffectStrength(cfg.maxLevel, cfg), 1.0);
    EXPECT_DOUBLE_EQ(EffectStrength(static_cast<uint8_t>(cfg.maxLevel + 5), cfg), 1.0);

    double prev = -1.0;
    for (uint8_t lvl = 0; lvl <= cfg.maxLevel; ++lvl)
    {
        double s = EffectStrength(lvl, cfg);
        EXPECT_GE(s, 0.0);
        EXPECT_LE(s, 1.0);
        EXPECT_GE(s, prev);
        prev = s;
    }
}

// XpForLevel is the closed-form sum of the geometric per-rank ladder (§7.4): the cumulative cost to
// reach level n equals the sum of rankBaseXp * growth^(k-1) for k in [1, n].
TEST(Proficiency, XpForLevelMatchesGeometricRankSum)
{
    FakeConfig cfg;
    cfg.rankBaseXp = 1670800.0;   // live level-79->80 XP
    cfg.rankGrowth = 1.01;        // +1%/rank

    double running = 0.0;
    for (uint8_t lvl = 1; lvl <= cfg.maxLevel; ++lvl)
    {
        running += cfg.rankBaseXp * std::pow(cfg.rankGrowth, lvl - 1);   // rankCost(lvl)
        // Allow rounding slack (the closed form rounds once; the running sum accumulates per-rank).
        uint64_t const expected = static_cast<uint64_t>(std::llround(running));
        uint64_t const actual = XpForLevel(lvl, cfg);
        int64_t const diff = static_cast<int64_t>(actual) - static_cast<int64_t>(expected);
        EXPECT_LE(std::abs(diff), 2) << "level " << static_cast<int>(lvl);
    }

    // The full 50-rank ladder is ~107.7M XP (the §14.13.6 pacing anchor).
    uint64_t const full = XpForLevel(cfg.maxLevel, cfg);
    EXPECT_GT(full, 107'000'000ull);
    EXPECT_LT(full, 109'000'000ull);
}

// growth == 1.0 degenerates to a linear ladder (n * rankBaseXp), no division by zero.
TEST(Proficiency, XpForLevelLinearWhenGrowthIsOne)
{
    FakeConfig cfg;
    cfg.rankBaseXp = 1000.0;
    cfg.rankGrowth = 1.0;
    EXPECT_EQ(XpForLevel(1, cfg), 1000ull);
    EXPECT_EQ(XpForLevel(7, cfg), 7000ull);
}
