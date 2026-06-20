#include "proficiency/Proficiency.h"
#include "fakes/FakeConfig.h"
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
