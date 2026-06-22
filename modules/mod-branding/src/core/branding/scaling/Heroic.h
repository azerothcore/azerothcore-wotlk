#ifndef MOD_BRANDING_CORE_SCALING_HEROIC_H
#define MOD_BRANDING_CORE_SCALING_HEROIC_H

#include "HeroicConfig.h"
#include <cstdint>

namespace Branding
{
    // What the player/group SELECTED in the native difficulty UI (§2.4.1) -- NOT the map's resolved
    // difficulty. The selection persists even when a classic/TBC map falls back to normal.
    enum class SelectedDifficulty : uint8_t
    {
        Normal = 0,
        Heroic = 1
    };

    // Inputs for the heroic overlay decision (§2.4.2).
    struct HeroicContext
    {
        SelectedDifficulty selected = SelectedDifficulty::Normal;
        bool nativeHeroicMap = false;   // true => the engine already runs real heroic; defer stats to it
        uint8_t maxLevel = 0;           // server level cap = overlay level target when it engages
    };

    // The overlay supplies its own stat tuning only when heroic is selected AND the map has no native
    // heroic difficulty (otherwise the engine already tuned the content -- never double-scale).
    bool HeroicOverlayEngages(HeroicContext const& ctx);

    // Encounter scalars -- 1.0 unless the overlay engages (composes multiplicatively onto §2.2).
    double HeroicHealthMul(HeroicContext const& ctx, IHeroicConfig const& cfg);
    double HeroicDamageMul(HeroicContext const& ctx, IHeroicConfig const& cfg);

    // Level target for instance creatures -- ctx.maxLevel when the overlay engages, else 0 (no change).
    uint8_t HeroicLevelTarget(HeroicContext const& ctx, IHeroicConfig const& cfg);

    // Reward-tier bump for the run -- applies whenever heroic is SELECTED (native or overlay),
    // 0 when normal (§2.4.2).
    uint8_t HeroicTierBonus(HeroicContext const& ctx, IHeroicConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_SCALING_HEROIC_H
