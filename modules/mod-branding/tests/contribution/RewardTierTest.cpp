#include "branding/contribution/RewardTier.h"
#include "fakes/FakeContributionConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// §9.4: thresholds map points to tiers, with strict ordering bronze < silver < gold
TEST(RewardTier, ThresholdsMapPointsToTiers)
{
    FakeContributionConfig cfg;   // 50 / 150 / 400
    EXPECT_EQ(TierForContribution(0, cfg), RewardTier::None);
    EXPECT_EQ(TierForContribution(49, cfg), RewardTier::None);
    EXPECT_EQ(TierForContribution(50, cfg), RewardTier::Bronze);
    EXPECT_EQ(TierForContribution(149, cfg), RewardTier::Bronze);
    EXPECT_EQ(TierForContribution(150, cfg), RewardTier::Silver);
    EXPECT_EQ(TierForContribution(399, cfg), RewardTier::Silver);
    EXPECT_EQ(TierForContribution(400, cfg), RewardTier::Gold);
    EXPECT_EQ(TierForContribution(100000, cfg), RewardTier::Gold);
}

// Tier is monotonic non-decreasing in points
TEST(RewardTier, MonotonicInPoints)
{
    FakeContributionConfig cfg;
    RewardTier prev = RewardTier::None;
    for (uint32_t pts = 0; pts <= 500; pts += 10)
    {
        RewardTier tier = TierForContribution(pts, cfg);
        EXPECT_GE(static_cast<uint8_t>(tier), static_cast<uint8_t>(prev));
        prev = tier;
    }
}

// §2.4.2 heroic bump: a contribution-earned tier advances, capped at Gold.
TEST(RewardTier, BumpAdvancesAndCapsAtGold)
{
    EXPECT_EQ(BumpTier(RewardTier::Bronze, 1), RewardTier::Silver);
    EXPECT_EQ(BumpTier(RewardTier::Bronze, 2), RewardTier::Gold);
    EXPECT_EQ(BumpTier(RewardTier::Silver, 1), RewardTier::Gold);
    EXPECT_EQ(BumpTier(RewardTier::Silver, 5), RewardTier::Gold);   // capped
    EXPECT_EQ(BumpTier(RewardTier::Gold, 1), RewardTier::Gold);
}

// A zero bonus (normal difficulty) is identity; None never gains a reward from heroic alone.
TEST(RewardTier, BumpIdentityAndNoneFloor)
{
    EXPECT_EQ(BumpTier(RewardTier::Bronze, 0), RewardTier::Bronze);
    EXPECT_EQ(BumpTier(RewardTier::None, 0), RewardTier::None);
    EXPECT_EQ(BumpTier(RewardTier::None, 3), RewardTier::None);
}

// Bump never lowers a tier (monotonic in bonus).
TEST(RewardTier, BumpMonotonicInBonus)
{
    RewardTier prev = RewardTier::Bronze;
    for (uint8_t bonus = 0; bonus <= 6; ++bonus)
    {
        RewardTier const tier = BumpTier(RewardTier::Bronze, bonus);
        EXPECT_GE(static_cast<uint8_t>(tier), static_cast<uint8_t>(prev));
        prev = tier;
    }
}
