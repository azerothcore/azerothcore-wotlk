#ifndef MOD_BRANDING_CORE_COMMON_BRAND_H
#define MOD_BRANDING_CORE_COMMON_BRAND_H

#include <cstdint>

// Pure core. No AzerothCore includes are permitted anywhere under core/.
namespace Branding
{
    // The set of brands. Extensible; order is stable (used as bitmask index in KnowledgeState).
    enum class BrandId : uint8_t
    {
        Fire = 0,
        Frost,
        Nature,
        Shadow,
        Arcane,
        Holy,
        Physical,
        COUNT
    };

    // XP source categories (design §7). Branded items modify the weights of these, not XP directly.
    enum class ActivitySource : uint8_t
    {
        Invasion = 0,
        Raid,
        Dungeon,
        Gathering,
        Crafting,
        Pvp,
        COUNT
    };

    // Role contribution lens for the role bonus (design §7) and effect asymmetry (§7.9).
    enum class RoleContribution : uint8_t
    {
        None = 0,
        Tank,
        Healer,
        Damage,
        Control,
        Support,
        COUNT
    };
}

#endif // MOD_BRANDING_CORE_COMMON_BRAND_H
