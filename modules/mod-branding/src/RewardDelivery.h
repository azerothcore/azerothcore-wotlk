#ifndef MOD_BRANDING_SRC_REWARDDELIVERY_H
#define MOD_BRANDING_SRC_REWARDDELIVERY_H

#include <cstdint>
#include <string_view>

class Player;

namespace Branding
{
    enum class DeliveryResult : uint8_t
    {
        None = 0,       // nothing delivered (bad input)
        Inventory,      // added to bags
        Mailed          // bags full -> sent by mail
    };

    // §4 personal-loot delivery (reusable): give `count` of `itemId` to the player, preferring the
    // inventory and falling back to mail when bags are full. (A phase-based reward chest is the
    // design's primary path; this inventory+mail fallback is the realistic baseline.)
    DeliveryResult DeliverItem(Player* player, uint32_t itemId, uint32_t count,
        std::string_view subject, std::string_view body);
}

#endif // MOD_BRANDING_SRC_REWARDDELIVERY_H
