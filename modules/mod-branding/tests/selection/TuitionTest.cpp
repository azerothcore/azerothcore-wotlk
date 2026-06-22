#include "branding/selection/Tuition.h"
#include "fakes/FakeSelectionConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// --- §14.13.2 escalating gold tuition ---

TEST(Tuition, FirstSwitchIsBase)
{
    FakeSelectionConfig cfg;
    EXPECT_EQ(TuitionCost(0, cfg), cfg.tuitionBase);
}

TEST(Tuition, EscalatesGeometrically)
{
    FakeSelectionConfig cfg;
    cfg.tuitionBase = 10000;
    cfg.tuitionFactor = 2.0;
    cfg.tuitionCap = 100000000;     // high enough not to clamp these steps

    EXPECT_EQ(TuitionCost(0, cfg), 10000u);
    EXPECT_EQ(TuitionCost(1, cfg), 20000u);
    EXPECT_EQ(TuitionCost(2, cfg), 40000u);
    EXPECT_EQ(TuitionCost(3, cfg), 80000u);
}

TEST(Tuition, MonotonicNonDecreasing)
{
    FakeSelectionConfig cfg;
    cfg.tuitionBase = 5000;
    cfg.tuitionFactor = 1.5;
    cfg.tuitionCap = 1000000;

    uint64_t prev = 0;
    for (uint32_t n = 0; n <= 64; ++n)
    {
        uint64_t const cost = TuitionCost(n, cfg);
        EXPECT_GE(cost, prev) << "non-monotonic at recentSwitches=" << n;
        prev = cost;
    }
}

TEST(Tuition, ClampsToCap)
{
    FakeSelectionConfig cfg;
    cfg.tuitionBase = 10000;
    cfg.tuitionFactor = 2.0;
    cfg.tuitionCap = 50000;

    // 0:10k 1:20k 2:40k 3:80k(->cap) and everything beyond stays at cap.
    EXPECT_EQ(TuitionCost(2, cfg), 40000u);
    EXPECT_EQ(TuitionCost(3, cfg), 50000u);
    EXPECT_EQ(TuitionCost(10, cfg), 50000u);
    EXPECT_EQ(TuitionCost(1000, cfg), 50000u);     // no overflow on a huge exponent
}

TEST(Tuition, NeverExceedsCapForAnyInput)
{
    FakeSelectionConfig cfg;
    cfg.tuitionBase = 12345;
    cfg.tuitionFactor = 3.0;
    cfg.tuitionCap = 777777;

    for (uint32_t n = 0; n <= 200; ++n)
        EXPECT_LE(TuitionCost(n, cfg), cfg.tuitionCap) << "cap exceeded at recentSwitches=" << n;
}

TEST(Tuition, Deterministic)
{
    FakeSelectionConfig cfg;
    for (uint32_t n = 0; n <= 20; ++n)
        EXPECT_EQ(TuitionCost(n, cfg), TuitionCost(n, cfg));
}

TEST(Tuition, FactorBelowOneDoesNotDecreaseBelowBase)
{
    FakeSelectionConfig cfg;
    cfg.tuitionBase = 8000;
    cfg.tuitionFactor = 0.5;        // pathological config: clamped to >= 1.0 internally
    cfg.tuitionCap = 1000000;

    EXPECT_EQ(TuitionCost(0, cfg), 8000u);
    EXPECT_EQ(TuitionCost(1, cfg), 8000u);
    EXPECT_EQ(TuitionCost(5, cfg), 8000u);
}

TEST(Tuition, BaseAlreadyAtCapStaysCapped)
{
    FakeSelectionConfig cfg;
    cfg.tuitionBase = 60000;
    cfg.tuitionCap = 50000;         // base above cap
    cfg.tuitionFactor = 2.0;

    EXPECT_EQ(TuitionCost(0, cfg), 50000u);
    EXPECT_EQ(TuitionCost(5, cfg), 50000u);
}

// --- recent-switch counter decay (§14.13.2) ---

TEST(SwitchDecay, ZeroCounterStaysZero)
{
    FakeSelectionConfig cfg;
    EXPECT_EQ(DecaySwitchCount(0, 1000, 1000000, cfg), 0u);
}

TEST(SwitchDecay, NeverSwitchedStaysZero)
{
    FakeSelectionConfig cfg;
    EXPECT_EQ(DecaySwitchCount(3, 0, 1000000, cfg), 0u);
}

TEST(SwitchDecay, RetainedWithinWindow)
{
    FakeSelectionConfig cfg;
    cfg.switchDecayDays = 7;
    uint64_t const last = 1000000;
    uint64_t const sixDays = 6ull * 86400ull;
    EXPECT_EQ(DecaySwitchCount(3, last, last + sixDays, cfg), 3u);
}

TEST(SwitchDecay, ResetsAfterWindow)
{
    FakeSelectionConfig cfg;
    cfg.switchDecayDays = 7;
    uint64_t const last = 1000000;
    uint64_t const sevenDays = 7ull * 86400ull;
    EXPECT_EQ(DecaySwitchCount(3, last, last + sevenDays, cfg), 0u);
    EXPECT_EQ(DecaySwitchCount(3, last, last + sevenDays + 1, cfg), 0u);
}

TEST(SwitchDecay, DisabledWhenDecayDaysZero)
{
    FakeSelectionConfig cfg;
    cfg.switchDecayDays = 0;
    EXPECT_EQ(DecaySwitchCount(3, 1000, 1000000000, cfg), 3u);
}

TEST(SwitchDecay, ClockSkewKeepsCounter)
{
    FakeSelectionConfig cfg;
    cfg.switchDecayDays = 7;
    EXPECT_EQ(DecaySwitchCount(3, 1000000, 500000, cfg), 3u);
}
