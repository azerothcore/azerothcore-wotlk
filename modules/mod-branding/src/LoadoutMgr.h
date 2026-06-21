#ifndef MOD_BRANDING_SRC_LOADOUTMGR_H
#define MOD_BRANDING_SRC_LOADOUTMGR_H

#include "ItemBrandConfig.h"
#include "effects/ItemBrand.h"
#include "ObjectGuid.h"
#include <unordered_map>

class Player;

namespace Branding
{
    // Adapter manager for the player-selected proc loadout (§7.9): owns the per-character active
    // brand + proc archetype, loads it on login and saves it on change. Selection changes are
    // validated by the pure core (IsLoadoutValid) against the account's Brand Knowledge and the
    // character's proficiency level. Cache is keyed by ObjectGuid (no raw Player* retained).
    class LoadoutMgr
    {
    public:
        static LoadoutMgr* instance();

        void LoadConfig();
        ItemBrandConfig const& Config() const { return _config; }

        // Login/logout lifecycle.
        void LoadPlayer(Player* player);
        void SavePlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // Current cached loadout for a character (defaults if not loaded).
        BrandLoadout GetLoadout(ObjectGuid charGuid) const;

        // Set the active brand, keeping the current proc archetype. Validates the resulting loadout
        // and persists on success. Returns false (no change) if invalid for this account/character.
        bool SetActiveBrand(Player* player, BrandId brand);

        // Set the proc archetype for the current active brand. Validates + persists on success.
        bool SetArchetype(Player* player, uint8_t archetype);

    private:
        LoadoutMgr() = default;

        // Validates `loadout` for the given character/account against knowledge + proficiency.
        bool IsValidFor(ObjectGuid charGuid, uint32_t accountId, BrandLoadout const& loadout) const;
        void Persist(uint32_t lowGuid, BrandLoadout const& loadout) const;

        ItemBrandConfig _config;
        std::unordered_map<ObjectGuid, BrandLoadout> _loadouts;
    };
}

#define sLoadoutMgr Branding::LoadoutMgr::instance()

#endif // MOD_BRANDING_SRC_LOADOUTMGR_H
