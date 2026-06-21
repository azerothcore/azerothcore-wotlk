#ifndef MOD_BRANDING_CORE_SCALING_SCALING_H
#define MOD_BRANDING_CORE_SCALING_SCALING_H

#include "ScalingConfig.h"
#include <cstdint>

namespace Branding
{
    // Combat stats subject to scaling. Branding (§7.9) later multiplies the SCALED values (§2.1).
    struct CombatStats
    {
        uint32_t health = 0;
        uint32_t attackPower = 0;
        uint32_t spellPower = 0;
        uint32_t armor = 0;
    };

    // Where a player is being scaled. Event scaling overrides zone scaling (§2.1).
    struct ScalingContext
    {
        uint8_t playerLevel = 0;
        uint8_t zoneTargetLevel = 0;
        bool inEvent = false;
        uint8_t eventTargetLevel = 0;
    };

    // The bracket level actually used: event target when in an event, else the zone target.
    uint8_t EffectiveTargetLevel(ScalingContext const& ctx);

    // Downward-only scaling factor in (0, 1]. 1.0 when playerLevel <= targetLevel (never scale up).
    double ScalingFactor(uint8_t playerLevel, uint8_t targetLevel, IScalingConfig const& cfg);

    // Step (1) of the stat resolution pipeline (§2.1): raw player stats -> scaled baseline.
    CombatStats ApplyScaling(CombatStats const& raw, ScalingContext const& ctx, IScalingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_SCALING_SCALING_H
