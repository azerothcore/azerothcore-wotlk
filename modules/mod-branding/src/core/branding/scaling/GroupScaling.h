#ifndef MOD_BRANDING_CORE_SCALING_GROUPSCALING_H
#define MOD_BRANDING_CORE_SCALING_GROUPSCALING_H

#include "ScalingConfig.h"
#include <cstddef>
#include <cstdint>

namespace Branding
{
    // Group size relative to the content's intended size (§2.2). e.g. {5, 40} = 5-man in a 40-man.
    struct GroupContext
    {
        uint8_t groupSize = 1;
        uint8_t contentSize = 1;
    };

    // Encounter scaling: bounded so any group size can clear, rising to 1.0 at full content size.
    double EncounterHealthMul(GroupContext const& group, IScalingConfig const& cfg);
    double EncounterDamageMul(GroupContext const& group, IScalingConfig const& cfg);

    // Reward yield: "won't drop as good or as many" for a smaller group (§2.2).
    struct RewardScale
    {
        uint32_t materialQuantity = 0;   // how MANY drops (linear in group fraction)
        uint8_t maxTier = 0;             // how GOOD (caps reward tier)
        double rareChanceMul = 0.0;      // rare/epic catalyst chance multiplier
        double currencyMul = 0.0;        // branding-currency yield -- steeper than gear (§2.4.3)
    };

    RewardScale RewardScaleForGroup(GroupContext const& group, IScalingConfig const& cfg);

    // The economy axis a character selects for the raid-wide Branding Boon (§2.7, issue #83). One
    // active axis per character; the boon then applies raid-wide for that axis. `None` = opted out.
    enum class BoonAxis : uint8_t
    {
        None = 0,
        Xp   = 1,
        Drop = 2,
        Gold = 3,
    };

    // Raid-wide economy multiplier for ONE boon axis, from the proficiency ranks of the group
    // members who selected it (§2.7, issues #81/#83). Each selector contributes a strength
    // s = clamp(rank / BoonMaxRank, 0, 1); strengths are sorted descending (best carries) and
    // stacked with the geometric §7.9 catalyst DR (BoonStackDecay), so:
    //     mul = clamp(1 + (AxisCap - 1) * Σ_i s_i * decay^(i-1), 1, AxisCap)
    // A lone maxed selector reaches exactly AxisCap (reproducing the old #81 +50% Drop bonus).
    // Empty/None -> 1.0. A pure bonus (>= 1.0), monotonic in any selector's rank, capped per axis.
    // Selector order does not matter (sorted internally). `ranks` may be null iff `count == 0`.
    double BoonAxisMultiplier(BoonAxis axis, uint8_t const* ranks, std::size_t count,
                              IScalingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_SCALING_GROUPSCALING_H
