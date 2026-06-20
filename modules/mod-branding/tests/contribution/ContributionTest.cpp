#include "contribution/Contribution.h"
#include "fakes/FakeClock.h"
#include "fakes/FakeContributionConfig.h"
#include <gtest/gtest.h>
#include <vector>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    // A signal that clears the anti-leech floors (an actively-participating player).
    ActivitySignal Active()
    {
        return ActivitySignal{ 1000, 10, 10 };
    }
}

// §9.2: raw scores match the action table
TEST(Contribution, ScoreActionMatchesTable)
{
    FakeContributionConfig cfg;
    EXPECT_EQ(ScoreAction(EventAction::InvadingKill, 0, cfg), 1u);
    EXPECT_EQ(ScoreAction(EventAction::EliteKill, 0, cfg), 5u);
    EXPECT_EQ(ScoreAction(EventAction::MiniBoss, 0, cfg), 15u);
    EXPECT_EQ(ScoreAction(EventAction::GatherResource, 0, cfg), 2u);
    EXPECT_EQ(ScoreAction(EventAction::CraftItem, 0, cfg), 10u);
    EXPECT_EQ(ScoreAction(EventAction::DiscoverObjective, 0, cfg), 8u);
}

// §9.2: Heal scales with magnitude within [1, HealMaxPoints]
TEST(Contribution, HealScoreScalesWithMagnitude)
{
    FakeContributionConfig cfg;
    EXPECT_EQ(ScoreAction(EventAction::Heal, 0, cfg), 1u);
    EXPECT_GT(ScoreAction(EventAction::Heal, 5000, cfg), 1u);
    EXPECT_EQ(ScoreAction(EventAction::Heal, 1000000, cfg), cfg.healMaxPoints);
}

// §9.3 hourly cap: points credited per rolling hour never exceed the cap; resets on window roll
TEST(Contribution, HourlyCapClampsAndResets)
{
    FakeContributionConfig cfg;
    cfg.hourlyCap = 10;
    cfg.eventDrSlope = 0.0;          // isolate the cap from DR
    FakeClock clock(1000);
    ParticipationState s;

    uint32_t first = ApplyEventAction(s, EventType::Invasion, EventAction::MiniBoss, 0, Active(), cfg, clock);
    uint32_t second = ApplyEventAction(s, EventType::Invasion, EventAction::MiniBoss, 0, Active(), cfg, clock);
    EXPECT_EQ(first, 10u);           // 15 scored, clamped to cap
    EXPECT_EQ(second, 0u);           // cap exhausted
    EXPECT_LE(s.pointsThisHour, cfg.hourlyCap);

    clock.Advance(3600);             // hour rolls over
    uint32_t afterReset = ApplyEventAction(s, EventType::Invasion, EventAction::MiniBoss, 0, Active(), cfg, clock);
    EXPECT_GT(afterReset, 0u);
}

// §9.3 daily DR: repeated participation in the same event type yields strictly less, down to a floor
TEST(Contribution, DailyDiminishingReturnsPerEventType)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    ParticipationState s;

    std::vector<uint32_t> grants;
    for (int i = 0; i < 6; ++i)
        grants.push_back(ApplyEventAction(s, EventType::EliteHunt, EventAction::MiniBoss, 0, Active(), cfg, clock));

    EXPECT_LT(grants[1], grants[0]);                 // DR kicked in
    for (size_t i = 1; i < grants.size(); ++i)
        EXPECT_LE(grants[i], grants[i - 1]);         // non-increasing
    uint32_t const floorPoints = static_cast<uint32_t>(15 * cfg.eventDrFloor + 0.5);
    EXPECT_GE(grants.back(), floorPoints);           // never below the floor
}

// §9.3 daily DR resets after the day window elapses
TEST(Contribution, DailyDrResetsAfterDayWindow)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    ParticipationState s;

    uint32_t fresh = ApplyEventAction(s, EventType::EliteHunt, EventAction::MiniBoss, 0, Active(), cfg, clock);
    for (int i = 0; i < 5; ++i)
        ApplyEventAction(s, EventType::EliteHunt, EventAction::MiniBoss, 0, Active(), cfg, clock);

    clock.Advance(86400);            // a day passes
    uint32_t afterDay = ApplyEventAction(s, EventType::EliteHunt, EventAction::MiniBoss, 0, Active(), cfg, clock);
    EXPECT_EQ(afterDay, fresh);      // DR counter reset -> full points again
}

// Adversarial (§10 charter): AFK in a zerg -> no own activity -> zero points, no state change
TEST(Contribution, Leech_AfkInZerg_ScoresZero)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    ParticipationState s;

    ActivitySignal afk{ 0, 0, 0 };
    uint32_t granted = ApplyEventAction(s, EventType::Invasion, EventAction::MiniBoss, 0, afk, cfg, clock);
    EXPECT_EQ(granted, 0u);
    EXPECT_EQ(s.pointsThisHour, 0u);
}

// Adversarial (§10 charter): tag-and-leave -> below activity floors -> zero points
TEST(Contribution, Leech_TagAndLeave_ScoresZero)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    ParticipationState s;

    ActivitySignal tag{ 50, 0, 200 };   // a little damage + moving, but below floors and no actions
    EXPECT_EQ(ApplyEventAction(s, EventType::Invasion, EventAction::InvadingKill, 0, tag, cfg, clock), 0u);
}

// A controller/support with low damage but real actions is NOT treated as a leech
TEST(Contribution, ActiveSupportNotTreatedAsLeech)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    ParticipationState s;

    ActivitySignal support{ 0, 5, 10 };   // no damage, but 5 actions
    EXPECT_GT(ApplyEventAction(s, EventType::Invasion, EventAction::Heal, 10000, support, cfg, clock), 0u);
}

// Determinism
TEST(Contribution, Deterministic)
{
    FakeContributionConfig cfg;
    FakeClock clock(1000);
    ParticipationState a;
    ParticipationState b;
    EXPECT_EQ(ApplyEventAction(a, EventType::Invasion, EventAction::EliteKill, 0, Active(), cfg, clock),
              ApplyEventAction(b, EventType::Invasion, EventAction::EliteKill, 0, Active(), cfg, clock));
}
