#include "Discoverable.h"

namespace Branding
{
    ResolvedReward ResolveDiscoverable(DiscoverableReward const& def, bool alreadyDiscovered)
    {
        ResolvedReward out;

        // Dedupe: an already-discovered object grants nothing on re-interact (§8.4 idempotency).
        if (alreadyDiscovered)
            return out;

        // Malformed data is a no-op rather than a malformed grant.
        if (def.rewardType == DiscoveryRewardType::None || def.payloadId == 0 || def.payloadAmount == 0)
            return out;

        out.granted = true;
        out.type = def.rewardType;
        out.payloadId = def.payloadId;
        out.amount = def.payloadAmount;
        return out;
    }

    bool RewardFitsTier(DiscoveryTier tier, DiscoveryRewardType rewardType)
    {
        switch (tier)
        {
            case DiscoveryTier::Common:
                return rewardType == DiscoveryRewardType::Recipe
                    || rewardType == DiscoveryRewardType::ProfessionXp;
            case DiscoveryTier::Uncommon:
                return rewardType == DiscoveryRewardType::ProfessionXp
                    || rewardType == DiscoveryRewardType::Reputation;
            case DiscoveryTier::Rare:
                return rewardType == DiscoveryRewardType::Recipe
                    || rewardType == DiscoveryRewardType::Reputation;
            case DiscoveryTier::Epic:
                return rewardType == DiscoveryRewardType::HiddenQuest;
            default:
                return false;
        }
    }
}
