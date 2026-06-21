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

// --- §14.9 per (school, tree) DR bucketing ---

// The bucket identity is (school, tree): both must match to share a DR bucket.
TEST(CatalystStacking, SameBucketRequiresSchoolAndTree)
{
    EXPECT_TRUE(SameCatalystBucket({ BrandId::Fire, MasteryTree::Defensive },
                                   { BrandId::Fire, MasteryTree::Defensive }));
    EXPECT_FALSE(SameCatalystBucket({ BrandId::Fire, MasteryTree::Defensive },
                                    { BrandId::Fire, MasteryTree::Offensive }));   // same school, diff tree
    EXPECT_FALSE(SameCatalystBucket({ BrandId::Fire, MasteryTree::Defensive },
                                    { BrandId::Frost, MasteryTree::Defensive }));  // same tree, diff school
}

// The headline case: one Fire-Def + one Fire-Off + one Fire-Support => three independent rank-1
// buckets, so ALL THREE keep the full raid multiplier (no DR among complementary specialists).
TEST(CatalystStacking, ComplementaryTreesDoNotTriggerDr)
{
    FakeCatalystConfig cfg;
    CatalystKey roster[] = {
        { BrandId::Fire, MasteryTree::Defensive },
        { BrandId::Fire, MasteryTree::Offensive },
        { BrandId::Fire, MasteryTree::Support },
    };
    for (std::size_t i = 0; i < 3; ++i)
    {
        uint8_t rank = CatalystRankInBucket(roster, 3, i);
        EXPECT_EQ(rank, 1u);
        EXPECT_DOUBLE_EQ(RaidCatalystMultiplier(rank, cfg), cfg.maxRaidMul);  // full effect, no DR
    }
}

// Redundant specialists (the SAME cell repeated) DO stack DR: ranks increment 1, 2, 3...
TEST(CatalystStacking, RedundantSameCellStacksDr)
{
    CatalystKey roster[] = {
        { BrandId::Fire, MasteryTree::Offensive },   // rank 1
        { BrandId::Fire, MasteryTree::Defensive },   // rank 1 (different bucket)
        { BrandId::Fire, MasteryTree::Offensive },   // rank 2 (second Fire-Off)
        { BrandId::Fire, MasteryTree::Offensive },   // rank 3 (third Fire-Off)
    };
    EXPECT_EQ(CatalystRankInBucket(roster, 4, 0), 1u);
    EXPECT_EQ(CatalystRankInBucket(roster, 4, 1), 1u);
    EXPECT_EQ(CatalystRankInBucket(roster, 4, 2), 2u);
    EXPECT_EQ(CatalystRankInBucket(roster, 4, 3), 3u);
}

// Different school, same tree are independent buckets (rank 1 each) -- mirror of the tree case.
TEST(CatalystStacking, DifferentSchoolSameTreeIndependent)
{
    CatalystKey roster[] = {
        { BrandId::Fire,  MasteryTree::Defensive },
        { BrandId::Frost, MasteryTree::Defensive },
        { BrandId::Shadow, MasteryTree::Defensive },
    };
    EXPECT_EQ(CatalystRankInBucket(roster, 3, 0), 1u);
    EXPECT_EQ(CatalystRankInBucket(roster, 3, 1), 1u);
    EXPECT_EQ(CatalystRankInBucket(roster, 3, 2), 1u);
}

// Defensive guards: null roster / out-of-range index => rank 0 (neutral).
TEST(CatalystStacking, RankInBucketHandlesBadInput)
{
    CatalystKey roster[] = { { BrandId::Fire, MasteryTree::Offensive } };
    EXPECT_EQ(CatalystRankInBucket(nullptr, 0, 0), 0u);
    EXPECT_EQ(CatalystRankInBucket(roster, 1, 5), 0u);
}
