#ifndef MOD_BRANDING_CORE_ECONOMY_DISCOVERABLE_H
#define MOD_BRANDING_CORE_ECONOMY_DISCOVERABLE_H

#include "branding/economy/Discovery.h"
#include <cstdint>

namespace Branding
{
    // §8.4 reward kinds a world-spawned discoverable can grant. The tier table (§8.3) maps each
    // zone-level tier to a reward flavour; this enum is the structured payload content is authored
    // against. Delivery of Recipe/Item is item-based (RewardDelivery); ProfessionXp/Reputation are
    // numeric grants the adapter routes to the host.
    enum class DiscoveryRewardType : uint8_t
    {
        None = 0,
        Recipe,         // grants a recipe/teaches item (Common basic / Rare advanced)
        ProfessionXp,   // grants profession skill XP
        Reputation,     // grants reputation with a faction
        HiddenQuest     // starts a hidden quest chain (Epic legendary)
    };

    // A single world-spawned discoverable's reward definition (§8.4). Authored as data
    // (branding_discovery_object) and mirrored here as a pure value the core resolves against.
    struct DiscoverableReward
    {
        uint32_t objectEntry = 0;               // gameobject template entry that triggers it
        DiscoveryTier tier = DiscoveryTier::Common;
        DiscoveryRewardType rewardType = DiscoveryRewardType::None;
        uint32_t payloadId = 0;                 // item/recipe entry, faction id, or quest id (by type)
        uint32_t payloadAmount = 0;             // item count, XP amount, or reputation amount
    };

    // What the adapter should actually grant after resolution. Empty (granted == false) when the
    // discoverable was already discovered (dedupe) or the definition is malformed.
    struct ResolvedReward
    {
        bool granted = false;
        DiscoveryRewardType type = DiscoveryRewardType::None;
        uint32_t payloadId = 0;
        uint32_t amount = 0;
    };

    // §8.4 reward resolution (pure): given a discoverable's definition and whether this player has
    // already discovered it, decide what to grant. Idempotent -- an already-discovered object yields
    // a non-granted result (the adapter then delivers nothing). Malformed definitions (no reward
    // type, zero payload, zero amount) also yield non-granted.
    ResolvedReward ResolveDiscoverable(DiscoverableReward const& def, bool alreadyDiscovered);

    // §8.3 consistency check (pure): does a discoverable's reward flavour fit its tier? Content
    // generation asserts this so bulk-authored data stays on-contract with the tier ruleset.
    //   Common   -> Recipe (basic) or ProfessionXp
    //   Uncommon -> ProfessionXp or Reputation (profession unlocks)
    //   Rare     -> Recipe (advanced) or Reputation
    //   Epic     -> HiddenQuest (legendary chains)
    bool RewardFitsTier(DiscoveryTier tier, DiscoveryRewardType rewardType);
}

#endif // MOD_BRANDING_CORE_ECONOMY_DISCOVERABLE_H
