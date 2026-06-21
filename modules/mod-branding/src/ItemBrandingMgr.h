#ifndef MOD_BRANDING_SRC_ITEMBRANDINGMGR_H
#define MOD_BRANDING_SRC_ITEMBRANDINGMGR_H

#include "ItemBrandConfig.h"
#include "branding/effects/ItemBrand.h"
#include "ObjectGuid.h"
#include <cstdint>
#include <unordered_map>

class Player;

namespace Branding
{
    // Adapter for item branding (§7.9). Per-item brand state keyed by the item's GUID, persisted to
    // `item_branding`. Upgrades spend economy resources to raise the item's proc/behavior INTENSITY
    // (never flat stats). Anti-P2W: a traded/maxed item is inert unless the current account can
    // express its brand. (First cut: persist + upgrade + expose intensity; applying the intensity to
    // actual weapon procs is the deferred follow-up that lands with the effect/proc layer.)
    class ItemBrandingMgr
    {
    public:
        static ItemBrandingMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _enabled; }

        IItemBrandConfig const& Config() const { return _config; }

        // Load the player's equipped main-hand brand state into the cache on login.
        void LoadEquipped(Player* player);

        // Brand the equipped weapon with the player's active brand (step 0). Persists.
        bool BrandEquipped(Player* player, BrandId brand);

        // Spend `resources` to upgrade the equipped weapon's brand (ApplyItemUpgrade). Persists.
        // Returns the internal levels gained (0 if no branded weapon / nothing affordable).
        uint8_t UpgradeEquipped(Player* player, uint32_t resources);

        // Resolved (anti-P2W) effect intensity of the equipped weapon for `player`; 1.0 baseline.
        double EquippedIntensity(Player* player) const;

        // Fetch the equipped weapon's brand state for display; false if no branded weapon.
        bool EquippedState(Player* player, ItemBrandState& out) const;

    private:
        ItemBrandingMgr() = default;

        // Resolves the equipped main-hand item GUID counter, or 0 if none.
        uint32_t EquippedItemGuid(Player* player) const;
        void Save(uint32_t itemGuid, ItemBrandState const& state);

        bool _enabled = false;
        ItemBrandConfig _config;
        std::unordered_map<uint32_t, ItemBrandState> _items;   // keyed by item GUID counter
    };
}

#define sItemBrandingMgr Branding::ItemBrandingMgr::instance()

#endif // MOD_BRANDING_SRC_ITEMBRANDINGMGR_H
