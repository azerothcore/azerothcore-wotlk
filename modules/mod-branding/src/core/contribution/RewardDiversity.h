#ifndef MOD_BRANDING_CORE_CONTRIBUTION_REWARDDIVERSITY_H
#define MOD_BRANDING_CORE_CONTRIBUTION_REWARDDIVERSITY_H

#include "ContributionConfig.h"
#include "ContributionTypes.h"
#include "common/Rng.h"

namespace Branding
{
    // §9.5 invariant: an EventType's allowed category set must exclude at least one category
    // (no single event type drops everything).
    bool CategorySetIsDiverse(EventType type, IContributionConfig const& cfg);

    // Picks one allowed reward category for the event, using injected RNG (deterministic per seed).
    RewardCategory SelectRewardCategory(EventType type, IRng& rng, IContributionConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_REWARDDIVERSITY_H
