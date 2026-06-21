#include "branding/mastery/EnemyMastery.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    uint8_t EnemyMasteryLevelForRank(EnemyRank rank, IMasteryTreeConfig const& cfg)
    {
        uint8_t const maxLevel = cfg.MaxMasteryLevel();
        switch (rank)
        {
            case EnemyRank::Boss:
                // "Bosses are at max mastery" (§14.6).
                return maxLevel;
            case EnemyRank::Elite:
            {
                // A scaled level: a config-driven fraction of the boss's full mastery. Clamp the
                // fraction to [0,1] so a misconfigured value can never push an elite past a boss.
                double const fraction = std::clamp(cfg.EnemyEliteLevelFraction(), 0.0, 1.0);
                double const level = std::round(static_cast<double>(maxLevel) * fraction);
                return static_cast<uint8_t>(level);
            }
            case EnemyRank::Normal:
            default:
                return 0;
        }
    }

    double EnemyMasteryMultiplierForRank(EnemyRank rank, IMasteryTreeConfig const& cfg)
    {
        // Reuse the §14.8 curve -- never reimplement it. Group-size invariant: depends on rank/level
        // only, so the same fraction rides on top of any §2.2-scaled baseline (small or full group).
        return EnemyMasteryMultiplier(EnemyMasteryLevelForRank(rank, cfg), cfg);
    }
}
