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
