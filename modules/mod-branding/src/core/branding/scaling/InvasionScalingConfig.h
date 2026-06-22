#ifndef MOD_BRANDING_CORE_SCALING_INVASIONSCALINGCONFIG_H
#define MOD_BRANDING_CORE_SCALING_INVASIONSCALINGCONFIG_H

#include <cstdint>

namespace Branding
{
    // Injected tunables for open-world invasion crowd scaling (§2.5). Pure core reads no globals;
    // production wraps sConfigMgr, tests inject a pinned fake. Boss difficulty reuses the §2.2
    // IScalingConfig dials -- this interface only carries the invasion-specific knobs.
    class IInvasionScalingConfig
    {
    public:
        virtual ~IInvasionScalingConfig() = default;

        // Enrolled headcount that counts as a "full" invasion: the difficulty/spawn ceiling. Crowd
        // beyond this adds nothing (the §2.2 "41st body" invariant, restated for the open world).
        virtual uint8_t IntendedInvasionSize() const = 0;

        // Decayed-peak window (§2.5.2): effective headcount is the max instantaneous count seen in
        // the trailing window, so a wipe / brief AFK does not instantly soften the field.
        virtual uint64_t CrowdDecaySeconds() const = 0;

        // Gentle trash curve (§2.5.1): trash mul rises from 1.0 at a solo straggler to TrashMaxMul at
        // a full crowd. TrashMaxMul >= 1.0 (1.0 => count-only, no per-trash difficulty scaling);
        // TrashExponent >= 1.0 shapes the ramp (higher => slower start, kinder to small crowds).
        virtual double TrashMaxMul() const = 0;
        virtual double TrashExponent() const = 0;

        // Hysteresis (§2.5.3): an active reinforcement tier is only released once the effective
        // headcount falls this many participants below its threshold, so a crowd hovering on a
        // boundary does not strobe spawn groups in and out.
        virtual uint32_t TierReleaseMargin() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_SCALING_INVASIONSCALINGCONFIG_H
