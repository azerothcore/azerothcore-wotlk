#include "branding/proficiency/Proficiency.h"
#include "fakes/FakeConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    // Linear ladder (growth == 1) so thresholds are exactly 100 * level -- the arithmetic in the
    // expectations stays trivial and exact (issue #54 / §7.4).
    FakeConfig LinearCfg()
    {
        FakeConfig cfg;
        cfg.rankBaseXp = 100.0;
        cfg.rankGrowth = 1.0;
        cfg.maxLevel = 5;
        return cfg;
    }
}

TEST(LevelProgress, ZeroXpIsLevelZeroAtStartOfFirstLevel)
{
    FakeConfig const cfg = LinearCfg();
    LevelProgress const p = ComputeLevelProgress(0, cfg);
    EXPECT_EQ(p.level, 0);
    EXPECT_EQ(p.maxLevel, 5);
    EXPECT_EQ(p.xpIntoLevel, 0u);
    EXPECT_EQ(p.xpForLevel, 100u);   // XpForLevel(1) - XpForLevel(0)
    EXPECT_FALSE(p.atMax);
}

TEST(LevelProgress, MidLevelSplitsTotalXpExactly)
{
    FakeConfig const cfg = LinearCfg();
    LevelProgress const p = ComputeLevelProgress(250, cfg);   // between level 2 (200) and 3 (300)
    EXPECT_EQ(p.level, 2);
    EXPECT_EQ(p.xpIntoLevel, 50u);   // 250 - XpForLevel(2)
    EXPECT_EQ(p.xpForLevel, 100u);   // XpForLevel(3) - XpForLevel(2)
    EXPECT_FALSE(p.atMax);
    // The decomposition must reconstruct the level threshold exactly.
    EXPECT_EQ(XpForLevel(p.level, cfg) + p.xpIntoLevel, 250u);
}

TEST(LevelProgress, ExactlyAtMaxLevelIsPrestigeWithNoRemainingSpan)
{
    FakeConfig const cfg = LinearCfg();
    LevelProgress const p = ComputeLevelProgress(500, cfg);   // XpForLevel(5) == 500 == max
    EXPECT_EQ(p.level, 5);
    EXPECT_TRUE(p.atMax);
    EXPECT_EQ(p.xpForLevel, 0u);
    EXPECT_EQ(p.xpIntoLevel, 0u);
}

TEST(LevelProgress, BeyondMaxStaysCappedAtMax)
{
    FakeConfig const cfg = LinearCfg();
    LevelProgress const p = ComputeLevelProgress(700, cfg);
    EXPECT_EQ(p.level, 5);
    EXPECT_TRUE(p.atMax);
    EXPECT_EQ(p.xpForLevel, 0u);
    EXPECT_EQ(p.xpIntoLevel, 200u);   // overflow past the cap is still reported, span is 0
}
