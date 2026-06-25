#include "branding/mastery/MasteryContent.h"
#include "branding/mastery/MasteryTrees.h"
#include "branding/common/Brand.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    // Minimal §14.10 envelope fake -- the whole-lattice defaults the per-cell content narrows.
    class FakeTreeConfig : public IMasteryTreeConfig
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
        uint8_t  archetypeUnlockLevel = 20;

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
        uint8_t  MaxArchetypesAtLevel(uint8_t level) const override
        {
            return static_cast<uint8_t>(1 + level / archetypeUnlockLevel);
        }
    };

    constexpr BrandId AUTHORED_SCHOOLS[] = {
        BrandId::Fire, BrandId::Frost, BrandId::Nature, BrandId::Shadow,
        BrandId::Arcane, BrandId::Holy, BrandId::Physical
    };
    constexpr MasteryTree TREES[] = {
        MasteryTree::Defensive, MasteryTree::Offensive, MasteryTree::Support
    };

    TreeAllocation OnAxis(ProcAxis a)
    {
        TreeAllocation alloc;
        for (auto& s : alloc.share)
            s = 0.0;
        alloc.share[static_cast<size_t>(a)] = 1.0;
        return alloc;
    }
}

// --- #30 deliverable 1: every authored cell maps to a real proc (spell id). ---

TEST(MasteryContent, EveryAuthoredArchetypeMapsToARealSpell)
{
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        for (MasteryTree t : TREES)
        {
            uint8_t const count = LatticeContentCount(s, t);
            ASSERT_GE(count, 1);
            for (uint8_t i = 0; i < count; ++i)
            {
                EXPECT_NE(LatticeSpellId(s, t, i), 0u)
                    << "school=" << static_cast<int>(s) << " tree=" << static_cast<int>(t)
                    << " archetype=" << static_cast<int>(i);
            }
        }
    }
}

// The content table carries the SAME archetype count as the lattice shape table (shape <-> content).
TEST(MasteryContent, ContentCountMatchesLatticeShape)
{
    for (BrandId s : AUTHORED_SCHOOLS)
        for (MasteryTree t : TREES)
            EXPECT_EQ(LatticeContentCount(s, t), LatticeArchetypeCount(s, t));
}

// A cell exposes the §14.10 reach axis IFF its content names a reach mode (single-target -> None).
TEST(MasteryContent, ReachModePresentExactlyWhenReachAxisApplicable)
{
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        for (MasteryTree t : TREES)
        {
            uint8_t const count = LatticeContentCount(s, t);
            for (uint8_t i = 0; i < count; ++i)
            {
                bool const axisHasReach =
                    (LatticeArchetype(s, t, i).applicableAxes & AxisBit(ProcAxis::Reach)) != 0u;
                bool const contentHasReach = LatticeContent(s, t, i).envelope.reachMode != ReachMode::None;
                EXPECT_EQ(axisHasReach, contentHasReach)
                    << "school=" << static_cast<int>(s) << " tree=" << static_cast<int>(t)
                    << " archetype=" << static_cast<int>(i);
            }
        }
    }
}

// --- #30 deliverable 2: per-cell magnitude ceilings (sustained raid cells conservative). ---

// Every non-situational sustained Support cell (the raid-utility auras: flame aura, raid-heal,
// intellect/mana aura, circle of healing) carries a conservative ceiling BELOW the global cap.
TEST(MasteryContent, SustainedRaidUtilityCellsCarryConservativeCeiling)
{
    FakeTreeConfig cfg;
    bool sawOne = false;
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        uint8_t const count = LatticeContentCount(s, MasteryTree::Support);
        for (uint8_t i = 0; i < count; ++i)
        {
            LatticeCellDef const def = LatticeArchetype(s, MasteryTree::Support, i);
            if (!(def.sustained && !def.situational))   // raid-utility = sustained + non-situational
                continue;
            sawOne = true;
            double const ceiling = LatticeContent(s, MasteryTree::Support, i).envelope.maxMagnitude;
            EXPECT_GT(ceiling, 0.0);                       // an explicit per-cell ceiling is set
            EXPECT_LT(ceiling, cfg.MaxProcMagnitude());    // ... and it is conservative (below global)
        }
    }
    EXPECT_TRUE(sawOne);   // Fire/Nature/Arcane/Holy each contribute one
}

// EffectiveEnvelope intersects per-cell caps with the global envelope -- it never widens.
TEST(MasteryContent, EffectiveEnvelopeNarrowsNeverWidens)
{
    FakeTreeConfig cfg;

    // A windowed Def/Off cell inherits the global magnitude cap (no per-cell ceiling authored).
    CellEnvelope const fireOff = LatticeContent(BrandId::Fire, MasteryTree::Offensive, 0).envelope;
    EXPECT_DOUBLE_EQ(EffectiveEnvelope(fireOff, cfg).maxMagnitude, cfg.MaxProcMagnitude());

    // A sustained raid-utility cell narrows it below the global cap.
    CellEnvelope const flameAura = LatticeContent(BrandId::Fire, MasteryTree::Support, 1).envelope;
    EXPECT_LT(EffectiveEnvelope(flameAura, cfg).maxMagnitude, cfg.MaxProcMagnitude());
}

// --- #30 deliverable 3: reach rendering -- radius (yards) vs cleave target count. ---

// The cleave cell's reach is an integer TARGET COUNT, with a small per-cell ceiling -- NOT the global
// 40-yard radius default (which is meaningless for a count).
TEST(MasteryContent, CleaveReachIsTargetCountNotGlobalRadius)
{
    FakeTreeConfig cfg;
    CellEnvelope const cleave = LatticeContent(BrandId::Physical, MasteryTree::Offensive, 0).envelope;
    EXPECT_EQ(cleave.reachMode, ReachMode::TargetCount);
    EXPECT_GE(cleave.minReach, 2.0);                 // base hits at least 2 targets
    EXPECT_LE(cleave.maxReach, 10.0);                // a controlled count ceiling, not a radius
    EXPECT_LT(cleave.maxReach, cfg.MaxReach());      // tighter than the global default

    // The per-cell count ceiling replaces the global reach bound in the resolved envelope.
    EXPECT_DOUBLE_EQ(EffectiveEnvelope(cleave, cfg).maxReach, cleave.maxReach);
}

// Genuine field-shaped procs render as a radius.
TEST(MasteryContent, AreaProcsRenderAsRadius)
{
    EXPECT_EQ(LatticeContent(BrandId::Fire, MasteryTree::Defensive, 0).envelope.reachMode,
              ReachMode::RadiusYards);   // fire AoE
    for (BrandId s : { BrandId::Nature, BrandId::Frost, BrandId::Shadow, BrandId::Arcane, BrandId::Holy })
        EXPECT_EQ(LatticeContent(s, MasteryTree::Offensive, 0).envelope.reachMode, ReachMode::RadiusYards);
}

// Single-target windowed cells render no reach.
TEST(MasteryContent, SingleTargetWindowedHaveNoReach)
{
    EXPECT_EQ(LatticeContent(BrandId::Fire, MasteryTree::Offensive, 0).envelope.reachMode, ReachMode::None);
    EXPECT_EQ(LatticeContent(BrandId::Shadow, MasteryTree::Defensive, 0).envelope.reachMode, ReachMode::None);
    EXPECT_EQ(LatticeContent(BrandId::Frost, MasteryTree::Defensive, 0).envelope.reachMode, ReachMode::None);
}

// --- resolve path honours the per-cell envelope ---

// Maxing the magnitude axis on a sustained raid-utility cell resolves BELOW the global cap (its
// per-cell ceiling binds), whereas the same allocation against the global envelope would not.
TEST(MasteryContent, ResolveContentCellRespectsMagnitudeCeiling)
{
    FakeTreeConfig cfg;
    uint32_t const supAxes = AxisBit(ProcAxis::Magnitude) | AxisBit(ProcAxis::Reach);
    CellEnvelope const flameAura = LatticeContent(BrandId::Fire, MasteryTree::Support, 1).envelope;

    ResolvedCell perCell = ResolveContentCell(OnAxis(ProcAxis::Magnitude), supAxes, flameAura, cfg.maxLevel, cfg);
    ResolvedCell global = ResolveTreeCell(OnAxis(ProcAxis::Magnitude), supAxes, cfg.maxLevel, cfg);

    EXPECT_LE(perCell.magnitude, flameAura.maxMagnitude + 1e-9);
    EXPECT_LT(perCell.magnitude, global.magnitude);   // the ceiling actually bites
    EXPECT_GE(perCell.magnitude, 1.0);                // floor preserved
}

// Maxing the cleave reach axis resolves within the integer count ceiling, never the 40-yard global.
TEST(MasteryContent, ResolveContentCellRespectsCleaveCount)
{
    FakeTreeConfig cfg;
    uint32_t const cleaveAxes = AxisBit(ProcAxis::Ppm) | AxisBit(ProcAxis::Duration) |
                                AxisBit(ProcAxis::Magnitude) | AxisBit(ProcAxis::Reach);
    CellEnvelope const cleave = LatticeContent(BrandId::Physical, MasteryTree::Offensive, 0).envelope;

    ResolvedCell r = ResolveContentCell(OnAxis(ProcAxis::Reach), cleaveAxes, cleave, cfg.maxLevel, cfg);
    EXPECT_GE(r.reach, cleave.minReach);
    EXPECT_LE(r.reach, cleave.maxReach + 1e-9);
    EXPECT_LT(r.reach, cfg.MaxReach());   // well under the global radius default
}

// --- safety nets ---

// An unauthored (exotic) school has no concrete content -> neutral default (spell id 0).
TEST(MasteryContent, UnauthoredSchoolHasNeutralContent)
{
    EXPECT_EQ(LatticeSpellId(BrandId::Wind, MasteryTree::Offensive, 0), 0u);
    EXPECT_EQ(LatticeContent(BrandId::Wind, MasteryTree::Offensive, 0).envelope.reachMode, ReachMode::None);
}

// Out-of-range archetype index clamps to the primary (no UB / read past the count).
TEST(MasteryContent, OutOfRangeArchetypeClampsToPrimary)
{
    LatticeCellContent primary = LatticeContent(BrandId::Physical, MasteryTree::Support, 0);
    LatticeCellContent oob = LatticeContent(BrandId::Physical, MasteryTree::Support, 99);
    EXPECT_EQ(oob.spellId, primary.spellId);
}
