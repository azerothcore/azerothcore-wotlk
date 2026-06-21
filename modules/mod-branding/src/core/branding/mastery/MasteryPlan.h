#ifndef MOD_BRANDING_CORE_MASTERY_MASTERYPLAN_H
#define MOD_BRANDING_CORE_MASTERY_MASTERYPLAN_H

#include "branding/catalyst/CatalystStacking.h"
#include "branding/common/Brand.h"
#include "branding/effects/EffectConfig.h"
#include "branding/mastery/MasteryActive.h"
#include "branding/mastery/MasteryTrees.h"
#include <array>
#include <cstddef>
#include <cstdint>

// Pure core (§14.12, issue #27). No AzerothCore includes anywhere under core/.
//
// The combat adapter does not decide magnitudes in the worldserver -- it builds this deterministic
// application plan from the live state it can read, then mechanically applies each ResolvedMasteryEffect.
// This ties the prior slices together (PointsToAllocation -> ResolveTreeCell, the §14.4 lattice defs,
// RaidMultiplier/PersonalMultiplier, CatalystRankInBucket) with no AzerothCore types in play.
namespace Branding
{
    // §14.12: per-school dual-key + earned level for the planning character, as a plain injected POD
    // (no AC types). The adapter fills it from ProficiencyMgr (BrandLevel + IsBrandKnown). Indexed by
    // BrandId ordinal; an out-of-range school reads as level 0 / locked (anti-P2W default-deny).
    struct MasterySchoolState
    {
        uint8_t level[static_cast<size_t>(BrandId::COUNT)] = {};      // §14.11 EARNED layer per school
        bool    unlocked[static_cast<size_t>(BrandId::COUNT)] = {};   // account Brand Knowledge per school
    };

    // §14.12: one resolved active cell -- everything the adapter needs to apply ONE mastery effect.
    struct ResolvedMasteryEffect
    {
        BrandId        school = BrandId::Fire;
        MasteryTree    tree = MasteryTree::Defensive;
        uint8_t        archetype = 0;            // §7.9 selected proc archetype (index into the cell)
        uint8_t        masteryLevel = 0;         // earned level for this school (the resolve envelope)
        LatticeCellDef def{};                    // §14.4 kind/situational/sustained/axes (the archetype)
        ResolvedCell   resolved{};               // §14.10 ppm/duration/magnitude/reach from the point-buy
        double         magnitude = 1.0;          // BOUND magnitude actually applied (raid or personal)
        bool           raidWide = false;         // true => RaidMultiplier path, false => PersonalMultiplier
        uint8_t        catalystRank = 1;         // §14.9 rank in the (school,tree) bucket (1 = full, no DR)
        double         uptimeFraction = 1.0;     // sustained => 1.0; windowed => window/(window+cd) < 1.0
    };

    // §14.12: the plan -- a fixed-cap list (NO <vector> in core), one entry per VALID active cell.
    struct MasteryPlan
    {
        static constexpr size_t Capacity = ActiveMasterySet::Capacity;

        std::array<ResolvedMasteryEffect, Capacity> effects{};
        uint8_t count = 0;
    };

    // §14.12: build the application plan. Iterates the WHOLE ActiveMasterySet (multi-mastery -- never
    // assumes one cell). For each VALID entry (dual-key via IsActiveEntryValid + the archetype unlocked
    // at the school's earned level via IsLatticeArchetypeUnlocked) it:
    //   - resolves the §14.4 archetype def (LatticeArchetype),
    //   - runs PointsToAllocation -> ResolveTreeCell over the def's applicable axes at the earned level,
    //   - computes the catalyst rank for the cell's (school,tree) bucket. The bucket roster is the
    //     supplied `raidRoster` (the surrounding raid's running cells) with the player's OWN cells
    //     appended, so even a solo player stacking the same cell sees DR. v1's adapter passes its own
    //     set as the roster (every distinct cell rank 1, no DR) -- the documented raid-roster seam.
    //   - binds magnitude via RaidMultiplier (raid-wide: Offensive + non-situational sustained Support
    //     utility) or PersonalMultiplier (personal: Defensive spikes + situational SM/SE Support),
    //     clamped to the §7.9 caps. `role` drives PersonalMultiplier's role asymmetry.
    // Invalid/absent cells are skipped. Deterministic: same inputs -> identical plan (no global state).
    MasteryPlan BuildMasteryPlan(ActiveMasterySet const& set, MasterySchoolState const& state,
        RoleContribution role, CatalystKey const* raidRoster, std::size_t raidRosterCount,
        IMasteryTreeConfig const& treeCfg, IMasteryLoadoutConfig const& loadoutCfg,
        IEffectConfig const& effectCfg, ICatalystConfig const& catalystCfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERYPLAN_H
