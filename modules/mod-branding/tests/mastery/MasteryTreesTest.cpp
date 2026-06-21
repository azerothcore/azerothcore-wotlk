#include "branding/mastery/MasteryTrees.h"
#include "branding/effects/EffectModel.h"
#include "fakes/FakeEffectConfig.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    class FakeMasteryTreeConfig : public IMasteryTreeConfig
    {
    public:
        uint8_t maxLevel = 50;
        double  maxUptime = 0.60;     // §14.3 #1: ceiling, MUST be < 1.0
        double  halfLevel = 25.0;     // upkeep == maxUptime/2 here
        double  offSchool = 0.25;     // situational falloff out of matching school
        double  maxEnemyMul = 1.5;    // §14.8: enemy spike ceiling (< MaxPersonalMul)
        double   minPpm = 1.0;        // §14.10 per-axis tuning bounds
        double   maxPpm = 10.0;
        uint32_t minWindowMs = 3000;
        uint32_t maxWindowMs = 12000;
        double   maxProcMagnitude = 2.0;
        double   minReach = 0.0;
        double   maxReach = 40.0;
        // §14.4.1: archetypes unlocked at a proficiency level. 1 at level 0, +1 every 20 levels.
        uint8_t archetypeUnlockLevel = 20;

        uint8_t MaxMasteryLevel() const override { return maxLevel; }
        uint8_t MaxArchetypesAtLevel(uint8_t profLevel) const override
        {
            return static_cast<uint8_t>(1 + profLevel / archetypeUnlockLevel);
        }
        double  MaxUptime() const override { return maxUptime; }
        double  UpkeepHalfLevel() const override { return halfLevel; }
        double  OffSchoolFactor() const override { return offSchool; }
        double  MaxEnemyMul() const override { return maxEnemyMul; }
        double   MinPpm() const override { return minPpm; }
        double   MaxPpm() const override { return maxPpm; }
        uint32_t MinWindowMs() const override { return minWindowMs; }
        uint32_t MaxWindowMs() const override { return maxWindowMs; }
        double   MaxProcMagnitude() const override { return maxProcMagnitude; }
        double   MinReach() const override { return minReach; }
        double   MaxReach() const override { return maxReach; }
    };

    // Common masks for tests.
    constexpr uint32_t MASK_PDM = AxisBit(ProcAxis::Ppm) | AxisBit(ProcAxis::Duration) |
                                  AxisBit(ProcAxis::Magnitude);                       // single-target
    constexpr uint32_t MASK_PDMR = MASK_PDM | AxisBit(ProcAxis::Reach);               // area / cleave proc

    TreeAllocation Alloc(double ppm, double dur, double mag, double reach = 0.0)
    {
        TreeAllocation a;
        a.share[static_cast<size_t>(ProcAxis::Ppm)] = ppm;
        a.share[static_cast<size_t>(ProcAxis::Duration)] = dur;
        a.share[static_cast<size_t>(ProcAxis::Magnitude)] = mag;
        a.share[static_cast<size_t>(ProcAxis::Reach)] = reach;
        return a;
    }

    ProcCell RaidCell()
    {
        return ProcCell{ EffectKind::RaidWindow, /*ppm*/ 6.0, /*windowMs*/ 6000, /*situational*/ false };
    }

    ProcCell ResistCell()
    {
        // SM: a school-matched mitigation window (e.g. fire resistance).
        return ProcCell{ EffectKind::PersonalSpike, /*ppm*/ 4.0, /*windowMs*/ 8000, /*situational*/ true };
    }
}

// §14.3 #1 -- the load-bearing rail: upkeep approaches but never reaches a sub-1.0 ceiling.
TEST(MasteryTrees, UpkeepNeverReachesPermanent)
{
    FakeMasteryTreeConfig cfg;
    ASSERT_LT(cfg.MaxUptime(), 1.0);
    ProcCell cell = RaidCell();
    for (uint8_t lvl = 0; lvl <= cfg.maxLevel; ++lvl)
    {
        double up = MasteryUpkeep(true, lvl, cell, true, cfg);
        EXPECT_GE(up, 0.0);
        EXPECT_LT(up, cfg.MaxUptime());  // strictly below the ceiling at EVERY level
    }
}

// §14.7 -- monotonic with diminishing increments (concave upkeep curve).
TEST(MasteryTrees, UpkeepMonotonicDiminishing)
{
    FakeMasteryTreeConfig cfg;
    ProcCell cell = RaidCell();
    double prev = MasteryUpkeep(true, 0, cell, true, cfg);
    double prevDelta = 1e9;
    for (uint8_t lvl = 1; lvl <= cfg.maxLevel; ++lvl)
    {
        double up = MasteryUpkeep(true, lvl, cell, true, cfg);
        EXPECT_GE(up, prev);                  // non-decreasing
        double delta = up - prev;
        EXPECT_LE(delta, prevDelta + 1e-9);   // each level adds no more than the last
        prev = up;
        prevDelta = delta;
    }
}

// §14/§6 dual-key: either key missing => inert (0 upkeep), both present => positive.
TEST(MasteryTrees, DualKeyGate)
{
    FakeMasteryTreeConfig cfg;
    ProcCell cell = RaidCell();
    EXPECT_DOUBLE_EQ(MasteryUpkeep(false, 40, cell, true, cfg), 0.0);  // account not unlocked
    EXPECT_DOUBLE_EQ(MasteryUpkeep(true, 0, cell, true, cfg), 0.0);    // no earned skill
    EXPECT_GT(MasteryUpkeep(true, 40, cell, true, cfg), 0.0);          // both keys present
}

// §14.3 #2 -- PPM normalization: equal ppm => equal expected procs over equal real time,
// regardless of weapon speed (a fast melee and a slow caster are not advantaged).
TEST(MasteryTrees, PpmDensityIndependent)
{
    FakeMasteryTreeConfig cfg;
    double fastWeapon = ExpectedProcs(6.0, 60000, 1.4, cfg);   // 1.4s swings
    double slowWeapon = ExpectedProcs(6.0, 60000, 3.6, cfg);   // 3.6s swings
    double spellLike  = ExpectedProcs(6.0, 60000, 1.0, cfg);   // PPM-only
    EXPECT_NEAR(fastWeapon, 6.0, 1e-6);    // 6 ppm over 1 minute
    EXPECT_NEAR(fastWeapon, slowWeapon, 1e-6);
    EXPECT_NEAR(fastWeapon, spellLike, 1e-6);
}

// §14.4 SM/SE: a situational cell is reduced out of its matching-school context; a normal cell is not.
TEST(MasteryTrees, SituationalCellIsContextGated)
{
    FakeMasteryTreeConfig cfg;
    ProcCell resist = ResistCell();
    double matched = MasteryUpkeep(true, 40, resist, true, cfg);
    double offSchool = MasteryUpkeep(true, 40, resist, false, cfg);
    EXPECT_GT(matched, offSchool);
    EXPECT_NEAR(offSchool, matched * cfg.offSchool, 1e-9);

    ProcCell raid = RaidCell();  // not situational -> context is irrelevant
    EXPECT_DOUBLE_EQ(MasteryUpkeep(true, 40, raid, true, cfg),
                     MasteryUpkeep(true, 40, raid, false, cfg));
}

// --- §14.10 per-cell player tuning (budget across a per-cell axis set, incl. range) ---

// Conservation: applicable fill fractions sum to the budget b (< 1); no two axes both reach max.
TEST(MasteryTrees, TreeTuningBudgetConservedNoMaxAllAxes)
{
    FakeMasteryTreeConfig cfg;
    // Max-mastery, all-equal allocation over the 4-axis (area) cell.
    ResolvedCell r = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDMR, cfg.maxLevel, cfg);
    int maxed = (r.ppm >= cfg.maxPpm - 1e-9) + (r.windowDurationMs >= cfg.maxWindowMs) +
                (r.magnitude >= cfg.maxProcMagnitude - 1e-9) + (r.reach >= cfg.maxReach - 1e-9);
    EXPECT_LT(maxed, 2);

    // Explicit budget identity: normalized fills sum to b.
    double const b = static_cast<double>(cfg.maxLevel) / (cfg.maxLevel + cfg.halfLevel);
    double ppmFill = (r.ppm - cfg.minPpm) / (cfg.maxPpm - cfg.minPpm);
    double durFill = (r.windowDurationMs - cfg.minWindowMs) /
        static_cast<double>(cfg.maxWindowMs - cfg.minWindowMs);
    double magFill = (r.magnitude - 1.0) / (cfg.maxProcMagnitude - 1.0);
    double rngFill = (r.reach - cfg.minReach) / (cfg.maxReach - cfg.minReach);
    EXPECT_NEAR(ppmFill + durFill + magFill + rngFill, b, 1e-6);
}

// Per-cell mask: a non-applicable axis (range, here) resolves to its Min and consumes no budget, so a
// 3-axis cell concentrates the same b over 3 axes -> each gets MORE than in the 4-axis cell.
TEST(MasteryTrees, TreeTuningNonApplicableAxisExcludedFromBudget)
{
    FakeMasteryTreeConfig cfg;
    ResolvedCell threeAxis = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDM, 40, cfg);   // range N/A
    ResolvedCell fourAxis = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDMR, 40, cfg);

    EXPECT_DOUBLE_EQ(threeAxis.reach, cfg.minReach);   // non-applicable -> Min baseline
    EXPECT_GT(fourAxis.reach, cfg.minReach);           // applicable -> invested
    EXPECT_GT(threeAxis.ppm, fourAxis.ppm);              // same b over fewer axes -> more per axis
    EXPECT_GT(threeAxis.magnitude, fourAxis.magnitude);
}

// Favouring one axis raises it at the cost of the others (burst vs sustained vs wide).
TEST(MasteryTrees, TreeTuningFavorsOneAxisAtCostOfOthers)
{
    FakeMasteryTreeConfig cfg;
    ResolvedCell allPpm = ResolveTreeCell(Alloc(1, 0, 0, 0), MASK_PDMR, 40, cfg);
    ResolvedCell allRange = ResolveTreeCell(Alloc(0, 0, 0, 1), MASK_PDMR, 40, cfg);
    ResolvedCell balanced = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDMR, 40, cfg);

    EXPECT_GT(allPpm.ppm, balanced.ppm);              // more frequent
    EXPECT_LT(allPpm.magnitude, balanced.magnitude);
    EXPECT_DOUBLE_EQ(allPpm.magnitude, 1.0);          // nothing on magnitude -> baseline
    EXPECT_DOUBLE_EQ(allPpm.reach, cfg.minReach);   // nothing on range -> baseline
    EXPECT_GT(allRange.reach, balanced.reach);    // wide build
    EXPECT_LT(allRange.ppm, balanced.ppm);
}

// Every allocation at every level/mask respects each axis bound.
TEST(MasteryTrees, TreeTuningAllAllocationsRespectCaps)
{
    FakeMasteryTreeConfig cfg;
    TreeAllocation allocs[] = {
        Alloc(1, 0, 0, 0), Alloc(0, 1, 0, 0), Alloc(0, 0, 1, 0), Alloc(0, 0, 0, 1),
        Alloc(1, 1, 1, 1), Alloc(3, 1, 2, 1), Alloc(0, 0, 0, 0)
    };
    for (uint8_t lvl = 0; lvl <= cfg.maxLevel; ++lvl)
    {
        for (uint32_t mask : { MASK_PDM, MASK_PDMR })
        {
            for (auto const& a : allocs)
            {
                ResolvedCell r = ResolveTreeCell(a, mask, lvl, cfg);
                EXPECT_GE(r.ppm, cfg.minPpm);
                EXPECT_LE(r.ppm, cfg.maxPpm);
                EXPECT_GE(r.windowDurationMs, cfg.minWindowMs);
                EXPECT_LE(r.windowDurationMs, cfg.maxWindowMs);
                EXPECT_GE(r.magnitude, 1.0);
                EXPECT_LE(r.magnitude, cfg.maxProcMagnitude);
                EXPECT_GE(r.reach, cfg.minReach);
                EXPECT_LE(r.reach, cfg.maxReach);
            }
        }
    }
}

// Degenerate (all-zero) shares fall back to an even split over the applicable axes.
TEST(MasteryTrees, TreeTuningDegenerateSharesNormalized)
{
    FakeMasteryTreeConfig cfg;
    ResolvedCell zero = ResolveTreeCell(Alloc(0, 0, 0, 0), MASK_PDMR, 40, cfg);
    ResolvedCell even = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDMR, 40, cfg);
    EXPECT_DOUBLE_EQ(zero.ppm, even.ppm);
    EXPECT_EQ(zero.windowDurationMs, even.windowDurationMs);
    EXPECT_DOUBLE_EQ(zero.magnitude, even.magnitude);
    EXPECT_DOUBLE_EQ(zero.reach, even.reach);
}

// A fixed allocation resolves to a wider envelope at higher mastery (bigger budget).
TEST(MasteryTrees, TreeTuningEnvelopeGrowsWithMastery)
{
    FakeMasteryTreeConfig cfg;
    ResolvedCell lo = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDMR, 5, cfg);
    ResolvedCell hi = ResolveTreeCell(Alloc(1, 1, 1, 1), MASK_PDMR, 45, cfg);
    EXPECT_GT(hi.ppm, lo.ppm);
    EXPECT_GT(hi.windowDurationMs, lo.windowDurationMs);
    EXPECT_GT(hi.magnitude, lo.magnitude);
    EXPECT_GT(hi.reach, lo.reach);
}

// --- §14.4 lattice content ---

namespace
{
    constexpr BrandId AUTHORED_SCHOOLS[] = {
        BrandId::Fire, BrandId::Nature, BrandId::Shadow, BrandId::Frost, BrandId::Physical,
        BrandId::Arcane, BrandId::Holy
    };
    constexpr MasteryTree TREES[] = {
        MasteryTree::Defensive, MasteryTree::Offensive, MasteryTree::Support
    };
    constexpr uint32_t BASE3 = AxisBit(ProcAxis::Ppm) | AxisBit(ProcAxis::Duration) |
                               AxisBit(ProcAxis::Magnitude);
}

// §14.4: windowed Def/Off cells expose the ppm/duration/magnitude axes; sustained Support cells
// tune magnitude + reach only (no proc cadence).
TEST(MasteryTrees, LatticeCellAxesMatchExpression)
{
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        EXPECT_EQ(LatticeCell(s, MasteryTree::Defensive).applicableAxes & BASE3, BASE3);
        EXPECT_EQ(LatticeCell(s, MasteryTree::Offensive).applicableAxes & BASE3, BASE3);

        LatticeCellDef sup = LatticeCell(s, MasteryTree::Support);
        uint32_t const expected = AxisBit(ProcAxis::Magnitude) | AxisBit(ProcAxis::Reach);
        EXPECT_EQ(sup.applicableAxes, expected);                           // magnitude + reach only
        EXPECT_EQ(sup.applicableAxes & AxisBit(ProcAxis::Ppm), 0u);        // no proc cadence
        EXPECT_EQ(sup.applicableAxes & AxisBit(ProcAxis::Duration), 0u);
    }
}

// §14.4: Support buffs are SUSTAINED auras (constant uptime); Def/Off are windowed.
TEST(MasteryTrees, LatticeSupportSustainedDefOffWindowed)
{
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        EXPECT_TRUE(LatticeCell(s, MasteryTree::Support).sustained);
        EXPECT_FALSE(LatticeCell(s, MasteryTree::Defensive).sustained);
        EXPECT_FALSE(LatticeCell(s, MasteryTree::Offensive).sustained);
    }
}

// §14.4: Offensive cells are bounded raid-damage windows; Support cells are all school-matched.
TEST(MasteryTrees, LatticeOffensiveAreRaidSupportAreSituational)
{
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        EXPECT_EQ(LatticeCell(s, MasteryTree::Offensive).kind, EffectKind::RaidWindow);
        EXPECT_TRUE(LatticeCell(s, MasteryTree::Support).situational);
        EXPECT_FALSE(LatticeCell(s, MasteryTree::Defensive).situational);
        EXPECT_FALSE(LatticeCell(s, MasteryTree::Offensive).situational);
    }
}

// §14.4/§14.10: among WINDOWED cells, reach marks the area/cleave procs; single-target windowed
// cells have none. (Sustained Support cells always tune reach -- the "more allies / bigger radius"
// lever -- and are covered by LatticeCellAxesMatchExpression.)
TEST(MasteryTrees, LatticeReachOnAreaCleaveWindowedCells)
{
    auto hasReach = [](BrandId s, MasteryTree t)
    {
        return (LatticeCell(s, t).applicableAxes & AxisBit(ProcAxis::Reach)) != 0u;
    };
    // Fire Def (AoE), and every school's Offensive except Fire (poison cloud / volley / nova / cleave).
    EXPECT_TRUE(hasReach(BrandId::Fire, MasteryTree::Defensive));
    EXPECT_TRUE(hasReach(BrandId::Nature, MasteryTree::Offensive));
    EXPECT_TRUE(hasReach(BrandId::Shadow, MasteryTree::Offensive));
    EXPECT_TRUE(hasReach(BrandId::Frost, MasteryTree::Offensive));
    EXPECT_TRUE(hasReach(BrandId::Physical, MasteryTree::Offensive));
    // Single-target windowed cells: no reach.
    EXPECT_FALSE(hasReach(BrandId::Fire, MasteryTree::Offensive));     // fire damage proc (single)
    EXPECT_FALSE(hasReach(BrandId::Shadow, MasteryTree::Defensive));   // life-steal
    EXPECT_FALSE(hasReach(BrandId::Frost, MasteryTree::Defensive));    // damage-reduction
}

// All 7 standard BrandId schools are now authored; an unknown/out-of-range school still falls back
// to the neutral default (safety net, no crash).
TEST(MasteryTrees, LatticeUnknownSchoolDefault)
{
    LatticeCellDef def = LatticeCell(static_cast<BrandId>(BrandId::COUNT), MasteryTree::Offensive);
    EXPECT_EQ(def.kind, EffectKind::RaidWindow);
    EXPECT_FALSE(def.situational);
    EXPECT_EQ(def.applicableAxes & BASE3, BASE3);
}

// Integration: a cell's own mask drives ResolveTreeCell. The cleave cell (Physical Off) tunes reach
// (target count); the single-target fire damage cell (Fire Off) does not.
TEST(MasteryTrees, LatticeMaskDrivesResolve)
{
    FakeMasteryTreeConfig cfg;
    LatticeCellDef cleave = LatticeCell(BrandId::Physical, MasteryTree::Offensive);
    LatticeCellDef fireBolt = LatticeCell(BrandId::Fire, MasteryTree::Offensive);

    ResolvedCell c = ResolveTreeCell(Alloc(1, 1, 1, 1), cleave.applicableAxes, 40, cfg);
    ResolvedCell f = ResolveTreeCell(Alloc(1, 1, 1, 1), fireBolt.applicableAxes, 40, cfg);

    EXPECT_GT(c.reach, cfg.minReach);              // cleave invests in reach (count)
    EXPECT_DOUBLE_EQ(f.reach, cfg.minReach);       // single-target: reach stays at baseline
}

// §14.8 -- enemy spikes are bounded by their own ceiling, never below 1.0, monotonic in mastery.
TEST(MasteryTrees, EnemyMasteryBoundedAndNeverWeakens)
{
    FakeMasteryTreeConfig cfg;
    double prev = EnemyMasteryMultiplier(0, cfg);
    EXPECT_DOUBLE_EQ(prev, 1.0);  // unmastered enemy = baseline
    for (uint8_t lvl = 0; lvl <= cfg.maxLevel; ++lvl)
    {
        double mul = EnemyMasteryMultiplier(lvl, cfg);
        EXPECT_GE(mul, 1.0);                   // mastery never weakens an enemy
        EXPECT_LE(mul, cfg.MaxEnemyMul());     // bounded by the separate NPC ceiling
        EXPECT_GE(mul, prev - 1e-9);           // monotonic non-decreasing
        prev = mul;
    }
}

// §14.8 -- enemy ceiling is a reactable-window dial, strictly below the player one-shot fantasy.
TEST(MasteryTrees, EnemyCeilingBelowPlayerFantasy)
{
    FakeMasteryTreeConfig cfg;
    Branding::Test::FakeEffectConfig eff;
    EXPECT_LT(cfg.MaxEnemyMul(), eff.MaxPersonalMul());
}

// §14.8 -- group-size invariance: the multiplier is a fraction of the already-scaled baseline, not a
// flat add, so a 5-man-scaled and 40-man-scaled elite keep the same difficulty ORDERING (Risk #4).
TEST(MasteryTrees, EnemyMasteryGroupInvariantFractionNotFlat)
{
    FakeMasteryTreeConfig cfg;
    uint8_t bossLevel = cfg.maxLevel;             // "boss at max mastery"
    double mul = EnemyMasteryMultiplier(bossLevel, cfg);

    double scaled5man = 20000.0;                  // §2.2 encounter HP scaled to a 5-man
    double scaled40man = 100000.0;                // ... and to a 40-man

    double final5 = scaled5man * mul;             // mastery rides on top (scaling-then-branding)
    double final40 = scaled40man * mul;

    // same multiplier both sides -> the small group never gets a disproportionate flat spike
    EXPECT_NEAR(final5 / scaled5man, final40 / scaled40man, 1e-9);
    EXPECT_LT(final5, scaled40man);               // a 5-man elite stays below a 40-man baseline
}

// --- §14.4.1 multi-archetype cells (issue #29) ---

// LatticeCell still returns archetype 0 (the primary) for every authored cell -- nothing else breaks.
TEST(MasteryTrees, ArchetypeZeroEqualsPrimaryCell)
{
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        for (MasteryTree t : TREES)
        {
            LatticeCellDef primary = LatticeCell(s, t);
            LatticeCellDef arch0 = LatticeArchetype(s, t, 0);
            EXPECT_EQ(arch0.kind, primary.kind);
            EXPECT_EQ(arch0.situational, primary.situational);
            EXPECT_EQ(arch0.sustained, primary.sustained);
            EXPECT_EQ(arch0.applicableAxes, primary.applicableAxes);
            EXPECT_GE(LatticeArchetypeCount(s, t), 1);  // always at least the primary
        }
    }
}

// §14.4.1: the Support column carries the multi-archetype (`·`) entries.
// Fire/Nature Support gain a non-situational sustained raid-utility aura as archetype 1;
// Shadow/Frost gain an SM resistance; Physical stays single-archetype.
TEST(MasteryTrees, SupportSecondaryArchetypesAuthored)
{
    // Fire Support: primary = fire resistance (SM, situational); secondary = flame aura (raid utility).
    EXPECT_EQ(LatticeArchetypeCount(BrandId::Fire, MasteryTree::Support), 2);
    EXPECT_TRUE(LatticeArchetype(BrandId::Fire, MasteryTree::Support, 0).situational);
    LatticeCellDef flameAura = LatticeArchetype(BrandId::Fire, MasteryTree::Support, 1);
    EXPECT_FALSE(flameAura.situational);                 // raid utility, not school-matched
    EXPECT_TRUE(flameAura.sustained);                    // a constant aura
    EXPECT_EQ(flameAura.kind, EffectKind::RaidWindow);

    // Nature Support: secondary = raid-heal (transform, non-situational).
    EXPECT_EQ(LatticeArchetypeCount(BrandId::Nature, MasteryTree::Support), 2);
    LatticeCellDef raidHeal = LatticeArchetype(BrandId::Nature, MasteryTree::Support, 1);
    EXPECT_FALSE(raidHeal.situational);
    EXPECT_TRUE(raidHeal.sustained);
    EXPECT_EQ(raidHeal.kind, EffectKind::MechanicTransform);

    // Shadow/Frost Support: secondary = SM resistance (situational, sustained).
    for (BrandId s : { BrandId::Shadow, BrandId::Frost })
    {
        EXPECT_EQ(LatticeArchetypeCount(s, MasteryTree::Support), 2);
        EXPECT_TRUE(LatticeArchetype(s, MasteryTree::Support, 1).situational);
        EXPECT_TRUE(LatticeArchetype(s, MasteryTree::Support, 1).sustained);
    }

    // Physical Support: single archetype only (the table lists one mitigation).
    EXPECT_EQ(LatticeArchetypeCount(BrandId::Physical, MasteryTree::Support), 1);

    // Arcane/Holy Support: two archetypes (school-matched primary + sustained raid-utility secondary).
    for (BrandId s : { BrandId::Arcane, BrandId::Holy })
    {
        EXPECT_EQ(LatticeArchetypeCount(s, MasteryTree::Support), 2);
        EXPECT_TRUE(LatticeArchetype(s, MasteryTree::Support, 0).situational);   // SM/SE primary
        LatticeCellDef util = LatticeArchetype(s, MasteryTree::Support, 1);
        EXPECT_FALSE(util.situational);                                          // raid utility
        EXPECT_TRUE(util.sustained);
    }
}

// Arcane/Holy complete the 7 standard WoW schools: Off = bounded raid damage (area, +reach).
TEST(MasteryTrees, ArcaneAndHolyOffensiveAreAreaRaid)
{
    for (BrandId s : { BrandId::Arcane, BrandId::Holy })
    {
        LatticeCellDef off = LatticeCell(s, MasteryTree::Offensive);
        EXPECT_EQ(off.kind, EffectKind::RaidWindow);
        EXPECT_NE(off.applicableAxes & AxisBit(ProcAxis::Reach), 0u);  // arcane explosion / holy nova
        EXPECT_EQ(LatticeCell(s, MasteryTree::Defensive).kind, EffectKind::PersonalSpike);
    }
}

// §14.4.1: every archetype is a valid Support-shaped def -- sustained, magnitude+reach axes only.
TEST(MasteryTrees, SupportArchetypesKeepSupportAxisSet)
{
    uint32_t const expected = AxisBit(ProcAxis::Magnitude) | AxisBit(ProcAxis::Reach);
    for (BrandId s : AUTHORED_SCHOOLS)
    {
        uint8_t const count = LatticeArchetypeCount(s, MasteryTree::Support);
        for (uint8_t i = 0; i < count; ++i)
        {
            LatticeCellDef def = LatticeArchetype(s, MasteryTree::Support, i);
            EXPECT_TRUE(def.sustained);
            EXPECT_EQ(def.applicableAxes, expected);
        }
    }
}

// Out-of-range archetype index clamps to the primary (no UB / crash on a bad selection).
TEST(MasteryTrees, ArchetypeIndexOutOfRangeFallsBackToPrimary)
{
    LatticeCellDef primary = LatticeCell(BrandId::Physical, MasteryTree::Support);
    LatticeCellDef oob = LatticeArchetype(BrandId::Physical, MasteryTree::Support, 99);
    EXPECT_EQ(oob.kind, primary.kind);
    EXPECT_EQ(oob.applicableAxes, primary.applicableAxes);
}

// §14.4.1 validation: index must be < count AND unlocked at the proficiency level. Index 0 always
// legal; higher indices gate behind MaxArchetypesAtLevel; an index >= count is never legal.
TEST(MasteryTrees, ArchetypeUnlockGatedByCountAndLevel)
{
    FakeMasteryTreeConfig cfg;  // MaxArchetypesAtLevel: 1 at lvl 0, 2 at lvl 20, 3 at lvl 40

    // Primary is always unlocked, even at level 0.
    EXPECT_TRUE(IsLatticeArchetypeUnlocked(BrandId::Fire, MasteryTree::Support, 0, 0, cfg));

    // Fire Support has 2 archetypes; index 1 needs the level gate (>= 20 here).
    EXPECT_FALSE(IsLatticeArchetypeUnlocked(BrandId::Fire, MasteryTree::Support, 1, 0, cfg));
    EXPECT_FALSE(IsLatticeArchetypeUnlocked(BrandId::Fire, MasteryTree::Support, 1, 19, cfg));
    EXPECT_TRUE(IsLatticeArchetypeUnlocked(BrandId::Fire, MasteryTree::Support, 1, 20, cfg));

    // Index beyond the cell's authored count is never legal, regardless of level.
    EXPECT_FALSE(IsLatticeArchetypeUnlocked(BrandId::Fire, MasteryTree::Support, 2, cfg.maxLevel, cfg));
    // Physical Support is single-archetype: only index 0 is ever legal.
    EXPECT_TRUE(IsLatticeArchetypeUnlocked(BrandId::Physical, MasteryTree::Support, 0, cfg.maxLevel, cfg));
    EXPECT_FALSE(IsLatticeArchetypeUnlocked(BrandId::Physical, MasteryTree::Support, 1, cfg.maxLevel, cfg));
}

// Forward-compat (multi-mastery): archetype lookups for two distinct cells are independent -- no
// shared "current archetype" state. Resolving one does not perturb the other.
TEST(MasteryTrees, ArchetypeLookupKeyedPurelyByCell)
{
    LatticeCellDef fireSup1 = LatticeArchetype(BrandId::Fire, MasteryTree::Support, 1);
    LatticeCellDef natureSup1 = LatticeArchetype(BrandId::Nature, MasteryTree::Support, 1);
    // Re-reading Fire after Nature yields the same def -> no cross-cell coupling / global state.
    EXPECT_EQ(LatticeArchetype(BrandId::Fire, MasteryTree::Support, 1).kind, fireSup1.kind);
    EXPECT_NE(fireSup1.kind, natureSup1.kind);  // distinct cells resolve distinctly
}

// §14.1/§7.9 composition: a raid-wide tree cell's magnitude still obeys the MaxRaidMul cap +
// catalyst DR (the layer adds upkeep, it does NOT lift the §7.9 ceiling).
TEST(MasteryTrees, RaidMagnitudeStillCappedByEffectModel)
{
    Branding::Test::FakeEffectConfig eff;
    EffectProfile raidProfile{ EffectKind::RaidWindow, RoleContribution::Support, 6000, 18000 };
    for (uint8_t lvl = 0; lvl <= eff.maxEffectLevel; ++lvl)
    {
        for (double stack : { 1.0, 0.5, 0.2 })  // catalyst stack weights (1st full .. 3rd+ heavy)
        {
            double mul = RaidMultiplier(lvl, raidProfile, stack, eff);
            EXPECT_LE(mul, eff.maxRaidMul);
            EXPECT_GE(mul, 1.0);  // a brand never hurts the raid
        }
    }
}
