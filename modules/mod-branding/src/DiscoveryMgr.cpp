#include "DiscoveryMgr.h"
#include "economy/Discovery.h"
#include "DBCStores.h"

namespace Branding
{
    DiscoveryMgr* DiscoveryMgr::instance()
    {
        static DiscoveryMgr mgr;
        return &mgr;
    }

    void DiscoveryMgr::LoadConfig()
    {
        _config.Load();
    }

    uint32_t DiscoveryMgr::AreaDiscoveryBonus(uint8_t playerLevel, uint32_t areaId) const
    {
        if (!_config.Enabled())
            return 0;

        AreaTableEntry const* area = sAreaTableStore.LookupEntry(areaId);
        if (!area || area->area_level <= 0)
            return 0;

        // Area-based discovery is treated as a Subzone; landmark/hidden objects are per-gameobject
        // discoverables (data, deferred). firstDiscovery is always true here -- see header note.
        return DiscoveryXp(playerLevel, static_cast<uint8_t>(area->area_level),
            DiscoveryType::Subzone, true, _config);
    }

    DiscoveryTier DiscoveryMgr::AreaTier(uint32_t areaId) const
    {
        AreaTableEntry const* area = sAreaTableStore.LookupEntry(areaId);
        uint8_t const level = area && area->area_level > 0 ? static_cast<uint8_t>(area->area_level) : 0;
        return TierForZoneLevel(level, _config);
    }
}
