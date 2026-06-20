#ifndef MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTION_H
#define MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTION_H

#include "ContributionConfig.h"
#include "ContributionTypes.h"
#include "common/Clock.h"
#include <cstdint>

namespace Branding
{
    // §9.2: raw points for an action. Heal scales with magnitude within [1, HealMaxPoints].
    uint32_t ScoreAction(EventAction action, uint32_t magnitude, IContributionConfig const& cfg);

    // §9.3: scores an action through all per-character guardrails and returns the points credited.
    // Guardrails: anti-leech gate, daily per-event diminishing returns, hourly cap. Mutates the
    // pacing state (window rolls, DR counter, hourly accumulator). Pure given the injected clock.
    uint32_t ApplyEventAction(ParticipationState& state, EventType type, EventAction action,
        uint32_t magnitude, ActivitySignal const& signal, IContributionConfig const& cfg, IClock const& clock);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTION_H
