#include "branding/insight/Insight.h"
#include "fakes/FakeClock.h"
#include "fakes/FakeInsightConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

// Raid boss yields ~1.0 and is NOT diminished by prior kills (the weekly lockout is the throttle).
TEST(Insight, RaidBossYieldsFullAndIsNotWindowed)
{
    FakeInsightConfig cfg;
    EXPECT_DOUBLE_EQ(InsightForKill(SourceRank::RaidBoss, 0, cfg), 1.0);
    EXPECT_DOUBLE_EQ(InsightForKill(SourceRank::RaidBoss, 10, cfg), 1.0);
    EXPECT_FALSE(RankIsWindowed(SourceRank::RaidBoss));
}

// Heroic dungeon bosses yield strictly more Insight than normal at the same prior count.
TEST(Insight, HeroicYieldsMoreThanNormal)
{
    FakeInsightConfig cfg;
    EXPECT_GT(InsightForKill(SourceRank::DungeonBossHeroic, 0, cfg),
        InsightForKill(SourceRank::DungeonBossNormal, 0, cfg));
}

// DR is monotonic NON-INCREASING in prior kills for every DR'd rank, and bounded >= 0.
TEST(Insight, DrMonotonicNonIncreasingAndBounded)
{
    FakeInsightConfig cfg;
    for (SourceRank rank : { SourceRank::DungeonBossHeroic, SourceRank::DungeonBossNormal, SourceRank::TrashMote })
    {
        double prev = InsightForKill(rank, 0, cfg);
        for (uint32_t prior = 1; prior < 20; ++prior)
        {
            double const cur = InsightForKill(rank, prior, cfg);
            EXPECT_LE(cur, prev) << "rank " << static_cast<int>(rank) << " prior " << prior;
            EXPECT_GE(cur, 0.0);
            prev = cur;
        }
    }
}

// Accrual is fractional (sub-item granularity) -- the first heroic kill is 0.5, not rounded to 0/1.
TEST(Insight, FractionalAccrual)
{
    FakeInsightConfig cfg;
    EXPECT_DOUBLE_EQ(InsightForKill(SourceRank::DungeonBossHeroic, 0, cfg), 0.5);
    EXPECT_DOUBLE_EQ(InsightForKill(SourceRank::DungeonBossHeroic, 1, cfg), 0.25);
    EXPECT_DOUBLE_EQ(InsightForKill(SourceRank::TrashMote, 0, cfg), 0.01);
}

// Trash mote is a tiny flat-ish breadcrumb -- far below a raid boss.
TEST(Insight, TrashMoteIsTiny)
{
    FakeInsightConfig cfg;
    EXPECT_LT(InsightForKill(SourceRank::TrashMote, 0, cfg),
        InsightForKill(SourceRank::DungeonBossNormal, 0, cfg) * 0.1);
}

// UnlockReached fires exactly at the threshold boundary (>=), not below it.
TEST(Insight, UnlockThresholdBoundary)
{
    FakeInsightConfig cfg;          // threshold 35.0
    EXPECT_FALSE(UnlockReached(34.999, cfg));
    EXPECT_TRUE(UnlockReached(35.0, cfg));
    EXPECT_TRUE(UnlockReached(35.001, cfg));
}

// EarnInsight accumulates fractional points and applies the account-wide DR across repeat kills.
TEST(Insight, EarnAccumulatesWithAccountWideDr)
{
    FakeInsightConfig cfg;
    FakeClock clock(1000);
    InsightState state;

    double const first = EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock);
    double const second = EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock);
    double const third = EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock);

    EXPECT_DOUBLE_EQ(first, 0.5);                       // prior 0
    EXPECT_DOUBLE_EQ(second, 0.25);                     // prior 1
    EXPECT_DOUBLE_EQ(third, 0.125);                     // prior 2
    EXPECT_DOUBLE_EQ(state.points, 0.875);
    EXPECT_EQ(state.windowUnits, 3u);
}

// Raid boss earns full points repeatedly and NEVER advances the DR window (lockout is the throttle).
TEST(Insight, RaidBossEarnDoesNotAdvanceWindow)
{
    FakeInsightConfig cfg;
    FakeClock clock(1000);
    InsightState state;

    EXPECT_DOUBLE_EQ(EarnInsight(state, SourceRank::RaidBoss, cfg, clock), 1.0);
    EXPECT_DOUBLE_EQ(EarnInsight(state, SourceRank::RaidBoss, cfg, clock), 1.0);
    EXPECT_EQ(state.windowUnits, 0u);
    EXPECT_DOUBLE_EQ(state.points, 2.0);
}

// The DR window decays after WindowSeconds: a later kill is at full value again.
TEST(Insight, WindowDecaysAfterWindowSeconds)
{
    FakeInsightConfig cfg;
    FakeClock clock(1000);
    InsightState state;

    EXPECT_DOUBLE_EQ(EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock), 0.5);   // prior 0
    EXPECT_DOUBLE_EQ(EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock), 0.25);  // prior 1

    clock.Advance(cfg.windowSeconds);                  // window fully elapses
    EXPECT_DOUBLE_EQ(EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock), 0.5);   // reset -> prior 0
    EXPECT_EQ(state.windowUnits, 1u);                  // window restarted with this kill
}

// Window does NOT decay just before WindowSeconds elapses -- DR still applies.
TEST(Insight, WindowPersistsBeforeWindowSeconds)
{
    FakeInsightConfig cfg;
    FakeClock clock(1000);
    InsightState state;

    EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock);                          // prior 0 -> 0.5
    clock.Advance(cfg.windowSeconds - 1);              // not yet elapsed
    EXPECT_DOUBLE_EQ(EarnInsight(state, SourceRank::DungeonBossHeroic, cfg, clock), 0.25);  // still DR'd (prior 1)
}

// Reaching the threshold via EarnInsight is observable and idempotent past the boundary.
TEST(Insight, EarnReachesThreshold)
{
    FakeInsightConfig cfg;
    cfg.unlockThreshold = 1.0;
    cfg.windowSeconds = 100;
    FakeClock clock(1000);
    InsightState state;

    EXPECT_FALSE(UnlockReached(state.points, cfg));
    EarnInsight(state, SourceRank::RaidBoss, cfg, clock);   // +1.0 -> exactly threshold
    EXPECT_TRUE(UnlockReached(state.points, cfg));
}

// Determinism: identical inputs (including injected clock) produce identical results.
TEST(Insight, Deterministic)
{
    FakeInsightConfig cfg;
    FakeClock clockA(5000);
    FakeClock clockB(5000);
    InsightState a;
    InsightState b;

    for (int i = 0; i < 6; ++i)
    {
        EXPECT_DOUBLE_EQ(EarnInsight(a, SourceRank::DungeonBossNormal, cfg, clockA),
            EarnInsight(b, SourceRank::DungeonBossNormal, cfg, clockB));
    }
    EXPECT_DOUBLE_EQ(a.points, b.points);
    EXPECT_EQ(a.windowUnits, b.windowUnits);
    EXPECT_EQ(a.windowStartUnix, b.windowStartUnix);
}
