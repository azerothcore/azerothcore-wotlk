#include "RewardTier.h"

namespace Branding
{
    RewardTier TierForContribution(uint32_t totalPoints, IContributionConfig const& cfg)
    {
        if (totalPoints >= cfg.GoldThreshold())
            return RewardTier::Gold;
        if (totalPoints >= cfg.SilverThreshold())
            return RewardTier::Silver;
        if (totalPoints >= cfg.BronzeThreshold())
            return RewardTier::Bronze;
        return RewardTier::None;
    }
}
