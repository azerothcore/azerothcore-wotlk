#ifndef MOD_BRANDING_CORE_PROFICIENCY_PROFICIENCY_H
#define MOD_BRANDING_CORE_PROFICIENCY_PROFICIENCY_H

#include "Types.h"
#include "branding/common/Brand.h"
#include "branding/common/Config.h"
#include <cstdint>

namespace Branding
{
    // Level curve (design §7.4). Monotonic, saturating at cfg.MaxLevel().
    uint64_t XpForLevel(uint8_t level, IBrandingConfig const& cfg);
    uint8_t LevelForXp(uint64_t totalXp, IBrandingConfig const& cfg);

    // Effect strength (design §8): level -> normalized multiplier for proc behavior, not raw stats.
    double EffectStrength(uint8_t level, IBrandingConfig const& cfg);

    // Anti-P2W resolved strength (§1, §7.5): forced to 0 when the current account cannot express
    // this brand, regardless of stored proficiency. This is the line that makes trading safe.
    double ResolvedEffectStrength(uint8_t level, BrandId brand,
        KnowledgeState const& currentAccount, IBrandingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_PROFICIENCY_PROFICIENCY_H
