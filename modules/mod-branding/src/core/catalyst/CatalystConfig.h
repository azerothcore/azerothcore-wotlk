#ifndef MOD_BRANDING_CORE_CATALYST_CATALYSTCONFIG_H
#define MOD_BRANDING_CORE_CATALYST_CATALYSTCONFIG_H

#include <cstdint>

namespace Branding
{
    // Injected tunables for catalyst stacking diminishing returns (§7.9 / §9 catalyst).
    class ICatalystConfig
    {
    public:
        virtual ~ICatalystConfig() = default;

        // Upper bound on the raid catalyst multiplier (§7.9, default 2.0). The 1st specialist hits it.
        virtual double MaxRaidMul() const = 0;

        // Geometric decay of each successive same-role specialist's effectiveness (0,1).
        // rank 1 weight = 1.0, rank 2 = decay, rank 3 = decay^2, ... so 3rd+ is heavily reduced.
        virtual double StackDecay() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_CATALYST_CATALYSTCONFIG_H
