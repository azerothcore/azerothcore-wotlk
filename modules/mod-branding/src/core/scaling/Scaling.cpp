#include "Scaling.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    uint8_t EffectiveTargetLevel(ScalingContext const& ctx)
    {
        // Event scaling overrides zone scaling (§2.1).
        return ctx.inEvent ? ctx.eventTargetLevel : ctx.zoneTargetLevel;
    }

    double ScalingFactor(uint8_t playerLevel, uint8_t targetLevel, IScalingConfig const& cfg)
    {
        if (playerLevel == 0 || targetLevel == 0)
            return 1.0;

        // Downward only: a player at or below the bracket is never scaled up.
        if (playerLevel <= targetLevel)
            return 1.0;

        double const ratio = static_cast<double>(targetLevel) / static_cast<double>(playerLevel);
        return std::min(1.0, std::pow(ratio, cfg.StatScalingExponent()));
    }

    namespace
    {
        uint32_t ScaleStat(uint32_t value, double factor)
        {
            return static_cast<uint32_t>(value * factor + 0.5);
        }
    }

    CombatStats ApplyScaling(CombatStats const& raw, ScalingContext const& ctx, IScalingConfig const& cfg)
    {
        double const factor = ScalingFactor(ctx.playerLevel, EffectiveTargetLevel(ctx), cfg);

        CombatStats scaled;
        scaled.health = ScaleStat(raw.health, factor);
        scaled.attackPower = ScaleStat(raw.attackPower, factor);
        scaled.spellPower = ScaleStat(raw.spellPower, factor);
        scaled.armor = ScaleStat(raw.armor, factor);
        return scaled;
    }
}
