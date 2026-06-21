#include "branding/mastery/MasteryPlan.h"
#include "branding/mastery/MasteryActive.h"
#include "branding/mastery/MasteryTrees.h"
#include "branding/common/Brand.h"
#include "fakes/FakeCatalystConfig.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    // Combined fake exposing the §14.10 envelope (IMasteryTreeConfig) plus the §14.10/§14.11 loadout
    // dials (IMasteryLoadoutConfig). Mirrors the production MasteryConfig, which implements both.
    class FakeTreeAndLoadoutConfig : public IMasteryTreeConfig, public IMasteryLoadoutConfig
    {
    public:
        uint8_t  maxLevel = 50;
        double   maxUptime = 0.60;
        double   halfLevel = 25.0;
        double   offSchool = 0.25;
        double   maxEnemyMul = 1.5;
        double   minPpm = 1.0;
        double   maxPpm = 10.0;
        uint32_t minWindowMs = 3000;
        uint32_t maxWindowMs = 12000;
        double   maxProcMagnitude = 2.0;
        double   minReach = 0.0;
        double   maxReach = 40.0;
        uint8_t  archetypeUnlockLevel = 20;

        uint8_t  pointsBudget = 10;
        uint32_t respecCost = 500;
        uint8_t  maxActive = 8;          // allow several active cells for the multi-mastery tests
        uint8_t  maxArchetypes = 3;

        uint8_t  MaxMasteryLevel() const override { return maxLevel; }
        double   MaxUptime() const override { return maxUptime; }
        double   UpkeepHalfLevel() const override { return halfLevel; }
        double   OffSchoolFactor() const override { return offSchool; }
        double   MaxEnemyMul() const override { return maxEnemyMul; }
        double   MinPpm() const override { return minPpm; }
        double   MaxPpm() const override { return maxPpm; }
        uint32_t MinWindowMs() const override { return minWindowMs; }
        uint32_t MaxWindowMs() const override { return maxWindowMs; }
        double   MaxProcMagnitude() const override { return maxProcMagnitude; }
        double   MinReach() const override { return minReach; }
        double   MaxReach() const override { return maxReach; }
        uint8_t  MaxArchetypesAtLevel(uint8_t level) const override
        {
            return static_cast<uint8_t>(1 + level / archetypeUnlockLevel);
        }
        uint8_t  PointsBudget() const override { return pointsBudget; }
        uint32_t RespecCost() const override { return respecCost; }
        uint8_t  MaxActive() const override { return maxActive; }
        uint8_t  MaxArchetypesPerCell() const override { return maxArchetypes; }
    };

    void SetPoints(ActiveMasteryEntry& e, uint8_t ppm, uint8_t dur, uint8_t mag, uint8_t reach)
    {
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Ppm)] = ppm;
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Duration)] = dur;
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Magnitude)] = mag;
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Reach)] = reach;
    }

    ActiveMasteryEntry Cell(BrandId school, MasteryTree tree, uint8_t archetype = 0)
    {
        ActiveMasteryEntry e;
        e.school = school;
        e.tree = tree;
        e.archetype = archetype;
        SetPoints(e, 4, 3, 2, 0);
        return e;
    }

    // A school state where everything is unlocked + leveled.
    MasterySchoolState FullState(uint8_t level = 40)
    {
        MasterySchoolState s;
        for (size_t i = 0; i < static_cast<size_t>(BrandId::COUNT); ++i)
        {
            s.level[i] = level;
            s.unlocked[i] = true;
        }
        return s;
    }

    struct Cfgs
    {
        FakeTreeAndLoadoutConfig tree;
        Branding::Test::FakeEffectConfig effect;
        Branding::Test::FakeCatalystConfig catalyst;
    };

    MasteryPlan Build(ActiveMasterySet const& set, MasterySchoolState const& state, Cfgs& c,
        RoleContribution role = RoleContribution::Damage,
        CatalystKey const* roster = nullptr, std::size_t rosterCount = 0)
    {
        return BuildMasteryPlan(set, state, role, roster, rosterCount, c.tree, c.tree, c.effect, c.catalyst);
    }
}

// An empty set yields an empty plan.
TEST(MasteryPlan, EmptySetYieldsEmptyPlan)
{
    Cfgs c;
    ActiveMasterySet set;
    MasteryPlan plan = Build(set, FullState(), c);
    EXPECT_EQ(plan.count, 0);
}

// A set whose only cell fails the dual key (locked account / level 0) yields an empty plan.
TEST(MasteryPlan, AllInvalidYieldsEmptyPlan)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Fire, MasteryTree::Offensive));

    MasterySchoolState locked = FullState();
    locked.unlocked[static_cast<size_t>(BrandId::Fire)] = false;   // anti-P2W: no account knowledge
    EXPECT_EQ(Build(set, locked, c).count, 0);

    MasterySchoolState noLevel = FullState();
    noLevel.level[static_cast<size_t>(BrandId::Fire)] = 0;         // no earned proficiency
    EXPECT_EQ(Build(set, noLevel, c).count, 0);
}

// A locked/out-of-range archetype excludes the cell (the def would otherwise clamp to the primary).
TEST(MasteryPlan, LockedArchetypeExcluded)
{
    Cfgs c;
    ActiveMasterySet set;
    // Fire-Support archetype 1 (flame aura) gates behind level 20 (FakeTree: +1 every 20 levels).
    set.Add(Cell(BrandId::Fire, MasteryTree::Support, /*archetype*/ 1));

    MasterySchoolState lowLevel = FullState(/*level*/ 10);   // archetype 1 not yet unlocked
    EXPECT_EQ(Build(set, lowLevel, c).count, 0);

    MasterySchoolState highLevel = FullState(/*level*/ 40);  // archetype 1 unlocked
    EXPECT_EQ(Build(set, highLevel, c).count, 1);
}

// Multi-mastery: N valid cells produce N effects, each carrying its own identity.
TEST(MasteryPlan, MultiMasteryAggregatesAllCells)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Fire, MasteryTree::Offensive));
    set.Add(Cell(BrandId::Frost, MasteryTree::Defensive));
    set.Add(Cell(BrandId::Nature, MasteryTree::Support));

    MasteryPlan plan = Build(set, FullState(), c);
    ASSERT_EQ(plan.count, 3);

    // Each input cell appears exactly once (order-independent membership check).
    bool sawFireOff = false, sawFrostDef = false, sawNatureSup = false;
    for (uint8_t i = 0; i < plan.count; ++i)
    {
        ResolvedMasteryEffect const& e = plan.effects[i];
        sawFireOff   |= (e.school == BrandId::Fire && e.tree == MasteryTree::Offensive);
        sawFrostDef  |= (e.school == BrandId::Frost && e.tree == MasteryTree::Defensive);
        sawNatureSup |= (e.school == BrandId::Nature && e.tree == MasteryTree::Support);
    }
    EXPECT_TRUE(sawFireOff);
    EXPECT_TRUE(sawFrostDef);
    EXPECT_TRUE(sawNatureSup);
}

// Raid magnitude is bounded: every raid-wide effect is in [1.0, MaxRaidMul].
TEST(MasteryPlan, RaidMagnitudeBounded)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Fire, MasteryTree::Offensive));    // RaidWindow => raid-wide
    set.Add(Cell(BrandId::Nature, MasteryTree::Support, 1)); // raid-heal utility (sustained, non-situational)

    MasteryPlan plan = Build(set, FullState(), c);
    bool sawRaid = false;
    for (uint8_t i = 0; i < plan.count; ++i)
    {
        ResolvedMasteryEffect const& e = plan.effects[i];
        if (!e.raidWide)
            continue;
        sawRaid = true;
        EXPECT_GE(e.magnitude, 1.0);
        EXPECT_LE(e.magnitude, c.effect.MaxRaidMul() + 1e-9);
    }
    EXPECT_TRUE(sawRaid);
}

// Personal magnitude is bounded by MaxPersonalMul (and >= 1.0).
TEST(MasteryPlan, PersonalMagnitudeBounded)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Frost, MasteryTree::Defensive));   // PersonalSpike, personal

    MasteryPlan plan = Build(set, FullState(), c, RoleContribution::Tank);
    ASSERT_EQ(plan.count, 1);
    ResolvedMasteryEffect const& e = plan.effects[0];
    EXPECT_FALSE(e.raidWide);
    EXPECT_GE(e.magnitude, 1.0);
    EXPECT_LE(e.magnitude, c.effect.MaxPersonalMul() + 1e-9);
}

// Raid magnitude is non-increasing as the SAME (school, tree) bucket stacks (catalyst DR).
TEST(MasteryPlan, RaidMagnitudeNonIncreasingWithBucketStack)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Fire, MasteryTree::Offensive));

    // Roster with two prior Fire-Off specialists -> the player's own cell is rank 3 in its bucket.
    CatalystKey roster[] = {
        { BrandId::Fire, MasteryTree::Offensive },
        { BrandId::Fire, MasteryTree::Offensive },
        { BrandId::Fire, MasteryTree::Offensive },   // the player (index 2)
    };

    MasteryPlan rank1 = Build(set, FullState(), c);                       // solo: own set only, rank 1
    MasteryPlan rank3 = Build(set, FullState(), c, RoleContribution::Damage, roster, 3);

    ASSERT_EQ(rank1.count, 1);
    ASSERT_EQ(rank3.count, 1);
    EXPECT_EQ(rank1.effects[0].catalystRank, 1);
    EXPECT_GE(rank3.effects[0].catalystRank, rank1.effects[0].catalystRank);
    EXPECT_LE(rank3.effects[0].magnitude, rank1.effects[0].magnitude + 1e-9);  // DR: never larger
}

// Sustained cells carry uptime 1.0 (constant aura); windowed cells get 0 < uptime < 1.0.
TEST(MasteryPlan, SustainedVsWindowedUptime)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Fire, MasteryTree::Offensive));    // windowed
    set.Add(Cell(BrandId::Fire, MasteryTree::Support));      // sustained Support (SM primary)

    MasteryPlan plan = Build(set, FullState(), c);
    ASSERT_EQ(plan.count, 2);
    for (uint8_t i = 0; i < plan.count; ++i)
    {
        ResolvedMasteryEffect const& e = plan.effects[i];
        if (e.def.sustained)
        {
            EXPECT_DOUBLE_EQ(e.uptimeFraction, 1.0);
        }
        else
        {
            EXPECT_GT(e.uptimeFraction, 0.0);
            EXPECT_LT(e.uptimeFraction, 1.0);
        }
    }
}

// Determinism: identical inputs produce an identical plan.
TEST(MasteryPlan, Deterministic)
{
    Cfgs c;
    ActiveMasterySet set;
    set.Add(Cell(BrandId::Fire, MasteryTree::Offensive));
    set.Add(Cell(BrandId::Shadow, MasteryTree::Defensive));

    MasteryPlan a = Build(set, FullState(), c);
    MasteryPlan b = Build(set, FullState(), c);
    ASSERT_EQ(a.count, b.count);
    for (uint8_t i = 0; i < a.count; ++i)
    {
        EXPECT_EQ(a.effects[i].school, b.effects[i].school);
        EXPECT_EQ(a.effects[i].tree, b.effects[i].tree);
        EXPECT_EQ(a.effects[i].raidWide, b.effects[i].raidWide);
        EXPECT_DOUBLE_EQ(a.effects[i].magnitude, b.effects[i].magnitude);
        EXPECT_DOUBLE_EQ(a.effects[i].resolved.ppm, b.effects[i].resolved.ppm);
        EXPECT_EQ(a.effects[i].resolved.windowDurationMs, b.effects[i].resolved.windowDurationMs);
        EXPECT_DOUBLE_EQ(a.effects[i].uptimeFraction, b.effects[i].uptimeFraction);
    }
}

// The resolved cell reflects the point-buy: a ppm-heavy spend resolves to a higher ppm than a
// magnitude-heavy spend (the §14.10 -> §14.10 path is actually exercised).
TEST(MasteryPlan, ResolvedCellReflectsPointBuy)
{
    Cfgs c;
    ActiveMasteryEntry ppmHeavy = Cell(BrandId::Fire, MasteryTree::Offensive);
    SetPoints(ppmHeavy, /*ppm*/ 8, /*dur*/ 0, /*mag*/ 0, /*reach*/ 0);
    ActiveMasteryEntry magHeavy = Cell(BrandId::Frost, MasteryTree::Offensive);
    SetPoints(magHeavy, /*ppm*/ 0, /*dur*/ 0, /*mag*/ 8, /*reach*/ 0);

    ActiveMasterySet set;
    set.Add(ppmHeavy);
    set.Add(magHeavy);

    MasteryPlan plan = Build(set, FullState(), c);
    ASSERT_EQ(plan.count, 2);

    double ppmFire = 0.0, ppmFrost = 0.0;
    for (uint8_t i = 0; i < plan.count; ++i)
    {
        if (plan.effects[i].school == BrandId::Fire)
            ppmFire = plan.effects[i].resolved.ppm;
        else
            ppmFrost = plan.effects[i].resolved.ppm;
    }
    EXPECT_GT(ppmFire, ppmFrost);   // the ppm-heavy build resolves to a higher proc rate
}
