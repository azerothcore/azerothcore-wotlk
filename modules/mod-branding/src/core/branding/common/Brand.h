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
        Stone,
        Venom,
        Chrono,
        Spirit,
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

    // Con-color band of a kill relative to the killer's level (design §7.4). Mirrors the vanilla
    // XP color bands (Formulas.h GetColorCode): Full covers red/orange/yellow (at/above level),
    // Green is the reduced band, Grey is trivial. Drives difficultyMul -- Full = 1.0, tapering to
    // the configured floor at Grey -- so an over-levelled kill is worth what the same effort is
    // worth in level-appropriate content, WITHOUT the vanilla grey->0 cliff.
    enum class KillBand : uint8_t
    {
        Full = 0,   // red / orange / yellow -- at or above the killer's level
        Green,      // green -- below level but not trivial
        Grey,       // grey -- trivial
        COUNT
    };

    // Creature classification weight lens for per-kill proficiency (design §7.4): normal < elite
    // < rare < worldboss. Normal is the 1.0 baseline; the others are configurable multipliers.
    enum class KillClassification : uint8_t
    {
        Normal = 0,
        Elite,
        Rare,
        WorldBoss,
        COUNT
    };
}

#endif // MOD_BRANDING_CORE_COMMON_BRAND_H
