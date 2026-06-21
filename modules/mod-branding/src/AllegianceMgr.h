#ifndef MOD_BRANDING_SRC_ALLEGIANCEMGR_H
#define MOD_BRANDING_SRC_ALLEGIANCEMGR_H

#include "AllegianceConfig.h"
#include "branding/allegiance/Allegiance.h"
#include "ObjectGuid.h"
#include <unordered_map>

class Player;

namespace Branding
{
    // Adapter manager for soft allegiances (§12). Owns the per-character allegiance cache, persists
    // it to `character_allegiance`, and translates live state into the pure-core AllegianceEfficiency
    // call. No Player* is stored past a call -- the cache is keyed by ObjectGuid (project
    // long-lived-reference rule).
    class AllegianceMgr
    {
    public:
        static AllegianceMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Login/logout lifecycle.
        void LoadPlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // Current allegiance of a (cached) character; Allegiance::None if unset/not loaded.
        Allegiance Current(ObjectGuid guid) const;

        // Validates `id`, persists immediately, and updates the cache. Returns false (no change) if
        // the id is not a real allegiance. `lowGuid` is the character low GUID for the row key.
        bool Select(ObjectGuid guid, uint32_t lowGuid, uint32_t id);

        // Reward/efficiency multiplier for content aligned to `contentAlignment` (always >= 1.0).
        // Neutral (1.0) when disabled, the character is unloaded, or the allegiance does not match.
        double Efficiency(ObjectGuid guid, Allegiance contentAlignment) const;

    private:
        AllegianceMgr() = default;

        AllegianceConfig _config;
        std::unordered_map<ObjectGuid, Allegiance> _charAllegiance;
    };
}

#define sAllegianceMgr Branding::AllegianceMgr::instance()

#endif // MOD_BRANDING_SRC_ALLEGIANCEMGR_H
