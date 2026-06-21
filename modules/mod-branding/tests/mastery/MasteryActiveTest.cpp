#include "branding/mastery/MasteryActive.h"
#include "branding/mastery/MasteryTrees.h"
#include "branding/common/Brand.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    // Local fake config exposing the §14.10 envelope (IMasteryTreeConfig) plus the new loadout dials
    // (IMasteryLoadoutConfig: PointsBudget, RespecCost, MaxActive). Mirrors the one in MasteryTreesTest
    // with the loadout extensions; the production MasteryConfig implements both interfaces too.
    class FakeMasteryTreeConfig : public IMasteryTreeConfig, public IMasteryLoadoutConfig
    {
    public:
        uint8_t  maxLevel = 50;
        double   maxUptime = 0.60;
        double   halfLevel = 25.0;
        double   offSchool = 0.25;
        double   maxEnemyMul = 1.5;
        double   enemyEliteLevelFraction = 0.5;
        double   minPpm = 1.0;
        double   maxPpm = 10.0;
        uint32_t minWindowMs = 3000;
        uint32_t maxWindowMs = 12000;
        double   maxProcMagnitude = 2.0;
        double   minReach = 0.0;
        double   maxReach = 40.0;

        // §14.10 / §14.11 loadout dials.
        uint8_t  pointsBudget = 10;
        uint32_t respecCost = 500;
        uint8_t  maxActive = 1;
        uint8_t  maxArchetypes = 3;

        uint8_t  MaxMasteryLevel() const override { return maxLevel; }
        double   MaxUptime() const override { return maxUptime; }
        double   UpkeepHalfLevel() const override { return halfLevel; }
        double   OffSchoolFactor() const override { return offSchool; }
        double   MaxEnemyMul() const override { return maxEnemyMul; }
        double   EnemyEliteLevelFraction() const override { return enemyEliteLevelFraction; }
        double   MinPpm() const override { return minPpm; }
        double   MaxPpm() const override { return maxPpm; }
        uint32_t MinWindowMs() const override { return minWindowMs; }
        uint32_t MaxWindowMs() const override { return maxWindowMs; }
        double   MaxProcMagnitude() const override { return maxProcMagnitude; }
        double   MinReach() const override { return minReach; }
        double   MaxReach() const override { return maxReach; }
        uint8_t  MaxArchetypesAtLevel(uint8_t level) const override { return static_cast<uint8_t>(1 + level / 20); }
        uint8_t  PointsBudget() const override { return pointsBudget; }
        uint32_t RespecCost() const override { return respecCost; }
        uint8_t  MaxActive() const override { return maxActive; }
        uint8_t  MaxArchetypesPerCell() const override { return maxArchetypes; }
    };

    constexpr uint32_t MASK_PDM = AxisBit(ProcAxis::Ppm) | AxisBit(ProcAxis::Duration) |
                                  AxisBit(ProcAxis::Magnitude);
    constexpr uint32_t MASK_PDMR = MASK_PDM | AxisBit(ProcAxis::Reach);

    void SetPoints(ActiveMasteryEntry& e, uint8_t ppm, uint8_t dur, uint8_t mag, uint8_t reach)
    {
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Ppm)] = ppm;
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Duration)] = dur;
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Magnitude)] = mag;
        e.pointsPerAxis[static_cast<size_t>(ProcAxis::Reach)] = reach;
    }
}

// ---- Point-buy -> shares (the §14.10 quantization contract) ----

// Zero points -> all-zero shares -> ResolveTreeCell's even-split baseline.
TEST(MasteryActive, PointsZeroYieldsBaseline)
{
    FakeMasteryTreeConfig cfg;
    uint8_t points[static_cast<size_t>(ProcAxis::COUNT)] = { 0, 0, 0, 0 };
    TreeAllocation alloc = PointsToAllocation(points, MASK_PDMR, cfg);

    ResolvedCell fromPoints = ResolveTreeCell(alloc, MASK_PDMR, 40, cfg);
    TreeAllocation even;  // default {1,1,1,1}
    ResolvedCell baseline = ResolveTreeCell(even, MASK_PDMR, 40, cfg);

    EXPECT_DOUBLE_EQ(fromPoints.ppm, baseline.ppm);
    EXPECT_EQ(fromPoints.windowDurationMs, baseline.windowDurationMs);
    EXPECT_DOUBLE_EQ(fromPoints.magnitude, baseline.magnitude);
    EXPECT_DOUBLE_EQ(fromPoints.reach, baseline.reach);
}

// Conservation: a spend exceeding the budget is clamped, never overflowed -- the resolved cell is
// identical to a spend that exactly hits the budget at the same ratio.
TEST(MasteryActive, PointsConservationClampedToBudget)
{
    FakeMasteryTreeConfig cfg;
    cfg.pointsBudget = 10;
    // All-into-ppm, way over budget; clamps to the budget on the single applicable axis.
    uint8_t over[static_cast<size_t>(ProcAxis::COUNT)] = { 200, 0, 0, 0 };
    uint8_t exact[static_cast<size_t>(ProcAxis::COUNT)] = { 10, 0, 0, 0 };

    ResolvedCell o = ResolveTreeCell(PointsToAllocation(over, MASK_PDMR, cfg), MASK_PDMR, 40, cfg);
    ResolvedCell e = ResolveTreeCell(PointsToAllocation(exact, MASK_PDMR, cfg), MASK_PDMR, 40, cfg);
    EXPECT_DOUBLE_EQ(o.ppm, e.ppm);

    // And the all-into-one cell at full budget never exceeds the per-axis envelope.
    EXPECT_LE(o.ppm, cfg.maxPpm);
    EXPECT_GE(o.ppm, cfg.minPpm);
}

// Deterministic + ratio-preserving: same points + same mask -> identical shares each call; and two
// spends with the same ratio resolve to the same cell.
TEST(MasteryActive, PointsDeterministicAndRatioPreserving)
{
    FakeMasteryTreeConfig cfg;
    uint8_t a[static_cast<size_t>(ProcAxis::COUNT)] = { 2, 4, 0, 0 };
    TreeAllocation x = PointsToAllocation(a, MASK_PDMR, cfg);
    TreeAllocation y = PointsToAllocation(a, MASK_PDMR, cfg);
    for (size_t i = 0; i < static_cast<size_t>(ProcAxis::COUNT); ++i)
        EXPECT_DOUBLE_EQ(x.share[i], y.share[i]);
}

// Non-applicable-axis points are inert: spending on Reach in a 3-axis (no-reach) cell changes nothing.
TEST(MasteryActive, PointsNonApplicableAxisInert)
{
    FakeMasteryTreeConfig cfg;
    uint8_t withReach[static_cast<size_t>(ProcAxis::COUNT)] = { 2, 2, 2, 4 };
    uint8_t noReach[static_cast<size_t>(ProcAxis::COUNT)] = { 2, 2, 2, 0 };

    ResolvedCell a = ResolveTreeCell(PointsToAllocation(withReach, MASK_PDM, cfg), MASK_PDM, 40, cfg);
    ResolvedCell b = ResolveTreeCell(PointsToAllocation(noReach, MASK_PDM, cfg), MASK_PDM, 40, cfg);
    EXPECT_DOUBLE_EQ(a.ppm, b.ppm);
    EXPECT_DOUBLE_EQ(a.magnitude, b.magnitude);
}

// ---- Respec cost (the §14.5 / §14.11 friction distinction) ----

TEST(MasteryActive, RespecCostFreeForSpecSwitch)
{
    FakeMasteryTreeConfig cfg;
    EXPECT_EQ(MasteryRespecCost(LoadoutChange::SwitchSpec, cfg), 0u);
    EXPECT_EQ(MasteryRespecCost(LoadoutChange::Reallocate, cfg), cfg.respecCost);
}

// ---- Loadout validation (dual-key mirror, §14 / §7.9) ----

TEST(MasteryActive, EntryValidRequiresBothKeys)
{
    FakeMasteryTreeConfig cfg;
    ActiveMasteryEntry e{ BrandId::Fire, MasteryTree::Offensive, 0, { 5, 5, 0, 0 } };

    EXPECT_TRUE(IsActiveEntryValid(e, /*accountUnlocked*/ true, /*schoolLevel*/ 10, cfg));
    EXPECT_FALSE(IsActiveEntryValid(e, /*accountUnlocked*/ false, /*schoolLevel*/ 10, cfg)); // no unlock
    EXPECT_FALSE(IsActiveEntryValid(e, /*accountUnlocked*/ true, /*schoolLevel*/ 0, cfg));   // no level
}

TEST(MasteryActive, EntryInvalidWhenPointsExceedBudget)
{
    FakeMasteryTreeConfig cfg;
    cfg.pointsBudget = 10;
    ActiveMasteryEntry e{ BrandId::Fire, MasteryTree::Offensive, 0, { 8, 8, 0, 0 } }; // 16 > 10
    EXPECT_FALSE(IsActiveEntryValid(e, true, 10, cfg));

    SetPoints(e, 5, 5, 0, 0); // 10 == budget -> ok
    EXPECT_TRUE(IsActiveEntryValid(e, true, 10, cfg));
}

// ---- ActiveMasterySet: a COLLECTION keyed by (school, tree) ----

// Add is config-free: it rejects a DUPLICATE (school, tree) cell (the collection key) and a full
// fixed Capacity. The cfg.MaxActive() v1 cap is a VALIDITY rule (IsActiveSetValid), kept separate.
TEST(MasteryActive, SetAddRejectsDuplicateCellAndFullCapacity)
{
    ActiveMasterySet set;
    ActiveMasteryEntry fireOff{ BrandId::Fire, MasteryTree::Offensive, 0, { 5, 5, 0, 0 } };
    ActiveMasteryEntry fireDef{ BrandId::Fire, MasteryTree::Defensive, 0, { 5, 5, 0, 0 } };
    ActiveMasteryEntry fireOff2{ BrandId::Fire, MasteryTree::Offensive, 1, { 0, 0, 0, 0 } };

    EXPECT_TRUE(set.Add(fireOff));
    EXPECT_FALSE(set.Add(fireOff2));  // same (school, tree) -> rejected (collection key)
    EXPECT_TRUE(set.Add(fireDef));    // distinct cell -> ok
    EXPECT_EQ(set.Count(), 2u);

    // Fill to capacity, then the next distinct cell is rejected (fixed-cap collection).
    BrandId const schools[] = { BrandId::Frost, BrandId::Nature, BrandId::Shadow, BrandId::Arcane,
                                BrandId::Holy, BrandId::Physical };
    MasteryTree const trees[] = { MasteryTree::Defensive, MasteryTree::Offensive, MasteryTree::Support };
    for (BrandId s : schools)
        for (MasteryTree t : trees)
            set.Add(ActiveMasteryEntry{ s, t, 0, { 0, 0, 0, 0 } });
    set.Add(ActiveMasteryEntry{ BrandId::Fire, MasteryTree::Support, 0, { 0, 0, 0, 0 } });

    EXPECT_EQ(set.Count(), ActiveMasterySet::Capacity);
    EXPECT_FALSE(set.Add(ActiveMasteryEntry{ BrandId::Fire, MasteryTree::Defensive, 2, { 0, 0, 0, 0 } }));
}

// The set type handles N entries (forward-compat), independent of cfg.MaxActive being 1 in v1.
TEST(MasteryActive, SetHoldsMultipleEntries)
{
    ActiveMasterySet set;
    EXPECT_GE(static_cast<size_t>(ActiveMasterySet::Capacity),
              static_cast<size_t>(BrandId::COUNT) * static_cast<size_t>(MasteryTree::COUNT) / 5);
    EXPECT_GT(static_cast<int>(ActiveMasterySet::Capacity), 1); // capacity is multi, not single
    EXPECT_TRUE(set.Add(ActiveMasteryEntry{ BrandId::Fire, MasteryTree::Offensive, 0, { 1, 1, 0, 0 } }));
    EXPECT_TRUE(set.Add(ActiveMasteryEntry{ BrandId::Frost, MasteryTree::Support, 0, { 0, 0, 2, 2 } }));
    EXPECT_EQ(set.Count(), 2u);
    EXPECT_NE(set.Find(BrandId::Fire, MasteryTree::Offensive), nullptr);
    EXPECT_EQ(set.Find(BrandId::Shadow, MasteryTree::Support), nullptr);
}

// Set validity iterates entries: invalid iff any entry invalid OR count exceeds cfg.MaxActive.
TEST(MasteryActive, SetValidityIteratesAndEnforcesMaxActive)
{
    FakeMasteryTreeConfig cfg;
    cfg.maxActive = 1;

    ActiveMasterySet set;
    set.Add(ActiveMasteryEntry{ BrandId::Fire, MasteryTree::Offensive, 0, { 5, 5, 0, 0 } });

    // dual-key lookup: account unlocked for Fire, char Fire level 10.
    auto unlocked = [](BrandId) { return true; };
    auto level = [](BrandId) -> uint8_t { return 10; };

    EXPECT_TRUE(IsActiveSetValid(set, unlocked, level, cfg));

    // add a second cell -> count 2 > MaxActive 1 -> invalid (v1 cap), even though each entry is fine.
    set.Add(ActiveMasteryEntry{ BrandId::Fire, MasteryTree::Defensive, 0, { 5, 5, 0, 0 } });
    EXPECT_FALSE(IsActiveSetValid(set, unlocked, level, cfg));

    // raise the cap -> valid again (forward-compat: same code path handles N).
    cfg.maxActive = 4;
    EXPECT_TRUE(IsActiveSetValid(set, unlocked, level, cfg));

    // break a key on one entry -> whole set invalid (iteration).
    auto noFireUnlock = [](BrandId b) { return b != BrandId::Fire; };
    EXPECT_FALSE(IsActiveSetValid(set, noFireUnlock, level, cfg));
}
