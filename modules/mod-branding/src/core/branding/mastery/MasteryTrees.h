#ifndef MOD_BRANDING_CORE_MASTERY_MASTERYTREES_H
#define MOD_BRANDING_CORE_MASTERY_MASTERYTREES_H

#include "branding/effects/EffectModel.h"
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

    // §14.10: resolve a player's tuning allocation at a mastery level into concrete proc params,
    // dividing the budget b = level/(level+UpkeepHalfLevel) (saturating below 1) ONLY among the axes
    // in `applicableAxes` (an OR of AxisBit(...)). Favouring one axis costs the others -- burst vs
    // sustained vs wide vs blended, never all maxed. Each applicable axis stays within its config
    // bound; non-applicable axes resolve to their Min (magnitude floor 1.0). Degenerate (all zero /
    // negative) shares fall back to an even split over the applicable axes.
    ResolvedCell ResolveTreeCell(TreeAllocation const& alloc, uint32_t applicableAxes,
        uint8_t masteryLevel, IMasteryTreeConfig const& cfg);

    // §14.8: enemy (elite/boss) mastery magnitude. Rides on top of the §2.2-scaled encounter
    // baseline (scaling-then-branding, §2.1). Function of mastery level ONLY -- group-size invariant,
    // so it never reaches down and breaks small-group completability. 1.0 at level 0, monotonic
    // non-decreasing, asymptotes below MaxEnemyMul; never < 1.0 (mastery never weakens an enemy).
    double EnemyMasteryMultiplier(uint8_t masteryLevel, IMasteryTreeConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERYTREES_H
