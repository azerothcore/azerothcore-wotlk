#ifndef MOD_BRANDING_CORE_MASTERY_MASTERYTREES_H
#define MOD_BRANDING_CORE_MASTERY_MASTERYTREES_H

#include "branding/effects/EffectModel.h"
#include <array>
#include <cstdint>

namespace Branding
{
    // §14.1: each damage school carries three trees. Persisted by ordinal -- only ever append.
    enum class MasteryTree : uint8_t
    {
        Defensive = 0,
        Offensive,
        Support,
        COUNT
    };

    // §14.2: a single (school, tree) cell. EVERYTHING is a proc-window -- there are no flat
    // passives in the lattice, including the resistances/mitigation (see `situational`). `ppm` is
    // procs-per-minute (§14.3 #2), NOT a per-action chance, so upkeep is decoupled from how often a
    // class acts. `situational` marks the SM/SE cells (resistances + school-exposure) that are only
    // full-value inside content themed to their matching school.
    struct ProcCell
    {
        EffectKind kind = EffectKind::RaidWindow;
        double     ppm = 0.0;            // procs per minute at full mastery (pre-context input)
        uint32_t   windowDurationMs = 0; // length of the buff/debuff window each proc opens
        bool       situational = false;  // SM/SE: full value only vs the matching invasion school
    };

    // §14.3: injected tunables for the combat-mastery upkeep model. Distinct from IMasteryConfig
    // (the §6 gathering/craft bonus); this governs proc upkeep, its asymptote, and off-school falloff.
    class IMasteryTreeConfig
    {
    public:
        virtual ~IMasteryTreeConfig() = default;

        virtual uint8_t MaxMasteryLevel() const = 0;
        // §14.3 #1: the uptime ceiling. MUST be < 1.0; upkeep approaches but never reaches it.
        virtual double  MaxUptime() const = 0;
        // Mastery level at which upkeep reaches MaxUptime/2 (saturating-hyperbola scale factor).
        virtual double  UpkeepHalfLevel() const = 0;
        // Multiplier applied to a `situational` cell when NOT in its matching-school context (0..1).
        virtual double  OffSchoolFactor() const = 0;
        // §14.8: separate ceiling for ENEMY (elite/boss) mastery procs. MUST be < an effect config's
        // MaxPersonalMul -- enemy spikes are reactable windows, not one-shots. >= 1.0.
        virtual double  MaxEnemyMul() const = 0;
        // §14.8.1: an invasion ELITE's enemy mastery level as a fraction of MaxMasteryLevel (a boss is
        // at full mastery; an elite at a scaled level). Clamped to [0,1] by EnemyMasteryLevelForRank.
        virtual double  EnemyEliteLevelFraction() const = 0;

        // §14.10: per-axis bounds for the player tuning budget. ppm and window define the achievable
        // envelope each axis can occupy; MaxProcMagnitude caps the magnitude axis (lattice sets it
        // <= MaxRaidMul / MaxPersonalMul so the §7.9 caps subsume it). magnitude floor is always 1.0.
        virtual double   MinPpm() const = 0;
        virtual double   MaxPpm() const = 0;
        virtual uint32_t MinWindowMs() const = 0;
        virtual uint32_t MaxWindowMs() const = 0;
        virtual double   MaxProcMagnitude() const = 0;
        // §14.10 reach axis: normalized breadth, rendered per-cell as AoE radius (yards) OR cleave
        // target-count -- a tooltip/adapter interpretation; core treats it as one envelope.
        virtual double   MinReach() const = 0;
        virtual double   MaxReach() const = 0;

        // §14.4.1: how many of a cell's authored proc archetypes are unlocked at a given proficiency
        // level (1-based; >= 1 at level 0 so the primary is always available, growing with level).
        // Mirrors the §7.9 loadout gate IItemBrandConfig::ArchetypesAtLevel -- secondary archetypes
        // gate behind proficiency. The bound is config, retunable without a recompile.
        virtual uint8_t MaxArchetypesAtLevel(uint8_t proficiencyLevel) const = 0;
    };

    // §14.2/§14.7: expected uptime fraction a character can SUSTAIN for a cell's proc-window, given
    // the dual-key (§14/§6) and school context. Returns 0 if the account has not unlocked the tree
    // OR the character has earned no level. Otherwise a saturating-hyperbola curve in masteryLevel:
    //   upkeep = MaxUptime * level / (level + UpkeepHalfLevel)
    // -- monotonic, diminishing increments, and STRICTLY below MaxUptime for all finite levels
    // (the §14.3 #1 asymptote). A `situational` cell out of its matching context is scaled by
    // OffSchoolFactor. Never returns >= MaxUptime, never negative.
    double MasteryUpkeep(bool accountUnlocked, uint8_t masteryLevel, ProcCell const& cell,
        bool inMatchingSchoolContext, IMasteryTreeConfig const& cfg);

    // §14.3 #2: expected number of procs over `elapsedMs` for a `ppm` proc, modelled per-swing with
    // `weaponSpeedS` seconds/swing (PPM normalization). The weapon speed cancels out -- a fast and a
    // slow attacker at equal ppm yield the same expected procs over equal real time. Pass any
    // weaponSpeedS > 0 (e.g. 1.0 for spell/PPM-only sources); the result is density-independent.
    double ExpectedProcs(double ppm, uint32_t elapsedMs, double weaponSpeedS,
        IMasteryTreeConfig const& cfg);

    // §14.10: the tunable proc axes. A cell exposes a SUBSET (its applicable-axis mask). `Reach` (the
    // breadth axis) only applies to area/cleave procs -- rendered as radius OR target count. COUNT last.
    enum class ProcAxis : uint8_t { Ppm = 0, Duration, Magnitude, Reach, COUNT };

    // Bit for a ProcAxis in an applicable-axis mask (OR them together).
    constexpr uint32_t AxisBit(ProcAxis a) { return 1u << static_cast<uint32_t>(a); }

    // §14.10: a character's chosen split of their per-cell budget across the proc axes. Shares are
    // relative weights (>= 0), normalized internally over the cell's applicable axes; shares for
    // non-applicable axes are ignored. Default {1,1,1,1} == even split over whatever the cell exposes.
    struct TreeAllocation
    {
        double share[static_cast<uint8_t>(ProcAxis::COUNT)] = { 1.0, 1.0, 1.0, 1.0 };
    };

    // §14.10: concrete proc parameters produced by resolving an allocation at a mastery level.
    struct ResolvedCell
    {
        double   ppm = 0.0;
        uint32_t windowDurationMs = 0;
        double   magnitude = 1.0;   // per-proc strength multiplier, >= 1.0
        double   reach = 0.0;       // breadth: AoE radius (yd) or cleave target-count; Min for single-target
    };

    // §14.10: the concrete numeric bounds the resolver fills between. Built from the whole-lattice
    // IMasteryTreeConfig (GlobalEnvelope) and optionally NARROWED per cell by the §14.4.2 content layer
    // (EffectiveEnvelope, issue #30). The magnitude floor is always 1.0; `maxMagnitude` is its ceiling.
    struct ResolvedEnvelope
    {
        double   minPpm = 0.0;
        double   maxPpm = 0.0;
        uint32_t minWindowMs = 0;
        uint32_t maxWindowMs = 0;
        double   maxMagnitude = 1.0;   // magnitude axis ceiling (floor is 1.0); <= MaxProcMagnitude
        double   minReach = 0.0;
        double   maxReach = 0.0;
    };

    // The whole-lattice envelope (no per-cell narrowing): each axis bound taken straight from config.
    ResolvedEnvelope GlobalEnvelope(IMasteryTreeConfig const& cfg);

    // §14.10: resolve a player's tuning allocation at a mastery level into concrete proc params,
    // dividing the budget b = level/(level+UpkeepHalfLevel) (saturating below 1) ONLY among the axes
    // in `applicableAxes` (an OR of AxisBit(...)). Favouring one axis costs the others -- burst vs
    // sustained vs wide vs blended, never all maxed. Each applicable axis stays within its config
    // bound; non-applicable axes resolve to their Min (magnitude floor 1.0). Degenerate (all zero /
    // negative) shares fall back to an even split over the applicable axes.
    ResolvedCell ResolveTreeCell(TreeAllocation const& alloc, uint32_t applicableAxes,
        uint8_t masteryLevel, IMasteryTreeConfig const& cfg);

    // §14.10 / §14.4.2: the same resolve against an EXPLICIT envelope + budget half-level. The
    // config overload above is exactly this with GlobalEnvelope(cfg) and cfg.UpkeepHalfLevel(); the
    // per-cell content path (ResolveContentCell) calls it with a narrowed envelope.
    ResolvedCell ResolveTreeCell(TreeAllocation const& alloc, uint32_t applicableAxes,
        uint8_t masteryLevel, ResolvedEnvelope const& env, double upkeepHalfLevel);

    // §14.4: structural definition of ONE proc archetype of a (school, tree) lattice cell. This is
    // the DESIGN ruleset (the §14.4 table): the §7.9 expression family, whether the archetype is
    // school-matched/situational, sustained-vs-windowed, and which §14.10 axes it exposes. Concrete
    // spell ids and per-cell envelopes are data/config layered on top; this fixes the shape.
    // §14.4.1: a cell carries 1..N of these (the `·` entries in the §14.4 table); the player's §7.9
    // selectedProcArchetype indexes them. Archetype 0 is always the cell's PRIMARY.
    struct LatticeCellDef
    {
        EffectKind kind = EffectKind::RaidWindow;
        bool       situational = false;     // SM/SE: school-matched mitigation/exposure
        // Support buffs are SUSTAINED auras -- constant uptime is intended, so the §14.3 uptime
        // asymptote does NOT apply and mastery tunes magnitude + reach instead of ppm/duration.
        // Def/Off cells are windowed (sustained == false).
        bool       sustained = false;
        uint32_t   applicableAxes = 0;      // §14.10 tunable axes for this cell (OR of AxisBit(...))
    };

    // §14.4.1: max proc archetypes any single cell can carry. A fixed cap keeps the pure core free of
    // <vector>; the §14.4 Support multi-entries fit in 2, with headroom for later authoring.
    constexpr uint8_t kMaxLatticeArchetypes = 4;

    // §14.4.1: a cell's authored proc archetypes -- a fixed-cap array + count (NO <vector> in core).
    // archetype[0] is the primary; archetype[1..count-1] are the §14.4 `·` secondaries.
    struct LatticeCellArchetypes
    {
        std::array<LatticeCellDef, kMaxLatticeArchetypes> archetype{};
        uint8_t count = 1;
    };

    // §14.4.1: the full set of proc archetypes for a (school, tree) cell. Keyed PURELY by (school,
    // tree) -- no global "active cell" state, so this composes with later multi-mastery (a character
    // running several active cells at once). Unauthored schools return the neutral default (count 1).
    LatticeCellArchetypes LatticeArchetypes(BrandId school, MasteryTree tree);

    // §14.4.1: number of authored archetypes for a cell (always >= 1; the primary).
    uint8_t LatticeArchetypeCount(BrandId school, MasteryTree tree);

    // §14.4.1: one archetype of a cell. archetypeIndex 0 is the primary; an out-of-range index clamps
    // to the primary (a bad selection never UB's -- callers validate via IsLatticeArchetypeUnlocked).
    LatticeCellDef LatticeArchetype(BrandId school, MasteryTree tree, uint8_t archetypeIndex);

    // §14.4.1 validation: is `archetypeIndex` a legal pick for a character at `proficiencyLevel`?
    // True iff the index is within the cell's authored count AND within the level-gated unlock count
    // (cfg.MaxArchetypesAtLevel). Index 0 (the primary) is always legal once the cell exists. Mirrors
    // the §7.9 loadout gate (IsLoadoutValid / ArchetypesAtLevel) on the mastery side.
    bool IsLatticeArchetypeUnlocked(BrandId school, MasteryTree tree, uint8_t archetypeIndex,
        uint8_t proficiencyLevel, IMasteryTreeConfig const& cfg);

    // Look up a cell's PRIMARY archetype (§14.4) -- identical to LatticeArchetype(school, tree, 0).
    // Schools without authored trees (Arcane/Holy) return a neutral default (RaidWindow,
    // non-situational, ppm/duration/magnitude axes). Kept stable so existing consumers are undisturbed.
    LatticeCellDef LatticeCell(BrandId school, MasteryTree tree);

    // §14.8: enemy (elite/boss) mastery magnitude. Rides on top of the §2.2-scaled encounter
    // baseline (scaling-then-branding, §2.1). Function of mastery level ONLY -- group-size invariant,
    // so it never reaches down and breaks small-group completability. 1.0 at level 0, monotonic
    // non-decreasing, asymptotes below MaxEnemyMul; never < 1.0 (mastery never weakens an enemy).
    double EnemyMasteryMultiplier(uint8_t masteryLevel, IMasteryTreeConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERYTREES_H
