#ifndef MOD_BRANDING_CORE_MASTERY_MASTERYCONTENT_H
#define MOD_BRANDING_CORE_MASTERY_MASTERYCONTENT_H

#include "branding/common/Brand.h"
#include "branding/mastery/MasteryTrees.h"
#include <array>
#include <cstdint>

// §14.4.2 (issue #30): the CONCRETE content that rides on the §14.4 lattice SHAPE. The shape
// (LatticeCellDef: kind/situational/sustained/axes) lives in MasteryTrees; this layer adds the
// reused 3.3.5a spell each cell expresses through, the per-cell tuning envelope (esp. the conservative
// magnitude ceiling for sustained raid buffs, §14.2), and how the §14.10 reach axis renders (a radius
// in yards vs an integer target count). Pure core: no AzerothCore includes. Keyed identically to the
// shape by (school, tree, archetypeIndex) so it composes with multi-mastery; the adapter applies the
// named spell and chooses the per-proc target set. Spell IDs: docs/issues/30-classic-school-spell-map.md
// (classic) and 16-exotic-school-spell-map.md.
namespace Branding
{
    // §14.4.2: how a cell's §14.10 reach axis is rendered/applied. `None` == single-target (the reach
    // axis is not in the cell's applicable mask). `RadiusYards` == a genuinely field-shaped effect
    // (AoE/aura) whose breadth is a radius. `TargetCount` == a spread/chain/cleave whose breadth is an
    // integer count of targets the adapter applies itself, independent of the source spell's hard cap.
    enum class ReachMode : uint8_t
    {
        None = 0,
        RadiusYards,
        TargetCount
    };

    // §14.4.2: the per-cell tuning envelope. Each cap NARROWS the whole-lattice IMasteryTreeConfig
    // bound; a value of 0 (or ReachMode::None) means "inherit the global bound". The magnitude floor is
    // always 1.0 (set in core); `maxMagnitude` is the per-cell ceiling -- sustained raid-utility cells
    // set it conservatively below the global MaxProcMagnitude.
    struct CellEnvelope
    {
        double    maxPpm = 0.0;          // 0 == inherit cfg.MaxPpm()
        uint32_t  maxWindowMs = 0;       // 0 == inherit cfg.MaxWindowMs()
        double    maxMagnitude = 0.0;    // 0 == inherit cfg.MaxProcMagnitude(); else the per-cell ceiling
        ReachMode reachMode = ReachMode::None;
        double    minReach = 0.0;        // base reach before mastery (yards OR target count)
        double    maxReach = 0.0;        // per-cell reach ceiling at full investment (only when reachMode set)
    };

    // §14.4.2: one archetype's concrete content -- the reused spell shell + its tuning envelope.
    struct LatticeCellContent
    {
        uint32_t     spellId = 0;        // 3.3.5a visual/mechanical shell (0 == unauthored / neutral)
        CellEnvelope envelope{};
    };

    // §14.4.2: a cell's authored content archetypes -- fixed-cap array + count (NO <vector> in core).
    // archetype[0] is the primary; the count mirrors LatticeArchetypes (the shape <-> content invariant).
    struct LatticeCellContentSet
    {
        std::array<LatticeCellContent, kMaxLatticeArchetypes> archetype{};
        uint8_t count = 1;
    };

    // Full content set for a (school, tree) cell. Unauthored schools (the exotic §7.10 set) return the
    // neutral default (count 1, spellId 0) -- consistent with LatticeArchetypes' neutral shape.
    LatticeCellContentSet LatticeContents(BrandId school, MasteryTree tree);

    // Number of authored content archetypes for a cell (always >= 1; equals LatticeArchetypeCount).
    uint8_t LatticeContentCount(BrandId school, MasteryTree tree);

    // One archetype's content. An out-of-range index clamps to the primary (mirrors LatticeArchetype).
    LatticeCellContent LatticeContent(BrandId school, MasteryTree tree, uint8_t archetypeIndex);

    // Convenience: the reused spell id for a (school, tree, archetype). 0 if unauthored.
    uint32_t LatticeSpellId(BrandId school, MasteryTree tree, uint8_t archetypeIndex);

    // §14.4.2: intersect a per-cell envelope with the global config -- each per-cell cap that is set
    // narrows the matching global bound (never widens); unset caps inherit the global value. When the
    // cell names a reach mode, its [minReach, maxReach] REPLACES the global reach bound (a 40-yard
    // default is meaningless for a target count). Mins are clamped to not exceed the resolved maxes.
    ResolvedEnvelope EffectiveEnvelope(CellEnvelope const& cell, IMasteryTreeConfig const& cfg);

    // §14.10/§14.4.2: resolve an allocation against a cell's EFFECTIVE (per-cell ∩ global) envelope at a
    // mastery level. Equivalent to ResolveTreeCell with EffectiveEnvelope(cell, cfg); this is the path
    // BuildMasteryPlan uses so the per-cell ceiling/reach bounds actually bind in production.
    ResolvedCell ResolveContentCell(TreeAllocation const& alloc, uint32_t applicableAxes,
        CellEnvelope const& cell, uint8_t masteryLevel, IMasteryTreeConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERYCONTENT_H
