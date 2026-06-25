#include "branding/economy/BalanceShares.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    constexpr auto Q = XpSource::Questing;
    constexpr auto P = XpSource::Professions;
    constexpr auto E = XpSource::Exploration;
    constexpr auto D = XpSource::Discoveries;
}

// Empty totals -> all-zero shares, no division by zero, deterministic Largest().
TEST(BalanceShares, EmptyTotalsAreZeroAndSafe)
{
    SourceTotals t;
    BalanceShares s = ComputeShares(t);

    EXPECT_DOUBLE_EQ(s.Share(Q), 0.0);
    EXPECT_DOUBLE_EQ(s.Share(P), 0.0);
    EXPECT_DOUBLE_EQ(s.Share(E), 0.0);
    EXPECT_DOUBLE_EQ(s.Share(D), 0.0);
    // Tie among zeros resolves to the lowest ordinal (Questing) -- never UB.
    EXPECT_EQ(s.Largest(), Q);
}

// Add accumulates per source; Total() is the sum across sources.
TEST(BalanceShares, AddAccumulatesAndTotals)
{
    SourceTotals t;
    t.Add(Q, 100);
    t.Add(Q, 50);
    t.Add(P, 25);

    EXPECT_EQ(t.Get(Q), 150u);
    EXPECT_EQ(t.Get(P), 25u);
    EXPECT_EQ(t.Get(E), 0u);
    EXPECT_EQ(t.Total(), 175u);
}

// Shares normalize to the proportion of total and sum to 1.0.
TEST(BalanceShares, SharesNormalizeAndSumToOne)
{
    SourceTotals t;
    t.Add(Q, 450);
    t.Add(P, 250);
    t.Add(E, 200);
    t.Add(D, 100);

    BalanceShares s = ComputeShares(t);
    EXPECT_DOUBLE_EQ(s.Share(Q), 0.45);
    EXPECT_DOUBLE_EQ(s.Share(P), 0.25);
    EXPECT_DOUBLE_EQ(s.Share(E), 0.20);
    EXPECT_DOUBLE_EQ(s.Share(D), 0.10);

    double sum = s.Share(Q) + s.Share(P) + s.Share(E) + s.Share(D);
    EXPECT_NEAR(sum, 1.0, 1e-9);
}

// Largest() returns the source with the greatest share.
TEST(BalanceShares, LargestPicksMaxShare)
{
    SourceTotals t;
    t.Add(Q, 10);
    t.Add(P, 80);
    t.Add(E, 5);
    t.Add(D, 5);

    EXPECT_EQ(ComputeShares(t).Largest(), P);
}
