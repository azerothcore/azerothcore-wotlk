#ifndef MOD_BRANDING_SRC_DISCOVERABLEMGR_H
#define MOD_BRANDING_SRC_DISCOVERABLEMGR_H

#include "DiscoveryConfig.h"
#include "branding/economy/Discoverable.h"
#include "ObjectGuid.h"
#include <cstdint>
#include <unordered_map>
#include <unordered_set>

class Player;

namespace Branding
{
    // §8.4 adapter for world-spawned profession discoverables. Loads the data-authored
    // gameobject->reward mapping (`branding_discovery_object`, world DB) and tracks per-character
    // dedupe (`character_branding_discovery`, characters DB). The reward decision itself is delegated
    // to the pure core (ResolveDiscoverable); this manager only owns the DB I/O and the dedupe set.
    class DiscoverableMgr
    {
    public:
        static DiscoverableMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Load the gameobject->reward mapping from the world DB. Called on startup / `.reload config`.
        void LoadDiscoverables();

        // Per-character dedupe set lifecycle (login/logout).
        void LoadPlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // Resolve the reward for interacting with `objectEntry`. Returns a non-granted result when the
        // object is unmapped, the player already discovered it, or the data is malformed. On a granted
        // result the discovery is recorded (in-memory + persisted) so re-interact yields nothing.
        ResolvedReward OnInteract(Player* player, uint32_t objectEntry);

    private:
        DiscoverableMgr() = default;

        bool HasDiscovered(ObjectGuid guid, uint32_t objectEntry) const;
        void RecordDiscovery(Player* player, uint32_t objectEntry);

        DiscoveryConfig _config;
        std::unordered_map<uint32_t, DiscoverableReward> _objects;              // objectEntry -> def
        std::unordered_map<ObjectGuid, std::unordered_set<uint32_t>> _seen;     // char -> discovered entries
    };
}

#define sDiscoverableMgr Branding::DiscoverableMgr::instance()

#endif // MOD_BRANDING_SRC_DISCOVERABLEMGR_H
