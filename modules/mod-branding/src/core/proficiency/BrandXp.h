#ifndef MOD_BRANDING_CORE_PROFICIENCY_BRANDXP_H
#define MOD_BRANDING_CORE_PROFICIENCY_BRANDXP_H

#include "Types.h"
#include "common/Clock.h"
#include "common/Config.h"

namespace Branding
{
    // Computes XP for an activity after all modifiers + diminishing returns (design §7.4).
    // Pure and read-only: does not mutate state. DR uses the decayed recent-window via the clock.
    uint32_t ComputeXpGain(XpActivity const& activity, ProficiencyState const& state,
        IBrandingConfig const& cfg, IClock const& clock);

    // Applies an activity: mutates state (totalXp + DR window) and returns the result.
    // Yields 0 XP if the account cannot earn proficiency in the activity's brand (§7.5 gate).
    // Pure given the injected clock/config (same inputs -> identical result).
    XpResult ApplyActivity(ProficiencyState& state, XpActivity const& activity,
        KnowledgeState const& knowledge, IBrandingConfig const& cfg, IClock const& clock);
}

#endif // MOD_BRANDING_CORE_PROFICIENCY_BRANDXP_H
