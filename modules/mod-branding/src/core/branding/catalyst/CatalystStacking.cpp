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

    bool SameCatalystBucket(CatalystKey const& a, CatalystKey const& b)
    {
        // §14.9: both school AND tree must match -- Fire-Def and Fire-Off are different buckets.
        return a.school == b.school && a.tree == b.tree;
    }

    uint8_t CatalystRankInBucket(CatalystKey const* roster, std::size_t count, std::size_t index)
    {
        if (roster == nullptr || index >= count)
            return 0;

        // Rank = 1 + (prior roster entries sharing this entry's bucket). Distinct (school, tree)
        // keys never increment each other, so complementary specialists each stay at rank 1 (no DR).
        uint8_t rank = 1;
        for (std::size_t i = 0; i < index; ++i)
        {
            if (SameCatalystBucket(roster[i], roster[index]))
                ++rank;
        }

        return rank;
    }
}
