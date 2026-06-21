#include "CatalystStacking.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    double CatalystStackWeight(uint8_t rank, ICatalystConfig const& cfg)
    {
        if (rank == 0)
            return 0.0;

        // Geometric decay: 1st specialist full (decay^0 = 1), each subsequent one weaker.
        return std::pow(cfg.StackDecay(), static_cast<double>(rank - 1));
    }

    double RaidCatalystMultiplier(uint8_t rank, ICatalystConfig const& cfg)
    {
        double const multiplier = 1.0 + (cfg.MaxRaidMul() - 1.0) * CatalystStackWeight(rank, cfg);

        // Bounded [1.0, MaxRaidMul]: a brand never hurts the raid, never exceeds the cap (§7.9).
        return std::clamp(multiplier, 1.0, cfg.MaxRaidMul());
    }
}
