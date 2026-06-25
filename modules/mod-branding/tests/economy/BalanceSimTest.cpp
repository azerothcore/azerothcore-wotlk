// #14 / §8.5 XP-source balance regression sim + §14.13.6 prestige-pacing gate.
//
// Deterministic economy simulation: feed the owner-ratified representative play-session profile
// through the XP sources AT PRODUCTION RATES (§10.1) and assert (a) the aggregate shares hold the
// 45/25/20/10 mix with Questing largest, and (b) time-to-Prestige stays near ~3 months. Both share a
// single profile artifact, so re-tuning one re-derives the other (no separate knobs).

#include "branding/economy/BalanceShares.h"
#include "branding/proficiency/Proficiency.h"
#include "fakes/FakeConfig.h"
#include <cmath>
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    constexpr auto Q = XpSource::Questing;
    constexpr auto P = XpSource::Professions;
    constexpr auto E = XpSource::Exploration;
    constexpr auto D = XpSource::Discoveries;

    // §8.5 targets and tolerance (3 percentage points).
    constexpr double kTargetQuest = 0.45;
    constexpr double kTargetProf  = 0.25;
    constexpr double kTargetExpl  = 0.20;
    constexpr double kTargetDisc  = 0.10;
    constexpr double kShareTol    = 0.03;

    // Owner-ratified representative daily session (§14.13.6), expressed in ACTIVITY terms (pre-rate),
    // calibrated for the production 5x baseline. Questing is the only rate-coupled source (§10.1:
    // discovery/profession/event XP are rate-independent). At 5x: 108000*5 = 540000 quest XP/day, so
    // the post-rate day is Q540k/P300k/E240k/D120k = 1.20M XP/day -> exactly the 45/25/20/10 mix.
    struct DailyProfile
    {
        uint64_t questBasePreRate = 108'000; // * questRate -> post-rate questing XP
        uint64_t professions      = 300'000; // rate-independent
        uint64_t exploration      = 240'000;
        uint64_t discoveries      = 120'000;
    };

    // Run one representative day at a given production quest-rate, re-deriving nothing: the activity
    // profile is fixed, the rate flows through Questing (and invasion-containment, folded in).
    SourceTotals RunDay(DailyProfile const& p, double questRate)
    {
        SourceTotals t;
        t.Add(Q, static_cast<uint64_t>(std::llround(static_cast<double>(p.questBasePreRate) * questRate)));
        t.Add(P, p.professions);
        t.Add(E, p.exploration);
        t.Add(D, p.discoveries);
        return t;
    }

    FakeConfig ProductionCurve()
    {
        FakeConfig cfg;
        cfg.rankBaseXp = 1'670'800.0; // live level-79->80 XP
        cfg.rankGrowth = 1.01;        // +1%/rank
        cfg.maxLevel = 50;            // 50 ranks
        return cfg;
    }
}

// Risk #2: at the production 5x baseline the ratified profile holds the target mix, Questing largest.
TEST(BalanceSim, HoldsAtProductionRates)
{
    BalanceShares s = ComputeShares(RunDay(DailyProfile{}, 5.0));

    EXPECT_NEAR(s.Share(Q), kTargetQuest, kShareTol);
    EXPECT_NEAR(s.Share(P), kTargetProf, kShareTol);
    EXPECT_NEAR(s.Share(E), kTargetExpl, kShareTol);
    EXPECT_NEAR(s.Share(D), kTargetDisc, kShareTol);
    EXPECT_EQ(s.Largest(), Q);
}

// The gate has teeth (1/2): bumping the rate 5x->7x WITHOUT re-deriving quest volume inflates the
// Questing share past tolerance -- exactly the Risk #2 failure the sim is meant to catch.
TEST(BalanceSim, RateBumpWithoutRederiveBreaksInvariant)
{
    BalanceShares s = ComputeShares(RunDay(DailyProfile{}, 7.0));
    EXPECT_GT(s.Share(Q), kTargetQuest + kShareTol);
}

// ...and re-deriving the quest volume for 7x (so post-rate questing stays 540k) restores the mix.
TEST(BalanceSim, SevenXHoldsWhenWeightsRederived)
{
    DailyProfile p;
    p.questBasePreRate = static_cast<uint64_t>(std::llround(540'000.0 / 7.0)); // re-derived weight
    BalanceShares s = ComputeShares(RunDay(p, 7.0));

    EXPECT_NEAR(s.Share(Q), kTargetQuest, kShareTol);
    EXPECT_EQ(s.Largest(), Q);
}

// The gate has teeth (2/2): if profession tuning drifts up (3x), professions dwarf questing and the
// "Questing largest" invariant fails -- the §8.5 anti-obsolescence guard fires.
TEST(BalanceSim, ProfessionDriftBreaksInvariant)
{
    DailyProfile p;
    p.professions *= 3; // 300k -> 900k
    BalanceShares s = ComputeShares(RunDay(p, 5.0));

    EXPECT_NE(s.Largest(), Q);
    EXPECT_GT(s.Share(P), kTargetProf + kShareTol);
}

// §14.13.6: time-to-Prestige for one school ~ 3 months for the ratified profile. With the 1:1 redirect
// the daily proficiency XP equals the daily player XP; days = XpForLevel(MaxLevel) / dailyXp.
TEST(BalanceSim, TimeToPrestigeNearThreeMonths)
{
    FakeConfig cfg = ProductionCurve();

    uint64_t const dailyXp = RunDay(DailyProfile{}, 5.0).Total(); // 1.20M/day at 1:1 redirect
    uint64_t const toPrestige = XpForLevel(cfg.maxLevel, cfg);    // ~107.7M

    double const days = static_cast<double>(toPrestige) / static_cast<double>(dailyXp);

    // ~90 days, within ~3 months +/- ~1 week of tolerance.
    EXPECT_GE(days, 83.0);
    EXPECT_LE(days, 97.0);
}
