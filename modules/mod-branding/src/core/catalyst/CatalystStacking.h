#ifndef MOD_BRANDING_CORE_CATALYST_CATALYSTSTACKING_H
#define MOD_BRANDING_CORE_CATALYST_CATALYSTSTACKING_H

#include "CatalystConfig.h"
#include <cstdint>

namespace Branding
{
    // Effectiveness weight of the rank-th same-role branded specialist (1-indexed), in [0, 1].
    // rank 0 -> 0 (no specialist); rank 1 -> 1.0 (full); decays geometrically thereafter (§9 catalyst).
    double CatalystStackWeight(uint8_t rank, ICatalystConfig const& cfg);

    // The raid catalyst multiplier applied for the rank-th same-role branded specialist.
    // In [1.0, MaxRaidMul] for all inputs (a brand never hurts the raid), monotonically
    // NON-INCREASING in rank (1st full, 2nd reduced, 3rd+ heavily reduced; §7.9).
    double RaidCatalystMultiplier(uint8_t rank, ICatalystConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_CATALYST_CATALYSTSTACKING_H
