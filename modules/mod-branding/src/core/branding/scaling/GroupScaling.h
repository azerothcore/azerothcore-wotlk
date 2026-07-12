#ifndef MOD_BRANDING_CORE_SCALING_GROUPSCALING_H
#define MOD_BRANDING_CORE_SCALING_GROUPSCALING_H

#include "ScalingConfig.h"
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

    // Instanced (dungeon/raid) drop-rate multiplier from the party's highest branding rank (§2.7,
    // issue #81). Linear in rank, clamped to [1.0, cap]: a pure bonus (1.0 at rank 0, never a penalty)
    // so farming ranks pays off and a high-rank member is worth bringing.
    double RankDropRateMultiplier(uint8_t topRank, IScalingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_SCALING_GROUPSCALING_H
