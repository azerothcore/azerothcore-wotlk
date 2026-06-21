#include "branding/catalyst/CatalystStacking.h"
#include "fakes/FakeCatalystConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// The first same-role specialist gets the full raid multiplier (cap)
TEST(CatalystStacking, FirstSpecialistGetsFullMultiplier)
{
    FakeCatalystConfig cfg;
    EXPECT_DOUBLE_EQ(RaidCatalystMultiplier(1, cfg), cfg.maxRaidMul);
}

// No branded specialist (rank 0) means no effect and no harm: multiplier is exactly 1.0
TEST(CatalystStacking, RankZeroIsNeutral)
{
    FakeCatalystConfig cfg;
    EXPECT_DOUBLE_EQ(CatalystStackWeight(0, cfg), 0.0);
    EXPECT_DOUBLE_EQ(RaidCatalystMultiplier(0, cfg), 1.0);
}

// §7.9: monotonically non-increasing in rank, always within [1.0, MaxRaidMul]
TEST(CatalystStacking, MonotonicNonIncreasingAndBounded)
{
    FakeCatalystConfig cfg;
    double prev = cfg.maxRaidMul + 1.0;
    for (uint8_t rank = 1; rank <= 20; ++rank)
    {
        double mul = RaidCatalystMultiplier(rank, cfg);
        EXPECT_GE(mul, 1.0);
        EXPECT_LE(mul, cfg.maxRaidMul);
        EXPECT_LE(mul, prev);            // never rises as more stack
        prev = mul;
    }
}

// "2nd reduced, 3rd+ heavily reduced": the marginal bonus shrinks fast
TEST(CatalystStacking, ThirdSpecialistIsHeavilyReduced)
{
    FakeCatalystConfig cfg;
    double bonus1 = RaidCatalystMultiplier(1, cfg) - 1.0;
    double bonus2 = RaidCatalystMultiplier(2, cfg) - 1.0;
    double bonus3 = RaidCatalystMultiplier(3, cfg) - 1.0;

    EXPECT_LT(bonus2, bonus1);                       // 2nd reduced
    EXPECT_LT(bonus3, bonus2);                       // 3rd further
    EXPECT_LT(bonus3, 0.5 * bonus2);                 // 3rd+ heavily reduced
}

// Stack weight decays from a full first specialist toward zero
TEST(CatalystStacking, StackWeightDecaysFromFull)
{
    FakeCatalystConfig cfg;
    EXPECT_DOUBLE_EQ(CatalystStackWeight(1, cfg), 1.0);
    EXPECT_GT(CatalystStackWeight(1, cfg), CatalystStackWeight(2, cfg));
    EXPECT_GT(CatalystStackWeight(2, cfg), CatalystStackWeight(3, cfg));
    EXPECT_GE(CatalystStackWeight(10, cfg), 0.0);
}

// Determinism
TEST(CatalystStacking, Deterministic)
{
    FakeCatalystConfig cfg;
    EXPECT_DOUBLE_EQ(RaidCatalystMultiplier(3, cfg), RaidCatalystMultiplier(3, cfg));
}
