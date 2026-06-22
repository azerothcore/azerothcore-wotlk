#ifndef MOD_BRANDING_CORE_CONTRIBUTION_REWARDTIER_H
#define MOD_BRANDING_CORE_CONTRIBUTION_REWARDTIER_H

#include "ContributionConfig.h"
#include "ContributionTypes.h"
#include <cstdint>

namespace Branding
{
    // §9.4: total contribution points -> reward tier (thresholds bronze < silver < gold).
    RewardTier TierForContribution(uint32_t totalPoints, IContributionConfig const& cfg);

    // §2.4.2 heroic reward bump: advance a tier by `bonus` steps, capped at Gold. A `None` tier (no
    // contribution earned) stays None -- heroic difficulty bumps an earned reward, it never conjures
    // one from nothing.
    RewardTier BumpTier(RewardTier base, uint8_t bonus);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_REWARDTIER_H
