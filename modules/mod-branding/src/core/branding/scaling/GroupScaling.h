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
        uint32_t materialQuantity = 0;   // how MANY drops
        uint8_t maxTier = 0;             // how GOOD (caps reward tier)
        double rareChanceMul = 0.0;      // rare/epic catalyst chance multiplier
    };

    RewardScale RewardScaleForGroup(GroupContext const& group, IScalingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_SCALING_GROUPSCALING_H
