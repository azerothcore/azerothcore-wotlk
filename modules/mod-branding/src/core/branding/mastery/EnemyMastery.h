#ifndef MOD_BRANDING_CORE_MASTERY_ENEMYMASTERY_H
#define MOD_BRANDING_CORE_MASTERY_ENEMYMASTERY_H

#include "branding/mastery/MasteryTrees.h"
#include <cstdint>

namespace Branding
{
    // §14.8.1: a creature's combat rank for enemy-side mastery. Ordinal is meaningful -- the enemy
    // multiplier is monotonic non-decreasing in this order (Normal <= Elite <= Boss). Append only.
    enum class EnemyRank : uint8_t
    {
        Normal = 0,
        Elite,
        Boss
    };

    // §14.8.1/§14.6: rank -> enemy mastery level fed to EnemyMasteryMultiplier.
    //   Boss   = MaxMasteryLevel (full mastery -- "bosses are at max mastery")
    //   Elite  = round(MaxMasteryLevel * EnemyEliteLevelFraction), fraction clamped to [0,1]
    //   Normal = 0 (no enemy mastery)
    // Pure: no creature math here, just the design mapping; the curve is reused via the multiplier.
    uint8_t EnemyMasteryLevelForRank(EnemyRank rank, IMasteryTreeConfig const& cfg);

    // §14.8.1: the bounded OUTGOING-damage multiplier for a ranked enemy, riding on top of the already
    // §2.2-scaled baseline (scaling-then-branding, §2.1). Equals EnemyMasteryMultiplier(
    // EnemyMasteryLevelForRank(rank, cfg), cfg): 1.0 for Normal, <= MaxEnemyMul, >= 1.0, monotonic
    // non-decreasing in rank, and a function of rank/level ONLY -- group-size invariant (§2.2 Risk #4).
    double EnemyMasteryMultiplierForRank(EnemyRank rank, IMasteryTreeConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_MASTERY_ENEMYMASTERY_H
