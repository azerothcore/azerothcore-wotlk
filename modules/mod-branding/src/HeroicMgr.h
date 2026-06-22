#ifndef MOD_BRANDING_SRC_HEROICMGR_H
#define MOD_BRANDING_SRC_HEROICMGR_H

#include "HeroicConfig.h"
#include "branding/scaling/Heroic.h"
#include <cstdint>
#include <string>
#include <unordered_map>

class Map;
class Player;

namespace Branding
{
    // Adapter for the heroic overlay (§2.4). Resolves the per-instance heroic decision from the
    // SELECTED (group/player) difficulty -- not the map's resolved difficulty -- so classic/TBC
    // content with no native heroic row still drives the overlay (§2.4.1). Caches the resolved
    // HeroicContext per instance id (refreshed when a player enters), and feeds the pure core's
    // encounter muls / level target / tier bonus to the creature hooks. No raw Player*/Creature* is
    // retained (project long-lived-reference rule); the cache key is the instance id.
    class HeroicMgr
    {
    public:
        static HeroicMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Advisory mechanic-exception table (`branding_heroic_exception`, §2.4.6). Reload-safe.
        void LoadExceptions();

        // Snapshot/refresh the instance's heroic decision when a player enters (overwrites the cache,
        // so a reused instance id self-heals on the first entrant of the new instance).
        void OnPlayerEnterInstance(Map* map, Player* player);

        // Resolved context for a creature's instance: cache hit, else lazily resolved from the map's
        // current players. Returns an inert (Normal) context outside instances or when disabled.
        HeroicContext ContextFor(Map* map);

        // Hook helpers (wrap the pure core with the loaded config).
        bool LevelTargetFor(Map* map, uint8_t& outTarget);   // true when the overlay engages
        double HealthMulFor(Map* map);
        double DamageMulFor(Map* map);
        uint8_t TierBonusFor(Map* map);

        // Reward adjustments for a heroic/small-group instance run (§2.4.3 currency reduction +
        // §2.4.2 tier bump), for a future instanced boss-reward trigger to consume. Currency reduction
        // comes from the instance's body-count vs intended size; tier bonus from the heroic overlay.
        // Identity ({1.0, 0}) outside instances or when disabled. Does NOT touch the §9 invasion/event
        // reward stream (kept decoupled).
        struct RewardModifiers
        {
            double currencyMul = 1.0;
            uint8_t tierBonus = 0;
        };
        RewardModifiers RewardModifiersFor(Map* map);

        // Advisory recommended group size for a map/boss (0 = no advice). §2.4.6.
        uint8_t RecommendedMinBodies(uint32_t mapId, uint32_t bossEntry) const;
        std::string ExceptionNote(uint32_t mapId, uint32_t bossEntry) const;

    private:
        HeroicMgr() = default;

        static bool HasNativeHeroic(Map* map);
        static SelectedDifficulty ResolveSelected(Player* player, bool isRaid);
        HeroicContext Resolve(Map* map) const;

        static uint8_t InstancePlayerCount(Map* map);   // non-GM bodies present (the group size)
        static uint8_t InstanceContentSize(Map* map);    // the instance's intended size (0 = unknown)

        static uint64_t Key(uint32_t mapId, uint32_t bossEntry)
        {
            return (static_cast<uint64_t>(mapId) << 32) | bossEntry;
        }

        struct Advice
        {
            uint8_t minBodies = 0;
            std::string note;
        };

        HeroicConfig _config;
        std::unordered_map<uint32_t, HeroicContext> _byInstance;   // keyed by instance id
        std::unordered_map<uint64_t, Advice> _exceptions;          // keyed by (mapId<<32)|bossEntry
    };
}

#define sHeroicMgr Branding::HeroicMgr::instance()

#endif // MOD_BRANDING_SRC_HEROICMGR_H
