#include "EffectModel.h"
#include <algorithm>

namespace Branding
{
    namespace
    {
        double Strength(uint8_t level, IEffectConfig const& cfg)
        {
            if (cfg.MaxEffectLevel() == 0)
                return 0.0;

            return std::min(1.0, static_cast<double>(level) / static_cast<double>(cfg.MaxEffectLevel()));
        }
    }

    double PersonalMultiplier(uint8_t profLevel, EffectProfile const& profile, IEffectConfig const& cfg)
    {
        double const multiplier = 1.0 + (cfg.MaxPersonalMul() - 1.0)
            * Strength(profLevel, cfg) * cfg.RolePersonalScale(profile.role);
        return std::clamp(multiplier, 1.0, cfg.MaxPersonalMul());
    }

    double RaidMultiplier(uint8_t profLevel, EffectProfile const& /*profile*/, double catalystStackWeight,
        IEffectConfig const& cfg)
    {
        double const weight = std::clamp(catalystStackWeight, 0.0, 1.0);
        double const multiplier = 1.0 + (cfg.MaxRaidMul() - 1.0) * Strength(profLevel, cfg) * weight;

        // Always bounded: never exceeds the raid cap, never drops below 1.0 (§7.9).
        return std::clamp(multiplier, 1.0, cfg.MaxRaidMul());
    }

    double WindowUptimeFraction(EffectProfile const& profile)
    {
        uint64_t const denom = static_cast<uint64_t>(profile.windowDurationMs) + profile.cooldownMs;
        if (denom == 0)
            return 0.0;

        return static_cast<double>(profile.windowDurationMs) / static_cast<double>(denom);
    }

    bool IsPrestige(uint8_t profLevel, IEffectConfig const& cfg)
    {
        return profLevel >= cfg.MaxEffectLevel();
    }
}
