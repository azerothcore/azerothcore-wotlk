#ifndef MOD_BRANDING_CORE_CONTRIBUTION_REWARDTIER_H
#define MOD_BRANDING_CORE_CONTRIBUTION_REWARDTIER_H

#include "ContributionConfig.h"
#include "ContributionTypes.h"
#include <cstdint>

namespace Branding
{
    // §9.4: total contribution points -> reward tier (thresholds bronze < silver < gold).
    RewardTier TierForContribution(uint32_t totalPoints, IContributionConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_REWARDTIER_H
