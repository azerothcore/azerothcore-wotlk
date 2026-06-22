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
    // Outcome of a one-shot Etch attempt (#31) -- mapped to a player message by the command layer.
    enum class EtchResult : uint8_t
    {
        Success,
        Disabled,            // Branding.Item.Enable or Branding.Etch.Enable off
        NoWeapon,            // no equipped main-hand to etch
        AlreadyBranded,      // this item already carries a Brand (etched or crafted)
        NotEnrolled,         // active school not account-unlocked (no Knowledge -- can't express)
        InsufficientEssence, // not enough Essence held
    };

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
        bool EtchEnabled() const { return _enabled && _etchEnabled; }

        IItemBrandConfig const& Config() const { return _config; }

        uint32_t EssenceItemId() const { return _essenceItemId; }
        uint32_t EssenceCost() const { return _essenceCost; }

        // Load the player's equipped main-hand brand state into the cache on login.
        void LoadEquipped(Player* player);

        // Brand the equipped weapon with the player's active brand (step 0). Persists.
        bool BrandEquipped(Player* player, BrandId brand);

        // One-shot Etch (#31): brand the equipped weapon with the player's active school, rank-locked
        // (never upgradeable) and soulbound (BoP), consuming Essence. Validates + consumes only on
        // success; refuses (no consume) otherwise. See EtchResult.
        EtchResult EtchEquipped(Player* player);

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
        bool _etchEnabled = false;
        uint32_t _essenceItemId = 190002;
        uint32_t _essenceCost = 500;
        ItemBrandConfig _config;
        std::unordered_map<uint32_t, ItemBrandState> _items;   // keyed by item GUID counter
    };
}

#define sItemBrandingMgr Branding::ItemBrandingMgr::instance()

#endif // MOD_BRANDING_SRC_ITEMBRANDINGMGR_H
