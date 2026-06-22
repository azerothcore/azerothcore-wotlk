#include "branding/scaling/InvasionScaling.h"
#include "branding/scaling/GroupScaling.h"
#include "fakes/FakeInvasionScalingConfig.h"
#include "fakes/FakeScalingConfig.h"
#include <gtest/gtest.h>
#include <vector>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    std::span<uint32_t const> Span(std::vector<uint32_t> const& v) { return {v.data(), v.size()}; }
    std::span<uint64_t const> Span64(std::vector<uint64_t> const& v) { return {v.data(), v.size()}; }
}

// --- CrowdTracker: decayed peak (§2.5.2) -----------------------------------------------------------

// A recent peak is held for the whole decay window even after the live count drops (no whiplash).
TEST(CrowdTracker, PeakHeldWithinWindow)
{
    FakeInvasionScalingConfig cfg;   // window = 60s
    CrowdTracker t;
    t.Sample(0, 30, cfg);
    t.Sample(10, 5, cfg);            // crowd dropped, but within the window
    EXPECT_EQ(t.Effective(10, cfg), 30u);
}

// Once the peak ages past the window, the effective headcount relaxes to what is still in-window.
TEST(CrowdTracker, PeakRelaxesAfterWindow)
{
    FakeInvasionScalingConfig cfg;   // window = 60s
    CrowdTracker t;
    t.Sample(0, 30, cfg);
    t.Sample(10, 5, cfg);
    t.Sample(70, 5, cfg);            // t=0 peak (0+60=60 < 70) has aged out
    EXPECT_EQ(t.Effective(70, cfg), 5u);
}

// Effective never reports below the latest sampled count (the live floor is always in-window).
TEST(CrowdTracker, NeverBelowLatestSample)
{
    FakeInvasionScalingConfig cfg;
    CrowdTracker t;
    t.Sample(0, 5, cfg);
    t.Sample(5, 12, cfg);            // crowd grew
    EXPECT_EQ(t.Effective(5, cfg), 12u);
}

TEST(CrowdTracker, EmptyAndResetAreZero)
{
    FakeInvasionScalingConfig cfg;
    CrowdTracker t;
    EXPECT_EQ(t.Effective(0, cfg), 0u);
    t.Sample(0, 30, cfg);
    t.Reset();
    EXPECT_EQ(t.Effective(0, cfg), 0u);
}

// --- ActiveSpawnTiers: threshold gating (§2.5.3) ---------------------------------------------------

TEST(SpawnTiers, BaseAlwaysActiveAtZeroHeadcount)
{
    std::vector<uint32_t> thr{0, 5, 15, 30};
    uint64_t const mask = ActiveSpawnTiers(Span(thr), 0);
    EXPECT_TRUE(TierActive(mask, 0));
    EXPECT_FALSE(TierActive(mask, 1));
}

TEST(SpawnTiers, ActivatesAsHeadcountCrossesThresholds)
{
    std::vector<uint32_t> thr{0, 5, 15, 30};
    uint64_t const mask = ActiveSpawnTiers(Span(thr), 15);
    EXPECT_TRUE(TierActive(mask, 0));
    EXPECT_TRUE(TierActive(mask, 1));
    EXPECT_TRUE(TierActive(mask, 2));
    EXPECT_FALSE(TierActive(mask, 3));
}

// More headcount is always a superset of fewer (no tier vanishes when the crowd grows).
TEST(SpawnTiers, MonotonicSuperset)
{
    std::vector<uint32_t> thr{0, 5, 15, 30};
    uint64_t prev = 0;
    for (uint32_t h = 0; h <= 40; ++h)
    {
        uint64_t const mask = ActiveSpawnTiers(Span(thr), h);
        EXPECT_EQ(prev & ~mask, 0u) << "tier lost at headcount " << h;   // prev is a subset of mask
        prev = mask;
    }
}

// Activation is per-tier and independent of the row order in the table.
TEST(SpawnTiers, OrderIndependent)
{
    std::vector<uint32_t> sorted{0, 5, 15, 30};
    std::vector<uint32_t> shuffled{15, 0, 30, 5};
    EXPECT_TRUE(TierActive(ActiveSpawnTiers(Span(shuffled), 7), 1));   // the "0" tier
    EXPECT_TRUE(TierActive(ActiveSpawnTiers(Span(shuffled), 7), 3));   // the "5" tier
    EXPECT_FALSE(TierActive(ActiveSpawnTiers(Span(shuffled), 7), 0));  // the "15" tier
    (void)sorted;
}

// --- ReconcileSpawnTiers: hysteresis (§2.5.3) ------------------------------------------------------

TEST(SpawnTiers, ReconcileTurnsOnAtThreshold)
{
    FakeInvasionScalingConfig cfg;   // margin = 3
    std::vector<uint32_t> thr{0, 5};
    uint64_t const mask = ReconcileSpawnTiers(Span(thr), 5, 0, cfg);
    EXPECT_TRUE(TierActive(mask, 0));
    EXPECT_TRUE(TierActive(mask, 1));
}

// An already-active tier stays up while the crowd dips within the release margin, then releases.
TEST(SpawnTiers, ReconcileHoldsWithinMarginThenReleases)
{
    FakeInvasionScalingConfig cfg;   // margin = 3, so tier@5 holds down to headcount 2
    std::vector<uint32_t> thr{0, 5};
    uint64_t active = ReconcileSpawnTiers(Span(thr), 5, 0, cfg);       // on
    active = ReconcileSpawnTiers(Span(thr), 3, active, cfg);           // 3 >= 5-3 => holds
    EXPECT_TRUE(TierActive(active, 1));
    active = ReconcileSpawnTiers(Span(thr), 1, active, cfg);           // 1 < 5-3  => releases
    EXPECT_FALSE(TierActive(active, 1));
}

// The margin does NOT lower the turn-on threshold for a tier that was off (no early spawn).
TEST(SpawnTiers, ReconcileDoesNotTurnOnEarlyWithinMargin)
{
    FakeInvasionScalingConfig cfg;
    std::vector<uint32_t> thr{0, 5};
    uint64_t const mask = ReconcileSpawnTiers(Span(thr), 3, 0, cfg);   // 3 < 5, was off
    EXPECT_FALSE(TierActive(mask, 1));
}

// --- LiveContainmentGoal (§2.5.4) ------------------------------------------------------------------

TEST(ContainmentGoal, SumsActiveTiersOnly)
{
    std::vector<uint64_t> contribs{100, 50, 200, 300};
    uint64_t const mask = (1ULL << 0) | (1ULL << 2);                  // base + elite pack
    EXPECT_EQ(LiveContainmentGoal(Span64(contribs), mask), 300u);     // 100 + 200
}

TEST(ContainmentGoal, EmptyMaskIsZero)
{
    std::vector<uint64_t> contribs{100, 50};
    EXPECT_EQ(LiveContainmentGoal(Span64(contribs), 0), 0u);
}

// --- InvasionTrashMul: gentle curve (§2.5.1) -------------------------------------------------------

// A solo straggler faces authored-baseline trash (mul 1.0) -- never an impossible wall.
TEST(InvasionTrash, SoloIsBaseline)
{
    FakeInvasionScalingConfig cfg;
    EXPECT_DOUBLE_EQ(InvasionTrashMul(1, cfg), 1.0);
}

// A full crowd hits the trash ceiling, and crowd beyond the intended size adds nothing.
TEST(InvasionTrash, FullCrowdHitsMaxAndClamps)
{
    FakeInvasionScalingConfig cfg;   // intended = 40, max = 1.5
    EXPECT_DOUBLE_EQ(InvasionTrashMul(40, cfg), cfg.trashMaxMul);
    EXPECT_DOUBLE_EQ(InvasionTrashMul(80, cfg), cfg.trashMaxMul);
}

TEST(InvasionTrash, MonotonicNonDecreasing)
{
    FakeInvasionScalingConfig cfg;
    double prev = -1.0;
    for (uint32_t h = 1; h <= 40; ++h)
    {
        double const mul = InvasionTrashMul(h, cfg);
        EXPECT_GE(mul, prev);
        EXPECT_GE(mul, 1.0);
        EXPECT_LE(mul, cfg.trashMaxMul);
        prev = mul;
    }
}

// Exponent >= 1 makes the ramp slow at first -- half a crowd is gentler than the linear midpoint.
TEST(InvasionTrash, GentleStartWithExponent)
{
    FakeInvasionScalingConfig cfg;   // exponent = 2
    double const mid = InvasionTrashMul(20, cfg);            // ~half of a 40 crowd (excess of 1.0)
    double const linearMidExcess = 0.5 * (cfg.trashMaxMul - 1.0);
    EXPECT_LT(mid - 1.0, linearMidExcess);
}

// --- The asymmetry (§2.5.1): trash hardens UP with crowd, boss softens DOWN for a small crowd ------

TEST(InvasionScaling, TrashAndBossScaleInOppositeDirections)
{
    FakeInvasionScalingConfig inv;   // intended 40
    FakeScalingConfig group;         // §2.2 boss dials

    // Trash: baseline at solo, harder at full crowd (>= 1.0).
    EXPECT_DOUBLE_EQ(InvasionTrashMul(1, inv), 1.0);
    EXPECT_GT(InvasionTrashMul(40, inv), 1.0);

    // Boss: full §2.2 -- easier for a small crowd (< 1.0), authored difficulty at full crowd (1.0).
    auto bossMul = [&](uint8_t h) { return EncounterHealthMul(GroupContext{h, inv.intendedInvasionSize}, group); };
    EXPECT_LT(bossMul(1), 1.0);
    EXPECT_DOUBLE_EQ(bossMul(40), 1.0);
    EXPECT_DOUBLE_EQ(bossMul(80), bossMul(40));   // 41st body adds nothing
}
