#ifndef MOD_BRANDING_CORE_COMMON_BRAND_H
#define MOD_BRANDING_CORE_COMMON_BRAND_H

#include <cstdint>

// Pure core. No AzerothCore includes are permitted anywhere under core/.
namespace Branding
{
    // The set of brands. Extensible; order is stable (used as bitmask index in KnowledgeState's
    // uint32_t mask -> up to 32 brands). Append new schools BEFORE COUNT to preserve persisted ids.
    enum class BrandId : uint8_t
    {
        // Classic spell schools.
        Fire = 0,
        Frost,
        Nature,
        Shadow,
        Arcane,
        Holy,
        Physical,
        // Exotic schools (§7.10) -- hybrid/conceptual brands; expressed via the same effect model.
        Wind,
        Lightning,
        Blood,
        Void,
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
