#include "RewardDiversity.h"

namespace Branding
{
    namespace
    {
        int PopCount(uint32_t mask)
        {
            int count = 0;
            while (mask)
            {
                count += static_cast<int>(mask & 1u);
                mask >>= 1;
            }
            return count;
        }
    }

    bool CategorySetIsDiverse(EventType type, IContributionConfig const& cfg)
    {
        return PopCount(cfg.AllowedCategoryMask(type)) < static_cast<int>(RewardCategory::COUNT);
    }

    RewardCategory SelectRewardCategory(EventType type, IRng& rng, IContributionConfig const& cfg)
    {
        uint32_t const mask = cfg.AllowedCategoryMask(type);

        uint8_t allowed[static_cast<size_t>(RewardCategory::COUNT)];
        uint32_t n = 0;
        for (uint32_t i = 0; i < static_cast<uint32_t>(RewardCategory::COUNT); ++i)
            if (mask & (1u << i))
                allowed[n++] = static_cast<uint8_t>(i);

        if (n == 0)
            return RewardCategory::COUNT;       // misconfigured: no allowed category

        return static_cast<RewardCategory>(allowed[rng.Next(n)]);
    }
}
