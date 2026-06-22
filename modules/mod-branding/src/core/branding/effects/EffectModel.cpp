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

namespace Branding
{
    EffectProfile ProfileFor(BrandId /*brand*/, RoleContribution role)
    {
        // Brand-specific profiles are a future refinement; for now the role drives kind + timing.
        EffectProfile profile;
        profile.role = role;
        switch (role)
        {
            case RoleContribution::Tank:
                profile.kind = EffectKind::PersonalSpike;   // dramatic, visible survivability spike
                profile.windowDurationMs = 8000;
                profile.cooldownMs = 24000;
                break;
            case RoleContribution::Healer:
                profile.kind = EffectKind::MechanicTransform; // structural (overheal->shield, ...)
                break;
            default:
                profile.kind = EffectKind::RaidWindow;      // restrained burst window
                profile.windowDurationMs = 6000;
                profile.cooldownMs = 18000;
                break;
        }
        return profile;
    }

    bool IsWindowActive(EffectProfile const& profile, uint64_t nowMs)
    {
        if (profile.kind == EffectKind::MechanicTransform)
            return true;    // structural transforms are always on; gated by strength, not time

        uint64_t const period = static_cast<uint64_t>(profile.windowDurationMs) + profile.cooldownMs;
        if (period == 0)
            return true;

        return (nowMs % period) < profile.windowDurationMs;
    }

    double WindowedOutgoingMultiplier(EffectProfile const& profile, uint8_t profLevel,
        double catalystStackWeight, uint64_t nowMs, IEffectConfig const& cfg)
    {
        // The healer transform expresses through the heal hook, never as an outgoing multiplier.
        if (profile.kind == EffectKind::MechanicTransform)
            return 1.0;

        // §7.9 no passive uptime: outside the active window the brand contributes nothing.
        if (!IsWindowActive(profile, nowMs))
            return 1.0;

        // PersonalSpike (tank) gets the large personal cap; RaidWindow gets the bounded, catalyst-DR'd
        // raid cap. Both are already clamped inside the respective Multiplier functions.
        if (profile.kind == EffectKind::PersonalSpike)
            return PersonalMultiplier(profLevel, profile, cfg);

        return RaidMultiplier(profLevel, profile, catalystStackWeight, cfg);
    }

    double WindowedIncomingMultiplier(EffectProfile const& profile, uint8_t profLevel,
        uint64_t nowMs, IEffectConfig const& cfg)
    {
        // Only a tank's PersonalSpike mitigates incoming damage, and only inside its window. The
        // reduction is the inverse of the personal multiplier -- a dramatic, short, windowed spike.
        if (profile.kind != EffectKind::PersonalSpike || !IsWindowActive(profile, nowMs))
            return 1.0;

        double const personal = PersonalMultiplier(profLevel, profile, cfg);
        return personal > 0.0 ? 1.0 / personal : 1.0;
    }

    uint32_t OverhealShieldAmount(uint32_t heal, uint32_t missingHealth, uint32_t maxHealth,
        uint8_t profLevel, IEffectConfig const& cfg)
    {
        // No overheal (heal at or below missing health) -> nothing to transform.
        if (heal <= missingHealth)
            return 0;

        // The overheal portion, scaled by mastery (0 at level 0), then hard-capped to a fraction of
        // the target's max health so a single transform can never snowball (§7.9 #3).
        double shield = static_cast<double>(heal - missingHealth) * Strength(profLevel, cfg);
        double const cap = static_cast<double>(maxHealth) * cfg.MaxOverhealShieldFraction();
        if (shield > cap)
            shield = cap;

        return static_cast<uint32_t>(shield);
    }
}
