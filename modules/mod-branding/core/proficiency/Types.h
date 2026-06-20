#ifndef MOD_BRANDING_CORE_PROFICIENCY_TYPES_H
#define MOD_BRANDING_CORE_PROFICIENCY_TYPES_H

#include "common/Brand.h"
#include <cstdint>

namespace Branding
{
    // Built by the adapter from a gameplay event (design §7.2).
    struct XpActivity
    {
        ActivitySource source = ActivitySource::Invasion;
        BrandId activeBrand = BrandId::Fire;     // the player's active brand at the time
        BrandId contentBrand = BrandId::Fire;    // the content/event's aligned brand (match bonus)
        RoleContribution role = RoleContribution::None;
        uint32_t baseUnits = 0;                  // raw activity magnitude
    };

    // Loaded from DB, mutated by core, saved by adapter (design §7.2).
    struct ProficiencyState
    {
        uint64_t totalXp = 0;
        uint32_t recentXpWindow = 0;             // accumulator for diminishing returns
        uint64_t windowStartUnix = 0;            // 0 = no active window
    };

    struct XpResult
    {
        uint32_t xpGained = 0;                   // after all modifiers + DR
        uint8_t levelBefore = 0;
        uint8_t levelAfter = 0;
        bool reachedPrestige = false;            // hit max level on this gain
    };

    // Account-wide unlock state (design §6). Bitmask indexed by BrandId.
    struct KnowledgeState
    {
        uint32_t unlockedMask = 0;
    };
}

#endif // MOD_BRANDING_CORE_PROFICIENCY_TYPES_H
