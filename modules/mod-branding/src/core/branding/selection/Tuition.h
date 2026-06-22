#ifndef MOD_BRANDING_CORE_SELECTION_TUITION_H
#define MOD_BRANDING_CORE_SELECTION_TUITION_H

#include "Config.h"
#include <cstdint>

namespace Branding
{
    // §14.13.2 anti-flip-flop gold tuition: cost of switching the active school given how many
    // recent (un-decayed) switches the character has made.
    //
    //   cost = clamp(round(base * factor^recentSwitches), <= cap)
    //
    // Contract (GoogleTested): first switch (recentSwitches == 0) == base; monotonic non-decreasing in
    // recentSwitches; never exceeds cap; deterministic (no globals, no RNG, no wall-clock).
    uint64_t TuitionCost(uint32_t recentSwitches, ISelectionConfig const& config);

    // Decays a stored recent-switch counter to 0 once at least SwitchDecayDays have elapsed since the
    // last switch (§14.13.2). Pure helper so the curve and the decay rule are both test-injectable.
    //   lastSwitchUnix == 0 (never switched) -> 0.
    //   SwitchDecayDays == 0 (decay disabled) -> counter unchanged.
    //   nowUnix < lastSwitchUnix (clock skew) -> counter unchanged.
    uint32_t DecaySwitchCount(uint32_t recentSwitches, uint64_t lastSwitchUnix, uint64_t nowUnix,
        ISelectionConfig const& config);
}

#endif // MOD_BRANDING_CORE_SELECTION_TUITION_H
