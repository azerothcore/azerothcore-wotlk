#include "branding/proficiency/BrandXp.h"
#include "branding/proficiency/Proficiency.h"
#include "fakes/FakeClock.h"
#include "fakes/FakeConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    KnowledgeState Unlocked(BrandId b)
    {
        return KnowledgeState{ static_cast<uint32_t>(1u << static_cast<int>(b)) };
    }

    XpActivity MakeActivity(ActivitySource src, BrandId active, BrandId content,
        RoleContribution role, uint32_t units)
    {
        XpActivity a;
        a.source = src;
        a.activeBrand = active;
        a.contentBrand = content;
        a.role = role;
        a.baseUnits = units;
        return a;
    }
}

// base gain with neutral config equals baseUnits * weight
TEST(BrandXp, BaseGainEqualsUnitsTimesWeight)
{
    FakeConfig cfg;
    cfg.sourceWeight[static_cast<size_t>(ActivitySource::Invasion)] = 2.0;
    FakeClock clock;
    ProficiencyState s;

    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::None, 10);
    EXPECT_EQ(ComputeXpGain(a, s, cfg, clock), 20u);
}

// brand-match bonus applied iff activeBrand == contentBrand
TEST(BrandXp, MatchBonusAppliedOnlyWhenBrandsMatch)
{
    FakeConfig cfg;
    cfg.matchBonus = 1.25;
    FakeClock clock;
    ProficiencyState s;

    auto matched = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Fire, RoleContribution::None, 100);
    auto mismatched = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);

    EXPECT_EQ(ComputeXpGain(matched, s, cfg, clock), 125u);
    EXPECT_EQ(ComputeXpGain(mismatched, s, cfg, clock), 100u);
}

// role multiplier applied per role
TEST(BrandXp, RoleMultiplierApplied)
{
    FakeConfig cfg;
    cfg.roleMul[static_cast<size_t>(RoleContribution::Damage)] = 1.5;
    FakeClock clock;
    ProficiencyState s;

    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::Damage, 100);
    EXPECT_EQ(ComputeXpGain(a, s, cfg, clock), 150u);
}

// source relevance scales gain (invasion > gathering)
TEST(BrandXp, RelevanceScalesGainBySource)
{
    FakeConfig cfg;
    cfg.relevance[static_cast<size_t>(ActivitySource::Invasion)] = 1.0;
    cfg.relevance[static_cast<size_t>(ActivitySource::Gathering)] = 0.5;
    FakeClock clock;
    ProficiencyState s;

    auto invasion = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);
    auto gathering = MakeActivity(ActivitySource::Gathering, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);

    EXPECT_GT(ComputeXpGain(invasion, s, cfg, clock), ComputeXpGain(gathering, s, cfg, clock));
}

// DR kicks in past the soft cap and never drops below the floor
TEST(BrandXp, DiminishingReturnsClampedToFloor)
{
    FakeConfig cfg;
    cfg.drSoftCap = 100;
    cfg.drSlope = 0.01;
    cfg.drFloor = 0.1;
    FakeClock clock;

    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);

    ProficiencyState fresh;
    uint32_t full = ComputeXpGain(a, fresh, cfg, clock);

    ProficiencyState farmed;
    farmed.recentXpWindow = 100000;       // way past soft cap -> clamp to floor
    farmed.windowStartUnix = clock.NowUnix();
    uint32_t reduced = ComputeXpGain(a, farmed, cfg, clock);

    EXPECT_LT(reduced, full);
    EXPECT_EQ(reduced, 10u);              // round(100 * floor 0.1)
}

// DR window decays with clock advance -> full XP restored after the window
TEST(BrandXp, DiminishingReturnsWindowDecays)
{
    FakeConfig cfg;
    cfg.drSoftCap = 100;
    cfg.drSlope = 0.01;
    cfg.drFloor = 0.1;
    cfg.drWindowSeconds = 3600;
    FakeClock clock(1000);

    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);

    ProficiencyState s;
    s.recentXpWindow = 100000;
    s.windowStartUnix = 1000;

    uint32_t duringWindow = ComputeXpGain(a, s, cfg, clock);
    clock.Advance(3600);                  // window fully elapsed
    uint32_t afterWindow = ComputeXpGain(a, s, cfg, clock);

    EXPECT_EQ(duringWindow, 10u);
    EXPECT_EQ(afterWindow, 100u);         // window decayed -> no DR
}

// branded items modify XP via source efficiency (config), NOT as additive XP
TEST(BrandXp, BrandedItemModifiesEfficiencyNotAdditiveXp)
{
    FakeClock clock;
    ProficiencyState s;
    auto a = MakeActivity(ActivitySource::Gathering, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);

    FakeConfig base;
    base.sourceWeight[static_cast<size_t>(ActivitySource::Gathering)] = 0.5;

    FakeConfig withBrandedTool;
    withBrandedTool.sourceWeight[static_cast<size_t>(ActivitySource::Gathering)] = 1.0;  // tool boosts efficiency

    EXPECT_GT(ComputeXpGain(a, s, withBrandedTool, clock), ComputeXpGain(a, s, base, clock));
}

// knowledge gate: locked brand yields 0 XP and does not mutate state
TEST(BrandXp, LockedBrandYieldsZeroXp)
{
    FakeConfig cfg;
    cfg.sourceWeight[static_cast<size_t>(ActivitySource::Invasion)] = 2.0;
    FakeClock clock;
    ProficiencyState s;

    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Shadow, BrandId::Shadow, RoleContribution::None, 100);
    KnowledgeState noShadow = Unlocked(BrandId::Fire);

    XpResult r = ApplyActivity(s, a, noShadow, cfg, clock);
    EXPECT_EQ(r.xpGained, 0u);
    EXPECT_EQ(s.totalXp, 0u);
}

// ApplyActivity is monotonic: totalXp grows, level never decreases
TEST(BrandXp, ApplyActivityIsMonotonic)
{
    FakeConfig cfg;
    FakeClock clock;
    ProficiencyState s;
    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Fire, RoleContribution::Damage, 100);
    KnowledgeState k = Unlocked(BrandId::Fire);

    uint64_t prev = s.totalXp;
    for (int i = 0; i < 5; ++i)
    {
        XpResult r = ApplyActivity(s, a, k, cfg, clock);
        EXPECT_GT(s.totalXp, prev);
        EXPECT_GE(r.levelAfter, r.levelBefore);
        prev = s.totalXp;
    }
}

// determinism: same inputs + same clock => identical result
TEST(BrandXp, DeterministicGivenInputs)
{
    FakeConfig cfg;
    FakeClock clock;
    auto a = MakeActivity(ActivitySource::Raid, BrandId::Fire, BrandId::Fire, RoleContribution::Healer, 73);
    KnowledgeState k = Unlocked(BrandId::Fire);

    ProficiencyState s1;
    ProficiencyState s2;
    XpResult r1 = ApplyActivity(s1, a, k, cfg, clock);
    XpResult r2 = ApplyActivity(s2, a, k, cfg, clock);

    EXPECT_EQ(r1.xpGained, r2.xpGained);
    EXPECT_EQ(s1.totalXp, s2.totalXp);
}

// reachedPrestige fires exactly once, when max level is first reached
TEST(BrandXp, ReachedPrestigeFiresOnceAtCap)
{
    FakeConfig cfg;
    cfg.rankBaseXp = 10.0;
    cfg.rankGrowth = 2.0;
    cfg.maxLevel = 2;                     // geometric: XpForLevel(2) = 10 * (2^2 - 1)/(2 - 1) = 30
    FakeClock clock;
    ProficiencyState s;
    auto a = MakeActivity(ActivitySource::Invasion, BrandId::Fire, BrandId::Frost, RoleContribution::None, 100);
    KnowledgeState k = Unlocked(BrandId::Fire);

    XpResult first = ApplyActivity(s, a, k, cfg, clock);
    EXPECT_EQ(first.levelAfter, 2);
    EXPECT_TRUE(first.reachedPrestige);

    XpResult second = ApplyActivity(s, a, k, cfg, clock);
    EXPECT_EQ(second.levelAfter, 2);
    EXPECT_FALSE(second.reachedPrestige);
}
