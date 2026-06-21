#include "economy/Discoverable.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    DiscoverableReward MakeDef(DiscoveryTier tier, DiscoveryRewardType type, uint32_t payloadId,
        uint32_t amount)
    {
        DiscoverableReward def;
        def.objectEntry = 500000;
        def.tier = tier;
        def.rewardType = type;
        def.payloadId = payloadId;
        def.payloadAmount = amount;
        return def;
    }
}

// --- §8.4 reward resolution + dedupe ---

TEST(Discoverable, FirstDiscoveryGrantsTheReward)
{
    DiscoverableReward def = MakeDef(DiscoveryTier::Common, DiscoveryRewardType::Recipe, 4202, 1);
    ResolvedReward r = ResolveDiscoverable(def, /*alreadyDiscovered*/ false);
    EXPECT_TRUE(r.granted);
    EXPECT_EQ(r.type, DiscoveryRewardType::Recipe);
    EXPECT_EQ(r.payloadId, 4202u);
    EXPECT_EQ(r.amount, 1u);
}

TEST(Discoverable, RediscoveryGrantsNothing)
{
    DiscoverableReward def = MakeDef(DiscoveryTier::Common, DiscoveryRewardType::Recipe, 4202, 1);
    ResolvedReward r = ResolveDiscoverable(def, /*alreadyDiscovered*/ true);
    EXPECT_FALSE(r.granted);
    EXPECT_EQ(r.payloadId, 0u);
    EXPECT_EQ(r.amount, 0u);
}

TEST(Discoverable, MalformedDefinitionGrantsNothing)
{
    EXPECT_FALSE(ResolveDiscoverable(MakeDef(DiscoveryTier::Common, DiscoveryRewardType::None, 4202, 1), false).granted);
    EXPECT_FALSE(ResolveDiscoverable(MakeDef(DiscoveryTier::Common, DiscoveryRewardType::Recipe, 0, 1), false).granted);
    EXPECT_FALSE(ResolveDiscoverable(MakeDef(DiscoveryTier::Common, DiscoveryRewardType::Recipe, 4202, 0), false).granted);
}

// --- §8.3 tier/reward consistency contract ---

TEST(Discoverable, RewardFitsTierMatrix)
{
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Common, DiscoveryRewardType::Recipe));
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Common, DiscoveryRewardType::ProfessionXp));
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Uncommon, DiscoveryRewardType::ProfessionXp));
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Uncommon, DiscoveryRewardType::Reputation));
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Rare, DiscoveryRewardType::Recipe));
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Rare, DiscoveryRewardType::Reputation));
    EXPECT_TRUE(RewardFitsTier(DiscoveryTier::Epic, DiscoveryRewardType::HiddenQuest));
}

TEST(Discoverable, RewardRejectsOffContractCombos)
{
    EXPECT_FALSE(RewardFitsTier(DiscoveryTier::Common, DiscoveryRewardType::HiddenQuest));
    EXPECT_FALSE(RewardFitsTier(DiscoveryTier::Epic, DiscoveryRewardType::Recipe));
    EXPECT_FALSE(RewardFitsTier(DiscoveryTier::Common, DiscoveryRewardType::None));
}
