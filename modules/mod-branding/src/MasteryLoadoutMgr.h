#ifndef MOD_BRANDING_SRC_MASTERYLOADOUTMGR_H
#define MOD_BRANDING_SRC_MASTERYLOADOUTMGR_H

#include "MasteryConfig.h"
#include "branding/mastery/MasteryActive.h"
#include "ObjectGuid.h"
#include <array>
#include <cstddef>
#include <unordered_map>

class Player;

namespace Branding
{
    // Adapter manager for the §14.11 per-talent-spec mastery loadout. The EARNED layer (per-school
    // level + account unlock) is owned by MasteryMgr and shared across specs; THIS manager owns the
    // ALLOCATED layer -- the per-(guid, spec slot) ActiveMasterySet of cells + their §14.10 point-buy
    // spends. It is intentionally separate from the item-brand LoadoutMgr (§7.9), a different system.
    //
    // The active loadout is a COLLECTION keyed by (school, tree), so multi-mastery needs no rebuild:
    // the cache, persistence, and validation all iterate the set. Switching dual-spec swaps the
    // cached set for free (a saved set, not a respec); only re-allocating points charges the token.
    // Cache is keyed by ObjectGuid (no raw Player* retained past a call -- project rule).
    class MasteryLoadoutMgr
    {
    public:
        static MasteryLoadoutMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }
        MasteryConfig const& Config() const { return _config; }

        // Login/logout lifecycle: load every spec slot's loadout, save the active slot, drop the cache.
        void LoadPlayer(Player* player);
        void SavePlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // §14.11: free swap of the cached active set when the player changes talent spec. No token,
        // no persistence write of points (the destination slot's saved set just becomes active).
        void OnSpecChanged(Player* player, uint8_t newSpec);

        // The currently-active (per active spec) loadout for a character (empty set if not loaded).
        ActiveMasterySet const& ActiveLoadout(ObjectGuid charGuid) const;

        // The loadout for a specific spec slot of a character (empty set if not loaded / out of range).
        ActiveMasterySet const& LoadoutForSpec(ObjectGuid charGuid, uint8_t spec) const;

        // §14.10/§14.11 re-allocate the active spec's loadout to `set`. Validates via the pure core
        // (dual-key per entry + cfg.MaxActive), and on success charges MasteryRespecCost(Reallocate)
        // and persists. Returns false (no change, no charge) if invalid or the player can't afford it.
        bool Reallocate(Player* player, ActiveMasterySet const& set);

    private:
        MasteryLoadoutMgr() = default;

        static constexpr size_t SpecSlots = 2;  // MAX_TALENT_SPECS on 3.3.5a
        using SpecLoadouts = std::array<ActiveMasterySet, SpecSlots>;

        void LoadCharacterLoadout(ObjectGuid guid, uint32_t lowGuid);
        void PersistSpec(uint32_t lowGuid, uint8_t spec, ActiveMasterySet const& set) const;

        // Validates `set` for the character/account dual key (account unlock x earned school level).
        bool IsValidFor(ObjectGuid charGuid, uint32_t accountId, ActiveMasterySet const& set) const;

        MasteryConfig _config;
        std::unordered_map<ObjectGuid, SpecLoadouts> _loadouts;  // per-character, per-spec
        std::unordered_map<ObjectGuid, uint8_t> _activeSpec;     // which slot is live now
        ActiveMasterySet _empty;                                 // returned when not loaded
    };
}

#define sMasteryLoadoutMgr Branding::MasteryLoadoutMgr::instance()

#endif // MOD_BRANDING_SRC_MASTERYLOADOUTMGR_H
