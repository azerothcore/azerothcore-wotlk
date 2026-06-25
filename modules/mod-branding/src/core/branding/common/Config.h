#ifndef MOD_BRANDING_CORE_COMMON_CONFIG_H
#define MOD_BRANDING_CORE_COMMON_CONFIG_H

#include "Brand.h"
#include <cstdint>

namespace Branding
{
    // Injected tunables (design §7.4, §8). Core reads no globals; production wraps sConfigMgr,
    // tests inject a FakeConfig with pinned values so every formula is deterministic.
    class IBrandingConfig
    {
    public:
        virtual ~IBrandingConfig() = default;

        // --- XP modifiers (§7.4) ---
        // base = baseUnits * SourceWeight(source); branded items modify these weights, not XP.
        virtual double SourceWeight(ActivitySource source) const = 0;
        // Content relevance multiplier per source.
        virtual double RelevanceMul(ActivitySource source) const = 0;
        // Applied when the active brand matches the content's aligned brand.
        virtual double MatchBonus() const = 0;
        // Role contribution multiplier.
        virtual double RoleMul(RoleContribution role) const = 0;

        // --- Diminishing returns (§7.4) ---
        // Recent-window XP above this soft cap starts decaying.
        virtual uint32_t DrSoftCap() const = 0;
        // Floor the DR multiplier never drops below.
        virtual double DrFloor() const = 0;
        // Linear decay slope applied per XP unit past the soft cap.
        virtual double DrSlope() const = 0;
        // After this many seconds the recent-window decays back to 0 (full XP restored).
        virtual uint64_t DrWindowSeconds() const = 0;

        // --- Level curve (§7.4 — geometric per-rank; prestige = max level, §14.13.6) ---
        // rankCost(n) = round(RankBaseXp * RankGrowth^(n-1)); the cumulative threshold is
        // XpForLevel(n) = round(RankBaseXp * (RankGrowth^n - 1) / (RankGrowth - 1)), clamped at MaxLevel.
        // Defaults: RankBaseXp = 1670800 (live level-79->80 XP), RankGrowth = 1.01 (+1%/rank), MaxLevel = 50.
        virtual double RankBaseXp() const = 0;
        virtual double RankGrowth() const = 0;
        virtual uint8_t MaxLevel() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_COMMON_CONFIG_H
