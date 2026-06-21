#ifndef MOD_BRANDING_CORE_SCALING_SCALINGCONFIG_H
#define MOD_BRANDING_CORE_SCALING_SCALINGCONFIG_H

#include <cstdint>

namespace Branding
{
    // Injected tunables for the scaling systems (§2.1 player downscaling, §2.2 group scaling).
    // Pure core reads no globals; production wraps sConfigMgr, tests inject a pinned fake.
    class IScalingConfig
    {
    public:
        virtual ~IScalingConfig() = default;

        // --- Player stat scaling (§2.1) ---
        // Stat-growth exponent: factor = (target/player)^exp, clamped to <= 1.0 (downward only).
        virtual double StatScalingExponent() const = 0;

        // --- Group-size encounter scaling (§2.2) ---
        // Encounter multiplier at the smallest group (interpolates up to 1.0 at content size).
        virtual double GroupHealthFloor() const = 0;
        virtual double GroupDamageFloor() const = 0;

        // --- Group-size reward scaling (§2.2) ---
        virtual uint32_t MaxGroupMaterials() const = 0;   // material quantity at full group
        virtual uint8_t MaxRewardTier() const = 0;        // reward-tier cap at full group
        virtual double RareChanceMulMin() const = 0;      // rare/epic chance mult at smallest group
        virtual double RareChanceMulMax() const = 0;      // ...at full group
    };
}

#endif // MOD_BRANDING_CORE_SCALING_SCALINGCONFIG_H
