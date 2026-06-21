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
