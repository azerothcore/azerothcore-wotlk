#ifndef MOD_BRANDING_SRC_DISCOVERYMGR_H
#define MOD_BRANDING_SRC_DISCOVERYMGR_H

#include "DiscoveryConfig.h"
#include <cstdint>

namespace Branding
{
    // Adapter for the discovery system (§8.2). Translates a player's current area into the bonus
    // discovery XP computed by the pure core. Idempotency is provided by the host: the core only
    // awards exploration XP on a FIRST visit, so the bonus layers on at exactly the right moment.
    class DiscoveryMgr
    {
    public:
        static DiscoveryMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Bonus discovery XP for first-exploring `areaId` at `playerLevel` (0 if disabled/unknown).
        uint32_t AreaDiscoveryBonus(uint8_t playerLevel, uint32_t areaId) const;

        // Discovery tier of an area's zone level (§8.3). For inspection.
        DiscoveryTier AreaTier(uint32_t areaId) const;

    private:
        DiscoveryMgr() = default;
        DiscoveryConfig _config;
    };
}

#define sDiscoveryMgr Branding::DiscoveryMgr::instance()

#endif // MOD_BRANDING_SRC_DISCOVERYMGR_H
