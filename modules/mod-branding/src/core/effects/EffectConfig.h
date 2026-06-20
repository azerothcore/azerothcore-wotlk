#ifndef MOD_BRANDING_CORE_EFFECTS_EFFECTCONFIG_H
#define MOD_BRANDING_CORE_EFFECTS_EFFECTCONFIG_H

#include "common/Brand.h"
#include <cstdint>

namespace Branding
{
    // Injected tunables for the branding effect model (§7.9). The caps are the legendary-vs-mandatory
    // dials: large personal (fantasy), bounded raid (desirability, not mandate).
    class IEffectConfig
    {
    public:
        virtual ~IEffectConfig() = default;

        virtual double MaxPersonalMul() const = 0;   // large, e.g. 3.0-4.0 (felt by the player)
        virtual double MaxRaidMul() const = 0;       // bounded, e.g. 2.0 (granted to the raid)
        virtual uint8_t MaxEffectLevel() const = 0;  // proficiency level that yields full strength

        // Role asymmetry (§7.9): tank effects are dramatic, dps restrained. In (0, 1], tank highest.
        virtual double RolePersonalScale(RoleContribution role) const = 0;
    };
}

#endif // MOD_BRANDING_CORE_EFFECTS_EFFECTCONFIG_H
