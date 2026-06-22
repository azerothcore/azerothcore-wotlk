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

    RewardTier BumpTier(RewardTier base, uint8_t bonus)
    {
        if (base == RewardTier::None || bonus == 0)
            return base;

        uint32_t const bumped = static_cast<uint32_t>(base) + bonus;
        uint32_t const capped = bumped < static_cast<uint32_t>(RewardTier::Gold)
            ? bumped : static_cast<uint32_t>(RewardTier::Gold);
        return static_cast<RewardTier>(capped);
    }

    uint32_t BaseBossCurrency(RewardTier tier)
    {
        switch (tier)
        {
            case RewardTier::Bronze: return 1000;
            case RewardTier::Silver: return 3000;
            case RewardTier::Gold:   return 8000;
            default:                 return 0;
        }
    }
}
