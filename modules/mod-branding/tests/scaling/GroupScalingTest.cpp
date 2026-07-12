#include "branding/scaling/GroupScaling.h"
#include "fakes/FakeScalingConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    GroupContext Group(uint8_t size, uint8_t content)
    {
        GroupContext g;
        g.groupSize = size;
        g.contentSize = content;
        return g;
    }
}

// A full group sees the unscaled encounter (mul == 1.0)
TEST(GroupScaling, FullGroupHasNoEncounterScaling)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(EncounterHealthMul(Group(40, 40), cfg), 1.0);
    EXPECT_DOUBLE_EQ(EncounterDamageMul(Group(40, 40), cfg), 1.0);
}

// The smallest group is scaled to the floor -- bounded so the content stays beatable
TEST(GroupScaling, SmallestGroupClampedToFloorAndBeatable)
{
    FakeScalingConfig cfg;
    double const health = EncounterHealthMul(Group(1, 40), cfg);
    double const damage = EncounterDamageMul(Group(1, 40), cfg);

    EXPECT_DOUBLE_EQ(health, cfg.groupHealthFloor);
    EXPECT_DOUBLE_EQ(damage, cfg.groupDamageFloor);
    EXPECT_GT(health, 0.0);   // never an impossible wall
    EXPECT_LT(health, 1.0);
}

// Encounter difficulty is monotonic non-decreasing in group size, clamped at content size
TEST(GroupScaling, EncounterDifficultyMonotonicAndClamped)
{
    FakeScalingConfig cfg;
    double prev = -1.0;
    for (uint8_t size = 1; size <= 40; ++size)
    {
        double const mul = EncounterHealthMul(Group(size, 40), cfg);
        EXPECT_GE(mul, prev);
        prev = mul;
    }
    // a 41st body in a 40-man adds nothing
    EXPECT_DOUBLE_EQ(EncounterHealthMul(Group(50, 40), cfg), EncounterHealthMul(Group(40, 40), cfg));
}

// Reward is monotonic non-decreasing in group size: a full raid drops at least as much and as good
TEST(GroupScaling, RewardMonotonicInGroupSize)
{
    FakeScalingConfig cfg;
    RewardScale small = RewardScaleForGroup(Group(5, 40), cfg);
    RewardScale full = RewardScaleForGroup(Group(40, 40), cfg);

    EXPECT_LE(small.materialQuantity, full.materialQuantity);
    EXPECT_LE(small.maxTier, full.maxTier);
    EXPECT_LE(small.rareChanceMul, full.rareChanceMul);
    EXPECT_EQ(full.materialQuantity, cfg.maxGroupMaterials);
    EXPECT_EQ(full.maxTier, cfg.maxRewardTier);
}

// Even the smallest group gets a non-zero, beatable reward floor
TEST(GroupScaling, SmallGroupStillRewarded)
{
    FakeScalingConfig cfg;
    RewardScale small = RewardScaleForGroup(Group(1, 40), cfg);
    EXPECT_GE(small.materialQuantity, 1u);
    EXPECT_GE(small.maxTier, 1);
}

// Determinism
TEST(GroupScaling, Deterministic)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(EncounterHealthMul(Group(13, 25), cfg), EncounterHealthMul(Group(13, 25), cfg));
}

// A full group earns full currency (no reduction).
TEST(GroupScaling, FullGroupHasFullCurrency)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(RewardScaleForGroup(Group(40, 40), cfg).currencyMul, 1.0);
}

// Currency falls off strictly faster than gear for a smaller group (§2.4.3 "especially currency").
TEST(GroupScaling, CurrencySteeperThanGear)
{
    FakeScalingConfig cfg;
    for (uint8_t size : {5, 10, 20})
    {
        RewardScale const r = RewardScaleForGroup(Group(size, 40), cfg);
        double const gearFraction = static_cast<double>(r.materialQuantity) / cfg.maxGroupMaterials;
        EXPECT_LT(r.currencyMul, gearFraction) << "size=" << static_cast<int>(size);
    }
}

// Currency is monotonic non-decreasing in group size, never exceeds 1.0, and respects the floor.
TEST(GroupScaling, CurrencyMonotonicBoundedAndFloored)
{
    FakeScalingConfig cfg;
    double prev = -1.0;
    for (uint8_t size = 1; size <= 40; ++size)
    {
        double const mul = RewardScaleForGroup(Group(size, 40), cfg).currencyMul;
        EXPECT_GE(mul, prev);
        EXPECT_GE(mul, cfg.currencyMulFloor);
        EXPECT_LE(mul, 1.0);
        prev = mul;
    }
}

// --- §2.7 branding-rank drop bonus (issue #81) ---

// Rank 0 is a no-op: the feature is a pure bonus, never a penalty.
TEST(RankDropRate, ZeroRankIsNeutral)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(RankDropRateMultiplier(0, cfg), 1.0);
}

// The multiplier grows linearly with the party's top rank at the configured per-rank bonus.
TEST(RankDropRate, LinearInRankBelowCap)
{
    FakeScalingConfig cfg;
    cfg.rankDropBonusPerRank = 0.01;
    cfg.rankDropMulCap = 1.5;
    EXPECT_DOUBLE_EQ(RankDropRateMultiplier(10, cfg), 1.10);
    EXPECT_DOUBLE_EQ(RankDropRateMultiplier(25, cfg), 1.25);
}

// Default calibration: a maxed rank-50 member lands exactly on the +50% cap.
TEST(RankDropRate, DefaultsCapAtMaxRank)
{
    FakeScalingConfig cfg;   // defaults: 0.01/rank, cap 1.5
    EXPECT_DOUBLE_EQ(RankDropRateMultiplier(50, cfg), 1.5);
}

// Clamped: rank beyond the cap point never exceeds the cap.
TEST(RankDropRate, ClampedAtCap)
{
    FakeScalingConfig cfg;
    cfg.rankDropBonusPerRank = 0.01;
    cfg.rankDropMulCap = 1.5;
    EXPECT_DOUBLE_EQ(RankDropRateMultiplier(200, cfg), 1.5);
}

// Monotonic non-decreasing in rank, and always a bonus (>= 1.0).
TEST(RankDropRate, MonotonicAndAlwaysBonus)
{
    FakeScalingConfig cfg;
    double prev = -1.0;
    for (uint16_t rank = 0; rank <= 255; ++rank)
    {
        double const mul = RankDropRateMultiplier(static_cast<uint8_t>(rank), cfg);
        EXPECT_GE(mul, prev);
        EXPECT_GE(mul, 1.0);
        EXPECT_LE(mul, cfg.rankDropMulCap);
        prev = mul;
    }
}

// Determinism.
TEST(RankDropRate, Deterministic)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(RankDropRateMultiplier(17, cfg), RankDropRateMultiplier(17, cfg));
}

// A misconfigured cap below 1.0 (admin typo, e.g. 0.5 for 1.5) must never turn the bonus into a
// penalty. std::clamp(v, lo, hi) with lo > hi is undefined behavior, so the pure fn floors the cap at
// 1.0 -- the "pure bonus, never a penalty" invariant holds regardless of config.
TEST(RankDropRate, MisconfiguredCapBelowOneNeverPenalizes)
{
    FakeScalingConfig cfg;
    cfg.rankDropBonusPerRank = 0.01;
    cfg.rankDropMulCap = 0.5;   // nonsensical: below the 1.0 floor
    for (uint8_t rank : {uint8_t(0), uint8_t(10), uint8_t(50), uint8_t(255)})
        EXPECT_GE(RankDropRateMultiplier(rank, cfg), 1.0) << "rank=" << static_cast<int>(rank);
}
