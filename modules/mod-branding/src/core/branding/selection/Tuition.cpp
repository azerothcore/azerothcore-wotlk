#include "Tuition.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    uint64_t TuitionCost(uint32_t recentSwitches, ISelectionConfig const& config)
    {
        uint64_t const base = config.TuitionBase();
        uint64_t const cap = config.TuitionCap();

        // A factor below 1.0 would make the curve decrease; clamp it so the contract (monotonic
        // non-decreasing, first switch == base) holds for any config.
        double const factor = std::max(1.0, config.TuitionFactor());

        // Already at/over the cap at the base, or no escalation: short-circuit to base (clamped).
        double cost = static_cast<double>(base) * std::pow(factor, static_cast<double>(recentSwitches));

        // Guard the double->uint64 conversion: pow can overflow to +inf for large exponents, and any
        // value past the cap (or past the uint64 range) clamps to the cap anyway.
        if (!(cost < static_cast<double>(cap)))
            return cap;

        uint64_t const rounded = static_cast<uint64_t>(std::llround(cost));
        return std::min(rounded, cap);
    }

    uint32_t DecaySwitchCount(uint32_t recentSwitches, uint64_t lastSwitchUnix, uint64_t nowUnix,
        ISelectionConfig const& config)
    {
        if (recentSwitches == 0 || lastSwitchUnix == 0)
            return 0;

        uint32_t const decayDays = config.SwitchDecayDays();
        if (decayDays == 0)
            return recentSwitches;          // decay disabled

        if (nowUnix < lastSwitchUnix)
            return recentSwitches;          // clock skew -- never decay on a backwards clock

        uint64_t const elapsed = nowUnix - lastSwitchUnix;
        uint64_t const decaySeconds = static_cast<uint64_t>(decayDays) * 86400ull;
        return elapsed >= decaySeconds ? 0u : recentSwitches;
    }
}
