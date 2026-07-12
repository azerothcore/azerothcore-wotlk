#include "branding/scaling/GroupScaling.h"
#include "fakes/FakeScalingConfig.h"
#include <gtest/gtest.h>
#include <initializer_list>
#include <vector>

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

// --- §2.7 Branding Boon: selectable raid-wide economy rate (issues #81, #83) ---

namespace
{
    double Boon(BoonAxis axis, std::initializer_list<uint8_t> ranks, IScalingConfig const& cfg)
    {
        std::vector<uint8_t> v(ranks);
        return BoonAxisMultiplier(axis, v.data(), v.size(), cfg);
    }
}

// No selectors, None axis, or a null list are all neutral (pure bonus, never a penalty).
TEST(Boon, EmptyOrNoneIsNeutral)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(BoonAxisMultiplier(BoonAxis::Drop, nullptr, 0, cfg), 1.0);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::None, {50, 50}, cfg), 1.0);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {}, cfg), 1.0);
}

// #81 migration parity: a single maxed Drop selector lands exactly on the old +50% cap.
TEST(Boon, MigrationParitySingleMaxedDropSelector)
{
    FakeScalingConfig cfg;   // BoonDropCap 1.5, MaxRank 50
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {50}, cfg), 1.5);
}

// A lone maxed selector reaches exactly that axis's cap, independently per axis.
TEST(Boon, LoneMaxedSelectorHitsAxisCap)
{
    FakeScalingConfig cfg;
    cfg.boonDropCap = 1.5;
    cfg.boonXpCap = 1.3;
    cfg.boonGoldCap = 1.2;
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {50}, cfg), 1.5);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Xp, {50}, cfg), 1.3);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Gold, {50}, cfg), 1.2);
}

// Harsh geometric DR: three rank-25 drop-selectors stay well below the cap (spec §2.7.1 worked
// example): 1 + (1.5-1) * 0.5*(1 + 0.4 + 0.16) = 1.39.
TEST(Boon, HarshDiminishingReturnsWithinAxis)
{
    FakeScalingConfig cfg;   // decay 0.4, maxRank 50, drop cap 1.5
    EXPECT_NEAR(Boon(BoonAxis::Drop, {25, 25, 25}, cfg), 1.39, 1e-9);
}

// Extra same-axis selectors never push past the cap, and adding a lower-rank selector after a
// maxed one never raises the result above what the best selector alone already yields (the cap).
TEST(Boon, StackingNeverExceedsBestAtCap)
{
    FakeScalingConfig cfg;
    double const soloMaxed = Boon(BoonAxis::Drop, {50}, cfg);
    EXPECT_DOUBLE_EQ(soloMaxed, cfg.boonDropCap);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {50, 50, 50, 50, 50}, cfg), soloMaxed);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {50, 30, 10}, cfg), soloMaxed);
    EXPECT_LE(Boon(BoonAxis::Drop, {40, 40, 40}, cfg), cfg.boonDropCap);
}

// Rank-0 / non-loaded members contribute nothing: padding with zeros changes nothing.
TEST(Boon, ZeroRankSelectorsContributeNothing)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Xp, {30, 0, 0, 0}, cfg), Boon(BoonAxis::Xp, {30}, cfg));
}

// Monotonic non-decreasing as a single selector's rank rises; always a bonus; always within cap.
TEST(Boon, MonotonicInRankAlwaysBonusWithinCap)
{
    FakeScalingConfig cfg;
    double prev = -1.0;
    for (uint16_t rank = 0; rank <= 255; ++rank)
    {
        double const mul = Boon(BoonAxis::Gold, {static_cast<uint8_t>(rank)}, cfg);
        EXPECT_GE(mul, prev);
        EXPECT_GE(mul, 1.0);
        EXPECT_LE(mul, cfg.boonGoldCap);
        prev = mul;
    }
}

// Axis independence: each axis reads only its own cap; the same roster yields different results
// only because the caps differ, and no axis leaks into another.
TEST(Boon, AxisIndependence)
{
    FakeScalingConfig cfg;
    cfg.boonDropCap = 1.5;
    cfg.boonXpCap = 2.0;
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {50}, cfg), 1.5);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Xp, {50}, cfg), 2.0);
    // Changing the gold cap moves gold only.
    cfg.boonGoldCap = 1.1;
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {50}, cfg), 1.5);
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Gold, {50}, cfg), 1.1);
}

// Selector order does not matter (sorted internally) -> deterministic.
TEST(Boon, OrderIndependentAndDeterministic)
{
    FakeScalingConfig cfg;
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {10, 40, 25}, cfg), Boon(BoonAxis::Drop, {40, 25, 10}, cfg));
    EXPECT_DOUBLE_EQ(Boon(BoonAxis::Drop, {17, 33}, cfg), Boon(BoonAxis::Drop, {17, 33}, cfg));
}

// A selector count beyond the internal stack buffer (WoW's 40-man cap) still computes correctly via
// the heap fallback: many maxed selectors saturate to -- never exceed -- the axis cap.
TEST(Boon, LargeSelectorCountUsesHeapFallbackAndStaysCapped)
{
    FakeScalingConfig cfg;
    std::vector<uint8_t> many(60, static_cast<uint8_t>(50));   // 60 > 40-entry stack buffer
    double const mul = BoonAxisMultiplier(BoonAxis::Drop, many.data(), many.size(), cfg);
    EXPECT_DOUBLE_EQ(mul, cfg.boonDropCap);
    EXPECT_LE(mul, cfg.boonDropCap);
}

// A misconfigured cap below 1.0 (admin typo, e.g. 0.5 for 1.5) must never turn the bonus into a
// penalty. std::clamp(v, lo, hi) with lo > hi is undefined behavior, so the pure fn floors the cap
// at 1.0 -- the "pure bonus, never a penalty" invariant holds regardless of config.
TEST(Boon, MisconfiguredCapBelowOneNeverPenalizes)
{
    FakeScalingConfig cfg;
    cfg.boonDropCap = 0.5;   // nonsensical: below the 1.0 floor
    for (uint8_t rank : {uint8_t(0), uint8_t(10), uint8_t(50), uint8_t(255)})
        EXPECT_GE(Boon(BoonAxis::Drop, {rank}, cfg), 1.0) << "rank=" << static_cast<int>(rank);
}
